Return-Path: <linux-fsdevel+bounces-10787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BBA84E655
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ED928FA41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75C41272B0;
	Thu,  8 Feb 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL/iXTuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAB823CD
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412116; cv=none; b=gYKLp0xwH8rhPGzxtUBfqkl/I7GkwNFZ7pMHOkuHh2FD4ortZZ2SXZpTYfdC2Rzd756rorWVJ9XfXSVWPiFLMcIXLZLNNgwILdEUXmhBh/eCQPwOVEe7vhzyKZT2QHOYaeD7KMdo3RPefv+NbbfJAH25QsImsKkvJSRmicMlVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412116; c=relaxed/simple;
	bh=vc+4y8dtmeiYaKQKPYMvznLCgiSrSyDt+HqfYdEm3Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNznmOS9EWY4lo8qCWNb8BrJZbjEoWABilMPyNTpuic9BEWWzHLKLjwVH6EJX/7lNjNKeGd43pEqtn96EWxuERN0tqzAm42w9kBvkjfQp6wYqH7D6kLfN/LuB/9Mhxk3Qr4bAWkn5lhvntD5GPo6lIuoD1WoPpL5goJCLbK/IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL/iXTuO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so739735e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412112; x=1708016912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnpbF4C2dzRm7euFf3p3x0k25EtKx6xZ5O5jv6A/MR4=;
        b=SL/iXTuOdBKprhVysXX5GRPJSU/KGGUJG8rjVGSCoG36Dw3v29rB4e0R84iHyOYJOh
         iw/o7Ll7CxVBhHiN7mNxNXOTzTVkclD+PectMjxQAzsx903jPMrWfDuqlixqumDS4BUA
         oj32QjFNZignSzhPwyatIoFDX2P/k9rK60abYyG0Ko3gsfneixzdQRDpYkdKsZ1VHK2p
         ZWC75oF+27X7mJ895/pOYxoZqVJL877VURMMsS5VnO+BkE6xgjBfB5lKoufzrt+3TUen
         2zKDAb2mJixoJHbdaTpQMei2D6ts0LM21Pv97gxIt1ZNWH+/nqsbUyymlzON5rSF/pG3
         I9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412112; x=1708016912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnpbF4C2dzRm7euFf3p3x0k25EtKx6xZ5O5jv6A/MR4=;
        b=bMezRY93QnBSrk4yUf9pAYkDgFmwB/u1xihQhizIi6OxQNRdRxNoVnhbzuVIkDo6LZ
         R5AhHst4TtETu8dm+AAjJja4d/BZCwlFzsdB8oYMyRefKaDUk7Jw2V2CjLRf24XvIqki
         kimzYqrMgIlu/z5tosr1RWZhHUN3Et8Gy1jB23Brm+UPKk2X8iXM5Dr210yiEdu/5fCU
         RicK+JW7sy6AFSC6+dW1D6kzlYRSbQGErY6brxOG6KhXL+rK8D+2/b+VeLLJi6WMmc3r
         FKwZmwxZGWXuo5sP3UijfJqPSwznR8AZ0UYnYAAYB3xljv5U2jSQvUIsQbQcHsUSjJ4m
         J0Nw==
X-Gm-Message-State: AOJu0Yw+eaVY2yozTia8nnXV7NNogm+O7llf3YB91QxKoYJPPd3AxSnL
	L7YeOJ1GfkEup6LhR1ueuLUHL0vWalyH+bsmLO97yOloeasxCTdPHhm6jbl6
X-Google-Smtp-Source: AGHT+IGpo0xtn2r/QD2tMuQsjW3SJ5MEm/NQR/+KIdHV4tylDpiOv5jdUEh14zcjVwKBhAWAv2LGdw==
X-Received: by 2002:a05:600c:450c:b0:40e:f222:9e52 with SMTP id t12-20020a05600c450c00b0040ef2229e52mr6195977wmo.40.1707412112494;
        Thu, 08 Feb 2024 09:08:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAo1l3cterEpF2VYNvdQ/QlvprCPP2m5TYNEP8mgGRrMcWhId1oxGxPc054yuNL5cWgilMjGyPyNMK4XpLmdhtCqpg0jebvAl/H2ZDKabtJCmK1gT9p3cEhpMVc7klR90=
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:08:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 2/9] fuse: Create helper function if DIO write needs exclusive lock
Date: Thu,  8 Feb 2024 19:05:56 +0200
Message-Id: <20240208170603.2078871-3-amir73il@gmail.com>
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

This makes the code a bit easier to read and allows to more
easily add more conditions when an exclusive lock is needed.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 64 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 243f469cac07..a64ee1392c77 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1299,6 +1299,45 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 	return res;
 }
 
+static bool fuse_io_past_eof(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
+/*
+ * @return true if an exclusive lock for direct IO writes is needed
+ */
+static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/* server side has to advise that it supports parallel dio writes */
+	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
+		return true;
+
+	/* append will need to know the eventual eof - always needs an
+	 * exclusive lock
+	 */
+	if (iocb->ki_flags & IOCB_APPEND)
+		return true;
+
+	/* combination opf page access and direct-io difficult, shared
+	 * locks actually introduce a conflict.
+	 */
+	if (get_fuse_conn(inode)->direct_io_allow_mmap)
+		return true;
+
+	/* parallel dio beyond eof is at least for now not supported */
+	if (fuse_io_past_eof(iocb, from))
+		return true;
+
+	return false;
+}
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1558,26 +1597,12 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
-static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
-					       struct iov_iter *iter)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-
-	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
-}
-
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct file *file = iocb->ki_filp;
-	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
-	bool exclusive_lock =
-		!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
-		get_fuse_conn(inode)->direct_io_allow_mmap ||
-		iocb->ki_flags & IOCB_APPEND ||
-		fuse_direct_write_extending_i_size(iocb, from);
+	bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
 
 	/*
 	 * Take exclusive lock if
@@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	else {
 		inode_lock_shared(inode);
 
-		/* A race with truncate might have come up as the decision for
-		 * the lock type was done without holding the lock, check again.
+		/*
+		 * Previous check was without any lock and might have raced.
 		 */
-		if (fuse_direct_write_extending_i_size(iocb, from)) {
+		if (fuse_io_past_eof(iocb, from)) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			exclusive_lock = true;
@@ -2468,7 +2493,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return fuse_dax_mmap(file, vma);
 
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
-		/* Can't provide the coherency needed for MAP_SHARED
+		/*
+		 * Can't provide the coherency needed for MAP_SHARED
 		 * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
 		 */
 		if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow_mmap)
-- 
2.34.1


