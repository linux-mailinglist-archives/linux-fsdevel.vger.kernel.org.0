Return-Path: <linux-fsdevel+bounces-45828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4CA7D134
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 01:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C5C3ACEF1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00171ADC8F;
	Sun,  6 Apr 2025 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsFq4f81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8D2914;
	Sun,  6 Apr 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743983903; cv=none; b=jMH2bcURj8+jcq7Q9/9yWOJ/le5k+976SVoUbce5YJ0M6Xsw48XaUT/vEdcfEWt98bkuIwhKXwe0dQejoKtXnWv1/pPit7Lit8CtYph9FZuGITeKRrRvJD+mBq/0znxoMl9cCob6veCzY2blEbp5HtmTcxLaUsr8Ymuz7jWcLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743983903; c=relaxed/simple;
	bh=3vJ0PhPQJDAHHBp34zlETqLTK59+q+zcQB9UoX1OA84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQCTkc5u7TDTubO7ouAMPAC7KlUhE2Ugfvit55MNc9Z3qbOiO7NUc7XUvVdUIN/BfmXhxEpCJkibwtHNMT5lECDVepSstJ6paiSb0H8CAK91vTgh96RV7G7EYkGk+UD9nftYd+wtStzjb/84DMSQd8ITeYrzDpwNY6EGORyoT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsFq4f81; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso2792425f8f.2;
        Sun, 06 Apr 2025 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743983899; x=1744588699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSPJ55mQnJHBWXMVfv1wTZBwCdfK1gZI3qG8kiSxktQ=;
        b=KsFq4f812N5xsvN4dfy/Pp1PsaH9KWVW6wBS9lQ9s6xfn1MbV4WewGPL24Wnp7VOjm
         gXF+Im+HGDRwuQitmfq+XItnfj7jbXTS6BOHrF9rsnABP8pG7K/NAJJuiGHC79SDBkV5
         jNEn5Aa0jYXP8egO4dZykZA/4qJFOTwFB1MdZyQI9yZgeMXezU0HTs9eK/ad3aBZ+W2V
         n3l20veJs5X3+WcOLiISBOB8ABbi/lDDC8Kagb9hhbm+gu1nRbWKyNPFBcjfC15zFOTL
         MQgsemsGh1Riv3Y6VYNrJD57FmtPja8crBLMXQw5OcN7Oi/H3oiunBAmVfXCpkj6D9aP
         vcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743983899; x=1744588699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSPJ55mQnJHBWXMVfv1wTZBwCdfK1gZI3qG8kiSxktQ=;
        b=ElCWRI3AdKLJp1VPLQgdzZuUGeac8R+Q0mmB4Rfl1HARflt8P9vclVgRLLO6mT43up
         nbnJf0OFVNYUczyJG0K5RYuGQMg5GP3Zp94lwsIM2ty2DgxDBVlUVqZ/rXsV3mMk28Pg
         fltZ1pH/76avUlUfr1KokYUfqLPdIQIm3+6l8jmA9cznKb8DL7DTGA0Cc1ORUXS2N3KJ
         LRqeir5KKJq4bHyFW31leqVIesoj+lpjqk41fGrldsPag7aYBuvCr5lbBoNjmGvwfl3c
         N+QjZMLd6PtGJTE1/uLpmuu365VFAgRwd8pCPElMJiqwwuhKtH2HWTLX1u2DH3n3l1H4
         /Jog==
X-Forwarded-Encrypted: i=1; AJvYcCV7zVTDelKXTl/L4Y5FCEjyYyaVMPfKnM1KjMZnfcbAP1jv8WaqYMCa4RlIk6ZSatxjkML4Rs+KTSYtj4wp@vger.kernel.org, AJvYcCVd+v5jzP3HTMpbS0l7v/3uW3sxgMPm9PV7ZgcyGhChMJdhwz2hQxIW/TZnkF4GMtSlZiN9ettgzw+8fUP5@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2SGLR6kDlkCfTIfavOtQuJthxAtejURzbfYZ5dmW/lmiC5ro
	XLfI1JBGVeOI7sjREW1clX8s9NLSvvStshuFbftaghXvUG95YUNy
X-Gm-Gg: ASbGncuY8zLur1eH4h73BYhdRuuSRLKLXFoMCIdvuCjDqU5pY9VTbnvrCgullU5T7w6
	2mwiM4MmDYtOo0UdmTiKsg8lCvKspsVr2IW11c65E0J0afTvqtzc1iMbt4rInz5R1/OLODxWPKu
	OK/0QO0adU8r9N/kEDIDSxLjj03tLsAz2dLGPgYrWx4YYS3xLTOLvmrZJpz1TvM/FQ7RO+7/uDH
	OAosXvvDPHbwaE0Gj9yz/wWi7qTQItjQ7K/0SZddztwneUnAeDnCNrvgSPe+iDCT5/OaRtySaHI
	QV4Gofg6KcAL61klJOGZTNsoJVCKLdLE3eUy9L3SBj4ZdxbI30804egVwe5QSnU=
X-Google-Smtp-Source: AGHT+IHE/mprPiDDQrjQanTxQzaFcKx+eLhU58wequg9acYfUBCLpa/iEq7/tkvYJd+8TWq0bbG36A==
X-Received: by 2002:a05:6000:1849:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-39d6fc00c82mr5829910f8f.1.1743983899331;
        Sun, 06 Apr 2025 16:58:19 -0700 (PDT)
Received: from f.. (cst-prg-74-157.cust.vodafone.cz. [46.135.74.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096b9csm10576598f8f.13.2025.04.06.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 16:58:18 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/3] fs: sort out cosmetic differences between stat funcs and add predicts
Date: Mon,  7 Apr 2025 01:58:04 +0200
Message-ID: <20250406235806.1637000-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a nop, but I did verify asm improves.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/stat.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..b79ddb83914b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -241,7 +241,7 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
 	int retval;
 
 	retval = security_inode_getattr(path);
-	if (retval)
+	if (unlikely(retval))
 		return retval;
 	return vfs_getattr_nosec(path, stat, request_mask, query_flags);
 }
@@ -421,7 +421,7 @@ SYSCALL_DEFINE2(stat, const char __user *, filename,
 	int error;
 
 	error = vfs_stat(filename, &stat);
-	if (error)
+	if (unlikely(error))
 		return error;
 
 	return cp_old_stat(&stat, statbuf);
@@ -434,7 +434,7 @@ SYSCALL_DEFINE2(lstat, const char __user *, filename,
 	int error;
 
 	error = vfs_lstat(filename, &stat);
-	if (error)
+	if (unlikely(error))
 		return error;
 
 	return cp_old_stat(&stat, statbuf);
@@ -443,12 +443,13 @@ SYSCALL_DEFINE2(lstat, const char __user *, filename,
 SYSCALL_DEFINE2(fstat, unsigned int, fd, struct __old_kernel_stat __user *, statbuf)
 {
 	struct kstat stat;
-	int error = vfs_fstat(fd, &stat);
+	int error;
 
-	if (!error)
-		error = cp_old_stat(&stat, statbuf);
+	error = vfs_fstat(fd, &stat);
+	if (unlikely(error))
+		return error;
 
-	return error;
+	return cp_old_stat(&stat, statbuf);
 }
 
 #endif /* __ARCH_WANT_OLD_STAT */
@@ -502,10 +503,12 @@ SYSCALL_DEFINE2(newstat, const char __user *, filename,
 		struct stat __user *, statbuf)
 {
 	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
+	int error;
 
-	if (error)
+	error = vfs_stat(filename, &stat);
+	if (unlikely(error))
 		return error;
+
 	return cp_new_stat(&stat, statbuf);
 }
 
@@ -516,7 +519,7 @@ SYSCALL_DEFINE2(newlstat, const char __user *, filename,
 	int error;
 
 	error = vfs_lstat(filename, &stat);
-	if (error)
+	if (unlikely(error))
 		return error;
 
 	return cp_new_stat(&stat, statbuf);
@@ -530,8 +533,9 @@ SYSCALL_DEFINE4(newfstatat, int, dfd, const char __user *, filename,
 	int error;
 
 	error = vfs_fstatat(dfd, filename, &stat, flag);
-	if (error)
+	if (unlikely(error))
 		return error;
+
 	return cp_new_stat(&stat, statbuf);
 }
 #endif
@@ -539,12 +543,13 @@ SYSCALL_DEFINE4(newfstatat, int, dfd, const char __user *, filename,
 SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 {
 	struct kstat stat;
-	int error = vfs_fstat(fd, &stat);
+	int error;
 
-	if (!error)
-		error = cp_new_stat(&stat, statbuf);
+	error = vfs_fstat(fd, &stat);
+	if (unlikely(error))
+		return error;
 
-	return error;
+	return cp_new_stat(&stat, statbuf);
 }
 #endif
 
-- 
2.43.0


