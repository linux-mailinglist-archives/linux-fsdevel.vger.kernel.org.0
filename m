Return-Path: <linux-fsdevel+bounces-21798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2790A368
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 07:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D342B21239
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 05:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED3181D0D;
	Mon, 17 Jun 2024 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9A+uv/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9717F5;
	Mon, 17 Jun 2024 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602949; cv=none; b=uht/APVkUXztUw270x3ho7NN6zhYjXxDzjnbCb7evqVgiWnUghh8lc0hgiP/a2ccz2uvg5qeHlpS4WvfWCjk4lq3N6jEboWi93C0mW3xZrYKszbDOHZ4BUft3xYzWW8IWPheWvKT2I7vxx0Ixq4C8mKD8a31WC5FLEPo10uy/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602949; c=relaxed/simple;
	bh=fe1CDe4TWdB/mkMo+Ij8B6m8DzwSgqUdshEjV3EiiHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezr5QXTUZOjh/V/ume5TC8YvhBk+8ZgZDaQQRBZhg7EQAeV/PPPjzTgIGxQzTxieEGXQ0vPbkoRjsR6SH4S05/3ZX0h6HNkPzb+GXBpzU7ka/vCIHp1LKFRy0AX/OuVPtLAI4M1fFc18F7XobApLftAHxZzaXfWpYU4u6hRFcFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9A+uv/C; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44054a2c153so21057571cf.2;
        Sun, 16 Jun 2024 22:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718602946; x=1719207746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djPwZuKbvrmoSptmQGftbxnFBiXhu4eAY3uKLEqMxtQ=;
        b=N9A+uv/CJW7I/7mp8qlPKB5qibKyNL3J0m5CTuid9je8SuJUHw877G5MTJ+bc3dxt0
         WXg+YYmACnlsyNdmo6vEBc2LklpQlzGqxmA3/RIZ0nNFVsEFa5AlsZIxhPwnRVc+cQKc
         G8biaBEEom1m3u0wsIfH4O6PW59ltpJw1Y1wPO/TfUgkB5bHUWDvMWpnzM3eQQxMSAEa
         v8fbiFvStkN8u8bd9H1CIq5mwc8PeIcBZs2vatDQiljJxTIuxYT0kDXRIIKFTxG3Rj//
         PWyAhXNIJac7ctmyFORxMINB6my3Y4PNIVrgPjNBVpWDaEpZJ58ASWEMGDT9uqYNGqxU
         ylTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718602946; x=1719207746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djPwZuKbvrmoSptmQGftbxnFBiXhu4eAY3uKLEqMxtQ=;
        b=rkw/IvQcmW/wTxp6KOHwQTGOEf5BJNUOxpNtcxoksTA7B2JExZV4GOzzWSTc4IvwCT
         lpEM1V0Z/8LPcVFA9bE/KutcCxgmXNgA2yQbWxdpoWJFo9gHYyMQHKm2IhLnoBqdo+6d
         fsDVfgoHDyMUwXDg93PGHp6B6i7v/ho9HIgJ3rT02nGHpQTyibQ0R5j7QGWTxYVZ1tCU
         qqFDRDBjwvx9Ij8uChhHB9o8TJq91kZQC+BHtd10Flvpuu58R8Ta5lofQeun4JTyoONa
         tAZhov/sox9UrVrhC+0DFXL5Shq0a4okoZR7n3VcmadArZhGt22mfNS9TxMPVyzcx9WZ
         wgUg==
X-Forwarded-Encrypted: i=1; AJvYcCXawzg8Yo1wGkHjCfvTvde2mXcMDD+6Cbyf9ua0SCby5qrS3trBUkqEYHPKJ8AIATmznITaaH5IKZ7N07i305uILkN+jkPjw3MdRhMx4xLPiMFtiOOpLA5Di6mp5XOw2o5Nm3EqSsdenvnlHoqXaLYvCjLAMoaztoghcBOEb9t72iu1XcueMz+xVp9IwoZJ2uVd2ee7f1nCFuvHYcN+MvE3LIGzkXyA7w==
X-Gm-Message-State: AOJu0YyNGKdEg5DHGc0p9DZXYcFnytJ4a7G5Blc0pVYQVvfEYt7HRi31
	qbCMhQW73p3/1dEYPWniwKfRAkbEkvD4+Pn2LG3X3rOZ5R9vfJ9o
X-Google-Smtp-Source: AGHT+IFs1jHgkUIF6bJM9amNqYLJX4wu5fNNYuW2fgfw3dZuTeC2J1Hh8+avNa0MuwtF0uJIpye+nw==
X-Received: by 2002:a05:622a:5b0a:b0:444:8e78:6d25 with SMTP id d75a77b69052e-4448e786de1mr26277721cf.65.1718602946046;
        Sun, 16 Jun 2024 22:42:26 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f30f1d2esm43347471cf.81.2024.06.16.22.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:42:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A58321200043;
	Mon, 17 Jun 2024 01:42:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 01:42:24 -0400
X-ME-Sender: <xms:wMxvZo0x9rYvWqnmGzVfHtqzQ5UJdt3TQ9Y6Q36Ed4hJqAi7c9zlew>
    <xme:wMxvZjHjSVMPeJV9Fh2t8F8OIYvHuNFa4SMst9xAKDgu62fciHn6ROTTzOXsZ23rB
    mTq2Sgg257x3qwurg>
X-ME-Received: <xmr:wMxvZg4aIL80NG_trWxZvtFnfjdGvo6GULztCf7a9BROKbU-6Iv_-tOSzEn3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgedgkedvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:wMxvZh0Y36WgBdy_3vUXxW_l0cXSwC1qF7IBDpgQfJkjnCOqU7xDaQ>
    <xmx:wMxvZrEWp6ygxMKl21Fr-OMTe3dZWwRrs1qvpZt6TjP_OHURD8YKaA>
    <xmx:wMxvZq9LmovzWkIscKjSOB3ZTFYsJvt-Yt9jLnOMu-azWM-iZOy1Cg>
    <xmx:wMxvZgkFowrjk3ULXLAerMXFmoV45SamdfPtX1UG5t5xgnhgwXH1uQ>
    <xmx:wMxvZrEH7HjeHWtZkpYbjttEVdIcmELQiMGL8pyCsJPmXC2K5Y_O5ORA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 01:42:23 -0400 (EDT)
Date: Sun, 16 Jun 2024 22:42:19 -0700
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
Message-ID: <Zm_Mu7C76jpMyRy6@Boquns-Mac-mini.home>
References: <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
 <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
 <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
 <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
 <20240616155145.54371240.gary@garyguo.net>
 <Zm7_XWe6ciy1yN-h@Boquns-Mac-mini.home>
 <Zm_LTXm3wJhcQIwI@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm_LTXm3wJhcQIwI@Boquns-Mac-mini.home>

On Sun, Jun 16, 2024 at 10:36:13PM -0700, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 08:06:05AM -0700, Boqun Feng wrote:
> [...]
> > > 
> > > Note that crossbeam's AtomicCell is also generic, and crossbeam is used
> > > by tons of crates. As Miguel mentioned, I think it's very likely that in
> > > the future we want be able to do atomics on new types (e.g. for
> > > seqlocks perhaps). We probably don't need the non-lock-free fallback of
> > 
> > Good, another design bit, thank you!
> > 
> > What's our overall idea on sub-word types, like Atomic<u8> and
> > Atomic<u16>, do we plan to say no to them, or they could have a limited
> > APIs? IIUC, some operations on them are relatively sub-optimal on some
> > architectures, supporting the same set of API as i32 and i64 is probably
> > a bad idea.
> > 
> > Another thing in my mind is making `Atomic<T>`
> > 
> > 	pub struct Atomic<T: Send + ...> { ... }
> > 
> > so that `Atomic<T>` will always be `Sync`, because quite frankly, an
> > atomic type that cannot `Sync` is pointless.
> > 
> 
> Also, how do we avoid this issue [1] in kernel?
> 
> `atomic_load()` in C is implemented as READ_ONCE() and it's, at most
> time, a volatile read, so the eventual code is:
> 
>     let a: (u8, u16) = (1, 2);
>     let b = unsafe { core::ptr::read_volatile::<i32>(&a as *const _ as *const i32) };
> 

^^^^ this line should really be:

	let b: (u8, u16) = unsafe { transmute_copy(&read_volatile::<i32>(&a as *const _ as *const i32)) };

but you get the idea.

Regards,
Boqun

> I know we probably ignore data race here and treat `read_volatile` as a
> dependency read per LKMM [2]. But this is an using of uninitialized
> data, so it's a bit different.
> 
> We can do what https://crates.io/crates/atomic does:
> 
> 	pub struct Atomic<T: NoUninit + ..> { ... }
> 
> , where `NoUinit` means no internal padding bytes, but it loses the
> ability to put a 
> 
> 	#[repr(u32)]
> 	pub enum Foo { .. }
> 
> into `Atomic<T>`, right? Which is probably a case you want to support?
> 
> Regards,
> Boqun
> 
> [1]: https://github.com/crossbeam-rs/crossbeam/issues/748#issuecomment-1133926617
> [2]: tools/memory-model/Documentation/access-marking.txt
> 
> > Regards,
> > Boqun
> > 
> > > crossbeam's AtomicCell, but the lock-free subset with newtype support
> > > is desirable.
> > > 
> > > People in general don't use the `atomic` crate because it provides no
> > > additional feature compared to the standard library. But it doesn't
> > > really mean that the standard library's atomic design is good.
> > > 
> > > People decided to use AtomicT and NonZeroT instead of Atomic<T> or
> > > NonZero<T> long time ago, but many now thinks the decision was bad.
> > > Introduction of NonZero<T> is a good example of it. NonZeroT are now
> > > all type aliases of NonZero<T>.
> > > 
> > > I also don't see any downside in using generics. We can provide type
> > > aliases so people can use `AtomicI32` and `AtomicI64` when they want
> > > their code to be compatible with userspace Rust can still do so.
> > > 
> > > `Atomic<i32>` is also just aesthetically better than `AtomicI32` IMO.
> > > When all other types look like `NonZero<i32>`, `Wrapping<i32>`, I don't
> > > think we should have `AtomicI32` just because "it's done this way in
> > > Rust std". Our alloc already deviates a lot from Rust std.
> > > 
> > > Best,
> > > Gary

