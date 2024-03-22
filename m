Return-Path: <linux-fsdevel+bounces-15138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1E8875D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203C61C22EF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D6584FD7;
	Fri, 22 Mar 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDMwLfMX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA396839FE;
	Fri, 22 Mar 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150755; cv=none; b=kf4p56SC2vDfAXSMZtTj7YDWxpRp8sLiUyUjz16kVNinKWsqJ6gDsAoiU2HGH/xfF5aD7dbQR3SDY1h62YEockHseXRaXBSa2qN70w57M3PCWow+2WFwenbjjq3mHGY9BY/qs3LP7PMnAD/vgYSV2ELxuqC2j8oQp67ohSnYrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150755; c=relaxed/simple;
	bh=qQ5oagRUQmpb8GABKAqxfq/Tg/yBhJf6ca7+7tUxq/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQhKln5RHcYqZp/e9XQbLsUEwsF/wB7islcXZmlVYgDWejEf8yWR8tt47p2jD01umcUUBwZxf5tR0Ky5myC4Wp3k7RnY4rwElOaolcSrNOLznjN2H1d/+Bv49LGIUV6qIU6Pq7eu5fZm3nsJYwM2/f/k8lO/6cCrWn6UkEAwV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDMwLfMX; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d453ae6af5so1246455e0c.2;
        Fri, 22 Mar 2024 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711150753; x=1711755553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZ2rrwnnSPuoyWFM6/wbqSx+XEHGNK8//eAAMbn2SLU=;
        b=dDMwLfMXrAIntfyxsD7U/i+CyLeVvop5HCkJUXDxZ3E5Ox4MA2QEwrfgbc3hOnaRQ0
         8P0NDpDw3HNqDhsCLGLqoemApY2JZ5SkKujRkkNtQYGdbXi2EDoqpz8XqH6vu66H3VXq
         S/AN1WUsXKkmeupMb34U2zafIg0KFtox6/XDck1h7smrwW8m6hty48gwJJb0Jli9PeB7
         cXhIfkeGM6wh1CCk8VfMQcJ991+RSPDSDGvAYHg6FMhfnacQ/5Ni4QLBoeb24gTEp5wt
         +8nKdEBtEQEQTQ3OUNiN+gv5GEzML0GDpaOH6wpJ9OMLtKugkQOkixyT8xxpS7S6w27u
         Okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150753; x=1711755553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZ2rrwnnSPuoyWFM6/wbqSx+XEHGNK8//eAAMbn2SLU=;
        b=JNSsPCtmJHpsVFsB4T2qqgIICax3EvoqFll/5Pa8jGhDc3z4tVuItZKm+VS4R81gqd
         zY86LvZiimkjsouOCALItWaqGwVwodSY2x6+43vqPFoNjKntjPVuOyG0omCnbIMhU8cW
         wdXZfQo9dB1HNZHzogZv3fzaBlgtSQXz7D3J4n3Be79EtE/M0DI7c7xPu4Jy722RWxVW
         lpO8oaiVvpv8emYQ/fEGmbqcDCertCU00gPKiO0lE50Z90azATaO3kNH6f4pI6U+8eLH
         l4JiwlLBKE0UjeikgQKy7AVN7GJ2uSzIUMp3PE2FvJ6I2pIqyV4Rfx5Jafy7mePJ6oCz
         j1EA==
X-Forwarded-Encrypted: i=1; AJvYcCX0jY7H+lU535PTaP5PORM00USAbDk30DNgMhZ+ij6UMdRglItTr2FZHqt68qWe+541Lw5aj5c7zZKu7DJdU1jA/R+vOA5gkhwpdcJpYsYtORDuHCkmunC+ecJ1kHu23BQhvMqZ5dp0CdkbSJMtcDEobp8Vk/4qSX9Jx0IO9nBtT0Lj++3606A=
X-Gm-Message-State: AOJu0Yz6CI/ekBopSa/bV0wb4BjPaHfITxfZ8mfcSxTOfjTU1CatVxQS
	bevk+peHQuMKN4q4AAc/6PAMBBCdMdptjyPZ+4i+K2qb9Ba4HX8S
X-Google-Smtp-Source: AGHT+IEaYQaJaeCZmztaSPVyvy8V/Vxeh4oBqEj4kwmvUweyQop95DXCqfqCPm+ZQJ2lS/7MtVUgAg==
X-Received: by 2002:a05:6122:c9f:b0:4cb:fc25:7caa with SMTP id ba31-20020a0561220c9f00b004cbfc257caamr1351039vkb.14.1711150752858;
        Fri, 22 Mar 2024 16:39:12 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id dd7-20020ad45807000000b0069675909982sm456994qvb.70.2024.03.22.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:39:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 98CB91200032;
	Fri, 22 Mar 2024 19:39:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Mar 2024 19:39:11 -0400
X-ME-Sender: <xms:nxb-ZXIx1aaow52e_WoDZFqnahY1bIzzv5Wxu7y5Bx3FCqaoacZKaw>
    <xme:nxb-ZbKVQEyiu5t7Xp4_oUUScOcKEYzNSWnVzrOr-P_XBPKxvfNR9gvy-y3qaTfgd
    B88TMJzA-sHCJuMcg>
X-ME-Received: <xmr:nxb-ZfsAdtEQ6wxjKWrjG-mmoZH0kN4C1sOqF3vapgci3LBivqDLSJscBpEfvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:nxb-ZQZZZwqym68B78NpzEjDSIBXxqsT776nMUbyvIA4DeAUsNkvmA>
    <xmx:nxb-ZeYPyMmA5Ie9kuz4ke_eNCTGF5Hy17FOBYmquZHMlJ3KUlIaVw>
    <xmx:nxb-ZUAFZkXd54Zn9rr1tBaLwxLqHc0ZCPVMAyTQnanW_yNTyHsHwQ>
    <xmx:nxb-ZcZNxf4TI3OmNTLXqYypNReK-w3xMoiOqTqRfhqRIPvgjUNKZA>
    <xmx:nxb-ZeaMRH_yJkm0MFOiCC5_cBsqDl8eAbpKk1x-uyep6Kc4A-NFFUh1PGAvdpkV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 19:39:10 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
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
	linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org
Subject: [WIP 3/3] rust: atomic: Add fetch_sub_release()
Date: Fri, 22 Mar 2024 16:38:38 -0700
Message-ID: <20240322233838.868874-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322233838.868874-1-boqun.feng@gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs            | 23 +++++++++++++++++++++++
 rust/kernel/sync/atomic/arch/arm64.rs | 20 ++++++++++++++++++++
 rust/kernel/sync/atomic/arch/x86.rs   |  5 +++++
 3 files changed, 48 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 280040705fb0..c3cae0d25e88 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -39,4 +39,27 @@ pub fn new(v: i32) -> Self {
     pub fn fetch_add_relaxed(&self, i: i32) -> i32 {
         arch::i32_fetch_add_relaxed(&self.0, i)
     }
+
+    /// Subs `i` to the atomic variable with RELEASE ordering.
+    ///
+    /// Returns the old value before the sub.
+    ///
+    /// # Example
+    ///
+    /// ```rust
+    /// use kernel::sync::atomic::AtomicI32;
+    ///
+    /// let a = AtomicI32::new(1);
+    /// let b = a.fetch_sub_release(1);
+    /// let c = a.fetch_sub_release(2);
+    /// let d = a.fetch_sub_release(3);
+    /// let e = a.fetch_sub_release(core::i32::MIN);
+    ///
+    /// assert_eq!(b, 1);
+    /// assert_eq!(c, 0);
+    /// assert_eq!(d, -2);
+    /// ```
+    pub fn fetch_sub_release(&self, i: i32) -> i32 {
+        arch::i32_fetch_sub_release(&self.0, i)
+    }
 }
diff --git a/rust/kernel/sync/atomic/arch/arm64.rs b/rust/kernel/sync/atomic/arch/arm64.rs
index 438f37cf7df6..beea77ecdb20 100644
--- a/rust/kernel/sync/atomic/arch/arm64.rs
+++ b/rust/kernel/sync/atomic/arch/arm64.rs
@@ -24,3 +24,23 @@ pub(crate) fn i32_fetch_add_relaxed(v: &UnsafeCell<i32>, i: i32) -> i32 {
 
     result
 }
+
+pub(crate) fn i32_fetch_sub_release(v: &UnsafeCell<i32>, i: i32) -> i32 {
+    let mut result;
+    unsafe {
+        asm!(
+            "prfm    pstl1strm, [{v}]",
+            "1: ldxr {result:w}, [{v}]",
+            "sub {val:w}, {result:w}, {i:w}",
+            "stlxr {tmp:w}, {val:w}, [{v}]",
+            "cbnz {tmp:w}, 1b",
+            result = out(reg) result,
+            tmp = out(reg) _,
+            val = out(reg) _,
+            v = in(reg) v.get(),
+            i = in(reg) i,
+        )
+    }
+
+    result
+}
diff --git a/rust/kernel/sync/atomic/arch/x86.rs b/rust/kernel/sync/atomic/arch/x86.rs
index 2d715f740b22..7f764cde4576 100644
--- a/rust/kernel/sync/atomic/arch/x86.rs
+++ b/rust/kernel/sync/atomic/arch/x86.rs
@@ -41,3 +41,8 @@ pub(crate) fn i32_fetch_add_relaxed(v: &UnsafeCell<i32>, i: i32) -> i32 {
     // SAFETY: `v.get()` points to a valid `i32`.
     unsafe { i32_xadd(v.get(), i) }
 }
+
+pub(crate) fn i32_fetch_sub_release(v: &UnsafeCell<i32>, i: i32) -> i32 {
+    // SAFETY: `v.get()` points to a valid `i32`.
+    unsafe { i32_xadd(v.get(), i.wrapping_neg()) }
+}
-- 
2.44.0


