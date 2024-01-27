Return-Path: <linux-fsdevel+bounces-9226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3983F067
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 23:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBBC1C22504
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB691B978;
	Sat, 27 Jan 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="aiK+ui9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83C1B7EE
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392871; cv=none; b=M3Ecnqa6WQEHgxc41FOkNOPWGdod4x8v+3uD0sHLTuLTQAWcTmAxydlHidsoIkjdOJI4WEqYxpsEQEwfvNROOdXJF+oVFHMoQKlrFMj+zU/fkNI97iNJuYKMUDx5XSc6aLlN9Mw0o15pfPax6+8QRl/pfAh1V8hJl4nrUA1U9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392871; c=relaxed/simple;
	bh=i2YafAS6UswvrfbzFXcODF8OztRsn1M/mcDkytvk/xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EbWrKvo+CcfBENNXJLIC1mmGvrsNUmNiLY+Kp+TVsi+OelQOSdXC1uO7gy7HbJcPydY/FZRi8Kbp7ylKcJkYWBnhwaYbF2HrnTsiYjkXfbYdb4QqEuH2fEL9IbSpzDr/g7bfJONyiqg0w3QFA9G5j2A34SSFPyHM0PV/bLan5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=aiK+ui9L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33921b95dddso1678997f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1706392867; x=1706997667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VC19HgC2xBJYYLj2MNIq83FdLrZUDryfrK5B88v0kp0=;
        b=aiK+ui9LKgFOpV0pF01GQmSuAu5bvYjeZy8Ak/3pdeBkxQGL50rSvE23eoCjJLsAR4
         gf9r/9EPW9e1bTrrTferkPIFrYRQTIDe+uAxbRFEVfIWbfTk9+8QbwhCPSi3cNdzClJK
         H8RoIAaJ2MRyZHy+Gn7Xse+7RX7xyVYooUODuGIlMs+jk9NIa+NloOoPgLma5fsuXyTs
         Qkv4j+/cSxS9bRFhwL2+Khencqio74W57UvFu+kdO1ZHLgGcglcFh2nueuOfUkvuA3z1
         9yVx1mrlkcP0cPlBWhuXtabd/5JAtXFhVBStpziztD9xDjSfcUtoDexPvGNrG7jlq6NL
         TD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706392867; x=1706997667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC19HgC2xBJYYLj2MNIq83FdLrZUDryfrK5B88v0kp0=;
        b=ZjZhFCGyqa1081Aauo1i6jfiqpnixgtjsNDR0QMb5dXQsRZyMzJCDCPDJGkq7Bp7Ym
         TWB+9cPp5Oh61lCAQFG5Jel1lj8tGWqDx4iYwOO0f8B/f4uRLyhGkmoHzUOeeGkEOEoZ
         LSawLsGBg83aTVTAvjv6Xg0a9CmCJRLDcWOUM/NfJZqt40U/GPFdJMinG/9vPG0UVh6Y
         6tdkPndLLyLGPlLzicZ0Y2Fu//bgBCbItcShv4CnyTVSi/A3YpOjQTkWc/VlFX0rvJIg
         nVorG+AzHfb8Dmg9TftkoUsrNUxmltDP8JIUYW+2ifhThlfLxRGqPdIr/sUDQ8FRfnBQ
         dYZw==
X-Gm-Message-State: AOJu0Yx6xGEUYhL23Svwy7F4/kwDHvx9cbPBpOOkPZDl6EkXDPRrtn1p
	TZZCNXSzA7OWkVfeIYt2Xs1dvx529ShiXRMgQkl7yEqNIb0nTnZBtTubxMwKqIw=
X-Google-Smtp-Source: AGHT+IEL8BSf5/b5rbuUtydWIGRDvMV929M5hAmGFiamdPtG2TRCQQafl5M+m4ldCG5GSLh3CS2ITA==
X-Received: by 2002:adf:f24c:0:b0:33a:e3ac:60d4 with SMTP id b12-20020adff24c000000b0033ae3ac60d4mr772227wrp.15.1706392865887;
        Sat, 27 Jan 2024 14:01:05 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b0040e541ddcb1sm5755532wmg.33.2024.01.27.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 14:01:05 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	Yoann Congal <yoann.congal@smile.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] printk: Remove redundant CONFIG_BASE_SMALL
Date: Sat, 27 Jan 2024 23:00:26 +0100
Message-Id: <20240127220026.1722399-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
equivalent to !CONFIG_BASE_FULL.

So, remove it entirely and move every usage to !CONFIG_BASE_FULL.

In addition, recent kconfig changes (see the discussion in Closes: tag)
revealed that using:
  config SOMETHING
     default "some value" if X
does not work as expected if X is not of type bool.

CONFIG_BASE_SMALL was used that way in init/Kconfig:
  config LOG_CPU_MAX_BUF_SHIFT
  	default 12 if !BASE_SMALL
  	default 0 if BASE_SMALL

Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 to
CONFIG_LOG_CPU_MAX_BUF_SHIFT=0 for some defconfigs, but that will not be
a big impact due to this code in kernel/printk/printk.c:
  /* by default this will only continue through for large > 64 CPUs */
  if (cpu_extra <= __LOG_BUF_LEN / 2)
          return;

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")
---
v1 patch was named "treewide: Change CONFIG_BASE_SMALL to bool type"
https://lore.kernel.org/all/20240126163032.1613731-1-yoann.congal@smile.fr/

v1 -> v2: Applied Masahiro Yamada's comments (Thanks!):
* Changed from "Change CONFIG_BASE_SMALL to type bool" to
  "Remove it and switch usage to !CONFIG_BASE_FULL"
* Fixed "Fixes:" tag and reference to the mailing list thread.
* Added a note about CONFIG_LOG_CPU_MAX_BUF_SHIFT changing.

CC: Luis R. Rodriguez <mcgrof@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Darren Hart <dvhart@infradead.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: "André Almeida" <andrealmeid@igalia.com>
CC: Masahiro Yamada <masahiroy@kernel.org>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-serial@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-kbuild@vger.kernel.org
---
 arch/x86/include/asm/mpspec.h | 2 +-
 drivers/tty/vt/vc_screen.c    | 2 +-
 include/linux/threads.h       | 6 +++---
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 9 ++-------
 kernel/futex/core.c           | 6 +++---
 kernel/user.c                 | 2 +-
 8 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a8d338d..44307fb37fa25 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -15,7 +15,7 @@ extern int pic_mode;
  * Summit or generic (i.e. installer) kernels need lots of bus entries.
  * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
  */
-#if CONFIG_BASE_SMALL == 0
+#ifdef CONFIG_BASE_FULL
 # define MAX_MP_BUSSES		260
 #else
 # define MAX_MP_BUSSES		32
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 67e2cb7c96eec..d0e4fcd1bd8b5 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -51,7 +51,7 @@
 #include <asm/unaligned.h>
 
 #define HEADER_SIZE	4u
-#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
+#define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_FULL) ? PAGE_SIZE : 256)
 
 /*
  * Our minor space:
diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f18..f0f7a8aaba77d 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -25,14 +25,14 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
+#define PID_MAX_DEFAULT (IS_ENABLED(CONFIG_BASE_FULL) ? 0x8000 : 0x1000)
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
  * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
-#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
-	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
+#define PID_MAX_LIMIT (IS_ENABLED(CONFIG_BASE_FULL) ? \
+	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT) : PAGE_SIZE * 8)
 
 /*
  * Define a minimum number of pids per cpu.  Heuristically based
diff --git a/include/linux/udp.h b/include/linux/udp.h
index d04188714dca1..ca8a172169019 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -24,7 +24,7 @@ static inline struct udphdr *udp_hdr(const struct sk_buff *skb)
 }
 
 #define UDP_HTABLE_SIZE_MIN_PERNET	128
-#define UDP_HTABLE_SIZE_MIN		(CONFIG_BASE_SMALL ? 128 : 256)
+#define UDP_HTABLE_SIZE_MIN		(IS_ENABLED(CONFIG_BASE_FULL) ? 256 : 128)
 #define UDP_HTABLE_SIZE_MAX		65536
 
 static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b16..7e00e71c2d266 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1141,7 +1141,7 @@ static inline void xa_release(struct xarray *xa, unsigned long index)
  * doubled the number of slots per node, we'd get only 3 nodes per 4kB page.
  */
 #ifndef XA_CHUNK_SHIFT
-#define XA_CHUNK_SHIFT		(CONFIG_BASE_SMALL ? 4 : 6)
+#define XA_CHUNK_SHIFT		(IS_ENABLED(CONFIG_BASE_FULL) ? 6 : 4)
 #endif
 #define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
 #define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b1..877b3f6f0e605 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -734,8 +734,8 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 12 if !BASE_SMALL
-	default 0 if BASE_SMALL
+	default 12 if BASE_FULL
+	default 0
 	depends on PRINTK
 	help
 	  This option allows to increase the default ring buffer size
@@ -1940,11 +1940,6 @@ config RT_MUTEXES
 	bool
 	default y if PREEMPT_RT
 
-config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
-
 config MODULE_SIG_FORMAT
 	def_bool n
 	select SYSTEM_DATA_VERIFICATION
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e0e853412c158..8f85afef9d061 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1141,10 +1141,10 @@ static int __init futex_init(void)
 	unsigned int futex_shift;
 	unsigned long i;
 
-#if CONFIG_BASE_SMALL
-	futex_hashsize = 16;
-#else
+#ifdef CONFIG_BASE_FULL
 	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
+#else
+	futex_hashsize = 16;
 #endif
 
 	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
diff --git a/kernel/user.c b/kernel/user.c
index 03cedc366dc9e..8f39fd0236fa0 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
  * when changing user ID's (ie setuid() and friends).
  */
 
-#define UIDHASH_BITS	(CONFIG_BASE_SMALL ? 3 : 7)
+#define UIDHASH_BITS	(IS_ENABLED(CONFIG_BASE_FULL) ? 7 : 3)
 #define UIDHASH_SZ	(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
-- 
2.39.2


