Return-Path: <linux-fsdevel+bounces-10633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9A84CF82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CB31C26CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21483CCC;
	Wed,  7 Feb 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="v9vnFyJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F98289F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325853; cv=none; b=VAY5NYD1DS2pxZ9OeS7NO2sZ2zeBBHuQAxylCthdsMUB519z+2qB0cST2laR/mx9C4kpNgHPnKPQFRFuHnSpR2ecLivnN3gi/iLjzzZEuiKZgkEfH6oNa1b9RFBsjOJcHJPCk8KASZCXD+peKYkqRyw3ALpDFetsykykOWfTHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325853; c=relaxed/simple;
	bh=Y67stv/sr6+muGOhcCJ8zh56gL3mr77izeIlP9rNHIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSQZ8WxO9cPAhRnqlqiEM9DE54VDX17SyfHifJLvzMXVqbBy9ywm4MaMnCUJ/2IuM6uAkIlPms+PDQAH7z7pqm1MMTGboYmXFcdFTZmf3AAkhDBwCPFfMtPHm9h3IHOUyEnb9dQi0B+SJJzojnW5rWJ0H0ws8xjvMrZbfcMgk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=v9vnFyJC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso7671755e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707325848; x=1707930648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm9Sx2Z+kw/+4Ic26K2y9NSDfw5+mOxd7yrUQqREtwE=;
        b=v9vnFyJCLgSD/tY3TXzzSZ/abgmDclru2pfcQUdXJyjMfafXaThSNC5McWGYEr7o7I
         SaIwjDrVKtKjci3jJfjoYbNSFOLevNlmlWMV5UQGnkT+yOFVDjcPq+KZVNXmWcy5jFAU
         lzk6ZYXv17q5nr0a9odqpkH/6Tr/wSW4QOXxzmA7IAsSkqt9UBKEIMI55Vw1tI6/UOtg
         wyuRfUdgDDmONaCCqkaBds/NdNgkOEJz2G6hgmARmYv1g1yQ7NV/dRN1xUSFxn51s3W6
         EJiOlCy/Ksb01ee6abYnTxgxZX44wgNA/BW8zfoxCUQHurxpeOKxeONBHUyR8ni3adGF
         B3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325848; x=1707930648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm9Sx2Z+kw/+4Ic26K2y9NSDfw5+mOxd7yrUQqREtwE=;
        b=tEp7l+5mjxH/8F5irDHwXiGq5PbmV8G7nW7sizGSsr8lmcuo303PCpkRBWPBA+x7lh
         7OQCnTo4k302gS2sAmKOMR95l4pHKRRXi64/Aom2imhLXStIE6LK3ewTiB1QY1Wq+il5
         qohej/jpEQe0gzUYAzR/O85TQZ8pNkjzkkTJBcOjjXdvdqTKLhBDL94fV9RaqZztja0y
         AeZEeYpv2bX1+xlOBA06cuaBAGGA8v3um5PSX+gm/4N8S+EKL8lu/ctY393eNHjUleOv
         OtIX0jGQKvZLi/mUdUN6jrEpgMDWnPXEgqnWhFuxI3uR8HUbG3+uj3YSov+Lz2CyJYkO
         AkMg==
X-Gm-Message-State: AOJu0YwINxW7Nc9oNt+tsvo/8pHY5c9OrqPl/4vJgz3yP+VmnHTk/rwB
	oQdpyVZ3gafSPcV4Mm1Ydb7xqnlesQlIbfjb5K4ga6jlV3EQDEf2D1Pws0iHuWOwfghpMTbgkDC
	/CBw=
X-Google-Smtp-Source: AGHT+IG39DVe+B7mlts7V0EJltGSSbQBy+9URtWinatSHU5Z5B7ouUOTmRnOQxBGBa34YlTWjp5t6A==
X-Received: by 2002:a05:600c:4448:b0:40e:6ba0:de3b with SMTP id v8-20020a05600c444800b0040e6ba0de3bmr4450074wmn.0.1707325848661;
        Wed, 07 Feb 2024 09:10:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPQp8T0ZkKgY6DM7XylIS/LXXQ5vwALOw7Rsjcj1ZiczFsNielmldgNn4Yfxn4b0nN8QM/LzxEGg7T8qr2nk+hamJbbzW/9nWQDafrlvjNBFrxR74XeI6jElAzMlzBBmeevQwD4mxuLqM1q+oWymUfs4F63GndI0GnJtjBcn9pd8A4uX38kABKpDRVdp7Zd1cZoaSunYPg/zF8QZEoUJj1wPHJwlNeATmjxS0KYW+HphgaC3cvVqpmBp7ZnDaHyEGnBPFCiu4hJKAnrZW6oeKwmj6SErLAm8NuuANx4aFd9XkA95cCnKZHRAOh2zQ03+0eZf0mU6odz6pnXzr4Eq9Uv50aPlE5/i2Q8aGyAIPspsHscO3W/wqliGcIGcjN/kxkS6UKrCOzsS+qRnS2lLKF6H3pT6/Wtp43PY0x28cEksA5oZ08bEP1a94H6Dwkh854dNM4QrJvZOHJIfgcnPKqmKOlBVmmoQAHGssekxjyXRE0++LQBa9/U3OKqBsgJELu3SIkKlVdIz4wu/WmZVpnrIoi4ZecEC5/88bpyO7Y5L6aFPJPZD/AIABtBlUxkMrfvEC3DwK8vGyZIpFeKetsuCpnpHFl/hYd9ThcLzqTobsAGcjgTSR/QtejE/PLj0flH+Zn0EatuPEP8JgUNRoQzKFhHYwszXkRRlMnfghLcbv2ZcBatQeV/VYvGw+3JTUttpRd6rdy9jade2GG8FdpxO0IH7skAZNzvvBxTdKz061cGHU7hoe14CHjzA6wbYkqaGRrX5gcbbYGIJ93VsWfOn0bze4=
Received: from P-ASN-ECS-830T8C3.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b0040fdf2832desm2645584wmq.12.2024.02.07.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:10:48 -0800 (PST)
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
Subject: [PATCH v5 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
Date: Wed,  7 Feb 2024 18:10:19 +0100
Message-Id: <20240207171020.41036-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207171020.41036-1-yoann.congal@smile.fr>
References: <20240207171020.41036-1-yoann.congal@smile.fr>
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

v4->v5: Applied Masahiro Yamada's comment (Thanks!)
* Use a shorter Kconfig definition (with def_bool)

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
 init/Kconfig                  | 6 ++----
 kernel/futex/core.c           | 2 +-
 kernel/user.c                 | 2 +-
 8 files changed, 12 insertions(+), 14 deletions(-)

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
index d50ebd2a2ce42..0148229f93613 100644
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
@@ -1941,9 +1941,7 @@ config RT_MUTEXES
 	default y if PREEMPT_RT
 
 config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
+	def_bool !BASE_FULL
 
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


