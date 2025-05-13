Return-Path: <linux-fsdevel+bounces-48827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C7AB4F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9531B43CB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30622156A;
	Tue, 13 May 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWUtKsiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C31218599
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127913; cv=none; b=EHESEgqNU/PrBFqImIjVRUcQOgtiG5Um4j8WUFFr3Kb+w97Q2JFoBXyuceOqDVvUSXS3XoAsrwCXVyzxFwH4UFmCpSSLhEBSgJYC7KLpLvj6L5XVD28xAcxYZFNE1TVieG7boPKrDVZq2x83WAWayGt3sROunbX9oBLVDkzRnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127913; c=relaxed/simple;
	bh=6GRgC9l31t4YtW1WpN15HEtI//c4dan1yl5qtYWAaXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phgW2oWh/s9VJqPGaC1Dtr6M7C6Fq18/g7Af19cP5iNC3i20xHMCa8cq6WWJkJ342uueOc/ZebJ8TUDc1LwoI6SzjYYUFRu8AZXwXPzLc5365Izh8jBm8BcsTJAGxguKc25EmuESZ07lcQPsjRP7iltCQDmvRy2LBYfFPRNAnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWUtKsiy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOc7n03QtvhEu44iPpxkG92PTjRYJg6Nm8X16D2kY0E=;
	b=JWUtKsiyOCSkp9b7jELLmcblSS9joc79PNpGDMYcXiJspk8K6DlRHwzemymbyyhUouMEBl
	PR9iTTj4h3XwyWSxkzc/67IXu1/IyPv0K3+cUypYnES0BlmtGmwO3nkdQzDcSvlNj2JmDb
	wbVXSLymH5ZdBYX3TLU9OMmqCj4kT+Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-HFoi9jshMmuGp1lrCxnCeg-1; Tue, 13 May 2025 05:18:26 -0400
X-MC-Unique: HFoi9jshMmuGp1lrCxnCeg-1
X-Mimecast-MFC-AGG-ID: HFoi9jshMmuGp1lrCxnCeg_1747127905
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43efa869b19so36707395e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127905; x=1747732705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOc7n03QtvhEu44iPpxkG92PTjRYJg6Nm8X16D2kY0E=;
        b=q9cPO1x/mEygSD8WSTAcPdWEn8kYL3Ip08dBnWCYyIYqrpYpV48s4rN/Mlr5kgu6P6
         lBPsB9XB/QSOvLopBRlYXz78WTnOMNOy4sliGdso9vR9oz/K75yWqwZrFdGs5+Ci9FZB
         OTkHPmfvLybIfj7WOQAnzcEfAsoesbUB/oJIN0+iC4xlllfNH4dnJFr3TwV3ERdHh02x
         Cd07GCzUW4AvJby8SyXMc+KGeOy5CQpYnTZHTCVe9tGHyAp2WIgv37g6dGMmJhZSNtQP
         tThmHt7PqTYqZ0/ffy2gH3yY5gEuSl44BEV5aEGF7wGTnKZBEH10B4Swp+uiLyQGfcuW
         aVLg==
X-Forwarded-Encrypted: i=1; AJvYcCXmIJ1AjrFe+r7KK7DAagALgR4roEdL1Z1+8XX5XwR2wovijbMo59FTDJSMAmSAcE3tlYzrFuToduIaVj/I@vger.kernel.org
X-Gm-Message-State: AOJu0YxGB9lccb45vi2HNU93wGW6ColUwyIJTPx9zn8PVUDKRdXd4E+N
	qI+ZeM+I6HoV/gcrXEhEhWU8+5bbXGPMYPypJVvOTpvILuJZJ+UTWYxPHuUNsSdQkaF27/rXmf0
	l+00RlNTrdUPRrVzVATNlndyw6aRpCCVAKCbB0jwtjryElxr7aGG+MUzu2Zr3Jw==
X-Gm-Gg: ASbGnctaExeF0cQ8Bg912Y+3vF1yeVfBI/72g4+lCJoCLc2ttE1fVAaV/0kUnVrZpbr
	odN7wpG+RMILABsgdlfUDp8Ys8kC1v1KFshYYTQwHPQJJv7BeHPQvP6h+L6rWXmtTao00AXPlXO
	KTgyHYWuPM5LL9MHSWAI+mZ046YZRkzAIrP9oJlSc2Q71yxDRyGbT7Ub5lzb1owzf57gSY9MPlH
	gvvSdD5rVL6Dv3c8S9XpBf9jBEp/0se9ol0Am7w3EoBqObxwx7i6TF68vJpZykhGrNAt+G4k868
	DbrdMs8f7oj+xjNOOziuMyDxoRE7q6BI0Y17SA5RjEm0uwM=
X-Received: by 2002:a05:600c:4454:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-442d6d44bd0mr165938575e9.13.1747127904718;
        Tue, 13 May 2025 02:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiuvTxW0gPiYb5Yeg/YAPZpfvdIILgd83canCiQJJ8hwGNTheApWOvMPsjwENNn935UE4Tg==
X-Received: by 2002:a05:600c:4454:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-442d6d44bd0mr165938225e9.13.1747127904260;
        Tue, 13 May 2025 02:18:24 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:23 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:58 +0200
Subject: [PATCH v5 5/7] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-xattrat-syscall-v5-5-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=6GRgC9l31t4YtW1WpN15HEtI//c4dan1yl5qtYWAaXk=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vHeeSvx1XJ17VoznhbT1nNa68Vxah3ftytP4y
 xmmWH2hyqOjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARCziGBkWnup90+qj/jDX
 J/7rpgO7jA7djNJlqpoYIWnU9Pi2iqsMwz9DVwXDCxlLHq56tKRp98R9l+e5LHztcHHptMMCT7x
 vsnLxAQC/ekWI
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Future patches will add new syscalls which use these functions. As
this interface won't be used for ioctls only the EOPNOSUPP is more
appropriate return code.

This patch coverts return code from ENOIOCTLCMD to EOPNOSUPP for
vfs_fileattr_get and vfs_fileattr_set. To save old behavior
translate EOPNOSUPP back for current users - overlayfs, encryptfs
and fs/ioctl.c.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/ecryptfs/inode.c  |  8 +++++++-
 fs/file_attr.c       | 12 ++++++++++--
 fs/overlayfs/inode.c |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 51a5c54eb74026d8b2deec6e0608f3d2b3e9c092..6bf08ff4d7f71c5223b90f4cde57e380b68260fd 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1124,7 +1124,13 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 
 static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
+	int rc;
+
+	rc = vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
+	if (rc == -EOPNOTSUPP)
+		rc = -ENOIOCTLCMD;
+
+	return rc;
 }
 
 static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
diff --git a/fs/file_attr.c b/fs/file_attr.c
index d9eab553dc250f84075ac74c1c7d8d6fd6588374..d696f440fa4ffcba8985cc4bfe22a1c0e612ac7c 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -79,7 +79,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	int error;
 
 	if (!inode->i_op->fileattr_get)
-		return -ENOIOCTLCMD;
+		return -EOPNOTSUPP;
 
 	error = security_inode_file_getattr(dentry, fa);
 	if (error)
@@ -239,7 +239,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 
 	if (!inode->i_op->fileattr_set)
-		return -ENOIOCTLCMD;
+		return -EOPNOTSUPP;
 
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
@@ -281,6 +281,8 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (err == -EOPNOTSUPP)
+		err = -ENOIOCTLCMD;
 	if (!err)
 		err = put_user(fa.flags, argp);
 	return err;
@@ -302,6 +304,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 			fileattr_fill_flags(&fa, flags);
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
+			if (err == -EOPNOTSUPP)
+				err = -ENOIOCTLCMD;
 		}
 	}
 	return err;
@@ -314,6 +318,8 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (err == -EOPNOTSUPP)
+		err = -ENOIOCTLCMD;
 	if (!err)
 		err = copy_fsxattr_to_user(&fa, argp);
 
@@ -334,6 +340,8 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 		if (!err) {
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
+			if (err == -EOPNOTSUPP)
+				err = -ENOIOCTLCMD;
 		}
 	}
 	return err;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 6f0e15f86c21fc576fe1679e977597bd9f817e36..096d44712bb1130fd3e9673a61747b0fbf877d25 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
 		return err;
 
 	err = vfs_fileattr_get(realpath->dentry, fa);
-	if (err == -ENOIOCTLCMD)
+	if (err == -EOPNOTSUPP)
 		err = -ENOTTY;
 	return err;
 }

-- 
2.47.2


