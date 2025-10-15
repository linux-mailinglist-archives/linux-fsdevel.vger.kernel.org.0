Return-Path: <linux-fsdevel+bounces-64262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0FBE0071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC31A3B14B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C01303C8A;
	Wed, 15 Oct 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SlxRf0vR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4830103F
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552026; cv=none; b=hxSAv8SUcOQKaXiSz/wSNAesiFn8yO2M40I4urNLVVoZxFREWhiCl21sPGtP2XYuq1iRoRTscSSo+nx98zjPhhMoJvAObYmV7+IS1v4dEfxoufDP8jhtr69ob6y8BsiJk5m2XsIHLFlnkY4L0Og1SmjJ9ipacewgXlz7KdOevgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552026; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAaTHRXkkotEl0xg9dMvf8qQBEmAMSplbZUULvFj3kwlT8vb924CC7b+zvGGcDmX+1LksNB9W7UTsPghGGDEzW1z+Ii3qj+KCn4uF8cqKPypYMoKTxZizYTRxzlDbseHyjGmTHQBlSZzojAPoFkEvIq7TwSN6CuaDFp24Z6t69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SlxRf0vR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6330788b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552024; x=1761156824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=SlxRf0vR86f+JdCivXZVuho/Ou6syE5bOrJYIXDsr1N2NnwLQbpE78vAaPkCMa2gD5
         dswCw9Tpnzgdx6fOQImJ8FDo+uaL3zooSIaAr+OoRC8AO09sxFOyX7JBhGbv/SSEO08I
         7DXG5Rf+/bP+fG56dUZF39Nz3Yp2eE3Fs9Fo07/ICgZd66wTBnJ5CeBSNjUvdgl4SwI7
         u7zTs60+yqT8Qr0oNNkHlkGcEyjErRmMPy7p2zj0XGysRaFXGPknSakU64SwZqU/UwHx
         TlMkA8o4Mt6Szf6U7VMqHfptggkKy0v3e470kSwy0S9ofTiwojfRpcJHy8gsEqDwbHMF
         vWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552024; x=1761156824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=AazRrLdK14av1+1zUb+AyIMCvupER/JT9YkEHb2WqFsDBFji4ekOij6knD18wZG/H5
         5nTfZ+eGMsOfjVAwEVlin8XgdMDKIzm126keHJ8DsA1Z0Pr7QUxHKu6AEfTCPiaPnHzo
         WEGYvnyRXZEJt8FMLWFHAusUSMJk/arhxLKruo73NEdWLI32FzhWzHKUnF0Ig9SCpxRp
         26LlVBXmQre0BVvUXM1TVOsgwRMw+ECG9xEns2XaL0R9XNOCMf6t3hR35nPxJ+TVlBF+
         NJ5mclj9/aKXWg82LfDAPYaBDm6DfIedWk2mkQxqi2fcFUA20QDFilCVX8C//fKrRjnu
         vsew==
X-Forwarded-Encrypted: i=1; AJvYcCXrkHLzE45hXwW6TTHwRoHuRrE4fVtp+Gs60HaX/R5lKB+4aoUzLiAmznGXiPWQCpXt+8IZ7cj7vp87+7Q2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rxT4tmUcDhAatvaykMdqzJo8Vc5neHyULVNSN2C2pbbCT0t7
	ZjqfGly8LZGThcUuCY4W7gYPiKoKv1h73ZwOvBSpX2ZwEXOBZZkWXlYwe7MeyCcglkg=
X-Gm-Gg: ASbGnctM9J0LW/2br1ySzfTAAoUa/DX2YHmgSNPEHY+jJABe8u2CGp5TD4i3wvHaVOD
	KaLHYjgtRvhs86Il46o3LVT+55B6QtwslI6/IQ/170nyPDp6dA+OWr9uQVa/q+YX67DkzjQzHqp
	wu7rTA19Jh+7w9kUph/rFc0gynWTvx1Fwo2IQOYLZK1A1xVO/I2NUBUQ83YLyYpa3KZ9xESIR78
	4E3sZmk+S4zgnd7FQ5uvtowi4pP9GVf9X1yPM5k00p2e0hvTGlAqIf9pF0j2tt0YMt9zwDpECBW
	ycpkSvRmWEMmK7/E41fhNUckORwZeqDmajWfxetWoPzeFqvWfmxOs1Z+ug3nz2VMPKbVxb53ptd
	r02Fy5Pp/JTbBOcbE/bBq3j2aKjcJxi7+UaV/UChrs8OlS4iqWcL5LUbC1/KpZw==
X-Google-Smtp-Source: AGHT+IE532Sc+sFZCiNmEvoJegTZ+cHh1Xu19llh3mJ+MHzVrRYzHyEQ1nhDnGpeZ7e3G8zwayd1Xg==
X-Received: by 2002:a17:903:2c10:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-29027374b5amr339106065ad.14.1760552023763;
        Wed, 15 Oct 2025 11:13:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:33 -0700
Subject: [PATCH v21 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-1-6a07856e90e7@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
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
2.43.0


