Return-Path: <linux-fsdevel+bounces-31375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F73D995A53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BC41C212D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91A21A709;
	Tue,  8 Oct 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VV5QADwf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5029219CB4
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427086; cv=none; b=Lo1wx97CkmzwQPCdnGEmXJP/6zx5yn8v12IG01UxozGi8eFxvmahDBWotAtJ8Rnm7hj8dEqu5iC44B6riGspn0QuVKyxBI/A8HVvqR32ZuFoAmHnBC4XnDAJDBb7dIaLHCb9VPxPhK5b4LqOqd0B+iO8CWBzvuGDhOjrg9V4POc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427086; c=relaxed/simple;
	bh=Cq07DZYYTuLqQ4gxwqCLLHBNKJv4iDz96fE7XrIs4Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOhPmqJ8CGXeNhSfAV+tDG3q55bsuZKoj8wiGHGkU0m0BBRBSgWUK9tVGPXIxG00pLk109MdQPiG+0jmE0ceOrgry9R3QKg94eUjDmTF5ZtVKqxiEvE+2fbosNSQgBSQOmDKwZYZmeJAgHPxm1mIAPySSiDivwc6qew/nrgqsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VV5QADwf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e050190ddso1945613b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 15:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427084; x=1729031884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxvPbFdPQ1tC+j3wFHGGOQBUzN++1F4GTwbS3f8RUbU=;
        b=VV5QADwfVa3j/mIQB1zSEknv/209tzS6nawOngm1As24FQXko/OGrZwWsuUkRJNNQS
         4GjOerPy2ZEm1WEMTx9JzLmTbb9P4ygUDIMs+m249bQpMrk3QmEuKe6SDZDxcIVudMpl
         LoV+461/UVnZjizoUP099tMG8/5mO8ZBjYeGjbXtvgo10yXwpr6mcX5+ImPh9P7pKG65
         EkruwH1XNYG9Zww+OsEa550XOJWYUYWlve4Ag4EfTLAvwPYVAZeR2ACSj3CbH2CNu9yZ
         Ke9QWJhfaTk6K+QQPdmmALtQZtT2kFR8uHFgV+cSkiror51UnsmzBClTDNM54zjpvhMH
         zpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427084; x=1729031884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxvPbFdPQ1tC+j3wFHGGOQBUzN++1F4GTwbS3f8RUbU=;
        b=qg1aCL3+/6W5a32ZPxw9yJGqUNBsDFCT/gpsSJBjF0/QYaEKBSHB8GY0wjwP2RrVo/
         DWjuggvp+q7W3hSkK44emqbFzBNCNLKw1yE+OxtZ+XcG+I/CZHRXpog+ArbaPkEcRiPy
         zd41mGOPt+rXrKmI7mLzFy2tpHTHftolhbr5c94CDCRMOCGAHEcZ0yfqc2V1xGhmU4A0
         UP4/CYEbKIGgWsDI01btN6h7PeoVACIBwA4nGkMASsJ3snSDSVqz/55x1wR2uiSoXxZM
         tZXECtwZbUVYlc83WCW4OUDMZphmaw8gjkXQkHSIGZhC3Za02XXz7eu7o3pN7Obng+2O
         p7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbTfDgH5lmIlWc+M/YpoIPo+jBHvnZhkmeBueOMJ8RbNT5D4MSJ0NDQ7fRbzwpinDZLRbqqxb7KaIOX2Lz@vger.kernel.org
X-Gm-Message-State: AOJu0YzelfY8xxsf7PeE7d36oEBsX6qC/uuIwQMSnNZg+o93GekA1/i8
	v1cUMxEGNuYRZHLM1Lv7WlPpvUtn+Fly4PWyLM1r8/VAaN566SF0ZslIHFDYC0s=
X-Google-Smtp-Source: AGHT+IF3M/VQF4JxFEIfdPLZxd9ZoguSrfvN9rKCL1mqQD6cOVqVplTxyPp4R1gZRhnFMnmKa4HdWw==
X-Received: by 2002:a05:6a21:9102:b0:1d6:d5c1:e504 with SMTP id adf61e73a8af0-1d8a3c1e587mr859595637.26.1728427084123;
        Tue, 08 Oct 2024 15:38:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:38:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:48 -0700
Subject: [PATCH v6 06/33] riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-6-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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

riscv will need an implementation for exit_thread to clean up shadow stack
when thread exits. If current thread had shadow stack enabled, shadow
stack is allocated by default for any new thread.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/process.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22dc5ea4196c..808ea66b9537 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -182,6 +182,7 @@ config RISCV
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_EXIT_THREAD
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e3142d8a6e28..1f2574fb2edb 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -201,6 +201,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;

-- 
2.45.0


