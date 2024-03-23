Return-Path: <linux-fsdevel+bounces-15149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B518876A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 03:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801441C22A13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 02:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C83FC7;
	Sat, 23 Mar 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFLeXa/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBFEC2;
	Sat, 23 Mar 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711160796; cv=none; b=LZ2P2Ca860WbIdtkbC4nklRNLxnZhMZSg0Kx5+6IWzOuJ/Io30zHmeYKofaSyd2Jhjr9LkekmvG/Im/I0ibXSDVJgD9Gzt4sgJTu4V+hOhPk3wl/wCDR0RkUQ7uPFzc4RXiraO8oPnBXcQwSqK4jIEYd2IkhVL5LWBPNseP/T4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711160796; c=relaxed/simple;
	bh=GLL8pdx2fKWkkU8matEFO89Wac2DtH6pOejmSxXEEII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xovbd3Xw/LInxQez58KVwCBrjx4IyyOtNDz0A7cQEORffKccgLVpAzZOcv1bobxkWMJrK7iIVXaaOkD6FvPlvbTKXi+HZyBk6GUKCNArGfFS5MCH7cUolk/XLNimD+bImzph8xoXkLh5C+3bGWgR7FsjXUYa2MXvcvSwJ1LRanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFLeXa/V; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69185f093f5so20833536d6.3;
        Fri, 22 Mar 2024 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711160794; x=1711765594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXWJvJZ+9VsV3RQHdz7GElkYKlzfacUvA+hl5w+A2pc=;
        b=TFLeXa/Vgbvs2KE/kqx4dAhFjmJA+wGNsmCklY4RRhvEE5pLwcam3yGSNBYHjE5EPo
         CjTGQnTNgDElp265W/hrIQdRoFnF1dh8J7YzBV2jtOohJe1R3LIxz9ZaXTzsCrURhFua
         GKqT7ihXHIGEVuQ8iG6kgCjC+XHqiwiAvGwLAbyv5a3JjAWeVgCdUBu3qm57mBdmmkRI
         AMmqCOYKHZeVe7RhtCVwAonS3QqK15bbUsqbk51zEqWKth1WcXZieTED/qTsUpRURI3A
         F5Li7kRGvjaQ77yjwIMp3CB0PsytNrcSRT0fWOZC0HUlyhsQXU6+HKI4VlkVaEISYkKK
         4uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711160794; x=1711765594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXWJvJZ+9VsV3RQHdz7GElkYKlzfacUvA+hl5w+A2pc=;
        b=rgMikKNn2fJ+0zfBvXMUg12eOb2QdHL7S5y09eQ5vXl4SBpdwZKivWIxdqQPTTQ4EP
         nxl5ZnuBjWSt9W36xlBjEju2CtnEnaBa/CfD2K5bwpgH8r8bEqsCDrfG/vk063rtjd7H
         Mp8FVejALCfl47TK+IgUJHp5ujFuoASIfdfFOYHNyQdc+ykFO5k+LZpUxwxj3lBLdRTw
         TDf5PHd+DdcHl0u55R9y/a42wuHdWUpBmiAeGZlzQhdVUPMkUXNYbFOiy60Vdwt64TGG
         aL5e1eujzIbt2fKRSBDih2mJuM4gk6yvOXWitLy3rSnh2bvvvglt/5TFLwHV48XsT+n2
         lCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdB3BLBsU9PaWuZM6tkSEgOeWhyKN6ivFSQe4yvhAIsumQV7KbFdmSp6OFkx/bi+3qyUPD0fayScxaeJ1EooHX2rMwcuMsXn5tSZ21pds0yXtH0X5iqxf84VsHFXQPVtTbeaa4muJXkr1Yt2BlmHRFlJrZ4NA1U0nBwCpzCZTUp9IpHG0xm4360QfT9iALmvEeLHKEZZNCXuOVgRytjtH6YubY6MEAow==
X-Gm-Message-State: AOJu0Yypr8Tl0RifplFSKoZI+YKETh5gsIqNO5/WjELV2myBTghI3ssm
	LmFtYdLe3Ws1Z47133cBM4+x2UN0E1XQKcs0pL0tDiNkWWachf0x
X-Google-Smtp-Source: AGHT+IHRua83/etcjWUTeOkd74S4PqwJUvYuzFevBWbUwWMqvkHnncpQsqfVM6o+HXolWLggxGI6EA==
X-Received: by 2002:a05:6214:2522:b0:690:ca82:55f7 with SMTP id gg2-20020a056214252200b00690ca8255f7mr1378038qvb.19.1711160793765;
        Fri, 22 Mar 2024 19:26:33 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id jo14-20020a056214500e00b00696769860ffsm463893qvb.99.2024.03.22.19.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 19:26:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5A8DD1200066;
	Fri, 22 Mar 2024 22:26:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 22 Mar 2024 22:26:32 -0400
X-ME-Sender: <xms:1j3-ZWzf5lR6OxV05ZR1mSq0pV-GAvirWngolPFptk0BOuwg4P7fkQ>
    <xme:1j3-ZSRFjnoxaYR5MEENA4xuzmt6rcddBKthfhnBNRfgKlmLQCSC_dVBQbTy4jW3W
    IBLKTT_bu28n2BVmA>
X-ME-Received: <xmr:1j3-ZYUgQu3tldYwPIx39K8GzHMVQp7ezkgee4nuL4-LjSjijB3_VynCZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1j3-ZcjC3gNwlgacNAFmMWAJYH63qalSm4dmMrElmq4YVIGXEvhDcw>
    <xmx:1j3-ZYBjfAWTpRhtIgxaKKToq1FLImAvOxelRxALqSGCeDfhIaWKVg>
    <xmx:1j3-ZdL5QVIqYIiMHdswvFn6f3xXO3fud3JkPoitOCWx-BBa3ONgtA>
    <xmx:1j3-ZfCbvyixf8Ii8JxNE2ccipzdt8Di-9VLpFfkEb_pi0pHud_oEw>
    <xmx:2D3-ZdBC0z3U7khBtzDYpd95D4-_vPWGCDyLjYL-Xm0ACfuhS-VKCbvj4TIo5N_->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 22:26:29 -0400 (EDT)
Date: Fri, 22 Mar 2024 19:26:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
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
Message-ID: <Zf491DuptReGqvfd@Boquns-Mac-mini.home>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <3modld2dafaqjxa2b7jln47ws4ylzhbsvhvnphoklwvzange5p@wlir7276aitp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3modld2dafaqjxa2b7jln47ws4ylzhbsvhvnphoklwvzange5p@wlir7276aitp>

On Fri, Mar 22, 2024 at 10:07:31PM -0400, Kent Overstreet wrote:
[...]
> > Boqun already mentioned the "mixing access sizes", which is actually
> > quite fundamental in the kernel, where we play lots of games with that
> > (typically around locking, where you find patterns line unlock writing
> > a zero to a single byte, even though the whole lock data structure is
> > a word). And sometimes the access size games are very explicit (eg
> > lib/lockref.c).
> 
> I don't think mixing access sizes should be a real barrier. On the read

Well, it actually is, since mixing access sizes is, guess what,
an undefined behavior:

(example in https://doc.rust-lang.org/std/sync/atomic/#memory-model-for-atomic-accesses)

	thread::scope(|s| {
	    // This is UB: using different-sized atomic accesses to the same data
	    s.spawn(|| atomic.store(1, Ordering::Relaxed));
	    s.spawn(|| unsafe {
		let differently_sized = transmute::<&AtomicU16, &AtomicU8>(&atomic);
		differently_sized.store(2, Ordering::Relaxed);
	    });
	});

Of course, you can say "I will just ignore the UB", but if you have to
ignore "compiler rules" to make your code work, why bother use compiler
builtin in the first place? Being UB means they are NOT guaranteed to
work.

> side we can obviously do that with a helper; the write side needs
> compiler help, but "writing just a byte out of a word" is no different
> from a compiler POV that "write a single bit", and we can already mix
> atomic_or() with atomic_add(), with both C atomics and LKMM atomics.
> 

I totally agree with your reasoning here, but maybe the standard doesn't
;-)

Regards,
Boqun

