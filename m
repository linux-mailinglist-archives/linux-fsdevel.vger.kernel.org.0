Return-Path: <linux-fsdevel+bounces-64024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE1BD66D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9661734ED65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5C2FD1BA;
	Mon, 13 Oct 2025 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="RMZ7uZi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AE2FB627
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392565; cv=none; b=OSMrX1eYwIlZKUULWCso9gdYQHktGs1TSaLMwa1+avbglf7dlBTAMGCv8Qp8fc8buy3xOJYegqXtTUWarYkuQseznM+/JdWrn6q9qg6tbYcHCxU2pbHqEITUQD7ZQo5JtYsQgSJQ6I4Iv5WRcUXtZ6dS8uZRSE68I3d4Kv79pq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392565; c=relaxed/simple;
	bh=onQZPDO/5PI+EGQWomoauY3V7EJZG9au2H7fkbOgnBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dn3RyT9Qbz2UooHjqND0hj32mWEixA+8xOd9+EVxf7BB2pouJPv4+7RtbdlHRyBT0ZBaFOSIb9KaeZzrRZwX0ee5mMY9tsjAx31hkhnaUxB3Wnez3v0POTUygU5+BRQy3mMhepNoCXjhFlWHt99Ucp8QBpyJ0dK2UPR4LuMynOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=RMZ7uZi8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so4119477a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392562; x=1760997362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=RMZ7uZi89iOh3KF8dtFZajyQ6Eu6hQjrun72cRAPze4v4Q1CRHwSbP2875vztQFM5s
         uz+Apzbe1ewdCyW+fvtN/QqCovSCzE5069Uw7/61zhgB/qxAeYbJteBQ8Gn2HioL9Qph
         QhX9n5e0YhNicmQgbHge69RcZ/Y+MgySIcC9YeKgL0sjMwm+xuDZ00LxF3A274I91Bqy
         GsoRYLNx8FyFXPTOOr2hM+tI11XDSDO14+i2EDV3qP5hPJiwCy8pyTDXrgzBiesRAzGa
         O2z/rGu9MWHxq3XOK6MG74x8gN2zMp5BGTlWrt7kfSaT2Ch15oVbNTEYjANuREk1EKk/
         CeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392562; x=1760997362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=doEbfFhEUqj6+Z6Qb2yGl0jsdbt8IMWb5rOYE7/VJvw62ItuxwEg9GhnPWT7rh9tIp
         yna8S1ZSGq1y3gBY1b112zZ3NWHUAYzoOQ7Tf8gD8slO74vYqMtQa/P4jbE8dKzjcy2l
         nnp3GfvmsuF4LxknmGZpZ/XbaGitFqmlnp33bd9HekL6K+YHFSJkMA5liCYyUlg13J+C
         lrXPNWKd55s6SoTsYgP+1ni3FRxukY/NCBstop8Vtj3Awpgnis/ecErQ+uuGG/Sm9gRx
         gZiLTIg9k+cs4bYqTWqX8LSpyrGXQThFMCJ+VDL73l0lPgLAZ8PszWRaeFWKsng+h5tD
         HLAw==
X-Forwarded-Encrypted: i=1; AJvYcCUHkAQ8Gda/Am3MqN1Mii1hO5/EVrH6Sr7uhuekZp+2QAxEFLGkHUwbt3y5gZ2z8CHV1tAjz3VJzvK51nY5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdltua7X6DfMUmGQGqU+Lo+FyyKrURgcR5D47OQNh9gsQm11KR
	XCwA2dWwcZNCBRsrI/2Msm35pe+PxxO9+nBl3TuaYp8I1vljSTm1Yvr+Lse6YJJnsqY=
X-Gm-Gg: ASbGncv4p7LoqOhyXLhQgt0rA6RQAPxgjVXHoxVlj7R/Onks8XQuQ6zMNzJNdASLxQy
	3rCX1w4NwDIf1mhXCSUORx6IO9FvJJrd8R7SgatilifQLJdyQ1LbMgA046j9Qtrv+6ZMBcXPBCP
	MQ3k5TI4Lz8FlUwznL5iu+dQwUyewEg5J3Dndvyq0JFhASxiYYFIXbQQqub1hZCH7JqpLPIAwGl
	yJcrAw2fc5citRohcx1FHaFslMeW6Td0VYZUDpPMZx10q/VwwuJC3PQM/Mzwt2uZ+C5Tjnve1d9
	Wex6DHLgikanxz92oJtjjsxOUvsr0b226J87vqDP1z1ohARnT+H5YhP3pv+/lenv07FPDObCN8v
	zmMX9zGzTlThdzepm0W/g2BDJDzADRCNfpD+6zeCnACNOXQ5R3oX8vS63OtrzyQ==
X-Google-Smtp-Source: AGHT+IGp2pHmwU1UwjR7VWVlmD1Zgem8xnSW6VcNxKOg/UKV/EDFr/tijHZhs1T8DdSJm+2/ITobLw==
X-Received: by 2002:a17:90b:180d:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-33b5137586emr32096496a91.23.1760392562315;
        Mon, 13 Oct 2025 14:56:02 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:01 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:55:54 -0700
Subject: [PATCH v20 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-2-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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


