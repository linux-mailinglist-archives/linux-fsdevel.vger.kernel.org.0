Return-Path: <linux-fsdevel+bounces-61217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC6B564B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 05:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA81A20774
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9026F47D;
	Sun, 14 Sep 2025 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1P8kBWK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E54268C73
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821840; cv=none; b=fJTlAwZU7JakQBMXKZIaQ64ZKjJ+QFvTNjKmbX5AgaCAmGhLlbr/y4HMVCLSPJzHhlb5oDRgQisVyBIUpLmHRMperAsNmn9mnrE+m/nRKEBzZZlzIlbvWBcX6NTWQHczkkDWZh5ApJxpJsB4f/rILH9coASfUqw1IkKMjQ2tklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821840; c=relaxed/simple;
	bh=UKYo3sZQHTOBTzj/ZrSKU3L73PiTPpOmU1LUHeX039A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4nLvKVMxnoM2VAFrqXV0v430ddRijJqSwEIQ2G5bCVOV5pBBeIwjY6yRT4XFnOajED6CfmPeYR1/GbuyvcWIbmqmJhEdk2vXA973b5SL/A+Z9PCUwl0AsvmCn0VdKbc2Sck2vz1zUwH/44PMn/SigFss+NdYDYMGh/zeIsvYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1P8kBWK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f1987d446so947720a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 20:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821833; x=1758426633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xULsRy9EzPzDuVUBFXoTlnqFZHMdg+FSwp5f1Vonn0Q=;
        b=a1P8kBWKhC/YGuTQ1qtgdu/eEmNliJm6xmjHlAYF/nZVCc+MkYl483G0Hq/aOPOuVQ
         co1t+z2BxO/DqCnrZV/EXoLvGXKtEHZqFdATOOJ7EzTdu3MgJ41k6O6rnPR886VF0J+g
         jgvNa+Ki1aT0KILtz2E0BMca3UYgzXBOakUCCFuFTU7ebx7Nd0hzzslIgv4hyWtZH0Us
         YbZQmnVSwIBoXEECRLCw5/S9dNhg9pi/sa5YxeFeAtv7H0GbAy2fZWrU6+0CkFOt7mcb
         RR3YbY8LMKAJx2sciiyJGNfQKUPjHVakvWWvmZVaCaVDH0xUngt3/RwvkIeU1VGaFSWY
         JGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821833; x=1758426633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xULsRy9EzPzDuVUBFXoTlnqFZHMdg+FSwp5f1Vonn0Q=;
        b=Brz+WljJJFaFIsR67yLaJWwjRtk6C9LwFAXKg12akL+HFTFnm8e5BeP/3wHeTUcN9w
         0kx0yCdnzAOxEADXx7myvH66ajxRzi2JNuAOj41RQTWHRy+v/Vu07ce6vqsAz6Eq/uNy
         clX/bqMPE0KlmrckUuFomBQ2Y5SzN+vgmgR9Hw4AVTVdTKiNMg8DwNs3A9pt5YrVX105
         JPmlCFzxov6nZVoc514WIwufqnbR3+CN92eWXeVwBBYQrWaWwcSipnvc10eoD/SrOKgU
         7xX2IPQqs9Dtz/8LC9tBMH4P80oYJldYy9dOpTfCX0j0tl3y88quhCBSnMCnDgdIMaQy
         xWXQ==
X-Gm-Message-State: AOJu0Yw1qGRNwjj2MzvLuhDeIJCVPBlUtqqUDTMRItaRzc8mVFiNKHKY
	4Q6zClU2defmHDfVEwGf8mJ18JO+mG8IuXllApC9Gt3nq3fX8PpCgrHr0v7Xk/9W
X-Gm-Gg: ASbGnctrK1YmCwwSKJvmDhFYGKd/TbuX3r/2hUcysmKZvLxaKmzY0kEsRJ6pt5X9WPw
	9JiEgHX0B3sMbLrTk2KQop+GmWjnlZPYpJ6Dw/XVw8GqeB1RLhpGmLQbNnnyu9UzSy5KM7r5TiS
	ly9RlcvOknD+xdNN+WgB4NBU/xo0R3p6IrxPhlCm9JUSgObHN2toQiKnEf0uKyxPKdHbxDYZg/f
	qEfUgm/2vufDEhHYTizql9Pr+nqlrLcMLIvy2O0s8m9cYow2VjGvJa9Vuv/S/4TOfNksLLoMGFu
	AMWD+5dkY0c3tOep4oe+Nvu/vpYDH+7cPRBXe1x8i4iGj4pHQ0Etki85W3x21ExISJgmsBI/YA5
	ZvpaV0IHHViXPHiu/mXf4+gLsIMArww==
X-Google-Smtp-Source: AGHT+IHE3K7efxQ+hk8pVBE6YY31PD4G3LjwwPuEi1DqCDNI+Ud0foCSPIjpPnt40T661VaNMc1/Ow==
X-Received: by 2002:a17:907:3e8c:b0:b07:8836:dea9 with SMTP id a640c23a62f3a-b07c3819dc5mr855439466b.39.1757821832889;
        Sat, 13 Sep 2025 20:50:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd3efsm668828766b.55.2025.09.13.20.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:50:32 -0700 (PDT)
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
Subject: [PATCH RESEND 38/62] init: remove most headers from init/do_mounts.h
Date: Sun, 14 Sep 2025 06:50:27 +0300
Message-ID: <20250914035027.3609569-1-safinaskar@gmail.com>
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
 init/do_mounts.c |  2 ++
 init/do_mounts.h | 10 ----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7ec5ee5a5c19..5b55d0035e03 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -5,12 +5,14 @@
 #include <linux/fd.h>
 #include <linux/tty.h>
 #include <linux/suspend.h>
+#include <linux/blkdev.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
 #include <linux/mount.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/fs.h>
 #include <linux/initrd.h>
 #include <linux/async.h>
diff --git a/init/do_mounts.h b/init/do_mounts.h
index e225d594dd06..53e60add795a 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -1,14 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/kernel.h>
-#include <linux/blkdev.h>
-#include <linux/init.h>
-#include <linux/syscalls.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/mount.h>
-#include <linux/major.h>
-#include <linux/root_dev.h>
-#include <linux/init_syscalls.h>
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-- 
2.47.2


