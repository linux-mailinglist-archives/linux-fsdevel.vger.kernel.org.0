Return-Path: <linux-fsdevel+bounces-43611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A320A5983E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EF6188AF28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA922D781;
	Mon, 10 Mar 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qT8njxvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330022CBF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618357; cv=none; b=ieflMGMuMqdt6nR918V3xh70L/ONFCq/2yBVkVJFje0G/OKbDEghf0TZd/2DJe6j2dv9UdSadJdcZoSRJ7F77iygrBEEoshU/H1FWMENb33OXrx/5POOYq9JoXIrTca85XxUSUz2Zf2OdNZuaBYbuhOmjIHFdEotl/JguigDG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618357; c=relaxed/simple;
	bh=fvZEXse498MAei+juRUqd4/R9FeoMw38NPBzNnBXz58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeTAtr9oOZVFOAVZBiDLNRsiJRUHp4O4rCBCMMou3pPzCHXyTY0DU54jdczZ8heZx48yyGX2n6Hhs4hGy2enwmzA50xLjAI9niabZ9tzwXEqP2Bge4Dd0e4jdfz0l3coQ427MN/6uMXzzG4FocoIH6EbGFfX12MnOfA7uoRaHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qT8njxvc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234e4b079cso76854915ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618355; x=1742223155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=qT8njxvcFWywG74UVYmqzi+wSnsvfdw3Uv7Oqs6yTatlDi7wXNGpKuHM2kvPsw3ijb
         +l33qtxvqgiLvjXowL9sNa7A42FMbI/UPW3tQkupYq7mbR+MS0JpCMGW/EBBdm7O2NtF
         4uUq2Pnn6gb+sykYVaGeSTx/Gjx4NYx8u/47/ZfVKQGhZuPGFVwSPBcIXkS+oanJceUh
         +2XFVVjZDm5szukXs626lde7nfrfjIkzt3NLhvXhtDNmmxIEzVnz20MUJMYy0S72UyVD
         XqwxHOE6mJp9sGmrVBLUuLONPoEQser0ZpgrgLfVLYMZjpo+M0aEMrRSLQ1grYcop58a
         WpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618355; x=1742223155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=KVrbkprpsU/9u/DplbRCfvgpJmUiaj6gFerDMXUeie04mnhDqR6mXWdUVK1hdJGYt/
         tRJbVgR5m+93kVzCD+f+uVI047aRuSoXTX0FKDuaLsAR2FTpc6ghMlpSoGAX6EShMAuq
         mOrm4mBj4X2hf4yso3FYq/fM6fc67EVDvpBznKhnqvMJLqxyP99e/MG1GR/T8NdnHNlZ
         O9R9WeQi1mKeiR/zVoGN9PtAeeZRVvyer5VieusgDniwUikHkt9joUIQLkuqFEv9fUnF
         W3AufR70rOUumq49TWBygzx4fUgsD4RKTvmb8cq6/umg/tCzh9o6rYQCCopnI5weKfcd
         danQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpcIz3DCbO+3InSr8Dk05VCoVkaDqAt4/lvWsBzgrzXbveUjFEIS+3kUKUxK3ecbRnMkdhvhgL0aMr1Ul6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/J3OiZUGJBkemuC4PGoGBRGqnrFTsLbF0dWmYFhXpe3sIcLo
	ga+uGyCJ2klkz1mBshq0r2aq/xlgN78brIoaesBVu/TUZrj5ruLx2CNLEAJrG84=
X-Gm-Gg: ASbGnctjGUAEXdyssZ/9BEKDLieYI1NtVcdKjVcxGnk4FvXwMs7jwboe+3m14nMjnhv
	xQtALsqOK5M4jaIGnmPfu0hhcFTtgjWNqOviENiLCagkVH6kFEjaQDt0EueFqHFFRUl225hbEuP
	DQDPZTqccrZN8gQQu/Fqo8pR7yGuWYf3TKrvt/NjNVnGfoom9VG+3jZjxu3gPq/NkFf+xXtLEP3
	TBN52bWkMuEYAXawLinkuVNx8XzhPQDAMV4WrZFtSmMGxDFoNwrtH9hmOwSuzcPrZc2PjXHm12b
	k6F8hmxDkfFohJ661aNDE9KQnoxmMFu6vkwdeG7eluwhYpe7JBJ82hM=
X-Google-Smtp-Source: AGHT+IGmALl7tE1vDAuhwzUIZXgg+Q9w22Wqj1GO54eJLmN8OylP52nRYF70/T1mCfLbdEp2H00RTw==
X-Received: by 2002:a05:6a21:4606:b0:1f5:7df9:f147 with SMTP id adf61e73a8af0-1f57df9f49dmr7380018637.40.1741618355060;
        Mon, 10 Mar 2025 07:52:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:23 -0700
Subject: [PATCH v11 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-1-86b36cbfb910@rivosinc.com>
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

VM_HIGH_ARCH_5 is used for riscv

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ef231cbc8fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.34.1


