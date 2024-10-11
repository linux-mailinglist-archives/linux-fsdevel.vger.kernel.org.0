Return-Path: <linux-fsdevel+bounces-31718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50D99A57D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB12B24652
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E1218D99;
	Fri, 11 Oct 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZIoacgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D5215F78
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654815; cv=none; b=W1rV0tvrnx3wspBSpam0/NRZWIrJgsh/95NbWvTzFobwn0toAJ8mlaN9OeVa9VcbWHVRIXk311wPYgc5aBsMi+3U+CVFP7dl20X6vWx4I980MwocoghonYnn9WKeCgKosvCKG2Py+i2Zyf9Xlta3hqIpWYT2fKrd8QY8UISzAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654815; c=relaxed/simple;
	bh=4CGw/1PvnUDJvkjWMHYhrozPrsYHsampv+X03gehpiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sBid/XG7NfyZUvCrFEqFrCH0k6L0VPPV4V/s+XdUUnyNgUyNADkHQY+IxVe6c9iaAJFLxTrfWSnWp8RPrZecSEn9priIrdpQlii+guvvz2aNbA3FMPh+ntKQbXpCoFUylAxL5zhWmPUiR6+CrTRgvZKdw+Q53vxRnSuV5WnTgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZIoacgQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398d171fa2so2707782e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728654812; x=1729259612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6woqody68cUC84IIe32w0d2+f4gfZf33Sz1RMVH8XKw=;
        b=QZIoacgQt3yCcQnLjZNIOHhMNw6B4XPpO+qZ9ntPsw3qTnRka7TE2/DGz9f2zP/u2v
         Fd4eomrJKunPpMVAJo5AEMaNlXo0wjtKgq4flo3154x5dD4e6y8c2qYJKnnXAmfuDyDU
         3TF532yE+591b0klHvPMYRhawXgwsW+KTy2nCJwKBWW9kxZ4++ThrUPSZihA6A8ECgVh
         nu7rWymgph+jFtMDASwcBfc5pUCSrGHL9IxaP5IhO00XllWKnV9Jibe4cALOhTbghox2
         Zyqp2vRbCRRHPw7K7BrhowV9KRFRcglnkhXzZnYBCr/m0CpU+k+RZdEQwJiIx04nPAIN
         5Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654812; x=1729259612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6woqody68cUC84IIe32w0d2+f4gfZf33Sz1RMVH8XKw=;
        b=NptI/DdbJ9172ZEcwL7MOTsVbf+O2Kablz7nZ/HLqIUxgAC/l0PB7UQ7ARw+XUZToM
         c5fTTiMflQQ/S6VtgkvB6CbWkHAzDFjCx1YQV0ER+D1GZp15V5JmNHjApGJtyyY5L9Rz
         vkFFG9x826VN77ygDEKO5X58VOjF4E0HpnZ+bEdmXRVU1m7VX+LSSxFA7eAS/SHneqb5
         AMhmpN8K335gRTw8CxYt3cclVhm56ZWGJnrvjaS58Tf0ldaAmXXVuDRAnqqhARLb2ryh
         49NKRDrn9FimovqO2ohy/jvvUFQnLKYz878VU1tte5hGC2+ZlHb/nqVWKSkZqtAlh3sH
         0bWw==
X-Forwarded-Encrypted: i=1; AJvYcCVUE0TA8k8v5uKPaUkMv8uNbW7YZcM3gLpyROyxtcsCptUa/IPvcBvN8+UMDz1aybHhUHHrznUTkkR4oABB@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyDRIza+sBeXnLmjL6/UCOPE8wW3QzNFTmRcAuqjgM0miELpx
	UpLIlAizVd1tcoe0cd9pb2w4O+NtFBwcDaWQfvRPYQxv5FwTAj9B
X-Google-Smtp-Source: AGHT+IF1i6OZ3IMhmPIiJVODJtOvoKEu9g13GBpsD9L3BC/d8paMgxWiW/fQudsOQuMXzdSgUMewvQ==
X-Received: by 2002:a05:6512:a8b:b0:52c:adc4:137c with SMTP id 2adb3069b0e04-539da3c67aemr1507101e87.20.1728654811505;
        Fri, 11 Oct 2024 06:53:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d784sm42747445e9.46.2024.10.11.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:53:31 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	yangyun <yangyun50@huawei.com>
Subject: [PATCH] fuse: update inode size after extending passthrough write
Date: Fri, 11 Oct 2024 15:53:26 +0200
Message-Id: <20241011135326.667781-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yangyun reported that libfuse test test_copy_file_range() copies zero
bytes from a newly written file when fuse passthrough is enabled.

The reason is that extending passthrough write is not updating the fuse
inode size and when vfs_copy_file_range() observes a zero size inode,
it returns without calling the filesystem copy_file_range() method.

Extend the fuse inode size to the size of the backing inode after every
passthrough write if the backing inode size is larger.

This does not yet provide cache coherency of fuse inode attributes and
backing inode attributes, but it should prevent situations where fuse
inode size is too small, causing read/copy to be wrongly shortened.

Reported-by: yangyun <yangyun50@huawei.com>
Closes: https://github.com/libfuse/libfuse/issues/1048
Fixes: 57e1176e6086 ("fuse: implement read/write passthrough")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Doh! force of habbit - fixed subject s/ovl/fuse

Thanks,
Amir.

 fs/fuse/passthrough.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index ba3207f6c4ce..d3047a4bc40e 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
 
 static void fuse_file_modified(struct file *file)
 {
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
 	struct inode *inode = file_inode(file);
-
-	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+	loff_t size = i_size_read(file_inode(backing_file));
+
+	/*
+	 * Most of the time we will be holding inode_lock(), but even if we are
+	 * called from async io completion without inode_lock(), the last write
+	 * will update fuse inode size to the size of the backing inode, even if
+	 * the last write was not the extending write.
+	 */
+	fuse_write_update_attr(inode, size, size);
 }
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-- 
2.34.1


