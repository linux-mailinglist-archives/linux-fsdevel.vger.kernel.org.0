Return-Path: <linux-fsdevel+bounces-15264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9D88B44C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 23:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8131C3D0E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0176C68;
	Mon, 25 Mar 2024 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYcWYvSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BB71732;
	Mon, 25 Mar 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406349; cv=none; b=gmmzO7ImxVtX7Yxm8ci3848PN4o6byXlLLu3BCimVnmc/o+hhjKTeg9fIYz6VGtcTNcZFhgJYSfTWU37FesitbAXfE3xmNcjbDLJ6rKoghEQKSwIKeDU/gqj9cVoU3zJ8lTEWublNRIaFZNmFuYRZIBBLCUlyvsMDjEfdvqNklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406349; c=relaxed/simple;
	bh=NdFZOSJ8XxzUKMEBRJR0MRnnOcBj20+zcY1Zl5G0cA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohKw8Pt6LlhLMbgtvcW9FfHFhOrwSPXsE9es7a765rOirABfhHRLySAEEEM5r9CyWrjmyJCk4gAptQK0CcV58i53AlP6jhkgHhcAw7bCpufAyiQQI6wrMKDJXwIWofaLyCDF6uHalNuH4GW9iqtXsGpQkqLI4g0zjPC9DlS9c/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYcWYvSh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so4682779276.1;
        Mon, 25 Mar 2024 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406346; x=1712011146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqLcZpfFx6aJ4RsnMU0gGS++kj6ptNsIBWGAoEw1/x4=;
        b=GYcWYvShYJdhABrE+9IFEfkg1mnnEonzO3D5VhH3gUkf1vmsvAaaAD9kTgXTv++o0/
         Jv8biXlJXqgyWj76DNLNUF76cgQTTLJElLypzAi45JRdr5uCt89bdUWCfPgLHfOtJSQR
         p7V8Y6y/ZB3RVbGLUqNdMpZGNPt/z64VUaK8kDvz+ysIOjTvjo4scvzADz23mAT2hP5t
         y4BwSMufYF+3G5S/mZuawY9+YF0r16KuCt7Bt9/b9NVtR6Oh3THvNN/91VW0mhJnw3RF
         YLm5rMRfOG5lOBIx2mqPMgfGLDfEdbcGMG/4agRaC3ohWvTXwMMYjGF9RzO0Gco6QwzU
         5vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406346; x=1712011146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqLcZpfFx6aJ4RsnMU0gGS++kj6ptNsIBWGAoEw1/x4=;
        b=YVZS6eYPcBaCrq7iGz3+NT9ApgGK1mQ3s4SX7rKDKKLShJRTzJkFeFQEfWal2Z14HY
         vuclmzFSCXCXj8F6KEv18wJ4KwNJs2l7r6KlNIvlPI2pMUTOc4SXqf5xxVBk0plm5vYW
         1CxT7RCpDI8TiuqSpWG6tZOKxmxSixAg/VVrXF+nrvTnpzTmvuH21ydra86tYhCJKz3S
         43rCA23N0v2eoQ1VacjTYqx3PLIYQfEzrIAp2TboEvGKZ9gBESTeCxkrdsPFn7VC2+yt
         X1u5uzABLnmuNpkO44q4tfqGOi8o7U0zsDRKIhfnJXkOtjt9PIZL04Ush+U5NBQjpxG/
         msDg==
X-Forwarded-Encrypted: i=1; AJvYcCXerYjFYH0Lo5ahyM+7DRrATq+f3o54Y/wddocPBh5+ahsVpqs/I92vyQFCZBCaH/e/Ke5uiul8tzwLciSiUrWlyJTrOrHXFZo/4Wjwv5KltYL2i0xCb1fjG9mZJfuHMuEcppm755FdMrHiYk8YcaFusdcEuJtjTvdJINdxXzdJfqncirXerbJfllgfQoTDzSKgT9wkIjD9BTl7ey/qR6rT31X+SLUAKQ==
X-Gm-Message-State: AOJu0YxqKrcc+ExCRIqXkL4tMYGumQXmKwAoki2Px63nOSNNiRJRHbvi
	JYZc6xeYn4CREcQHUHgiqlSnqopA4z/vfB5Fl2OjyahZP9lESP3dbuTEbSc042Q=
X-Google-Smtp-Source: AGHT+IH3T67VWUI4TBUfClcieBCpVxYsnEW19lJIDeWsn1YqrxvgYKauhlG9YQbW/4ViSpj7DUfkpQ==
X-Received: by 2002:a25:dbcb:0:b0:dcb:dd25:74c4 with SMTP id g194-20020a25dbcb000000b00dcbdd2574c4mr1167520ybf.52.1711406346402;
        Mon, 25 Mar 2024 15:39:06 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a17-20020a0cc591000000b006904d35e1c6sm3964406qvj.58.2024.03.25.15.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:39:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id F1A9E27C005B;
	Mon, 25 Mar 2024 18:39:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 18:39:05 -0400
X-ME-Sender: <xms:B_0BZr8oNOydZ58XwHHzBCWLcMpH0tYL06dIuggok72BI0Vi1Debyg>
    <xme:B_0BZnsP2-hQ8qbEWZl5GgimOUQ3tKUB8okLz5Nvzxwkua4qdnWvpRd10wo_s1TN6
    YN2GrAfkRcOZwjTqg>
X-ME-Received: <xmr:B_0BZpBx8tvqddyCuTKQ5xnwc1QVJ8T4fOUm17Snfhd8Rxa9H4yNgVFEK1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeeihedv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:B_0BZncm5U0EMh8nRyaL-qV2TGBUswboaVvDkttp5Nkd4LBTpt0LSQ>
    <xmx:B_0BZgMPGO9EVMPqnhj1f_0ljqhk3xcnDJKLnChqXUUQ6tEcKOxYHQ>
    <xmx:B_0BZpmyZVwHUrNAQI_8BO4b4_Opz8iwfXJA2SvgMMEBS6uukhPp0A>
    <xmx:B_0BZqsSbHvRuTPsqSjJlKJlHK_DM3Me1cOya0iMwbBBd-FzpEOPKQ>
    <xmx:CP0BZhIpyp1iLLNP0C1RHxFzknooQKg7GUyOvLbirpz0Ef8vlh9ddiWHuAk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 18:39:03 -0400 (EDT)
Date: Mon, 25 Mar 2024 15:38:32 -0700
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
Message-ID: <ZgH86EUON30lUk6m@boqun-archlinux>
References: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>
 <ZgHuioMM1cAWNDiX@boqun-archlinux>
 <jyijwrrzzhlsrffj37xj4sskipxqbxfewydnb3yzgybjobj6tg@cbv5y7znhm3n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jyijwrrzzhlsrffj37xj4sskipxqbxfewydnb3yzgybjobj6tg@cbv5y7znhm3n>

On Mon, Mar 25, 2024 at 06:09:19PM -0400, Kent Overstreet wrote:
> On Mon, Mar 25, 2024 at 02:37:14PM -0700, Boqun Feng wrote:
> > On Mon, Mar 25, 2024 at 05:14:41PM -0400, Kent Overstreet wrote:
> > > On Mon, Mar 25, 2024 at 12:44:34PM -0700, Linus Torvalds wrote:
> > > > On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > To be fair, "volatile" dates from an era when we didn't have the haziest
> > > > > understanding of what a working memory model for C would look like or
> > > > > why we'd even want one.
> > > > 
> > > > I don't disagree, but I find it very depressing that now that we *do*
> > > > know about memory models etc, the C++ memory model basically doubled
> > > > down on the same "object" model.
> > > > 
> > > > > The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> > > > > with modern thinking, just done with the tools available at the time. A
> > > > > more modern version would be just
> > > > >
> > > > > __atomic_load_n(ptr, __ATOMIC_RELAXED)
> > 
> > Note that Rust does have something similiar:
> > 
> > 	https://doc.rust-lang.org/std/ptr/fn.read_volatile.html
> > 
> > 	pub unsafe fn read_volatile<T>(src: *const T) -> T
> > 
> > (and also write_volatile()). So they made a good design putting the
> > volatile on the accesses rather than the type. However, per the current
> > Rust memory model these two primitives will be UB when data races happen
> > :-(
> > 
> > I mean, sure, if I use read_volatile() on an enum (whose valid values
> > are only 0, 1, 2), and I get a value 3, and the compiler says "you have
> > a logic bug and I refuse to compile the program correctly", I'm OK. But
> > if I use read_volatile() to read something like a u32, and I know it's
> > racy so my program actually handle that, I don't know any sane compiler
> > would miss-compile, so I don't know why that has to be a UB.
> 
> Well, if T is too big to read/write atomically then you'll get torn
> reads, including potentially a bit representation that is not a valid T.
> 
> Which is why the normal read_volatile<> or Volatile<> should disallow
> that.
> 

Well, why a racy read_volatile<> is UB on a T who is valid for all bit
representations is what I was complaining about ;-)

> > > where T is any type that fits in a machine word, and the only operations
> > > it supports are get(), set(), xchg() and cmpxchG().
> > > 
> > > You DO NOT want it to be possible to transparantly use Volatile<T> in
> > > place of a regular T - in exactly the same way as an atomic_t can't be
> > > used in place of a regular integer.
> > 
> > Yes, this is useful. But no it's not that useful, how could you use that
> > to read another CPU's stack during some debug functions in a way you
> > know it's racy?
> 
> That's a pretty difficult thing to do, because you don't know the
> _layout_ of the other CPU's stack, and even if you do it's going to be
> changing underneath you without locking.
> 

It's a debug function, I don't care whether the data is accurate, I just
want to get much information as possible. This kinda of usage, along
with cases where the alorigthms are racy themselves are the primary
reasons of volatile _accesses_ instead of volatile _types_. For example,
you want to read ahead of a counter protected by a lock:

	if (unlikely(READ_ONCE(cnt))) {
		spin_lock(lock);
		int c = cnt; // update of the cnt is protected by a lock.
		...
	}

because you want to skip the case where cnt == 0 in a hotpath, and you
know someone is going to check this again in some slowpath, so
inaccurate data doesn't matter.

> So the races thare are equivalent to a bad mem::transmute(), and that is
> very much UB.
> 
> For a more typical usage of volatile, consider a ringbuffer with one
> thread producing and another thread consuming. Then you've got head and
> tail pointers, each written by one thread and read by another.
> 
> You don't need any locking, just memory barriers and
> READ_ONCE()/WRITE_ONCE() to update the head and tail pointers. If you
> were writing this in Rust today the easy way would be an atomic integer,
> but that's not really correct - you're not doing atomic operations
> (locked arithmetic), just volatile reads and writes.
> 

Confused, I don't see how Volatile<T> is better than just atomic in this
case, since atomc_load() and atomic_store() are also not locked in any
memory model if lockless implementation is available.

> Volatile<T> would be Send and Sync, just like atomic integers. You don't
> need locking if you're just working with single values that are small
> enough for the machine to read/write atomically.

So to me Volatile<T> can help in the cases where we know some memory is
"external", for example a MMIO address, or ringbuffer between guests and
hypervisor. But it doesn't really fix the missing functionality here:
allow generating a plain "mov" instruction on x86 for example on _any
valid memory_, and programmers can take care of the result.

Regards,
Boqun

