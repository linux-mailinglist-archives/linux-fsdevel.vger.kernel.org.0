Return-Path: <linux-fsdevel+bounces-4298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2317FE6FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E29A1C20A34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE9134A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C7210D4;
	Wed, 29 Nov 2023 17:33:37 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5b9a456798eso371040a12.3;
        Wed, 29 Nov 2023 17:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308016; x=1701912816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlH7tXr/JJ/oeUjxYcuUpMA0NZ87dlG/Te1MIow77j4=;
        b=bHB59P6b738Ks3jJOEoU3/gWvi6lAZq8SjB5Zv4/pJVZJzAxJINN4O9wE8P9D5tkT4
         Geiopz68VZ0qeBrppUULk8jLbLEXux1CiJpULkHgPR9tzVuzm2lLdEEzLdTR3OY5GoMy
         NXyoZuX3MlVxXK5VF6GCxaO5LmiJH7M8zYPmiGFcTriKc49oN7a+GNPvuSnCVPGzSXJi
         a58lErpqoDmrdFlhlv+bLsu1IfRYV3mLZNyMsIGNvq+J7liAa4kmW7TAclx8PRHPC2KH
         FPVKpBnEbZmA9MyoN6w1GbdBflubhZz6atrZQaVsU4WVDPaGQy7ZgP5Z3R0bIWUpTmT+
         Gg/w==
X-Gm-Message-State: AOJu0Yxc6QpoGRq2PJgyPuaBrREW2SioQM1y5GuoDiy4zBio7/EYcp8g
	YJ0ZhTqtXsYkFeyKIans+M2SpLPHWrt+BQ==
X-Google-Smtp-Source: AGHT+IEVG8FVaNCQCICcqJFGF7WP+eGvIK382l2jPoq5LJUM4Dhnxtz87XO3dRX0IKSkX6fFXGxcHw==
X-Received: by 2002:a17:90b:224f:b0:281:4fa7:7ab0 with SMTP id hk15-20020a17090b224f00b002814fa77ab0mr16415617pjb.24.1701308016370;
        Wed, 29 Nov 2023 17:33:36 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:35 -0800 (PST)
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 04/17] fs: Restore F_[GS]ET_FILE_RW_HINT support
Date: Wed, 29 Nov 2023 17:33:09 -0800
Message-ID: <20231130013322.175290-5-bvanassche@acm.org>
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

Revert commit 7b12e49669c9 ("fs: remove fs.f_write_hint") to enable testing
write hint support with fio and direct I/O.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c         | 17 +++++++++++++++++
 fs/open.c          |  1 +
 include/linux/fs.h |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 891a9ebcdef1..fe80e19f1c1a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -292,6 +292,21 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	u64 hint;
 
 	switch (cmd) {
+	case F_GET_FILE_RW_HINT:
+		hint = file_write_hint(file);
+		if (copy_to_user(argp, &hint, sizeof(*argp)))
+			return -EFAULT;
+		return 0;
+	case F_SET_FILE_RW_HINT:
+		if (copy_from_user(&hint, argp, sizeof(hint)))
+			return -EFAULT;
+		if (!rw_hint_valid(hint))
+			return -EINVAL;
+
+		spin_lock(&file->f_lock);
+		file->f_write_hint = hint;
+		spin_unlock(&file->f_lock);
+		return 0;
 	case F_GET_RW_HINT:
 		hint = inode->i_write_hint;
 		if (copy_to_user(argp, &hint, sizeof(*argp)))
@@ -416,6 +431,8 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GET_RW_HINT:
 	case F_SET_RW_HINT:
+	case F_GET_FILE_RW_HINT:
+	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
 	default:
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

