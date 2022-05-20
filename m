Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6052E3DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 06:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbiETEf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 00:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiETEfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 00:35:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7525149DBB;
        Thu, 19 May 2022 21:35:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6967733pjg.0;
        Thu, 19 May 2022 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=+HMM3QrNZIcRde8m3UrpX3LxHzWz6RayXI9TEq8xKik=;
        b=UvPLHgyINUZ3FQH9w9t+MzAvoXFFolYJBVupiGDy89jK0wLWw5w9EwFLt2gUhzW0LT
         X8aJazZeV4EoNLmXbcQpN0r7lbV8Z3WwbJgRalzFZqRbMxH8v00m+vnKEFMDfzAPfTQk
         0RDhZwdoHteINH79fo8Eju16baTsqaKYhd2W27RnJmwrsek97Z2BS5VXZCZEonp29nX4
         +48ACdzF81qkPuEONBRUylhhWhg0B2a+sFL8tZISPP31rGWg2JDW5o5kEakjQw0IfmHM
         v4B1GQ4g9CLhJEg+Az1NndjV2XNHpXkZXBLSeLGrM7IdEEFPJo5dwdb76nASd5DdG4ge
         AEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=+HMM3QrNZIcRde8m3UrpX3LxHzWz6RayXI9TEq8xKik=;
        b=Hb3SfFjoEhOhGDZs72p+mVjXX2JQsaW6lNfQFxiBX/kfdOlmfWUL3fHM0F05VaXCMb
         oQrMFZRUSMd72ZWxS+UErvNFq9IZmKfRTkQf0HnPjRFmT9hW3Ke/UH93MeZo2PRPhv4e
         1ErC+CZ/HwJzZniBn6duaOwC0dCaoKj+hVSeb1XziJCXrxbiCBQgbi1ua+FuqLj8lV4O
         5uyAUMcuWcu/eYftO56a73d/veor/g8YFxOJ08nnAkQKrXFRsRoZynhRfFUKvrAwjBXE
         qiqxMB70xysrS67jGZMHRVYXf3DGXli7QtA46hUua9GtfDHkj2Ry3ZoQal7QxT8JArtO
         923A==
X-Gm-Message-State: AOAM532msSyQkDWKHebr393qj+M7uWvZngURfPD4aeHm49H1fJSUgxEb
        cd/m18AkBH/AVpVBWNcUXnx3AukXY1JZTBoj
X-Google-Smtp-Source: ABdhPJzjv8yD/glTSYzn3OCizSyLT3X+0zESC7iq9ZinuDwiA/a2UeNOLaCtgrFRSen2QgL/3frcNg==
X-Received: by 2002:a17:903:2055:b0:161:7399:3b89 with SMTP id q21-20020a170903205500b0016173993b89mr8109739pla.22.1653021302370;
        Thu, 19 May 2022 21:35:02 -0700 (PDT)
Received: from localhost.localdomain ([123.201.215.11])
        by smtp.googlemail.com with ESMTPSA id t1-20020a17090a024100b001d952b8f728sm724748pje.2.2022.05.19.21.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:35:01 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v3 1/1] FUSE: Allow non-extending parallel direct writes on the same file.
Date:   Fri, 20 May 2022 10:04:43 +0530
Message-Id: <20220520043443.17439-2-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520043443.17439-1-dharamhans87@gmail.com>
References: <20220520043443.17439-1-dharamhans87@gmail.com>
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
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c            | 33 ++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..1a93fd80a6ce 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,14 +1541,37 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
+	bool exclusive_lock = !(ff->open_flags & FOPEN_PARALLEL_WRITES) ||
+			       fuse_direct_write_extending_i_size(iocb, from);
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
@@ -1559,7 +1582,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2901,6 +2927,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
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

