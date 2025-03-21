Return-Path: <linux-fsdevel+bounces-44738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4CA6C3BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 20:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A1E1895B01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88D231A21;
	Fri, 21 Mar 2025 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrRfPmEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7C23099C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586566; cv=none; b=HA5rdy3EI1nUdIC3V/SLdx63CLjXp73ldMKpNF3YpHPC587feuTtBo0Ul0AqPyR599M92xMG2FOXIZ69/8CEwQcTCzf6Pk0vLpYvBoZkkaX6NbKZEz6dDN25hVb4HpK4XoV/a3vHBxSupNPkg8t5aW4dSPC1PADlFKiFpBiaq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586566; c=relaxed/simple;
	bh=UM4dBeQhjnLKCtYaVRyZJclCAb+Ay8VqBhpEcQvPK9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTGvKsJf0t0H/85zUlek0LB96/PvMlcTyInV4hsGkvU+qH11zfaUdOr9uLwbQoiSDDXzNODWmJFyd/1rd7WImmbY+IvjEbqcc00qFNqoZqqoV9b7hJX7NZgOQ2X+i1dj3wHP0ZicWjNYhOfb5FYb6sOTVikYSBp3RAZRJfuD5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrRfPmEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742586561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UnS3ex18xX+sda9SyJQmz6o+EGnB5pIpxGnsBA74Tw=;
	b=FrRfPmEbjetuwIsG5PYqYYCNQ6hA+U7TvLSVCeBHJpen+0kfSLWmt0o7mRQpNG/6P1v5Y0
	Y0izttUYdopYwasYMGP6pChmIQavznaBfSMBoWfBQaDWy5t/lwN/QuOdHijNZ+YnSPdGq+
	qoVzP4fr+06HcvsMYxQ1MycxSdvKWAc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-2XTssjTvMCqDZ_8-Xy6QKQ-1; Fri, 21 Mar 2025 15:49:19 -0400
X-MC-Unique: 2XTssjTvMCqDZ_8-Xy6QKQ-1
X-Mimecast-MFC-AGG-ID: 2XTssjTvMCqDZ_8-Xy6QKQ_1742586558
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3e0c13278so186598066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 12:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586558; x=1743191358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UnS3ex18xX+sda9SyJQmz6o+EGnB5pIpxGnsBA74Tw=;
        b=PXitFTw/XIv2aSfZ81aIrHQhEkA42UkJIbouv0VyEJ50rEPJ4dl5YMNN0fbfXic2Ou
         CnKAH0Z68Y54wFMHKLkTHMbpgHeFJhLOg1VcnJIia2sDP7TUdK28+bLjjKVwQQ+kMnm3
         EO/lcIqHyTrClq6R+m2FtEnmZZ0oDctVxkXcy8zWnRY90Q4rwcP1Gcfp71dO3NqMAlgU
         NW9ZcyIbdncFfdN5ia/3SVuRDo7488HH1h3TiwcmIfx1L08TOrR/rCuMKScjsNVicqra
         OSMBe+BbqhZWuvgLNcuIuiP63o3DeoygTkBFYCSfArHfAhneEb4DMCp8tZhlAzZosDj3
         /18w==
X-Forwarded-Encrypted: i=1; AJvYcCVE30nRgtH+qvvXvTyIahQd9q4YG9/YlX9knmuo86fTXl5ae5CCnlnwuCxyPa40DZf+pXtPNJtJzxfR2hu2@vger.kernel.org
X-Gm-Message-State: AOJu0YztCzkBXrV5sG06OXiBp6b0W+XfLQasyuclnGbQR+YI36j3MufL
	iO/KKVV9nZxs0+kCCMnMBddDmra8R8NWWGj/6y0MPtLP4whiuTnXF1KeUL/rBGZn1IyW8d91+cA
	3TrfyFxMilUqGV5btIWSpJPrspvlcpE+GmJHUa5+u13vXH6nF93TaLoRIC1RVhg==
X-Gm-Gg: ASbGnctr/JXBqWKBrNh6pda1S+FKPVG2r0nJ11L+1APOXQGj0nlEKD5gk3BhYeFAXGe
	Eaht79bOGyCBae3FLuBW/Ie7TttsNSgr6R0bu7n+CKS3XzKL6YVGkNplpXgIPmR28OrWLkqkzZC
	7ZrpdBuqIJQA672p+XT/A3qLed8FTIbuKQAiHCYSb71ikju0Khz69E4QR1Q6NcvHQ8bElTb7SHI
	xWByvjMoU28s3f7oHFV9WxB6d+996o7F51sWTFAnIgcmWrl2K+3D3lVpWhat2BWtgkGiPaY4pvk
	CpjodG9KXiLC23L7aFPEG+98fUocXFlO51l23TiGGw==
X-Received: by 2002:a17:907:97ce:b0:ac3:3f13:4b98 with SMTP id a640c23a62f3a-ac3f251f516mr481920966b.39.1742586558124;
        Fri, 21 Mar 2025 12:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTEnbVb5ZhxaCvYIJ95LKpuTda9i+H0QllTvbu0PmbUmmkibUhe4J/UvBBYGy5FTBaCSWKUw==
X-Received: by 2002:a17:907:97ce:b0:ac3:3f13:4b98 with SMTP id a640c23a62f3a-ac3f251f516mr481912966b.39.1742586557496;
        Fri, 21 Mar 2025 12:49:17 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d38sm204412266b.39.2025.03.21.12.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:49:16 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 21 Mar 2025 20:48:42 +0100
Subject: [PATCH v4 3/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
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
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16534; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=4PfF4Q21KvQ8qEms4EIdkoz2Ye9IxK6NP91RMyHkTBM=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8e2vht9wX11q/6NTMUXKZlS6479HD13xXG4S8SL
 xrlCCtxhhd3lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmIh5OiPDVh4lKz2B37Gh
 gYsa98QLTH2mfD206vOCtB9c172iWfcfYGSYPWNx04TgeXPSnaaWfZPv+8999rdT9b2YPKOEJUo
 Z064wAADHykhA
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
extended attributes/flags. The syscalls take parent directory fd and
path to the child together with struct fsxattr.

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
Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
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
 fs/inode.c                                  | 130 ++++++++++++++++++++++++++++
 include/linux/syscalls.h                    |   6 ++
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |   3 +
 20 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c59d53d6d3f3490f976ca179ddfe02e69265ae4d..4b9e687494c16b60c6fd6ca1dc4d6564706a7e25 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -506,3 +506,5 @@
 574	common	getxattrat			sys_getxattrat
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
+577	common	getfsxattrat			sys_getfsxattrat
+578	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 49eeb2ad8dbd8e074c6240417693f23fb328afa8..66466257f3c2debb3e2299f0b608c6740c98cab2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -481,3 +481,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 69a829912a05eb8a3e21ed701d1030e31c0148bc..9c516118b154811d8d11d5696f32817430320dbf 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -478,3 +478,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f5ed71f1910d09769c845c2d062d99ee0449437c..159476387f394a92ee5e29db89b118c630372db2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -466,3 +466,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 680f568b77f2cbefc3eacb2517f276041f229b1e..a6d59ee740b58cacf823702003cf9bad17c0d3b7 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -472,3 +472,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0b9b7e25b69ad592642f8533bee9ccfe95ce9626..cfe38fcebe1a0279e11751378d3e71c5ec6b6569 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -405,3 +405,5 @@
 464	n32	getxattrat			sys_getxattrat
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
+467	n32	getfsxattrat			sys_getfsxattrat
+468	n32	setfsxattrat			sys_setfsxattrat
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c844cd5cda620b2809a397cdd6f4315ab6a1bfe2..29a0c5974d1aa2f01e33edc0252d75fb97abe230 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -381,3 +381,5 @@
 464	n64	getxattrat			sys_getxattrat
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
+467	n64	getfsxattrat			sys_getfsxattrat
+468	n64	setfsxattrat			sys_setfsxattrat
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 349b8aad1159f404103bd2057a1e64e9bf309f18..6c00436807c57c492ba957fcd59af1202231cf80 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -454,3 +454,5 @@
 464	o32	getxattrat			sys_getxattrat
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
+467	o32	getfsxattrat			sys_getfsxattrat
+468	o32	setfsxattrat			sys_setfsxattrat
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index d9fc94c869657fcfbd7aca1d5f5abc9fae2fb9d8..b3578fac43d6b65167787fcc97d2d09f5a9828e7 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -465,3 +465,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index d8b4ab78bef076bd50d49b87dea5060fd8c1686a..808045d82c9465c3bfa96b15947546efe5851e9a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -557,3 +557,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e9115b4d8b635b846e5c9ad6ce229605323723a5..78dfc2c184d4815baf8a9e61c546c9936d58a47c 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -469,3 +469,5 @@
 464  common	getxattrat		sys_getxattrat			sys_getxattrat
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
+467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
+468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c8cad33bf250ea110de37bd1407f5a43ec5e38f2..d5a5c8339f0ed25ea07c4aba90351d352033c8a0 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 727f99d333b304b3db0711953a3d91ece18a28eb..817dcd8603bcbffc47f3f59aa3b74b16486453d0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -512,3 +512,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2fba7e208ae9455459afe11e277321d9f74..b4842c027c5d00c0236b2ba89387c5e2267447bd 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -472,3 +472,5 @@
 464	i386	getxattrat		sys_getxattrat
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
+467	i386	getfsxattrat		sys_getfsxattrat
+468	i386	setfsxattrat		sys_setfsxattrat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c791debd6cfc5322583b2ae53f6437..b6f0a7236aaee624cf9b484239a1068085a8ffe1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,6 +390,8 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
+467	common	getfsxattrat		sys_getfsxattrat
+468	common	setfsxattrat		sys_setfsxattrat
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 37effc1b134eea061f2c350c1d68b4436b65a4dd..425d56be337d1de22f205ac503df61ff86224fee 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -437,3 +437,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/fs/inode.c b/fs/inode.c
index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..811debf379ab299f287ed90863277cfda27db30c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -23,6 +23,9 @@
 #include <linux/rw_hint.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/syscalls.h>
+#include <linux/fileattr.h>
+#include <linux/namei.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -2953,3 +2956,130 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+SYSCALL_DEFINE5(getfsxattrat, int, dfd, const char __user *, filename,
+		struct fsxattr __user *, ufsx, size_t, usize,
+		unsigned int, at_flags)
+{
+	struct fileattr fa = {};
+	struct path filepath;
+	int error;
+	unsigned int lookup_flags = 0;
+	struct filename *name;
+	struct fsxattr fsx = {};
+
+	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	if (usize < FSXATTR_SIZE_VER0)
+		return -EINVAL;
+
+	name = getname_maybe_null(filename, at_flags);
+	if (!name) {
+		CLASS(fd, f)(dfd);
+
+		if (fd_empty(f))
+			return -EBADF;
+		error = vfs_fileattr_get(file_dentry(fd_file(f)), &fa);
+	} else {
+		error = filename_lookup(dfd, name, lookup_flags, &filepath,
+					NULL);
+		if (error)
+			goto out;
+		error = vfs_fileattr_get(filepath.dentry, &fa);
+		path_put(&filepath);
+	}
+	if (error == -ENOIOCTLCMD)
+		error = -EOPNOTSUPP;
+	if (!error) {
+		fileattr_to_fsxattr(&fa, &fsx);
+		error = copy_struct_to_user(ufsx, usize, &fsx,
+					    sizeof(struct fsxattr), NULL);
+	}
+out:
+	putname(name);
+	return error;
+}
+
+SYSCALL_DEFINE5(setfsxattrat, int, dfd, const char __user *, filename,
+		struct fsxattr __user *, ufsx, size_t, usize,
+		unsigned int, at_flags)
+{
+	struct fileattr fa;
+	struct path filepath;
+	int error;
+	unsigned int lookup_flags = 0;
+	struct filename *name;
+	struct mnt_idmap *idmap;
+	struct dentry *dentry;
+	struct vfsmount *mnt;
+	struct fsxattr fsx = {};
+
+	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+
+	if (usize < FSXATTR_SIZE_VER0)
+		return -EINVAL;
+
+	error = copy_struct_from_user(&fsx, sizeof(struct fsxattr), ufsx, usize);
+	if (error)
+		return error;
+
+	fsxattr_to_fileattr(&fsx, &fa);
+
+	name = getname_maybe_null(filename, at_flags);
+	if (!name) {
+		CLASS(fd, f)(dfd);
+
+		if (fd_empty(f))
+			return -EBADF;
+
+		idmap = file_mnt_idmap(fd_file(f));
+		dentry = file_dentry(fd_file(f));
+		mnt = fd_file(f)->f_path.mnt;
+	} else {
+		error = filename_lookup(dfd, name, lookup_flags, &filepath,
+					NULL);
+		if (error)
+			return error;
+
+		idmap = mnt_idmap(filepath.mnt);
+		dentry = filepath.dentry;
+		mnt = filepath.mnt;
+	}
+
+	error = mnt_want_write(mnt);
+	if (!error) {
+		error = vfs_fileattr_set(idmap, dentry, &fa);
+		if (error == -ENOIOCTLCMD)
+			error = -EOPNOTSUPP;
+		mnt_drop_write(mnt);
+	}
+
+	path_put(&filepath);
+	return error;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d45130eb022f6db460eea34a1f6e91db..e242ea39b3e63a8008bc777764b616fd63bd40c4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -371,6 +371,12 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
+				 struct fsxattr __user *ufsx, size_t usize,
+				 unsigned int at_flags);
+asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
+				 struct fsxattr __user *ufsx, size_t usize,
+				 unsigned int at_flags);
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
 asmlinkage long sys_epoll_create1(int flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..50be2e1007bc2779120d05c6e9512a689f86779c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 
+/* fs/inode.c */
+#define __NR_getfsxattrat 467
+__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
+#define __NR_setfsxattrat 468
+__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 469
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 7539717707337a8cb22396a869baba3bafa08371..aed753e5d50c97da9b895a187fdaecf0477db74b 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -139,6 +139,9 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+#define FSXATTR_SIZE_VER0 28
+#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
+
 /*
  * Flags for the fsx_xflags field
  */

-- 
2.47.2


