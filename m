Return-Path: <linux-fsdevel+bounces-34322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F39C479B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F821F21704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E651E285B;
	Mon, 11 Nov 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Oohz/73x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1751E25E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358504; cv=none; b=CCXV4vAOPTA/MSeRjN5z9f3aC1qEL4Tpb3A4H0nD+1Y4Mk4WafVGjxD9RsoM3YUMK9z3+rcY+rcD74cbcvQzRvrH5n75pRsjmGtUv6yGW2ZKV41AGQzPF6kt7UpRj8eW7quErsWwemVxMX/BrdhwOC/F/3zNVGCVnGMtozSguEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358504; c=relaxed/simple;
	bh=C2e0qcdc5PaNPYSlHWVjFzNo4JFQL2cVOGLaECCTRx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZ4KdtHr7EanwZWjZcxR2i8DWA6u0ooln3OJdCpAhvWwFZdEzorGjqhPaHwOOtBEqvu7HtJmjLEroNlx2Ay9AiJhHxxFMh5GlBgjsYmNtgnp9lK/u9qGKmkJKHSqHYdRkGjXERcVV+CNLpMhm1vZ1Jm7p4P0UUEsymnxkRoE2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Oohz/73x; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso4010056a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358503; x=1731963303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v87E2FN7teOOU1wWTBhK9gVAN0VjVVh/KdbYNd+fh68=;
        b=Oohz/73xCwOTmNpPf7ljnGldlXieHokB+fNkE2Y6zPmlccW2ZAXgnPheUZVHlOvxio
         HWAD96OSPXwRlecdyfZUM3QhmOn5lMIm87Lg9yK4zyjEccVDKAl6+0nzremahRSGgcrm
         6s4xJPvwXJdM7d5wehDotwhF8pnPi+pbwixDn69rC9TFxO83FdT9C6DNUGcKn/wdWRjx
         7QZoaGhNssitAfRt/47ZlpBKjC0gUIal1C1Tzjq/gXk53sWNUXQe0H9MRxNI42/Bd9pt
         ctsa5BxYDQE34WXKQ44KhCElcT5xuzVwEuATKRLYJ4uQO0Yuq7646h2wi9LOwJwI+34/
         DpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358503; x=1731963303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v87E2FN7teOOU1wWTBhK9gVAN0VjVVh/KdbYNd+fh68=;
        b=BLVLqn+OggZiJ+fjRdwcV7oLa1G+8nZCADRZidF4u1cpplXI0qemaSs4cGtV+8sjVA
         3py/8oe83Q2YDCwG/06O5lchIlhpjyBYHwVz7vFke6uWuqqwDYOY489qWw9lZhmngNfD
         tO8FzvVklHZAdZkyUDAPQaG8KmY9VOHNt+8BYKepR0pEH4eVTPqaJHTfP5TgUxUOSsgp
         nZXBC0kU2vrjIP5z9G/6QGL/Y6tRtj++JNRduD8N09pbXluQzF7XwEGe/hG2mA05If+t
         y6qMctAYSjZJz2FkMbdHOo8VnlJYmdJUAZnJWM3DHmTvf0+d10vgZE+K7Z0tF2HRS67T
         k4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/fxNHeic9CcOCxleXYyJKyeSf3w0B74gWcM8Z8XfiokGpdWB7377+sjdzgsrVaMNxjECo3Br4aJGO76i@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7Tim/lrYegL1X2mZT4J5qOvTm0Ib2jRSk3MdnVfmNdiR9xH/
	LsdDtncobpEibAQcScR7GinHO2W3f2cezj9Plgf8ZSOj8EBYClc2mjksrQ5+jHA=
X-Google-Smtp-Source: AGHT+IE6pHU7K0D6Kovlo0iT4mPH8p4N2kcP8nKM47bgfKvZsvt7nFC76OWezD1by9y3vt8KBs+5Mg==
X-Received: by 2002:a17:90b:1a92:b0:2e2:cd22:b092 with SMTP id 98e67ed59e1d1-2e9b171f93amr20303584a91.16.1731358503151;
        Mon, 11 Nov 2024 12:55:03 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:55:02 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:54:10 -0800
Subject: [PATCH v8 25/29] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-25-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 04b0305943b1..223dfa482deb 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+bool disable_riscv_usercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -393,6 +395,9 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_shadow_stack())
 		return -EINVAL;
 
@@ -472,6 +477,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_indirect_br_lp_instr())
 		return -EINVAL;
 
@@ -504,3 +512,15 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "true") == 0)
+		disable_riscv_usercfi = true;
+
+	pr_info("Setting riscv usercfi to be %s\n", (disable_riscv_usercfi ? "disabled" : "enabled"));
+
+	return 1;
+}
+
+__setup("disable_riscv_usercfi=", setup_global_riscv_enable);

-- 
2.45.0


