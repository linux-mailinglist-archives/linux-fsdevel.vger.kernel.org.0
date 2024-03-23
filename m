Return-Path: <linux-fsdevel+bounces-15141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13478875EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 01:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC991F23811
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CE1EDE;
	Sat, 23 Mar 2024 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5czqY2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340D372;
	Sat, 23 Mar 2024 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152219; cv=none; b=AocqusPb/e1FjdaB5vPrfTL53ZcTNMymznw5yaCsLjEM68MuVntTjbpCVlRLjLmiNuMclWTC66LLfMXz+uLPWnUVjzCj7UJ6Zlhm4lECZ8asJz45QRGmTaflMOT+ioHbTXw9UTraZ5KUUTtxEIvcuJMSiNoV8rBdnE8A9DghR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152219; c=relaxed/simple;
	bh=vW2bvOuQiEcRn8u7kI1XXOFFH3fIHb1PivHG6bJDI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btzD8zPjjwDaoV+4oLVHjzorZSqkRIBXy5a/zxsolCoxlkRz64ddIckKfuEEbQx7hLINdUYnhRZH39/lJMkHLIf//4oY2Oo86v8WEg8NgXryO3MNOlVnWGn0BWO6bH7I6uJZ91UXTFaRFapsckoAkfqgAfRdMoc1Knffs0H5jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5czqY2m; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430c63d4da9so19874201cf.0;
        Fri, 22 Mar 2024 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711152217; x=1711757017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eASLODvGo3GX2Oyfss7PQQhJkyATkdZhH8YczVO2EXo=;
        b=G5czqY2mVqLASoTXcSh4fWCbz4Z3n2a7w2EDL5TB4Ix1WN9e/X8D++rugVgFz7SY/Z
         4xxDeFye3PY+CimrRQ2p+eziaBzkkJg9BbzTaxkGiJk/otzVtse3Jip2qe8AjvTZ65L8
         MINuS+kogd9SHowjYRrSiYPdzeISiYpiOtn76hils+kRihAZ54HS2vWUjsySqNGP+ak9
         5YLSzmXFiSyxkrDQc6TAbvba80a8UzxQgXlqKg6ZGb8SakJOThgI9BefWhYDJZ9+9qKX
         /SbxntiVHtTgNaAsqOEYYg+zX1hvdL/VuDNLlx8/+fCpfpfPTUmm07qvfmOJP/mw1PCg
         uj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152217; x=1711757017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eASLODvGo3GX2Oyfss7PQQhJkyATkdZhH8YczVO2EXo=;
        b=ARhahq5uOgfBqr/aR3vaAMVaSwdja2DIiN2Ba+Vtnlup4oGBgrJb9VqHETurcPge9t
         zBw1op5DqXG5c1ncNrp6iuUymybqH7cl8bmQ+0f8GUiiUzJkBzXOvHhkVFiyXg/f+C+H
         nrIonk9JXtC9fm+nm5X4TeUTQDZrUEyOK5RxCV4OhHGNJi31SRRG+tmqfOm4p2YejN8C
         fcmnKI5y7ZvLKYDhph5JqPV4192UT/JgsQyU2qmmwJ1boNUtG3fCm7wuURASdLmAXIXG
         nDCEs/SWe734dfp2mNoriCHaVLy6XqI7a3hQb945uzFJxrXCjekKNjtu0ecnNa4DPCvx
         +CHA==
X-Forwarded-Encrypted: i=1; AJvYcCUs4cAhe66zdOIBII+7VPy2+fyiBLuQ6Aix8/HyP5T60wXj2nb2jJgszqIa/+1e/4etvKf6ClsSPI1D00JjS/d14f2MbRO0g5F784Oq5xdOIlsRI6zVFiHdxxdde6nLJKro1+cH53J1cGin5Q6EWuOwbG/D4Dcl90IwjnHr4VewTe+UST8IXtQ=
X-Gm-Message-State: AOJu0YzCcSrOZlGmMEGqC0fVgtCJcbt4bVY9YWDDfalGYBLkdpmyDS/x
	6RMkI0JrwzejodggFkdX8t0XGs+wgTWStIk9gAM64rSde4ecZv8A
X-Google-Smtp-Source: AGHT+IHjbUwCnlotNrzEjDqfeNUUku72up8XO+hTXKKrIOT7ksYTxuCesrZTrHymVkrnW/ZbtgJbZw==
X-Received: by 2002:a05:622a:14c:b0:431:24c5:9dd0 with SMTP id v12-20020a05622a014c00b0043124c59dd0mr1180573qtw.29.1711152216768;
        Fri, 22 Mar 2024 17:03:36 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d2-20020ac84e22000000b00430cacfe532sm298900qtw.79.2024.03.22.17.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 17:03:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5901B1200043;
	Fri, 22 Mar 2024 20:03:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 20:03:35 -0400
X-ME-Sender: <xms:VRz-ZdXHSIU4BX8chv0Purd_bpORS4xQiU2e-I_22sDXeCHAl3zz7A>
    <xme:VRz-ZdmP2FluUVkk7NL3loKYAmaFWKJt4T_RRMVQXFswYXjPdNdXbiDiI4VzKRsqE
    aDkFjicd6dBIz42IA>
X-ME-Received: <xmr:VRz-ZZaN3pO-DfeAke7bo2B-AJmNKkOpZdAENuU93WMn_4fUTUWz5Y0y5FE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:VRz-ZQV5IsiQ2dn-V_IQGJQATDKPlHAjJgfYEFoYHotrCsEZgm084Q>
    <xmx:VRz-ZXnJR1Jp7C6bk3BVOlpG56qHQGcKCBa0606CC4yN6krT9hCAvw>
    <xmx:VRz-ZdcaBrIS8ih1MvMKVVYUf0tqriGMYHRq4FXDoe2KQ3CA1FeuJg>
    <xmx:VRz-ZREpiOuFz4uBcPFkFCWx-cJYtKQLdXD1nf4J0J3PTq_ExXwtcA>
    <xmx:Vxz-ZYmpBDlpMIxq8k8Bo7f1tn1-uNRKAQtiRUINbv6m5It0_omvAqyN_AVWy9Ke>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 20:03:33 -0400 (EDT)
Date: Fri, 22 Mar 2024 17:03:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
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
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 1/3] rust: Introduce atomic module
Message-ID: <Zf4cP6lx7LHmt3dz@boqun-archlinux>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <20240322233838.868874-2-boqun.feng@gmail.com>
 <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch>

On Sat, Mar 23, 2024 at 12:52:08AM +0100, Andrew Lunn wrote:
> > +//! These primitives should have the same semantics as their C counterparts, for precise definitions
> > +//! of the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory
> > +//! (Consistency) Model is the only model for Rust development in kernel right now, please avoid to
> > +//! use Rust's own atomics.
> 
> Is it possible to somehow poison rusts own atomics?  I would not be

I can continue to look an elegant way, now since we compile our own
`core` crate (where Rust atomic library locates), we can certain do a
sed trick to exclude the atomic code from Rust. It's pretty hacky, but
maybe others know how to teach linter to help.

Regards,
Boqun

> too surprised if somebody with good Rust knowledge but new to the
> kernel tries using Rusts atomics. Either getting the compiler to fail
> the build, or it throws an Opps on first invocation would be good.
> 
>     Andrew

