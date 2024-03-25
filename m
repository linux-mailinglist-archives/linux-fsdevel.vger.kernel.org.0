Return-Path: <linux-fsdevel+bounces-15266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078FD88B576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 00:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D71C37676
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 23:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793E84D0A;
	Mon, 25 Mar 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdTVfaWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1683CA4;
	Mon, 25 Mar 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410116; cv=none; b=pkP+/YNRpRzCpHS88CFL8yyfjOJNiy7FX6ZqWp8x4FUiJeNO/H493ysrYpxizdiptzssUrekcutgC4qhExBNzNLhP+eq7VXmdniDdEMdnHzEjvW/cme46FZEiUyQ9zHaDFVih1Pc+HinE6EZ0FFDcASwkFIC7ZxSwzWObzGAW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410116; c=relaxed/simple;
	bh=8wtoXalC0rIot47YssKWI4aZamE8d7fHGPD58F/CrCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1G6++0yGpt6apDDc2VM5SpbQshmBl5T8bxWfjQ6Sha4iLek+ujW/RF6q6VMNl0C6yCUfiE22neQrRPYAznllFMfbmh4vnFg5sHDBUaDo+iPzusf0rRIcxoxVurDprOBl9dCtbgJk0m8V9uc0+b2ZjfNQdzg/qWv+ZgG3IYngTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdTVfaWx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6918781a913so41496086d6.3;
        Mon, 25 Mar 2024 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711410114; x=1712014914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJGcRjWxujI/xbMJS+9v8/3RkR6IQk/HoBXdHo4IvJM=;
        b=GdTVfaWx01v07Aj+NJLr/jCNIbxMwTiQDERbcKPCzJTvlh8P8cTiREqLh1TBlRZ5p9
         tuHXJQ464OnGuonwqg6Kraj2HMFIGU2zky24yZRecrX1ARv+rXgTVI5eusA/a3qj6Xzv
         ujNzTZLl0r49pPTCe4JeVvN1zUUKwbkp4NhpbaURlCTiHYvE18s1ein4kduWGUqYnYrW
         ItjKLRrHknI2BqwN24Kpjn5roAj95JHf7FuOhvvcVdar0/Ea7vE+lvMelTE9prsZELQu
         DjwPF+YAPmyyFmmC3mB1Fr7WaB4pYz5CHpELiAd2/AOSI8TON5/lY9vYampe2YCcQJ+S
         MmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410114; x=1712014914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJGcRjWxujI/xbMJS+9v8/3RkR6IQk/HoBXdHo4IvJM=;
        b=vKcvzpza6QAjMCQSgw7FNjFjurH12FfqX5qYJpb80BiyVsKvz7AFuW5FjChJS+j2kc
         DQMAlEnHiMamtbBWFfogvkmJUvZPPQPeVs19W1hVr8EVUDEMb5Uv4EhQcYoAQevJTBlr
         7MfaubmTxxUmij3urmhXvxqniMvPEh20oJfmS/gNCg2SVtxrdhj5X+Wna/UoxW8iU9sJ
         MCmPjRc4aqtSOE1+PNalR6JobKhyK8BSOjWKNM93HMwSxFVzG/QSAgvqiSueDTNxGAtI
         qxdZKEzoOn1COEjPJ3x9sRLx4eHxGRsUnPeQUb147mKHJ57VldsbHGzNhwqt3E3TSdxM
         pH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdy5TZ43fy34ytk5f72NJVqmlyxwteS6HMC4VqAB5fR8zcbWYoSnIZUUq6PpH7pgMLpqxcs6elx9g8dhnqvQaCsIH+05O5X7Jtrju/mxcRf4/f7cqvGmm+Fl9IlzfSNwY623eMKA3Fa0gYZUkgAPvZdkELo8ECeRnOdBurfW+XliL9mBZO36RYl7ha7d2JovqgoiQwWZjC34xM1g2pAC2oCALlx0xGvA==
X-Gm-Message-State: AOJu0Yw9Pnf0cyMAw0UO0P/Z1azKUdxixA9V3ykQdPR9ZJtwCvP01nIg
	TduYvnEOrmJYGJ4dtIddaxXF0Hz5Nwy8e7qj478YxyB97j8h1HWx
X-Google-Smtp-Source: AGHT+IEdPU4dTEy2JZqf6+fOq13iZJz6jJM2/V2qB77B0kCBgeR/Ks/8yVDV8iurZcon/ktLSAu9Dw==
X-Received: by 2002:a05:6214:20e7:b0:696:89f6:28d5 with SMTP id 7-20020a05621420e700b0069689f628d5mr5443333qvk.50.1711410113750;
        Mon, 25 Mar 2024 16:41:53 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id pn16-20020a056214131000b00690afbf56d5sm4549850qvb.66.2024.03.25.16.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:41:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0DD1A1200032;
	Mon, 25 Mar 2024 19:41:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 19:41:52 -0400
X-ME-Sender: <xms:vwsCZvsaCSxos8n79rZkAnGlOLB2T3k0UOcwZUN8am2ifjKvkR6qAQ>
    <xme:vwsCZgcbeL9ZUoKDC84FCXvXT50zsbQLmYIZwAELH26czQlsmNuaRuvnuhqqBwu7R
    ghIgUv7_CmxngQjkg>
X-ME-Received: <xmr:vwsCZiwkQGJyk9mLCVEH4OO83Fe-KY7HEZ9mTurW_zD-zL8662W1ASrrCIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevvdejffefgeffhfelffeikeeigeehjeekgfefudeugfejfefhteekvedu
    teelhfenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghdpiihulhhiphgthhgrth
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:vwsCZuNaQjsRCLUNW8IaAff0EyoUoWu_fUrBqrZKEsNReL9iHs8kFg>
    <xmx:vwsCZv9ocLjBkeOeNf-GDgorBHdbW30PbcdI4nVzT3zrOUogmMhSIA>
    <xmx:vwsCZuVqLPTJVJhxer93DncKKWLfZcU7ABwCONtY-6l6fztq-LpCKA>
    <xmx:vwsCZgfTrHJpR_1BcTK--XiAOr8c5rkvIZZWJeQfLZMXK4ijfwf-RQ>
    <xmx:wAsCZl4i7_IgwVOE5CIKAS825amAtXL6LwfmgSXfqwER1O_snhWyF99VBEV0nCdF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 19:41:50 -0400 (EDT)
Date: Mon, 25 Mar 2024 16:41:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>,	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,	linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
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
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZgILn_Uy5nSodrcY@boqun-archlinux>
References: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>
 <ZgHuioMM1cAWNDiX@boqun-archlinux>
 <jyijwrrzzhlsrffj37xj4sskipxqbxfewydnb3yzgybjobj6tg@cbv5y7znhm3n>
 <ZgH86EUON30lUk6m@boqun-archlinux>
 <qo6z3j2h32rzwr6bcnkrrw7irdqwakgymcf2jodnq5nz3simwq@tqydlv4mctrv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qo6z3j2h32rzwr6bcnkrrw7irdqwakgymcf2jodnq5nz3simwq@tqydlv4mctrv>

On Mon, Mar 25, 2024 at 07:02:12PM -0400, Kent Overstreet wrote:
> On Mon, Mar 25, 2024 at 03:38:32PM -0700, Boqun Feng wrote:
> > On Mon, Mar 25, 2024 at 06:09:19PM -0400, Kent Overstreet wrote:
> > > On Mon, Mar 25, 2024 at 02:37:14PM -0700, Boqun Feng wrote:
> > > > On Mon, Mar 25, 2024 at 05:14:41PM -0400, Kent Overstreet wrote:
> > > > > On Mon, Mar 25, 2024 at 12:44:34PM -0700, Linus Torvalds wrote:
> > > > > > On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > > >
> > > > > > > To be fair, "volatile" dates from an era when we didn't have the haziest
> > > > > > > understanding of what a working memory model for C would look like or
> > > > > > > why we'd even want one.
> > > > > > 
> > > > > > I don't disagree, but I find it very depressing that now that we *do*
> > > > > > know about memory models etc, the C++ memory model basically doubled
> > > > > > down on the same "object" model.
> > > > > > 
> > > > > > > The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> > > > > > > with modern thinking, just done with the tools available at the time. A
> > > > > > > more modern version would be just
> > > > > > >
> > > > > > > __atomic_load_n(ptr, __ATOMIC_RELAXED)
> > > > 
> > > > Note that Rust does have something similiar:
> > > > 
> > > > 	https://doc.rust-lang.org/std/ptr/fn.read_volatile.html
> > > > 
> > > > 	pub unsafe fn read_volatile<T>(src: *const T) -> T
> > > > 
> > > > (and also write_volatile()). So they made a good design putting the
> > > > volatile on the accesses rather than the type. However, per the current
> > > > Rust memory model these two primitives will be UB when data races happen
> > > > :-(
> > > > 
> > > > I mean, sure, if I use read_volatile() on an enum (whose valid values
> > > > are only 0, 1, 2), and I get a value 3, and the compiler says "you have
> > > > a logic bug and I refuse to compile the program correctly", I'm OK. But
> > > > if I use read_volatile() to read something like a u32, and I know it's
> > > > racy so my program actually handle that, I don't know any sane compiler
> > > > would miss-compile, so I don't know why that has to be a UB.
> > > 
> > > Well, if T is too big to read/write atomically then you'll get torn
> > > reads, including potentially a bit representation that is not a valid T.
> > > 
> > > Which is why the normal read_volatile<> or Volatile<> should disallow
> > > that.
> > > 
> > 
> > Well, why a racy read_volatile<> is UB on a T who is valid for all bit
> > representations is what I was complaining about ;-)
> 
> yeah, that should not be considered UB; that should be an easy fix. Are
> you talking to Rust compiler people about this stuff? I've been meaning

Here you go:

	https://rust-lang.zulipchat.com/#narrow/stream/136281-t-opsem/topic/UB.20caused.20by.20races.20on.20.60.7Bread.2Cwrite.7D_volatile.60/near/399343771	

but maybe instead of Rust, LLVM is the best one to talk with on this.
Because my take from the communication with Rust folks is more like
"it's more up to LLVM on this".

> to make my own contacts there, but - sadly, busy as hell.
> 
> > > > > where T is any type that fits in a machine word, and the only operations
> > > > > it supports are get(), set(), xchg() and cmpxchG().
> > > > > 
> > > > > You DO NOT want it to be possible to transparantly use Volatile<T> in
> > > > > place of a regular T - in exactly the same way as an atomic_t can't be
> > > > > used in place of a regular integer.
> > > > 
> > > > Yes, this is useful. But no it's not that useful, how could you use that
> > > > to read another CPU's stack during some debug functions in a way you
> > > > know it's racy?
> > > 
> > > That's a pretty difficult thing to do, because you don't know the
> > > _layout_ of the other CPU's stack, and even if you do it's going to be
> > > changing underneath you without locking.
> > > 
> > 
> > It's a debug function, I don't care whether the data is accurate, I just
> > want to get much information as possible.
> 
> yeah, if you just want the typical backtrace functionality where you're
> just looking for instruction pointers - that's perfectly
> straightforward.
> 
> > This kinda of usage, along
> > with cases where the alorigthms are racy themselves are the primary
> > reasons of volatile _accesses_ instead of volatile _types_. For example,
> > you want to read ahead of a counter protected by a lock:
> > 
> > 	if (unlikely(READ_ONCE(cnt))) {
> > 		spin_lock(lock);
> > 		int c = cnt; // update of the cnt is protected by a lock.
> > 		...
> > 	}
> > 
> > because you want to skip the case where cnt == 0 in a hotpath, and you
> > know someone is going to check this again in some slowpath, so
> > inaccurate data doesn't matter.
> 
> That's an interesting one because in Rust cnt is "inside" the lock, you
> can't access it at all without taking the lock - and usually that's
> exactly right.
> 

(Now you mention that, once I was trying to construct a deadlock case
with some Rust code, but I couldn't since the locks are naturally
hierarchical because of the types, therefore it's impossible to reverse
the lock ordering. Yes, you still can have deadlocks in Rust, but that
hierarchial type trees really help a lot).

> So to allow this we'd annotate in the type definition (with an
> attribute) which fields we allow read access to without the lock, then
> with some proc macro wizardry we'd get accessors that we can call without
> the lock held.
> 

Right, that's field projection:

	https://internals.rust-lang.org/t/pre-rfc-field-projection/17383	

> So that probably wouldn't be a Volatile<T> thing, that'd be coupled with
> the lock implementation because that's where the accessors would hang
> off of and they'd internally probably just use mem::volatile_read().
> 

So we can play the type game as deep as we can, and I'm sure it'll be
helpful, but in the same time, having a reasonable
{read,write}_volatile() semantics on UB and races is also what we need.

> > > So the races thare are equivalent to a bad mem::transmute(), and that is
> > > very much UB.
> > > 
> > > For a more typical usage of volatile, consider a ringbuffer with one
> > > thread producing and another thread consuming. Then you've got head and
> > > tail pointers, each written by one thread and read by another.
> > > 
> > > You don't need any locking, just memory barriers and
> > > READ_ONCE()/WRITE_ONCE() to update the head and tail pointers. If you
> > > were writing this in Rust today the easy way would be an atomic integer,
> > > but that's not really correct - you're not doing atomic operations
> > > (locked arithmetic), just volatile reads and writes.
> > > 
> > 
> > Confused, I don't see how Volatile<T> is better than just atomic in this
> > case, since atomc_load() and atomic_store() are also not locked in any
> > memory model if lockless implementation is available.
> 
> It certainly compiles to the same code, yeah. But Volatile<T> really is
> the more primitive/generic concept, Atomic<T> is a specialization.
> 
> > > Volatile<T> would be Send and Sync, just like atomic integers. You don't
> > > need locking if you're just working with single values that are small
> > > enough for the machine to read/write atomically.
> > 
> > So to me Volatile<T> can help in the cases where we know some memory is
> > "external", for example a MMIO address, or ringbuffer between guests and
> > hypervisor. But it doesn't really fix the missing functionality here:
> > allow generating a plain "mov" instruction on x86 for example on _any
> > valid memory_, and programmers can take care of the result.
> 
> You're talking about going completely outside the type system, though.
> There is a need for that, but it's very rare and something we really
> want to discourage. Usually, even with volatile access, you do know the

Hey, in memory ordering model areas, we are supposed to work on these
rare cases ;-) These are building blocks for high level synchronization
constructions, so I'm entitled to complain ;-) But yes, to your point,
type system can help a lot, however, there are still cases we need to
roll our own.

Regard,
Boqun

> type - and even if you don't, you have to treat it as _something_ so
> Volatile<ulong> is probably as good as anything.

