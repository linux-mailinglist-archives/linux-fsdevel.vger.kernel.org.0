Return-Path: <linux-fsdevel+bounces-43632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D703A598DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53990188683E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CB223BD11;
	Mon, 10 Mar 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="02fXvqYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B423BD13
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618408; cv=none; b=SVlhrXIOaIKQQFyn5qu2nv4IbZbeDQemPl+6RF8RgV1fW6OV6Oet3Aa8asPHx7OzCFC9I/b8JjB0l7Of5Zd7DGKcbWR6Vcb9CFdJkQEhA7Tx84RrMBt7MSQPDsAY2qDkLMN+RD94g+VUs0PMEylCKRngTdLkQvveLlf/Rn8MLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618408; c=relaxed/simple;
	bh=zWvCMjEUr0fm2YGOtkO5JQMRJ3MfHFejTQpY2YYRpeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+63MlHfdMd30qpfdEVnwxkNKiIv4xOSdvbXMasO5t7OeQmtg9UtLsOUUY97Aq0JPlGWMt4I/zM7+lWbPWtSHnnCvUzh2F/3dMG4y4x2Lk19b7b29bRsIS8qWtjH3Wqy9Awxogf7Gfq+N0u5Z7FA6bw4Csn4JR02wg0BE3kU67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=02fXvqYm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2254e0b4b79so11056145ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618406; x=1742223206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opxHamP1ejpgUrZttGLg4zwDHWHLF3xPs1/Qb/08WRM=;
        b=02fXvqYmI7IQzrMpZK7gWQgvRJrftC9vOY2QlY/CM8V2HigjhV+w/NhLxRTeEtYott
         S2q7kSjN72yJa5Ufr7WNsgAxBQaPRxaPtmQ14/lwF1on8E1MOrns3WfNwEZCQNFrYfxl
         GX52zg5xG6UIPsdCmuXWJna4/t0SmvTqPIp2e0KDF5gTKiAT1Amm+d7ScFnLCsHzXtGI
         FEyqvUmVtYaQI/Zb7K1ksG7qzmbIOSeCsvQqszo50mYTw1QzcKG9b/fXneMLRQWsQOnq
         bg32wUkKQoBy8zsP0AAuBeuiOmbpUWRyIMYciP3/LXXmnjAuZ1ZA/9PzQt0oY9ba4Agc
         5BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618406; x=1742223206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opxHamP1ejpgUrZttGLg4zwDHWHLF3xPs1/Qb/08WRM=;
        b=uitxMv515T1JZUbEvCU2byGJUMphMhhLnNsN86TIvIWduIMGS2Sk9FSPggts/3bvzw
         0BSWqXzU629LqzwIL9RPQDZ+D7QAczYzZ4u416eiPDO5aIec/uciC73C2WLnzW9WkL8O
         gJ7Tsrsti387dtl6VhOm1rFdnojRrUO89FmIzu0zCYMUs/hrGdPCpE4kt4eoSS2f6xY7
         rzDuVR92VxEfZpdJBgM72uABJLJUlgt0fuHqoyoeIv3uXqvJPrpcevxyS6KcF3OxISRP
         5QNEatOyFPr7rGnsCIrf4WAn6VJ1hEMHmN4osvpO82JR5qS2pDwFsrQRQ+LixfXISEP8
         Ro/g==
X-Forwarded-Encrypted: i=1; AJvYcCU77Q031/S72pU65gpVWwFfYi6xU1q2jb0J/B9nHbGLhTp1EOCHhrgeZjlPVxaJ4YETOdch5EOn8a3dHMNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZtIO+Fe8md0/cSZG6hXNa5bCCZgPKJRgQsnt03q/tX45sp1T
	C1fL51Acj8KITOkFP+yGwMNRAZSmsxxKcRf+qWr2zka+y/NwlpHVRWUvGc8DUGU=
X-Gm-Gg: ASbGncuhFe/hic7iAV+eVz3Rku/o2UUmYteeTeqfSrrkCrqwIEIM3NthvIX8q0XJENF
	B3czqKGGrHh3edU/cpp1iQLO+xZs80k9u8X+Pc5aFoJECVKuvYbPMU0XMySFvjh8HNwvYJaSmKC
	dthrkrZQqbwNMZ4uNw06a43IpRL9fJUajC20RvW6PuVtPU3KYVJXI85o3NOPpMmZwHfKDXqtE9k
	uewLhwwR3ictrlBSepJarvTnQ/ScQva6L9SJ/rYwDRW152HqwFAwU4BPmkEDYIhDAzf3rb5TWnT
	ZrJ1XMpf0RNBPst2BQeejVkf+Th5uq6TU0dePa1i6IjiWuHQnN35PgU=
X-Google-Smtp-Source: AGHT+IGghOp+j7sQ0Qt7sq7k8fXJkHLz3hwRxKC8iR81NfpyoYASRowQ1NRmeDSzKjKxRLkZDMtKZA==
X-Received: by 2002:a62:fb06:0:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-736baa02af4mr14991022b3a.20.1741618406530;
        Mon, 10 Mar 2025 07:53:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:53:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:44 -0700
Subject: [PATCH v11 22/27] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-22-86b36cbfb910@rivosinc.com>
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

This commit adds a kernel command line option using which user cfi can be
disabled.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/usercfi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 6e561256bfaf..be08e5bb6e62 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+bool disable_riscv_usercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -390,6 +392,9 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_shadow_stack())
 		return -EINVAL;
 
@@ -469,6 +474,9 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
+	if (disable_riscv_usercfi)
+		return 0;
+
 	if (!cpu_supports_indirect_br_lp_instr())
 		return -EINVAL;
 
@@ -501,3 +509,16 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "true") == 0)
+		disable_riscv_usercfi = true;
+
+	pr_info("Setting riscv usercfi to be %s\n",
+		(disable_riscv_usercfi ? "disabled" : "enabled"));
+
+	return 1;
+}
+
+__setup("disable_riscv_usercfi=", setup_global_riscv_enable);

-- 
2.34.1


