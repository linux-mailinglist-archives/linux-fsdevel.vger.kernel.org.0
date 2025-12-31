Return-Path: <linux-fsdevel+bounces-72288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE0CEBF7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 13:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DE2B3021790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B809322B9C;
	Wed, 31 Dec 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Ap73j1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDF320CD1
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183762; cv=none; b=NBVfx2TABOwbxwxAb1+QyvoyrjhkT8RyWx7tnuM0zoDYcBkF4/badXN04bkVDw9JVQ7ydSd8zGwUx1dcAV5Qz4AqM/j/hdV42EoKv5elC82MV9r/auQqccIN1UZeIVwSNqm5u7ud2Tasu1zOcCYf2T9bHq0Zmlo1qrRAFeQjHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183762; c=relaxed/simple;
	bh=ho7sEa3sHiw4JAsNigwc6kC7aT+CIvKjmsF0WqyxYeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KZzWXy0bt1JsNgq/5rWUhc6vGMhkZ84NSgRbanNjJHfayQIJwbmAxwDRpBwPllscOCUlTnTyiey3hYZ1RHhPWZ6z/m5CIIpt3iJ93VbdlLfXmZUo7i09zpXGmeQ3HHdbdFcsT3ZRVT4Zaotdhkq1bOyVHsmZ9cYioLrVvEWwnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Ap73j1g; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so65818195e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767183758; x=1767788558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=REYT8YJ/dkSr2Ie21SxZFTWd8sKfplhaWYQ+TaqETKQ=;
        b=2Ap73j1gygHyUQFpr4eUUI36IwMsSDE9zD6EK+Ycrd8gnoiHVXSbKHSZIdn12ZAQsD
         B2ac01AkES2Ca0hIGBmdrvosX+t9SFzEeov/7lBFbGdX0xijRnWKUZq/4gekbe6FWkAR
         Knf7ZbS/hwJxjsCsCYheXLOS/iFkMayeDx+0e4uSlkdCV7IRAEBymrAtX2qr1EUwEpBP
         Llvwb5i49ZxRHXkjwxFQ7OdSqI2V45Fld2uK8tXKCkyMkGWXWwD1skDNZvula8/Eu7jF
         2CWlvw5V7Y3oU301orMZ9ba7DMx2zBw66OyLNMv1LUD/Mj6j7MCCAKx2aQeXa3ECom66
         jGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183758; x=1767788558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REYT8YJ/dkSr2Ie21SxZFTWd8sKfplhaWYQ+TaqETKQ=;
        b=t6xQCxUL+S1k7jk4BwnkJTh+zS3RSuDZpmaaeremUoI0K9cyck79asMiFbqWfjQ4Dy
         oUKcBQ7Nu9/KOwDl6yp+aGflbnk+RYn7TCk2LjJ7MfYYTMIayorqxgix8O75c2Zg6Wkk
         aVQX7zLBt7xR6YGxV5IFMY5JZuewABhN4ABY2O92YkxE3qT24RW4HKvhS+jjy1r7NoHX
         0WLs96jAK0cUNhAIU3pnTXZt3mzllnJqXpP5YhEZCP5JpjiUMkCrg+o1mEo3v48NHeHS
         VCmyOjYcv40EydrsliduT0RyVqiE4EJwB69IYNTs/r6sju8SQ8poO/oUBEe/jtiLPWBE
         4A9A==
X-Forwarded-Encrypted: i=1; AJvYcCWqM4PoL5aRMt9cuBkT72av8cx6K3Mbs4c7Is8uU1HitUAS4n1K6SA9E+phXFKN6FjtolunA/2rolB+fpX6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2leHcaSfmerPSaFN9qHght40ffrWSh9+wttl/gcw/bbMTnviC
	dJ+/ZvnQpqWz6aC2xuZGhsWG9tnBH7TPHTJEJg2GWf2NHRp5ZGbcTQPvjqTTAbhiIy2mHWSQJI7
	GTqq/vXOVY7vYa1DPJw==
X-Google-Smtp-Source: AGHT+IG+d3dn97mR05G1vfxtVGQCjvCQzYBGJ5XjDQkL2U/PB1Ft8yM2WWn+7k6yvU3vRGKPA72nmhH58SjTDVY=
X-Received: from wmsm38.prod.google.com ([2002:a05:600c:3b26:b0:477:a1f9:138c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:818f:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d19538725mr450831265e9.3.1767183757851;
 Wed, 31 Dec 2025 04:22:37 -0800 (PST)
Date: Wed, 31 Dec 2025 12:22:25 +0000
In-Reply-To: <20251231-rwonce-v1-0-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3744; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ho7sEa3sHiw4JAsNigwc6kC7aT+CIvKjmsF0WqyxYeE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpVRWLKHPgRt7fOS19l2MagjlWg0LGc+wVA9YRb
 5uR2DA3RfaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVUViwAKCRAEWL7uWMY5
 RhplD/91zkdMMSGPLFlUxmye1zAnivnHlCVwGrBjDg+IhGKnsT9ZSGq9/ZSv+0HBjouSoFXO/gS
 C7rCtFQgHg1EQ2RCW6jzt70ph9bv8lh3ob+cOuLf167GMhNEpDTTtbgSkqUQiidmnH4arv17iLr
 C9n72wGxhQbLJgGSouTCXPyCjUTg9Z5YSY+tT++gPbdLApvL10aoophFoOf7gEZyHnIOLPBUqxh
 QbxWhIubQMig97irk7zNGgUMvWSn0oU2+4zFhNe7MVOgQL/M3oNZ8FRqsOiRTZY/SCEGf5i2GLN
 pJTK/AarnDFWPuJsZ6UYhZeN9ZQSDkoWeZdLWOVtKrEvU11Nx5M7Ss7989CfRAeoLAUw0MrWvMQ
 zoOrU5wALF/6YNktCRdDFmpXg6nPzG1q5B1CRlzlc8sxxcjwRD/lgoLMSu6guiI5ls/AButpJiu
 sMZFGqgCtR3p4FmX2ch0ecWN/kK4lFRU/oiTY6fUwAo2EdtdN1HO8dss7HPbpSoUqCwl085YgWR
 TMq88vxxwiddr7umQrgL8YQIOeGPUkHEJCIcUZ8RZJP8cCXWi3wiTufRFv3nU8joLUfvQBXts3E
 dVkAqZ0IPWv/nX4/sjoXpJ//15qdnZOrGa/yh79ghXgdg3FNlmtFDgE0FujYtkUWSJBf17JcRYo e6fQY6LvRgmu/Aw==
X-Mailer: b4 0.14.2
Message-ID: <20251231-rwonce-v1-1-702a10b85278@google.com>
Subject: [PATCH 1/5] arch: add CONFIG_ARCH_USE_CUSTOM_READ_ONCE for arm64/alpha
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

By exposing this variable as a config option, conditional compilation in
Rust code may rely on it to determine whether it should use a volatile
read or call a C helper function to perform a READ_ONCE operation.

This config option is also added on alpha for consistency, even if Rust
does not support alpha right now.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 arch/Kconfig                    | 11 +++++++++++
 arch/alpha/Kconfig              |  1 +
 arch/alpha/include/asm/rwonce.h |  4 ++--
 arch/arm64/Kconfig              |  1 +
 arch/arm64/include/asm/rwonce.h |  4 ++--
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31220f512b16d5cfbc259935c2d3675b60c1e25c..683176bb09e50e31f398bb92678283e5de66b282 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -229,6 +229,17 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	  See Documentation/core-api/unaligned-memory-access.rst for more
 	  information on the topic of unaligned memory accesses.
 
+config ARCH_USE_CUSTOM_READ_ONCE
+	bool
+	help
+	  Some architectures reorder address-dependent volatile loads,
+	  which means that the default implementation of READ_ONCE that
+	  relies on a volatile load is not appropriate.
+
+	  This symbol should be selected by an architecture if it
+	  redefines READ_ONCE to use a different implementation than a
+	  volatile load.
+
 config ARCH_USE_BUILTIN_BSWAP
 	bool
 	help
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 80367f2cf821ceb4fc29485b7b21b37d5c310765..1d5d48153ba0087554221e9412a6af0c672d3f5c 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -11,6 +11,7 @@ config ALPHA
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_CUSTOM_READ_ONCE if SMP
 	select FORCE_PCI
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
diff --git a/arch/alpha/include/asm/rwonce.h b/arch/alpha/include/asm/rwonce.h
index 35542bcf92b3a883df353784bcb2d243475ccd91..c9f21aa0764625b24e8957923926d09a2eb97e7c 100644
--- a/arch/alpha/include/asm/rwonce.h
+++ b/arch/alpha/include/asm/rwonce.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_RWONCE_H
 #define __ASM_RWONCE_H
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_ARCH_USE_CUSTOM_READ_ONCE
 
 #include <asm/barrier.h>
 
@@ -28,7 +28,7 @@
 	(typeof(x))__x;							\
 })
 
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_ARCH_USE_CUSTOM_READ_ONCE */
 
 #include <asm-generic/rwonce.h>
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7deb07b46ab4f16a1a0e4320dfbf1..cd16053c8302479458a05c23ba9cfb73ee50232c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_CUSTOM_READ_ONCE if LTO
 	select ARCH_USE_GNU_PROPERTY
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
index 78beceec10cda47b319db29d9f79d2a5df35e92d..5da6b2d6a12399a520f7a3310014de723baa278a 100644
--- a/arch/arm64/include/asm/rwonce.h
+++ b/arch/arm64/include/asm/rwonce.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_RWONCE_H
 #define __ASM_RWONCE_H
 
-#if defined(CONFIG_LTO) && !defined(__ASSEMBLER__)
+#if defined(CONFIG_ARCH_USE_CUSTOM_READ_ONCE) && !defined(__ASSEMBLER__)
 
 #include <linux/compiler_types.h>
 #include <asm/alternative-macros.h>
@@ -62,7 +62,7 @@
 })
 
 #endif	/* !BUILD_VDSO */
-#endif	/* CONFIG_LTO && !__ASSEMBLER__ */
+#endif	/* CONFIG_ARCH_USE_CUSTOM_READ_ONCE && !__ASSEMBLER__ */
 
 #include <asm-generic/rwonce.h>
 

-- 
2.52.0.351.gbe84eed79e-goog


