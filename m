Return-Path: <linux-fsdevel+bounces-45273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C732EA756B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C91170F7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC961D7994;
	Sat, 29 Mar 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWU2n00M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C251922FB
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258801; cv=none; b=L8+icdMR6V+R+tZdovD0IZvVn/PYG8qcu4XvlVozG7GXgQANEIs6R7zdtlU++oXTBrpjO7zNRZskQKTEMzaRY1PUwfSRy37svhkZLbredC6pRCuRzsSeF9fwQ26rirDye8Zwps4bJXVxhhzucJg2VSwSwqdclgIm+35gMlJDKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258801; c=relaxed/simple;
	bh=aKXvQl3nTwBgKjff3KkixCScXEFk89Di1EbNJO/uZ0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyShAQo9jdAwdhuLVVQLIQdMlx2enizO6mCpj2K86dh7m2cJqcPGHeS/8xKqtO28NpaAjKmF4M8CGQ9tnake/AHVTNtymWAWn3oDDn8eGTm0TLMZ3VjCFHRuGUM8p/tL6Hu6X15Oz++CycbhRhG7+aEQGXUxDns7YEQjGCTJBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWU2n00M; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so514140766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743258798; x=1743863598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp0UZvrYYY9G2UMTNDVLuSBTxzhAQodKL+hIFClTE/A=;
        b=GWU2n00Md4ofZahCyYsqq4cxwP5VqLLsaQW6HooBj6Iy8Ywqs78zfFBhva3n2mj41I
         vJ/1Lg42eW4j/HPgWpd/fEQE8fCaEl4D2g/fW4Gu6KXI8KQOf8iTBAV3fxwe3Sfph9oo
         ffWdToDXe8uXk3IL7YGouw3T2hRC7QEIwpK9XeKdoJVB/9EoQFy3K2tJEabLrzJrAWHz
         ZunbvwRXsU7WrRaOpWO7mVPBffYDqS/hCvu9ikhhSo8WonQZtkfBlyZVfu0biKO2L2AE
         41IlFYEh/vDB7UgBUrfZk0KJVkFoqTAeSY+rJk4/5n/6S86fRBDg24533gmAjI3UM3uG
         TJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743258798; x=1743863598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp0UZvrYYY9G2UMTNDVLuSBTxzhAQodKL+hIFClTE/A=;
        b=UJFrdAu8JkuS8lkCUEVOMv/aj9m4UDOwtTH/pWFhSHSf06XfpV8v9YpOfs+cUIfBdW
         ABCtdURyZq5bxY9kx0EcURS+TRr90DyodprJ8vcRS07sUe5ki2wfjKeZSgAdECzFMzY7
         vU+Umx2deYgMlpfWgMGLXrcHR59aWPR14ZV8d6Zift4+eByRcz/teL913Wl8KzwStCu6
         wxTqCxbopzorTTou5RzRIhgcLW/yEGqzeT9rRdbKxQmJcqzMXiYL6qjvu0hAWIB2TGYN
         JxD+g8Pa3XIY8YnrS4v00KV27MHcbpLlx6B5nZy7Wf3ASTavzL1JRk/QWmQBIABcajv8
         D/zA==
X-Forwarded-Encrypted: i=1; AJvYcCW0yB4T+tSP0BFrtB6fAD3sJFOuVekmVGumt5sFkoqr2WHfO144Wy0T+USgBDiDhUKK1um0yT4EdpIXEfjO@vger.kernel.org
X-Gm-Message-State: AOJu0YxNK45j5UzJaNZx3m44YLD2J6j8zYHO+GcnrPwYwxnfZd6xkMXL
	BbOyHALbCzjSl9ZoN3IXJFze3jkAyTPA1FtFWjEaoD2rvb6njF3BQIb1dyWvxxc=
X-Gm-Gg: ASbGnctAEJirQMjxJ/hQt2VL1pKqTYCRRvcC6UQJ3SQkKrCutEOnvPwGSCDQLT6UKUp
	SAiJUCG0qQkhlwqbF7A3loT7M5l6Cq3LRE9N8AYiHpNm7RXxpnDgAl3IXYJNEYuDUBuK4xc4XWw
	1FzcEnMzvQsIKkFYI3o75+U8Loy6nt+Q+JeNVZyKBvdX7YZxtQb99UrOtermbwaIbN9sEdiSD8h
	Qigk8hcr1cIWGYb0VqBzXDS8vQ0b3BJCfdOBs86suCq94KSqghWhti+p+zQZczh+MDafeeUDRYp
	Ug7CCHCZPZMFWqV3ZQUXT1HT+pZ0lRrsvQqTp+TlGBXAxzyHKcZuBztoJpKK5q85xeMCi1v96Z6
	mg+I5kQbB7OLLi97iEtc7b1zhFUKbaehse2fp7YTuQQ==
X-Google-Smtp-Source: AGHT+IG/BVrq5Ae11dKdP7gYrvtz7AZKMIh++JbQ1EV/4v5gHoX9avGliyVxE6SagKZDJboxIiH8RQ==
X-Received: by 2002:a17:906:ca4b:b0:ac7:391a:e2d3 with SMTP id a640c23a62f3a-ac7391ae45fmr207224966b.58.1743258797438;
        Sat, 29 Mar 2025 07:33:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719223e12sm344871866b.14.2025.03.29.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 07:33:16 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/2] fs: add support for custom fsx_xflags_mask
Date: Sat, 29 Mar 2025 15:33:12 +0100
Message-Id: <20250329143312.1350603-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329143312.1350603-1-amir73il@gmail.com>
References: <20250329143312.1350603-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit

With getfsxattrat() syscall, filesystem may use this field to report
its supported xflags.  Zero mask value means that supported flags are
not advertized.

With setfsxattrat() syscall, userspace may use this field to declare
which xflags and fields are being set.  Zero mask value means that
all known xflags and fields are being set.

Programs that call getfsxattrat() to fill struct fsxattr before calling
setfsxattrat() will not be affected by this change, but it allows
programs that call setfsxattrat() without calling getfsxattrat() to make
changes to some xflags and fields without knowing or changing the values
of unrelated xflags and fields.

Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
Cc: Pali Rohár <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ioctl.c               | 35 +++++++++++++++++++++++++++++------
 include/linux/fileattr.h |  1 +
 include/uapi/linux/fs.h  |  3 ++-
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index b19858db4c432..a4838b3e7de90 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -540,10 +540,13 @@ EXPORT_SYMBOL(vfs_fileattr_get);
 
 void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
 {
-	__u32 mask = FS_XFALGS_MASK;
+	/* Filesystem may or may not advertize supported xflags */
+	__u32 fs_mask = fa->fsx_xflags_mask & FS_XFALGS_MASK;
+	__u32 mask = fs_mask ?: FS_XFALGS_MASK;
 
 	memset(fsx, 0, sizeof(struct fsxattr));
 	fsx->fsx_xflags = fa->fsx_xflags & mask;
+	fsx->fsx_xflags_mask = fs_mask;
 	fsx->fsx_extsize = fa->fsx_extsize;
 	fsx->fsx_nextents = fa->fsx_nextents;
 	fsx->fsx_projid = fa->fsx_projid;
@@ -562,6 +565,8 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 	struct fsxattr xfa;
 
 	fileattr_to_fsxattr(fa, &xfa);
+	/* FS_IOC_FSGETXATTR ioctl does not report supported fsx_xflags_mask */
+	xfa.fsx_xflags_mask = 0;
 
 	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
 		return -EFAULT;
@@ -572,16 +577,30 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
 
 int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
 {
-	__u32 mask = FS_XFALGS_MASK;
+	/* User may or may not provide custom xflags mask */
+	__u32 mask = fsx->fsx_xflags_mask ?: FS_XFALGS_MASK;
 
-	if (fsx->fsx_xflags & ~mask)
+	if ((fsx->fsx_xflags & ~mask) || (mask & ~FS_XFALGS_MASK))
 		return -EINVAL;
 
 	fileattr_fill_xflags(fa, fsx->fsx_xflags);
 	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
-	fa->fsx_extsize = fsx->fsx_extsize;
-	fa->fsx_projid = fsx->fsx_projid;
-	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+	fa->fsx_xflags_mask = fsx->fsx_xflags_mask;
+	/*
+	 * If flags mask is specified, we copy the fields value only if the
+	 * relevant flag is set in the mask.
+	 */
+	if (!mask || (mask & (FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT)))
+		fa->fsx_extsize = fsx->fsx_extsize;
+	if (!mask || (mask & FS_XFLAG_COWEXTSIZE))
+		fa->fsx_cowextsize = fsx->fsx_cowextsize;
+	/*
+	 * To save a mask flag (i.e. FS_XFLAG_PROJID), require setting values
+	 * of fsx_projid and FS_XFLAG_PROJINHERIT flag values together.
+	 * For a non-directory, FS_XFLAG_PROJINHERIT flag value should be 0.
+	 */
+	if (!mask || (mask & FS_XFLAG_PROJINHERIT))
+		fa->fsx_projid = fsx->fsx_projid;
 
 	return 0;
 }
@@ -594,6 +613,10 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
+	/* FS_IOC_FSSETXATTR ioctl does not support user fsx_xflags_mask */
+	if (xfa.fsx_xflags_mask)
+		return -EINVAL;
+
 	return fsxattr_to_fileattr(&xfa, fa);
 }
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f682bfc7749dd..93102423b7c95 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -44,6 +44,7 @@ struct fileattr {
 	u32	flags;		/* flags (FS_IOC_GETFLAGS/FS_IOC_SETFLAGS) */
 	/* struct fsxattr: */
 	u32	fsx_xflags;	/* xflags field value (get/set) */
+	u32	fsx_xflags_mask;/* xflags valid mask (get/set) */
 	u32	fsx_extsize;	/* extsize field value (get/set)*/
 	u32	fsx_nextents;	/* nextents field value (get)	*/
 	u32	fsx_projid;	/* project identifier (get/set) */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0ae21596e25a5..5c35c415ca8fa 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -145,7 +145,8 @@ struct fsxattr {
 	__u32		fsx_nextents;	/* nextents field value (get)	*/
 	__u32		fsx_projid;	/* project identifier (get/set) */
 	__u32		fsx_cowextsize;	/* CoW extsize field value (get/set)*/
-	unsigned char	fsx_pad[8];
+	__u32		fsx_xflags_mask;/* xflags valid mask (get/set) */
+	unsigned char	fsx_pad[4];
 };
 
 #define FSXATTR_SIZE_VER0 28
-- 
2.34.1


