Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF953DAAD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbiFEHWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350737AbiFEHWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 03:22:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B40E2B248;
        Sun,  5 Jun 2022 00:22:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b5so9864714plx.10;
        Sun, 05 Jun 2022 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=XfDlIBErzMQQGxMeHC3myQUwfB57qWMbRoZlEF59g3g=;
        b=MRTHb1lo6PIkG8XWrPJFMJwL+ezQtRTYrzRSYCPtlfoudyZqnOPgNzWLWPv/EyRRhS
         PzjHIfdlxTFXOOCxc8wen31m6eTJXwgvlGq3vCWWBJOhK6QcZhwqs6Ucps4VaGekgJFZ
         szoe3Kf3TjGyZWKWjebcM7ihwLrjBeJECOtF3PZG/60genSCpckFbDRp7HsWlPOVemif
         EO4h3eSdbEOFq5i0KEE5HQFuiSjXnCQmkJVUQb6uKK5XIRGO+S+O7Go89MEudBkG4hPX
         PpaCK4Ryfloq+YWrjb1xMd3KGtEJNLX5Kym2cXzo8fJzK1B7tQuEuvwztjYM3LcLy9l/
         jcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=XfDlIBErzMQQGxMeHC3myQUwfB57qWMbRoZlEF59g3g=;
        b=eIX5nC+ijy5NW7Pwdm132CXZF+ubq82/QNqJDwvHNr2zuhEJrMBrpLiheil3UOxkZr
         IoeUwBK4AspTAXD8SiZDko6uPLrPasEeegQbMArRvdx3ixIr/LBCdAOvnrR1IJT+XWpv
         fiKUTcCfbYuqVaxwha4Zi51vmsbLfkMNEP8+P/FDbEFOjgREqT1f93EfvPVzylNOBv1I
         jraxPL1aRVfVFTPKX4COOYhIM9S/Qhzxs+7yyqkpBYp9vE71wn0gPdf2Lx4wHEkzjBDr
         t44i+9nisaiXYVZHEcpbBZpgkqwE8x7dJOTR84+J9zUCW/E5xoA3JrVzfkfSt+Laa6yu
         cPnQ==
X-Gm-Message-State: AOAM533NTZ+EIdHQU4e2KB9PkXLXKvKLizk2BpESHxnugnm4LXfDd1Ul
        ONZBaiamWxZ33CS4mRYlBVs=
X-Google-Smtp-Source: ABdhPJzvQd/Emt4PjW7r1woOgXWwv9sG5K7Y2cQVZjJTPAbsABL37F+2DFnsRdBQ0dZtjtrjoF8VNw==
X-Received: by 2002:a17:90b:4d0a:b0:1e2:c0b4:8bb8 with SMTP id mw10-20020a17090b4d0a00b001e2c0b48bb8mr19987172pjb.94.1654413742488;
        Sun, 05 Jun 2022 00:22:22 -0700 (PDT)
Received: from localhost.localdomain ([219.91.178.135])
        by smtp.googlemail.com with ESMTPSA id e3-20020a170902e0c300b001663cf001besm6288046pla.174.2022.06.05.00.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 00:22:22 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v4 1/1] Allow non-extending parallel direct writes on the same file.
Date:   Sun,  5 Jun 2022 12:52:00 +0530
Message-Id: <20220605072201.9237-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220605072201.9237-1-dharamhans87@gmail.com>
References: <20220605072201.9237-1-dharamhans87@gmail.com>
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

From: Dharmendra Singh <dsingh@ddn.com>

In general, as of now, in FUSE, direct writes on the same file are
serialized over inode lock i.e we hold inode lock for the full duration
of the write request. I could not found in fuse code a comment which
clearly explains why this exclusive lock is taken for direct writes.

Following might be the reasons for acquiring exclusive lock but not
limited to
1) Our guess is some USER space fuse implementations might be relying
   on this lock for seralization.
2) This lock protects for the issues arising due to file size
   assumptions.
3) Ruling out any issues arising due to multiple writes where some 
   writes succeeded and some failed.

This patch relaxes this exclusive lock for non-extending direct writes.

With these changes, we allows non-extending parallel direct writes
on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
If this flag is set on the file (flag is passed from libfuse to fuse
kernel as part of file open/create), we do not take exclusive lock
instead use shared lock so that all non-extending writes can run in 
parallel.

Best practise would be to enable parallel direct writes of all kinds
including extending writes as well but we see some issues such as
1) When one write completes on one server and other fails on another
server, how we should truncate(if needed) the file if underlying file 
system does not support holes (For file systems which supports holes,
there might be a possibility of enabling parallel writes for all cases).

FUSE implementations which rely on this inode lock for serialisation
can continue to do so and this is default behaviour i.e no parallel
direct writes.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c            | 46 ++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..72524612bd5c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,14 +1541,50 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
+static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
+					       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return (iocb->ki_flags & IOCB_APPEND ||
+		iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode));
+}
+
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
+	bool exclusive_lock = !(ff->open_flags & FOPEN_PARALLEL_WRITES ||
+			       fuse_direct_write_extending_i_size(iocb, from));
+
+	/*
+	 * Take exclusive lock if
+	 * - parallel writes are disabled.
+	 * - parallel writes are enabled and i_size is being extended
+	 * Take shared lock if
+	 * - parallel writes are enabled but i_size does not extend.
+	 */
+retry:
+	if (exclusive_lock)
+		inode_lock(inode);
+	else {
+		inode_lock_shared(inode);
+
+		/*
+		 * Its possible that truncate reduced the file size after the check
+		 * but before acquiring shared lock. If its so than drop shared lock and
+		 * acquire exclusive lock.
+		 */
+		if (fuse_direct_write_extending_i_size(iocb, from)) {
+			inode_unlock_shared(inode);
+			exclusive_lock = true;
+			goto retry;
+		}
+	}
 
-	/* Don't allow parallel writes to the same file */
-	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
@@ -1559,7 +1595,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2901,6 +2940,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iov_iter_rw(iter) == WRITE) {
 		fuse_write_update_attr(inode, pos, ret);
+		/* For extending writes we already hold exclusive lock */
 		if (ret < 0 && offset + count > i_size)
 			fuse_do_truncate(file);
 	}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..ee5379d41906 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -301,6 +301,7 @@ struct fuse_file_lock {
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_PARALLEL_WRITES: Allow concurrent writes on the same inode
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -308,6 +309,7 @@ struct fuse_file_lock {
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_PARALLEL_WRITES	(1 << 6)
 
 /**
  * INIT request/reply flags
-- 
2.17.1

