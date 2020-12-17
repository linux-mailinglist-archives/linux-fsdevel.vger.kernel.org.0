Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845E92DD38A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgLQPBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:01:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbgLQPBU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:01:20 -0500
From:   Jeff Layton <jlayton@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
Date:   Thu, 17 Dec 2020 10:00:37 -0500
Message-Id: <20201217150037.468787-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs's volatile mounts want to be able to sample an error for their
own purposes, without preventing a later opener from potentially seeing
the error.

The original reason for the ERRSEQ_SEEN flag was to make it so that we
didn't need to increment the counter if nothing had observed the latest
value and the error was the same. Eventually, a regression was reported
in the errseq_t conversion, and we fixed that by using the ERRSEQ_SEEN
flag to also mean that the error had been reported to userland at least
once somewhere.

Those are two different states, however. If we instead take a second
flag bit from the counter, we can track these two things separately, and
accomodate the overlayfs volatile mount use-case.

Rename the ERRSEQ_SEEN flag to ERRSEQ_OBSERVED and use that to indicate
that the counter must be incremented the next time an error is set.
Also, add a new ERRSEQ_REPORTED flag that indicates whether the current
error was returned to userland (and thus doesn't need to be reported on
newly open file descriptions).

Test only for the OBSERVED bit when deciding whether to increment the
counter and only for the REPORTED bit when deciding what to return in
errseq_sample.

Add a new errseq_peek function to allow for the overlayfs use-case.
This just grabs the latest counter and sets the OBSERVED bit, leaving the
REPORTED bit untouched.

errseq_check_and_advance must now handle a single special case where
it races against a "peek" of an as of yet unseen value. The do/while
loop looks scary, but shouldn't loop more than once.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/core-api/errseq.rst |  22 +++--
 include/linux/errseq.h            |   1 +
 lib/errseq.c                      | 139 ++++++++++++++++++++++--------
 3 files changed, 118 insertions(+), 44 deletions(-)

v3: rename SEEN/MUSTINC flags to REPORTED/OBSERVED

Hopefully the new flag names will make this a bit more clear. We could
also rename some of the functions if that helps too. We could consider
moving from errseq_sample/_check_and_advance to
errseq_observe/errseq_report?  I'm not sure that helps anything though.

I know that Vivek and Sargun are working on syncfs() for overlayfs, so
we probably don't want to merge this until that work is ready. I think
the errseq_peek call will need to be part of their solution for volatile
mounts, however, so I'm fine with merging this via the overlayfs tree,
once that work is complete.

diff --git a/Documentation/core-api/errseq.rst b/Documentation/core-api/errseq.rst
index ff332e272405..ce46ddcc1487 100644
--- a/Documentation/core-api/errseq.rst
+++ b/Documentation/core-api/errseq.rst
@@ -18,18 +18,22 @@ these functions can be called from any context.
 Note that there is a risk of collisions if new errors are being recorded
 frequently, since we have so few bits to use as a counter.
 
-To mitigate this, the bit between the error value and counter is used as
-a flag to tell whether the value has been sampled since a new value was
-recorded.  That allows us to avoid bumping the counter if no one has
-sampled it since the last time an error was recorded.
+To mitigate this, the bits between the error value and counter are used
+as flags to tell whether the value has been sampled since a new value
+was recorded, and whether the latest error has been seen by userland.
+That allows us to avoid bumping the counter if no one has sampled it
+since the last time an error was recorded, and also ensures that any
+recorded error will be seen at least once.
 
 Thus we end up with a value that looks something like this:
 
-+--------------------------------------+----+------------------------+
-| 31..13                               | 12 | 11..0                  |
-+--------------------------------------+----+------------------------+
-| counter                              | SF | errno                  |
-+--------------------------------------+----+------------------------+
++---------------------------------+----+----+------------------------+
+| 31..14                          | 13 | 12 | 11..0                  |
++---------------------------------+----+----+------------------------+
+| counter                         | OF | RF | errno                  |
++---------------------------------+----+----+------------------------+
+OF = ERRSEQ_OBSERVED flag
+RF = ERRSEQ_REPORTED flag
 
 The general idea is for "watchers" to sample an errseq_t value and keep
 it as a running cursor.  That value can later be used to tell whether
diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..7e3634269c95 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,7 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_peek(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..8fd6be134dcc 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -21,10 +21,14 @@
  * Note that there is a risk of collisions if new errors are being recorded
  * frequently, since we have so few bits to use as a counter.
  *
- * To mitigate this, one bit is used as a flag to tell whether the value has
- * been sampled since a new value was recorded. That allows us to avoid bumping
- * the counter if no one has sampled it since the last time an error was
- * recorded.
+ * To mitigate this, one bit is used as a flag to tell whether the value has been
+ * observed in some fashion. That allows us to avoid bumping the counter if no
+ * one has sampled it since the last time an error was recorded.
+ *
+ * A second flag bit is used to indicate whether the latest error that has been
+ * recorded has been reported to userland. If the REPORTED bit is not set when the
+ * file is opened, then we ensure that the opener will see the error by setting
+ * its sample to 0.
  *
  * A new errseq_t should always be zeroed out.  A errseq_t value of all zeroes
  * is the special (but common) case where there has never been an error. An all
@@ -35,11 +39,33 @@
 /* The low bits are designated for error code (max of MAX_ERRNO) */
 #define ERRSEQ_SHIFT		ilog2(MAX_ERRNO + 1)
 
-/* This bit is used as a flag to indicate whether the value has been seen */
-#define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
+/* Flag to indicate whether the value will be or has been reported */
+#define ERRSEQ_REPORTED		BIT(ERRSEQ_SHIFT)
+
+/* Flag to ndicate that error must be recorded */
+#define ERRSEQ_OBSERVED		BIT(ERRSEQ_SHIFT + 1)
 
 /* The lowest bit of the counter */
-#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
+#define ERRSEQ_CTR_INC		BIT(ERRSEQ_SHIFT + 2)
+
+/* Mask that just contains the counter bits */
+#define ERRSEQ_CTR_MASK		~(ERRSEQ_CTR_INC - 1)
+
+/* Mask that just contains flags */
+#define ERRSEQ_FLAG_MASK	(ERRSEQ_REPORTED|ERRSEQ_OBSERVED)
+
+/**
+ * errseq_same - return true if the errseq counters and values are the same
+ * @a: first errseq
+ * @b: second errseq
+ *
+ * Compare two errseqs and return true if they are the same, ignoring their
+ * flag bits.
+ */
+static inline bool errseq_same(errseq_t a, errseq_t b)
+{
+	return (a & ~ERRSEQ_FLAG_MASK) == (b & ~ERRSEQ_FLAG_MASK);
+}
 
 /**
  * errseq_set - set a errseq_t for later reporting
@@ -53,7 +79,7 @@
  *
  * Return: The previous value, primarily for debugging purposes. The
  * return value should not be used as a previously sampled value in later
- * calls as it will not have the SEEN flag set.
+ * calls as it will not have the OBSERVED flag set.
  */
 errseq_t errseq_set(errseq_t *eseq, int err)
 {
@@ -77,11 +103,11 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 	for (;;) {
 		errseq_t new;
 
-		/* Clear out error bits and set new error */
-		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
+		/* Clear out flag bits and old errors, and set new error */
+		new = (old & ERRSEQ_CTR_MASK) | -err;
 
-		/* Only increment if someone has looked at it */
-		if (old & ERRSEQ_SEEN)
+		/* Only increment if we have to */
+		if (old & ERRSEQ_OBSERVED)
 			new += ERRSEQ_CTR_INC;
 
 		/* If there would be no change, then call it done */
@@ -108,11 +134,38 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 EXPORT_SYMBOL(errseq_set);
 
 /**
- * errseq_sample() - Grab current errseq_t value.
+ * errseq_peek - Grab current errseq_t value
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * In some cases, we need to be able to sample the errseq_t, but we're not
+ * in a situation where we can report the value to userland. Use this
+ * function to do that. This ensures that later errors will be recorded,
+ * and that any current errors are reported at least once when it is
+ * next sampled.
+ *
+ * Context: Any context.
+ * Return: The current errseq value.
+ */
+errseq_t errseq_peek(errseq_t *eseq)
+{
+	errseq_t old = READ_ONCE(*eseq);
+	errseq_t new = old;
+
+	if (old != 0) {
+		new |= ERRSEQ_OBSERVED;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return new;
+}
+EXPORT_SYMBOL(errseq_peek);
+
+/**
+ * errseq_sample() - Sample errseq_t value, and ensure that unseen errors are reported
  * @eseq: Pointer to errseq_t to be sampled.
  *
  * This function allows callers to initialise their errseq_t variable.
- * If the error has been "seen", new callers will not see an old error.
+ * If the latest error has been "seen", new callers will not see an old error.
  * If there is an unseen error in @eseq, the caller of this function will
  * see it the next time it checks for an error.
  *
@@ -121,12 +174,11 @@ EXPORT_SYMBOL(errseq_set);
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
-	errseq_t old = READ_ONCE(*eseq);
+	errseq_t new = errseq_peek(eseq);
 
-	/* If nobody has seen this error yet, then we can be the first. */
-	if (!(old & ERRSEQ_SEEN))
-		old = 0;
-	return old;
+	if (!(new & ERRSEQ_REPORTED))
+		return 0;
+	return new;
 }
 EXPORT_SYMBOL(errseq_sample);
 
@@ -145,7 +197,7 @@ int errseq_check(errseq_t *eseq, errseq_t since)
 {
 	errseq_t cur = READ_ONCE(*eseq);
 
-	if (likely(cur == since))
+	if (errseq_same(cur, since))
 		return 0;
 	return -(cur & MAX_ERRNO);
 }
@@ -159,9 +211,9 @@ EXPORT_SYMBOL(errseq_check);
  * Grab the eseq value, and see whether it matches the value that @since
  * points to. If it does, then just return 0.
  *
- * If it doesn't, then the value has changed. Set the "seen" flag, and try to
- * swap it into place as the new eseq value. Then, set that value as the new
- * "since" value, and return whatever the error portion is set to.
+ * If it doesn't, then the value has changed. Set the REPORTED+OBSERVED flags, and
+ * try to swap it into place as the new eseq value. Then, set that value as
+ * the new "since" value, and return whatever the error portion is set to.
  *
  * Note that no locking is provided here for concurrent updates to the "since"
  * value. The caller must provide that if necessary. Because of this, callers
@@ -183,21 +235,38 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 	 */
 	old = READ_ONCE(*eseq);
 	if (old != *since) {
+		int loops = 0;
+
 		/*
-		 * Set the flag and try to swap it into place if it has
-		 * changed.
+		 * Set the flag and try to swap it into place if it has changed.
+		 *
+		 * If the swap doesn't occur, then it has either been updated by a
+		 * writer who is setting a new error and/or bumping the counter, or
+		 * another reader who is setting flags.
 		 *
-		 * We don't care about the outcome of the swap here. If the
-		 * swap doesn't occur, then it has either been updated by a
-		 * writer who is altering the value in some way (updating
-		 * counter or resetting the error), or another reader who is
-		 * just setting the "seen" flag. Either outcome is OK, and we
-		 * can advance "since" and return an error based on what we
-		 * have.
+		 * We only need to retry in one case -- if we raced with another
+		 * reader that is only setting the OBSERVED flag. We need the
+		 * current value to have the REPORTED bit set if the other fields
+		 * didn't change, or we might report the same error on newly opened
+		 * files.
 		 */
-		new = old | ERRSEQ_SEEN;
-		if (new != old)
-			cmpxchg(eseq, old, new);
+		do {
+			if (unlikely(loops >= 2)) {
+				/*
+				 * This should never loop more than once, as any
+				 * change not involving the REPORTED bit would also
+				 * involve non-flag bits. WARN and just go with
+				 * what we have in that case.
+				 */
+				WARN_ON_ONCE(true);
+				break;
+			}
+			loops++;
+			new = old | ERRSEQ_REPORTED | ERRSEQ_OBSERVED;
+			if (new == old)
+				break;
+			old = cmpxchg(eseq, old, new);
+		} while (old == (new & ~ERRSEQ_REPORTED));
 		*since = new;
 		err = -(new & MAX_ERRNO);
 	}
-- 
2.29.2

