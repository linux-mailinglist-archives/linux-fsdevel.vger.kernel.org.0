Return-Path: <linux-fsdevel+bounces-61229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B1B56599
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 05:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CE91A22BC1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A52749DA;
	Sun, 14 Sep 2025 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0pjvupp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601B26F47D
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822269; cv=none; b=hq8giiRStPgy89C2sW0FALeczGSnB0fwBK+9yvPMewzbI+VryuF3DubZ5EPej63tAcDUMEa+TAA0oC8vxPoi96zcgHapJMA3dWtiFUrvKkgNinMVnYUHsD8Sha8STdIqBhf79AVEif5BExXF0j+ZldZs1cQMnwtcW7GGboohAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822269; c=relaxed/simple;
	bh=oKU/He6fgnkGxFwiXzfMSQvpywViA2YaDdh3D2HgJ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB74WzChtR5g4mNRNiYRM9KLv5baWz3nCQo0XfVcI2sqefM8lTfYOLeRfr5CsGUUY+AgqBz9uJRzuhHil+drIkf9x9BF+070SOz96YayUbLNlb/HA9Oy4/S7a50rXFV0nNDa5PVNYGudW/ocTWwsyXSrybjntj/esxGY1kG8+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0pjvupp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so5095535a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822264; x=1758427064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLgSWRUhBJ+Eb73oE0EhwiwscJ+skfUSjN5GwJ3O/gU=;
        b=Z0pjvupp9oiKINjNbyeuSobzmzNc3O235l4XZaJq6+xnV8xiQNvmcPRhTjA0wy8g9j
         1e/VnNr8qqUxIu704AIAXUk3hdIHvQA2i+7JMtdyUSLBNWCch2mJfUrX3kek54B00jIX
         cpkdx+SF3alQFdxuMwBpZmAMcBz1Fkvbhqc+rqW0oPJBw3vuPYmCSOvsKe8xp+b9RN/V
         gAdtsX4NIFWKTmhvWP3oEqv1ZMtJ8kBfRF67kPO2/akOjOYC2dMCZGY8BqZAd+ytSz+V
         h3rnckiFQSpaBVNrFt5iWUY1JpIoQK/ePVg8RRD6OraLlYp4RCO48NNQFUqRkIYcPgQk
         HyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822264; x=1758427064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLgSWRUhBJ+Eb73oE0EhwiwscJ+skfUSjN5GwJ3O/gU=;
        b=d9U+3gAlReyaGZ8/imWvWay5LpJWuB236z01pYP5VltajKTBvmWBxSLYVJuZRSKucF
         Qz5JtHlI/4zgquyx1oWiol9pWeLou9Cmap/Hx9ygTmr57W0HuDORxBYN+yYJ1reKX0bP
         dtPcAITZ5SdcVoiIDE70BnqsKrWSQ1sxlfu+rZM2v1URjQ/j8HB3Wo+GkvhECA0/5UH9
         NQSRtRQsF6/yDykkkk9ZPhBRjCVpBb3oPuiGnO33BTCjWaYAObSmyNBPnBUBWMxm69nr
         wPGa1x9zofdlRp93R3c5/nZIFt3XF59datJoA/cu9MGLZpPakqxWdocDjnBwbTWCOfl/
         e6gw==
X-Gm-Message-State: AOJu0Yy+nybNMc2MyRGgJkvEHXmDlNdPvujz0cj8KGXcr9AeuvJ8aV74
	WcNLmnhs9Kl/bYVW2pfb3Qhsx8qyCWSoCDPF16Hkxq+t818nMf2ChBDiPUf8QijC
X-Gm-Gg: ASbGncsDTk92HrOQpZ1HO9x4ehvKGQG1+sM/kFwyB60soWCbLJY4wQPpCr4G6rfm4Ls
	XT5emSoJFXhVb/E0+enca88mK2zzuA8djIHpEEM+UkFnmZI4VttY0plsUBW5L9VvTAl+gfLxLYX
	25c6Wc4GpWXyBAMGbzgTSAwJQrB/D7O7hkhY/RJL/43TnhCZncuPOJEKjgFhsz0/JNjJnqrtgXh
	1regejE9pXWvKQEG9j3thSJYFwU61ZTVPeMBiGaEMGwM4SHDtDnLUanYjXnhHI4KPDK3LK+iHAA
	rlZTaHk6vtv5x1su+LpAruRCG+bN4ko0AQHFapHR2WM5j4qjVADqOA6CjWyYGp29up1cttBxKDT
	yzkrEd0TXzZvj8RnZ6DlFRk26h/sXqQ==
X-Google-Smtp-Source: AGHT+IGOdPvfXOVddm8G6LJhfH2nNJDoTTLKR/3NE7kowNRoQPIuzhxmV+feQvXrrMYzfjsz5Ubcxg==
X-Received: by 2002:a17:906:a84d:b0:b07:cf04:8a43 with SMTP id a640c23a62f3a-b07cf049441mr520202566b.41.1757822263792;
        Sat, 13 Sep 2025 20:57:43 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b31287cesm676665366b.30.2025.09.13.20.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:57:43 -0700 (PDT)
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
Subject: [PATCH RESEND 50/62] init: rename ramdisk_command_access to initramfs_command_access
Date: Sun, 14 Sep 2025 06:57:38 +0300
Message-ID: <20250914035738.3741007-1-safinaskar@gmail.com>
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
 init/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index cbebd64f523c..a42f1f0fce84 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1587,11 +1587,11 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	int ramdisk_command_access;
-	ramdisk_command_access = init_eaccess(initramfs_execute_command);
-	if (ramdisk_command_access != 0) {
+	int initramfs_command_access;
+	initramfs_command_access = init_eaccess(initramfs_execute_command);
+	if (initramfs_command_access != 0) {
 		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
-			initramfs_execute_command, ramdisk_command_access);
+			initramfs_execute_command, initramfs_command_access);
 		initramfs_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.47.2


