Return-Path: <linux-fsdevel+bounces-70706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16361CA533F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 21:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BF08301E4E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A734BA31;
	Thu,  4 Dec 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="QVhJPuRJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B94C6D
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878642; cv=none; b=NT/hOpu4K7elxh7fRz3DtVkm2lWXlhGxUduPwvPicb3I0SI9XUekE3VO2a8DB+jC6xE+VTfaH7w1zti5YUGyROXpb9RqybqJKGNZbXYOgiyICfu36AIGzvKz2zet2Wmg5yKrG2P7N2kJ+avrqp4PgRicl2oiRz4KtWwGFrM13wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878642; c=relaxed/simple;
	bh=BfqrkDAmEYT+r742gKB+SlFctae91M/veuPAGWY6Q04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0FMNK80SiH9pSMtJbRaJ39splXiU4L0KQVsEcWUM/4npjm+CjudCs3CGlMZA+T7v7RXFWmf4B+6A+EItXV9hBxSHio9kvu1J4K1/8MhP1hMMTuU0/w9b+OIXWWJ1ZInUKHpSjMqZgv0yGiz7DjtEY5cmzI1UuEA4AHijkFps7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=QVhJPuRJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1186620b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878641; x=1765483441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzDCu7IaTRxcq9mEPcCPJw7K7qmz1vUabcyA8OBdm1w=;
        b=QVhJPuRJw4ru6itiJ7mirR256wQL1Nwf7ZzEv8ynm53sTdG2LDVUYJbIlylkvuSge9
         l9tWrPUyJZWxDrK2ghm2+lYHwOa6458aXIp6osVS+Z8rfI337uL8Y7hOpdFB8p0WKok7
         WD8EfOKVFpzbSecFSaBvB2Ru5gktu0IEyvd3XD2+0N1RWcslOP9EeIi1tvKUmdk4LarK
         DolC7Mu0+csv0sy9RBYeZ3JxRd6TEHKa4up5wRFtzHfGvbb8NdiqNdomsl5xe86tpnmP
         PyLGuQZTy/KzUIADrY0koWLjZQNOaqnC1ZKr1Z/ew1csuzcJa7FiYsd2FtJuibz1i+ol
         uJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878641; x=1765483441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZzDCu7IaTRxcq9mEPcCPJw7K7qmz1vUabcyA8OBdm1w=;
        b=C37R/vZP2f01nJFgf/8kWtFuIYBPjqLib1gguTwqr0I4oQ+E8cgH60JOeo4b1rYE6h
         +HYuMf8aGKJNBwG9BwRl8VBI+YO7X97uAn8LbDXOu9BYCt+Q6UZS9w/vq5YfmZHIxlyn
         yVEExtt8LwzAHcs0G+YcI/X1K5BXf5mAhEmsdh4ll/ag0v02Ka2SVqI3Tq4khLFbYAHH
         wEOLPuPmRlpdUugNDogtd926vY29seti1y8VQ7TwquAFPvcovWQhzGptd7sBjOo/9ixW
         dV7kGTtxhP5XMMODEHOZpA6OoHV1d2K+4JQlUCJjdkkRWLoxnMIdBrfRbq2vZ4vqTEbB
         U70A==
X-Forwarded-Encrypted: i=1; AJvYcCWD/IiP7VoBoIgFPmN15aYwKLHdkxDDZsWFRgpGencFd7gemQoJ/wlWiTcodNw30SuI2rlWCwRv9iKHQ+t8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uJE/wJWENhDpNnRILn0l17HSmTt+oK8CQvoKbLOZn0zC2uJ6
	Swd0LxZShABD7QRQbV4dm/Dt3zDT2naJgPsANrPgzFC1ZZm2G4ccq3O0AbAERrPn7/8=
X-Gm-Gg: ASbGncvboUlBg/kri64rtrpeQvwWYCoI0eWRHVW/4LTpDg4djO8EWrqhE0coPRlGoj1
	mJdVZoxKZgRnF+3wZoGuv9diBU0nwJeNl/IH5sF4mrr+Kh2JkLKDkhZ/jqeNvMezEmEK4NmViz/
	ZI5uLSuUwyu8yYdKS/+MxEkMDoWrNC1GQSuk7VOMDHpQfc28gt018KvMtoeU65zX7F3cAJvTFWD
	5GtbVONjDk4fDxQyhfaA919Ck7n0XdfH/6whvbQppYD6NG+D4WYUayn/NMI2LeYHXaumx+PJPRf
	r3bvQKUVIZOEOTeCdYTg9Gs8oTGSkOsmOKDuapw4S42vNLV1HcaLWT3wRDGmZSwsBisLBy5qx2B
	WMwEXas/KG06Wf9MtOk0oMuXK4OPbj54jd55GBa+vwFUE00rtJEBwhNcv3GR13uefVRU7z5eyYa
	3H9yVAwDZxqnNe0C7BsQtD
X-Google-Smtp-Source: AGHT+IFS3/LyaA7r+iO4CE8PdPOdVvp7/Ont/dyD58FlxgFclLSqiPQIEE7yhvikN0vHy7ae7J+lfQ==
X-Received: by 2002:a05:7022:925:b0:119:e56b:98ac with SMTP id a92af1059eb24-11df646417cmr2797504c88.19.1764878640495;
        Thu, 04 Dec 2025 12:04:00 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:03:59 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:03:50 -0800
Subject: [PATCH v24 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-1-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878635; l=941;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=BfqrkDAmEYT+r742gKB+SlFctae91M/veuPAGWY6Q04=;
 b=rLyoDrCEHiggT9VGWh+AV59ny1tITwEdtsn6xQ7T68CawzBV32k8ccRrfNpmgg6pBQ3jSqH1t
 By7DryeDPH3CNPKMe3XDDQ4h9GMvBJsJm+XUidd42pvbJxj7L7UGjUE
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
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
2.45.0


