Return-Path: <linux-fsdevel+bounces-6142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C2813BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584971F22540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25296A001;
	Thu, 14 Dec 2023 20:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D66ABA4;
	Thu, 14 Dec 2023 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d05199f34dso50255855ad.3;
        Thu, 14 Dec 2023 12:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586517; x=1703191317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJzjvBu27w4u++rDgDtYuKSsyegZn0GUdEKSmcBTHV0=;
        b=Xe8ECgP4Z2LTh5XAQl62sCmPVJSQ2jO7wfmjvaTSBqwKAXSVh7A5/iFzG0L4Mswc6D
         mzyWEOtRjyOffvbngo5j3uD+cHg1YgJ1IHnm1gRjtFDFSid9wi7sE7rhCZ2WCdDxStQ9
         mKGzCUdL8xSMnKVyxqwgvx5HC/Ilfx3aSDf4qFLdJR5seY13NZkoCVlFYiDAM3050pv3
         fnDesptOIHPDcOSknpBlyvzAlBhykbxfVDvlLw78elhaCdvyLUmgo37t+/1HJibrHcvq
         CZloAgps+6LS9bMD+vkZpcd8t6Tklk+PejrWjcT1gT8WDdZU7NqR714uBfjddc2KSn7e
         azDw==
X-Gm-Message-State: AOJu0YwgVM/L61VU+NBjKhtWpkcWN/h/YyoB/GHAiWPiEV53rLxV7sor
	Nf9KBZhnUfj+OQg9Ri8/vgI=
X-Google-Smtp-Source: AGHT+IFTv4hi6iBEdmBa/uXCfiosFH7TqSHnh4Q4zA4O1GMRwsAuPvgU+zzlsESmQnlsoo5+Tb2Y/A==
X-Received: by 2002:a17:902:ec89:b0:1cf:b29d:3e8e with SMTP id x9-20020a170902ec8900b001cfb29d3e8emr6360635plg.58.1702586516794;
        Thu, 14 Dec 2023 12:41:56 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:41:56 -0800 (PST)
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
Subject: [PATCH v6 03/20] fs: Split fcntl_rw_hint()
Date: Thu, 14 Dec 2023 12:40:36 -0800
Message-ID: <20231214204119.3670625-4-bvanassche@acm.org>
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

Prepare for restoring F_[GS]ET_FILE_RW_HINT by splitting fcntl_rw_hint()
such that there is one helper function per fcntl. No functionality is
changed by this patch.

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

