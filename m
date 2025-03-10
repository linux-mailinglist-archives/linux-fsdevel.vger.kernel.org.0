Return-Path: <linux-fsdevel+bounces-43629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65031A598B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9268716E12C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECCF238165;
	Mon, 10 Mar 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="001MDNVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC67238179
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618402; cv=none; b=kCtJKIOyEMds9rd0/yfwLQ+5DF3dtoItfdYueyXMPdVEY1Wiji/E8a85GtGA8Crz7NIxCBIJOs1zQ3ypV8FoMpV1EFp5lpnzo//VRUsSUAFVI71/hNQIb98h5o4RINrVMGzlM2C0UwlgDujcnVDBXNK+uOm0B23G2r4popwH0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618402; c=relaxed/simple;
	bh=NmVWKk7RCdoTm8/kxl5H6XmDwgptfJerdilzp6YHjbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcKWRoQrHvDxOG/nyaQjwEl9YKbp6iZ8ZsnKYBM/afCoxILsXCvsLHGpivDzLUszERd7bcmsqCnwcQWcFK5YYDa+ndDhbxnHShKxuXwd+5SJIc/wdxf6gBFdUk+/NBKii2ZI6gxPzlln76Ed5oZ/FdqfOkolzqaobuWB9DYifFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=001MDNVH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22185cddbffso95176285ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618399; x=1742223199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=001MDNVHlC1le3S/p3HpJjvvRY1zWlgI7KtAcZRY/0MIZyG2mLNEY95y0IK+V2WarG
         MJJOCnOK10PlxOPHAIX08BPn2OjLCRoB9QlZZwXVNknopwgUgFClom06HTKqOKFF1g91
         yjNwR/9DnNTCex/suq/biq2N1c+CHhS7+kiY/cwHEaIdBNlPYnGde3oprqKifrr8f3qg
         zTyXQmFw1Odpv1AhL4vVA5Sl61WG3HSX/RAdSZUSqsGogS73lJ5fSIFwDWXgbenw9a7p
         JrTwrZqZhiyjHptDYnm0hz/vj/99iTc7WB/SLoV5zrvrHZJUXIbICtAYM/zsqWL7Qr3x
         3bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618399; x=1742223199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=ePGqpHrJPeLz58qplawiLlHPRX0ApJbq5gFo3ATM7sBvxGQBNgEFPF8s3TZtUZyXht
         eCflbPEgdyVcG3A2xP1MP8veHd2vqQMQ2/2b1Y8yH6oBgA0TQ6Zb5d5grtmSQgzv1Dc2
         XrulAP38HVp+MM7E0JiKXa8wI4o0/wcX/OsLzKLul8jIp6UJahhXReQVzd6ju1hrKM0w
         XRZ9UYXCoPnP6DyBEj06f+UOFKXpBb8Vj37hMpUoSWICEfxoDc2d17tijbxmKX4LPbsf
         gmXqo79F9Ngm2nowok9kAKfK27uYEwpw85UO2L3wxs9M5b6eGQ1ydU6lXnEFcJ+ZennH
         4oEA==
X-Forwarded-Encrypted: i=1; AJvYcCXlALWuXUEhDZDHLOcxiUQDwSUf7spTsHnDDGZLg3jakal6Vtmjo3XQH54DJfBO5bCEnNGTXiffIdC3gxbW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/fIW1WE1t2crxbJNZNzUzxII1lO1Oybsq/54F5o35LOTwEqD
	P/D9LXRdtsz4lAN4R/euNCXBFSbaC2quufjC71mxkJuWUq1fNK4snED4hI13KU0=
X-Gm-Gg: ASbGncti8Q5SJltmWg6OWyxFhuU7cMBeDDxyCfy87PxAo2+T4CEFu9EifMXY93JWffJ
	1uZsiOTUTb+isE6h6CKxPkRFrxBk3aZ96tRft6Pn/gHmI4afym2Ly+JFZDpGgrqKC59K1Ca0MFT
	C6Z9oShmdxOgKBxELKuYe2yB8F4eiVZuwptnMM5A0f06V2pg8aYA2gexC96Z69xiyQUS9e3BawS
	Q/W8Sley+Te/N4N9cjOzEulnPUjQx4A2mfF04ig8SZ6W8S5iNStJ87OrHx+8j6cs+lSKZDUAisn
	3aeCT+1AMWDEDzZ0Xkm93AURnIjOIXSaXnog45qmHTvgINE7OHEOHI8=
X-Google-Smtp-Source: AGHT+IEx/P9VhGmpM9Qve+8fxlnJz5OWfBkRKBtIDANK/IPRQR8t6D11CbRKG5Xc1EPx3A5RF0LL1A==
X-Received: by 2002:a05:6a00:2b4f:b0:736:b923:5323 with SMTP id d2e1a72fcca58-736bc0fb12dmr15850983b3a.10.1741618399230;
        Mon, 10 Mar 2025 07:53:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:41 -0700
Subject: [PATCH v11 19/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-19-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index c3c1cc951cb9..c1b537b50158 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 51)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b816306c..d802ff707913 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -108,6 +108,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
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


