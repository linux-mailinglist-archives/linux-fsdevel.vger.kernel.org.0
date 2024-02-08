Return-Path: <linux-fsdevel+bounces-10788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B684E658
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9E928D7CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056887EF18;
	Thu,  8 Feb 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQG9dHGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B51272C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412132; cv=none; b=cjLuKfyY/50kV4+12skt7LuTr/a4io/FhHjJwtEbpNn/3jfMcnhubOqGzkDUsuIdDmsfRHgc95JSIPO6mwS1eB0zDmo80EznZK1D2HIJa5KHEWW3i9DwYxpyiy2cqyWYPTtefWZP+ch2GunV5r2nNK9nvuguJ1Ye2kBUVHMXY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412132; c=relaxed/simple;
	bh=lhYG46+NW6mq+0ZPHHbQV6MqRGLrYlwAm3xyfEhFeHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PayFSIOZ8DA/wE3CR9GmORk5+SiOIrsxhkbB+oC7diSEDjCxouIOCxN5IIKNHG1PjTZXjdzCWIrvnZq1VraGkq5YShlYNv7if+/po28Cgph3P8s15LSV+DZqMYv+dJdEwySn5EPjkqjc5KSe/oiYHtGf8m9000RMOR2FqfS6Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQG9dHGi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b2960ff60so702087f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412129; x=1708016929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmj+ClzZDDFzj3JWtFZYzYu4soZaCiWmEHYThaI8WgM=;
        b=DQG9dHGiHQUkn1T81S+heVQ3wXHW5voNpC9nR8rJASpk2IvoWkfRzoLG+J2EuVupCL
         g65OeeGimi7ajumoI+7tAH5VCRZ2iBf7UVMi7wTcl4y8nR+I86ui2lzleRLpSVUR/Z//
         DgcrqpFkN0yBmQ9XOlGU4lHNUTKGr66YrIdtAVA7MbhTNpUfAR25rsU8f1bVF3WKeREK
         gOcciZawBlRsUzbaCacxR9sJGXYG9IhUElCJl298UArnnG8hKCPiNIYCnsCB+NanSKN6
         z/q4MhgZ77IbuyjfIBGHcySQ9CAucVY7pMDkqOwoXoijDbAV7rV0Bps62GjwlHDA6LBE
         X39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412129; x=1708016929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmj+ClzZDDFzj3JWtFZYzYu4soZaCiWmEHYThaI8WgM=;
        b=fsNQprsrZaImAa3fgiGKEmHsNaPvDr0MSnHWZigahUE406A5gZAzT/j6F7yo47ICcv
         VKUGE6mhNXOeM/fGPWXW02FqOkwUAf2Klo43VApnnKW7mF/4ODQgDCbufz26sy07tKxK
         Mfwc8sZDsPdPQf/vrXhZ3albSMUnA7kbaq2lprIl4rcl6EzZkZ8lFDNfG7kCjUJtw1B1
         ZS+XQREypWvSLkbbp3U9lXiwkyZKpJ/jvC+2MpfKnOml9bm71x6sdaqU9YY4N2/ikvUE
         Eywjb4qZ0nmZGFHF+KhDJluoKX/NnoeJvmNMaC6udBHp+yCfSZgQEFNMz41Xq52Livf7
         VApw==
X-Gm-Message-State: AOJu0Yzbu/opZp3CRjGaGQABpXeQLxPljh2nDyXDiRTjBxWMI/UON+2Z
	iof2FTIPS5qRxBS/zed9emnBBIfTWC1bMuf8rZSMesDnw2i9/0ZM
X-Google-Smtp-Source: AGHT+IFNbCQ7kYiwTxRlCuQMYGMl2t/dVtr/m9NKx5Xo2qJDYPoAQcx4S68NjGXxgAF/PI4rvQyhDQ==
X-Received: by 2002:a5d:4e46:0:b0:338:8892:fbdd with SMTP id r6-20020a5d4e46000000b003388892fbddmr226805wrt.4.1707412128503;
        Thu, 08 Feb 2024 09:08:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUh/9LJbsWYrQBoN1fm3jnnTsfbOVAjYpxUzWIcIzo4xGLl8qjAd6etcpaFNXCLxZBx1jKggMfdfpPye+1PBkbTK1Hp+EzHRPyfec8vsvV57KGBpGqwz689pD+PWUsNzyY=
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:08:38 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 3/9] fuse: Add fuse_dio_lock/unlock helper functions
Date: Thu,  8 Feb 2024 19:05:57 +0200
Message-Id: <20240208170603.2078871-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170603.2078871-1-amir73il@gmail.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bernd Schubert <bschubert@ddn.com>

So far this is just a helper to remove complex locking
logic out of fuse_direct_write_iter. Especially needed
by the next patch in the series to that adds the fuse inode
cache IO mode and adds in even more locking complexity.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 61 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a64ee1392c77..3062f4b5a34b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1338,6 +1338,37 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
 	return false;
 }
 
+static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
+			  bool *exclusive)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	*exclusive = fuse_dio_wr_exclusive_lock(iocb, from);
+	if (*exclusive) {
+		inode_lock(inode);
+	} else {
+		inode_lock_shared(inode);
+		/*
+		 * Previous check was without inode lock and might have raced,
+		 * check again.
+		 */
+		if (fuse_io_past_eof(iocb, from)) {
+			inode_unlock_shared(inode);
+			inode_lock(inode);
+			*exclusive = true;
+		}
+	}
+}
+
+static void fuse_dio_unlock(struct inode *inode, bool exclusive)
+{
+	if (exclusive) {
+		inode_unlock(inode);
+	} else {
+		inode_unlock_shared(inode);
+	}
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1602,30 +1633,9 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
-	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
-
-	/*
-	 * Take exclusive lock if
-	 * - Parallel direct writes are disabled - a user space decision
-	 * - Parallel direct writes are enabled and i_size is being extended.
-	 * - Shared mmap on direct_io file is supported (FUSE_DIRECT_IO_ALLOW_MMAP).
-	 *   This might not be needed at all, but needs further investigation.
-	 */
-	if (exclusive_lock)
-		inode_lock(inode);
-	else {
-		inode_lock_shared(inode);
-
-		/*
-		 * Previous check was without any lock and might have raced.
-		 */
-		if (fuse_io_past_eof(iocb, from)) {
-			inode_unlock_shared(inode);
-			inode_lock(inode);
-			exclusive_lock = true;
-		}
-	}
+	bool exclusive;
 
+	fuse_dio_lock(iocb, from, &exclusive);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
@@ -1636,10 +1646,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
-	if (exclusive_lock)
-		inode_unlock(inode);
-	else
-		inode_unlock_shared(inode);
+	fuse_dio_unlock(inode, exclusive);
 
 	return res;
 }
-- 
2.34.1


