Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6797951FABD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiEILDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiEILD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 07:03:28 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28E1F35D0;
        Mon,  9 May 2022 03:59:19 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so13854721fac.9;
        Mon, 09 May 2022 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=BnGXEbV8Y7iEf/Z1438MCDej841Qs2ARKUYBZjaa3vU=;
        b=O6mFHsaWY71qiihG+2kKl84oGRJitswJMj16CyxEf77+qR58ms5pvkK7yj3mFGw+rw
         LKVy3uO9FYuNLPxRrodcoEfmkNkx9+BvKACVlEQox6xIRVfu4KkIcEGK19261bHPB6Ld
         WnMXIrCY2mN1fbwcNP4YuGB4I6Gd4sc0iDsGTfmiNcUqVFHnRi+LznNi3ln09Zaz10Nm
         5cEH4at/42pQJjhAUCqYBjVfBsZDc7eAdPq/6lNbJZ+CGLt01mRA5ZofN3+grDCFEw5N
         7vuIRLY4VKpdg9qIZfCyZlU2xVlOn5pD0Ib2HaMe3TMrewlIk7FyN8nZZfdPDMGZWFkN
         grOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=BnGXEbV8Y7iEf/Z1438MCDej841Qs2ARKUYBZjaa3vU=;
        b=7Aksau9TI5dWDNUkHvGdYWEbm6ldSQRVoihf+XH8slug9EZqRG/CaiiwZAsBcGT6ZH
         TY6ykN+ExvNElhl1SohAm8QsvM+UtiqRrvBDmpWTF6gaDN6Gt0kZT6/KzHautdw+XNhY
         2HbR9RgOduaPGH7cvF4U4ydkXH0Yh0gnHAXVOABndvgGb4r1GOTZkLZcSn1vuXMove0v
         P/zztRY+qZjcfgopz/PKwENGUE1CFd0kbzR5y5rlUBbNSqBOALp7k6H9WWnKPeUqka95
         ngc8c02x3EtosxBxfMTA+4+zK9BjUkEyf+my2f8vNNkAbDASVnEhtkiDQipxw/IRXjOf
         Q4gg==
X-Gm-Message-State: AOAM531YwqdRcL/W2iIiYC7OgnUhblqfhNJDIUh0NYhU/sUhvSlCxI7H
        iPzouIejABwGPA8ZAiRB1iU=
X-Google-Smtp-Source: ABdhPJwQD9E0L71Ga03OY/y0UOZKyH+0TnrU24+fSBgkLvgZm01UzzugjY2BGBk/64yL2nPJhY3www==
X-Received: by 2002:a05:6870:240c:b0:ed:a070:eda5 with SMTP id n12-20020a056870240c00b000eda070eda5mr10018042oap.274.1652093959021;
        Mon, 09 May 2022 03:59:19 -0700 (PDT)
Received: from DDNINR0360.datadirectnet.com ([219.91.178.243])
        by smtp.googlemail.com with ESMTPSA id 26-20020aca0d1a000000b00325d7b6cab8sm4199150oin.16.2022.05.09.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 03:59:18 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v2 1/1] Allow non-extending parallel direct writes
Date:   Mon,  9 May 2022 16:28:47 +0530
Message-Id: <20220509105847.8238-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509105847.8238-1-dharamhans87@gmail.com>
References: <20220509105847.8238-1-dharamhans87@gmail.com>
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
Our guess is some USER space fuse implementations might be relying
on this lock for seralization and also it protects for the issues
arising due to file size assumption or write failures.  This patch
relaxes this exclusive lock in some cases of direct writes.

With these changes, we allows non-extending parallel direct writes
on the same file with the help of a flag called FOPEN_PARALLEL_WRITES.
If this flag is set on the file (flag is passed from libfuse to fuse
kernel as part of file open/create), we do not take exclusive lock instead
use shared lock so that all non-extending writes can run in parallel.

Best practise would be to enable parallel direct writes of all kinds
including extending writes as well but we see some issues such as
when one write completes and other fails, how we should truncate(if
needed) the file if underlying file system does not support holes
(For file systems which supports holes, there might be a possibility
of enabling parallel writes for all cases).

FUSE implementations which rely on this inode lock for serialisation
can continue to do so and this is default behaviour i.e no parallel
direct writes.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/file.c            | 45 ++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..495138a68306 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,14 +1541,48 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
+static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
+					       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t i_size;
+	loff_t offset;
+	size_t count;
+
+	if (iocb->ki_flags & IOCB_APPEND)
+		return true;
+
+	offset = iocb->ki_pos;
+	count = iov_iter_count(iter);
+	i_size = i_size_read(inode);
+
+	return offset + count <= i_size ? false : true;
+}
+
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
+	bool p_write = ff->open_flags & FOPEN_PARALLEL_WRITES ? true : false;
+	bool exclusive_lock = !p_write ||
+			       fuse_direct_write_extending_i_size(iocb, from) ?
+			       true : false;
+
+	/*
+	 * Take exclusive lock if
+	 * - parallel writes are disabled.
+	 * - parallel writes are enabled and i_size is being extended
+	 * Take shared lock if
+	 * - parallel writes are enabled but i_size does not extend.
+	 */
+	if (exclusive_lock)
+		inode_lock(inode);
+	else
+		inode_lock_shared(inode);
 
-	/* Don't allow parallel writes to the same file */
-	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
@@ -1559,7 +1593,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2900,7 +2937,9 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	kref_put(&io->refcnt, fuse_io_release);
 
 	if (iov_iter_rw(iter) == WRITE) {
+
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

