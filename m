Return-Path: <linux-fsdevel+bounces-44393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B967FA6814E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817B07ABD70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3A1D5AC6;
	Wed, 19 Mar 2025 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="m/qlmE01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92B1C6F70
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343354; cv=none; b=dQg0ijF3nxkNC9Ijf14j4QW2p2aVocEvIMRgtQg4Y7Ky/0IfLjpKalEY74A4ySNMaJEK34WAYx2YKze1kl89+bZxrX8O+ubOEQ8bQBb5a3Xtf1or3YoV1jssIbYq+vSr/qtPo59Dg0tuGmNTXWXMjs6t7717qdGxIU9t6V8IPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343354; c=relaxed/simple;
	bh=HrvGzL7SpIoKoXo8zFH3/CZ1R1e6uAmq2pNYC7W0pqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awFghX89h2AWmCGeAOK/lPh7FRSQtMjp6exXRA6AbV1JiNEe3VJK3tYl5kfT2DOqrjMiFCRyuYwf1D3vNZIL+JQoCisv++SZGY3HmRjS3tCI6Z8LbPtKRkdDJRAQPHfHmsu0tzySkmacuxbQ2jiZa8G2KWufuH05aVKc112pxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=m/qlmE01; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-226185948ffso55129895ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343352; x=1742948152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB6CanLMGY6mZXQkGX+cRiOusq9nkfF+ZzLXVJxU5Ns=;
        b=m/qlmE01QBk73ZOy9TB4yXQm4sUA0jAbyaT/jF8KepjyZbRTrU0uBgcxtOf6cVlu5c
         ANbs1eibefl9/qap2HWUJfRvQyAWAnUA2eygVhhEYk+N/f6lvrlN1EKxZvE1TQikOfW6
         7i4/ftSypVjjHjHpcaCoIx6Qy13ufcEWt+RBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343352; x=1742948152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZB6CanLMGY6mZXQkGX+cRiOusq9nkfF+ZzLXVJxU5Ns=;
        b=CHBaqnS/BXxcPLRP/ZEC/+YsRTRjNRUzlJkvqCawceLNrKLFnBolVo09TUKXvj4pbP
         0q/tQR1MEAb0ddoe1pW/tfDHyo5CYGYtjbQDGMTqWbvktI8Ue049R07HG3tVcH4KLbae
         aVgNNDs4M8ov4Gx/t+8VAEHkInCGTWHaVthvSNKvKldeRzBGHHHNQlWzRgy5mwYGzQWR
         lvBIzNAMg19sl9wlMw5c7Wd6AFqtpVLCB4pQioiffCecoorvH5K7ySrnmCiEUqyFMsuy
         YAGxhzQqRg4kzKbcFUNTRNDSCVkHo2+oGWfk8xEziNSFBzxzg2gJjjThDmtxMmLO+6ib
         PmDw==
X-Forwarded-Encrypted: i=1; AJvYcCV3HkLBXGNST8ONJti4AQL9DpMHJygG5jM9rrBapQtJsb977baFfDx7pwL3Su31GghDCvYiBcmPo3h+BwYM@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIOXxWi+C/CmjvyX9ZLxeton11QIocYZ3XWDjFKUg1J4pqiUQ
	LKp8QkcxcirSuFKRmk8no5dgpcCfC+VieBKeP/GK4ACg/ojpGjGuCSQ2vTccXxw=
X-Gm-Gg: ASbGncv6R8Sc/sJC/+SK6O0SOLsC7is13cdDj5ZnEt4SiClR4lyGtgc4gkiB2fw5zYU
	uOPITJvNKUju+lmNyLIe3C1UnNE2iuAdjtMbEpwNUlVaEjTxT1cnFdfN21mj93slnAVqe93AptX
	8xjxXdNbsKtVngW0YUbOZVKjtG8Kc/yV//Qx3XgfC+In1qIWGebUTiR9gWUt28fiwpPuepEW5Ut
	ZWnOd0UnCt9bU1PIuY97J3Hbo8ROzLD+aJVRjz57WAULJTtzgMD/iiFzYzEtdaazprTzi9ndXEi
	6HOQyh0YgwFw0Up0xJU9R3vWEYn3JfspX2Dt0nE6Ve3lDIvBnWQm
X-Google-Smtp-Source: AGHT+IGEjgNr8OXukMKpiMZiFHzun0R5NaGz3kNl/a4hrPUj8a+pmGVK3Inx5pRS8JA4nLBMKEl0Gg==
X-Received: by 2002:a17:902:db12:b0:223:49cb:5eaa with SMTP id d9443c01a7336-22649a46a18mr10979595ad.35.1742343351630;
        Tue, 18 Mar 2025 17:15:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:51 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 09/10] fs: Add sendfile2 syscall
Date: Wed, 19 Mar 2025 00:15:20 +0000
Message-ID: <20250319001521.53249-10-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sendfile2 system call is similar to sendfile64, but takes a flags
argument allowing the user to select either a default sendfile or for
sendfile to generate zerocopy notifications similar to MSG_ZEROCOPY and
sendmsg.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/tools/syscall_32.tbl             | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/linux/syscalls.h                    | 2 ++
 include/uapi/asm-generic/unistd.h           | 4 +++-
 scripts/syscall.tbl                         | 1 +
 19 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c59d53d6d3f3..124313c745b6 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -506,3 +506,4 @@
 574	common	getxattrat			sys_getxattrat
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
+577	common	sendfile2			sys_sendfile2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 49eeb2ad8dbd..ca61b5792148 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -481,3 +481,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 69a829912a05..71695a61a1df 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -478,3 +478,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f5ed71f1910d..6096a22b4472 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -466,3 +466,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 680f568b77f2..0429dc26ceee 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -472,3 +472,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0b9b7e25b69a..f6571c8ecb15 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -405,3 +405,4 @@
 464	n32	getxattrat			sys_getxattrat
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
+467	n32	sendfile2			sys_sendfile2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c844cd5cda62..532ce99478ee 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -381,3 +381,4 @@
 464	n64	getxattrat			sys_getxattrat
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
+467	n64	sendfile2			sys_sendfile2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 349b8aad1159..9cacbbff6b12 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -454,3 +454,4 @@
 464	o32	getxattrat			sys_getxattrat
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
+467	o32	sendfile2			sys_sendfile2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index d9fc94c86965..ca5a3e6eb8f3 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -465,3 +465,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index d8b4ab78bef0..450392aed1eb 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -557,3 +557,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e9115b4d8b63..e7e1b16f4d39 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 464  common	getxattrat		sys_getxattrat			sys_getxattrat
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
+467  64	sendfile2		sys_sendfile2			-
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c8cad33bf250..c75a0e69c033 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 727f99d333b3..fd15465b5330 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -512,3 +512,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2fba7e2..f711ee6068ec 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -472,3 +472,4 @@
 464	i386	getxattrat		sys_getxattrat
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
+467	i386    sendfile2		sys_sendfile2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c7..0ba4edb1e4c0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,6 +390,7 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
+467	common  sendfile2		sys_sendfile2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 37effc1b134e..142597c92baf 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	sendfile2			sys_sendfile2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d451..3ee0e997d6c6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -491,6 +491,8 @@ asmlinkage long sys_pwritev(unsigned long fd, const struct iovec __user *vec,
 			    unsigned long vlen, unsigned long pos_l, unsigned long pos_h);
 asmlinkage long sys_sendfile64(int out_fd, int in_fd,
 			       loff_t __user *offset, size_t count);
+asmlinkage long sys_sendfile2(int out_fd, int in_fd,
+			      loff_t __user *offset, size_t count, int flags);
 asmlinkage long sys_pselect6(int, fd_set __user *, fd_set __user *,
 			     fd_set __user *, struct __kernel_timespec __user *,
 			     void __user *);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 88dc393c2bca..ec0ac5a8d519 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -849,9 +849,11 @@ __SYSCALL(__NR_getxattrat, sys_getxattrat)
 __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
+#define __NR_sendfile2 467
+__SYSCALL(__NR_sendfile2, sys_sendfile2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 468
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index ebbdb3c42e9f..1911a64d3b33 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -407,3 +407,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common  sendfile2			sys_sendfile2
-- 
2.43.0


