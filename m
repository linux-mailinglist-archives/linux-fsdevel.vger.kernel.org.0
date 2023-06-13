Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28772E29E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbjFMMP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjFMMP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB2E7D;
        Tue, 13 Jun 2023 05:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE8163576;
        Tue, 13 Jun 2023 12:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB3BC4339C;
        Tue, 13 Jun 2023 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686658524;
        bh=u87nLaY8CnHIf6lGPmCaMeaMMPHADO8Fwc25C1lXyNI=;
        h=From:To:Cc:Subject:Date:From;
        b=otNZv5jG2XnneBVDhTwGf5eYQw63jyqJmJKda6cx2mOJeeWSjjpGD5bDDM/UWCJeY
         qyEsS0cn0QaRG+oKxHxBw16uUwDTBejxpt/coODQCbRTDWRrWTPRiLbaOJEu5CtRNh
         K+51rxtQY19QsheB8aE1wDuQ1uzvDoup7wV8Ix2xHxKdYZPODGIxdqPY96MlBMLuYr
         dIZSZ2BRcpKOJ0dg4koIYpI1wAVmHuuvxm5Psxma/su+IGsRtR/RgghDAO0PNIEYB6
         6meiHSglzzY6fRxU50VBsbgbEogiiiI+6DUsdQN7JNOoq+7a9836UTh4frcHFy/xuQ
         jwRTSvSYxQKXQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     bcodding@redhat.com, Chris Perl <cperl@janestreet.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] errseq_t: split the ERRSEQ_SEEN flag into two
Date:   Tue, 13 Jun 2023 08:15:20 -0400
Message-Id: <20230613121521.146865-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFS wants to use the errseq_t mechanism to detect errors that occur
during a write, but for that use-case we want to ignore anything that
happened before the sample point.

This points out a problem with the current errseq_t implementation. The
SEEN flag is overloaded:

- errseq_set uses it to tell when it can skip incrementing the value
- errseq_sample uses it to tell when there are unseen errors

When sampling for the NFS write usecase, we need to set the former
without setting the latter.

Carve a new flag bit out of the counter as an ERRSEQ_MUST_INC flag, and
have errseq_set check for that instead of ERRSEQ_SEEN. Add a new
errseq_sample_new function that will set this bit, and
filemap_sample_new_wb_err wrapper that NFS can call from its write
codepath.

This reduces the max size of the errseq_t counter from 512k to 256k, but
I believe that's an acceptable tradeoff here, as it further clarifies
the meaning of the flags.

Reported-by: Chris Perl <cperl@janestreet.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/file.c           |  2 +-
 include/linux/errseq.h  | 14 ++++++++++
 include/linux/pagemap.h | 18 +++++++++++-
 lib/errseq.c            | 62 +++++++++++++++++++++++++++++++----------
 4 files changed, 79 insertions(+), 17 deletions(-)

This patch fixes the issue where an unseen writeback error prior to the
file being opened is reported on write(). It does _not_ make any
material difference to Chris' testcase however, because NFS will still
report the error on close(), so the second "tee" call will still fail
due to the writeback error.

To _really_ fix that testcase, I think we'd need both this patch and to
make NFS stop reporting writeback errors at close() (which is something
problematic and not required by POSIX).

Thoughts?

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 7d21b4ca2ec5..71ab5a396b5d 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -643,7 +643,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	nfs_clear_invalid_mapping(file->f_mapping);
 
-	since = filemap_sample_wb_err(file->f_mapping);
+	since = filemap_sample_new_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..2403d2f390aa 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -7,8 +7,22 @@
 
 typedef u32	errseq_t;
 
+/**
+ * errseq_fetch - Grab the current errseq_t value
+ * @eseq: Pointer to errseq_t to peek
+ *
+ * Grab the current errseq_t value and return it. This value is OK
+ * to use as a "since" value later, as long as you don't care about
+ * unseen errors that happened before this point.
+ */
+static inline errseq_t errseq_fetch(errseq_t *eseq)
+{
+	return READ_ONCE(*eseq);
+}
+
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_sample_new(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..dbdf00a829fc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -102,13 +102,29 @@ static inline int filemap_check_wb_err(struct address_space *mapping,
  * @mapping: mapping to be sampled
  *
  * Writeback errors are always reported relative to a particular sample point
- * in the past. This function provides those sample points.
+ * in the past. This function provides those sample points. In the event that
+ * there are unseen errors at the time of the sample, they will be reported
+ * during the next check.
  */
 static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 {
 	return errseq_sample(&mapping->wb_err);
 }
 
+/**
+ * filemap_peek_wb_err - peek at the current errseq_t to test for later errors
+ * @mapping: mapping to peek
+ *
+ * Writeback errors are always reported relative to a particular sample point
+ * in the past. This function provides those such sample points. If there are
+ * unseen errors present at the time of the sample, then they will be ignored
+ * in later checks.
+ */
+static inline errseq_t filemap_sample_new_wb_err(struct address_space *mapping)
+{
+	return errseq_sample_new(&mapping->wb_err);
+}
+
 /**
  * file_sample_sb_err - sample the current errseq_t to test for later errors
  * @file: file pointer to be sampled
diff --git a/lib/errseq.c b/lib/errseq.c
index 93e9b94358dc..ae28fa13f9c1 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -36,11 +36,17 @@
 /* The low bits are designated for error code (max of MAX_ERRNO) */
 #define ERRSEQ_SHIFT		ilog2(MAX_ERRNO + 1)
 
-/* This bit is used as a flag to indicate whether the value has been seen */
+/* Error has been reported */
 #define ERRSEQ_SEEN		(1 << ERRSEQ_SHIFT)
 
+/* Must increment the counter on the next recorded error */
+#define ERRSEQ_MUST_INC		(1 << (ERRSEQ_SHIFT + 1))
+
 /* The lowest bit of the counter */
-#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 1))
+#define ERRSEQ_CTR_INC		(1 << (ERRSEQ_SHIFT + 2))
+
+/* Both of the flag bits */
+#define ERRSEQ_ALL_FLAGS	(ERRSEQ_SEEN|ERRSEQ_MUST_INC)
 
 /**
  * errseq_set - set a errseq_t for later reporting
@@ -54,7 +60,7 @@
  *
  * Return: The previous value, primarily for debugging purposes. The
  * return value should not be used as a previously sampled value in later
- * calls as it will not have the SEEN flag set.
+ * calls as it will not have the MUST_INC flag set.
  */
 errseq_t errseq_set(errseq_t *eseq, int err)
 {
@@ -69,7 +75,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 	 * also don't accept zero here as that would effectively clear a
 	 * previous error.
 	 */
-	old = READ_ONCE(*eseq);
+	old = errseq_fetch(eseq);
 
 	if (WARN(unlikely(err == 0 || (unsigned int)-err > MAX_ERRNO),
 				"err = %d\n", err))
@@ -79,10 +85,10 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 		errseq_t new;
 
 		/* Clear out error bits and set new error */
-		new = (old & ~(MAX_ERRNO|ERRSEQ_SEEN)) | -err;
+		new = (old & ~(MAX_ERRNO|ERRSEQ_ALL_FLAGS)) | -err;
 
-		/* Only increment if someone has looked at it */
-		if (old & ERRSEQ_SEEN)
+		/* Only increment if marked for it */
+		if (old & ERRSEQ_MUST_INC)
 			new += ERRSEQ_CTR_INC;
 
 		/* If there would be no change, then call it done */
@@ -122,7 +128,7 @@ EXPORT_SYMBOL(errseq_set);
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
-	errseq_t old = READ_ONCE(*eseq);
+	errseq_t old = errseq_fetch(eseq);
 
 	/* If nobody has seen this error yet, then we can be the first. */
 	if (!(old & ERRSEQ_SEEN))
@@ -131,6 +137,33 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+/**
+ * errseq_sample_new() - Sample the errseq_t, ignoring earlier errors
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * This function allows callers to initialise their errseq_t variable.
+ * Any errors that occurred before this point will not be reported if
+ * this value is later used as a "since" value.
+ */
+errseq_t errseq_sample_new(errseq_t *eseq)
+{
+	errseq_t old = errseq_fetch(eseq);
+	errseq_t new = old;
+
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the MUST_INC bit. Once an error has been set, the value
+	 * will never go back to zero.
+	 */
+	if (old != 0) {
+		new |= ERRSEQ_MUST_INC;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return new;
+}
+EXPORT_SYMBOL(errseq_sample_new);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
@@ -144,9 +177,9 @@ EXPORT_SYMBOL(errseq_sample);
  */
 int errseq_check(errseq_t *eseq, errseq_t since)
 {
-	errseq_t cur = READ_ONCE(*eseq);
+	errseq_t cur = errseq_fetch(eseq) & ~ERRSEQ_ALL_FLAGS;
 
-	if (likely(cur == since))
+	if (likely(cur == (since & ~ERRSEQ_ALL_FLAGS)))
 		return 0;
 	return -(cur & MAX_ERRNO);
 }
@@ -182,7 +215,7 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 	 * so that the common case of no error is handled without needing
 	 * to take the lock that protects the "since" value.
 	 */
-	old = READ_ONCE(*eseq);
+	old = errseq_fetch(eseq);
 	if (old != *since) {
 		/*
 		 * Set the flag and try to swap it into place if it has
@@ -192,11 +225,10 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
 		 * swap doesn't occur, then it has either been updated by a
 		 * writer who is altering the value in some way (updating
 		 * counter or resetting the error), or another reader who is
-		 * just setting the "seen" flag. Either outcome is OK, and we
-		 * can advance "since" and return an error based on what we
-		 * have.
+		 * just setting flags. Either outcome is OK, and we can
+		 * advance "since" and return an error based on what we have.
 		 */
-		new = old | ERRSEQ_SEEN;
+		new = old | ERRSEQ_ALL_FLAGS;
 		if (new != old)
 			cmpxchg(eseq, old, new);
 		*since = new;
-- 
2.40.1

