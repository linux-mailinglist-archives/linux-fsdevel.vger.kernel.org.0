Return-Path: <linux-fsdevel+bounces-21671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCB907C07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA091C24DCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7B14B94D;
	Thu, 13 Jun 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCUvASAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C144130487;
	Thu, 13 Jun 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305553; cv=none; b=BWwqOT80akdOGLEzL3GUPxmwrA4K9/gJ8LdnfCZO8Oy3ZGsRjf/RUgHoveVqz5nGXn9IldOUuF2FgO0zESqI3JRIZx8jREpJDjderGiSYVo9dYPCHV9Yvj+TOa4EenguEfxPnHI1Mv5tuVCzXVyQ4hhqZ/qoNazJUN2gW1LNt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305553; c=relaxed/simple;
	bh=Gjcaa8+6uCgQkQx/KQDUdcFBpRQxKJkZkyyvTptG/DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjR4T4hwWQYQ5eNWRWXV8mNfRGP8EdGkP+K4GP1hwbgCiQ/e04F654vLg5RsNacRxu/mDD2qyop3xi7Lx2BLAlKO+bhvmcZv3Kf7I5F/czVaAu8y18lOyG0P6HeUt8Ef+/rJsngxBAzGXwum743bjG9/6p+HBwldlh4rkCVtomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCUvASAU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44055ca3103so7775101cf.3;
        Thu, 13 Jun 2024 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718305551; x=1718910351; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ffc3VX56CZ7smTmD9fwLf7azxKQfNJQFr7EZRiaut9M=;
        b=PCUvASAUnkWfnh4k6w1wQPRfaMgJclN0P+i9l1fhmBAU1LQGuEJ5B28lINOklT7vM+
         9nFPMRNg8G4uWSAYlMg3oIbOQpdAk7kYrqjnBiM+Xoub8yNgBnyF07ZmUHUsOYl9VsgM
         Zt86rgo1hIkye9kpw2CQDzC3L0OTNVrESueWpsNZuQQNxDxfxK7X/Od7H4jUpxH4BTtr
         5V93w03AZDkcsi7TOjz17vaAse6mCz7TlWlVOcraaUxWBK/PVhRYxkN/NfJkhbhrYBnf
         4PCxYSto5wua9AkAtIUeGgt1l3shzhtLAOwr8jRpDz/sJDt6jRTjp4tN/RVoU50RCKz8
         jmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305551; x=1718910351;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ffc3VX56CZ7smTmD9fwLf7azxKQfNJQFr7EZRiaut9M=;
        b=bs5Ve05CCHlwNIfEkUWnKnG2nUqB9zSoJw/z31wmlBpKu3HwaxOw7X0QvbRmsQpZS5
         R92rZjO2CPGulTrmxujgJAT1cP7QO/1Lftgc7A2YaZUHHUz+X+bP64alqPuRJBPtdpQb
         miBzgVN2o5DkAKlJ3NlNOl/1JQcsWIpDXJeqYe08oUsiy2q/yplYdV2Xjtw9y0lk2Qzs
         sYJoaIpLuMcaMdgpSFaSSNPjRFR1etjLiowmPhiLLQSf4xHmx5noqmwIDhUJi4lR8Lb2
         C5enHtweNgpkd7C+KpkgB+q6rWMuMxCHX8RsvFY5ogwOUuBeoJopCYFevJ7JZ2jmFm86
         MVpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9jtuYy2jTgxx93CulyRdakYcO/brK9SlsVWFm6fbm09hhbx1WHnEqSksROd/cK3qL44+2NvfXo0viEwU+anWsbM/NwtnCGKnBL8DiRBD3RAinUZurXbTwOqrE5nIV48yWEkuXpFfPSyBt6Ht5/VScKTmghbQlb1RpU5cSHdBUZQRCy6KVJbKhkROwK48LfukykwCVuUvI8cYDWUdHhmFcOWwCcMOP3A==
X-Gm-Message-State: AOJu0YzmFcVbp7F0UlSLf62Xs+wKw/RZtT2OZETE1BBievjkQLMo5tAc
	IPTbJ5obNz4YVNOuAapcFkop2GI4EwEOHnZpuApI6hlKpTyxhVmn
X-Google-Smtp-Source: AGHT+IE7frHfV9qWWrHFx6ZJCKnyiIFeH/wvgqxxR+AWnNkmcvkTjALGUbQSHHQF3wfhTv0YEkSdrg==
X-Received: by 2002:a05:622a:284:b0:43a:f698:2b21 with SMTP id d75a77b69052e-442168efe33mr5802941cf.36.1718305550923;
        Thu, 13 Jun 2024 12:05:50 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f310c9f3sm8692321cf.94.2024.06.13.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:05:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D6B961200068;
	Thu, 13 Jun 2024 15:05:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jun 2024 15:05:48 -0400
X-ME-Sender: <xms:DENrZlFyE4PKus7PtcngvvYJ3LDlv17zq_-foOA-R_uwn2jWAj5rmg>
    <xme:DENrZqWOnjAN0L_ogg5Eh5sTwvLhgw7t1HLptF-85aJTCt9K3ooSlaqXarlDVcwt0
    UFDeP7cZzo6WHb1Sg>
X-ME-Received: <xmr:DENrZnJSJ7VqUNPf6OqtGP4nPRTqgpQmCGv9P9T2DHk-SIFKM-_WloxqWCmTaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DENrZrHyy5dfzSclIt6WrauysNCojKo0axfasGsZcmpz8USlRnpVFQ>
    <xmx:DENrZrUfUVM4S_BiOu3E8BA8rZJVtfctsRmyF5dw0BITnGnmSAxdSg>
    <xmx:DENrZmO6yQ36TILhM_mcUmir8zxJ5zFCQyoMAiqCFePOn4zhQciS1w>
    <xmx:DENrZq3fOjwskOsIlU1kCxV2aA6xYxwuK4exCf5HiG5uRm3ryIoFzw>
    <xmx:DENrZoV3M8wFR_ypgM1ymcj7O08B1d2k9Pfm3jwltwuf14xQA3ysxuMX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 15:05:47 -0400 (EDT)
Date: Thu, 13 Jun 2024 12:05:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Message-ID: <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>

On Thu, Jun 13, 2024 at 07:22:54PM +0200, Miguel Ojeda wrote:
> On Thu, Jun 13, 2024 at 6:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > So let's start with some basic and simple until we really have a need
> > for generic `Atomic<T>`. Thoughts?
> 
> I don't want to delay this, but using generics would be more flexible,
> right? e.g. it could allow us to have atomics of, say, newtypes, if
> that were to be useful.
> 
> Is there a particular disadvantage of using the generics? The two
> cases you mentioned would just be written explicitly, right?
> 
> One disadvantage would be that they are different from the Rust
> standard library ones, e.g. in case we wanted third-party code to use
> them, but could be provided if needed later on.
> 

Well, the other thing is AtomicI32 -> atomic_t and AtomicI64 ->
atomic64_t are perfect mappings, and we can treat AtomicI32 and
AtomicI64 as a separate layer that wires C atomics into Rust. As I said,
we can build `Atomic<T>` on top of this layer, like:

    Atomic<T>
      |
      V
    AtomicI{32,64}
      |
      V
    atomic{,64}_t

and if we drop this layer, the dependencies become:

    Atomic<i32,i64> <- Atomic<u32,u64>
      |
      V
    atomic{,64}_t

i.e. in the same layer of Atomic<T>, some of them directly depend on
some other Atomic<T> types, which doesn't look very clean to me. And it
might be difficult for architecture maintainers to track the exact
dependency for Rust code.

This is also the reason why I didn't use Rust macros to generate
AtomicI32 and AtomicI64 implementation: I use a script to generate .rs
file. This ensures AtomicI32 and AtomicI64 stay with the exact same set
of APIs as atomic{,64}_t (described by scripts/atomic/atomics.tbl. Put
it in another way, I guess you can think AtomicI32 and AtomicI64 as some
sort of intrinsic layer provided by C. And should we need it, we can
build an Atomic<T> layer on top of it.

Does this make sense?

Regards,
Boqun

> Cheers,
> Miguel

