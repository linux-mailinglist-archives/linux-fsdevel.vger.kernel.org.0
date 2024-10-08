Return-Path: <linux-fsdevel+bounces-31398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD622995AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB82B23D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA382281C3;
	Tue,  8 Oct 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UGAbvs2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68077227BAA
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427150; cv=none; b=WdBDPSnMmI8lXEO2uEet2WU8kQjD2w5nNuGiYOx2GBsmaJeGaKFBBiKMvgD4PZU1XB2afu0uv+ndRfzdOiQNiVr03HeL3mrenMkoonMKxrIouUYVD+uDs7XXweq4D5Q3EXGYra0xZi9NGT7bMnlORVpOBk9bfStsowq4Cjbkwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427150; c=relaxed/simple;
	bh=nvfnkqxnugn7yXDs2mnbXWqQ+p4uD0M2J+dTO4OtmVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oErOS3yPawM2pUWHDmrsu7rWo8FtpFXW3HZE/4CIhJWTGvydikJ4RJ8iyD/rc1NEWHFxeQzS8OjuzBB8WXH/9bm0zAhRWwkMiHdFpw7tE3BmfxQfyY5oaYytlyZj0VDeQPf/n/74yIaWeQ8HBq8rEOuBWLaKB7L8OjdmhPz8KDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UGAbvs2x; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71df2b0a2f7so3055185b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427149; x=1729031949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iv4iGVPETdra3MKQf2NWKMBAajr7s4N4hA6eTIOU8rY=;
        b=UGAbvs2x37vaJ0Pg387SU/3G25YdvrVEH+o9ZKLLCvAhf3ZyB7yJQe3rmtXDTwhxtq
         vAf6mR1qA6ioBUcpdhW85fqU+JDVPxXB8Wov9v0uIiHj/QjtdJu/hWdK0gL7PVYAwRwK
         AHfuh+fTRa7o+Paz9r8/CGRHoBOFWh4ZE6CdwrQkVeX8JDY8rsjQCJ8+QQ2s3NHokb5t
         ahw9rpuPmqkHZwsfbejWkMrIh87GJUZrOZDQBGstiobmuOwOgDAd8kRp37AJh5EDRuam
         zwalI1JCI0SNE2YT5fujRd98z47o0GXpsGd2z/B7DUUtXWUASU+FaZLMDEfB0k2xo3jF
         sPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427149; x=1729031949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iv4iGVPETdra3MKQf2NWKMBAajr7s4N4hA6eTIOU8rY=;
        b=Ej1EvmkSACj8wI2T/Y1uc3e9Us3H+4NtUS4D3HFDxIKiaYlTyyibDSQs87i+LW77Ey
         HmxUUTtOIhLrsjJtNiRBoVTQT5ADLKwT1ZIGq8Qx2PxBk533hNTUYTahEeTB+jXWaOQC
         9zwmXTCP7lhQPEPE5Xds57IhgVL3Hw6/iYrC0pEq9Qq5oD8UVQERdv+T+1hv3LPPWd+D
         hVjlAtfAsbw3aMJm5nB4sjwPvJmsVB6g7RE9g+2bZfMtQhOn03k2cK17jReERQh3KUM5
         zpKthYbZOjMWkbnSXRprm1gil8wnBlBD+9crPGRIa079DZ2G8ewfddhiAaxSE1XBlOkd
         YviQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCKL+1z14lnotWCUuhf/l9d50Yfi163YX6pPuRH1RgaonCkoRHaJoj0iXJ5ajBc/hA4Jm2I79sBSoEw+3A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9J3HG8YsamNNq7vawskHkTkq+QMruKfA+0C7OtZaVOjCPN1wQ
	q67LKqHOlgJehAYnkFftgqG3HgYgV7Mp77bshOkkQAwJYXD9OvmPe1FD0cw+3Gk=
X-Google-Smtp-Source: AGHT+IHjoVQEvv2ZL9MtUd0PoitnGhc0oOx8qTU8cQ9IzAvoigYxCtNZAaIOLoagpVlmMdjHekGPKw==
X-Received: by 2002:a05:6a00:244d:b0:71d:f423:e6d8 with SMTP id d2e1a72fcca58-71e1db680ecmr668933b3a.6.1728427148723;
        Tue, 08 Oct 2024 15:39:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:39:08 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:37:11 -0700
Subject: [PATCH v6 29/33] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-29-60d9fe073f37@rivosinc.com>
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

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 92d03eb76c03..fb17a67568a8 100644
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


