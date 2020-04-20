Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D151B17CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgDTU7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgDTU6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9EC061A0E;
        Mon, 20 Apr 2020 13:58:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so1172506wmh.3;
        Mon, 20 Apr 2020 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/+6N4SY+ltsYi8Tx6jM5WzdncRVZ/zZ9Jo8Ulqxolo=;
        b=AC7QyTAUNCvmwN6hPpkezJGocgjwuGhG6qdSYXv8PsgxF9b/Ykj6Vx246zw/+//87S
         Nm5QVqYJkM5n8ovp11aQg0a6prKkqG94IIy3CEM0DAZIvpBKK1x9yrh+zXz8MhyQxdDF
         iDj7vQIF9nWUJt3rnCksDOsVWH+I2+Hijgo0Uk9lrxcEmhUyEzsWCuV/nd9+N/jVMruz
         jPyz5LQyRgFhjVNUSD+fjQL4qdtOea9qlJsnlJupPdAuFNpywB1ShfPTHVuRrWGeWLn1
         /tfoLQ5MO1KkmizYFSeU0BW5VYaiRWN4yfkkHo7n45k3Jr8+DRVX942wwdUMwh3qTHPM
         6TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/+6N4SY+ltsYi8Tx6jM5WzdncRVZ/zZ9Jo8Ulqxolo=;
        b=YQ1CpHUN5TlOJoG5dbTfjCTtFO18KPNwjL/Ue0IrY0yVuy/CMTGdi49gmrfGuhhkLn
         gr0rYpb0iMicC8HlmvuK9CM2xwSX5P6O03XbD/LC0p/4hSZpM80/Jr8O66rc2MEH+Nxv
         HHtRB3YCDiD7CMhvN43c/ZgpNZ52b/J66FLWiiaEVWweObMEGOBggxRMu4F1uebbnpqr
         1bF8mD06qEyzlrC0nyutEzc6cFeBvxc7CHrDgt+n7lOs0s9FSpxNvDrhH4rUJmKRDI46
         ge8g+55KK7BQDCCxJaQzK2Xv7eTdWqYejzjhJEn2MDOdWTm2M2BGTDWALdCpknJtMLVb
         y+5A==
X-Gm-Message-State: AGi0PuZECgpyrYk6FTMFowIZNSo1p2XTVlzCFN/fO2dqPH9bE3nK7xuW
        tElv3217GCK7akSYj4o0Yg==
X-Google-Smtp-Source: APiQypLXPYwa279TMrEJeoLpj8agbrimCd3YIt+hkSRFpM10mTghthm4A2Whvpwir3fbEI5A2eP22w==
X-Received: by 2002:a05:600c:4102:: with SMTP id j2mr1317027wmi.159.1587416290042;
        Mon, 20 Apr 2020 13:58:10 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:09 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 03/15] print_integer: new and improved way of printing integers
Date:   Mon, 20 Apr 2020 23:57:31 +0300
Message-Id: <20200420205743.19964-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Time honored way to print integers via vsnprintf() or equivalent has
unavoidable slowdown of parsing format string. This can't be fixed in C,
without introducing external preprocessor.

seq_put_decimal_ull() partially saves the day, but there are a lot of
branches inside and overcopying still.

_print_integer_*() family of functions is meant to make printing
integers as fast as possible by deleting format string parsing and doing
as little work as possible.

It is based on the following observations:

1) memcpy is done in forward direction
	it can be done backwards but nobody does that,

2) digits can be extracted in a very simple loop which costs only
	1 multiplication and shift (division by constant is not division)

All the above asks for the following signature, semantics and pattern of
printing out beloved /proc files:

	/* seq_printf(seq, "%u %llu\n", A, b); */

	char buf[10 + 1 + 20 + 1];
	char *p = buf + sizeof(buf);

	*--p = '\n';
	p = _print_integer_u64(p, B);
	*--p = ' ';
	p = _print_integer_u32(p, A);

	seq_write(seq, p, buf + sizeof(buf) - p);

1) stack buffer capable of holding the biggest string is allocated.

2) "p" is pointer to start of the string. Initially it points past
	the end of the buffer WHICH IS NOT NUL-TERMINATED!

3) _print_integer_*() actually prints an integer from right to left
	and returns new start of the string.

			     <--------|
				123
				^
				|
				+-- p

4) 1 character is printed with

	*--p = 'x';

	It generates very efficient code as multiple writes can be
	merged.

5) fixed string is printed with

	p = memcpy(p - 3, "foo", 3);

	Complers know what memcpy() does and write-combine it.
	4/8-byte writes become 1 instruction and are very efficient.

6) Once everything is printed, the result is written to seq_file buffer.
	It does only one overflow check and 1 copy.

This generates very efficient code (and small!).

In regular seq_printf() calls, first argument and format string are
constantly reloaded. Format string will most likely with [rip+...] which
is quite verbose.

seq_put_decimal_ull() will do branches (and even more branches
with "width" argument)

	TODO
	benchmark with mainline because nouveau is broken for me -(
	vsnprintf() changes make the code slower

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 MAINTAINERS         |  6 ++++++
 lib/Makefile        |  2 +-
 lib/print-integer.c | 40 ++++++++++++++++++++++++++++++++++++++++
 lib/print-integer.h | 20 ++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 lib/print-integer.c
 create mode 100644 lib/print-integer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..8322125bb929 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8470,6 +8470,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/inside-secure/
 
+INTEGER PRINTING PRESS
+M:	Alexey Dobriyan <adobriyan@gmail.com>
+L:	linux-kernel@vger.kernel.org
+F:	lib/print-integer.[ch]
+S:	Maintained
+
 INTEGRITY MEASUREMENT ARCHITECTURE (IMA)
 M:	Mimi Zohar <zohar@linux.ibm.com>
 M:	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
diff --git a/lib/Makefile b/lib/Makefile
index 685aee60de1d..a2f011fa6739 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -25,7 +25,7 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
-lib-y := ctype.o string.o vsprintf.o cmdline.o \
+lib-y := ctype.o string.o print-integer.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
diff --git a/lib/print-integer.c b/lib/print-integer.c
new file mode 100644
index 000000000000..563aaca19b8c
--- /dev/null
+++ b/lib/print-integer.c
@@ -0,0 +1,40 @@
+#include <linux/compiler.h>
+#include <linux/math64.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "print-integer.h"
+
+noinline
+char *_print_integer_u32(char *p, u32 x)
+{
+	do {
+		*--p = '0' + (x % 10);
+	} while (x /= 10);
+	return p;
+}
+
+noinline
+char *_print_integer_s32(char *p, s32 x)
+{
+	if (x < 0) {
+		p = _print_integer_u32(p, -x);
+		*--p = '-';
+		return p;
+	} else {
+		return _print_integer_u32(p, x);
+	}
+}
+
+noinline
+char *_print_integer_u64(char *p, u64 x)
+{
+	while (x >= 100 * 1000 * 1000) {
+		u32 r;
+
+		x = div_u64_rem(x, 100 * 1000 * 1000, &r);
+		p = memset(p - 8, '0', 8);
+		(void)_print_integer_u32(p + 8, r);
+	}
+	return _print_integer_u32(p, x);
+}
diff --git a/lib/print-integer.h b/lib/print-integer.h
new file mode 100644
index 000000000000..a6f8e1757a6f
--- /dev/null
+++ b/lib/print-integer.h
@@ -0,0 +1,20 @@
+#pragma once
+char *_print_integer_u32(char *, u32);
+char *_print_integer_u64(char *, u64);
+char *_print_integer_s32(char *, s32);
+
+static inline char *_print_integer_ul(char *p, unsigned long x)
+{
+#ifdef CONFIG_64BIT
+	return _print_integer_u64(p, x);
+#else
+	return _print_integer_u32(p, x);
+#endif
+}
+
+enum {
+	LEN_U32 = 10,
+	LEN_S32 = 1 + LEN_U32,
+	LEN_UL = sizeof(long) * 5 / 2,
+	LEN_U64 = 20,
+};
-- 
2.24.1

