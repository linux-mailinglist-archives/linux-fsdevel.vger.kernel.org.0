Return-Path: <linux-fsdevel+bounces-46822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA9A954CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84535173D08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92181EFFB1;
	Mon, 21 Apr 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKmKGS9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE71EE039;
	Mon, 21 Apr 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253768; cv=none; b=SFibYGB6GD54C6592GvwlbRtjZx8slW8g75cYWB6brvSq06E9kQsUOnNMco+INh0EkNgWXJBsS8sg0bGNNoAbHmB5eo8gW8W7BSRKtM6cr5NsnLP3CVQQxT22sNTsqDJVBp8gvjzyWwDEH7sDp70PYNsN6XVCSike18lI7kwIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253768; c=relaxed/simple;
	bh=GvXnRtT8VxgnibDq9zxBs4/gUfJm1ape9XUvKM0P9wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdpZV1pBtpF7hk5hbRTuncOHrtoxTqbz+rYeoP01siEKTqPcKpD/YbyIx04YergYkueSNCXy9U+uiT6d845c4qQvt8M3C4+kxsJ2ayolI4LbUOtrL/YSz/a5VR4czOgum39Q6HcilBdGhV6r7PcHoxRmYr1N/G+bipTp0lUVKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKmKGS9t; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5b2472969so448789785a.1;
        Mon, 21 Apr 2025 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253764; x=1745858564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FQdpd+pohHuwKd+PplgPe0guKqarlBZhgyvqtWw2lTY=;
        b=QKmKGS9tEAEWruw0n30UWqRAzWdMSXmyquvz/ssnyhEPKfqgDcnNYCFOJslYCcSM34
         FBsCTMRy9cR1VmYTvpC2hljd9TYrtZCcENtT0aMrIcoKT2LEieoy7xtoRkiL/dTBny8x
         MAu8TXod1xiYdPsj9K71Fh1vVNtls27kRnsn82ZXXDyCib3aYsTW2c9XBGrBAKS2YvkB
         KjvrjWhEgiCb9OVdYc+COedJychS33g2dwVSCdWGq1xk3ky4FqlzuH51NBL/c1jmGgQD
         RHCuxapV6PRz7Vdi7rytATuTSEx9t7TuBtwA4MiykUNXAKA+K0z43jE9I+rDJSAzNotx
         ur6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253764; x=1745858564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQdpd+pohHuwKd+PplgPe0guKqarlBZhgyvqtWw2lTY=;
        b=KrMZUeUBoS7bgAo8/ztK2012x0ER7xkzuZuYzPuePx8jByOov2mLCinUTqYMRBJqTf
         7fPb1Y+ddizsP/gM+0IeZtLpocwRRfTKZcZxK9NpotBpJA8vV4X+3aVhChzB6FEV5B64
         6ht6zxTpu0fyfSOR7bX/zCOMRi7WzuNSTg1mo0MNl7kkazRtfnK1Fd+G3ub0G70eJ+tT
         2rA7ly/NbjdL7vafJ7YaqY9xW9Ug3Se7SCL50ww2siL9e+NcRMw4JLXkdKjTm7e7CU5I
         aDbwRi3JESc9LoMOMPnEp/B7aqKfIW0eLAoAJVZUW7DGaVYyEvxjwRK3CcxOHrwAO4jE
         Zjpw==
X-Forwarded-Encrypted: i=1; AJvYcCVOFDX5Hfr1Dllvh4/BM4W3hAJR0fex5c75yv6GaftLY0PTRb9BCL+Z3T8Z2+jCnNnt5eX/lGu0HrJKHNdVJA==@vger.kernel.org, AJvYcCVlngTIqO3/VwondK3fB9B5VmXhWDd3AdHulhuCddaK6oUp2XvKNiRna/Dl4UL5S25z1AhVTNnKc8NEYhWu@vger.kernel.org, AJvYcCWSyB93UQua/TQQ6xusgYWuSz9iL8IGHSyCM4pm5Vy0MFcGO+ZC5xPPAZ2LJ3ig4OTlxkGS0jlGyTKr@vger.kernel.org, AJvYcCXkvTQfauvJDyYn9Yo96iiTcmZvDL4PFP0M3L/zgtmtD9SrU216wLH5yPWfV+mCTcKI7HWM@vger.kernel.org
X-Gm-Message-State: AOJu0YwudLzDZ7BRQhNFfZ0M+hJsv1dbOCLUl5IojOfaTt6ciejIPjoJ
	qlLMop8M4OhDiP4YMCuTTAMA564Om+ZvTre1ZBq9eIXT9QchjbsB8J03FQ==
X-Gm-Gg: ASbGncsKwbVjdQx6UgohSSHbS83/4KX/E8AJCJgZw+f+hwMRgUdm4iJbUJf07Y5IoAe
	PMtDpF45Xkj9P3XsulMNDlrVIR8WSzJWPP+/MxLNWNMSlEqDQe4oMU7mrvs04CDO9Jp+UAMNKIG
	/VYsl4yXYsRUUfQ0p9jE2sOjF0p1QT6G90bPGdZENu9a67rOEudncBtc2WLDC5fyTg/UGOTR19g
	TNzgXgLhTY9tGfTjRbnsw3TMi6NkyLfs0gR7OqO3hTUykhIADg5ZuPDioBP2PmQ0KW/RxQs6fHp
	P5NioezXw0jjiUcvBe08EgjPxvqX48dWIElr7vSimfFsCIhrnmBc0tNz0yVwXUdUer5p9lLtHxo
	PB4fK9As5uf0Diy9xVz7huJMap23o6uQ=
X-Google-Smtp-Source: AGHT+IFv5kjUwR8/Y/tKuGxoZhXCxprxqNdVpCUQI6JryRHBrh3wOBVwtOy29Ja/DVq5OiiHaEY7+g==
X-Received: by 2002:a05:620a:4510:b0:7c5:6ba5:dd65 with SMTP id af79cd13be357-7c9280779bcmr2259957585a.55.1745253764552;
        Mon, 21 Apr 2025 09:42:44 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b325a4sm45802916d6.60.2025.04.21.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:44 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D19181200043;
	Mon, 21 Apr 2025 12:42:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 12:42:43 -0400
X-ME-Sender: <xms:g3UGaDqM-oRY72VYfjjMMPWBvD260B0kTEAsydJZkF4gN068ia1SFw>
    <xme:g3UGaNrsF5Ku86dctP77P9l30AlPIBsgRI8mheoJ1zwGoh1aEhvWqRbi01tZqtDqV
    w-lrLPLVxP1XWVb7g>
X-ME-Received: <xmr:g3UGaAMNVA8SJrYRDpHMhbtIliU3S27SHm1GKUj-cWhLjgzbQf_Mn0IK7CxF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpeehnecurfgrrh
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
X-ME-Proxy: <xmx:g3UGaG6oIejwUk9ROXZAi4AfIt86GNmDOQtx95SfmZVDVwnImBiYnw>
    <xmx:g3UGaC5PU_lidQwNoZHsPp0xYqmuTX4yzf9_8XjK0nKJ0BJHzgnGgw>
    <xmx:g3UGaOim6mTR3MiQ5pi4rJo98ItyYarif3n-MV2yevViPc9uX9wO5A>
    <xmx:g3UGaE4SW0qcatBPuakGjhChYJB0n5Lj_GIF-9KAOwr7heV_-atzVg>
    <xmx:g3UGaBKs0Qe-XZ3HmeRKLnaez0zEWFmBrXeDFaK7kh5arXwITaODOVeO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:43 -0400 (EDT)
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
Subject: [RFC v3 08/12] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Mon, 21 Apr 2025 09:42:17 -0700
Message-ID: <20250421164221.1121805-9-boqun.feng@gmail.com>
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

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessarity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index d197b476e3bc..6008d65594a2 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -102,3 +102,74 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
         d as _
     }
 }
+
+// SAFETY: `usize` has the same size and the alignment as `i64` for 64bit and the same as `i32` for
+// 32bit.
+unsafe impl generic::AllowAtomic for usize {
+    #[cfg(CONFIG_64BIT)]
+    type Repr = i64;
+    #[cfg(not(CONFIG_64BIT))]
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
+/// let x = Atomic::new(42usize);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for usize {
+    type Delta = usize;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
+
+// SAFETY: `isize` has the same size and the alignment as `i64` for 64bit and the same as `i32` for
+// 32bit.
+unsafe impl generic::AllowAtomic for isize {
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
+/// let x = Atomic::new(42isize);
+///
+/// assert_eq!(42, x.fetch_add(12, Full));
+/// assert_eq!(54, x.load(Relaxed));
+///
+/// x.add(13, Relaxed);
+///
+/// assert_eq!(67, x.load(Relaxed));
+/// ```
+impl generic::AllowAtomicArithmetic for isize {
+    type Delta = isize;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
-- 
2.47.1


