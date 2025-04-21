Return-Path: <linux-fsdevel+bounces-46821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC925A954C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A935D174196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C921EF37A;
	Mon, 21 Apr 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDoOorjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944ED1EA7C8;
	Mon, 21 Apr 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253766; cv=none; b=lhAUmpdEO10jz2u8PjDRtL8vttbQTKHFe2qeVJuUDTaPjFq/zUn5Dx7VJedBODhtT5dUm1RyQ9R9+bWRPcWed2c1sa9oZj3wzCypf1nHzEBODuv6OIh1ordrUBzZQ5jX7F4ZP271izTMSI7OPnlLCLZ3/j9M119T9qgPMoLXGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253766; c=relaxed/simple;
	bh=T6fn+IIXOWZFbnRBBLRrM7viHHO9sGEOT6hWF8K4jvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1NCOWnh5qiQZvIWj3yKq8l8vL9MCFZdlrmQRxQzjT3LJprvGz0RJ7dyWFRmumCaK0zOMdWV0LAtZjffLVCC4DMXMjYFuvOv4Zb1gCNT8pTcv1yAuf3Qv7XfPjjoFEghjU8iitnnH557K58xLAv2dBveTXLPE9PJQEZTS7cqTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDoOorjt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e900a7ce55so67697576d6.3;
        Mon, 21 Apr 2025 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253763; x=1745858563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2I8XAztJEZn+vwuO6dwvyeow7+5UV1o92z9+NI6bSFY=;
        b=gDoOorjth15rCaN4PEozAEGFpy0X5L6FrttWakBOh1XlOMH7YSEUz7OnTUhCoM60wG
         Dsaoeu/XVIGPMyPQNdsPuWrulkh4/MCLcv3AZPjDWQrlfo6xw6+scz07HLO+crd+8yRg
         sWXApRvOkA+uEWROMwFMWVyNylHZI1Ce+KVSN4IKCqcCEJjDxDTVukqM2ziNmdbuFtEx
         1V+0kDTTfULVctNEtUjZksZJrezW7EbPUj7g/lUg/JhCWbHYmYT6yDc2eKdLKBT6q0Az
         3uygRg1zQHpYla/KzUCTfdrcrTZVG6yrm7Ecb9Dfu8q00aLzOpnfyz4qg2nA92FwXl1y
         C8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253763; x=1745858563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2I8XAztJEZn+vwuO6dwvyeow7+5UV1o92z9+NI6bSFY=;
        b=XpfHXXH8m0lm7QJ7db+kDMJ3aAcrZKQQpkjaGn2jqhSmG+eWgIFvn/ZneInG3LTe9D
         jIC/w20bUi1NfuDRAIsI3YKdg25eYGlJsQSfSOxYY4a7QsxFU8w4Pt5qbw7ebD/p5o8k
         vUzw/F6oyq/GZaXV6WYZzx0m3MZ5ZPI0HWxzjfYBBC3Qq9lvr3EsDXwdvQToOVWyM1A/
         j/o3B/qKUbiCi4T+l5nGqxFb8I7gOuwVmpSDKz0XMtB5BhYP12cbn00ZeRhMpmFJ9KnC
         dCvE9kN9CawBkEoi+RWL8MQnOJgBfxCjARqlZA6i43DfBlTMqyQPylB6ZBJfKVNWnWwR
         B1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUNuHV+2xS6lcxEiOvJR/5ZiulgkZRK1jEDWSsK7VGijnLGhmCthbNBNlmVhavZnyeZlh1N@vger.kernel.org, AJvYcCV4TnWBIGYNSXHQ5N1c1SVbvmI99+QxtnsNObvS7vlWDYLSksjBcE6O8IEFAY2QHc5kfX/4fxEhKP2t81+l/Q==@vger.kernel.org, AJvYcCVXGhc6sH3VS85ab4XROyIC3gJSK1ZZme4nrEsuFuLnZbXRrsjVepYUWBgQFMGR2d9wklwohUd4f48Z@vger.kernel.org, AJvYcCVj5BYbij8fqgrhx7E9qNwxl8zKGnIj1hH54j2nUb4WDfZY5Zl9NdINdiuLu/KD+ew6dEvhEiC9x5cpRO9v@vger.kernel.org
X-Gm-Message-State: AOJu0YzyH2nWUsqlLZxG0Rp23iQ6UJEryXzK4B8rZPeHVQOdhDrhMDIl
	LPbwtd+KTNP/66fLLdJXxokExQ9W2OflXxXaKcPlJeND4jeMaCIFhxF3TA==
X-Gm-Gg: ASbGncspJLrEKHW7OVaYzAH4AQvGtYDXDKGFUxUYL9xfZXdbIUpWZ7gl0xrOK1TN7hj
	5wTHVOuOCz729v5CaZTIHHDsmQC5Xqw4n/b91eiiCZ1lBB4WbsTJtQA/JJoLZldXsi+zOdgjR48
	XaN0+Z9rZSHZpmbHrHKbx1ljBJBqcUrQyJxDia4Z1FpLGuDJljiv+nUaDkjKExBr5kM4srmE+RR
	TkatDxdwWDpthef0+InQ4a+t3g9SS6F4LnJtyn1uz8VPjovnVlWRxErVUcxj1tK/hPOOx4p/BtV
	SAbNGM/nFY4laWGgFaWOlwhX+kRHD+pXljGCSaikCpkg1JYr6xW0BjVK3OyYJD62jfZd+lmE/N3
	SIIh1c2pmYtH+BCbZHSzebfNy613DyFQ=
X-Google-Smtp-Source: AGHT+IGvM5MicIi76VA584PiH6Y2GFv2NRK24khwnxOuU4C7WmvwllySnRg7t29WaLINEvuwTGyqKA==
X-Received: by 2002:ad4:4ea7:0:b0:6e6:6c18:3ab7 with SMTP id 6a1803df08f44-6f2c45b6bc5mr215702126d6.27.1745253763090;
        Mon, 21 Apr 2025 09:42:43 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfd5e4sm45385466d6.74.2025.04.21.09.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:42 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 504631200066;
	Mon, 21 Apr 2025 12:42:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 12:42:42 -0400
X-ME-Sender: <xms:gnUGaH2s-0N1_cS70v5IhHVJTw7PJUZBjRYITApQbHzUDi-crzM3cA>
    <xme:gnUGaGHbUsAUlFpu8ky0_NMJHtbvEWFGIor_iv_8K9UE6kz72lo6LmkRqOSiyFU47
    c4J7kPDeQG1ivT6Ug>
X-ME-Received: <xmr:gnUGaH7mLKey1kd1QVA2JL0Bi-4nvDOBiLw5FOmK1Pk0l67zlovjAZToRsJi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpeefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:gnUGaM3DPoqdouy69KxmnQ3YF2i7VYwe0K0m_DYo7qDq80U_zmliAg>
    <xmx:gnUGaKFQ48PVzlYFvrkZWY5t4EOFmz1dgv5UdBGxAaIL5ntshUt0hw>
    <xmx:gnUGaN-WjBXSOBMKw7brrtnQgUxKSi5i1QWGzAEAHlsu8BKVugAd2Q>
    <xmx:gnUGaHkommaXzJJH-EScrY2Sb9BDOBp64rRMxz-3elc4ZleW7HSxIQ>
    <xmx:gnUGaGG-PHY8ZSs9qHKXy0dG6ul3m-5avOINGkSuqe5DXSu70cs3sjWV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:41 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	lkmm@lists.linux.dev
Cc: Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,	elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
	Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [RFC v3 07/12] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Mon, 21 Apr 2025 09:42:16 -0700
Message-ID: <20250421164221.1121805-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250421164221.1121805-1-boqun.feng@gmail.com>
References: <20250421164221.1121805-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index a01e44eec380..d197b476e3bc 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -22,3 +22,83 @@
 
 pub use generic::Atomic;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Relaxed};
+///
+/// let x = Atomic::new(42u64);
+///
+/// assert_eq!(42, x.load(Relaxed));
+/// ```
+// SAFETY: `u64` and `i64` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u64 {
+    type Repr = i64;
+
+    fn into_repr(self) -> Self::Repr {
+        self as _
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as _
+    }
+}
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+///
+/// let x = Atomic::new(42u64);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for u64 {
+    type Delta = u64;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Relaxed};
+///
+/// let x = Atomic::new(42u32);
+///
+/// assert_eq!(42, x.load(Relaxed));
+/// ```
+// SAFETY: `u32` and `i32` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u32 {
+    type Repr = i32;
+
+    fn into_repr(self) -> Self::Repr {
+        self as _
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as _
+    }
+}
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Full, Relaxed};
+///
+/// let x = Atomic::new(42u32);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for u32 {
+    type Delta = u32;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
-- 
2.47.1


