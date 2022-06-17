Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65054F191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380496AbiFQHLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 03:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380475AbiFQHKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:10:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715164BE7;
        Fri, 17 Jun 2022 00:10:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k7so3170322plg.7;
        Fri, 17 Jun 2022 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=fjXHYprjUJo3vptR8ZDmjzvgqyxJ0T7Bx162ug34nW0=;
        b=nebhPsQemubikv970ke5FPvsr+FFLB14J5Cvt4co7fvxyX9eIHVZcxAwsj27B8vbeD
         EzUl+ur+6U1UAdN3FpAPX6lm8z0zwBaWu4zjsKbZRZjRG2VeQ/Ej5r6b+FewCZr9XfiQ
         hb459SsEdtH3IwD3MrSLQWXrUGN+RZUE2gBPcuHYvygLS9pWueFLuuHo/JQkUYFiBE13
         MRUK2Vo1uXbLLrvYT3pHlB2Ey4s6hM6tDeiTH79vbrr2Kokgib3iD37i7ZTR4Ila+m8M
         Z6ykPWZRZgp/6F0hb5qfjUcEvQuys8X2LAwEJ/Tyt6R9S3znbdXKGZw8kgXtWWov+JRV
         qKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=fjXHYprjUJo3vptR8ZDmjzvgqyxJ0T7Bx162ug34nW0=;
        b=GeOwOAt28ZVJAHeKiPJAhTicegMLBDasTyM23ssN5iLj6inglnj5kSbw4Xi0Qk6nh7
         dCQdRuY2KIWLKM2JtiZAs9MXH0T19e16maQz+umGsdn4goJ7OCS9mCAhyL9YuZ/CGX/B
         GaQtZ9gCFhFj+HDzo++mqAn0KNRf4M8uhsk41lSL4qRHIA2cFAYHrfsut3+yv10psQTQ
         lo1j5mnKWQpB8sWKiiOQTcnmSwxflpxTTaoIpFzmKbFYHnU1QPx18dAIOQ1ZNvWFcAB+
         EYbaYnGnv5IRGfFqzYvoZdTyLsA83Ihi3mFIsWwBalCSQ0WazzxG1ADz0hmExR35MRdk
         6bhQ==
X-Gm-Message-State: AJIora99zo3s1U77KKyicyZ7+5y8g9ACe30NOsJ52f5oUT6rn+AOTWPH
        qvjuwJ+fAA19+ZaKqwJhXJk=
X-Google-Smtp-Source: AGRyM1tKAIfzvWfya3uBEsJ7RFHiplx6hC6zYLEtHa/EFYUnhpOnth6Ux1PTTtcqwUkxSTxzvxZYJg==
X-Received: by 2002:a17:902:a609:b0:169:a8b:7c3c with SMTP id u9-20020a170902a60900b001690a8b7c3cmr5316311plq.67.1655449851635;
        Fri, 17 Jun 2022 00:10:51 -0700 (PDT)
Received: from localhost.localdomain ([219.91.170.210])
        by smtp.googlemail.com with ESMTPSA id d6-20020a170902654600b00163c0a1f718sm2770025pln.303.2022.06.17.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:10:51 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v5 1/1] Allow non-extending parallel direct writes on the same file.
Date:   Fri, 17 Jun 2022 12:40:27 +0530
Message-Id: <20220617071027.6569-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220617071027.6569-1-dharamhans87@gmail.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
Organization: DDN STORAGE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In general, as of now, in FUSE, direct writes on the same file are
serialized over inode lock i.e we hold inode lock for the full duration
of the write request. I could not find in fuse code and git history
a comment which clearly explains why this exclusive lock is taken
for direct writes.  Following might be the reasons for acquiring
an exclusive lock but not be limited to
1) Our guess is some USER space fuse implementations might be relying
   on this lock for seralization.
2) The lock protects against file read/write size races.
3) Ruling out any issues arising from partial write failures.

This patch relaxes the exclusive lock for direct non-extending writes
only. File size extending writes might not need the lock either,
but we are not entirely sure if there is a risk to introduce any
kind of regression. Furthermore, benchmarking with fio does not
show a difference between patch versions that take on file size
extension a) an exclusive lock and b) a shared lock.

A possible example of an issue with i_size extending writes are write
error cases. Some writes might succeed and others might fail for
file system internal reasons - for example ENOSPACE. With parallel
file size extending writes it _might_ be difficult to revert the action
of the failing write, especially to restore the right i_size.

With these changes, we allow non-extending parallel direct writes
on the same file with the help of a flag called
FOPEN_PARALLEL_DIRECT_WRITES. If this flag is set on the file (flag is
passed from libfuse to fuse kernel as part of file open/create),
we do not take exclusive lock anymore, but instead use a shared lock
that allows non-extending writes to run in parallel.
FUSE implementations which rely on this inode lock for serialisation
can continue to do so and serialized direct writes are still the
default.  Implementations that do not do write serialization need to
be updated and need to set the FOPEN_PARALLEL_DIRECT_WRITES flag in
their file open/create reply.

On patch review there were concerns that network file systems (or
vfs multiple mounts of the same file system) might have issues with
parallel writes. We believe this is not the case, as this is just a
local lock, which network file systems could not rely on anyway.
I.e. this lock is just for local consistency.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 37eebfb90500..b3a5706f301d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1565,14 +1565,47 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
+static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
+					       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
+	bool exclusive_lock =
+		!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
+		iocb->ki_flags & IOCB_APPEND ||
+		fuse_direct_write_extending_i_size(iocb, from);
+
+	/*
+	 * Take exclusive lock if
+	 * - Parallel direct writes are disabled - a user space decision
+	 * - Parallel direct writes are enabled and i_size is being extended.
+	 *   This might not be needed at all, but needs further investigation.
+	 */
+	if (exclusive_lock)
+		inode_lock(inode);
+	else {
+		inode_lock_shared(inode);
+
+		/* A race with truncate might have come up as the decision for
+		 * the lock type was done without holding the lock, check again.
+		 */
+		if (fuse_direct_write_extending_i_size(iocb, from)) {
+			inode_unlock_shared(inode);
+			inode_lock(inode);
+			exclusive_lock = true;
+		}
+	}
 
-	/* Don't allow parallel writes to the same file */
-	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
@@ -1583,7 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
-	inode_unlock(inode);
+	if (exclusive_lock)
+		inode_unlock(inode);
+	else
+		inode_unlock_shared(inode);
 
 	return res;
 }
@@ -2925,6 +2961,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iov_iter_rw(iter) == WRITE) {
 		fuse_write_update_attr(inode, pos, ret);
+		/* For extending writes we already hold exclusive lock */
 		if (ret < 0 && offset + count > i_size)
 			fuse_do_truncate(file);
 	}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index a28dd60078ff..bbb1246cae19 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -301,6 +301,7 @@ struct fuse_file_lock {
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -308,6 +309,7 @@ struct fuse_file_lock {
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 
 /**
  * INIT request/reply flags
-- 
2.17.1

