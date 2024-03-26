Return-Path: <linux-fsdevel+bounces-15275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3288B7B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 03:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13971F39D76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 02:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC1129A8D;
	Tue, 26 Mar 2024 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgRVmiR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FCD128392;
	Tue, 26 Mar 2024 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421478; cv=none; b=KQqhNg+/DSruGz+Y46b9fO1GSNIVUEaWs+BEyw3ffBfSwm0f8Z/36RFo/HqZECdln0wIMVhP9ewJ0mYg/nyXIxjPfnDxmb6UAtEkrqBqJfpHZ/zG/+U+bOuy8k04wgctsAfKb71MCI451jDb0Re8HpiB1H53uAeK11eaorHjPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421478; c=relaxed/simple;
	bh=N5UUxAKoTPcBjWK+QOUVolTBhb8j694WCAv1Ly4a9d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5tMG7x0fHI0PfYHO0UTIpL4dweMwpCNmjLWypEVR0cVDiTJcmcfUXvYQL6ipBSEgpuLVdxHhSQHqYKhfx+DM7Kp33pLF0jFRW7di8NsjTUZyUimaWgWoHgCg98FzrcwnkL9RHisn7UHqFyQKhJata2X6f8z8O4KsJ3cLeQImSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgRVmiR3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-789db18e169so390188585a.1;
        Mon, 25 Mar 2024 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421476; x=1712026276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcNhvrzgAeTv+RtaHHdMdJGRePwYOV19cay72dN5zG0=;
        b=AgRVmiR3D9mf+k/NIj7NXanJ7ArXrV15PnMeE+XYF7mcljRYdW1oRo/62fH5xlVOi2
         62ZwhmqBWXuF064QyMpofaqV3O+SAMnR28Q4F2YRRRxuAoGRke5Kwn/K1FGbLpaAxFqB
         LP383lgMqVmmxIlv+bXPMkU/na6aXv+eGCN6qbT+ft2e+L1IUBd0UCLonN0tduEFYnjQ
         qK91OCpohVl1OCiLL2Q/UJiCylRks1wiulToJO+DPOmifF7COeY1v3ihjHr5GQ0+UeEv
         NmjEqM6fP030GmlNEC2l5t966WR+oFUCDGkR8tPlzRl52dO4o72axc7F57ja+qVfWxuN
         urwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421476; x=1712026276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcNhvrzgAeTv+RtaHHdMdJGRePwYOV19cay72dN5zG0=;
        b=blgRtuiA4rhqJ1mFlqsNBZR3BI/PApnZVCzIl+KNHazfxJ7YdODOtup9TAWAk9cBzp
         rL581AhhS6Eh9B2cXTxncaY6i6PIxBo2twCaRuRg0urNBUHxfEfkQwbzJ1GIV0NTw93F
         vMQAkpi3zAzdCBEQcz/U7mqN6ZOnBVEOnicz35ejGP5l/hQvz4W2Wrk+yXeNOLpYiLB6
         5sjCNthrgiVZ3UCc8nEGlrpmuDW1D/FBtnoPZCzgFAm5VKVIB5bHqJqOx9xdEaIKYpMy
         d78lefI+I+1Ai7/1lyaciiyph3Artz7DZT+q2sAPnfSJMgzfThJkKvdnmHgl9gw/4DeO
         RnUA==
X-Forwarded-Encrypted: i=1; AJvYcCUnKONaU6Nu8smKLOfS4ezzEDblRm2lstaanyoq9Rfr2iR6uQypaAhJFhY6i2aZaYLuMEvQcw0E5K71+z2ibMInmob5C44jNUjnfq5wvpmVzIgFp7iW2ET1SDS/DFqagRmGw66vCf0RxLYrK2KAD+T6DepForZulefbUCsW46K+e/4BxCmDpq0SRHT05oSsvkwea+ZAob14JGHq9tAk7pR3THTEZKhZkg==
X-Gm-Message-State: AOJu0YyLq8fi13jBwHD7FOf5Xot+UygwCeTENjP+zwpx78prsCT8peGe
	5KO1wERCLwpfDilLep4k7WTho/Ya/C2DGdJ2Blb4a2yIgEyjAj+Y
X-Google-Smtp-Source: AGHT+IFDSXtUV4AQwiSzsedITS1Ks+VU5H+aA+IrwzXY0yARA6zx4+/SmU8LSwuDkN0+4uIvx/tnYA==
X-Received: by 2002:a05:620a:1d99:b0:78a:45b9:c96f with SMTP id pj25-20020a05620a1d9900b0078a45b9c96fmr8386956qkn.59.1711421476022;
        Mon, 25 Mar 2024 19:51:16 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id f23-20020ae9ea17000000b00789e800c204sm2642313qkg.62.2024.03.25.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 19:51:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6C02F1200032;
	Mon, 25 Mar 2024 22:51:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 22:51:14 -0400
X-ME-Sender: <xms:ITgCZq0KMEEsDawHXZdKnL8n4WUCu3oJXr-g9e8bQ51FudtBKjmfDA>
    <xme:ITgCZtEVfhDHXly_ppW_xP0-FeKwM-fdfQ-EUyNRzOxFgEuCgU2crtIt7c8Mn_sx3
    UbnWWtNEBsZqgIboQ>
X-ME-Received: <xmr:ITgCZi5oVZ8ki9DHasrqwtZTEfQuziED9fPOcZhFon2BnRtBiS1axksDFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvudfgheeikeehiedugfdugfegjeegvdelteeffeejfefgkeduteekgfev
    keeitdenucffohhmrghinhepthhrvggslhhighdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ITgCZr0bQsaUqYUNd0feuVjVTTA008glsjcyqMC3K9VCveZqZ7ViQw>
    <xmx:ITgCZtFhkYNIORHDvgCfcXQZdxGp48exRrJ-Dky0Ak6tT5Vi9Ega4w>
    <xmx:ITgCZk8IW44RemklT6gJdGIXTGObj6V8Ru7piiqQbosIXr3uEBZVLA>
    <xmx:ITgCZikVqwPyizH1Xengv-x1mKi2OOHJfx1tpfj87r72bZIGR3ihvw>
    <xmx:IjgCZpAbMxss07kt1nC5b-UgIevPlKplkZZEdun6Pl8MpEEgIA_B-LEV6sqVb7xO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 22:51:12 -0400 (EDT)
Date: Mon, 25 Mar 2024 19:51:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
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
Message-ID: <ZgI4H8AMc3TAlEag@Boquns-Mac-mini.home>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgIRXL5YM2AwBD0Y@gallifrey>

On Tue, Mar 26, 2024 at 12:05:48AM +0000, Dr. David Alan Gilbert wrote:
> * Linus Torvalds (torvalds@linux-foundation.org) wrote:
> 
> <snip>
> 
> > IOW, the whole access size problem that Boqun described is
> > *inherently* tied to the fact that the C++ and Rust memory model is
> > badly designed from the wrong principles.
> > 
> > Instead of designing it as a "this is an atomic object that you can do
> > these operations on", it should have been "this is an atomic access,
> > and you can use this simple object model to have the compiler generate
> > the accesses for you".
> 
> Isn't one of the aims of the Rust/C++ idea that you can't forget to access
> a shared piece of data atomically?
> 
> If you want to have 'atomic accesses' explicitly, how do you tell the compiler
> what you can use them on, and when it should stop you mixing them with
> normal accesses on the same object?
> 

Well, you can just wrap it in your own atomic types, can't you?

If the atomic primitives that a language provides is access-based, users
can create their own atomic types or language can provide via standard
library, but mixed usage is still allowed when it makes sense (debug
functionality, low level concurrent code that utilizes races, etc.) But
if the atomic primitives that a language provides is type-based, then
you're limited to what you can do. It might be totally fine as Linus
pointed out, if you just write a portable library, and don't want to
care about architectural details. But that's not the case in Linux
kernel.

Regards,
Boqun

> Dave
> 
> > This is why I claim that LKMM is fundamentally better. It didn't start
> > out from a bass-ackwards starting point of marking objects "atomic".
> > 
> > And yes, the LKMM is a bit awkward, because we don't have the
> > shorthands, so you have to write out "atomic_read()" and friends.
> > 
> > Tough. It's better to be correct than to be simple.
> > 
> >              Linus
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

