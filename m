Return-Path: <linux-fsdevel+bounces-48824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D27AB4F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5538C1528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3221CFE0;
	Tue, 13 May 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hll8SPtX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E521ABB1
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127905; cv=none; b=VtOu2jpvNOZoBp2KolNk1ZvjvZaod+HN/bSyXm+h/SiMbmQcXrGk1Z9hiK2XksattJZYDPPn1fnirFvRv7qxnD+djmbIw6+4IwN5dToBSNRDvA0aTOzaCeTjnvGSkhpgpaFui5SdknPfIAFOZ4O4ucQVUhM5c6c9SD2htPy2uDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127905; c=relaxed/simple;
	bh=YQGIdXvgchaWb1V6UiKUwEOK/o3C4y9T6tou+r20L0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4alYoeMV85/aaoTk2Oj632bXDE3q6IW6h5ouhdfZXGODGLIdoQCS5MmGU9q1IW8VhP9qz2c8uHSli1HVbOfMiSV8lCqfx+PrrJv1h9AdwYzykRHoopJJlAGPP6eVCDZxxe5kdxpELUD7CBGrinpsyeTogCfOpvAZTCCUpBZaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hll8SPtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQLwPqXkUI6z4QQX8G7LIPfd+304h8Dijb2vEngn3fA=;
	b=Hll8SPtXtIHdpB1Y1o37ZPtIPg/s7zUPaUloeoGohwoNCNX88ZzsZinpZ3CZWxxb1al+07
	f1wl3j5y4trT7mOjGnUqwG6CWcMXRdR/UgN2MYzLQ9fwR/czbVRUSrTD2KMvFQPCoobJlo
	DzE6k9MbAzJTL8AIS8R9a79SCeVWWAY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xisw9pg7PtCAz0a6usrySQ-1; Tue, 13 May 2025 05:18:17 -0400
X-MC-Unique: xisw9pg7PtCAz0a6usrySQ-1
X-Mimecast-MFC-AGG-ID: xisw9pg7PtCAz0a6usrySQ_1747127896
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442cdf07ad9so22262725e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127896; x=1747732696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQLwPqXkUI6z4QQX8G7LIPfd+304h8Dijb2vEngn3fA=;
        b=tk4XI/w/T6886q2sYEUwwdMhZaMAcq7/ZibrJW2Tyc9ulTDFkchCS15uMCGCRKKP3d
         PUp73zVISJPVZsHhPy/dsLb+WSsos6mFLGEg7/ajYp/fHHDdRb7S1CaehP7NOAsLP+cx
         IcxH/ARXW3tbFNzuOwrdYXy+he0hi6ELl9sVZH623Kyyxy9AfpkJmQtDdVzoFlDmUmz3
         KaPfkJlxq0XpWUPv7RGND5p4Lh+5ssIXoooYZZD5rIma5rWudPByijbr/UA19GRU2HA2
         IZHi5pic/XidZwGrsqKpcqJqS92yXVmMqqn/8l6kT2jnHeqmUNUWZZHXqovuWlrPLyb2
         DoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Anv1RAlaWtkiQ8RFB44Rqy3eUdbozjYCpemOLgy1pvI9rGCyq8EaXo4CG2vvovCD4lShrE8dgqH4OUax@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4nCl5Q9p87xR9Ti4DUCF7YQutRlUH0N0lsuyR5Yj205z1P8o
	e/khfsahSrIZB9eLDHH0VTo8aczMjEdiv11TMXWjgmkSgO4deVrhShocdPDu/rwJnrs8lmwx//w
	vBC3aCkbn5LYgxK2mdBuemCGtOMJnpqC5r1r6fLSDmS82uUUQECUUh8STGSQVBw==
X-Gm-Gg: ASbGncvT2BrVdUsDQxOhMJekufhtrkPiWVUsJYCz5ge79+KKUTEXxeCSTwqRoqhYxd7
	nUhVxpWW72B7RIZDPXhqqV4WqGlqPUlnAr0zh9esMTicTolMzY/MebFo48z65qAEUUkiLG7Zohn
	Rr8SexzT9sPWZn9uwL/iR0IiaxAVxVjW6zeor/pAWqA/KtiEaI2yU9wUwxwkLtJcByZuUkbpxhL
	YT30SOsoarAcAKbIlvx5Nf3K+N9REjZn2bbPQVPofw5WhfhjD65/kwhclE9dIf2Tf559EUIkKyt
	pKsc+NFKY0WLPuuwXuE69pZFbQYJ9Cn9Z4hUHgnYfhC5IaU=
X-Received: by 2002:a05:600c:3c8c:b0:43d:224:86b5 with SMTP id 5b1f17b1804b1-442d89ca4f8mr121131465e9.4.1747127895988;
        Tue, 13 May 2025 02:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgkQ6lr6jSThr2Cb3q6ZMQrTYHBuqnvQFthxFwxp9l7aEmx3rs55WDKKU2lMzSuNkJYBOxWQ==
X-Received: by 2002:a05:600c:3c8c:b0:43d:224:86b5 with SMTP id 5b1f17b1804b1-442d89ca4f8mr121130905e9.4.1747127895389;
        Tue, 13 May 2025 02:18:15 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:14 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:55 +0200
Subject: [PATCH v5 2/7] lsm: introduce new hooks for setting/getting inode
 fsxattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-xattrat-syscall-v5-2-22bb9c6c767f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5418; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=YQGIdXvgchaWb1V6UiKUwEOK/o3C4y9T6tou+r20L0U=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vF3LC9luzDZOZnCaUM3c/WPNxAMdNf8KZT2O5
 y9vqDzGfKGjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARMKmM/zhqWy5qqrd8PO1
 /vv/OiXxZr/F9nBPzWTMWJI18d+cxMJ8RoZXGf8r1h+awrr7cHvWqX9t5UWFz++c4rvw7aXBssS
 IVQJsAGi4SHY=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Introduce new hooks for setting and getting filesystem extended
attributes on inode (FS_IOC_FSGETXATTR).

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c                | 19 ++++++++++++++++---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 16 ++++++++++++++++
 security/security.c           | 30 ++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 2910b7047721df893540ff8a7c992558390eaa3a..be62d97cc444a445deac1c8ac8331f4a3766126a 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	int error;
 
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
+	error = security_inode_file_getattr(dentry, fa);
+	if (error)
+		return error;
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
@@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		} else {
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
+
 		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
+		err = security_inode_file_setattr(dentry, fa);
+		if (err)
+			goto out;
+		err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
 	}
+
+out:
 	inode_unlock(inode);
-
 	return err;
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a59a67de4ace85b93b1a878131f60..9600a4350e791f47006720765c199e35d3abafd4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
+LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
+LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22cd11480c38148005ed778b7af1bd..d2da2f654345b36b20fbe68ce11468ca4a55d8b3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
+int security_inode_file_setattr(struct dentry *dentry,
+			      struct fileattr *fa);
+int security_inode_file_getattr(struct dentry *dentry,
+			      struct fileattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1053,6 +1057,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
+static inline int security_inode_file_setattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
+static inline int security_inode_file_getattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index fb57e8fddd911bbb417ed2e7db443979bf611f43..09c891e6027dc1803a3af024b2f676e263da8aec 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
+/**
+ * security_inode_file_setattr() - check if setting fsxattr is allowed
+ * @dentry: file to set filesystem extended attributes on
+ * @fa: extended attributes to set on the inode
+ *
+ * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_setattr, dentry, fa);
+}
+
+/**
+ * security_inode_file_getattr() - check if retrieving fsxattr is allowed
+ * @dentry: file to retrieve filesystem extended attributes from
+ * @fa: extended attributes to get
+ *
+ * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_getattr, dentry, fa);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry

-- 
2.47.2


