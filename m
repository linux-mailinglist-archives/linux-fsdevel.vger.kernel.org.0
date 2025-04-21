Return-Path: <linux-fsdevel+bounces-46813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD7A954AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3935116FFD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA01E5201;
	Mon, 21 Apr 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwzkvvaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62B1DF72E;
	Mon, 21 Apr 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253754; cv=none; b=S9tsf+npDodLBVI31IoLjGm7BHSquASUJ4JUSU3kKEWQ8TihcZe8a5kqGQ4XDl/WiPHm4ROdJ1d2swc8omXGoELD3ArhNoQYKrpRlfiu3eABsYwEwxyrUSISUNZClDhk6wgIG6RhfT2S/N0AYZEuuR4aXA2AFShH17ERMkeeMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253754; c=relaxed/simple;
	bh=n9vuedf6SLmh7TklE+9GmS5b6pnz2Hcuw8Jcq+yExuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeO/15HuQZxxTV8vVm7toe27ZPkDoywouFRhPscB0WToJTO2WRe/YlDUhYH7RFa5LiEmXyyNYV51n4GahgHedAS9ES3OufTKDSKQ4QCCMLtgRODA1rqjrNJ4dUWynLuSDUlSmQ82Vu4ap5cohx0Avq5JuXdUaWK16rEOS0GUM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwzkvvaE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c59e7039eeso590492985a.2;
        Mon, 21 Apr 2025 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253751; x=1745858551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ODIKSAWOegt1B2HFm8l018++oeGfbMZqnIZ7rWaQ3pQ=;
        b=kwzkvvaE+pzCwv0WYEhXC8Bk+r6sLXUY4IJUVvNPCONZsv5p4Hgt9nkyfcag9Z5QCJ
         eHW8NACsgVq6jSmoI6sS5J1UHC/GstR15cq6zcdDV53a1gz+LAkraU6S3RM9fFGl8egB
         P5fGive+kiifruIVM+367FSEbw3nL7eDSvh6/Y1lx91UQCVC8FVjDAJbNpodejgSiFhK
         xAefFIX6SlYVR8613tvnPs4gcIvEJh3hs99dwygpPwA/DhjvM3zbra0ozsMS+l4DO31Y
         OhUFPaNuoleSP8xWyd28ztz8Q3iinOz3Ilp018jAiZdAu3it5CV0jv8n0oaNGvolWOW9
         uhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253751; x=1745858551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODIKSAWOegt1B2HFm8l018++oeGfbMZqnIZ7rWaQ3pQ=;
        b=GsQKR9Cj5Gyr9vmW3jT2QUaHFzydY+MP5T68gGwI6whrRrhvWNIziGLyWDnL+kjfyT
         KeOc49J98YtiCi/KVFnwC5+ZYYa3PTW5BzZXWb8Aux3Q5DUAWpytS7wGbNJlk79VCtu/
         wtAZM7dn6pbiRbfHGegfXY3DrYuBDaITdj57H0SpsPbXDvqMhzqY1FECX7dH1GiOtluA
         wBbwJxMe5yY1OUGP9U6fzFQje5uzely2HxDCYhu/dUdXYTDagHthVx3FZXA8EtiQz/q9
         Yqxt/ZQ2QoaPCSuP7PUvSqaBGEdi6mMH9yMcCfzC3Vh8QBpz4n4udc3IhjdEb26BD6vv
         +sSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTRrs6euWN6WOeRpjyNFueXJ9ykCaRL35lshpYrKOVjMcuKUQg/XN3RpaaqUY+rwpckd9m@vger.kernel.org, AJvYcCVeAIyurAlEUGgf3vy8ETJPzWXkcrZ4fy6Z43KYNJdkbDzkadYBrLeoAtp54D1TNBy51R6MEdpzZA96@vger.kernel.org, AJvYcCVueoqkWUg2J/Yo43mCH2IQeZ8Owx3Nbu+5ozYcvmxbUv6nYuJrXlIg+ffuzFLQhP3zW51XSmeWGit/F5Wf@vger.kernel.org, AJvYcCWfEgtOei4nc8PRH6R8z3vq6oNQWJpM2UnZKicm3rpddeS5H58yoRuFCrraI9vv9UNKt9xKYhX0VmqO2mN0Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwoSNPtxMTjjlCqWwLcfGa+QN98jyR9yOWhnD58EquxoQOAWFn
	TncYuGGv/z2Q6E93EqKIUgcSgVor4hvFop0Fpv+BWNEV8ze7GMxv8AwpXA==
X-Gm-Gg: ASbGncsL32bLB4Rt+FuWANsUXMNq5Ll1Ql9k5yMWfvVM3AIlxob3l99F25Hlc+WwcIR
	hCJNZpl1HmagLpYiSEbM2YKTkSe9SHN1/Wa5Dv2Ip8KI0rmRNvb2398H8HDo/zwudqqSYU4mGMr
	gCCxPyqMtwlp11tVd4MIMLnuDsTOBGYfFt/So9O7b8by+ZkOBdN2ZzuVaymwaqBFzL0Vgnq7ou6
	1zzfuXQHOLQDjqTdfWM7c1+AlOY8GQOusbZoN8/lCKS5TKd6bZxKxPHD0vOJoVdtIVUiGJL0nEs
	P7WiocQ9e9stUiOoJI/PrilcRAsUkHjgCMcbrEO5LU0q8Isuu6/7n1hJbQJ2bEOpHSfJxB2uMux
	euDm0FCiOH19yH2RnrHnBO2oPMQJlPMY=
X-Google-Smtp-Source: AGHT+IHewOY1waDmussup22qNjvnXmo+g9qW95rRhTHZS93YwijxnDwYkpr3aqHhszdWqKYbprRU2g==
X-Received: by 2002:a05:620a:4511:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7c9280167b1mr2038665785a.40.1745253751372;
        Mon, 21 Apr 2025 09:42:31 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b69d0asm437358585a.99.2025.04.21.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:42:30 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6DE101200043;
	Mon, 21 Apr 2025 12:42:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 21 Apr 2025 12:42:30 -0400
X-ME-Sender: <xms:dnUGaKTlJuxHgt-ByEfqqq6pKkOsT2AMOAdV6wfAPxVU2GN-bFZOAQ>
    <xme:dnUGaPw6B7IAIOuPN4fLcyjSfzr8w_sKGNmhsFvjy6Ezg8Nhk9t-LZlkZOfVJT2xr
    ZPsDvtm1yJDkpUZig>
X-ME-Received: <xmr:dnUGaH3dwis-2V2wO2u33k0Li-fk7BirGRV2xY89LN1lsk-HFPl6qKP11___>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeggeeukeeghfevudektdevjeehhfekffevueef
    udeivdelteeltdekheejgfeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeehiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlkhhmmheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dnUGaGAIFo9hXK_--fPBdFYreTLGmzR7mN6l8OZDIpoiWnL3BrHWeQ>
    <xmx:dnUGaDiVq-wZpzKikenr_WqjGgjUzfS-Yxejaa7b1Nse-klFgRUpYw>
    <xmx:dnUGaCp1pY3eVeNPRNWYeXo-KJwlKGUjqmFt_YeVcnQfng5DOM-V3A>
    <xmx:dnUGaGgwDNiiaWtfhYyD9JPrJgt7jwz6tyJvo-QoMFT_ZTthuHpDbg>
    <xmx:dnUGaCTZPsnD4RyR99O6Hg_vj72roA5JlZAcikFvF4b6LTZNHnqdt3E_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:42:29 -0400 (EDT)
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
Subject: [RFC v3 00/12] LKMM generic atomics in Rust
Date: Mon, 21 Apr 2025 09:42:09 -0700
Message-ID: <20250421164221.1121805-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v3 for LKMM atomics in Rust, you can find the previous versions:

v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun.feng@gmail.com/
v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

Changes since v2:

*	Drop the temporary RCU binding since they are already in
	mainline.

*	Fix a few "Ipml" typos in previous versions per feedback from
	Alice Ryhl.

*	Documentation improvement per feedback from Alice Ryhl.

I'm hoping to at least get the first 8 patches (atomic operations on
normal integer) in a good shape so that we can have them in v6.16.
Thanks!

Regards,
Boqun

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

 MAINTAINERS                               |    4 +-
 rust/helpers/atomic.c                     | 1038 +++++++++++++++++++++
 rust/helpers/barrier.c                    |   18 +
 rust/helpers/helpers.c                    |    2 +
 rust/kernel/sync.rs                       |    2 +
 rust/kernel/sync/atomic.rs                |  228 +++++
 rust/kernel/sync/atomic/generic.rs        |  488 ++++++++++
 rust/kernel/sync/atomic/ops.rs            |  199 ++++
 rust/kernel/sync/atomic/ordering.rs       |   94 ++
 rust/kernel/sync/barrier.rs               |   67 ++
 rust/kernel/sync/rcu.rs                   |  275 +++++-
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
 13 files changed, 2479 insertions(+), 2 deletions(-)
 create mode 100644 rust/helpers/atomic.c
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/generic.rs
 create mode 100644 rust/kernel/sync/atomic/ops.rs
 create mode 100644 rust/kernel/sync/atomic/ordering.rs
 create mode 100644 rust/kernel/sync/barrier.rs
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

-- 
2.47.1


