Return-Path: <linux-fsdevel+bounces-53387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61902AEE448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7784616D604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C3228F947;
	Mon, 30 Jun 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqi/AGju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083D291C1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300444; cv=none; b=GeDIQLBpTxhPJu4Aya2Ah2MlHKN1ltV3dnA+ev7qGobgFXoAOXvNgxBkmVD7Tgj8deJPwA6zf/Q+Bo8Bi2YfKbsIpbhLbL1G9YRNMul2jYvJuvN3EINF33YtbNeyi4fZ6QMtX8byxFk0nE0Yi9RKDSRi+Ys/tM9klnWLrUBWxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300444; c=relaxed/simple;
	bh=/0DPgYqHwXH68zqTi+bZwoE769iGHAO3Kk0ZsNgUTCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBUs3kQwqQ+GjkrSYcv66jm4+ooI1HE65Ykwtx2NV18FRxbIEVFfvo5+6XQubKhVC8oqLHp2P/6LnpX+Kke/0RhCVvNWuGXFTG74gDi3WduZsQIK9FH6zHGSjwmr4h6yIzgkejRi3FiKMWcGvcT56hPc9uqpku+O13RUwzgjxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqi/AGju; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoyF2Lbb+EmANh+ApKAOj3j7GqG7GRYmSFuKrQ30Lm4=;
	b=eqi/AGjusGEXJ7cC4kcAJBeioWy8rFTNP/AazHji1FKYA3IncR2nr+ZFrWxz+rQJuHy+0i
	EDhsjTpuod9cMQtgsd2ylFMtc9vVfjOBSUTYi4InI3olAbmRJ8VYDqjQDsSFjysu281nPR
	nQpNFzPdVrh/3W/6rua0vuCx+UGWOU0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-w-aJ9opwPLyyGkVmioYQ1Q-1; Mon, 30 Jun 2025 12:20:38 -0400
X-MC-Unique: w-aJ9opwPLyyGkVmioYQ1Q-1
X-Mimecast-MFC-AGG-ID: w-aJ9opwPLyyGkVmioYQ1Q_1751300437
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450eaae2934so16813695e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300437; x=1751905237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoyF2Lbb+EmANh+ApKAOj3j7GqG7GRYmSFuKrQ30Lm4=;
        b=a3Xi4kFH85NwklLztmXXsPi4QSKuCWK8/GiFcYTHCpJ4x3YjRmNnYN1SzDg3r385ey
         HVX4jufaKIe48csTPUgTy9LRfn2wNQi5yVPwLwn/BILZu4MxMwg7Pqf7XjPS3bJ75Hj0
         LHZIWLf8431TW3lq+pRKigvo4V3JjmgXJl3Q1iP5ZNo/BEmWp40BbCqPU09odlj3/mQv
         rk7O5qGXyds8Nyyy2GpzZ0jQrttElxxFiSgLMfVJuDbl8UZVl3sWhE4v0Ry7LknLVqI9
         jgehXoRUDdN4fPYYPONxYHh3P8DTY31FRJNhR161bMk/ewb33C6RG8pKJbnx9wlgXlm5
         LAnA==
X-Forwarded-Encrypted: i=1; AJvYcCWTDNpLC6uNtKEsA+Yze8Xsq9nv5BvTW/ss7BM6UunzuxOvqXUGSjXKCs6/wUMv/1sLuoVd0Ux1ITLTlMPw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5weXap5sfWGdZHqokHquVxz/m2NFoV8nXfBbZH/cmdCl2eOoc
	4rD1gX6YhmjhlTOp589oo65HtLEfMMA3aaT0iRrpBYagtrtBPX83eJ+Q90TX+BXIWWkzPN7LcdN
	el4A3KUbKbOhOThpAWqLh9yFSII4dQ8DklNv+FjGdHQorQUO12kuqOGKzwvvJICW2eQ==
X-Gm-Gg: ASbGncsV7D73knqa9hiAEy7pSy+9Ey95pRQ4KrKFCl5JJ7g2BfMjFI8mVCdNJCslMle
	wHrjrLky7/EcNdXq04YID6HFqXW6YWNShFBK/Hn6syqoYMPWqVpKYahpPLG6u0akYkIrp3fF/LU
	FAA2EonNixyteBtduCcRDI33R6jAvMk/kLukxskCBDEDIbAvXWUNG9IR9FGL3JQF58qu61xc7tT
	itLyaqYuHJ4ZFq+T+tn5xNjopP4UYdK8ytyKTkbQN3nlg4OPU1hz3hk9HqiyTXzKjRgLxQOCkis
	SkFMgPk3wpZRMaByQboH/se+JFrA
X-Received: by 2002:a05:600c:6285:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-4538ee51961mr161000465e9.15.1751300437326;
        Mon, 30 Jun 2025 09:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtorg9o36AVQP+WBvPMzp87fcnrKpmxG66TjtrB1Pb0Yem+Q0XFJ/tFsqwzgrGlrSTf0Zcqw==
X-Received: by 2002:a05:600c:6285:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-4538ee51961mr161000125e9.15.1751300436799;
        Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:16 +0200
Subject: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17773; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=ZLLC0uab4T1vYFSlMig/IXObB26c+FZcBUGNwVHWico=;
 b=kA0DAAoWRqfqGKwz4QgByyZiAGhiuUuhJ+RO7hD/JfzUzRBkyP8w2z93FUimejVHPUZNkWHxZ
 Yh1BAAWCgAdFiEErhsqlWJyGm/EMHwfRqfqGKwz4QgFAmhiuUsACgkQRqfqGKwz4QhnewD/S9Nl
 MnvwpB18h4axOdsLw8cZ4Q7S3k3edh73tjuUyi8A/1SlEIftICnrt8K3Xw2U8+GIv+c4gQ9Y2GV
 vRCwGlq4K
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Introduce file_getattr() and file_setattr() syscalls to manipulate inode
extended attributes. The syscalls takes pair of file descriptor and
pathname. Then it operates on inode opened accroding to openat()
semantics. The struct fsx_fileattr is passed to obtain/change extended
attributes.

This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
that file don't need to be open as we can reference it with a path
instead of fd. By having this we can manipulated inode extended
attributes not only on regular files but also on special ones. This
is not possible with FS_IOC_FSSETXATTR ioctl as with special files
we can not call ioctl() directly on the filesystem inode using fd.

This patch adds two new syscalls which allows userspace to get/set
extended inode attributes on special files by using parent directory
and a path - *at() like syscall.

CC: linux-api@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-xfs@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/tools/syscall_32.tbl             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/file_attr.c                              | 148 ++++++++++++++++++++++++++++
 include/linux/syscalls.h                    |   6 ++
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |  18 ++++
 scripts/syscall.tbl                         |   2 +
 21 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 2dd6340de6b4..16dca28ebf17 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -507,3 +507,5 @@
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
 577	common	open_tree_attr			sys_open_tree_attr
+578	common	file_getattr			sys_file_getattr
+579	common	file_setattr			sys_file_setattr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 27c1d5ebcd91..b07e699aaa3c 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -482,3 +482,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 0765b3a8d6d6..8d9088bc577d 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -479,3 +479,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 9fe47112c586..f41d38dfbf13 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -467,3 +467,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 7b6e97828e55..580af574fe73 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -473,3 +473,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index aa70e371bb54..d824ffe9a014 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -406,3 +406,5 @@
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
 467	n32	open_tree_attr			sys_open_tree_attr
+468	n32	file_getattr			sys_file_getattr
+469	n32	file_setattr			sys_file_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 1e8c44c7b614..7a7049c2c307 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -382,3 +382,5 @@
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
 467	n64	open_tree_attr			sys_open_tree_attr
+468	n64	file_getattr			sys_file_getattr
+469	n64	file_setattr			sys_file_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 114a5a1a6230..d330274f0601 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -455,3 +455,5 @@
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
 467	o32	open_tree_attr			sys_open_tree_attr
+468	o32	file_getattr			sys_file_getattr
+469	o32	file_setattr			sys_file_setattr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 94df3cb957e9..88a788a7b18d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -466,3 +466,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 9a084bdb8926..b453e80dfc00 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -558,3 +558,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index a4569b96ef06..8a6744d658db 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
+468  common	file_getattr		sys_file_getattr		sys_file_getattr
+469  common	file_setattr		sys_file_setattr		sys_file_setattr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 52a7652fcff6..5e9c9eff5539 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 83e45eb6c095..ebb7d06d1044 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -513,3 +513,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ac007ea00979..4877e16da69a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -473,3 +473,5 @@
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
 467	i386	open_tree_attr		sys_open_tree_attr
+468	i386	file_getattr		sys_file_getattr
+469	i386	file_setattr		sys_file_setattr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..92cf0fe2291e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -391,6 +391,8 @@
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
 467	common	open_tree_attr		sys_open_tree_attr
+468	common	file_getattr		sys_file_getattr
+469	common	file_setattr		sys_file_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index f657a77314f8..374e4cb788d8 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -438,3 +438,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
diff --git a/fs/file_attr.c b/fs/file_attr.c
index 62f08872d4ad..fda9d847eee5 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -3,6 +3,10 @@
 #include <linux/security.h>
 #include <linux/fscrypt.h>
 #include <linux/fileattr.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
+
+#include "internal.h"
 
 /**
  * fileattr_fill_xflags - initialize fileattr with xflags
@@ -89,6 +93,19 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
+static void fileattr_to_fsx_fileattr(const struct fileattr *fa,
+				     struct fsx_fileattr *fsx)
+{
+	__u32 mask = FS_XFLAGS_MASK;
+
+	memset(fsx, 0, sizeof(struct fsx_fileattr));
+	fsx->fsx_xflags = fa->fsx_xflags & mask;
+	fsx->fsx_extsize = fa->fsx_extsize;
+	fsx->fsx_nextents = fa->fsx_nextents;
+	fsx->fsx_projid = fa->fsx_projid;
+	fsx->fsx_cowextsize = fa->fsx_cowextsize;
+}
+
 /**
  * copy_fsxattr_to_user - copy fsxattr to userspace.
  * @fa:		fileattr pointer
@@ -115,6 +132,23 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
+static int fsx_fileattr_to_fileattr(const struct fsx_fileattr *fsx,
+				    struct fileattr *fa)
+{
+	__u32 mask = FS_XFLAGS_MASK;
+
+	if (fsx->fsx_xflags & ~mask)
+		return -EINVAL;
+
+	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
+	fa->fsx_extsize = fsx->fsx_extsize;
+	fa->fsx_projid = fsx->fsx_projid;
+	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+
+	return 0;
+}
+
 static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
@@ -343,3 +377,117 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 	return err;
 }
 EXPORT_SYMBOL(ioctl_fssetxattr);
+
+SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
+		struct fsx_fileattr __user *, ufsx, size_t, usize,
+		unsigned int, at_flags)
+{
+	struct fileattr fa;
+	struct path filepath __free(path_put) = {};
+	int error;
+	unsigned int lookup_flags = 0;
+	struct filename *name __free(putname) = NULL;
+	struct fsx_fileattr fsx;
+
+	BUILD_BUG_ON(sizeof(struct fsx_fileattr) < FSX_FILEATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct fsx_fileattr) != FSX_FILEATTR_SIZE_LATEST);
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	if (usize < FSX_FILEATTR_SIZE_VER0)
+		return -EINVAL;
+
+	name = getname_maybe_null(filename, at_flags);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	if (!name && dfd >= 0) {
+		CLASS(fd, f)(dfd);
+
+		filepath = fd_file(f)->f_path;
+		path_get(&filepath);
+	} else {
+		error = filename_lookup(dfd, name, lookup_flags, &filepath,
+					NULL);
+		if (error)
+			return error;
+	}
+
+	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error)
+		return error;
+
+	fileattr_to_fsx_fileattr(&fa, &fsx);
+	error = copy_struct_to_user(ufsx, usize, &fsx,
+				    sizeof(struct fsx_fileattr), NULL);
+
+	return error;
+}
+
+SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
+		struct fsx_fileattr __user *, ufsx, size_t, usize,
+		unsigned int, at_flags)
+{
+	struct fileattr fa;
+	struct path filepath __free(path_put) = {};
+	int error;
+	unsigned int lookup_flags = 0;
+	struct filename *name __free(putname) = NULL;
+	struct fsx_fileattr fsx;
+
+	BUILD_BUG_ON(sizeof(struct fsx_fileattr) < FSX_FILEATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct fsx_fileattr) != FSX_FILEATTR_SIZE_LATEST);
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	if (usize < FSX_FILEATTR_SIZE_VER0)
+		return -EINVAL;
+
+	error = copy_struct_from_user(&fsx, sizeof(struct fsx_fileattr), ufsx,
+				      usize);
+	if (error)
+		return error;
+
+	error = fsx_fileattr_to_fileattr(&fsx, &fa);
+	if (error)
+		return error;
+
+	name = getname_maybe_null(filename, at_flags);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	if (!name && dfd >= 0) {
+		CLASS(fd, f)(dfd);
+
+		filepath = fd_file(f)->f_path;
+		path_get(&filepath);
+	} else {
+		error = filename_lookup(dfd, name, lookup_flags, &filepath,
+					NULL);
+		if (error)
+			return error;
+	}
+
+	error = mnt_want_write(filepath.mnt);
+	if (!error) {
+		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
+					 filepath.dentry, &fa);
+		mnt_drop_write(filepath.mnt);
+	}
+
+	return error;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963..179acbe28fec 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -371,6 +371,12 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long sys_file_getattr(int dfd, const char __user *filename,
+				 struct fsx_fileattr __user *ufsx, size_t usize,
+				 unsigned int at_flags);
+asmlinkage long sys_file_setattr(int dfd, const char __user *filename,
+				 struct fsx_fileattr __user *ufsx, size_t usize,
+				 unsigned int at_flags);
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
 asmlinkage long sys_epoll_create1(int flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2892a45023af..04e0077fb4c9 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -852,8 +852,14 @@ __SYSCALL(__NR_removexattrat, sys_removexattrat)
 #define __NR_open_tree_attr 467
 __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
+/* fs/inode.c */
+#define __NR_file_getattr 468
+__SYSCALL(__NR_file_getattr, sys_file_getattr)
+#define __NR_file_setattr 469
+__SYSCALL(__NR_file_setattr, sys_file_setattr)
+
 #undef __NR_syscalls
-#define __NR_syscalls 468
+#define __NR_syscalls 470
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0098b0ce8ccb..0784f2033ba4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -148,6 +148,24 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+/*
+ * Variable size structure for file_[sg]et_attr().
+ *
+ * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
+ * As this structure is passed to/from userspace with its size, this can
+ * be versioned based on the size.
+ */
+struct fsx_fileattr {
+	__u32	fsx_xflags;	/* xflags field value (get/set) */
+	__u32	fsx_extsize;	/* extsize field value (get/set)*/
+	__u32	fsx_nextents;	/* nextents field value (get)   */
+	__u32	fsx_projid;	/* project identifier (get/set) */
+	__u32	fsx_cowextsize;	/* CoW extsize field value (get/set) */
+};
+
+#define FSX_FILEATTR_SIZE_VER0 20
+#define FSX_FILEATTR_SIZE_LATEST FSX_FILEATTR_SIZE_VER0
+
 /*
  * Flags for the fsx_xflags field
  */
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 580b4e246aec..d1ae5e92c615 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -408,3 +408,5 @@
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
 467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr

-- 
2.47.2


