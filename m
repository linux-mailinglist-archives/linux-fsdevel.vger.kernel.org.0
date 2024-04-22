Return-Path: <linux-fsdevel+bounces-17386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB38ACA8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0400D1C210D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9764B140395;
	Mon, 22 Apr 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kaQ9gEiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869613E3E5;
	Mon, 22 Apr 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781531; cv=none; b=ibzXr+AwBO1RYVjD+YeuoNYlED7fgME/OcafyxqVm0ko9o9Nzo4c17C1BXCv6r4cCn8kB6d8aSVGFZDfw7CnWGWDC7tEfIaqG1rO+0fCOufVKSLUww91SUy8ATrloDE6t28ToG4qmf4C1H3VTRLZMc9tRRTCr+5C3qT+m0OP7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781531; c=relaxed/simple;
	bh=PEe4CtOIrKOA5J/Q+3pJlXyDw+pimrK40GN8HRR88Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ga4KxYfVisOteTzu4ky3FGJ6y2V0EWYdGGNC4DfFXQ0StfmImdTta/HKyDFT0pU6KMnCFWjRNZdQADbsW8PkowDfI10FxJ1VOL2z5PgG3DtDp8pXhxTetvvFz4liBOHeaGRNX/N5g7kvlLhMnZrIPzM+GQ6QGR9VViMotpua6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kaQ9gEiM; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id yqqPr8npHhQSByqqPrJn2k; Mon, 22 Apr 2024 12:24:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713781458;
	bh=WDS/cJIF3u/b8hKGhrIR45S+kJmGLDvRuuuBC4I4XyY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kaQ9gEiMqMz2fUPdb+cygTCdJytCqki5fJpgw8E/zgZZfy5hc6+RBYeHtX9LMYzie
	 0kn0DwUKqBwFgbA0DwkQBf9JkRHVGrq3z7ypX+hquI7Gu6yhU5Q16ZdmNvAHUmcoJ0
	 6rs/y47hUKC6w4EKdBR9Oa1BaergyneOdGsQk0cX5njFtod7RsiMk3F/OSNIQshhzh
	 at0DKr6ME9bQ4nGZI4K8vNPtUbxDaFBSX3EYuWRC2mBYk4FqTv/xszsxUrI4G2/14l
	 WjEb2MwDgQXFuZhDTDbA8lGX0S7CqBGS3HxkAqf2Xp8XEWJUojGiSXbUDtZc4mFBRl
	 pU5P603po9jbQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Apr 2024 12:24:18 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David.Laight@ACULAB.COM,
	rasmus.villemoes@prevas.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] seq_file: Optimize seq_puts()
Date: Mon, 22 Apr 2024 12:24:06 +0200
Message-ID: <a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of seq_puts() usages are done with a string literal. In such cases,
the length of the string car be computed at compile time in order to save
a strlen() call at run-time. seq_putc() or seq_write() can then be used
instead.

This saves a few cycles.

To have an estimation of how often this optimization triggers:
   $ git grep seq_puts.*\" | wc -l
   3436

   $ git grep seq_puts.*\".\" | wc -l
   84

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
   - Use a function, instead of a macro   [Al Viro]
   - Handle the case of 1 char only strings, in order to use seq_putc()   [Al Viro]
   - Use __always_inline   [David Laight]

V1: https://lore.kernel.org/all/5c4f7ad7b88f5026940efa9c8be36a58755ec1b3.1704374916.git.christophe.jaillet@wanadoo.fr/


Checked by comparing the output of a few .s files.
Here is one of these outputs:

$ diff -u drivers/clk/clk.s.old drivers/clk/clk.s | grep -C6 seq_w

 .L2918:
@@ -46072,10 +46073,11 @@
 	call	clk_prepare_unlock	#
 # drivers/clk/clk.c:3438: 	clk_pm_runtime_put_all();
 	call	clk_pm_runtime_put_all	#
-# drivers/clk/clk.c:3440: 	seq_puts(s, "}\n");
+# ./include/linux/seq_file.h:130: 		seq_write(m, s, __builtin_strlen(s));
+	movl	$2, %edx	#,
 	movq	$.LC94, %rsi	#,
 	movq	%rbp, %rdi	# s,
-	call	seq_puts	#
+	call	seq_write	#
 # drivers/clk/clk.c:3441: 	return 0;
 	jmp	.L2917	#
 	.size	clk_dump_show, .-clk_dump_show
@@ -46200,7 +46202,7 @@
 	leaq	128(%rbx), %r15	#, _97
 	movq	%r15, %rdi	# _97,
--
 # drivers/clk/clk.c:1987: 		__clk_recalc_rates(core, false, 0);
@@ -46480,15 +46482,17 @@
 	call	seq_printf	#
 	jmp	.L2950	#
 .L2946:
-# drivers/clk/clk.c:3315: 		seq_puts(s, "-----");
+# ./include/linux/seq_file.h:130: 		seq_write(m, s, __builtin_strlen(s));
 	call	__sanitizer_cov_trace_pc	#
+	movl	$5, %edx	#,
 	movq	$.LC100, %rsi	#,
 	movq	%rbp, %rdi	# s,
-	call	seq_puts	#
+	call	seq_write	#
+# ./include/linux/seq_file.h:131: }
 	jmp	.L2947	#
 .L2957:
 # drivers/clk/clk.c:1903: 	return clk_core_get_accuracy_no_lock(core);
-	xorl	%r14d, %r14d	# _34
+	xorl	%r14d, %r14d	# _35
--
@@ -46736,21 +46740,22 @@
 	call	__sanitizer_cov_trace_pc	#
 	leaq	240(%r12), %rdi	#, tmp101
 	call	__tsan_read8	#
-# drivers/clk/clk.c:3355: 	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
-	movq	$.LC104, %rsi	#,
+# ./include/linux/seq_file.h:130: 		seq_write(m, s, __builtin_strlen(s));
+	movl	$142, %edx	#,
 	movq	%r12, %rdi	# s,
+	movq	$.LC104, %rsi	#,
 # drivers/clk/clk.c:3352: 	struct hlist_head **lists = s->private;
 	movq	240(%r12), %r13	# s_10(D)->private, lists
-# drivers/clk/clk.c:3355: 	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
-	call	seq_puts	#
-# drivers/clk/clk.c:3356: 	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
+# ./include/linux/seq_file.h:130: 		seq_write(m, s, __builtin_strlen(s));
+	call	seq_write	#
+	movl	$142, %edx	#,
 	movq	$.LC105, %rsi	#,
 	movq	%r12, %rdi	# s,
-	call	seq_puts	#
-# drivers/clk/clk.c:3357: 	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
+	call	seq_write	#
 	movq	$.LC106, %rsi	#,
 	movq	%r12, %rdi	# s,
-	call	seq_puts	#
+	movl	$142, %edx	#,
+	call	seq_write	#
 # drivers/clk/clk.c:3359: 	ret = clk_pm_runtime_get_all();
 	call	clk_pm_runtime_get_all	#
 # drivers/clk/clk.c:3360: 	if (ret)
@@ -57943,7 +57948,7 @@
 	subq	$88, %rsp	#,
 # drivers/clk/clk.c:5338: {


The output for seq_putc() generation has also be checked and works.
---
 fs/seq_file.c            |  4 ++--
 include/linux/seq_file.h | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

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
index 234bcdb1fba4..8bd4fda6e027 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -118,7 +118,18 @@ void seq_vprintf(struct seq_file *m, const char *fmt, va_list args);
 __printf(2, 3)
 void seq_printf(struct seq_file *m, const char *fmt, ...);
 void seq_putc(struct seq_file *m, char c);
-void seq_puts(struct seq_file *m, const char *s);
+void __seq_puts(struct seq_file *m, const char *s);
+
+static __always_inline void seq_puts(struct seq_file *m, const char *s)
+{
+	if (!__builtin_constant_p(*s))
+		__seq_puts(m, s);
+	else if (s[0] && !s[1])
+		seq_putc(m, s[0]);
+	else
+		seq_write(m, s, __builtin_strlen(s));
+}
+
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
 			       unsigned long long num, unsigned int width);
 void seq_put_decimal_ull(struct seq_file *m, const char *delimiter,
-- 
2.44.0


