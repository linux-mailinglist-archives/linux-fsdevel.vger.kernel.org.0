Return-Path: <linux-fsdevel+bounces-64263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD36BE0074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3619C8283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4A3375DA;
	Wed, 15 Oct 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Q8ZFNbuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A7303A0B
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552028; cv=none; b=NCZG+C6j4M2kUA4vbrBVeNrPwLu8iugjPY+KqXwH+6s2o58aF6XA1NOfoDc6fNm5ENpWbCtdbTJxIhkflvWWFS3vbmZI8E0YZztiP8WNoH2vaXfeb52Hq2q4zbJAR+gjRYW6XHM6ImUPa4Y1Il4fsQ3h2KGp19aRNg7Zn8qcRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552028; c=relaxed/simple;
	bh=onQZPDO/5PI+EGQWomoauY3V7EJZG9au2H7fkbOgnBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRrlcpjEzHSNbxkRaSwA0phO4/wR2u4Jm1XjPw9AZPXnkE3lVgdyLra/aODT4kEcF7wEQ1fv82YEm3noFN1+6ko+thLxEzQ10IMPLoF0HOsj0deJXAygshKmauiqUA8e+y8Kc9O/IoTPlez9dAD2RbvC11/Hh4Zw72uEF7VAjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Q8ZFNbuH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7841da939deso6286411b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552026; x=1761156826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=Q8ZFNbuHG2AEPhvEZXnbKpfGdBxs1HiFJF2cXbOmjFhGMg+0wAW9f0N+5Y7bT6Gi3i
         wQM49YzIJ2xf1vqe6zUcbjH/aoX2sG0Yh98I+beaUiJJDSesmRbnL31I0ty/6IA4sWyD
         g1zJ2YY/UWV0+UIDaoqrO0vFEk9INv12rom6K6QkWZ/G1epvAaAt23W5p9kQ4e3PouYW
         hby/wsuD17jm9OC1Pv2+l0wOenDvPIu7kJl+rgCyOK/JV47kn+LXjds71cRBa5ihq/Bv
         PbwYkf5dSh5SYSh0KQ2UGi7ZcPpBrLLjF2fCC7OXD2UTHqhti4mGHKhZwnQI0vlj4QNZ
         5YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552026; x=1761156826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=J4BU0rz61Ex13IBuR6Dwl0L5kqHcWfiZJt5ZhqBXbtMbRzEP1YChHM7NSO0W9435KR
         ujNNLyNrh55as6mgEfhMTv6YJQpLnzdj2wRzk0BWBJeFuy2+WM+uMGqCCHS1X5br/51V
         GWFLEe7biIEh31IlnGbR0jIBpCDAKMNRXP+eCT+qLdXmYpUs1xwfLPBeFwhwvKJ4VeUq
         acP5ze+j8L7126r5TN+183EdhGZv9xG+aVB9ZsFOgmYNa2Vo5UjyjRxszOcfSjnIz+Km
         QsKpWNUU+ukoYf0EqybcVyNz5GG3vyLjlwlnI/YCqgoWi6fNADLAyUezR5A9xcu/t72k
         FeuA==
X-Forwarded-Encrypted: i=1; AJvYcCWe6vFLEMOTxMHuja2wsrod0LEuKTna9DEL6ghHsO2VbayvPlkrpqW8cJfhZg67FCgKUFg2CTf86ssENsoS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Nt3MrSyMulm803So2muQn7PICodBHXtOhJT1Uzs2WYDkUC2m
	VO1yERxcH1b6sjD0B3VbRt1dYejMtSx47fzYzE8BcFZc5z7fC0b7mxKsv8cfsesYj6E=
X-Gm-Gg: ASbGncuUIM4O4Lvdbhn49ELhmN06aRc53T44xsGEjmnnNPVYxrTgJ1aWr+T82D2i2Xt
	L5xZ0y/3i/T2o1gQRbz8Fe++mGBqM7HZ8cvhkbXLL5zt0q/nXe9Dir2LGmhnwTvr1f+cQMk6Ppw
	EO2V9U8EH3Sew3NzC6yRc3S156OGTynmKIsgaQYja9rs8IZZi9hJ8IyqrKIHy/48zy9X3O3M4Oj
	kR+wCxwodrliBQfCvZhRc0e7Dv8fc4c9+Uq4349Sw3epsIpiqGutZIN1m7W83ghO5QUmFbEEg67
	Qq92xWjmxXp90+PPXSN2GAwTaM+nSWdkKBOV07h6COki/LDGI6/WIoA9vJDmg1wNUMnzwur7oTY
	x3onwPTgVP9zIB3fSZ8VZB9IaOiQ/rOmHCdacM39LDX4CB1Jugyc=
X-Google-Smtp-Source: AGHT+IG5lE0uCP31F892Rhz+3o+LdNX1Rw5571X/JjIijPM/WottLx6odEgFGO357kvJF6BtLvDxeg==
X-Received: by 2002:a17:903:3c25:b0:26c:3e5d:43b6 with SMTP id d9443c01a7336-290273ef107mr347052995ad.32.1760552026115;
        Wed, 15 Oct 2025 11:13:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:34 -0700
Subject: [PATCH v21 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-2-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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


