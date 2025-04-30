Return-Path: <linux-fsdevel+bounces-47659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111ECAA3F09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747919C01B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66B21D587;
	Wed, 30 Apr 2025 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sMC4GSVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C08219E9E
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972197; cv=none; b=tRCzf392L5BqbrNzfQInLI869IObRVeGsyaqdFjJWDksAPllw1V7548ULucYeas/++O/r7WEXbB053EnjgYIJmbGFwZ2nBfTfURxmyzjVMOjYPp/g0DTLAt41GkOqvSqeMhZQxycf2aoBrC4ceO411zd6eQeu6Q/GxKoh+3B6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972197; c=relaxed/simple;
	bh=0tq61D9uccU6FiQqC8xv/y4u19vkZ7ShJckqXhsFT6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cy5DY/JrwI88KakUl6RkY7IfxTqW8RXnE23vYvScXy3WDvIbZLZjKCRHoL4OYvPThtJKzbad+EuaJhxFJtCivxnOTKRPcHUu35gH/5OJfuu/hF/K/dY2xze29P1bUxW0v9tnayQxOMmtfdPFi7D9+ON4zMSOkEiGZUGeC7JUTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sMC4GSVP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30828fc17adso6631063a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972192; x=1746576992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=sMC4GSVPZdq+3xo/i9GAPn9J7xS8K31wIwYHW6wZbRo6kUZQcVMEzq94A+VRNVp1fr
         vT3x9Z4Y14DR8U6Rj3Q1Uqkk14sdYT4yNBEElyVqkXrGNBX6UO0QOSOCMxlBAsGkDBdx
         yYwVhhSZhrOkWGYUDCWvMKUGp/VhGpY6pT9/iV5Obe89LtQ8W1iSpNrT6nn5Hivgblcm
         h5biWDfm0s7+2UtNXJ2qOBt+9TYt++RFJXXKCUVmo1OBCP5nDJWZSW5JQ4XBrkJbLkGz
         LRePUqYsvhRFm+9MQct1fHW2c12vJg9A7CZzaeuI839YAA+gDwA3g3ROeEgEdw7GjGsT
         fx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972192; x=1746576992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHp8skVfcDwQ99Y8qvuLL+UOu6n4/KmOGLmf3JbJ7iE=;
        b=pjiqjRRAduPqWnA6Q83tVJdZsAw0WiLed2nIN+sMZENPbRUSkWBi+4VvCCDmUudp+H
         WxlzvcSEaxBnf0WV50Rpe0GD744M9RDv3MeA5j4KoIBwQR34k816w8AhV4r1fUMruPh/
         XQ9pQavn0pA9SEIv6rh6cYIGR62oHKuVBg9I0CUDca3XC33aBfC5yx9nTU7CiKMuFLAL
         rifTuX0kSnIcRpTUjZmAbK278p8MsMZ/ssbvp/Tn7ewOvbxIjnv8FBQxkLsCMiqlR5hl
         CZdF069il4dQl+cJYfPhVOTXXUVZ6k+8+yfjTUHdLMCqifQHhYxMditi+3GvAtVos6xX
         Ax6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuesbVBB/5Zy9SYWa1r39NwhzoCUGkWNtIvaAz9p0vecTppUjP/gbWaVBY45sbkFTz3ppwJkNuVkZ/fRBE@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTmOOA69G2F2EIkzDBhiTzYwfrdKF8W8rXWu3R2f5l+S4t/qS
	E0XWST0T1QdoPxEhzcuXjwq2DfIOam07MeTLwK1hZpDeEAXtIWoBodXziK1Cm8E=
X-Gm-Gg: ASbGncuMKLPmUklC28PZVWmWV8EsGv14ZEvriR1Y3C2lyfJjLqwMzHd4yXq3X1Nej3O
	U22tNPyebQvjgCjA7pyK27UrlYEXH95ON9RRB98k0To0HO1XS76ixxn4IEZObghGnptULGsZ/p/
	nxc2smHuRrq9nhaYayCjYf4z/oSWRVWOAg2rQYtA4COfu+Uij0K8FitM2HKXSHwFiUNu+SOWh0o
	PW1o8iGfQerjWQbEsXis7xpCcjKOfEqHd3H/aKhSyd06XfdF6RocTIt3Llpj2oWH4KEBzarT3ZC
	h8jqjnOqAGWtcrU5ExHiPT8XLsi9xO1hy7SCPSD+xkRd5URWEPM=
X-Google-Smtp-Source: AGHT+IFZqq9MjhSqj6zWUKle5rqAOmKZksHCBhGRQygZlDXBwlT0hJq0zTG/U4jkXRf2orxlgxORVA==
X-Received: by 2002:a17:90b:3d84:b0:309:f5c6:4c5c with SMTP id 98e67ed59e1d1-30a34450c14mr888187a91.25.1745972192207;
        Tue, 29 Apr 2025 17:16:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:31 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:19 -0700
Subject: [PATCH v14 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-2-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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


