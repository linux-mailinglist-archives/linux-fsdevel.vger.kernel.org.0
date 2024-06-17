Return-Path: <linux-fsdevel+bounces-21797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B33E90A360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 07:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2832B20F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 05:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3F181D1F;
	Mon, 17 Jun 2024 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAGuTI5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B717F5;
	Mon, 17 Jun 2024 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602584; cv=none; b=cj4eWYNwnWVbfL35ex/C3TcUMVhtSh7UgM0tFQv55d6HwpJTUDKMpfwFMtssJNleVuRwBxDsebIp/8s5y9yS+GUZn1GPnMBs8Dz+kbtFqsNXZlpJE6KbsL6/A/hghWirGV/sEsvOS4CPGXbvkJZi3dEdULgky3wOROIYP+Pt0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602584; c=relaxed/simple;
	bh=qNGJPYfBIO6Qqcf8w5/M6GsWzh6G1g0pb+xXn3QuMW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7o3N9JjPHInij+/gPZDhPwYqSe5qxRuyrQozwY/JQE2uplCUzMbx63TyYTyIFKRqbb3cLbA0jesuKFnO9si3AIP0jXPf/IBxFf+jDl0VuA5pGXdqdJvxOsR2u4YhGna9c/xGxwU7N8hvKrWuWdb1/R0amtqgqS7UJR8LEW/g58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAGuTI5M; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-797a8cfc4ecso256101085a.3;
        Sun, 16 Jun 2024 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718602580; x=1719207380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJeIgTT6Qh/sxRKpkuk9BR9tYX+tCBNvv142Tf4kLOk=;
        b=SAGuTI5MJ7/bb9u+ndbDkxJtImYCwnhrOu3kTVtsIUjOZ/sGc4UIIHM95KdXx+2Le4
         hy+BzCqjix3ZDW1ROfxJ8yNPro26orj7tcPBG+iJ340zHqmx6rJvMAtmFS0PEhBPSwO7
         Lxuey4dswjFnufaBZtiDkBQbm8/m1CEgD1cSyyTPdw1750TyWnVgtHpAOBHfbg/MiNlG
         eEQzItb+Z1be0xyVSyWxkUlTtTW5JJu5INnHimYYSDbhhkfiRwyw0dIS1mVSXhjqt/cc
         +Ww6ViOq2Dh5eVMiJrv9giO4//cZLCFKt1RjKu2D/W6EO4Sal9tWFl1cBEs14pfGRe8y
         3pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718602580; x=1719207380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJeIgTT6Qh/sxRKpkuk9BR9tYX+tCBNvv142Tf4kLOk=;
        b=VijhRCAtZuIStoY+qGaflzef6gyVy46vc3naEo5+vZUdcvN4/MZCZC//fanxo98XZ0
         ciYfk/SMg2fwE6lWDaC9EgfJ7Tx7b9Qd3kQw+tzHQK9ggtCY9QzQKhb+VJaSH5upyAIp
         BkIaAzkcVRCqLjzhhb6ygdlSJO/n4uETiY/3iIVgnQenqlwuAciuLnrEbxOEQ42JzY4x
         upbxJuh4xlnvby2dsuaxj+lRNSP4K9A7jWDvxkUQ6sAWEcpLj59mKSj7EkXD8kJjzEd+
         MZwf58bAZqgH5t3l5W9/LCBvLHXsGs+oVgG3K4KbyuIkmCs/3Nv5hDlC/w+j8aXyy28h
         Zl2A==
X-Forwarded-Encrypted: i=1; AJvYcCW+yTKGr9lJdrN4WBqnDOpyXSJHlsIanbCfXTiozjR4kDPy5D7ekazMc5bJ4my4VmhU4JNNXydewzr50JzT3nBc84C4FFI8uKB0Y0HYOc1w5orLEaZEArcXz6HQ2B8ig2OGOq4c2TGgVIUoPfqanmLcKWh9VG+ewZ5J06kdMj3FHUjQUWHKti1KmpakCECCwQp5QX4LwqGPs7jfdZVx5nVbK4lj85owtQ==
X-Gm-Message-State: AOJu0Yw1B4RLbcsWgapDmSYDva6jcz3NLJruHiJvbkpYOsrc/M0NPuZE
	v82zs/15oGYh3fS4jc9D0acFCDC91EqcTCBu2sov+Y6Jpg9ibB3i
X-Google-Smtp-Source: AGHT+IHQxDKmzbQN3wDBWu2GUvw9lePhre6ZMLcLvCTUY/3kdj6Q6oqMmjAj+h53BtENoBkKnF5x2Q==
X-Received: by 2002:a05:620a:1921:b0:797:b67e:e843 with SMTP id af79cd13be357-798d258cf02mr869592085a.48.1718602580414;
        Sun, 16 Jun 2024 22:36:20 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe4f35dsm398786285a.122.2024.06.16.22.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:36:19 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id CAEB21200066;
	Mon, 17 Jun 2024 01:36:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 17 Jun 2024 01:36:18 -0400
X-ME-Sender: <xms:UstvZg4OKD0D5PdMwUkiymvL5RVxgMkqPDyDc2oI55hL3sxResMhcA>
    <xme:UstvZh6sjGf--LJ1guqKzRWVGnZUL4raAzsqsRnDe_w0MBAypia_nDlCVa6UOnE-F
    fd9KZlnRwz8S75bJg>
X-ME-Received: <xmr:UstvZveUkCBgqxC1AM2WOGv4P7WJRdcihWolYDynT_0R3qfYhm-D3DwSMTsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtteeuudejhfekffeiudeuvddvheduteejudeiieffhedvhffhffevtefg
    tdevtdenucffohhmrghinheptghrrghtvghsrdhiohdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgv
X-ME-Proxy: <xmx:UstvZlLD_I0DnJCopOEhlaBBeJjmGREaYlqiASh8Fv6MO2A9jTY8TQ>
    <xmx:UstvZkKa9vP5p9jv6p81qfz3AeuwJedYZeAg2weT3j6_n3wo96UYVQ>
    <xmx:UstvZmyWVWBZ8NH3B4zENjLVmv3YHMyyKgIO89Bohty3LX2JUZfGug>
    <xmx:UstvZoKlw68_7R3rFxM_YpO3A1mVdjfaLqcy7N8X5yqExmZLq4HidA>
    <xmx:UstvZjYRifXEzIfcyT5Mjjtnf8ibovnAmPvz4D5yA_GwgcxcQzqLcbcv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 01:36:17 -0400 (EDT)
Date: Sun, 16 Jun 2024 22:36:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <Zm_LTXm3wJhcQIwI@Boquns-Mac-mini.home>
References: <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
 <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
 <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
 <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
 <20240616155145.54371240.gary@garyguo.net>
 <Zm7_XWe6ciy1yN-h@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm7_XWe6ciy1yN-h@Boquns-Mac-mini.home>

On Sun, Jun 16, 2024 at 08:06:05AM -0700, Boqun Feng wrote:
[...]
> > 
> > Note that crossbeam's AtomicCell is also generic, and crossbeam is used
> > by tons of crates. As Miguel mentioned, I think it's very likely that in
> > the future we want be able to do atomics on new types (e.g. for
> > seqlocks perhaps). We probably don't need the non-lock-free fallback of
> 
> Good, another design bit, thank you!
> 
> What's our overall idea on sub-word types, like Atomic<u8> and
> Atomic<u16>, do we plan to say no to them, or they could have a limited
> APIs? IIUC, some operations on them are relatively sub-optimal on some
> architectures, supporting the same set of API as i32 and i64 is probably
> a bad idea.
> 
> Another thing in my mind is making `Atomic<T>`
> 
> 	pub struct Atomic<T: Send + ...> { ... }
> 
> so that `Atomic<T>` will always be `Sync`, because quite frankly, an
> atomic type that cannot `Sync` is pointless.
> 

Also, how do we avoid this issue [1] in kernel?

`atomic_load()` in C is implemented as READ_ONCE() and it's, at most
time, a volatile read, so the eventual code is:

    let a: (u8, u16) = (1, 2);
    let b = unsafe { core::ptr::read_volatile::<i32>(&a as *const _ as *const i32) };

I know we probably ignore data race here and treat `read_volatile` as a
dependency read per LKMM [2]. But this is an using of uninitialized
data, so it's a bit different.

We can do what https://crates.io/crates/atomic does:

	pub struct Atomic<T: NoUninit + ..> { ... }

, where `NoUinit` means no internal padding bytes, but it loses the
ability to put a 

	#[repr(u32)]
	pub enum Foo { .. }

into `Atomic<T>`, right? Which is probably a case you want to support?

Regards,
Boqun

[1]: https://github.com/crossbeam-rs/crossbeam/issues/748#issuecomment-1133926617
[2]: tools/memory-model/Documentation/access-marking.txt

> Regards,
> Boqun
> 
> > crossbeam's AtomicCell, but the lock-free subset with newtype support
> > is desirable.
> > 
> > People in general don't use the `atomic` crate because it provides no
> > additional feature compared to the standard library. But it doesn't
> > really mean that the standard library's atomic design is good.
> > 
> > People decided to use AtomicT and NonZeroT instead of Atomic<T> or
> > NonZero<T> long time ago, but many now thinks the decision was bad.
> > Introduction of NonZero<T> is a good example of it. NonZeroT are now
> > all type aliases of NonZero<T>.
> > 
> > I also don't see any downside in using generics. We can provide type
> > aliases so people can use `AtomicI32` and `AtomicI64` when they want
> > their code to be compatible with userspace Rust can still do so.
> > 
> > `Atomic<i32>` is also just aesthetically better than `AtomicI32` IMO.
> > When all other types look like `NonZero<i32>`, `Wrapping<i32>`, I don't
> > think we should have `AtomicI32` just because "it's done this way in
> > Rust std". Our alloc already deviates a lot from Rust std.
> > 
> > Best,
> > Gary

