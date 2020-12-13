Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD82D8D41
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406845AbgLMN2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 08:28:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgLMN16 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:27:58 -0500
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
Subject: [RFC PATCH 1/2] errseq: split the SEEN flag into two new flags
Date:   Sun, 13 Dec 2020 08:27:12 -0500
Message-Id: <20201213132713.66864-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201213132713.66864-1-jlayton@kernel.org>
References: <20201213132713.66864-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs's volatile mounts want to be able to sample an error for
their own purposes, without preventing a later opener from potentially
seeing the error.

The original reason for the SEEN flag was to make it so that we didn't
need to increment the counter if nothing had observed the latest value
and the error was the same. Eventually, a regression was reported in
the errseq_t conversion, and we fixed that by using the SEEN flag to
also mean that the error had been reported to userland at least once
somewhere.

Those are two different states, however. If we instead take a second
flag bit from the counter, we can track these two things separately,
and accomodate the overlayfs volatile mount use-case.

Add a new MUSTINC flag that indicates that the counter must be
incremented the next time an error is set, and rework the errseq
functions to set and clear that flag whenever the SEEN bit is set or
cleared.

Test only for the MUSTINC bit when deciding whether to increment the
counter and only for the SEEN bit when deciding what to return in
errseq_sample.

Add a new errseq_peek function to allow for the overlayfs use-case.
This just grabs the latest counter and sets the MUSTINC bit, leaving
the SEEN bit untouched.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/errseq.h |  2 ++
 lib/errseq.c           | 64 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..6d4b9bc629ac 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,8 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_peek(errseq_t *eseq);
+errseq_t errseq_sample_advance(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..5cc830f0361b 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -38,8 +38,11 @@
 /* This bit is used as a flag to indicate whether the value has been seen */
 #define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
 
+/* This bit indicates that value must be incremented even when error is same */
+#define ERRSEQ_MUSTINC		(1 << (ERRSEQ_SHIFT + 1))
+
 /* The lowest bit of the counter */
-#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
+#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 2))
 
 /**
  * errseq_set - set a errseq_t for later reporting
@@ -77,11 +80,11 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 	for (;;) {
 		errseq_t new;
 
-		/* Clear out error bits and set new error */
-		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
+		/* Clear out flag bits and set new error */
+		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN|ERRSEQ_MUSTINC)) | -err;
 
-		/* Only increment if someone has looked at it */
-		if (old & ERRSEQ_SEEN)
+		/* Only increment if we have to */
+		if (old & ERRSEQ_MUSTINC)
 			new += ERRSEQ_CTR_INC;
 
 		/* If there would be no change, then call it done */
@@ -122,14 +125,50 @@ EXPORT_SYMBOL(errseq_set);
 errseq_t errseq_sample(errseq_t *eseq)
 {
 	errseq_t old = READ_ONCE(*eseq);
+	errseq_t new = old;
 
-	/* If nobody has seen this error yet, then we can be the first. */
-	if (!(old & ERRSEQ_SEEN))
-		old = 0;
-	return old;
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the SEEN|MUSTINC bits. Once an error has been set, the value
+	 * will never go back to zero.
+	 */
+	if (old != 0) {
+		new |= ERRSEQ_SEEN|ERRSEQ_MUSTINC;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+		if (!(old & ERRSEQ_SEEN))
+			return 0;
+	}
+	return new;
 }
 EXPORT_SYMBOL(errseq_sample);
 
+/**
+ * errseq_peek - Grab current errseq_t value, but don't mark it SEEN
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * In some cases, we need to be able to sample the errseq_t, but we're not
+ * in a situation where we can report the value to userland. Use this
+ * function to do that. This ensures that later errors will be recorded,
+ * and that any current errors are reported at least once.
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
+		new |= ERRSEQ_MUSTINC;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return new;
+}
+EXPORT_SYMBOL(errseq_peek);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
@@ -143,7 +182,10 @@ EXPORT_SYMBOL(errseq_sample);
  */
 int errseq_check(errseq_t *eseq, errseq_t since)
 {
-	errseq_t cur = READ_ONCE(*eseq);
+	errseq_t cur = READ_ONCE(*eseq) & ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
+
+	/* Clear the flag bits for comparison */
+	since &= ~(ERRSEQ_MUSTINC|ERRSEQ_SEEN);
 
 	if (likely(cur == since))
 		return 0;
@@ -195,7 +237,7 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 		 * can advance "since" and return an error based on what we
 		 * have.
 		 */
-		new = old | ERRSEQ_SEEN;
+		new = old | ERRSEQ_SEEN | ERRSEQ_MUSTINC;
 		if (new != old)
 			cmpxchg(eseq, old, new);
 		*since = new;
-- 
2.29.2

