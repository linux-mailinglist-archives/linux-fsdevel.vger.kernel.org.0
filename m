Return-Path: <linux-fsdevel+bounces-21740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32235909541
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 03:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AC51C21BAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88828D53F;
	Sat, 15 Jun 2024 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPe4HgZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7218F70;
	Sat, 15 Jun 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718415197; cv=none; b=oZJc94HPj+YW3lt6RDQZkifdiPioyhI3HtCVRSnrrV5OoNTH/7vmarkmH3P67VW3Jn17dlTzANANQ/qzxOf7gNoNfbrMaoonGTH2w5DQ4X8tKjSD/nEje/y9XuPaSC3V0rW9hW8y7e6w+WLL8vChBkPbg2R9M4PH1QzzG1eDfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718415197; c=relaxed/simple;
	bh=CN3bPCf2Y3zAyQDEccKddE9q4bieNSMv8+8LxuB+vW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNFxifjKI6AFpILWZu1kXOUIrH1ZNkXgsVdgsy3Ey4JSvKhv25SgqnNoa+EiyZwoyh/IsK5WzefeNUlFaSuS0wX4TkFu2TsnOFAH1d0d4R+0zo4Lgq583rLplUi57Wd8P7lPWGPmnqfdtXpvyjipU+Lkg0Nt2Iqt3iisTkZ34cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPe4HgZi; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b064841f81so21799936d6.1;
        Fri, 14 Jun 2024 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718415194; x=1719019994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl32RvA7/8lBmewSY1/SnN35QBeCzByhM9oh3NCck0A=;
        b=KPe4HgZi3DRF3ZueRGhlPSG9rioCIEw8d38MqeO9inr6YvOaj9jzsmRFM3//ACpIIM
         SacL+6YgXplOH4m4RTwzfUMpnF0mgnkoeX47l0gUBGPqmEoCLHzPpJo4Qm3WhfnYAfNe
         UtlrYRibfA5BhTK7Z91K0961YI+T/2B48JiA4hpvG0XKPAFD1z+lI4GhOphDjP5DronF
         oVXrxVuLt+mCn/uqeV0sbzgcoQ+Us7z0vH0OzhgWgWHvI7toHR+uKL2aOLxIUB02hMWq
         JN9+mFCGCgESX603X8Mx9gUHRri5Rko1iuKqPPTK9+1+nTwNpWrYybwqNLuq3/h9HrNt
         Hi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718415194; x=1719019994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nl32RvA7/8lBmewSY1/SnN35QBeCzByhM9oh3NCck0A=;
        b=cJnGUKkb07rAV2HAVMgkTw6/T6N57GUEN+oLiKu5WPE17AONC2KLbRCfulEjZCsyE5
         6J0MFa/KqpMVlhuknuA7uyM8Klbn9Qn6KTNVHs11Uijj/gBJfrixx0S4AZhLIT9QqbeA
         HWVP83pCYKnmn8H1k8nac1qoRcdnYZhbovsxQy4ShP4PFSFC1lkxCeUmcZqDWDx8sWED
         7W6TzBFDOows5nXZjkcVCi1wB0ELj5JOBeqrw++Xwft49DKr3Wl5qf4GPzRGBxlxzmJm
         qd2zXNcZXYJGsyG8Z0WiivZkLc6Ku8+fw2JKHMwjI49EJqw2CJhuQK9o8FyZnnDfNLoC
         OyNA==
X-Forwarded-Encrypted: i=1; AJvYcCUmPXWVuYBas55ARjxDySNdZCAWFQ5bDg5ND40fr6k/ZeCfgxB1mBmSUeRpH03Y74IXaxPJsCV2gRtRApkhua+3BRzD+MGl6DDvEmuD3jVbx0qsX4UdgCTFZAcXAu4o/74+pdNYYysgiLq77YQnEm6nY7P01vpoeJc8CrUq9ndp9K/32MTzkdVomqLH0sWjb/AsBlibxxACm7OzvOTC5U4TfhswP/Kc9w==
X-Gm-Message-State: AOJu0YxHZRwPGFbutIy064Az0zkcl8D3g7NmFnIeUURXrz8ayL5GJHqX
	/znes2qWD3Yc1rjDox+LVbJM7Y8oZ1uecr5DyVhO49SjcbTZe3Wv
X-Google-Smtp-Source: AGHT+IHusve5yBDJq/XFnwBg2V+Vmg3WpZo51eIFcVWMMwJppFqQKmZbR+WS7jABk1wBgQwKzARILQ==
X-Received: by 2002:a05:6214:d89:b0:6a0:c903:7226 with SMTP id 6a1803df08f44-6b2afceb0edmr56977236d6.34.1718415194197;
        Fri, 14 Jun 2024 18:33:14 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c466ccsm25109666d6.71.2024.06.14.18.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 18:33:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EDBEC120006A;
	Fri, 14 Jun 2024 21:33:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 21:33:13 -0400
X-ME-Sender: <xms:WO9sZrGDr3M9yJFFMDoJ9j5Em_vWw7Drv280-eBlQPYlaGibXhk7gg>
    <xme:WO9sZoU0Lh_J7h98Ni7BCJSipSjkE79tfSc73niyD67_cguKhlcsfeVenWb8t-u-h
    yuGF_T6nI7bcjG9xw>
X-ME-Received: <xmr:WO9sZtIy2IE4IrSCLJE-CbjiLFfxbL50KUD0MwBMBdmWuo6y-YKAHiz8sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:WO9sZpG7McGJkiOf07Tr-3bcCX6gtcNCY-_kz4IWIdQ7KlQF9108Lw>
    <xmx:WO9sZhXnoNQAVua7VD6hOEsSalo_sw-exhJbV4h5kcn1tRLo-5zLuQ>
    <xmx:WO9sZkPeYdZl3MTjaltPRlg_9lw9L8mZWGB8tIUwJXcfhjb8PXKxsQ>
    <xmx:WO9sZg1mvadWOpGtoMoXTNjr030u-nHef8kJ9mJXaflX8OWj7oBbxQ>
    <xmx:WO9sZmXuAPjCCB3tzBS3vywJ9xRo7cfLWsePgDuHS0zIFlOc4x47UqJ7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 21:33:10 -0400 (EDT)
Date: Fri, 14 Jun 2024 18:33:10 -0700
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
Message-ID: <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>

On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
> On 14.06.24 16:33, Boqun Feng wrote:
> > On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
> >> On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>
> >>> Does this make sense?
> >>
> >> Implementation-wise, if you think it is simpler or more clear/elegant
> >> to have the extra lower level layer, then that sounds fine.
> >>
> >> However, I was mainly talking about what we would eventually expose to
> >> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> > 
> > The truth is I don't know ;-) I don't have much data on which one is
> > better. Personally, I think AtomicI32 and AtomicI64 make the users have
> > to think about size, alignment, etc, and I think that's important for
> > atomic users and people who review their code, because before one uses
> > atomics, one should ask themselves: why don't I use a lock? Atomics
> > provide the ablities to do low level stuffs and when doing low level
> > stuffs, you want to be more explicit than ergonomic.
> 
> How would this be different with `Atomic<i32>` and `Atomic<i64>`? Just

The difference is that with Atomic{I32,I64} APIs, one has to choose (and
think about) the size when using atomics, and cannot leave that option
open. It's somewhere unconvenient, but as I said, atomics variables are
different. For example, if someone is going to implement a reference
counter struct, they can define as follow:

	struct Refcount<T> {
	    refcount: AtomicI32,
	    data: UnsafeCell<T>
	}

but with atomic generic, people can leave that option open and do:

	struct Refcount<R, T> {
	    refcount: Atomic<R>,
	    data: UnsafeCell<T>
	}

while it provides configurable options for experienced users, but it
also provides opportunities for sub-optimal types, e.g. Refcount<u8, T>:
on ll/sc architectures, because `data` and `refcount` can be in the same
machine-word, the accesses of `refcount` are affected by the accesses of
`data`.

The point I'm trying to make here is: when you are using atomics, you
care about performance a lot (otherwise, why don't you use a lock?), and
because of that, you should care about the size of the atomics, because
it may affect the performance significantly.

Regards,
Boqun

> because the underlying `Atomic<I>` type is generic shouldn't change
> this, right?
> 
> ---
> Cheers,
> Benno
> 

