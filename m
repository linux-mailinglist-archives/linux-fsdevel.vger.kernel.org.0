Return-Path: <linux-fsdevel+bounces-64759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9990BF385C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED3318C307D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D942EBB9B;
	Mon, 20 Oct 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FvDMBt34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50C2E62D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993622; cv=none; b=iWfj8HScbqW2QI83ievSFSTUlEC6kn5T9KbropGIPcWBoQCkpIZjGbMoN6Bvws4CLaCqd8kCLAViX4G6i9+ML8fA7OXdM3B0ZWiA5+FF9ry586jPy2pbIYq0YCeIL5Oqeo3E0Ux2uaL/vDMSVuwmSHKUYObCSgcFVUO2mG6w9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993622; c=relaxed/simple;
	bh=onQZPDO/5PI+EGQWomoauY3V7EJZG9au2H7fkbOgnBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwbLIwWmEKlIxOPebLTuY/0e8zc/T/nEBEb1RWPD6UmXGzFuhm7z/YzlfeLLJfLTKp4LXDHt37pwPw3hTgWIATCFPIs7jMGMgwsnz4KCb7C5OmR62MOgPBQ80p5zC7EbR06oUWmES75K07vYe2fJm5Eq7y11SDtjfX0V+YtAjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FvDMBt34; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781001e3846so4456589b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760993619; x=1761598419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=FvDMBt34Bf4iVxQuImCUekwk8iBwWuuao9LFHHwRIUfSil8m2XEwWsXFsT2QHTaeoS
         MvKPM+w1ALObY3TlROkcZBrA2fyK7c/DJUoAKLtB6R01OA7PAzIibBn/N8QJfhjAq01V
         ymS6quQHPn2u7rftkeTdvpBuQrcSZV4W5yumPha+Stbj08h3P2gasXyXjEYDIcoixVI6
         SFawYv9yF+UvxIv4MQFKp9SmBmpGmSc8J8SOz0/5jzi8rEyVlpudDGtE2b1LEml2HwIg
         aaBzHeNgzZqeV48h5QKVNvwJCZtVbL2sPe0yRmL4MqjSh5qoXS1jJE4ka5WyGKnG6DtK
         oYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993619; x=1761598419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=JunZ0E07ALxfiwbOGMuAudfaB90ZzHQA4LgYRXuCVAigxw1lWUao4Oy0wmsvkEkmNS
         E9mWzBRJtzSFYQRxMHb6rhxOgGTg6VG/nuhMi4tLdyB9+u0y0hmLvvJKhObULz85FUQ7
         THRlN3hyctuhOyW0RT7UatQN4Q65a53UbtBk9I/c+49l7IDRfJhNaxA3Hw21qX/EumgA
         P05rk+7VkuconE2HVNo+xtHUIOMzBMQ45KWmChNyzD0jkWtRe8PDZPEtldIkGtD3BD3/
         VtEmmx8ZTX153Iybh/yFmwVXUCIxulhTm+9RV8DGMtaUMwyxMHvUF/MLuKAeOpavHedP
         vTJg==
X-Forwarded-Encrypted: i=1; AJvYcCXXo1i9VtuGLs2ByhUg84XxSt7GAc+x9XpvMpeDAMUpgvH4sz1atjr4JPzCPapVFF6C/8kNP2EwTS9T/+/h@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWYKjn8vwfnG0W5xP/aR6Aleuqmo15z87eWQDCFFW4G6CxPyS
	cvDbgJadpZdtyx6PROfh2Q2YQpaDMJGHut53r2nvzh6OmdpxkGTXwVcYiTFX+xbRt0c=
X-Gm-Gg: ASbGnctRfBFm6ujlF/ZwRph1zOoUuNq8MXYRxqCGeaKvDDkXReqrD/rcOmJOVJ4Irf4
	s3ImPe/JvPoN9yQwZY17wWio7iK3BmBR4lNdEIvkmz6E9EQWUONJrJgfgGSeheVOUQePG7SVSx7
	/MpVN2cFM8caX+O2LunoRk8APPtVpPDtLhzCG0lyhjo5upc/Vm5tEkq96gkAyfkl2sDIyxqxqrP
	ak8lX7ZoQXIrnm69YkCoJ97ENYLR/diwdj1Sk2/APS9X9z5Gd4cmu2MvSd1IB6LLK2SxHuP8duj
	qGg/MIAa/+/PsvSIgxns9gTpnW4MPMYsDk08qTVSIGp+BPTm3uW0/GGxxyEZcZCCHVL4lqGTv2h
	MsQU9jJHY2mMvyt23c461IqWwDsvkDAOuD1COmrwG5kbGV00lXba3Uf0uj1AaHgvHya23/vxiBI
	8lCZUFOr1JQ7qj09QDXXFl
X-Google-Smtp-Source: AGHT+IGL4wpVGpFAR6+71Q3uMu9smAAvPQjPoICYz6gHBaftPyajfTVLLzLP1i70rrv4AcCHkeSJkA==
X-Received: by 2002:a05:6a00:acc:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-7a220b0719cmr19998820b3a.18.1760993618646;
        Mon, 20 Oct 2025 13:53:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1591dsm9453867b3a.7.2025.10.20.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:53:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:53:31 -0700
Subject: [PATCH v22 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-2-9ae5510d1c6f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 543ac94718e8..3222326e32eb 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -444,6 +444,20 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description: |
+            The standard Zicfilp extension for enforcing forward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicfiss
+          description: |
+            The standard Zicfiss extension for enforcing backward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as

-- 
2.43.0


