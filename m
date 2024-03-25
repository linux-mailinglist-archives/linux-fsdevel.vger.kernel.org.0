Return-Path: <linux-fsdevel+bounces-15262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8A88B2EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC4F1F39483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACED6EB6B;
	Mon, 25 Mar 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBFqJqYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A76DCE8;
	Mon, 25 Mar 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402671; cv=none; b=lJyi3VVQTk6FkOOZoGGhKT2pt3C1oEckcVf+KKtP/zZt5PxS0ZNr9jI29ZJPoKqgo0pjlboyTbsohqjC3oe49HFLBD+x/sNUHHYXmicyWkfywbcVjLej7i8gX1iEu2wwGLX3jeGuMnTc3+g2wdmdFap41DsCCayURV1+PW4BUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402671; c=relaxed/simple;
	bh=PgOCH9l5+TRsC10l8LRgnziKoXQSiBkFJFUbjNNqzk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9MUc2Nd5emeGCJYFgPHsQpP+Rb1eynPOO1KTaZIgC8798RjTuRvEWItQCTZvY6LPxZ/Rp72kguVLF5a3kB/arJ8Gtt9IsKK1nLrYo37pilfYYb5I0GtF19x+2zdOGt3s4pOqAYQrhUg4DW512GJQk2Y94stt+IglyT3ETbVG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBFqJqYE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78a60d10eeeso11431285a.2;
        Mon, 25 Mar 2024 14:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711402669; x=1712007469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXvJB4PTr9BnmGHzkolraHMPsM/PHcpz2o1jxgX00Cw=;
        b=XBFqJqYEen7qk6aWg+ASrMe81Dn46lHPHArC7OdpPDrDxQTUpznk4rC2o9bpqujJxi
         H0NIiQvZjKZLEUjSTfxRYKHQRJ5YKbN/Hqlh5p8dS/917BMANu7hxhWpwBWuFjpTpT/p
         M/IdXKThva3YXFN+arfNAIYUggj6qnk41fW/I1OSz+gDJcdsC/knl0Mf1gyQrrS2x/dH
         IBCT3fqo0HPITkInvfGWN4REPCZLDTnHXdRQ3gcJbzhMqRbGR8xF10d3d8rC0RCJbRly
         61eFFXTTY8iphaCgfqXsyU9DBiGtu3g4KMKGqoJDEgHfaPmL5CtcKeP2bw4l+jkyxAwL
         Nbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711402669; x=1712007469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXvJB4PTr9BnmGHzkolraHMPsM/PHcpz2o1jxgX00Cw=;
        b=CvJ0sqLtRx5BYjxjaA/Vb9/kEAIKq+x3krGvhqy3QAQBPDB6Pug5Xv7DxTiRb1kIw7
         w3q+AYEWDHtUlQU6VCTxSfbHyxHNIsTzf6sx0BA6xXViag1IwOKvEIP+oM6EWn9p5PdJ
         GM4vq4rM4PbdzGnV8VcLrRKJ0F430+dR/BlJOeZ9gk7c8ba9/qZB8FZgGHC30zbBrsZi
         KHtilwKRbBiLEDurfIDXNVkZhV6Lq7JVa6Ri2ftHVza4bURtOpfAv9qc5ZTYjIydwYxL
         6j/oiH+m7zYgUXS399MF2fpJaqKvF50cbmRXbXEcWgBKaHJ/jqRwaIlNAvjzsRkN1ujJ
         fAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqzPZQ/ClV/44XxC0e0YOUpIwgBow8hK1YJjtgpoarvfBX9nI85dJDpwr/ZfSloN5xdWtcExqFGBxccep6zcpcUEnLzH93X5TUMBG2JTAdAtl1CJy2RHU6JhHaMzMYRHgLufm8VWSMTXtXGTKhrOOHyVERjaSwZBbbVE9MT1D5oA8QWOHhKZXDEcuJnSmeKpYal3M9zQcJGgV3oQR6B4CGaq1teRjZYg==
X-Gm-Message-State: AOJu0YweoX9jVwrgv7cIOuaLVW+SeoQXiDkUbINY2UJlD8G+X/6xZDId
	ca3yV/rMFOdbf/P1moBMSIIH+P3ny8+JfexyiofVbSqXBfzN9oTC
X-Google-Smtp-Source: AGHT+IEcUMc58g6IuQ5hGxe8QG2RU/su4immaoKU7ZFPkQningk7dx0ah1v7u/eFIaHFnL28zDZMRA==
X-Received: by 2002:a05:620a:2211:b0:78a:5c11:e7ac with SMTP id m17-20020a05620a221100b0078a5c11e7acmr2588111qkh.40.1711402669111;
        Mon, 25 Mar 2024 14:37:49 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id v25-20020ae9e319000000b0078838c7acbfsm2467972qkf.42.2024.03.25.14.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:37:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 43A091200032;
	Mon, 25 Mar 2024 17:37:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 25 Mar 2024 17:37:47 -0400
X-ME-Sender: <xms:qu4BZlGOBTyWu7Dm1mRElVpr_IQ4pvUPZNeOqb3ggCcS-j7ILEcLmw>
    <xme:qu4BZqV63EQdf5ttV_Mq4yH6BCr9l5skTwQpFkTxrlQMzlfgBhIS1jeCQibQv_-g0
    8cg_MPCCk1aBBJ1YA>
X-ME-Received: <xmr:qu4BZnLOjIVGctxBnJUPJnM_MI7E1JOoecqG0s1OHb-GmzEI_MD3gXhaT1cisw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qu4BZrG-adCHNdN4YCDOP5gylybW4a10IkuCxv8aHEj5SZ4dpx7cVA>
    <xmx:qu4BZrX7yEMdMz-M-Q7OUOMHtZ3X8exfN5xQgSBX3wey4zrP5fecxg>
    <xmx:qu4BZmNmevCFcpQ5uZzPzmvvFNJohraes22V-_AGu6C6_DpWuYQ4hQ>
    <xmx:qu4BZq0b_As1FQ1MKs9TLC5sP8h8X0HqlkaSXF0Of6rqON-17HazTA>
    <xmx:q-4BZlxQqOP3gmLPWbdoM_wjwsOYJEbLNLhea_z9DAvqfANN-3_m6hDMC8BLHDvs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 17:37:45 -0400 (EDT)
Date: Mon, 25 Mar 2024 14:37:14 -0700
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
Message-ID: <ZgHuioMM1cAWNDiX@boqun-archlinux>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>

On Mon, Mar 25, 2024 at 05:14:41PM -0400, Kent Overstreet wrote:
> On Mon, Mar 25, 2024 at 12:44:34PM -0700, Linus Torvalds wrote:
> > On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > To be fair, "volatile" dates from an era when we didn't have the haziest
> > > understanding of what a working memory model for C would look like or
> > > why we'd even want one.
> > 
> > I don't disagree, but I find it very depressing that now that we *do*
> > know about memory models etc, the C++ memory model basically doubled
> > down on the same "object" model.
> > 
> > > The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> > > with modern thinking, just done with the tools available at the time. A
> > > more modern version would be just
> > >
> > > __atomic_load_n(ptr, __ATOMIC_RELAXED)

Note that Rust does have something similiar:

	https://doc.rust-lang.org/std/ptr/fn.read_volatile.html

	pub unsafe fn read_volatile<T>(src: *const T) -> T

(and also write_volatile()). So they made a good design putting the
volatile on the accesses rather than the type. However, per the current
Rust memory model these two primitives will be UB when data races happen
:-(

I mean, sure, if I use read_volatile() on an enum (whose valid values
are only 0, 1, 2), and I get a value 3, and the compiler says "you have
a logic bug and I refuse to compile the program correctly", I'm OK. But
if I use read_volatile() to read something like a u32, and I know it's
racy so my program actually handle that, I don't know any sane compiler
would miss-compile, so I don't know why that has to be a UB.

> > 
> > Yes. Again, that's the *right* model in many ways, where you mark the
> > *access*, not the variable. You make it completely and utterly clear
> > that this is a very explicit access to memory.
> > 
> > But that's not what C++ actually did. They went down the same old
> > "volatile object" road, and instead of marking the access, they mark
> > the object, and the way you do the above is
> > 
> >     std::atomic_int value;
> > 
> > and then you just access 'value' and magic happens.
> > 
> > EXACTLY the same way that
> > 
> >    volatile int value;
> > 
> > works, in other words. With exactly the same downsides.
> 
> Yeah that's crap. Unfortunate too, because this does need to be a type
> system thing and we have all the tools to do it correctly now.
> 
> What we need is for loads and stores to be explict, and that absolutely
> can and should be a type system thing.
> 
> In Rust terminology, what we want is
> 
>   Volatile<T>
> 
> where T is any type that fits in a machine word, and the only operations
> it supports are get(), set(), xchg() and cmpxchG().
> 
> You DO NOT want it to be possible to transparantly use Volatile<T> in
> place of a regular T - in exactly the same way as an atomic_t can't be
> used in place of a regular integer.

Yes, this is useful. But no it's not that useful, how could you use that
to read another CPU's stack during some debug functions in a way you
know it's racy?

Regards,
Boqun

