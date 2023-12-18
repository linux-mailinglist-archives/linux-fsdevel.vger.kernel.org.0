Return-Path: <linux-fsdevel+bounces-6400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53AF817A40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F341F2337A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2D72073;
	Mon, 18 Dec 2023 18:57:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA51EB3F;
	Mon, 18 Dec 2023 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d87eadc43fso703074b3a.1;
        Mon, 18 Dec 2023 10:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925854; x=1703530654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX2AqNGNajm/tepWLqi5DpfhfQCLB1wKlvs8RQ7Asx4=;
        b=d9a+9y8aCKiVXfCS1FgsP5qB3I+Z/gIZU84+pzQNXSHOkaAEEANaU8BxYyLcx5kKRZ
         E5oBAPMSolXQr1BKF3uiPl2NCi9+oUx0GEuWSzfLNOqA5KzlgY4B37HkT8kb4ckwDxs9
         wuRYS2eVgsjiw6S+j71vQ9tmtUf7byeAn/l1E+B/pK7rWGcD5OnEKasqzsuRFvBk1qqO
         nknaWgqXvYymm5KEdSrsZCuW+M3Zmezra/ekwlfRdEIld09CeOvhsylRiSoxDpfU3PxR
         v/SoAxZIBHSB1Qcvj5p6vedgTuezgST3KytbzVWux+dk61bPOctpOwkEFd6XctS99z/x
         WZSQ==
X-Gm-Message-State: AOJu0YyGQHSNjaLApKvsdKbW721Rdmkjy5//jdges9oKjcbVSb+QQjc6
	qOAD0a8o7ph/jke+Wk0vFQQ=
X-Google-Smtp-Source: AGHT+IGgCv37Zf2aPnfaOnoxnhsfTTEi7rr9Z/PQk5jyx3r5vq4DfPyak4kw7Vv6s6tgjuyTqt2D2A==
X-Received: by 2002:a05:6a00:1487:b0:6ce:6265:fc0d with SMTP id v7-20020a056a00148700b006ce6265fc0dmr11018070pfu.6.1702925854573;
        Mon, 18 Dec 2023 10:57:34 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id n20-20020a056a0007d400b006d45707d8edsm3918397pfu.7.2023.12.18.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 10:57:34 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 06/19] block, fs: Propagate write hints to the block device inode
Date: Mon, 18 Dec 2023 10:56:29 -0800
Message-ID: <20231218185705.2002516-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231218185705.2002516-1-bvanassche@acm.org>
References: <20231218185705.2002516-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write hints applied with F_SET_RW_HINT on a block device affect the
shmem inode only. Propagate these hints to the block device inode
because that is the inode used when writing back dirty pages.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/fops.c       | 11 +++++++++++
 fs/fcntl.c         |  4 ++++
 include/linux/fs.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 787ce52bc2c6..138b388b5cb1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -620,6 +620,16 @@ static int blkdev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void blkdev_apply_whint(struct file *file, enum rw_hint hint)
+{
+	struct bdev_handle *handle = file->private_data;
+	struct inode *bd_inode = handle->bdev->bd_inode;
+
+	inode_lock(bd_inode);
+	bd_inode->i_write_hint = hint;
+	inode_unlock(bd_inode);
+}
+
 static ssize_t
 blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -854,6 +864,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.apply_whint	= blkdev_apply_whint,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/fcntl.c b/fs/fcntl.c
index fc73c5fae43c..18407bf5bb9b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -306,6 +306,7 @@ static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
 static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
+	void (*apply_whint)(struct file *, enum rw_hint);
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
@@ -317,6 +318,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 
 	inode_lock(inode);
 	inode->i_write_hint = hint;
+	apply_whint = inode->i_fop->apply_whint;
+	if (apply_whint)
+		apply_whint(file, hint);
 	inode_unlock(inode);
 
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a08014b68d6e..293017ea2466 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1944,6 +1944,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	void (*apply_whint)(struct file *, enum rw_hint hint);
 } __randomize_layout;
 
 /* Wrap a directory iterator that needs exclusive inode access */

