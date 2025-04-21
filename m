Return-Path: <linux-fsdevel+bounces-46824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3BA954D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69653ACAA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C173B1F12F4;
	Mon, 21 Apr 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9WDzMWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A91F03C9;
	Mon, 21 Apr 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253771; cv=none; b=aJF1sPNVkZGGYJ4HIwv7qbtaT+jb/5rtXkQudmhiVV1IDLXiiCQWuML1L4ZQTWjVW9j9oO8zo2ufH4aeg9JCQVS/4zaqpGr6yQXjzj6bz+y+wOXEXQd7cJ50nsUE2UzcSBDZrD9pzmVUYZVyKqwqmaW3kCon7E8k331g/iQZ29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253771; c=relaxed/simple;
	bh=ir9Jiu1Y1J4FXKxDOougVPhBcRyH5oNJ6vvblr33dic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTc+uRGUke53BjX8JxFriD2GxIpPjJWm0du4qmks/D6amqinU3GIOXBK9nwa6mLzw7bsLsAShwJ2N4T4kPE0D4YqRBUfNAw+BYVaU6NklkKYcv52X7lYTDvyziXOYaq9k5LrFwp//5d/OYFsuziuQPmqmiwXpEoXfIMjR33yMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9WDzMWD; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6eeb7589db4so47912336d6.1;
        Mon, 21 Apr 2025 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253768; x=1745858568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uMU54tdag8mXyAmWP+eFJWJLUiSas5VBnDSB0h2I5Ow=;
        b=T9WDzMWDeaUkn5VzGRPeLGJccyBtu5/vxujaB9Ma6CyYMg4mw2sYIVJXvLUDOYax/E
         j4Tmxsr6m4G0E0shr5BC9FzdFxhQNI7bmMuuet9/w2EWXDBPIP8WgOfbpHhvDX9LuDWQ
         mAFuZC/5DNyWqNFZjkbOAQI6x0JRCvLzqkKQ47WqDHWiGxI0pd0Qqy1ZGyLgTSWBSe9P
         GMyTcrmrzbrSAufx2bjstWM/J92haiEi2KevzWiPQkumHOA925puCcOs2dRboWeAOkWn
         xqpXEVu39YIY9jrO/VAnVnAb43zKOLj7t/cteSJDA4nDS/YCy7w0IjGb+2ZVCJJkxmBD
         WdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253768; x=1745858568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMU54tdag8mXyAmWP+eFJWJLUiSas5VBnDSB0h2I5Ow=;
        b=haN8nbAETR+GBxO52LYPXQWVNWYhGQ0gbkVzqy3v4v9G4d/Jz7perN3evCfYWQ8jJV
         BTDD3P3Tz3WmOP0oDbbLw5ILZkfw3zsePpsR1tif9kOHmjyYJMVNcjNJB3J/+opkaCms
         mkh3sb/aSQFqqCnfIAwCs6IXP7vWyIYCovDNRqn/KHucSGfZYKkR2kMsF3rV8SeRypir
         pqgcuUyj6aGRs0LY1N7d3tJDlwOAoyOagbmJXt8h0Zwnb09UW0zw/CRNM0ofEpd2DCHq
         G7B22iIQtEbz3kehzmoLin1fDHuAEgKpwgTIcLOIpa1loRFUGF8CrodiJMvataVLeKJZ
         vPnA==
X-Forwarded-Encrypted: i=1; AJvYcCUJG+ySefSiOG0CF5yFXfBU9J7g6hF+c3pJpkri16d2OvUIjYF/6zJgBfQ/vYWqciFEUquffvYgLX9CaUb4@vger.kernel.org, AJvYcCUiJS0LblW/RgkabqtRis9hCVgQPvflpEno9xsEIIl3+dzBjVszfoSOHL5Al8qX0j1hCdkUs9YN5+2aCdHQ9A==@vger.kernel.org, AJvYcCVtxopTXpdlt+kqtT0gxXD5DdPz1juMeJWng3NWrTISkczJ22Rl0sGZYQecm+AK194qOjLUSUc1N3bH@vger.kernel.org, AJvYcCWMFGI6Wf6PEoi21pGmvAFBvc0hZ1NHoT71b1cteaXWnFjLFLXh0lBwKPrcCZTVUBAiiYJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEYdKhoiAnX5oqdKRTyEd3SUutWQOz7Ox4V4PslGQB34Ju43a
	86HbrXx7Te4d/2lMrJw/sR9TTlTML8rqe9eCRzPBbKq45qw4BFmZ3UtOzQ==
X-Gm-Gg: ASbGncut4q+fhstzwaLxS3skwM5v8suVj9k201kt7itPzCB4tVH3bIFWbRXE2LTzJW5
	vWceS15KFINJDe5wrEt3jQHpAPdMSBO0SnAmFLDC9wDA1dJMCr4+mt+INCjP25Fw1TFBwlEgPxs
	XiYwrGKpjEn4CSnqyRdby7sr9ZXeSb1u/K28bceN+b/oZwNVclLVSKppZ7HVmUg+2cnA8L5D/5c
	17CzCTCusZ9jaS7Guu3XPLuxR95AKYTtdDAFjXPT3NhoPAkUiB6Ru0BDAsh5nfi85I96JpQGgtM
	kWtL9buVrtnuxnF2tGe18j3en2qgOQh9o6vYaOIGkb5OEANCyLaqMgcxs2aBpNDqBpIgqqhCvpA
	NIYAXwi8bO6qDn+3gsQqCvUekNbpJc5p02L6jDpd7aw==
X-Google-Smtp-Source: AGHT+IGU0JcGAhVuULdUx6Z4ZKxYf32ZP2BkzbnQ+QciqlajuN2LNG68/aiDW+Pw4v75CJt6Z5kDGA==
X-Received: by 2002:ad4:5b83:0:b0:6ed:122c:7da7 with SMTP id 6a1803df08f44-6f2c4509511mr225275636d6.5.1745253767862;
        Mon, 21 Apr 2025 09:42:47 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0cb51sm45755526d6.31.2025.04.21.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:47 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25E5B1200043;
	Mon, 21 Apr 2025 12:42:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Apr 2025 12:42:47 -0400
X-ME-Sender: <xms:h3UGaG57po1eR2F88GMjW0h-xR6XvIjMQuOmAFfAEw5EzHKzOqLq5g>
    <xme:h3UGaP59JVjNaOOAy-__KTOM8TZbBUJPsHXOmFp3On8lbzbdAdHU8vJud9YAmz9OC
    1Rv-B_OQCRtH1s-Cw>
X-ME-Received: <xmr:h3UGaFcxsZjJKvlIY6eTduyY2xePqb-oBqcx10y-VQ46DbKofgllEsYOdSUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefg
    veffieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
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
X-ME-Proxy: <xmx:h3UGaDKY3WhiLISzt8hpltmCqfJP5nrXVAkhh2O73Q7gW6cYSP8-5g>
    <xmx:h3UGaKJ9cqOrAZxyZVAPaDk5qrig4s8HEy0K2sz6tTpa0e4STiTPRA>
    <xmx:h3UGaEym3UKQtrVgcltD72BrgyPmmACBNsNZvEkPs0Y4pip0l0wqcQ>
    <xmx:h3UGaOKndUSoX8-vyscSMxNQvUOFsTXAHWfAHtCOXHfAkMrXkgascA>
    <xmx:h3UGaBZU9qNnDGOytmIDNypnA9r5h9ag_5ZvvdpIm7O75-L-X3h3K8jv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:46 -0400 (EDT)
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
Subject: [RFC v3 10/12] rust: sync: atomic: Add arithmetic ops for Atomic<*mut T>
Date: Mon, 21 Apr 2025 09:42:19 -0700
Message-ID: <20250421164221.1121805-11-boqun.feng@gmail.com>
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

(This is more an RFC)

Add arithmetic operations support for `Atomic<*mut T>`. Currently the
semantics of arithmetic atomic operation is the same as pointer
arithmetic, that is, e.g. `Atomic<*mut u64>::add(1)` is adding 8
(`size_of::<u64>`) to the pointer value.

In Rust std library, there are two sets of pointer arithmetic for
`AtomicPtr`:

* ptr_add() and ptr_sub(), which is the same as Atomic<*mut T>::add(),
  pointer arithmetic.

* byte_add() and byte_sub(), which use the input as byte offset to
  change the pointer value, e.g. byte_add(1) means adding 1 to the
  pointer value.

We can either take the approach in the current patch and add byte_add()
later on if needed, or start with ptr_add() and byte_add() naming.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index ffec46e50a06..f2dd72c531fd 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -197,3 +197,32 @@ fn from_repr(repr: Self::Repr) -> Self {
         repr as _
     }
 }
+
+/// ```rust
+/// use kernel::sync::atomic::{Atomic, Relaxed};
+///
+/// let s: &mut [i32] = &mut [1, 3, 2, 4];
+///
+/// let x = Atomic::new(s.as_mut_ptr());
+///
+/// x.add(1, Relaxed);
+///
+/// let ptr = x.fetch_add(1, Relaxed); // points to the 2nd element.
+/// let ptr2 = x.load(Relaxed); // points to the 3rd element.
+///
+/// // SAFETY: `ptr` and `ptr2` are valid pointers to the 2nd and 3rd elements of `s` with writing
+/// // provenance, and no other thread is accessing these elements.
+/// unsafe { core::ptr::swap(ptr, ptr2); }
+///
+/// assert_eq!(s, &mut [1, 2, 3, 4]);
+/// ```
+impl<T> generic::AllowAtomicArithmetic for *mut T {
+    type Delta = isize;
+
+    /// The behavior of arithmetic operations
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        // Since atomic arithmetic operations are wrapping, so a wrapping_mul() here suffices even
+        // if overflow may happen.
+        d.wrapping_mul(core::mem::size_of::<T>() as _) as _
+    }
+}
-- 
2.47.1


