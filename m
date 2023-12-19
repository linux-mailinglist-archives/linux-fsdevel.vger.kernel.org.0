Return-Path: <linux-fsdevel+bounces-6443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C62817E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678DAB2386E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F84694;
	Tue, 19 Dec 2023 00:08:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6489715AC;
	Tue, 19 Dec 2023 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3dc30ae01so1258575ad.0;
        Mon, 18 Dec 2023 16:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944521; x=1703549321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX2AqNGNajm/tepWLqi5DpfhfQCLB1wKlvs8RQ7Asx4=;
        b=KwYusEcLKEbLb0ISzaK4ftDOOOr5eYdg+bgDf/rm/tztSQI4TBf/aENeNcZMQFEY0Z
         jOsR4XKNnlvCZ9fLgnlqf9KKLkS0hVba2faMo8p0yFStI+dmk22DeCdhodh0T9LQzOj0
         bn5wFuUtruetr0sPvj83sj+3rkbjY+pZiJ+NgJds1hO2hqCsiuZAMbC6QC09W/aDHSux
         qjTyVH9s6m/awKbxjSqcqnYhpJvD8bz+PpAOgiL0P2ZZdpApo6xvRY6JqtuSBD51f3NG
         29FfHYyiIxYq9W/aBBNipblpbKhvDoLfEeZuKXoIBxhDXyeLY9hJbAHQ9OSsCwe7VLrV
         yytQ==
X-Gm-Message-State: AOJu0YzZ4RMrJcuRELW9Sga2iYHuSUJ6MyJKsiD3K2JN/8x3SCPzSWYX
	8czQoXPStki+8wxvz3HaPvM=
X-Google-Smtp-Source: AGHT+IEmj3kamI3VsxdqaEabn9RtMOl6kBEZX6XfMNxPzJ20y98OnyfmHTuoiLefyC4//1qIfnkGEA==
X-Received: by 2002:a17:903:2304:b0:1d3:b3b7:5db0 with SMTP id d4-20020a170903230400b001d3b3b75db0mr3429695plh.4.1702944521612;
        Mon, 18 Dec 2023 16:08:41 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:41 -0800 (PST)
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
Subject: [PATCH v8 06/19] block, fs: Propagate write hints to the block device inode
Date: Mon, 18 Dec 2023 16:07:39 -0800
Message-ID: <20231219000815.2739120-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
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

