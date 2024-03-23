Return-Path: <linux-fsdevel+bounces-15143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B98875FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 01:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02081283E07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B926A31;
	Sat, 23 Mar 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1kWeaxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEC1FA1;
	Sat, 23 Mar 2024 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152937; cv=none; b=q7qdFV2soRwRRfle4fuZlwJo0EaNrCewYId1qWniFEJ4Aa1zni6bFDlwliN5HXzS/D0Y24jF+D+SO6Rk408nPOyOeRRKeTgc2OIn+gpXh9Wei9TNDRtjpMHEFzBVMxn7IX9CAEqw8362VV/DCAA3+2g3uJA2WaU3H1kBUdI+Clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152937; c=relaxed/simple;
	bh=VTI9Sf3VccnbABPGXsY1j2qF+SStz+OEfznm86+qGLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMfn5lJhzTWNh6b+EX2ikc7hGsLITAznC7gomrRrmYVi64luhMf+/Et9MrPeDevGPul0hFuJMia9+lKIDvEi+o/Yd6OhusmOgHG2/BDvTFD1ji435vOJLuWaZkhAdGTAbPxhfCkWY+Ow7GyzNW9/fKvaCV35oKvkJ2fAGSVKc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1kWeaxq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690d7a8f904so34549316d6.1;
        Fri, 22 Mar 2024 17:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711152935; x=1711757735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whmVMHuEBXgRIj9diBxuHvfTM2nWAuNzeXBmM3HZHOY=;
        b=k1kWeaxqCSkS5z1d046Rs4gFuYTzg/F7efu0e2m49a0LdRk9SSA3FiIdEGMixDWivT
         +G+f8OVtc+haWHPUIVXvWWOCs3uBNTUH9LTZ9q9GcxuOj9KWkk+YUQVzRVJ4Ke14XuSl
         WI2OfxbDuIVzSsop/nOvJYjpP/y9KoSrtvT3t9suc+txKEJacPuMzIuhXfUcJ1K0v4hI
         1Civ2To5yc//w/fQBFnV5UC3qgiqJkE7J57gFWZJy6UN3DqYjG090biAXBdydHhFrWxs
         CzNhuXZuMUFsuDTLLbMXg+LfUacN2QeMZUATGy93u2RmhbZ706EhAHw76Q8Kyc6SRm+q
         JN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152935; x=1711757735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whmVMHuEBXgRIj9diBxuHvfTM2nWAuNzeXBmM3HZHOY=;
        b=S8gpeG8DGRZh75npbyXFtdKruG9MwpPSdnlmC1Wo0TA63PqZplFDUXBmIC6X6VOFPa
         lV8gK3roTTqUDV72TCNAlzMKy07Dol0Y+8SATG/o7eKycrNLqqhpprrKAgw6JS+5fNvQ
         4x8Hu6FWg5mUuCF/EmpoCgK/Bo7D4rx23G2P+JDIDHCqoF/cWcNCr8xzgdLJ2blpHzMB
         wafdJKNjww89+z3W4J2otgx6sHuqSKtryaQ2tkRYAJBLFB4otlcLGCp3dRlwYIbkyCxF
         oujYurA2dGPVfisn8YwfkJ65qyZQ3PYpOzdtRpiJnCN9hI3IV8OWf4KCFMADMXMV4/oW
         qU4g==
X-Forwarded-Encrypted: i=1; AJvYcCVmoHBpogub1u0zunyXe7bd5z2YlYTry2/X6okExnf6LzLPNl9AEn8roZsibrQzUPhAD2T0dlMZu7zs2LUzDDUzAZ0JH5RZxCRucupjCVb49acA7I5yadqz2OuofztbH7MBcUVDRJUXGSl4NIfdUk/zbj1N/eGTnvmdih24qwQoSflXqoRiKDE=
X-Gm-Message-State: AOJu0Ywx6M2dtnXqaLMxOF0BSEylQdLRq7kIJfu6MXVqy61bof7fkD8F
	jezp8nuOgT4b6ATNcTR0R4bw3ugM5iPd3ISXGJTi8+dWTDIcvttm
X-Google-Smtp-Source: AGHT+IHOo27LLL5BHPFVw2rGuSB7QeBeHaMSJwGhonKrbQGbCwa6LdZz9tGDqQaK9+FrfZtfSfp36A==
X-Received: by 2002:a05:6214:2124:b0:691:3d91:80bb with SMTP id r4-20020a056214212400b006913d9180bbmr1044086qvc.11.1711152935122;
        Fri, 22 Mar 2024 17:15:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i11-20020ad45c6b000000b0069068161388sm1558668qvh.131.2024.03.22.17.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 17:15:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8AF5227C005B;
	Fri, 22 Mar 2024 20:15:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 20:15:32 -0400
X-ME-Sender: <xms:Ix_-ZUUr0Zr7P-rdVzLcnxOteaopQcoWP4M_QKcO5tgxJdwJSbrjRA>
    <xme:Ix_-ZYmGgdko81K4NeYOyyDZYPTSMk-kdIfkwzg_5e8SHsrcYicuXooExU_kpz0QJ
    qN_iU7d9tz9aAuU-w>
X-ME-Received: <xmr:Ix_-ZYa2scaSM2UvwgHKVCQsqYKycZ1LXAfzgb9OIMoB1XqBWwYj8xYSGx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdei
    geehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ix_-ZTWHEgAkmfjD2i9t-JnRVOM_exrp-qCXzEaBaEeIw_6QY-boOQ>
    <xmx:Ix_-ZenzfIQS-GlYhhcrHv8B_gxu88-FH41lN5naq1F83dfGzs0bTg>
    <xmx:Ix_-ZYfMCRZRWH96zPWn5dt2PCIy9q8P_mmdEZ29vSZL9wQN3OkdGw>
    <xmx:Ix_-ZQHx_kACfeCCdbG3obFGRLJ1IKEWhOa38HM6rn2VyxigoUcvWQ>
    <xmx:JB_-ZflHnfpFS5SSC4nwSvCuOGUk2HWQ8168jZGHQbpB-kR7ky5mhYcKTnI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 20:15:31 -0400 (EDT)
Date: Fri, 22 Mar 2024 17:15:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
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
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <Zf4fDJNBeRN5HOYo@boqun-archlinux>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>

On Fri, Mar 22, 2024 at 07:57:41PM -0400, Kent Overstreet wrote:
> On Fri, Mar 22, 2024 at 04:38:35PM -0700, Boqun Feng wrote:
> > Hi,
> > 
> > Since I see more and more Rust code is comming in, I feel like this
> > should be sent sooner rather than later, so here is a WIP to open the
> > discussion and get feedback.
> > 
> > One of the most important questions we need to answer is: which
> > memory (ordering) model we should use when developing Rust in Linux
> > kernel, given Rust has its own memory ordering model[1]. I had some
> > discussion with Rust language community to understand their position
> > on this:
> > 
> > 	https://github.com/rust-lang/unsafe-code-guidelines/issues/348#issuecomment-1218407557
> > 	https://github.com/rust-lang/unsafe-code-guidelines/issues/476#issue-2001382992
> > 
> > My takeaway from these discussions, along with other offline discussion
> > is that supporting two memory models is challenging for both correctness
> > reasoning (some one needs to provide a model) and implementation (one
> > model needs to be aware of the other model). So that's not wise to do
> > (at least at the beginning). So the most reasonable option to me is:
> > 
> > 	we only use LKMM for Rust code in kernel (i.e. avoid using
> > 	Rust's own atomic).
> > 
> > Because kernel developers are more familiar with LKMM and when Rust code
> > interacts with C code, it has to use the model that C code uses.
> 
> I wonder about that. The disadvantage of only supporting LKMM atomics is
> that we'll be incompatible with third party code, and we don't want to
> be rolling all of our own data structures forever.
> 

A possible solution to that is a set of C++ memory model atomics
implemented by LKMM atomics. That should be possible.

> Do we see a path towards eventually supporting the standard Rust model?
> 

Things that Rust/C++ memory model don't suppor but we use are at least:
mixed size atomics (cmpxchg a u64, but read a u8 from another thread),
dependencies (we used a lot in fast path), so it's not trivial.

There are also issues like where one Rust thread does a store(..,
RELEASE), and a C thread does a rcu_deference(), in practice, it
probably works but no one works out (and no one would work out) a model
to describe such an interaction.

Regards,
Boqun

> Perhaps LKMM atomics could be reworked to be a layer on top of C/C++
> atomics. When I last looked, they didn't look completely incompatible;
> rather, there is a common subset that both support with the same
> semantics, and either has some things that it supports and the other
> doesn't (i.e., LKMLL atomics have smp_mb__after_atomic(); this is just a
> straightforward optimization to avoid an unnecessary barrier on
> architectures where the atomic already provided it).

