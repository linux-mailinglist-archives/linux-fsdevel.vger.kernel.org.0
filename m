Return-Path: <linux-fsdevel+bounces-7369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2D8242BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 14:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF089286E43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F31224C3;
	Thu,  4 Jan 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Iod9vDX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39E22313
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LNn9rqZHtmbVqLNn9rhL4z; Thu, 04 Jan 2024 14:29:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704374988;
	bh=ciTbDjeP+vCKPdJby2wMqEkjO/zLT5PPfRKymuvu7Ls=;
	h=From:To:Cc:Subject:Date;
	b=Iod9vDX/tgK1aAj3D0pbcF1SNX2aOulCB5ziVBgXc2wj6sOGEGBmLWICLdqZHZt1x
	 UlTjdr32do3p5szUwUxlGYJXZCS9asBZSRogiJqv6CaSbTb6kt9vprVOAq9m0B1Okf
	 //EXruuhFxkXyxmZeYu0nHTfn0zzJkFcd3ymeIDLQzLloLnZkyaN43xELjdoI9Ys+y
	 DIW2rbvPF+wBN8W2CB8VEm4/9Mf/bxfNzmMGqUW1d1P8S8t0mu127k442K2KggsUsv
	 GC1Jh3+mYzZMGZXRoxl6tidDt02gehE5jJOb8Fz3axGOJPBtvHnAsMeSXwnXWhaulV
	 N60RtHWbmS6zA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 Jan 2024 14:29:48 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] seq_file: Optimize seq_puts()
Date: Thu,  4 Jan 2024 14:29:37 +0100
Message-Id: <5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of seq_puts() usages are done with a string literal. In such cases,
the length of the string car be computed at compile time in order to save
a strlen() call at run-time. seq_write() can then be used instead.

This saves a few cycles.

To have an estimation of how often this optimization triggers:
   $ git grep seq_puts.*\" | wc -l
   3391

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Checked by comparing the output of a few .s files.
Here is one of these outputs:

$ diff -u drivers/clk/clk.s.old drivers/clk/clk.s | grep -C6 seq_w

 	call	clk_prepare_unlock	#
 # drivers/clk/clk.c:3320: 	seq_puts(s, "}\n");
 	movq	%r12, %rdi	# s,
+	movl	$2, %edx	#,
 	movq	$.LC66, %rsi	#,
-	call	seq_puts	#
+	call	seq_write	#
 	call	__tsan_func_exit	#
 # drivers/clk/clk.c:3322: }
 	xorl	%eax, %eax	#
@@ -34520,6 +34521,7 @@
 	popq	%rbp	#
 	popq	%r12	#
--
 # drivers/clk/clk.c:3205: 		seq_puts(s, "-----");
 	call	__sanitizer_cov_trace_pc	#
+	movl	$5, %edx	#,
 	movq	$.LC72, %rsi	#,
 	movq	%r13, %rdi	# s,
-	call	seq_puts	#
+	call	seq_write	#
 	jmp	.L2134	#
 .L2144:
 # drivers/clk/clk.c:1793: 	return clk_core_get_accuracy_no_lock(core);
@@ -35225,20 +35228,23 @@
 	leaq	240(%r12), %rdi	#, tmp95
 	call	__tsan_read8	#
--
 	movq	%r12, %rdi	# s,
+	movq	$.LC77, %rsi	#,
 # drivers/clk/clk.c:3244: 	struct hlist_head **lists = s->private;
 	movq	240(%r12), %rbp	# s_9(D)->private, lists
 # drivers/clk/clk.c:3246: 	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
-	call	seq_puts	#
+	call	seq_write	#
 # drivers/clk/clk.c:3247: 	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
+	movl	$142, %edx	#,
 	movq	$.LC78, %rsi	#,
 	movq	%r12, %rdi	# s,
-	call	seq_puts	#
+	call	seq_write	#
 # drivers/clk/clk.c:3248: 	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
+	movl	$142, %edx	#,
 	movq	$.LC79, %rsi	#,
 	movq	%r12, %rdi	# s,
-	call	seq_puts	#
+	call	seq_write	#
 # drivers/clk/clk.c:3251: 	clk_prepare_lock();
 	call	clk_prepare_lock	#
 .L2207:
@@ -37511,7 +37517,7 @@
 	subq	$16, %rsp	#,
 # drivers/clk/clk.c:3082: {
---
 fs/seq_file.c            |  4 ++--
 include/linux/seq_file.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index f5fdaf3b1572..8ef0a07033ca 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -669,7 +669,7 @@ void seq_putc(struct seq_file *m, char c)
 }
 EXPORT_SYMBOL(seq_putc);
 
-void seq_puts(struct seq_file *m, const char *s)
+void __seq_puts(struct seq_file *m, const char *s)
 {
 	int len = strlen(s);
 
@@ -680,7 +680,7 @@ void seq_puts(struct seq_file *m, const char *s)
 	memcpy(m->buf + m->count, s, len);
 	m->count += len;
 }
-EXPORT_SYMBOL(seq_puts);
+EXPORT_SYMBOL(__seq_puts);
 
 /**
  * seq_put_decimal_ull_width - A helper routine for putting decimal numbers
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 234bcdb1fba4..15abf45d62c5 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -118,7 +118,15 @@ void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
 __printf(2, 3)
 void seq_printf(struct seq_file *m, const char *fmt, ...);
 void seq_putc(struct seq_file *m, char c);
-void seq_puts(struct seq_file *m, const char *s);
+void __seq_puts(struct seq_file *m, const char *s);
+#define seq_puts(m, s)						\
+do {								\
+	if (__builtin_constant_p(s))				\
+		seq_write(m, s, __builtin_strlen(s));		\
+	else							\
+		__seq_puts(m, s);				\
+} while (0)
+
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
 			       unsigned long long num, unsigned int width);
 void seq_put_decimal_ull(struct seq_file *m, const char *delimiter,
-- 
2.34.1


