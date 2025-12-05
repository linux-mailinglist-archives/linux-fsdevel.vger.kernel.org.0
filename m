Return-Path: <linux-fsdevel+bounces-70854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95236CA8D05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 19:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60BEF301CD81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92307349AED;
	Fri,  5 Dec 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="GV//io1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1482F25F0
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959817; cv=none; b=S8xOALrdRhDz0y0k4WrnYwGfb3uN9yZ13MTkbXQMmKm0CK7SRV/DaeXdYcsPXVmx21LwIpEGDy23jVJQDBkR289v2vhH8uf65b6s6+E9BqP7SAePQCn3Hru6qL6GVJJbS477XWtzUBK4GDLSHyEsfSHt2lO0RCsekWzDxS6/UDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959817; c=relaxed/simple;
	bh=vDVmmVGnkAFlfQ8sB5tmt1wB1lda3XmsatvedsLasmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chbanDiia12MgePN08EvYe/znSpWihPc5EPRurIW1zKYbGM+RTqHHiRNbdqP1+OnGlZiLOes9rF8KXL5AfjLMMp8kuSrzNjJg/BeNkHRzkUeLapjwPE99qOzPwG8pn0iz0K3hn+2RgXttoe5SNQQHBc4knmp4lzwTNQPkESaoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=GV//io1f; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295548467c7so30160255ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959815; x=1765564615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64xLkyzyDt+G7LhAFS7W5T4PZ7pgqwloJjIatj/cxJQ=;
        b=GV//io1fXl5h9w5aMxur+jMOG1H8NhcyyY/48WT/K9zQCfj3x7lNPAFRQZTB0QcWt1
         G1lV15JmYtH1PzgD+vlkeJaseWJuh2HRBUfPsAZufmxQw6Dp7kdXDvcGdl+lP1/gUhtb
         PxUA10p9u9xBUPJ0AXP9hRJqXv1/ReT+DgSBjU7r+/X49elW5i5BLQF5roSow4Sh0sy4
         GNEKhR2Kk+PXKaL+yOIjbO857zFRYm5szbyQbBRNjOJeOM35NjplRROki1pKAn6uOwBc
         to18TpYX5COg8A+wlbgTd2d93RfaoNSOr+y6YdZYrkA1yHWCrxRKUdn7mMevH5zBXO4Z
         8STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959815; x=1765564615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64xLkyzyDt+G7LhAFS7W5T4PZ7pgqwloJjIatj/cxJQ=;
        b=gCzGgKQRubDNaI/bxwIJGO0PAPt7/cRuO4uo0kAwuknZEW1zhDv1wkhTU5Jn8KMjgo
         CaNc+L//rAcr9+lRLRHNbq5Acv08SlWoMkot+jH/07SpysBm921oeMKAUqWMKjsILE2L
         WYYu7zjDRPu6rp47dtg+vpesdijhaMCpgm8ddvTsn7Ggf1/hbMCg6HGKkcvB/QGr151C
         rbnONfLobQ1kE+o05SXu7C0zlTHawoUAyO0SZfO+I3Iz9XVNyBAhdJZ7H3Q91KB3B1IQ
         KjdRHdUiilfArhgnH+akgPXRIs7NJYGC/kP/AvKJc+iIAzK2jWmdvr8z+vaSniwXmSLp
         4qQw==
X-Forwarded-Encrypted: i=1; AJvYcCVL0V1bgiJwHWypmLKth2SSz+wVa6Owwl8nP3C+ulCgo6Q1vIrdVtG2bGcteJ4NpQ468W1h44FTOYk2Vcuc@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTZHawRmQ8jIw2jRhsnJthcd447vNqOMHuA0sVhychS/Y+XQm
	SXPJ+nkLWa9VwnMt1LE708k5dr/eWpT8C8VHcKzrI8n2w1jmthvbLDhzQM8sF9zCWzA=
X-Gm-Gg: ASbGncu9vU9B5zJ1eGVAui0SX/YnzGQUpfcFQI9mHIGUIHyGz9by3297deXq+YyghGn
	ra3/RurYPvgYXZUH1aG2LMCpHLmDYVtPxnK2dpJXu+ckFWbZC6sJAwDZU7SzYGgfxGyrF0a9Zvd
	SOWSpSCHNlPNBceNwIgaZUTftq//mNu67Knu6+RYvZtJqK739TO31mSWqEMReLCtN9cLi7moSbm
	AhFdyIJGXWTc5z1j6a6ukFmG4Ur8yjnq2dnyY9PeHE7Nh9SzqAkEcdzo69cB8peo/VZE/hWs65R
	QXp8iy34BuGhyHbgM8uq0TdDgWo6aaHJa+KYVtUw98St0x1S6lLN4nfhn5N944Sr+iohFUxEexP
	vViCi2TVVaafKVQ2VIwEMxM9zbspfRFAOnnOEE43bUhTsgRhExvf4ncrS8HhB/uDp5rfgLsnRhL
	Yu1tl9uiIbJiFKfEemAL/Y
X-Google-Smtp-Source: AGHT+IGU2sLP85/lJ1hQVHbc76Oe28ZFP7QFL3n7WXxEEBaxhaqoxKiUM68PA0g4YWByoTPd/kSlLw==
X-Received: by 2002:a05:7300:cc8f:b0:2a4:3593:9699 with SMTP id 5a478bee46e88-2abc71f7ee3mr78452eec.22.1764959814725;
        Fri, 05 Dec 2025 10:36:54 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:36:54 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:48 -0800
Subject: [PATCH v25 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-2-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1566;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=vDVmmVGnkAFlfQ8sB5tmt1wB1lda3XmsatvedsLasmU=;
 b=FTcBrsY29zH4CGwlbVTm1o8uVBkzLWVuJZRVdzWSvyaLQ+YCd1ACncy30R/KVfqxKm8RGhxIK
 fyUsZ0gvoQPAEuPbkBJtPN+hiBZ+Driu1BfYy5W9om0F5sqYa2IMOjY
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Make an entry for cfi extensions in extensions.yaml.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
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
2.45.0


