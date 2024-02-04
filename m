Return-Path: <linux-fsdevel+bounces-10230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF238491B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5018B1F21022
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 23:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E111714;
	Sun,  4 Feb 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="muUTaTJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B6D30B
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Feb 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089426; cv=none; b=neBst6xcCqO7eWJ9vi3/Tmr4jf5A+ObvxjQ3Ns/FCxItQ461Bl/WVB/sDat7sGSqYIkz555fb2Xw96le6wMSlwS9RQdzC1aintJTIeXfJHycWPE6F0yndgviFwQQ6L6bSglrTU3sPPSKobyVrhgFU/Vp9TJleQFhrgbxdvg/CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089426; c=relaxed/simple;
	bh=WDz9XV+IcN+z75ZIj0kVamVYFOuRXwS6pV5NF9q1TH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aeHAnNlGI8nd0eeSP7P186F9wTqIdeOlHMP+4eQuIM0rpl3MhsfGvnDKuJ3o+1vQw6oqjZWxlB+6QArpoC+HczCwFk0E01PpntbwFNgCcwa9bXD1YZABlTj/NHXu77jWwamANfthr4ZW4pOOFbS1tq+L+y4CZfdovZ0IsdjcHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=muUTaTJw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd446d520so9410795e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Feb 2024 15:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707089422; x=1707694222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqOh5UyldPlxDYLA+1PFmA3uJbDUnT3VqP7toNyEhUg=;
        b=muUTaTJwJExYJc/dt80T+cbhld8/8j5PoOnmfw7yg7RpL0sdnNqtWOQHK9tk4/I8sn
         9MNoEUemKa0WQz4I8JeEhGCmM/8GHcQtDdGs4D6kGaMQRmiP3d2IUZVin6oes3INhJtd
         JwEmj+bFq3klM6HB2SvpDfgdHOp7PCKD1BrZAAG5ySuPA1ztk1AJJ9b8ez0UAEDl4CD8
         3CuVS76xBnzByKnhONKwi/oqBDe+dvaDeyVjx/JP/wofw2WhpiwCfR0tNh6Mr834zUlM
         LtSirslhsyLmWUWSFNfUjPoUdTSuuSxlhIeU1UMqwiL7Ffi7pObK/mBTpyxZJjOyz965
         L6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089422; x=1707694222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqOh5UyldPlxDYLA+1PFmA3uJbDUnT3VqP7toNyEhUg=;
        b=ir0wYwblzSoXc0bHvcqRapaJZwyz0mwZwsHjnQeH7XuGzdukO6ACmMKRZm4uZAD7wZ
         h4+5yhBf+hrDELOBpYU/NFKtncdSyYcXx5TbupO/F/XCUoEXC03Exo7fMDqMOyR78kXZ
         UNg2McT0E8aY8YcCG1zSyDrBgoD77UQ3OFONul8r1uqDXP5H2uFbp+REd9OBxAatDDIP
         kE2tn5+kQZgV4Hs7IwQhmU/Ti07yhkOej7GkM1U7mGl0PExxvq7vRAp+X+Lz0KEu2nJb
         fPWEzGKxQCZ+YttxL0ffNcxauCbUMmIy1lIaiJBswX+C+3vbqMOc9zrKWjf2z7aDdyIc
         1AmQ==
X-Gm-Message-State: AOJu0Ywg2oD/PwzCIzGy+ngn3HHdf3zQ1GUOoYJZMFmHShGkoLLUj/cs
	Fyh4bXl4Fg5ymTxs6oSUu3zteD8+k4zVrjoPoJzTILLQvltJ/ZT6NhMxGUW/DqgoG9i8ZdIVPO/
	Kwn1q4w==
X-Google-Smtp-Source: AGHT+IH62/VYjqSuNvY0E3VbDUyG+Y9PgwjFX7hrqC5hth00DnxXAYZCfdRlplSSSi1R6vtwAujOQA==
X-Received: by 2002:a05:600c:181d:b0:40e:f736:8152 with SMTP id n29-20020a05600c181d00b0040ef7368152mr3002467wmp.14.1707089421843;
        Sun, 04 Feb 2024 15:30:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcvNauzoQLlS3V2rUQ2XoowHf8tIE3g5cfPJeRLKnVxargL9QsLMJDXjVf7tWSVT1BTPxHRNT0OBeCZnWaqdMS6qKZjyvByIzEK36mR8GkMGc+aM4kUT1HVS6fEcLn20Q7C6rxrOws2StgCxWRlOnbUdkBSWF5qNoVeO4SutgE+GsrFVhOkv/qZT3PJpaagoyPDoCpTAt3SM5ZuFf9GG7ySfo6gTGSYU2sypKzk3ODpY/1A+wRlG7HGljs2FVYhV10gep79DZgB5AIQZVz+bU38OUBQXgnObJ2lkj5BTpKr5ss+pGtRUdzJMrsmAFBwCS36HLWktc3A8pacqMht3ss/Gl9c7BHDywWxlaX+0R+qqfXn5x8uzjTo3CqZJFw0GEufxkvE5uxGK/4ZD3248E8DPTyo357Jd4/F40izCw4CkLykJpYktJvJs/221Zfaeghq9yb6tGTHgUMe3WQ0gtGoy3A3LZ9LAAkBluxaPI2rUxsQCBXNNWslbLvKV+1GNH5jbdQAog4EURqUI5wlYW1fyVVQftd6YgIcKooXIg7UKpBGsWN4GWeJzetGzU2kijHInv+ml1ZkzatajHtScXID9DJKjKCA6yZy4gnDzZYjRuwlBnLKkfqbtu4IrknGiaweo0y7VqEs5cmTotHIw48Rtw9KaMY3u/S64F35tZxTMnMlmIVs/9XT3ABI3Ah2M+8edVHQ5/J52BsOqfCgblsrDoQKZTGfE3QgIBuPt2Dg+nk6cbvOB9rlNbpyEPoFqlX1onfbC2TMf0o3248k45wFsB+ziA=
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d588d000000b0033ae9e7f6b6sm6822576wrf.111.2024.02.04.15.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:30:21 -0800 (PST)
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
Subject: [PATCH v3 2/2] printk: Remove redundant CONFIG_BASE_SMALL
Date: Mon,  5 Feb 2024 00:29:45 +0100
Message-Id: <20240204232945.1576403-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204232945.1576403-1-yoann.congal@smile.fr>
References: <20240204232945.1576403-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
equivalent to !CONFIG_BASE_FULL.

So, remove it entirely and move every usage to !CONFIG_BASE_FULL:
Since CONFIG_BASE_FULL is a type bool config,
CONFIG_BASE_SMALL == 0 becomes  IS_ENABLED(CONFIG_BASE_FULL) and
CONFIG_BASE_SMALL != 0 becomes !IS_ENABLED(CONFIG_BASE_FULL).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 arch/x86/include/asm/mpspec.h | 2 +-
 drivers/tty/vt/vc_screen.c    | 2 +-
 include/linux/threads.h       | 6 +++---
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 5 -----
 kernel/futex/core.c           | 6 +++---
 kernel/user.c                 | 2 +-
 8 files changed, 11 insertions(+), 16 deletions(-)

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
index 73efb76f38734..3c1654fc770b5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
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
index 1e78ef24321e8..8488d3a23e2fd 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1150,10 +1150,10 @@ static int __init futex_init(void)
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


