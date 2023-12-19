Return-Path: <linux-fsdevel+bounces-6440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FAC817E71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770CA283770
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9293C0E;
	Tue, 19 Dec 2023 00:08:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276B1FDE;
	Tue, 19 Dec 2023 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so1405673a12.0;
        Mon, 18 Dec 2023 16:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944505; x=1703549305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkthmP4bZIqeOGTObc8ZGg/UrCVoX1rsnNT/8DFjYSU=;
        b=oUIEjbhl6vK2mIyFZFhgd7H2kKVRgQ9D58eNzIHP0JN9dUfJnPkKZ1xmCAMiOvepAu
         tAupK+taNTXBcDhaQaGRhx2Ni8qUX/7nQ3KXiJow/ro1WJPbhlPF+ET81dfd1xjoAoEB
         aBggkz3lL6lbuKN+uzTgwPhohs16gRSxwdoVA7whig7SluzAYu9Md7tW1S8j6a8dDf0+
         kcnHAyMEALBD76Y2RWUqSdsmIjJWTchDuYUynhhf2x2nTPRFLIrgwuznQ0ohIPKcnP+j
         zrSPyBSO1r45JC9hb2BAyLhTQRxJJUmN2+Bwiy7L9lbdeGGY47hvABKfly2CNnqIrnLO
         t+Wg==
X-Gm-Message-State: AOJu0YwIGCvRPmwG2CvSpWrMaCSQgJxMQX0On9SmcJ7pBkxuZQ2IJKDT
	VqEclgi5EDQ7YdUkv+sEB2w=
X-Google-Smtp-Source: AGHT+IEE4XI4+iwofpaLxXjEb/YUxvr/ucyGnEOKq+OqDziRgNwT6OOvc05sNBV/kVpUhUOw3Be/uA==
X-Received: by 2002:a17:90a:4381:b0:28b:3da8:47b0 with SMTP id r1-20020a17090a438100b0028b3da847b0mr2094030pjg.37.1702944504908;
        Mon, 18 Dec 2023 16:08:24 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:24 -0800 (PST)
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
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 03/19] fs: Split fcntl_rw_hint()
Date: Mon, 18 Dec 2023 16:07:36 -0800
Message-ID: <20231219000815.2739120-4-bvanassche@acm.org>
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

Split fcntl_rw_hint() such that there is one helper function per fcntl. No
functionality is changed by this patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f3bc4662455f..5fa2d95114bf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -290,32 +290,35 @@ static bool rw_hint_valid(u64 hint)
 	}
 }
 
-static long fcntl_rw_hint(struct file *file, unsigned int cmd,
-			  unsigned long arg)
+static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	u64 hint;
+	u64 hint = inode->i_write_hint;
 
-	switch (cmd) {
-	case F_GET_RW_HINT:
-		hint = inode->i_write_hint;
-		if (copy_to_user(argp, &hint, sizeof(*argp)))
-			return -EFAULT;
-		return 0;
-	case F_SET_RW_HINT:
-		if (copy_from_user(&hint, argp, sizeof(hint)))
-			return -EFAULT;
-		if (!rw_hint_valid(hint))
-			return -EINVAL;
+	if (copy_to_user(argp, &hint, sizeof(*argp)))
+		return -EFAULT;
+	return 0;
+}
 
-		inode_lock(inode);
-		inode->i_write_hint = hint;
-		inode_unlock(inode);
-		return 0;
-	default:
+static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 __user *argp = (u64 __user *)arg;
+	u64 hint;
+
+	if (copy_from_user(&hint, argp, sizeof(hint)))
+		return -EFAULT;
+	if (!rw_hint_valid(hint))
 		return -EINVAL;
-	}
+
+	inode_lock(inode);
+	inode->i_write_hint = hint;
+	inode_unlock(inode);
+
+	return 0;
 }
 
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
@@ -421,8 +424,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
+		err = fcntl_get_rw_hint(filp, cmd, arg);
+		break;
 	case F_SET_RW_HINT:
-		err = fcntl_rw_hint(filp, cmd, arg);
+		err = fcntl_set_rw_hint(filp, cmd, arg);
 		break;
 	default:
 		break;

