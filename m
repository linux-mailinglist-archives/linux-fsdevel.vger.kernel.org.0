Return-Path: <linux-fsdevel+bounces-61218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA06B564C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 05:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313961A20AF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F32701CC;
	Sun, 14 Sep 2025 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8exd0Or"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04B26A0DD
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821874; cv=none; b=aBNV6muS88a5Y3gOSsSfRnVBWyJsMsJJd3kz0tIYVSpzz8dDTHvELYW7MiptYkkDDluxw8j4vPTETulHBaR9NiF4DAdZRz/uYI/8R3ldaSX30dAE4BidW1WOIcl76vaVOcEbUk2cOvplrF8RoJppPB2VGRcuesIKAzuGNgcpAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821874; c=relaxed/simple;
	bh=0pa06GJsqjKCCDz/UM3o5nwPqkgP4CqvzP324rR3v40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkDS61WvoHSorhkTMj9UDRM4XUsyIrh5P34v3hfMOSSGulQ6s0OsZOnNcADOgzFDxXA/mhaP1k9ZU1nyQMBiC13ZLZf6b99YydGqCB/shi40xOpsCL7W4/Ise0mPYXyQ5zaVeQu7tCyf1Hu1Xt8Lg5tE2WrPdHBlWW2binjowko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8exd0Or; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso92710766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821868; x=1758426668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=;
        b=Q8exd0Or+KP3IfpJ/F6cr04Z8ZzprXAK/vvOy0fDtx94X4VdoDeaLl53x+Re5XVu87
         nMyvaYDn8vFmTcEvvBxemBcs/KQak0F949JM4uH33s339OQt5URkPKDSAY3+ZGKOdjL5
         pUJ94likUMs0rBMqjlpvJwgZdJbK3S9flcLQ8zD5bq7g6BoxDcTYuO+f8U85RhZRiEFd
         NWgbXH/2vbui42YTjC9kWIfsAixItMc1GfQiwH5d3DjDt9wpiScun1VkZoezAqvc6RKI
         73MhrVf1ZHdX6nrAEPt0Dk6q5BbIrsUiJClkzy8cJCjt926MOo3foy+tV7x7JwQDnt3k
         Kq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821868; x=1758426668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgyNirakXvU+05rXEnyXXLzO67oYWYN1IcZHpjjqHUg=;
        b=bsVYC2OHOpAuB7KhDXv496ZHa4aHf46B3DNcaUh52sQUQi1gbw2qtiWrR2VDBU3F4N
         hLvR0xa8WoFeJNXegLgr2F1CKg0HsoDF52PyRgfxNUh77vRVc+X7meKs+a2qs98TcOTV
         GVSqxI+k+WSWdEc+sWa5ecRQcULRT+1i2t62kDH04tKqlP/NmCRu1NCGV18bSrNnj2g1
         A+oLGvB/SvueY/BnXvBGm67h9acZst6MTINOmqzAzQI12s9pYc5IbMP6j/jP00CIEPpS
         3c+TujjsOnQCtGhyrVisonKbVlntqSnQu830f7Eu1vvjNswHZQyXsAyV6wfbxUL3ZHVX
         eKZw==
X-Gm-Message-State: AOJu0YwqrhovYX5fO33ZXCGhKEDEN10o+qCxt0tKTloThlYu7KIRI/rX
	0bFl+PVDpUmp18jtDd0uypTAUTpK4tlQ39nnnH4JR9mlOwHGZZH+LWFnhBEp6N/o
X-Gm-Gg: ASbGnctBM3IGMQvH0lfSi5aUDSOaT75jNSk4FVmU+yxK/Mo2pT2ZMZtHlCeVCNqMu5e
	qOAk/blSK1LWi8O9TXAiGEtZCD9WJHHbie8zoCtipofT0coP5NMM8qouy9gIoHL1dD/y81wRF62
	buLiQVOvnymN5e8DyIrk1oFEyBObmpU4lA0oBqVN4GmqogIw8UX+cECrDQThdYTY0hEOKmBaHa9
	A8Mb5NI50rq+PL31rPlzCms3xPiHHJgilGec4/1Pu+Dctd9N0iBi95Kxyhmd/Rzslxw4ns2sns8
	ffMHYPznk4fj98/r2gHzoAKvDGOpyzG2a3t2ziLQq/yhPbmNE9pIaLu+WIMN+d+89McRcwCODX8
	Gi52NvOK3bcG3VYO/0dE=
X-Google-Smtp-Source: AGHT+IGYiK6likOM/TjE1BLl/jI3UX22nGT0EQIxF87CUWohx3tkGnMcAa8PzC4lwu+rbC2577QTfw==
X-Received: by 2002:a17:906:46c7:b0:b07:da17:79fd with SMTP id a640c23a62f3a-b07da178367mr507229866b.17.1757821868321;
        Sat, 13 Sep 2025 20:51:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347b6fsm679031866b.111.2025.09.13.20.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:51:07 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 39/62] init: make console_on_rootfs static
Date: Sun, 14 Sep 2025 06:51:03 +0300
Message-ID: <20250914035103.3619203-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/initrd.h | 2 --
 init/main.c            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 364b603215ac..55239701c4e0 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -23,6 +23,4 @@ extern unsigned long phys_external_initramfs_size;
 extern char __builtin_initramfs_start[];
 extern unsigned long __builtin_initramfs_size;
 
-void console_on_rootfs(void);
-
 #endif /* __LINUX_INITRD_H */
diff --git a/init/main.c b/init/main.c
index 58a7199c81f7..f119460bf8e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1533,7 +1533,7 @@ static int __ref kernel_init(void *unused)
 }
 
 /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
-void __init console_on_rootfs(void)
+static void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
-- 
2.47.2


