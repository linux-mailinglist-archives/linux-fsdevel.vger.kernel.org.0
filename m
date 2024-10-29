Return-Path: <linux-fsdevel+bounces-33202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E59B57D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAA2B233B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A3215038;
	Tue, 29 Oct 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tpACsMkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F12144C6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245523; cv=none; b=bHmIrPjUIchTgEaCCo0DMbT18uPEewUxCLcztat4bnNG1oTMsIR5SNXG+wCCIz0vUZnr45kKVtGNoZq9SJRNtPBMkuzc1qW5v9F/IogZdTOXsb6mob58tWdw5In1r9AyFYeFUJjPNvr2Bx19oU2mLPvkQR+vR725jO/Jq0DuHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245523; c=relaxed/simple;
	bh=uIj6D6eKxGy22T3W83W2H4Fei/chUVRqxoKSzM5k6/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gG/druog6nGkXmyK/kWJrlM9X6EOfO7Ul7J1OLzjB8sIl3r1OCIVCTQ0nmadq6Wqq6VBOtjooEvWdteAYYXd5JrHvc5QETZHP/2TYsPhRZzMTQPqjVgstRcNwxbMO4KBbQi8dYCIUwv2QxQ0W2u6nD492ceQYii0QX3J84o/Ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tpACsMkN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e467c3996so4617810b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245521; x=1730850321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn/sn+D1z+93mY85aikbkRt+t3FRvwF0B8Ok3zV+OA0=;
        b=tpACsMkNDdHDMljNEfzxdFWJukqwQPAK6dy9qtuDt+FvoNqjYJQDXJmiLSxFz9KKvp
         QLY6DX1IIcTg1cEKmVYhfMcnOrfAtEyOEoeYY9prN77TOfsLcwcX03tycZ71gR/Mz/A1
         Ie+IYvktVIsz5iTd3ax1eHk7gwW29LC+JlmrjS9r/rbajNiOwCyGKLvIwk/4Z6frMj3R
         U9kDn5gc2YBbhwXJh9zbTtTLZt6BdjwydgcgNWaNiITBbp0PNZLUp9qngN7r4XCudRfh
         PVUzNxPOOVGprPwDRI2TnvJJS7esOG0Ekph4ruIK/qEFAsAHQXiGQgIfHyGIWb2GUuA7
         eJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245521; x=1730850321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn/sn+D1z+93mY85aikbkRt+t3FRvwF0B8Ok3zV+OA0=;
        b=OmTbbhmIjWVoJH/I0YIqA4Qf7m9t88+Y/TIKJxmUNK6N8XqtPUnuWLvoQSlOBBwPdZ
         44pW4CyAfht/JnhcU7ZgeN8JRB7BZzLeW54Wk4y1ikT/WeX8ZPp8pabHWXtU3DrJIdWj
         519OrzBOtRKbKUZjR7WpxtM03ekz4/y/VXsjOSzyB889LMz7iTXT2lR6gNg2/VUzbx8R
         1ARYDI1RflCb3xSCUZQlDpAf8xOcry6v9Y4qWy/Z9PUI8Oso+luP5fa87N2PiIXVk0HR
         DipvHAuLhia/qsXr7qWdnO2l0QlysZzQRGROUMFe4PHHwi4WIYDGaeOeL+BpJDIJuqTg
         hPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhOcDsttZorboAadtrP0lCqpsgle5iqLu9RTq+QKR7iIzWuNKTxHD4d2kIm9g+wtZaFJHhigHmq17ouSGW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv0WP87CPIBYS6PKG/itEYgPt86ZVzWzYYpLfFS37GVrZcoJf
	Kh+44g7xhb4ik3N4rfCcE153lAEED2vbKCAZby6yHSIOMvhVBWPt8Mg9XwZ04yE=
X-Google-Smtp-Source: AGHT+IFSRRwDJwzMEik28WuiCu9TazkISCRtSEmteAY39kMNDbrF9hMfjaoxtBbs1QyHM1hw6YiZLw==
X-Received: by 2002:a05:6a21:e96:b0:1d2:eaca:4fa8 with SMTP id adf61e73a8af0-1d9a84d9df9mr21491704637.35.1730245520903;
        Tue, 29 Oct 2024 16:45:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:45:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:25 -0700
Subject: [PATCH v7 25/32] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-25-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 1e153cda57db..d5c5dec9ae6c 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..98f72ad7124f 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);

-- 
2.34.1


