Return-Path: <linux-fsdevel+bounces-4301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0F7FE707
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C753B20F31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC3134B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B543198;
	Wed, 29 Nov 2023 17:33:41 -0800 (PST)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c6263fce87so108579a12.0;
        Wed, 29 Nov 2023 17:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308021; x=1701912821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSe2qQ1ghjwblhDujV9feTu29lV38bmjDtGQkN4h5sc=;
        b=MW+GzeXNayyuOLMW8r5bu+DJaSPQB2B9deK4j1dT9xQEqvSJaKwpEd70kO3ry4SxDH
         bodA539hbFvp5vQGNuNfuGPDpHANIs9W9AiPM5oL6Ya8odbXCWuV4KBMMLO4v5JZI0JA
         GnKwiLgIbSY/3FcrN0Mf8a+M355XXri7wl1pLmA/hPj1bcYImHAplgfrg2mUz+iFeO+P
         MDER22+cRcrU9hkkFyytrqVfGY/Di7ha0P2APa3JDde3mRdnpWnAAsd/hFT6AZ4ihXNl
         1QWPQpdr2Jdegy3Q87ysDeDOm/fhi/Ho1Ntz9Y9rwklWFBTZ8sUjHvWNKzgZ+6mnjlTu
         h2ig==
X-Gm-Message-State: AOJu0YzG5txXYO2k2cVtxjj2Stey8h89tXc2iYF55QYGTNJSyaXOcoiG
	w6GaMbNaZ9bxqSxpBz3Llzk=
X-Google-Smtp-Source: AGHT+IFZh8sYa9ER2WZGobWh8qvG72N4v5saLXN0TQenb8zJIxhcn4ms+zkZ3jccav/y83CIrFtvrQ==
X-Received: by 2002:a17:90a:ce81:b0:281:3a5:d2ec with SMTP id g1-20020a17090ace8100b0028103a5d2ecmr33141321pju.8.1701308020643;
        Wed, 29 Nov 2023 17:33:40 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:40 -0800 (PST)
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
Subject: [PATCH v5 07/17] block: Propagate write hints to the block device inode
Date: Wed, 29 Nov 2023 17:33:12 -0800
Message-ID: <20231130013322.175290-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
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
index 2de61d81f8ec..87ddaf3ac831 100644
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
index fe80e19f1c1a..c0f8b7e880a4 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -287,6 +287,7 @@ static bool rw_hint_valid(u64 hint)
 static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			  unsigned long arg)
 {
+	void (*apply_whint)(struct file *, enum rw_hint);
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
 	u64 hint;
@@ -320,6 +321,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 
 		inode_lock(inode);
 		inode->i_write_hint = hint;
+		apply_whint = inode->i_fop->apply_whint;
+		if (apply_whint)
+			apply_whint(file, hint);
 		inode_unlock(inode);
 		return 0;
 	default:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index acc0cbab93dd..c5f82b88a82e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1946,6 +1946,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	void (*apply_whint)(struct file *, enum rw_hint hint);
 } __randomize_layout;
 
 /* Wrap a directory iterator that needs exclusive inode access */

