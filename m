Return-Path: <linux-fsdevel+bounces-45272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E0FA756B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E1B3B0A30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1B1D63FC;
	Sat, 29 Mar 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neJBBGMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648A2AE99
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258800; cv=none; b=hTUjCYxQyx4BPoS1xkWMrXTm9DZpIeUadHeUC70OPSPI9540VnYrd3S2FKDFn57smtoBaE3fqQT69zJUsTfBMtLYlItK/mFBywYODalv8l+zd9vpXc5b/7vRGWpcD+7kFG407Kap5Ci+RvoGTO2l2IRTUTFz5FN6fTq/obuA9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258800; c=relaxed/simple;
	bh=8ToMgMvdRX5HDptxbW5kzam5mHxd1yN7/AaVwvW9enU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlFA7hlzlYTl5icPFUXWT7uoEv7tXe4XsuNiWG1l7r511qaoKWhZPyIBBuv925B6IlSzfhOSXYKLVhCaRiDHLaA6rvDsxr5cxVpFpQ1tFb22V/2Sy9ZAOXj6YEzB7Pvtjo01o+U1unRZw7rdeiaY4pLZTJXngqfwxRhdDcFw0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neJBBGMq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so414648866b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743258797; x=1743863597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBnnmXCaajuutNxzgl9THxTO+ni6DZKbBfXSEp1bPDo=;
        b=neJBBGMqJZImoV1V8i3tQcgEMFAhPC5ptOf5kqRJVCKfN1QWEwHxxlxUMoZMl1SRHr
         BYMMynIXAZBKF+l4P7KPmLEKG+OLSOwILWjKsMFHAE4hj9vYrPrCUMbe+oANsrLuW6FG
         XQXIf52Te1xydEapOJxzDZ8K0EKT3Yhf600BRc5QFovcl/41MJkUUPMv1e+xBSYdW6sQ
         nSWC8EHhYLAgjt0i4aahUlgJ8W0nO/3TTke/KdNG1PHlVuOukjWsQIguHFdyggkEfWUP
         Gbocb098MKCPg67THrhfRnELcldj6SjBOOPK00G2DXhmIYWkUv27TeVS4E1wVjqvB/eF
         mY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743258797; x=1743863597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBnnmXCaajuutNxzgl9THxTO+ni6DZKbBfXSEp1bPDo=;
        b=xF74y3xQjvCzIxMXUE4KUJzLv8i5zIa3k1PUXTc2IOmTm57WhTuDIB19UZc5zhIQO/
         oCBK9xHQIoqypVvPmnFHI2EsVSQH7tOMlin0qmW4byUYw1FFo/4jm69tWiH8wDJo5PLz
         QPQf7dc9GTc9QqGbGGNNgkP9k9OV9ATxnq4Cp69Kw0QejvgBfp38a/m4p/WQ/VPcRHWD
         BbO6UybPT897+mT01BVGVHwfEiKdeJBgXCbNLmtVmd0JsYebtFmgOr+1CXC+lQsnRsvF
         zQWiREA28914yKOv2fZTeejn1czsqk9U3pgJ3XLi4LtMhhjWkLQV2McusQFdiKfcsI7E
         roXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9acaCep/C1aBEY0348yaPPNVkdyZy7M/leuDeYOogDIuFXfqH7In3wx9XtU//kYMQdIyCV+9c84RpdImP@vger.kernel.org
X-Gm-Message-State: AOJu0YwPoZNYK96fl81QPzZoWB4Ki6UE1RG+nb+NtsFBXrtvlUSKg1TE
	RTeTgdVBW+hZTNpcg9HhnSsmmAgEDMKe0CfbpqAc1oj9VfGZQ7h7MX2ipUADCxA=
X-Gm-Gg: ASbGnctYuAUP4engkwbFLYuLB8XpV0xd7XCu0SN+9t/IYR3YBWKZxZPffZ1lYIBbd8a
	4uDF77jOjgFwuWiZO2toNO40Kz+vVDtvT83vZDaTievuWpAhRfdmTtvXtJjg/3QNn8FvI8QK35n
	76KFgDlO9rx9+5QD/zdw2VqkOgx3V1WItVpmVYX3XgnORzEWBybY7EBss2CCilJ+Cl06OpVR6C7
	y8grLj6sHvcpk8WVYNlF2i/GufJI1SUz0N4WQjVt3bvQcqlMlkm/fZXP7OmtbYLzNeqo0LNVYCv
	BLt3dtCuccmu82qzPWgnMdxJ4bB41RNNcqhjF5WiX+Da1XUtAhkUvZqGeAcVv9XIRH5lK4IkYpG
	rdwTYIZKxOFrNqFmldDfAm5/Rf88m3XHvP2PIzKZKexg9AmIFH5ra
X-Google-Smtp-Source: AGHT+IECDHci8+eZzcNFB4mtBMPWCRrNjnEcrgSA4qdbb3sHvMa2aFdBz5KGxwZh8o+3X6SC1jntMw==
X-Received: by 2002:a17:907:728b:b0:ac2:7d72:c2aa with SMTP id a640c23a62f3a-ac738bf61demr215496166b.51.1743258796647;
        Sat, 29 Mar 2025 07:33:16 -0700 (PDT)
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
Subject: [RFC PATCH 1/2] fs: prepare for extending [gs]etfsxattrat()
Date: Sat, 29 Mar 2025 15:33:11 +0100
Message-Id: <20250329143312.1350603-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329143312.1350603-1-amir73il@gmail.com>
References: <20250329143312.1350603-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We intend to add support for more xflags to selective filesystems and
We cannot rely on copy_struct_from_user() to detect this extention.

In preparation of extending the API, do not allow setting xflags unknown
by this kernel version.

Also do not pass the read-only flags and read-only field fsx_nextents to
filesystem.

These changes should not affect existing chattr programs that use the
ioctl to get fsxattr before setting the new values.

Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
Cc: Pali Rohár <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/inode.c               |  4 +++-
 fs/ioctl.c               | 19 +++++++++++++------
 include/linux/fileattr.h | 22 +++++++++++++++++++++-
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 3cfcb1b9865ea..6c4d08bd53052 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -3049,7 +3049,9 @@ SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
 	if (error)
 		return error;
 
-	fsxattr_to_fileattr(&fsx, &fa);
+	error = fsxattr_to_fileattr(&fsx, &fa);
+	if (error)
+		return error;
 
 	name = getname_maybe_null(filename, at_flags);
 	if (!name) {
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 840283d8c4066..b19858db4c432 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -540,8 +540,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
 
 void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
 {
+	__u32 mask = FS_XFALGS_MASK;
+
 	memset(fsx, 0, sizeof(struct fsxattr));
-	fsx->fsx_xflags = fa->fsx_xflags;
+	fsx->fsx_xflags = fa->fsx_xflags & mask;
 	fsx->fsx_extsize = fa->fsx_extsize;
 	fsx->fsx_nextents = fa->fsx_nextents;
 	fsx->fsx_projid = fa->fsx_projid;
@@ -568,13 +570,20 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
-void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
+int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
 {
+	__u32 mask = FS_XFALGS_MASK;
+
+	if (fsx->fsx_xflags & ~mask)
+		return -EINVAL;
+
 	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
 	fa->fsx_extsize = fsx->fsx_extsize;
-	fa->fsx_nextents = fsx->fsx_nextents;
 	fa->fsx_projid = fsx->fsx_projid;
 	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+
+	return 0;
 }
 
 static int copy_fsxattr_from_user(struct fileattr *fa,
@@ -585,9 +594,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fsxattr_to_fileattr(&xfa, fa);
-
-	return 0;
+	return fsxattr_to_fileattr(&xfa, fa);
 }
 
 /*
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 31888fa2edf10..f682bfc7749dd 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -14,6 +14,26 @@
 	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
 	 FS_XFLAG_PROJINHERIT)
 
+/* Read-only inode flags */
+#define FS_XFLAG_RDONLY_MASK \
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
+
+/* Flags to indicate valid value of fsx_ fields */
+#define FS_XFLAG_VALUES_MASK \
+	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
+
+/* Flags for directories */
+#define FS_XFLAG_DIRONLY_MASK \
+	(FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT)
+
+/* Misc settable flags */
+#define FS_XFLAG_MISC_MASK \
+	(FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
+
+#define FS_XFALGS_MASK \
+	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
+	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
+
 /*
  * Merged interface for miscellaneous file attributes.  'flags' originates from
  * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which
@@ -35,7 +55,7 @@ struct fileattr {
 
 void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
-void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
+int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);
-- 
2.34.1


