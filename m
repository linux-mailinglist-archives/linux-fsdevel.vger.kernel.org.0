Return-Path: <linux-fsdevel+bounces-50637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36403ACE2EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 19:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F6C1892580
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BC1FC7CB;
	Wed,  4 Jun 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YYZImV4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83E1F791C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057381; cv=none; b=aU5Cmyfla0rXi1bwxx8yESsqcyRGrh8WLSxoyAwUlpSCA/Bpd/dEpv9T8F6oHSypJ/TnKLaZ22APGA6L2dFYyQVylpDgIePGASd2Z3y1FquODQC6mvh71sCOg53SvqORE+ivBV0EmliGVRktGsLQq+yKXlQeOG0vxi51crzjDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057381; c=relaxed/simple;
	bh=0tq61D9uccU6FiQqC8xv/y4u19vkZ7ShJckqXhsFT6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRmoU3UZAnKW7W+/1vW0Qqio13nLHsbkddzK1iGIm2ayjbVJwIZhJwyQJ7rDFYFfAb7j7qXlIi52YEAESytSD4scUFgKlUP9f0xKC5sPxbiXYHf1fceCwH3XLkU7bOjiJ5FrK5jntrEPAsoDbdyyEeP/ClCRlltpxxrZrDp9VJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YYZImV4X; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-312a62055d0so93875a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057379; x=1749662179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=YYZImV4XAxaoX3dv1PEm4++u4SUVmagxZ5gO6578St8oHtI9Yq+C54jWNio035aFQf
         drwQ3kAA3DWXVEF6TtBub4CmoS9epqX1qBGuI2QO1+5lZXtOBTGVE0SX03C6xSAu9fEu
         Tr4zKwupKeBjLdh6ErJEYkCd1xy4g4jnxDH1Ym8H+SxRYMkeBUIx1FYBMlN9119NH5dL
         H1fBBhuK4mjP7hF1PqMyRbvfRpMV3oocFkNTwwctZ/K1t9RfRXO65DhgeYUwBGmf93Vi
         gIKTKg08X7Ew2fjPwnTqqoPyW+YKVNXypYnZ1w5elSzyRmmN+/u3Q90Vq4S8Si7w+AHt
         Q6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057379; x=1749662179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=qTKJJJHjAqsv+6xglk4/rHT84gR8JJB9UiptoL3CD/mZVw3lmUsD1YKfaze5TlUzCS
         al7rJVss9LoeEN/7lcFjyj0h120v/KECy6JafiDb+PVf8bTi9EUD24SBJRkU1ld8OWBa
         Wz2tAIVxDwkpbQ/QG10ZWMV/lf6lhxBXju1tW9D+mPCMRSfF6vqTHGDpWl8VFhKjF1s2
         hYb9LUIDDTSpG96E58HQtHwIcazOeP1CSrvN9h8I+HbrTdcGkMSFc6DEzvf/32W9S8em
         8jF1IoGG9zZR0s0SGDhNFGwd710vFVJ+1/eYGgq1+WPavSh6/DgyOeHbRtXHN4+fCevo
         lsfg==
X-Forwarded-Encrypted: i=1; AJvYcCUVEnNuwCi2pJgr3269lt/U75H37BiTAfKZy9OX50i6gTf4YH9aKWzue/NUKq4vTIROMkh357y0TZRN5OON@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQucoP55xCpfNYEhfYnUOAZRnJIsAjEe0j2ge0bKNqCnvew+0
	OW0R/FyXlCRhEViEgQtn6WAEF9toha8dYzzEc63lGuhR4cmFDX3dlvkEDQ4abNepodU=
X-Gm-Gg: ASbGncuX1+AAJFlUQOI+JsKZE0LLyiJimlAmKVyAxd2GWES9axNQsztX6PpuUoMII0H
	mcwMg7m1eC1jbPyXEsqq183LTRStKsGZDTPViHUnFfcfyXRFYAPyqFvalToZhgY5cWkxBXXe/Zm
	BYelrkm3FBZfzoiNRJihn6/roh/ocrKJNFBfnKqaRzKn7GNMqoojBzbBSPJMhya/eD/0KNzoJyH
	jXXc/vDdOoY/Xl6HXltfmLuEfZjZN1lzZupa75GvcwQgyp8czQAoX/WHE9wbD4Y3XWME4iphAjR
	EUxKc5DbE+bQ9E+xenL/PZ/kSefBGOIodeL+B/9eYDZ0p3hvjXTeCM6roP1k/ahCA/vhGTsv
X-Google-Smtp-Source: AGHT+IGkexVwRd4MBugt686K9ooA6BwNW7BY3mlzIvdhU2r4+d354fip8huOwZDJ0pdHlmWrSOoHpw==
X-Received: by 2002:a17:90b:2692:b0:313:279d:665c with SMTP id 98e67ed59e1d1-313279d6ba1mr1336750a91.7.1749057379093;
        Wed, 04 Jun 2025 10:16:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:26 -0700
Subject: [PATCH v17 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-2-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
index bcab59e0cc2e..c9e68bdbf099 100644
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


