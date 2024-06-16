Return-Path: <linux-fsdevel+bounces-21791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C6909EA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4221281492
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62A225D6;
	Sun, 16 Jun 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beUBqpVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73F17C6C;
	Sun, 16 Jun 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718557512; cv=none; b=B8SYxCzGhD8XKn8Md4pSmXgIRtpCEDb+Ux/T8m5bMnC9q6wsX1L5SYouGVWMbcE1YuwBbX36NufadaSTXVJUTPj1DF8IvOLVaf4r9kONr3EqZy6KgLz3kgAJfuxZMVyU2FAO5kZQrloT/hKpBWefu3FWp0hbeoJEeZ+03T4PomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718557512; c=relaxed/simple;
	bh=RIvx9kOHWKLvcoJfK4R0q0IiIfjt7q/a7nOFuOC5niM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7OXNYFCH+qYeqfWjubimW3/EM8wxFpC1EyR694XgYeEfjwUnoA1KZO75go+BQBE8EmiGAyQla3Sb4rQM51ASjxZoUoOZ8zcYQvZeo/CffCZhLr8yPoj7L3HPF0Nilndqh7KJPGWBVWj+mvMnbNoikjd0qmSIvD0ndjDecr/1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beUBqpVU; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d23db75f5cso2229358b6e.0;
        Sun, 16 Jun 2024 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718557510; x=1719162310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb/VuEkpep0deG9cMLgNvTgMKIQq7qL3KwU1FP8n8Zw=;
        b=beUBqpVUQtfhLynW0eWkiXvdIHsrG2eFPO8RkUq9Y6WieiUH0KNM8rK7tAFIhRS/JR
         BQW3cdRrKM2o22Qgr0e15B80IGfYeI49Wb5GzbABDwD/R3bcTCcj4V6jlT9JjnjvsyDl
         1f0670X0y3yUNDRDTa88Z4TsrnU84wDQm9EzARrdmD3oSVMeV4Ndgn74EORSt+wTj/Cf
         uyp9uP2OasqJCV3+FBmnkapyCNGylxWXEnV/OEVPhkZ9k1QyYylsbAdagFiPMHZrI25d
         /3MU1bO7nyZZUYDoVFkdog1hVqpFK41cjY1Xy2xSIBnFKhihwjFR4C4QBgxT9TpGpZPK
         yrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718557510; x=1719162310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb/VuEkpep0deG9cMLgNvTgMKIQq7qL3KwU1FP8n8Zw=;
        b=q41e9os3zUd/O7hhJE5cQdQcmg8k5/hcXTMhx7EPZ0th+w+7UKKWYxmPXdFDcLGCRq
         wGGWFnBBwfOrrkm9UGjIVFH/ab/N7hueSgWO9oOZRKQ9WHkdeAzjd+QHywxwloZBqayR
         kakjD0Zt0RC9mbDWrmk4jbXC09PfJTbUFcQjNWcH4hdmIMu2zpoGazkS6TGn//JAjmDl
         DxD4L41wO3UeYUbAzlcGzHIcRAtl6SCibc2fFHH0H/qetcidz/sVCCIQ13Jjpbmpqv2z
         NcFPqv3znFK4glmukRfWe9yJHX/iCumFI3gqZtq0jjdukIyJ78hs7KaNUjoFXF785NZg
         u//A==
X-Forwarded-Encrypted: i=1; AJvYcCVo9yXI3YkjGT6ACvX4ZSkzKaF55WXUGp2bzl9AgkNxpgQNlHVx2hX6jvyBvF37XA6gfrNrUlkHF6HjBXNAOM9P2ryErZKEJvjQttaEiVdxIXqNjsDKvFDkmlXUY3UOzUubs/8Wyu2yv0tC2Di9ChMEklM/19QfHgPnLkgBGPWJl8yS6psKIBavWN+DdLUrjc1Zg/aAA1xyo+vb+ongKTpusr4wreNJiw==
X-Gm-Message-State: AOJu0Yy39MFY8J0xuOw1bEAz/I8RNfveynwTHdjYYCtzU/6XdeCqzsLI
	bIeTpZZSpSUlzclv3Q+ODvX7MOGxFX5ADDR+IZdS3hkuehrc5gia
X-Google-Smtp-Source: AGHT+IGelQ5mYwaNQtvvsfM75dkmU6tbIL7wNO/AXelpy/8mWu1xuPwyHTXC3de/DOySHWI05Gx5qQ==
X-Received: by 2002:a05:6808:1520:b0:3d2:2356:d273 with SMTP id 5614622812f47-3d24e8a9973mr10166314b6e.6.1718557510442;
        Sun, 16 Jun 2024 10:05:10 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaedc360sm354994185a.33.2024.06.16.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 10:05:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F3B401200043;
	Sun, 16 Jun 2024 13:05:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 16 Jun 2024 13:05:09 -0400
X-ME-Sender: <xms:RBtvZj2OaSyEI2y2V9-SV8zns7pXtwAuifBua7R-qHZJIEnPe2vrag>
    <xme:RBtvZiF67gwxLmmCwKTmfYcWn3G0RadywiVzA6IV6wWYsLCfpw5McAa_d4fWSaM7r
    nBI0EETouif78uJwA>
X-ME-Received: <xmr:RBtvZj7-D-81dAgltMEDzAkUxvpGg7h9V-HW_LOEYutBUzCFu1SXJIQ8UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RBtvZo1gRpIqhEQGdujZa859eZs3naawX8BSbi2KvwkOmKC4fwgdkg>
    <xmx:RBtvZmGO9Qbn7U4XLSTouWlILV5JfyISsOlJuEZ2Mj4_O4A4g0iVJg>
    <xmx:RBtvZp9hy3T4Q-uXgqlbb3h_q3dCAX1_n3jZKg8eg6dR6MQ6nbKENQ>
    <xmx:RBtvZjn8fscW1pBdQVrMgRmOKdBhTcFGgzwXfwGh3MPVaIFWqAbavw>
    <xmx:RBtvZiFn6QKs4Xn-sXl847Km0MmKF90_4OfR1iIggUg_yS6i662ClvYs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 13:05:08 -0400 (EDT)
Date: Sun, 16 Jun 2024 10:05:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <Zm8bQktx4D-3glG5@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>

On Sun, Jun 16, 2024 at 09:46:45AM +0000, Benno Lossin wrote:
[...]
> > To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> > What's the downside? A bit specific example would help me understand
> > the real concern here.
> 
> I don't like that, why have two ways of doing the same thing? People
> will be confused whether they should use `AtomicI32` vs `Atomic<i32>`...
> 

BTW, we already have something similar like this in kernel, we have
SpinLock<T> and Lock<T, SpinLockBackend>, how should we do about this?

Regards,
Boqun

> ---
> Cheers,
> Benno
> 

