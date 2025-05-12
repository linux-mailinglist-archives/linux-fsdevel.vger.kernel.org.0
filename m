Return-Path: <linux-fsdevel+bounces-48742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B3AB389E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2450F7ADF48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522F2957D7;
	Mon, 12 May 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HANJjMlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51A2951A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055970; cv=none; b=Nh6I7aFR4HB4o0xuPK2+00DskTneEDB525bGejAiY0cm0qKYpZbpYZ6JpJ+7iRW+DVsTPj4f1YL17xhB3lbfJhE4E51rGTtoQ1z3xFkZ0/xKeeqDiDOCpYM568nDzlNw0HUVnALgV77t1wQ4hCaBe39GFSKJqV/w8bY3EAMwXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055970; c=relaxed/simple;
	bh=EmR+qa8CwZsS9KCxJJBgYph25/tNUv3/TVU3Qj6vhXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ko2FZUk4vZFrX+WBkCkr20pgmKpkbcB5BR9kNxlV64jcWaRcpqi7JLiReifGjIDSZPX7h1w2Uo7rC0Z+kCGCnM3t66KO0Kg0fAakBukNgju97O4LAmxDpmNI/MRefKcTSeW8SF4KHGkIdIJpHh7J9+1VTsycEmO5viP86XpApSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HANJjMlg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KskbOtx9kmCL1KYjlinzqO2sdtLLS86YLm+BzmhHmDI=;
	b=HANJjMlg5DK9Qc+J4iOfky44gZwylr11TPTiGVUdXs/Zuo1QXVG3QTBmIV+ZUoEW71XQxe
	pc8bG/lENOwzP5BoXRj6rswVkpeE2W7RZp3oBSGg/w6mn2uW6N2Cqi2/J5TZeHXW2QmiF4
	YggICgIjkDm37ChL4kUHiRjFpoLVtzc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-1mZ2lrmjPFOmnRgRnT5Jbg-1; Mon, 12 May 2025 09:19:22 -0400
X-MC-Unique: 1mZ2lrmjPFOmnRgRnT5Jbg-1
X-Mimecast-MFC-AGG-ID: 1mZ2lrmjPFOmnRgRnT5Jbg_1747055960
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac37ed2b99fso403192866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 06:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055960; x=1747660760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KskbOtx9kmCL1KYjlinzqO2sdtLLS86YLm+BzmhHmDI=;
        b=pn8pWRsUt5gtflhEMdD/CstMt4etSP9hz71+w/9TdomKErrQgPKALvy5Yn2LUh4f88
         GcxDsTGh2W75eEvoMmCYGVp14EaWHvVnkrZk4AhLg7zjq1CoDpI+WVRq3CLUgPSmx/sR
         ALRmlmlZ4Xwk4lbUX/iaAB0IZ+aCnP3aXYqekxBwFBnCKqK7HkAYZ8mIZTu5/SFrPtge
         oVqxQGMexuH5UShF1qTCFXJ/DhuCGhbJOLJXNuEloNwFxYPPVdTy0VkPSneXuNbRAgW4
         pvT1v81ItTMGRk7ESRX/U/eq7b7AxoCJXEnrQInBUkTQih8JZRN5Rad2ZvqGsJY0wAVv
         vzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoFy+j/Sw0Ify2K+Bm1RrJ0XJadGkA1shwgzEZ0AB60ABhRoHFeecciwY0hTZPu32PBJ10chKXhNcu6aL2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ht9pfTlN9caKSjjtF4iD8IlLZY3U6sATun6n81gmJEETAG1O
	UbFm9Z6pdzw5OWUyw8QGNhD8wHVnr5r3h0LowmhBx4WUUUDaDSjU82PuMxQnQ7QhhXsyim3hoCu
	e2Z8TVE/fcr0hK1nt+HH7Fzt/qCVgWuxbaT+TSjTapGRhn7qEEstqKRpD18dR9g==
X-Gm-Gg: ASbGnctlyXVXxrdGbNYtwEdOunsDystXNgI3mZxRksNQjy/YYKAGh3EFRvAPr7BT16M
	wiP4gb6AopDJRWQJb5W0vXKQ2nawUloJzhQY0xv+nyJfYqYYVfAvKglngpwb4DPOJtYhbGy2w19
	AXbbpLXA+ErkQUN4IviQXFtGcpA6iXV6gLUMKx3FUzXR7Wn46U1gfaer9nRhK/rHxjpw3rts8Rw
	+RBmO/DHs2kTFHSAl61KiVZcM9PcA36KYQGa1W2CWmq8AnZVYGxz+697Sx2BRI0LUbn00VdF1Sn
	/Mw30/IGW57w52QKJbcMlma1Miw=
X-Received: by 2002:a17:906:988c:b0:ad2:1c70:3a8f with SMTP id a640c23a62f3a-ad21c703dadmr796167366b.53.1747055959878;
        Mon, 12 May 2025 06:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqOZcyX5mMzEBWWr5mk5cSzGkf5in4jrOwX2YFPFtHDQQJ6DlCpwuFwlIqKU4oi2/Nt0JmyQ==
X-Received: by 2002:a17:906:988c:b0:ad2:1c70:3a8f with SMTP id a640c23a62f3a-ad21c703dadmr796159666b.53.1747055959151;
        Mon, 12 May 2025 06:19:19 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:16 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 May 2025 15:18:54 +0200
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
Message-Id: <20250512-xattrat-syscall-v5-1-a88b20e37aae@kernel.org>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=20201; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=p7jOeNk7/fWSjM5nR0sexrxO/5MDb/e1y548KGb8xZU=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+rU9Cv+vniLcvtTo3vawNz68sz7HeTMYTt3Mv
 NrcW8bCJ6GjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARE5pMPwzXMFh6Brxxfbu
 iw+LRN32L2RhcnLXyvsZ55DB8q/gvt4zhv8pm6dUZ5zZJFH6ZsuykwzB66qOR5zl9WNaG72Y8bD
 VqieMAEXzRcI=
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
index 77fd7f7b5d02..2f1daaea86da 100644
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
index 000000000000..2910b7047721
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
index c91fd2b46a77..5bf1e4215252 100644
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
index 47c05a9851d0..6030d0bf7ad3 100644
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


