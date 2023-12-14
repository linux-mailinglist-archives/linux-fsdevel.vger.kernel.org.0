Return-Path: <linux-fsdevel+bounces-6144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EF813BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FB8283703
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399B6DCEF;
	Thu, 14 Dec 2023 20:42:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FF17755;
	Thu, 14 Dec 2023 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d075392ff6so8840425ad.1;
        Thu, 14 Dec 2023 12:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586534; x=1703191334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk2ihovKNRK6u+s+5HL4/doR8ARRBdZiN97q9xkBx2w=;
        b=aml3HwrHsVai0ZKXqAZBB1J0Ywp+t5a/nrC83yt/L0fFcHazpx8dA34Wt/xqQE4lzg
         ta2qjRs10atI7y6ZtTs7bL4b9F04txp5nPMIqfmOcxR0Mmde+ysVVaZnDZxhSovlkV/N
         cvRWtxvpfoLmRKRRgis8fB8AMTVbABZtkTTddIpKUbtVDQImn20lyKnIOrGIyfH6beIu
         jQXaPnhMhZOxCbthfn9xUkOfZIFGJJ1FoCt9OsBUfRSQXKzr9NuFWJBoju1erkVXWUkf
         1hNJQQUW1LJBQYuoj91xL0FkRczYVKD1mjtJ0SYutkOJO3xlH1RXVVTwR3s6hgYjFST1
         nu/w==
X-Gm-Message-State: AOJu0YxhHt+TAr1q5BSRnOTqkZ4IUFXuOAcNOQcQUnAvkjy1S2GrGuRX
	HmC7Gd7Og+NbSwq1S/XDJMM=
X-Google-Smtp-Source: AGHT+IHUKISqW/ooeu+52hVSdEzOkIeEunISRmuNe9xMkTy+67JP30xd5O4TH3Yv1+scZ0m6Fr+8Rw==
X-Received: by 2002:a17:902:cec3:b0:1d0:4802:3b6c with SMTP id d3-20020a170902cec300b001d048023b6cmr13163916plg.4.1702586534349;
        Thu, 14 Dec 2023 12:42:14 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:13 -0800 (PST)
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
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v6 05/20] fs: Restore F_[GS]ET_FILE_RW_HINT support
Date: Thu, 14 Dec 2023 12:40:38 -0800
Message-ID: <20231214204119.3670625-6-bvanassche@acm.org>
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

Since there are applications (e.g. Ceph) that use F_[GS]ET_FILE_RW_HINT,
restore support for these fcntls. This patch restores functionality that
was removed by commit 7b12e49669c9 ("fs: remove fs.f_write_hint").

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c         | 37 +++++++++++++++++++++++++++++++++++++
 fs/open.c          |  1 +
 include/linux/fs.h |  9 +++++++++
 3 files changed, 47 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index fc73c5fae43c..8018c4da478c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -322,6 +322,37 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static long fcntl_get_file_rw_hint(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 __user *argp = (u64 __user *)arg;
+	u64 hint = inode->i_write_hint;
+
+	hint = file_write_hint(file);
+	if (copy_to_user(argp, &hint, sizeof(*argp)))
+		return -EFAULT;
+	return 0;
+}
+
+static long fcntl_set_file_rw_hint(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	u64 __user *argp = (u64 __user *)arg;
+	u64 hint;
+
+	if (copy_from_user(&hint, argp, sizeof(hint)))
+		return -EFAULT;
+	if (!rw_hint_valid(hint))
+		return -EINVAL;
+
+	spin_lock(&file->f_lock);
+	file->f_write_hint = hint;
+	spin_unlock(&file->f_lock);
+
+	return 0;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -430,6 +461,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_RW_HINT:
 		err = fcntl_set_rw_hint(filp, cmd, arg);
 		break;
+	case F_GET_FILE_RW_HINT:
+		err = fcntl_get_file_rw_hint(filp, cmd, arg);
+		break;
+	case F_SET_FILE_RW_HINT:
+		err = fcntl_set_file_rw_hint(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..4c5c29541ac5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -961,6 +961,7 @@ static int do_dentry_open(struct file *f,
 	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
 		f->f_mode |= FMODE_CAN_ODIRECT;
 
+	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 	f->f_iocb_flags = iocb_flags(f);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a08014b68d6e..a6e0c4b5a72b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -989,6 +989,7 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
+	enum rw_hint		f_write_hint;
 	fmode_t			f_mode;
 	atomic_long_t		f_count;
 	struct mutex		f_pos_lock;
@@ -2162,6 +2163,14 @@ static inline bool HAS_UNMAPPED_ID(struct mnt_idmap *idmap,
 	       !vfsgid_valid(i_gid_into_vfsgid(idmap, inode));
 }
 
+static inline enum rw_hint file_write_hint(struct file *file)
+{
+	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+		return file->f_write_hint;
+
+	return file_inode(file)->i_write_hint;
+}
+
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 {
 	*kiocb = (struct kiocb) {

