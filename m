Return-Path: <linux-fsdevel+bounces-65314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B98C0161A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68501A0676C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65573322A2E;
	Thu, 23 Oct 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="YDanNtvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1F3195FE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225944; cv=none; b=EdApDIt3GMShzkNZ5eE/aD1dA0Ccqv1kc7/EPjQOrXYQtx/2A8iipzJF6b4VZeX91Mywx48uUXR86cLPnD2Kv6YGPfzDOAEJWjWczCtPTvN4l8nxwGPjDR4HveorbQ6CAs9mfa/AfTbxFrabZa1SYIhsHq83naRD6SJ/cQ05LjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225944; c=relaxed/simple;
	bh=onQZPDO/5PI+EGQWomoauY3V7EJZG9au2H7fkbOgnBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhEBX29FOww+uBsEgDemoZl1Xd/BoMp86kx0PACGfGGX3CtUEIvRTuq6gMrlWzEX9LFUOAtqG/Ppp1ecla/ukkXBAfz5c6/4BmGuOPhaJ820e0Opcb7qWul612RBiOxE7u8OKVKJ8baUTQFCU+lDoDYlCH0GGFEjW7vPP1+pFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=YDanNtvS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290d14e5c9aso10365055ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225941; x=1761830741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=YDanNtvSMz4xyaPeBcbGIHZA8YhFkYywg4srsnSROEljXZ/CSraF4OnYeRWAfB5evS
         WJh+o/vj4r+DX8x3JGdL+cL+DkimdX1XT/bMyl3V7rkwV5EoNmpj3OgeqxK1V0VMEO35
         i2MxZXt3ftkDqKqbNSxzfYjkYg5Xn4Ctwju+wkjlBLr4MygHBWAF8qHPpWKFfGVN3+J+
         Vaf2WPjeCQANuJpWBGG49bBeaA1KIVqijFIpbHz+C3so02R60ZKGKBE4N8Zuv/sk27rs
         71odVAyUjiEEdIuOfL4FjlMsnMeBBqVVGWt1EUPyRpTGRIHr66e9fuDlsxiyB/HCccaU
         HPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225941; x=1761830741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=EA75LF8oSjm6uvNQRjznpNYQzQGSLJVGjj/VVlNYC/S6Ml06l5siX77ypr2GKKCT2Q
         SkCCU9ar4aQgTIjB36hCb+LMrF/GcATyyrqGQZk02ZyoHEEnirzPqx8Rq928mzLWJF1z
         jGPJrZJ+x2D8EE6bwaks90j4Hqb8QlM8jaG0A/MCfWtIisKyfvqzsXIFO5dM/AdFO8TY
         hWqm+S58Ht1wyd1Lz2x9dK+xG3M1eGQqGxKoPon+9KVawLjrxVQwtOoZqMvZzLanrdWP
         t6RLt+Tsw/todki2GFLJ+S6PGnQefOr237lshuLhSQCUF+Ipb28UZkVZTCp4IVvuV3lO
         72Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVAL21cdj5yNVJTqIUPqbP3qk6HiZv5urhP9YVx84i0/qaf82SKtToR00hPjNZSSqmFzAcwwpcXCnm90to0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08BDtyNZ+5OuZ6w8gv9AnY4fMsfEM5i7QxzpvliC6yNQr8xIt
	8kVCTjtw/7ONbDYb0fhOWVLzyIYCeBx/p+7cvHnUXzgQgR91Mz01BBVdvggrK/GQhFs=
X-Gm-Gg: ASbGncu5H7VOUp4/Fn2cV01Vu2pMoRlwQhlQvbN31rLQ3pt+72Jb2xTWAlxW7UMKrVQ
	faEJTo4ZO3gywUg8RYlzKZBPnn5WmtbMYxdGvi86PUOgzB4Y5On+53pMhf2L1Rs6WHnjHG6qRNT
	lHSfJA920MDaGw6Lw1KIhhnh5xThoG7rM+8fLOruyrqfLu7g8mA9mzepc0CLp00fz1hS9s20bOY
	7Fq+YLr54vtfVV0TOMOh2xFz0F4sSKSQmX+M1qGXCI7IAbgRAD5a93v0sJDQns0YrI/+v5WoWVB
	zUvsEWcH2SAEzpR/1aa5XD2Kfo+v7TfS7zO4WWKFzU9Y9Y/8vhCW2rDImqfEW3RNxikSQb+9fS5
	/8Hn+g06uV3FRUAVZDqm9dFJCaxjdZ2nrRWkSKsbret6PkzWNDDSqU24fqO34Rs5+H5q+fSFAOc
	zdPiOfjh9NEJuDnwM9Zud2
X-Google-Smtp-Source: AGHT+IGl4K3EWqXzwvKFEGfUV31SHiJxvtb202KqFHfU8YvsQJIOKEaNW7S6Y9DyIV9G23eYEwYAmQ==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr349494795ad.47.1761225941004;
        Thu, 23 Oct 2025 06:25:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:31 -0700
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
Message-Id: <20251023-v5_user_cfi_series-v22-2-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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


