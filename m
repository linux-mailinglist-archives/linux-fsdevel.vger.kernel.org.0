Return-Path: <linux-fsdevel+bounces-41470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A1A2FA79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FC93A3276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A124C69B;
	Mon, 10 Feb 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P+MOXZ/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D66250BEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219252; cv=none; b=XbUlcDtHOGo6QyAPF+PjrGRpW7UINHlgkaWW0wUmEdsqg7B+e7B/RoL6LpeVd9q3JnICj8Dk+udnwiCnMWkfaph46jQUhT+F7CKHqqDmuZPbJdaE0xFO9ukXtvcEKru0fyOLse37G2vm9HnzxXgZrgUl/rG/idqK6AFjCq+Rpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219252; c=relaxed/simple;
	bh=NmVWKk7RCdoTm8/kxl5H6XmDwgptfJerdilzp6YHjbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXtsxqdXg2QhK3OxT0JeNCfq4kf46bHQWTAnHh6tv6BjFZzn55l/nuWhripwrlFNhjJ4eZCjxUHrLae0kBBgVqNdTk1OQ57dyZaj7BGyb4AX5vpIfjZJlDYva9/1NP1V08UVni9m9g1KN8d1Eps6MaFW65ERdNSwQk0D7TAzK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P+MOXZ/e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f6d2642faso58717475ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219249; x=1739824049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=P+MOXZ/ewCBOEQQ3PgRWhwMFXy7m/YkwALhtYvrVVVzozxwYXwirhID323RIFh2W85
         vqjoC4NX/rbn4nuPDdbnOXAHBHUPWcGRnooREnJp7dxZg96krfjR6f7hnUmZBZ2krWHf
         1nab+xxqifZnD+xo4LbJ5Fw/pMrGrtPNIeyrr/I2HnrWYprxlYSEzjG/bKwtxjo5s9Z3
         MOMKTstOqaxFfMlb6lU5cqpY2bjT1rPDhLTwRFzOiNfkO2cIfb1dCUTXpke99gbzmm01
         HZtjGAbEymku8yG/ceaHJaHRJY52Y4hXvV1Q7ZF83C2cLxGwRRtj4baLv+skbF16uUuB
         dPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219249; x=1739824049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=tF27uUTO1TP2pfxJSFCJG5Xv107WTbHvtCv5CsFSzDeWAzgrXushAPqYp35RWsHB3W
         UVk/mwor3TVVe4VtJLKg6GUxUtNy37V4JdcnVCInX47qcw2NvbtEh5xgpaG3UFZ8HTfm
         MdFeLv65uziaMl5wC7AXaBW4BJ+LsEWlVX9DZZwQa45YF4iOpZGZ6QNjAHpwv5U/SVhg
         M5/18dlCR/kx8NqzaSZBB9TwCn1jArm4XvaQSjN7jGqR23851p2isK+nfJvkhr7CjkFZ
         3FTBMvsecXacPQak4VAYWhx50yY17sUtLLsKWqW6YI15d2X0ENKlYiRjM5zo2Ym4XCpe
         3FNA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQ48RU1Pt18JpKP0vhQl7Kn2dR6EOxcOkQDu3OaVgoxfOcdF7D65tqjbwUi8OoQ9B3+NwtLzy/8VAGIrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyBL3hybbZTDdR6+a2Of/eemZzXPbsn7vOYU6qbh7O/ehW7+AKo
	izim03D2ygGB8HXgONIRSWU4vDhW9sACdKo9BFJd8XU/+VwoVHqIMdViiYQoHQxllb25wbIN8MD
	0
X-Gm-Gg: ASbGnctsdU9W8igdgGzJ14ija+/YQdJYn7PYVwqTuVhNtVudWsRQjM985LBJ7Q/Rx9Z
	2ejEdd8Q1igh48uwQx3u5+FOsJ4XA13HkkxB4aFl/s4I9ouUaSopRFL8rQYnCfRK2XdY8sPHKwH
	b2hbVAdXqKV3dlk1QEN411+sUjusnz42VsARaAEVNENQMvagjW1g9amwlkWBaFsg1xcVYo4w7q8
	dO7MPgRZYBbHplYAvDXBRPFeVpTdHpxN5Mb5mtpr7amfaMBC/5MOVrXiDsxeHxlbm3f6EFdqm0D
	zxBRmsl1EJ6n/z3UW48FcBpVtA==
X-Google-Smtp-Source: AGHT+IEt5F3RjsoBA/4cHXJN1Ltv5WX03R8vCEuQgHxCW+5M2vSetK20AA29/O7CLlddL+JvfC+2OA==
X-Received: by 2002:a17:902:d484:b0:21f:617a:f1b4 with SMTP id d9443c01a7336-21f617b009dmr211020025ad.45.1739219249583;
        Mon, 10 Feb 2025 12:27:29 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:29 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:52 -0800
Subject: [PATCH v10 19/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-19-163dcfa31c60@rivosinc.com>
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


