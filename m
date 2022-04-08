Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79714F8E37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiDHGVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 02:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiDHGVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:21:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59492132E94;
        Thu,  7 Apr 2022 23:18:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c7so11378686wrd.0;
        Thu, 07 Apr 2022 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=sXrx2h/uKeuznM6QnZlvZ5gyDgWktcFuETr25SqnaH8=;
        b=HfIgop56PzGbC34UKE3BY8YUKyPKULFKuCK+oSkBeVZMkrOEY2z0r/DbcKAPfSLi1K
         NpLBJ2iKxwVuoVQ15NnIztVgSACudwkQ1Sfw73VjFHt7Pa4rgGeUAcxTIQ4Jyv58zTF1
         8AaEIurs6v4Osii0UFHWwNvB99Em545hdCQR0jnV1x4+KMvFRs2PRVfC5dGZaOTl47kl
         ocVMfMmRfnFoV/o+LlhjOFXFi2SvtaCHWC+m4BRx2oHn1sHo6+FTCsV4x+lBbILF0EIR
         JVilz4HXSO09bUYiay0Blc9Mxoh9dzXXJa0YthUu6aL/+q35DyqKMNm82/QILMmUjBLD
         Zu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=sXrx2h/uKeuznM6QnZlvZ5gyDgWktcFuETr25SqnaH8=;
        b=pBsses+q7pmz0EFnBagImYJqxC8CuKd4x1YCAK1IjzBKS/M107yZJ5+g+9iPXeUpzR
         q4KSMzItouB+K2AnQDpj8o5B2KqF5QybJWitSMH2vzFYikM4q6O2oE0CI1jAehrHGl7K
         64Ztc7lqtPRSnHNvrHWRxACH4TayOhPowLjmv3+4/Z5pv0/simMyUkt7uKZ0giuP6+V6
         A31xcQyfeeM31xjwPRtcRDyC3x8dCUGiwhTkp7HESbMisUPOqpYxYEy+7z2ifnCC6YLp
         ZYAnYqMMuMXltzT8DL6+zLXiIwo6iKQxZHKsgGUcoSYuVjJEYfq89nMJeyzYPbkIMX+/
         WuBQ==
X-Gm-Message-State: AOAM5312Q6sTkRShJ1jQxbqiCpgr/eDq8u4ZvDkk9BxaU2fjkYEXIiQi
        xU15Xu7dEDB2Sm8QHlmGP14=
X-Google-Smtp-Source: ABdhPJzPo8N/pRLuDN4QeUvd0KsWCRctjfD1TwwHFYfadY/Tjf+94N4cF9qIuctjY+c9OfAMdTv5wg==
X-Received: by 2002:a5d:452c:0:b0:207:9915:60b9 with SMTP id j12-20020a5d452c000000b00207991560b9mr685026wra.379.1649398735730;
        Thu, 07 Apr 2022 23:18:55 -0700 (PDT)
Received: from DDNINR0360.datadirect.datadirectnet.com ([123.201.116.157])
        by smtp.googlemail.com with ESMTPSA id k13-20020a7bc40d000000b0038e9edf5e73sm1051695wmi.3.2022.04.07.23.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 23:18:55 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     bschubert@ddn.com, miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
Date:   Fri,  8 Apr 2022 11:48:09 +0530
Message-Id: <20220408061809.12324-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220408061809.12324-1-dharamhans87@gmail.com>
References: <20220408061809.12324-1-dharamhans87@gmail.com>
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

As of now, in Fuse, direct writes on the same file are serialized
over inode lock i.e we hold inode lock for the whole duration of
the write request. This serialization works pretty well for the FUSE
user space implementations which rely on this inode lock for their
cache/data integrity etc. But it hurts badly such FUSE implementations
which has their own ways of mainting data/cache integrity and does not
use this serialization at all.

This patch allows parallel direct writes on the same file with the
help of a flag called FOPEN_PARALLEL_WRITES. If this flag is set on
the file (flag is passed from libfuse to fuse kernel as part of file
open/create), we do not hold inode lock for the whole duration of the
request, instead acquire it only to protect updates on certain fields
of the inode. FUSE implementations which rely on this inode lock can
continue to do so and this is default behaviour.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/file.c            | 38 ++++++++++++++++++++++++++++++++++----
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 37eebfb90500..d3e8f44c1228 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1465,6 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	int err = 0;
 	struct fuse_io_args *ia;
 	unsigned int max_pages;
+	bool p_write = write &&
+		(ff->open_flags & FOPEN_PARALLEL_WRITES) ? true : false;
 
 	max_pages = iov_iter_npages(iter, fc->max_pages);
 	ia = fuse_io_alloc(io, max_pages);
@@ -1472,10 +1474,11 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		return -ENOMEM;
 
 	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
-		if (!write)
+		/* Parallel write does not come with inode lock held */
+		if (!write || p_write)
 			inode_lock(inode);
 		fuse_sync_writes(inode);
-		if (!write)
+		if (!write || p_write)
 			inode_unlock(inode);
 	}
 
@@ -1568,22 +1571,36 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
+	bool p_write = ff->open_flags & FOPEN_PARALLEL_WRITES ? true : false;
+	bool unlock_inode = true;
 
 	/* Don't allow parallel writes to the same file */
 	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
+		/* Allow parallel writes on the inode by unlocking it */
+		if (p_write) {
+			inode_unlock(inode);
+			unlock_inode = false;
+		}
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
 			res = fuse_direct_io(&io, from, &iocb->ki_pos,
 					     FUSE_DIO_WRITE);
+			if (p_write) {
+				inode_lock(inode);
+				unlock_inode = true;
+			}
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
-	inode_unlock(inode);
+	if (unlock_inode)
+		inode_unlock(inode);
 
 	return res;
 }
@@ -2850,10 +2867,16 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	size_t count = iov_iter_count(iter), shortened = 0;
 	loff_t offset = iocb->ki_pos;
 	struct fuse_io_priv *io;
-
+	bool p_write = (iov_iter_rw(iter) == WRITE &&
+			ff->open_flags & FOPEN_PARALLEL_WRITES);
 	pos = offset;
 	inode = file->f_mapping->host;
+
+	if (p_write)
+		inode_lock(inode);
 	i_size = i_size_read(inode);
+	if (p_write)
+		inode_unlock(inode);
 
 	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
 		return 0;
@@ -2924,9 +2947,16 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	kref_put(&io->refcnt, fuse_io_release);
 
 	if (iov_iter_rw(iter) == WRITE) {
+
+		if (p_write)
+			inode_lock(inode);
+
 		fuse_write_update_attr(inode, pos, ret);
 		if (ret < 0 && offset + count > i_size)
 			fuse_do_truncate(file);
+
+		if (p_write)
+			inode_unlock(inode);
 	}
 
 	return ret;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index a28dd60078ff..07f00dfeb0ce 100644
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

