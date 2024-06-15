Return-Path: <linux-fsdevel+bounces-21738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E1909530
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 03:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1397281C5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F0525E;
	Sat, 15 Jun 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDK0OPaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63841C2E;
	Sat, 15 Jun 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718414700; cv=none; b=L/xLGN9K0cb18L7LSWTEYOg0AhvWeW77Y4s0hSAXcaoBKgTfWH9kc+EwvPMgc1VuvfM2NMZM8nzJ4roxln0PnFrjfgh6jb+PEg4m7IrDdXvfweQHO5rZjiTnjOQPHpt3H2UAFegsLmpnoXKUIT0wM0eKfERmWrL1ru/3m9zd9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718414700; c=relaxed/simple;
	bh=vgpdZy8Zm21I5i7rHfIpJ5Zyoj30Uxr0py2T20VG2tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1HfEuapGDjXdHEc9+T5wLv9IFdggOjybq9cJ/nlQGA+DXEK28oTj8rFYGxiEzEBDqWiwjAkdmDCPmOpDwfjXo8V/c/ovR/xfR2B2k322DotHF9Pl0po2/90GwL9VpB+Zogp+lAXad9EdbukqN3WzvvfU3SoptNAFEqrXOEkreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDK0OPaG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7955dfce860so178524685a.2;
        Fri, 14 Jun 2024 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718414698; x=1719019498; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JfOBXszW5OZSQ0w6pPZYZxRPhMPO4vnS5op55SUhlr4=;
        b=LDK0OPaG8SJ9fxkiltIMCQcLQ5ulLMM5gxJ96pocFRDK5Ww30vcIo/Vs4i5kdXDfR/
         KvJt2+/Gkaaf+PilmTQkpunUFSPCDrUOHVmo8ZPu6IX2PDnffeXuJOr6kCEeykgmcMqZ
         Mw+C2BEXHL5vD0EC+xnrQE8mzWafd4tVKh+0vm/5Ekdydbd+u3Ok2Yh8Qy3DtSEkyNdB
         O0e2OIeFnR6PQklAyyC34Znv8mFclZ7XmbwzrbuQa9rI8IH6e2OKWme25y0naddL2pO6
         +fPKKVqUaomH1KASOWTTZ/ckU0LZu1LJ0hy3seGjksQxHhcg6izplmT/cpql9U5825YV
         BzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718414698; x=1719019498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfOBXszW5OZSQ0w6pPZYZxRPhMPO4vnS5op55SUhlr4=;
        b=OAi3fhIdd1voQ4ZttKpgmCUAGUs8uS+RPhm85CidVGTRKXaNvPCN/neAmiVKYqjyEt
         g1IShLu7vtDDFnrVda4t0yX9hYk/DoqfYW2EaIJuFEnGXmTVPGOVckTLr13Swsta+JqW
         3Ptm9IxIdHEq+JoU+hAqAT/rSCgz92a5shtHcplb/OEdAMnwr+7jv/eWh4vUlcz+3gTV
         bm/DLd6rmK2HjDkwavwBXovX7J56IZFVeMn2cQ5unf1pNh4ERthnIU0fGk4uWlGSpmfR
         9TAvmVIZmkALaNI4QUO6vsqrsokGItGjCHQ30bQeWVkBk0699fqUv2Wch5PCctehd+Dw
         V37w==
X-Forwarded-Encrypted: i=1; AJvYcCXtKxgLEAsYU7o/0keRHjW7CuH6oAo+Up/JglJopzqhijVwbcIUn/AN+vpzYRYtFwb9EC2axXw3JtpasPJeJS3gTooqOSwW5SYNASC7STCA6c04GNJEWlX8CQwzMd4+pikeiChyuru72TPHDehLOsabADB6M0LoWezBBPmFmHMwdmFZRtFyzjHzXrNy3qcb339SL2llhH1N1TkI28oTV3uPTOMJKBnnIQ==
X-Gm-Message-State: AOJu0YwEhYjVHjFfnrKaN5esOnKrnm9EKHj937fp0nSAgL4BOQuJZBVB
	vmR8s2NFRAgsYUkrHNU7YaMqqCB66xoyijcjnNTRFA+W43JJbkcc
X-Google-Smtp-Source: AGHT+IG6n7GPvstdqsh1yw1mNVwR7ev+2XQ3VHwq7FcLWe4FaNEqoQptCk/LJ0Zi1UEWs9hkSViM2A==
X-Received: by 2002:a05:620a:3955:b0:795:758d:fba4 with SMTP id af79cd13be357-798d243b042mr491526185a.46.1718414697754;
        Fri, 14 Jun 2024 18:24:57 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaedc360sm198773685a.33.2024.06.14.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 18:24:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 03B3C120006A;
	Fri, 14 Jun 2024 21:24:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 21:24:56 -0400
X-ME-Sender: <xms:Z-1sZvOgWv8RCft1zQbaQjImr1wtCuGHt6cKHSVl2_henjEWxpD4Dw>
    <xme:Z-1sZp_1KoiwJg0IBfbZtygwl7AmihNvLyCmEGwYsx5uAdZc2V2FE_vx91-hw5m-H
    dpnms_LKml9b1_vXw>
X-ME-Received: <xmr:Z-1sZuTG69pV3Y6aR8AOhLfbwRPjmBvcxRtJfJqVsYqoyIn6QI_gD0LEFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Z-1sZjvzJ2JihPBJtUb3JJwcPUHKcpThYKLdNyrbJZeoe8wRTzVaow>
    <xmx:Z-1sZndWMVAzg8ILebxL155UR7oM5hFwXZHpcZ6MlWwmHAhxT3ydrg>
    <xmx:Z-1sZv1WS-HnjqJurM9A1Vci8ZKauC3OEcvWRkwf7QowLBtIqeTVtg>
    <xmx:Z-1sZj_pFKfsGcG3AfOmu7CvRyYaQhC4OWSp5Ly3J6zDrNBfITCO4g>
    <xmx:Z-1sZq-2Op7iZ1Fr_mbNrOeeqIDaaagnsZ-5xigHBGNtXw2fKruqywwk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 21:24:54 -0400 (EDT)
Date: Fri, 14 Jun 2024 18:24:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
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
Message-ID: <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>

On Fri, Jun 14, 2024 at 06:03:37PM -0700, John Hubbard wrote:
> On 6/14/24 2:59 AM, Miguel Ojeda wrote:
> > On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > 
> > > Does this make sense?
> > 
> > Implementation-wise, if you think it is simpler or more clear/elegant
> > to have the extra lower level layer, then that sounds fine.
> > 
> > However, I was mainly talking about what we would eventually expose to
> > users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> > then we could make the lower layer private already.
> > 
> > We can defer that extra layer/work if needed even if we go for
> > `Atomic<T>`, but it would be nice to understand if we have consensus
> > for an eventual user-facing API, or if someone has any other opinion
> > or concerns on one vs. the other.
> 
> Well, here's one:
> 
> The reason that we have things like atomic64_read() in the C code is
> because C doesn't have generics.
> 
> In Rust, we should simply move directly to Atomic<T>, as there are,
> after all, associated benefits. And it's very easy to see the connection

What are the associated benefits you are referring to? Rust std doesn't
use Atomic<T>, that somewhat proves that we don't need it.

Regards,
Boqun

> between the C types and the Atomic<T> types.
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

