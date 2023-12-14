Return-Path: <linux-fsdevel+bounces-6146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0400B813BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21E01F221A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33933A264;
	Thu, 14 Dec 2023 20:42:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4F282E6;
	Thu, 14 Dec 2023 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c690c3d113so7138430a12.1;
        Thu, 14 Dec 2023 12:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586538; x=1703191338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi96nnLINc22qhwRjZrVxfgpRdElfRJaTo4Tdkir1lc=;
        b=nK8NV3k3DyGAvc6bFJ9PSs1Qu+MBEPVX3TT5ZfvyGUmBCEWWJ9GAUH6nZlepjTGCJ/
         FvgvvKB6JqKdcmdpEYe4b356QpY+bMWPk7TYfkXN7XSvQ8VjELKUEtfY3+wtcpnqGYpV
         HgHAr7h39El7OMh2NcAAFQIhOnQMUcNr5JRUi5C3225FxFP5QnGrfQTOg2YIF4OCYZxG
         7JK4XIJ+XV1w44D7LFyGc+uhV0iqg5K+FHAL2rRJlXEU+/ztw/IBI2L3LWCwGaq77qFd
         v9MA+KmjMA67Ub7KxpfZueb9Aa6Si0Vc8dCK3fHWA8QfH4+/M1Cv/YePjCMWBRYv62Hy
         yc0Q==
X-Gm-Message-State: AOJu0YwOwxAR2DhgTa6PSsSWCQcAqklz6+Yr/6tG5Rpp+tovCW9cXCNi
	hV7SSpnuvcUVWWG8NFwaqEs=
X-Google-Smtp-Source: AGHT+IFfxDhV+H0cdjNnS2YsBOnGZPjr/cswRhRUJ5+9MdxK8SAT9eUT5+rhA40CJe90n0sMRRKOgQ==
X-Received: by 2002:a17:902:f544:b0:1d3:7643:b963 with SMTP id h4-20020a170902f54400b001d37643b963mr1005081plf.38.1702586538061;
        Thu, 14 Dec 2023 12:42:18 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:17 -0800 (PST)
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
Subject: [PATCH v6 07/20] block, fs: Propagate write hints to the block device inode
Date: Thu, 14 Dec 2023 12:40:40 -0800
Message-ID: <20231214204119.3670625-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
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
index 124a06c1b925..5560eb9d8b49 100644
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
index 8018c4da478c..1d97a60de22f 100644
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
index a6e0c4b5a72b..5ae943e717df 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1945,6 +1945,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	void (*apply_whint)(struct file *, enum rw_hint hint);
 } __randomize_layout;
 
 /* Wrap a directory iterator that needs exclusive inode access */

