Return-Path: <linux-fsdevel+bounces-10400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2384AB05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A248CB21C25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000A4A11;
	Tue,  6 Feb 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="DV73vVZ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060133234
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178437; cv=none; b=U9hUmd1DHyDFc1vKva4lLGWxqbngzNR057k2vd6nyGZtpOtptiX+VTwr3KemFpfp8VlDAUb/6fD55RAfaj4G1Ij339qp0OIuVLcxYwHb+qsg7H2KOeiKkey7Q8FZPib8o9DMaUUwyDz6mpLu67TxdnGkFQMC86rXpcCl+JKCYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178437; c=relaxed/simple;
	bh=cP/4/UkSs0FwG35VQ63HkqzL1J7Rzl17TzuFmKODFxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toVXkrRZJHAf2MNWPdlSl7rESjJ5SsNARsR7PmZF8pWy4kwgMk0AKzR71b/SInw2nh3a6fTPDEq/nPCgDGd9daYpX1fbsE/1aj9kvay39/j4Wpjns5AuLC/0QbBvcE+e+D8AIvFulCUHrRp45setxWNNT9S7jI8eZ3U4XxaAsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=DV73vVZ9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fe00cb134so4418975e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 16:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707178432; x=1707783232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq/vJmgKCN4+43lqiOQvDvHZ5T2ZeE9RmH3a3i0S7t4=;
        b=DV73vVZ9DKsCo1N4zXBRa20dE3xhzfBc5afhHmDAfZlwaMj0/dHt+Xtirwkkc2YErX
         3wjEdI5FCmPq/Z/JiTVfpy8q8+rU16m5AtVa6/QGDz3cXi7/BTOwAWUVMuLQbWkYLjM3
         cQNzRVp9UgaHbLKMhWpt/jlMsnVZKRrvZ812vUNwlB5AxKXHtSUWyl3cvlCjtTLABeZA
         rzqxvuVPYRQpMiEQTw4qdeesteMzpS9+RUf9HoQvJ80WIG3QnDkXdGWougrMKfc3f5Ag
         g/4XLvJkRjZEXfSm2ZhJzsRzk6KVsPyH+rq/jA3RaEy2RxVJCoB0pl1CQcgYSiypTBL9
         HClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178432; x=1707783232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq/vJmgKCN4+43lqiOQvDvHZ5T2ZeE9RmH3a3i0S7t4=;
        b=cSyYHxHYeD8kzDrxX1i1TFfBznKLPrRRK+acWGvmH2bVsv6YeiU30/c5NDM1TF9N1a
         B033tHx6vILYBw3XWQSuhRG+elmEKzFdDbO0EtO5OQo9uD0jEzfj83CEGFb3wzlRtgd7
         GS89zcFe7gi3vCx8Z0SRQNLj8UE5CjVDlBByzt0NiUJCBWluatHKxXoENUu0hEmjIWVf
         I+KeOpxOZSVnKhiTS/bhnp1KwGQfkcb1KYs+0mZ0jcUXWH9UM8fMsiUpYFkJJnuu82Z3
         07YPc+DmwX27uGlF1HCs+9iKwILNSH61FhJ6jysghBfPGtr0IFuezT/aofZO1VcAZKrz
         ppJg==
X-Gm-Message-State: AOJu0YxKxfNEnMuhmRGMXhtFnCks6kcCPCiBs0PsbT3S3rMCxQlx5YhS
	jXA5TM9RBFoyZqWpqEmmKTTZn+MqWj4HmVYoMnsIaovpMzoDYZS6qInGCHO76sHTafewg1rY/nZ
	SxaxpMg==
X-Google-Smtp-Source: AGHT+IFDZiqZCqXSW50BaIopf3+TuvOXvtTei80hIpKW62aZOXV+z3L31NeRZ68PFAmNV5ntUy8n7g==
X-Received: by 2002:a05:600c:3110:b0:40f:b45c:85a5 with SMTP id g16-20020a05600c311000b0040fb45c85a5mr869848wmo.22.1707178432482;
        Mon, 05 Feb 2024 16:13:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYDtvhA0Pcloza39he5JBCyZ9ZNK63hXDPbN3A6qiXjD5eegCT4Hiiui8jpxnsrU7F7VMA1rUGYPCoOpELvpUR5ft3rDzXYQPgJNjz2ZCTH/2u0nwNEupG3BYZCvz5OXQur8AZC7CGZzHJ/PseuunTs2ADo8fnXRhdQY8+6IyalM+KnM7fsi0IE3VGosiQchIFbhB98tsMdgf+7Pi6ky0SAy+VJCQVFPXmvI3q9LwnA/YN3PB1i1sX4ZEAO2i//Ud0nZ/Y7jxvOm1Yg6eVytofID/X3IVEnQR+HTZiKlk3z5yBUg47/u6uJPC0BqYAIKJ9l9C0KA4FBi8AxBW5R298mN7c0Y1PZFG3HvysZFKjD0TX/XCEC+gf/NiTIuE57Inq5TSgXFM5Nno0IrzinWh0FgcjkD08JIFQmOoECuRTvev4H77qevmMM7nEJq9Xs0vuMdxSf/d028tk5qqhQc6A+glC7zrvpOf67ulDMwIHelwOpGVxI/t8veno+pXAlTR0duQLk21qtv3JC3sodp+urRyDPz1SjfNAzmBjHzGIdrSPv+4Z8PbKZNgKGNLZV/yXIZNDx1afSLvGRmrvOhkF0BA+fWbseCXp6mDC9CRbJXFlwEGg2vjH9TB94mHntEXv47BGPvK56PiZLykunFjGzO5oQMBLvFGiG9sD1iHaygnBGLZ2kUMFMKxdeQ43/EsS/UkSsd31X29MSfAp4nO5pf7hcVQ8QJkdN2hQi+jSZgGgHgUt/Z5HGN4SzOHU70co4R1NyQwK1IVXmc4i41oaWaspAPQ=
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b0033ae7d768b2sm686959wrq.117.2024.02.05.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:13:51 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v4 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
Date: Tue,  6 Feb 2024 01:13:32 +0100
Message-Id: <20240206001333.1710070-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206001333.1710070-1-yoann.congal@smile.fr>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_BASE_SMALL is currently a type int but is only used as a boolean.

So, change its type to bool and adapt all usages:
CONFIG_BASE_SMALL == 0 becomes !IS_ENABLED(CONFIG_BASE_SMALL) and
CONFIG_BASE_SMALL != 0 becomes  IS_ENABLED(CONFIG_BASE_SMALL).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
NB: This is preliminary work for the following patch removing
CONFIG_BASE_FULL (now equivalent to !CONFIG_BASE_SMALL)

v3->v4:
* Split "switch CONFIG_BASE_SMALL to bool" (this patch) and "Remove the redundant
  config" into two patches
* keep CONFIG_BASE_SMALL instead of CONFIG_BASE_FULL
---
 arch/x86/include/asm/mpspec.h | 6 +++---
 drivers/tty/vt/vc_screen.c    | 2 +-
 include/linux/threads.h       | 4 ++--
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 8 ++++----
 kernel/futex/core.c           | 2 +-
 kernel/user.c                 | 2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a8d338d..c01d3105840cf 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -15,10 +15,10 @@ extern int pic_mode;
  * Summit or generic (i.e. installer) kernels need lots of bus entries.
  * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
  */
-#if CONFIG_BASE_SMALL == 0
-# define MAX_MP_BUSSES		260
-#else
+#ifdef CONFIG_BASE_SMALL
 # define MAX_MP_BUSSES		32
+#else
+# define MAX_MP_BUSSES		260
 #endif
 
 #define MAX_IRQ_SOURCES		256
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 67e2cb7c96eec..da33c6c4691c0 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -51,7 +51,7 @@
 #include <asm/unaligned.h>
 
 #define HEADER_SIZE	4u
-#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
+#define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
 
 /*
  * Our minor space:
diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f18..1674a471b0b4c 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -25,13 +25,13 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
+#define PID_MAX_DEFAULT (IS_ENABLED(CONFIG_BASE_SMALL) ? 0x1000 : 0x8000)
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
  * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
-#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
+#define PID_MAX_LIMIT (IS_ENABLED(CONFIG_BASE_SMALL) ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
 
 /*
diff --git a/include/linux/udp.h b/include/linux/udp.h
index d04188714dca1..b456417fb4515 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -24,7 +24,7 @@ static inline struct udphdr *udp_hdr(const struct sk_buff *skb)
 }
 
 #define UDP_HTABLE_SIZE_MIN_PERNET	128
-#define UDP_HTABLE_SIZE_MIN		(CONFIG_BASE_SMALL ? 128 : 256)
+#define UDP_HTABLE_SIZE_MIN		(IS_ENABLED(CONFIG_BASE_SMALL) ? 128 : 256)
 #define UDP_HTABLE_SIZE_MAX		65536
 
 static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b16..3f81ee5f9fb9c 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1141,7 +1141,7 @@ static inline void xa_release(struct xarray *xa, unsigned long index)
  * doubled the number of slots per node, we'd get only 3 nodes per 4kB page.
  */
 #ifndef XA_CHUNK_SHIFT
-#define XA_CHUNK_SHIFT		(CONFIG_BASE_SMALL ? 4 : 6)
+#define XA_CHUNK_SHIFT		(IS_ENABLED(CONFIG_BASE_SMALL) ? 4 : 6)
 #endif
 #define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
 #define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
diff --git a/init/Kconfig b/init/Kconfig
index d50ebd2a2ce42..d4b16cad98502 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -734,7 +734,7 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 0 if BASE_SMALL != 0
+	default 0 if BASE_SMALL
 	default 12
 	depends on PRINTK
 	help
@@ -1941,9 +1941,9 @@ config RT_MUTEXES
 	default y if PREEMPT_RT
 
 config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
+	bool
+	default y if !BASE_FULL
+	default n
 
 config MODULE_SIG_FORMAT
 	def_bool n
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1e78ef24321e8..06a1f091be81d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1150,7 +1150,7 @@ static int __init futex_init(void)
 	unsigned int futex_shift;
 	unsigned long i;
 
-#if CONFIG_BASE_SMALL
+#ifdef CONFIG_BASE_SMALL
 	futex_hashsize = 16;
 #else
 	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
diff --git a/kernel/user.c b/kernel/user.c
index 03cedc366dc9e..aa1162deafe49 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
  * when changing user ID's (ie setuid() and friends).
  */
 
-#define UIDHASH_BITS	(CONFIG_BASE_SMALL ? 3 : 7)
+#define UIDHASH_BITS	(IS_ENABLED(CONFIG_BASE_SMALL) ? 3 : 7)
 #define UIDHASH_SZ	(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
-- 
2.39.2


