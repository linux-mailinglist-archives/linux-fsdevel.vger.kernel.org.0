Return-Path: <linux-fsdevel+bounces-9078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD4F83DEC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A94B24827
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA781DDF8;
	Fri, 26 Jan 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="KFoEJSn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554991DDFA
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286649; cv=none; b=EHkOkJMNf5ZyNQ+BH94e4QtPPHs5CKOXFo7P+dddarxBT+3Z71hCKWnqNphkGf0Yz/dlYORTLKRwvBCmGwcxllF0nh5Ao/Kh62+VKYNFNL0kzd7OnBBWCiDidY9dqr/4kh8z2ESelrhOnVkPFTuNNMtvo6VY2/XVjl6VrdqeYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286649; c=relaxed/simple;
	bh=e4P27LVIoLu447WxGDoBfB8TV0IwjkIO9iwplgiRTRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G/R6iTkCjlZfTk8vcNqhiTZyGxZFOg3Hl1wtEiwE+9KIh0bLXqA+FNq10/if8SO2F3WM/Nw68kQj5vzjv6zvAdcH5d731gmY1ZDw+d331VVArZozD4rGxrxlLOZAvjSzfLhZzaMLEb1a2tnnHH1OoW6hPerV7XYHfoLnmRlKL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=KFoEJSn2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so9321135e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1706286643; x=1706891443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUy3Rwm9maFk8GP2x854tHf75dVLpNSbOLWxYX7ax5o=;
        b=KFoEJSn2+NEXu+7uSAEIRaq3hq+MzWy0GZH54qlj+8NgLP03R9c7dJhtpHRx1VPWie
         0qLcu+iaYrYc0ShiTf98eWcwiwuENAw8HBSKWaGpSJH3Qi1r1r91dUHl5obJJ/H0wk+I
         UgMI31BifIvGcX0qS2HzcuaHK+m4J2GvT1TOQ3WYcOACA+UKD2dDNVMJHZvHweHgCuZW
         yi2HuVF74dg3eJ6AenNcBklLYWa26y0XVI0GJFPaQLBerJA4H7R5WcAuVt7+yf9KW0oT
         5zO9P3DtDByr2OsknZK426cpNz/OilgWiLHw7MNYzO50f1ritlJ7WWWbBTUL1KxC4eQB
         orjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706286643; x=1706891443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUy3Rwm9maFk8GP2x854tHf75dVLpNSbOLWxYX7ax5o=;
        b=JrJ3tAGwZWuPpYWCjjilkhWandwcR7TAjTevUtJ9aNQqlNfDDkMNqP15GyILEEM1l7
         pSCOGaREu2asez35QivTTtJ+QuvO2ZtyNOSsWYZQ3xCoDfmq9u1Y+cC6MR46ZSgi8ysM
         dxccpqxe5HW67/3wCUqEnm5VFAUAwpKEAABfPLgf5ogiwdW9k+HwNXCybVOnHepXXvTd
         /OK/pNXe3NQkGAjKlRQEErDezj8sMX5rUUr/MK8WoqOlFu60FSHBQyxJZiKVpL/UR0a8
         pdyKLP8rS5xE8Au0QKEx7cwrUvyhreAYGksMA4xsupdLTeLTqNEm5fk9Iqf2uXB0+s/7
         ATYg==
X-Gm-Message-State: AOJu0YwCCHHkpKnZz3fvgNAWaVLFKJe8fOQkxbgCwc8xdaDX45HS40JB
	qSGk2gpmSOEApElSyboPOJKXO592+1gZ/zbt0hPmTlid/Z2vUSv+JcFJoFgmmHU=
X-Google-Smtp-Source: AGHT+IHKrnM6QdGCuLACvBQlPCI1fRERqYVbqvlykdiDAUVmDp7BbX1i59uxODRv8YnFlIpKfqkT3g==
X-Received: by 2002:a05:600c:a385:b0:40e:e793:8f9 with SMTP id hn5-20020a05600ca38500b0040ee79308f9mr30020wmb.134.1706286643360;
        Fri, 26 Jan 2024 08:30:43 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b0040ea875a527sm2337557wmq.26.2024.01.26.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:30:43 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	Yoann Congal <yoann.congal@smile.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: [PATCH] treewide: Change CONFIG_BASE_SMALL to bool type
Date: Fri, 26 Jan 2024 17:30:32 +0100
Message-Id: <20240126163032.1613731-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CONFIG_BASE_SMALL is currently a type int but is only used as a boolean:
CONFIG_BASE_SMALL == 0 vs CONFIG_BASE_SMALL != 0.

So change it to the more logical bool type.

Furthermore, recent kconfig changes (see Fixes: tags) revealed that using
  config SOMETHING
     default "some value" if X
does not work as expected if X is not of type bool.

CONFIG_BASE_SMALL is used that way in init/Kconfig:
  config LOG_CPU_MAX_BUF_SHIFT
  	default 12 if !BASE_SMALL
  	default 0 if BASE_SMALL

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
Fixes: 6262afa10ef7 ("kconfig: default to zero if int/hex symbol lacks default property")
Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")

---
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
 include/linux/threads.h       | 4 ++--
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 6 +++---
 kernel/futex/core.c           | 2 +-
 kernel/user.c                 | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a8d338d..ebe4b6121b698 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -15,7 +15,7 @@ extern int pic_mode;
  * Summit or generic (i.e. installer) kernels need lots of bus entries.
  * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
  */
-#if CONFIG_BASE_SMALL == 0
+#ifndef CONFIG_BASE_SMALL
 # define MAX_MP_BUSSES		260
 #else
 # define MAX_MP_BUSSES		32
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
index 8d4e836e1b6b1..766a7ac8c5ea4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1941,9 +1941,9 @@ config RT_MUTEXES
 	default y if PREEMPT_RT
 
 config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
+	bool
+	default n if BASE_FULL
+	default y if !BASE_FULL
 
 config MODULE_SIG_FORMAT
 	def_bool n
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e0e853412c158..5f7aa4fc2f9ee 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1141,7 +1141,7 @@ static int __init futex_init(void)
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


