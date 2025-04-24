Return-Path: <linux-fsdevel+bounces-47176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168DCA9A33D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95CDD5A126C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970791F4622;
	Thu, 24 Apr 2025 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hWS5HHox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C931F3BBC
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479230; cv=none; b=mCPS9GrifZK9JDhkMthPbyQY8xUCnDfeM64PRmFpB7pncNO6iPytcLPyO2/Au7UT8PtZme3KAaVmlJYvhbgx+rD987/eUbHfdI9ZFtja9R/kFV/V7M659e7/iOYE4aJXAtBgrDU3Rvt+26ZFN1sFDyv++hrYled7JoRLkaWkqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479230; c=relaxed/simple;
	bh=YiVhhtwo3/7LJndpVIgtujp+IRS33vrzSOrk/lIRdRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u09f0hs9kDGKCqom58VcG1V5Rk7dUOXn9h6dWCrIoepOptP/oGOptDdxVmWk53wfiVH28yfetO03Vp88IlG4iGrK2CPtoUBmHgA8u3/19ygJ0XsOhuyOH7hGHcVeAF8bnMhwLy6JbbYAA4mCQxpxQFtw9xlXY4+rZgnix61jSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hWS5HHox; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso9623285ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479228; x=1746084028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnsN/FT6wHpekGZzdtp9zZaBWWGp9NhN+LtMYNwstuQ=;
        b=hWS5HHoxvm5MOWQTLCMyR9dRx4b3dOMxsrXWdTOwFnJ0kMmHgger579sRaM9G7GHBr
         9HNJelZ4gQ25T6hs9mTbVYmVnrrNTkawXgsib5Er36LvdW053BW01C1sBLqxZpERPjBX
         YODYKTS/lFEQexDv4zhE8ojSveqzTuB7Ep2Kl90SlKsDCW+pLu5JLGQYlp1S3JB5at05
         /7YL2hVLERzwpNg984cyS069FEjCYeArPwAbxvKqZKoRJLGDwJzPToAs2O5J+85pknH/
         6ooXr8etz3jzaW4XWtbj2POL1DaeTdUIbl448Av0uYoW3Sk7iZYfbP6GL+83A96KYDZC
         n5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479228; x=1746084028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnsN/FT6wHpekGZzdtp9zZaBWWGp9NhN+LtMYNwstuQ=;
        b=WXTyCPXCQiJcr+UdOKswNZEHXUMA6caK2R3Y2UEkLwkKfDDxCr4OSu5LnHXc3Vrckh
         r2mczy+HPnzsQmM5U2EEOLOsgeaMMU6OS5NlwJDxZKfqQ4k/fKaDYQ+VyfXoCf9O4BbP
         x5JlnJQwAj1PicUo6HME/9oC0O9cuCDZUuBeYNTHdqa0Md49bd4Fs5UjA8DrpOwQCKyB
         sE7ma+39EIS0m9jEH9uMjVIw/dmVVKEwRIMmCl1sonIKitQ/c3XkHlWDv2Y9h2jWvMUL
         j31TDnBwh4X+DpRxvfRKtBRI02/3UPL+mXudOkOaouDMZhvwDbcX/ssen1SeOHZfB1DY
         FZQA==
X-Forwarded-Encrypted: i=1; AJvYcCUSWpSDdYXSQXcbWj47hz7KuP+VyuCO5whZBRSiP9iE3/ChMzAB9GSPdSnUEascOyEZ/gdfGor5TP4GOR5r@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEtjvH+vvU84BUEi7SZ3nyMU6ut2f5QPYMOO5mAqBxXjJl+im
	CXaJ7HnEP243VwqwUps9so/koRXX5pxTyeQD2EynzCs9US/q0ALngX+w9ERJZl4=
X-Gm-Gg: ASbGnctJx282VhBWZu+DVt+kdciS9iffAmFkRQW8gUby6jKwR62cS7TjjFHXI6j+W7E
	cDq6VGuLLubqaD80kEbSp+VuOggYCk0YPEtLlc/QQlIncmV2+MBT7dnQCwdoIOO7Y/ZZkZaX2QL
	OGLtAmeHxv/uj4kVJPPbfVc+Hmlrf+e6Zzz4heHXhzQ6q57TYASlZ/vg7culMAoW61UvEAwFNZ5
	I7G6X+TQ9AbYGAq1zTUWLehINlFvc3Ho0avhPIjZPaQHz+w3kwbcz1bM4tlUaMipwZKPD8XGpi1
	tf+Z+QLFjpFfD/JHYxTglAZ+YULfU9Dz3aE44JwcsACHTS8mi0cRBDo/ytu7KQ==
X-Google-Smtp-Source: AGHT+IEU+Y137gYRHLnOx26vSf7L3l2vsQIYY8+sFwtF+6f0KCB41T+GdLc1UUDDDmJfXYf+XxTPnw==
X-Received: by 2002:a17:902:ce0b:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22db3bd0f4amr25027775ad.16.1745479227851;
        Thu, 24 Apr 2025 00:20:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:17 -0700
Subject: [PATCH v13 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-2-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
index a63b994e0763..9b9024dbc8d2 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -426,6 +426,20 @@ properties:
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


