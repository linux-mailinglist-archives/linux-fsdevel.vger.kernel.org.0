Return-Path: <linux-fsdevel+bounces-48823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA09AB4F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E30165B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB121B9D1;
	Tue, 13 May 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STy2oJi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5C218587
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127902; cv=none; b=qYhyYPFZ0DZG3ngrloOljShSACmDbIF9WmDivbJ/TkWGMXVFDfAxuXttCSL8wYw+EYRPPJnQZ5TkAiY+5RRGdnVG4r1pGpvNzphE7GrXtA+Emk1XE3acUohqMBQmbxpgJKCTOgct9+rC0dwQEhI+fmMBDg4nEf7BuNTkGLsdaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127902; c=relaxed/simple;
	bh=lWnpmRGbimw9Ccwg9DRdBJUFR0Hwxn4Kj8mLRBOmaRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhXYhLlqFjwIZ74jOo3iUdLJrSeTauJydsYbrnwktTnFR3huuMzftFIG6l0Vq+gUpb+2U5nBa3hMi63LlBTvynIjYREWX//QtlHyOIBD83+pXLOZ+sX6BdvnvhQl+VRKM62hi9Z/STHMiH1HPml0Yh57qo8sbMgoq4MOMOyh4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STy2oJi3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOzCZLZ8C63sKEIEu8NsBxg+KeZh/fdqLcOoc3mUKBU=;
	b=STy2oJi383WW27FxXVYQRvfK64+RAZR2wuhWmjNH4i42SPHPzuDpqeyK06+uBSO/gGwg51
	NnluNOV+UuSdcpuIBIZkE42h/qCi5Iz/G5XR2MctQebW7VtT1iicosfS1Q/bk3EfjZXWay
	J2r1zX6Z5AwtTk32+pzOAZPNBMhX9NY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-iCze05RsOYW1Fzigj15-mQ-1; Tue, 13 May 2025 05:18:13 -0400
X-MC-Unique: iCze05RsOYW1Fzigj15-mQ-1
X-Mimecast-MFC-AGG-ID: iCze05RsOYW1Fzigj15-mQ_1747127893
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43efa869b19so36705845e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127892; x=1747732692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOzCZLZ8C63sKEIEu8NsBxg+KeZh/fdqLcOoc3mUKBU=;
        b=R1WL7PMW4sziCbOEJQhBcniaekVUu3wunveMP9MM5V8yhbT+0uBZykTSksqCZfOQ+c
         b2Z24tQZwVml6YLWg3QsEec0X8mWZw/rizGLzJ3pdQqEANKYUtQAC0Ulalo9qnvavBEv
         +YT73szc+DeH8YrjwwcajKS/B5hCTc+4wVb0QtGwJr/nqjbfvPY9jlEGz13J5uYlbpRb
         EWD6JAF7OLIMMfC0RqNkPKtBIrWFDQXilQLjjIWrBwo2u/cZepDp4+RzQ/IEZotAhM0m
         MaoSSNgCYUoNdF6OGLM244K4SbQ9ZFSR5YA4MkA3qEE33UlFJ05/icnBJnNI9llCADre
         8ivw==
X-Forwarded-Encrypted: i=1; AJvYcCXQsZjNJbMUdaKpQA0sncE+oMq3YQvQHNxDdC0V6NmxEONaYkIjA+waC68k1TWj8nq+hoK3SbDMS0TY2aa+@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCExEs6dkDJaeg1HgWFWtw+uAHE8a6dyebInpoTeIDjaKBRca
	r0eAnn+lxgGQ1kefNQnGZFnnVx5BcCLb7KUPTeEo71AFnMJ5wRMsmh428Y7PAwbDmMCkSMlWsiH
	Q2xjAQz2DjQrPIoU0ff+3dnHdoxsozOzK1Uzw1CoFXlBFl3rhgpNrXJ0fPGbgqQ==
X-Gm-Gg: ASbGncvWMaaW2i6tah5D0WvS9Dk6Rr1bLrdbJ40qtvMsreKigaw+cqNWyhT1B1Z70mK
	fgzLwezhbpX0G7XCIZwIT/W4k9/cRkXRPAyVBF1M9Atlir7P/Y/uMCAVqKpIVqzL+cYOa0O3rmj
	o9MBZBDwQK7Mn7Si8LgFK5oyQrED8qEZrY+bFuH4lCFcjpqiot2ILMQagomoMPPsyv1SWYsLLnm
	J7YInWABOnso9gzn8UBBloH3ZkT0XGY/apMyIglbXCZhKsOcakOCRA9x/y6Igyz01cwForKJSPB
	RDdDOMFppjTyxL7kifSRBrbKFhSQob7oVcWiMyFHltmmIn4=
X-Received: by 2002:a05:600c:8519:b0:43c:e481:3353 with SMTP id 5b1f17b1804b1-442d6dacbdcmr169707295e9.17.1747127892299;
        Tue, 13 May 2025 02:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBuJrtbmvMX9xwpvAxClBheb2s3ohv9cGy2aD4ig7ITjNjphrAXpH8BqrKzkCdOaBQ+kwPMg==
X-Received: by 2002:a05:600c:8519:b0:43c:e481:3353 with SMTP id 5b1f17b1804b1-442d6dacbdcmr169706665e9.17.1747127891729;
        Tue, 13 May 2025 02:18:11 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:08 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:54 +0200
Subject: [PATCH v5 1/7] fs: split fileattr related helpers into separate
 file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-xattrat-syscall-v5-1-22bb9c6c767f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20425; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=vlFp/kLaUfFXsyM4cL1jhHJcu0Pt3JZYRE4Ehh6SGDM=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vHn9IktOzAjg7rM+cT7S23P6Xwmxz3vKp3W4B
 IjoKqm1WnaUsjCIcTHIiimyrJPWmppUJJV/xKBGHmYOKxPIEAYuTgGYyMEnDP80dwd/37JjnnOF
 U2yAg5GN2cRFKl6uAZqv5LP6/ok1Gn5n+M1my1ThejzLQaXl+AzP2BatbBfzCJFHT78lnHiTWrb
 3LwMA1ZlCMQ==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@kernel.org>

This patch moves function related to file extended attributes manipulations to
separate file. Just refactoring.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/Makefile              |   3 +-
 fs/file_attr.c           | 318 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ioctl.c               | 309 ---------------------------------------------
 include/linux/fileattr.h |   4 +
 4 files changed, 324 insertions(+), 310 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 77fd7f7b5d02478621f06304e447cc4a387a7167..2f1daaea86da456672234cf4df35e63e39a3e71d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -15,7 +15,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o
+		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
+		file_attr.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/file_attr.c b/fs/file_attr.c
new file mode 100644
index 0000000000000000000000000000000000000000..2910b7047721df893540ff8a7c992558390eaa3a
--- /dev/null
+++ b/fs/file_attr.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/security.h>
+#include <linux/fscrypt.h>
+#include <linux/fileattr.h>
+
+/**
+ * fileattr_fill_xflags - initialize fileattr with xflags
+ * @fa:		fileattr pointer
+ * @xflags:	FS_XFLAG_* flags
+ *
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
+ * other fields are zeroed.
+ */
+void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->fsx_valid = true;
+	fa->fsx_xflags = xflags;
+	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
+		fa->flags |= FS_IMMUTABLE_FL;
+	if (fa->fsx_xflags & FS_XFLAG_APPEND)
+		fa->flags |= FS_APPEND_FL;
+	if (fa->fsx_xflags & FS_XFLAG_SYNC)
+		fa->flags |= FS_SYNC_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
+		fa->flags |= FS_NOATIME_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
+		fa->flags |= FS_NODUMP_FL;
+	if (fa->fsx_xflags & FS_XFLAG_DAX)
+		fa->flags |= FS_DAX_FL;
+	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+		fa->flags |= FS_PROJINHERIT_FL;
+}
+EXPORT_SYMBOL(fileattr_fill_xflags);
+
+/**
+ * fileattr_fill_flags - initialize fileattr with flags
+ * @fa:		fileattr pointer
+ * @flags:	FS_*_FL flags
+ *
+ * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
+ * All other fields are zeroed.
+ */
+void fileattr_fill_flags(struct fileattr *fa, u32 flags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->flags_valid = true;
+	fa->flags = flags;
+	if (fa->flags & FS_SYNC_FL)
+		fa->fsx_xflags |= FS_XFLAG_SYNC;
+	if (fa->flags & FS_IMMUTABLE_FL)
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+	if (fa->flags & FS_APPEND_FL)
+		fa->fsx_xflags |= FS_XFLAG_APPEND;
+	if (fa->flags & FS_NODUMP_FL)
+		fa->fsx_xflags |= FS_XFLAG_NODUMP;
+	if (fa->flags & FS_NOATIME_FL)
+		fa->fsx_xflags |= FS_XFLAG_NOATIME;
+	if (fa->flags & FS_DAX_FL)
+		fa->fsx_xflags |= FS_XFLAG_DAX;
+	if (fa->flags & FS_PROJINHERIT_FL)
+		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+}
+EXPORT_SYMBOL(fileattr_fill_flags);
+
+/**
+ * vfs_fileattr_get - retrieve miscellaneous file attributes
+ * @dentry:	the object to retrieve from
+ * @fa:		fileattr pointer
+ *
+ * Call i_op->fileattr_get() callback, if exists.
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (!inode->i_op->fileattr_get)
+		return -ENOIOCTLCMD;
+
+	return inode->i_op->fileattr_get(dentry, fa);
+}
+EXPORT_SYMBOL(vfs_fileattr_get);
+
+/**
+ * copy_fsxattr_to_user - copy fsxattr to userspace.
+ * @fa:		fileattr pointer
+ * @ufa:	fsxattr user pointer
+ *
+ * Return: 0 on success, or -EFAULT on failure.
+ */
+int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
+{
+	struct fsxattr xfa;
+
+	memset(&xfa, 0, sizeof(xfa));
+	xfa.fsx_xflags = fa->fsx_xflags;
+	xfa.fsx_extsize = fa->fsx_extsize;
+	xfa.fsx_nextents = fa->fsx_nextents;
+	xfa.fsx_projid = fa->fsx_projid;
+	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+
+	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_fsxattr_to_user);
+
+static int copy_fsxattr_from_user(struct fileattr *fa,
+				  struct fsxattr __user *ufa)
+{
+	struct fsxattr xfa;
+
+	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
+		return -EFAULT;
+
+	fileattr_fill_xflags(fa, xfa.fsx_xflags);
+	fa->fsx_extsize = xfa.fsx_extsize;
+	fa->fsx_nextents = xfa.fsx_nextents;
+	fa->fsx_projid = xfa.fsx_projid;
+	fa->fsx_cowextsize = xfa.fsx_cowextsize;
+
+	return 0;
+}
+
+/*
+ * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
+ * any invalid configurations.
+ *
+ * Note: must be called with inode lock held.
+ */
+static int fileattr_set_prepare(struct inode *inode,
+			      const struct fileattr *old_ma,
+			      struct fileattr *fa)
+{
+	int err;
+
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+	 * the relevant capability.
+	 */
+	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
+	if (err)
+		return err;
+
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() != &init_user_ns) {
+		if (old_ma->fsx_projid != fa->fsx_projid)
+			return -EINVAL;
+		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
+				FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	} else {
+		/*
+		 * Caller is allowed to change the project ID. If it is being
+		 * changed, make sure that the new value is valid.
+		 */
+		if (old_ma->fsx_projid != fa->fsx_projid &&
+		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
+			return -EINVAL;
+	}
+
+	/* Check extent size hints. */
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/*
+	 * It is only valid to set the DAX flag on regular files and
+	 * directories on filesystems.
+	 */
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (fa->fsx_extsize == 0)
+		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (fa->fsx_cowextsize == 0)
+		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
+	return 0;
+}
+
+/**
+ * vfs_fileattr_set - change miscellaneous file attributes
+ * @idmap:	idmap of the mount
+ * @dentry:	the object to change
+ * @fa:		fileattr pointer
+ *
+ * After verifying permissions, call i_op->fileattr_set() callback, if
+ * exists.
+ *
+ * Verifying attributes involves retrieving current attributes with
+ * i_op->fileattr_get(), this also allows initializing attributes that have
+ * not been set by the caller to current values.  Inode lock is held
+ * thoughout to prevent racing with another instance.
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
+		     struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct fileattr old_ma = {};
+	int err;
+
+	if (!inode->i_op->fileattr_set)
+		return -ENOIOCTLCMD;
+
+	if (!inode_owner_or_capable(idmap, inode))
+		return -EPERM;
+
+	inode_lock(inode);
+	err = vfs_fileattr_get(dentry, &old_ma);
+	if (!err) {
+		/* initialize missing bits from old_ma */
+		if (fa->flags_valid) {
+			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+			fa->fsx_extsize = old_ma.fsx_extsize;
+			fa->fsx_nextents = old_ma.fsx_nextents;
+			fa->fsx_projid = old_ma.fsx_projid;
+			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+		} else {
+			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
+		}
+		err = fileattr_set_prepare(inode, &old_ma, fa);
+		if (!err)
+			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+	}
+	inode_unlock(inode);
+
+	return err;
+}
+EXPORT_SYMBOL(vfs_fileattr_set);
+
+int ioctl_getflags(struct file *file, unsigned int __user *argp)
+{
+	struct fileattr fa = { .flags_valid = true }; /* hint only */
+	int err;
+
+	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (!err)
+		err = put_user(fa.flags, argp);
+	return err;
+}
+EXPORT_SYMBOL(ioctl_getflags);
+
+int ioctl_setflags(struct file *file, unsigned int __user *argp)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct dentry *dentry = file->f_path.dentry;
+	struct fileattr fa;
+	unsigned int flags;
+	int err;
+
+	err = get_user(flags, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			fileattr_fill_flags(&fa, flags);
+			err = vfs_fileattr_set(idmap, dentry, &fa);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+EXPORT_SYMBOL(ioctl_setflags);
+
+int ioctl_fsgetxattr(struct file *file, void __user *argp)
+{
+	struct fileattr fa = { .fsx_valid = true }; /* hint only */
+	int err;
+
+	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (!err)
+		err = copy_fsxattr_to_user(&fa, argp);
+
+	return err;
+}
+EXPORT_SYMBOL(ioctl_fsgetxattr);
+
+int ioctl_fssetxattr(struct file *file, void __user *argp)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct dentry *dentry = file->f_path.dentry;
+	struct fileattr fa;
+	int err;
+
+	err = copy_fsxattr_from_user(&fa, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			err = vfs_fileattr_set(idmap, dentry, &fa);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+EXPORT_SYMBOL(ioctl_fssetxattr);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index c91fd2b46a77f6f1ea99aab56b4d92b6d9a8c534..5bf1e4215252e3fe4febfc9646bb8209aadc76f0 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -453,315 +453,6 @@ static int ioctl_file_dedupe_range(struct file *file,
 	return ret;
 }
 
-/**
- * fileattr_fill_xflags - initialize fileattr with xflags
- * @fa:		fileattr pointer
- * @xflags:	FS_XFLAG_* flags
- *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
- */
-void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->fsx_valid = true;
-	fa->fsx_xflags = xflags;
-	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
-		fa->flags |= FS_IMMUTABLE_FL;
-	if (fa->fsx_xflags & FS_XFLAG_APPEND)
-		fa->flags |= FS_APPEND_FL;
-	if (fa->fsx_xflags & FS_XFLAG_SYNC)
-		fa->flags |= FS_SYNC_FL;
-	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
-		fa->flags |= FS_NOATIME_FL;
-	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
-		fa->flags |= FS_NODUMP_FL;
-	if (fa->fsx_xflags & FS_XFLAG_DAX)
-		fa->flags |= FS_DAX_FL;
-	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
-		fa->flags |= FS_PROJINHERIT_FL;
-}
-EXPORT_SYMBOL(fileattr_fill_xflags);
-
-/**
- * fileattr_fill_flags - initialize fileattr with flags
- * @fa:		fileattr pointer
- * @flags:	FS_*_FL flags
- *
- * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
- * All other fields are zeroed.
- */
-void fileattr_fill_flags(struct fileattr *fa, u32 flags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->flags_valid = true;
-	fa->flags = flags;
-	if (fa->flags & FS_SYNC_FL)
-		fa->fsx_xflags |= FS_XFLAG_SYNC;
-	if (fa->flags & FS_IMMUTABLE_FL)
-		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
-	if (fa->flags & FS_APPEND_FL)
-		fa->fsx_xflags |= FS_XFLAG_APPEND;
-	if (fa->flags & FS_NODUMP_FL)
-		fa->fsx_xflags |= FS_XFLAG_NODUMP;
-	if (fa->flags & FS_NOATIME_FL)
-		fa->fsx_xflags |= FS_XFLAG_NOATIME;
-	if (fa->flags & FS_DAX_FL)
-		fa->fsx_xflags |= FS_XFLAG_DAX;
-	if (fa->flags & FS_PROJINHERIT_FL)
-		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
-}
-EXPORT_SYMBOL(fileattr_fill_flags);
-
-/**
- * vfs_fileattr_get - retrieve miscellaneous file attributes
- * @dentry:	the object to retrieve from
- * @fa:		fileattr pointer
- *
- * Call i_op->fileattr_get() callback, if exists.
- *
- * Return: 0 on success, or a negative error on failure.
- */
-int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-
-	if (!inode->i_op->fileattr_get)
-		return -ENOIOCTLCMD;
-
-	return inode->i_op->fileattr_get(dentry, fa);
-}
-EXPORT_SYMBOL(vfs_fileattr_get);
-
-/**
- * copy_fsxattr_to_user - copy fsxattr to userspace.
- * @fa:		fileattr pointer
- * @ufa:	fsxattr user pointer
- *
- * Return: 0 on success, or -EFAULT on failure.
- */
-int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
-{
-	struct fsxattr xfa;
-
-	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
-	xfa.fsx_extsize = fa->fsx_extsize;
-	xfa.fsx_nextents = fa->fsx_nextents;
-	xfa.fsx_projid = fa->fsx_projid;
-	xfa.fsx_cowextsize = fa->fsx_cowextsize;
-
-	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
-		return -EFAULT;
-
-	return 0;
-}
-EXPORT_SYMBOL(copy_fsxattr_to_user);
-
-static int copy_fsxattr_from_user(struct fileattr *fa,
-				  struct fsxattr __user *ufa)
-{
-	struct fsxattr xfa;
-
-	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
-		return -EFAULT;
-
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_extsize = xfa.fsx_extsize;
-	fa->fsx_nextents = xfa.fsx_nextents;
-	fa->fsx_projid = xfa.fsx_projid;
-	fa->fsx_cowextsize = xfa.fsx_cowextsize;
-
-	return 0;
-}
-
-/*
- * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
- * any invalid configurations.
- *
- * Note: must be called with inode lock held.
- */
-static int fileattr_set_prepare(struct inode *inode,
-			      const struct fileattr *old_ma,
-			      struct fileattr *fa)
-{
-	int err;
-
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 */
-	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
-	if (err)
-		return err;
-
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() != &init_user_ns) {
-		if (old_ma->fsx_projid != fa->fsx_projid)
-			return -EINVAL;
-		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
-				FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	} else {
-		/*
-		 * Caller is allowed to change the project ID. If it is being
-		 * changed, make sure that the new value is valid.
-		 */
-		if (old_ma->fsx_projid != fa->fsx_projid &&
-		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
-			return -EINVAL;
-	}
-
-	/* Check extent size hints. */
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-			!S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
-	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems.
-	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
-
-	/* Extent size hints of zero turn off the flags. */
-	if (fa->fsx_extsize == 0)
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
-	if (fa->fsx_cowextsize == 0)
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
-
-	return 0;
-}
-
-/**
- * vfs_fileattr_set - change miscellaneous file attributes
- * @idmap:	idmap of the mount
- * @dentry:	the object to change
- * @fa:		fileattr pointer
- *
- * After verifying permissions, call i_op->fileattr_set() callback, if
- * exists.
- *
- * Verifying attributes involves retrieving current attributes with
- * i_op->fileattr_get(), this also allows initializing attributes that have
- * not been set by the caller to current values.  Inode lock is held
- * thoughout to prevent racing with another instance.
- *
- * Return: 0 on success, or a negative error on failure.
- */
-int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
-		     struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-	struct fileattr old_ma = {};
-	int err;
-
-	if (!inode->i_op->fileattr_set)
-		return -ENOIOCTLCMD;
-
-	if (!inode_owner_or_capable(idmap, inode))
-		return -EPERM;
-
-	inode_lock(inode);
-	err = vfs_fileattr_get(dentry, &old_ma);
-	if (!err) {
-		/* initialize missing bits from old_ma */
-		if (fa->flags_valid) {
-			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
-			fa->fsx_extsize = old_ma.fsx_extsize;
-			fa->fsx_nextents = old_ma.fsx_nextents;
-			fa->fsx_projid = old_ma.fsx_projid;
-			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
-		} else {
-			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
-		}
-		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
-	}
-	inode_unlock(inode);
-
-	return err;
-}
-EXPORT_SYMBOL(vfs_fileattr_set);
-
-static int ioctl_getflags(struct file *file, unsigned int __user *argp)
-{
-	struct fileattr fa = { .flags_valid = true }; /* hint only */
-	int err;
-
-	err = vfs_fileattr_get(file->f_path.dentry, &fa);
-	if (!err)
-		err = put_user(fa.flags, argp);
-	return err;
-}
-
-static int ioctl_setflags(struct file *file, unsigned int __user *argp)
-{
-	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct dentry *dentry = file->f_path.dentry;
-	struct fileattr fa;
-	unsigned int flags;
-	int err;
-
-	err = get_user(flags, argp);
-	if (!err) {
-		err = mnt_want_write_file(file);
-		if (!err) {
-			fileattr_fill_flags(&fa, flags);
-			err = vfs_fileattr_set(idmap, dentry, &fa);
-			mnt_drop_write_file(file);
-		}
-	}
-	return err;
-}
-
-static int ioctl_fsgetxattr(struct file *file, void __user *argp)
-{
-	struct fileattr fa = { .fsx_valid = true }; /* hint only */
-	int err;
-
-	err = vfs_fileattr_get(file->f_path.dentry, &fa);
-	if (!err)
-		err = copy_fsxattr_to_user(&fa, argp);
-
-	return err;
-}
-
-static int ioctl_fssetxattr(struct file *file, void __user *argp)
-{
-	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct dentry *dentry = file->f_path.dentry;
-	struct fileattr fa;
-	int err;
-
-	err = copy_fsxattr_from_user(&fa, argp);
-	if (!err) {
-		err = mnt_want_write_file(file);
-		if (!err) {
-			err = vfs_fileattr_set(idmap, dentry, &fa);
-			mnt_drop_write_file(file);
-		}
-	}
-	return err;
-}
-
 static int ioctl_getfsuuid(struct file *file, void __user *argp)
 {
 	struct super_block *sb = file_inode(file)->i_sb;
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0600964b644c9c7218faacfd865f8..6030d0bf7ad32693a0f48a6f28475d97e768bb3e 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -55,5 +55,9 @@ static inline bool fileattr_has_fsx(const struct fileattr *fa)
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct fileattr *fa);
+int ioctl_getflags(struct file *file, unsigned int __user *argp);
+int ioctl_setflags(struct file *file, unsigned int __user *argp);
+int ioctl_fsgetxattr(struct file *file, void __user *argp);
+int ioctl_fssetxattr(struct file *file, void __user *argp);
 
 #endif /* _LINUX_FILEATTR_H */

-- 
2.47.2


