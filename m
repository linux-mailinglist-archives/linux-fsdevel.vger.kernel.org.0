Return-Path: <linux-fsdevel+bounces-33410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3B9B8AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0D281348
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA3B146A7A;
	Fri,  1 Nov 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnDAwJp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E1380;
	Fri,  1 Nov 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441036; cv=none; b=jQSeiA4ZwZqcM9VTGTtI++ZvUQDU8TxHvq6YtLjmqSlrPUmNR5Ac39J7dYi7/s4OXYKWrXhUoQ04TRjJmI3YGVbaQNBe3AP6v2KRySH4xtjmNWaCZYo1nhr6YWkdLX7RVOl0yZX8Zj3t488BNcilTWuyNGgOICCmBVf83lw5VSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441036; c=relaxed/simple;
	bh=w4U7eyn5TzHvTCGOpY/GYCJLAOOa7mB/OK5nM83Wc7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPC1wOJdTyUCN62YvHc0DnQwVf6HdjyjXtdrUoW4M40F0/7QIbT5FNEsnXCzJsERzHvJJFX01OYieBWWAD8Beg5qrz/Ak/C36CotAKtmocika1oFi31YLRsSFy8rFPKtce3LaZmUDkfit6YLG/ejMV8hRxhhHU/yzeHd/mORR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnDAwJp6; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-512259c860eso210859e0c.2;
        Thu, 31 Oct 2024 23:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730441033; x=1731045833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+2bTlN8noZ5lv/9FDkrA2vDRY8BOyZCwzPzl7RAkqKk=;
        b=BnDAwJp6o1Gy3/994d9iUod452uYqWqeKx3fEv5xbjkSHg0wazFNJW742ii/zZNu8F
         JQj+M+9eVj3kWN9Hu2po1khAvkDcmegFg3ui3XT75e9e01rSOWGGtrm13AO2F+NkUAwJ
         twPVquXI2Q1tt3fdDw1gzTYHUHgr58NbFsXJpOtrAwi+ktg+I/ZU2nqHIz3/PNNN8AjO
         T0wRgEs02zr/RqiL9qd34BSrLfuIR5jQH0U33dkWPgwlwVA8cRy31UYifMgvcpVZDO5b
         Pyc9GPe2bpfKYoyMSXPaWc8rqICCqEm3n9aW+M2rObZ+bd7aatScC26e32lRHoJ8EbdK
         MhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730441033; x=1731045833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2bTlN8noZ5lv/9FDkrA2vDRY8BOyZCwzPzl7RAkqKk=;
        b=gkQDz/pbXg1ukQRBrKILi1xB7pg5CcFIYAo+q/TuENq5vtcqD/d0S+4/2CFDl/ZVWo
         m5SZWBmvhA6z/4fp+AwG9AexkJ2wPIUMavMF+iBGwTBX40yoYpd/gJsla01TzlebkCfz
         ZkEsCuzX0ItWmn0gQnKYPf56A/drWWmzYIIqujL9vkw3WROj9xGtdMEb8GALIIfPmyux
         zHYxLJZrYrq8ld9g5AR9aIFmzXNnMuFtgLUE+qEhYx7IYU6c1eM/MzCOqwtco7aAWDmv
         IOgzPQV7E9ZAe6yS+V+otuW4NHp/xzKHl2EIKBJKHBehy6qZ1VaR6bcE7LU5glcECWMC
         H07A==
X-Forwarded-Encrypted: i=1; AJvYcCVBGaOCrF0ltvcO1jx5sWvJsqpquMHh1KrBst9WzoZjKBOsKaEYHGQGPZkEnQ7riXWG49oABVxjg8yf@vger.kernel.org, AJvYcCW2yY7DgBS5MLDNx+LlhcLMeW95vwxF/OWcV0abY/KuHFvBy3w2/gTrE7MfwIThnnfkbnHp0ch7lQ5yKLLbsA==@vger.kernel.org, AJvYcCX7NutS+YcEDV3LSdbHRuvaw2qMlGMQLDUUEDnSSz2PXc74sDPUdqlyolKLRrvnVvStesI+4e4F0oVxkV+W@vger.kernel.org, AJvYcCXXN9o4SKCXKqSv0ZA9xR69TT21chDHE2LH2XFF2+/P1Y3/WsgKB1tcZYL4ZM+apkh645GV@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgs340hBZEoTZ/00zeAUmdBkMxdaYrGBeEKde37z89VwKhXDk
	0m8NWjCiuwheTLOFxzOsta2OlPH56IJVuhYYN1NJ9+p8VF0VPz3LH4j7cQ==
X-Google-Smtp-Source: AGHT+IFpmKxegBBxJtwt3F5kjss628klsXcexCPwNYqEgnGMblF1xw2sAYbYnXxsAMkQ/CKqrs9XdQ==
X-Received: by 2002:a05:6122:1d4c:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-5106ae6d944mr7241263e0c.2.1730441032853;
        Thu, 31 Oct 2024 23:03:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a54csm15599906d6.103.2024.10.31.23.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:03:52 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id A3CA61200043;
	Fri,  1 Nov 2024 02:03:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 02:03:51 -0400
X-ME-Sender: <xms:R28kZ4bb_Sk9J7zt3qFeaT1qzW6GSFona-Ra0vzADvi51JvP6gzrQQ>
    <xme:R28kZzb4zs_rSb-O8-rH8VXmtXSrpKNxo7HIHRx2zWFOWZ3pXa68xln8EoyBgBAMD
    PArbQDyATWXi5hP_A>
X-ME-Received: <xmr:R28kZy-LSAufwW1a7ygeoPoU8ypYEhDJatfOJM4Th7Lng_ghYTxruzelpVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeuieehffeijeelkeevheegleeifeevfeetkeehhfei
    ieevfeegvdelleekvdejleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlfihnrd
    hnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehg
    mhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhr
    tghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepoh
    hjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhes
    ghhmrghilhdrtghomhdprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:R28kZyrpJlHIvsTTJ-WuleSP96_mG-FkZdVedW5NiQjlaAFO600eMA>
    <xmx:R28kZzrHCB4ir-wAjZX332RHKJMwzKCinWtCmTJyWN4LWycSAWm01A>
    <xmx:R28kZwSMGSNzLcJp6OHMEq-daBCDG1v6e6QenIan8b8GxF-TNgRoLg>
    <xmx:R28kZzrH-eNwVcajJdcHii_fV9T-A03iQvTXjfsIV6uAIxC4E0YxjQ>
    <xmx:R28kZ468gHgU7LKmhLnh3uBi9E8DEdQyIqYPQ4y0FNHt4kMBxSX6Xsq9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 02:03:51 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	lkmm@lists.linux.dev
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
Subject: [RFC v2 00/13] LKMM *generic* atomics in Rust
Date: Thu, 31 Oct 2024 23:02:23 -0700
Message-ID: <20241101060237.1185533-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is another RFC version of LKMM atomics in Rust, you can find the
previous versions:

v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

I add a few more people Cced this time, so if you're curious about why
we choose to implement LKMM atomics instead of using the Rust ones, you
can find some explanation:

* In my Kangrejos talk: https://lwn.net/Articles/993785/
* In Linus' email: https://lore.kernel.org/rust-for-linux/CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com/

This time, I try implementing a generic atomic type `Atomic<T>`, since
Benno and Gary suggested last time, and also Rust standard library is
also going to that direction [1].

Honestly, a generic atomic type is still not quite necessary for myself,
but here are a few reasons that it's useful:

*	It's useful for type alias, for example, if you have:

	type c_long = isize;

	Then `Atomic<c_clong>` and `Atomic<isize>` is the same type,
	this may make FFI code (mapping a C type to a Rust type or vice
	versa) more readable.

*	In kernel, we sometimes switch atomic to percpu for better
	scalabity, percpu is naturally a generic type, because it can
	have data that is larger than machine word size. Making atomic
	generic ease the potential switching/refactoring.

*	Generic atomics provide all the functionalities that non-generic
	atomics could have.

That said, currently "generic" is limited to a few types: the type must
be the same size as atomic_t or atomic64_t, other than basic types, only
#[repr(<basic types>)] struct can be used in a `Atomic<T>`.

Also this is not a full feature set patchset, things like different
arithmetic operations and bit operations are still missing, they can be
either future work or for future versions.

I included an RCU pointer implementation as one example of the usage, so
a patch from Danilo is added, but I will drop it once his patch merged.

This is based on today's rust-next, and I've run all kunit tests from
the doc test on x86, arm64 and riscv.

Feedbacks and comments are welcome! Thanks.

Regards,
Boqun

[1]: https://github.com/rust-lang/rust/issues/130539

Boqun Feng (12):
  rust: Introduce atomic API helpers
  rust: sync: Add basic atomic operation mapping framework
  rust: sync: atomic: Add ordering annotation types
  rust: sync: atomic: Add generic atomics
  rust: sync: atomic: Add atomic {cmp,}xchg operations
  rust: sync: atomic: Add the framework of arithmetic operations
  rust: sync: atomic: Add Atomic<u{32,64}>
  rust: sync: atomic: Add Atomic<{usize,isize}>
  rust: sync: atomic: Add Atomic<*mut T>
  rust: sync: atomic: Add arithmetic ops for Atomic<*mut T>
  rust: sync: Add memory barriers
  rust: sync: rcu: Add RCU protected pointer

Wedson Almeida Filho (1):
  rust: add rcu abstraction

 MAINTAINERS                               |    4 +-
 rust/helpers/atomic.c                     | 1038 +++++++++++++++++++++
 rust/helpers/helpers.c                    |    3 +
 rust/helpers/rcu.c                        |   13 +
 rust/kernel/sync.rs                       |    3 +
 rust/kernel/sync/atomic.rs                |  228 +++++
 rust/kernel/sync/atomic/generic.rs        |  516 ++++++++++
 rust/kernel/sync/atomic/ops.rs            |  199 ++++
 rust/kernel/sync/atomic/ordering.rs       |   94 ++
 rust/kernel/sync/barrier.rs               |   67 ++
 rust/kernel/sync/rcu.rs                   |  319 +++++++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
 13 files changed, 2549 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/atomic.c
 create mode 100644 rust/helpers/rcu.c
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/generic.rs
 create mode 100644 rust/kernel/sync/atomic/ops.rs
 create mode 100644 rust/kernel/sync/atomic/ordering.rs
 create mode 100644 rust/kernel/sync/barrier.rs
 create mode 100644 rust/kernel/sync/rcu.rs
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

-- 
2.45.2


