Return-Path: <linux-fsdevel+bounces-41468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485DBA2FA6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5361630F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0725EFA6;
	Mon, 10 Feb 2025 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="25DR1lro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4F25D55D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219247; cv=none; b=Upq6K6Sb94gyabMaNYxfe850ZIl753v+znpOr8hxXh0/BzJ8it8gvme7nYQdNrsIGP+c66kPV4JYm9IHjA2GiwDtZUT3HEukl586jD/RO54QVwkWc+BCKAKjUfDFQor2BycwrMf3sqO1GL0T3Tve0nIXiuZQ0o+xVQGNcgsuVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219247; c=relaxed/simple;
	bh=UvMauEZ7ujgiT53rhoVNtF8wKatfWBS5dd1E01vsJYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFBOwGax+Z9m5L5U/dwU+kwA1hhuMQHlRlPf1N7IArAkD8VW75TWbI7D5jYb46M6+8XJrISrKbMAA7gn4W+oUwupLNViJpzTGe+BZt2+pz34gPxnqqPdrd6ezh/rYufyVoEAqRgjmEXt/P5ZlOBV5Db/2FjRJbG5mjFbRP/TkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=25DR1lro; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f42992f608so7337745a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219244; x=1739824044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU6IAlGSwKWKw5iWDrFBqBdwaJZ69/+Cs7+/DXu3do8=;
        b=25DR1lroWrg7UsNBwD70rQeyXIkgutU9wLu8AGpWro8LJ3L02pgtiUxGDmrzqVcCW8
         yQ88b7ShNXHQ5oV90s2rELsqhQOR05BCXy/6ZETRkEoIbBx5bGhP7w94jg/3jUW/aNs4
         5GwnYwHHOFmqV6WMEHBrClaP7sQM5Lfuql2pFc04EsnVXurlFe3zWf4o0wAT+U9alHBR
         tlnlPKDnm/Zu0QGu01rLI/xJUhmU5ox+kiDw6J0TO6dQnLxv7NDKg0srDP/l/b5QPlQS
         b3CQzJsNAXIvWq6aGBoqZ92CcjkJaCvO6AlZthRa+qzzRm237x/JPO0Hkdry/AIetAye
         8DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219244; x=1739824044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU6IAlGSwKWKw5iWDrFBqBdwaJZ69/+Cs7+/DXu3do8=;
        b=qN9/r0HykOjSJTPsKm4zyufiI9PEqIilbXxHYoD0eOxis3UnvyotBktDd/GVx+gdUZ
         bUSHvTdtPk1SKzgl9jcSS1c7pxjIWqHlECXK4AvA3krTPQyB2zwl+eZ8I3pLTrq1l8KE
         U2yOoZE2DL5rEXxnD50XBMHU3d46XkJ6zn74z4Dl0IG/qyoMKW6dWGzzpWqM26ZITSOV
         uK+E5vVr2Liq4B2LDUKJNXbFsC15bwozTSB4SgPJVwdWj9FWEVusK5RpfbB1Dr0i2j8W
         NPN5qtzyccTqH74Dk+veYV7Kz1B5GkUVGyMtlQUWr6cHLT/nSLItZomI5GbuHDpuI99k
         7PVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+s85k0PeLNHrV5Ctmh65BF6J8rXYxbdtjUhMVM1hs2DGTVRxRfXyPPU7AcsvPB7GcE+xuWCeYB5E6E2b2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/S77kqxqZBqTil8Q02hxWg3sZWEYV14F0NP28jkekzWvFdx/
	mypDnQixuB8U0fdX8KG1sRua+XTsqWkszVuXItAr1cXC88VRDMaZnfrccfG6TgyOVnwosrF8ZRT
	X
X-Gm-Gg: ASbGncuQUzgzirUQlJ2P9LvF8xuG9fCE+5qoGmrC8HamBRQvp1DvVR9/VMJtotKjYdx
	tbkrkHVjrZU+wLeIcnxdP4uF4sw5CuDprTyqi3NiKu4GSXqKEWN7jkL7JY3VyzLCWoNqzBEw35L
	QgLShLou0tUstUXxmFGvqD4YppfnRWLh0jQlPiFbm0gN8akFqyp/uCQkjtR0K2ZEyh7DL0T8X9D
	1hW8kOW2dS8LiQtOKfEF6TYF+Ce4Yrrk1MWJL+acIrJFE++QVqflwzgWnQejvhVzlkJPQoO4EM5
	T07Ulr3/gqYj/Bu23VrX2kRWGg==
X-Google-Smtp-Source: AGHT+IEWx6Qroyd+owNLnhKMgXzpvCrfsJ5gLeMKvyo/Cha3hnXDj8amjvFC6tZrBWudZswu2pIc0A==
X-Received: by 2002:a17:90b:2317:b0:2ee:94d1:7a9d with SMTP id 98e67ed59e1d1-2fa243eb4e7mr19748747a91.32.1739219244559;
        Mon, 10 Feb 2025 12:27:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:24 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:50 -0800
Subject: [PATCH v10 17/27] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-17-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4587201dd81d..6bb53ce72ed5 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -90,8 +90,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.34.1


