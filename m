Return-Path: <linux-fsdevel+bounces-21712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AEC908D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 16:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C52228BE97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B1EAFA;
	Fri, 14 Jun 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWvTq06a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C9C132;
	Fri, 14 Jun 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374716; cv=none; b=cuFZHIOhtSKKVArpqIyRmGWzufFAonJetC+DQQRUBW95scB19DJwnUMC7R7ofpiQgs+MJfqkq1uXZdK3lZpL5wK9m8tTsFJ58dESG57rMWP8d3ftUBmjwMdUCMFAqLFIKAJD2ilQr4pC8vOCcBFYjfWornkPgx96aGXwDxMXhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374716; c=relaxed/simple;
	bh=AzsmAzBa3FyhGwMJs7CFC6ijvLpC7MBVBXc1nB27RF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi8una/Vv/1K0S0ybV4V1fZ8os133RsAfgRj+gB3aqgV/5UUK97KZcT0flH7A4Z1xX1UlZKSsr5/o8S80f/xDv5w1/5TCqjUJ1WVKcH8g9Bi0N+hrJvRwLm86nKZ4tW9ryfXeLpEHMvR8FmYnJNCWHRMmBChRHsp+nfVP9wSEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWvTq06a; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5baf982f56dso1254701eaf.3;
        Fri, 14 Jun 2024 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374714; x=1718979514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sjDmlk8xndLaxRABwpUKDEvjWtvENBQR7ofiVHlQf8=;
        b=DWvTq06aN5b2L+D3aFKUlV3NlsNgrqVTfLx2vVkPxxuDb+/cTv97LjM6BlIpmG6vYw
         tvgb2TYcZ9VyWwP/apQLVOe5Ss+SWZRxAqzmcouIkHFMlzhrU0zqnoP22bfx2RdZbMPq
         1NttgrU12Y/nGRqc03FnrrdqfyRvonXK4glRLAxV3+Q7jgSAgGbWXDgqiXuizIQmIIHw
         pXMpfceDdwuL0aZi4e3F9ULD9RFqyUEdI9rIctYYqSBMndB97a0o0FW96T2HG2QYuJ1L
         JECKKe8QLUUe5YZOUDNfLZW3ViAmeTbRDgm94NfdDHeE8Yx+UhulvSjseUMFXnnWkuY9
         AN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374714; x=1718979514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sjDmlk8xndLaxRABwpUKDEvjWtvENBQR7ofiVHlQf8=;
        b=gZEQ7IzsZBww6nuHvBdzcgBTPmBCBZY+UHIWtCyo4ucG1mp4AlDeQOJmQLFivPoOGQ
         0hMykkPk8odFH8l/vr8VnrvHJTPsY5YlZXE9Sc4tYp4No46cnudMDhVkXDtx1Vf8ZQn/
         cAvJPMBS8hZ52d0rec+qzDmEmkI4ZIz3f6ZwM0+utCWLXAOHOQRFxZ3BO7Pq1Z6osTE2
         7a6sZFiHsjk07FzgxKPgtA2xLTBhn86Rgxso9nVNCoFVArKxizRRekrAeX6Uq62HgciE
         1q414S9VmbHeOmpw3e4cHek9g5+TFGJ75IJa8EiNOSLZq/Hg38QJBOh4u+rug0rOeUwu
         lYNA==
X-Forwarded-Encrypted: i=1; AJvYcCXxzZT6Rs6Lcqsw0gLI+qslFy5QPf8m2f/1iR+LS7FuPG7e5bP8VxlB+OnR/pRsASoD/OvQP8aG0BT3QvfSMWF5LyNydzZjcgEzNotX3G54GCf5Ls5oIQ7O+MQk/iWKyxSrlkzMUzCBv3o99vdo2RC2bB3egOUUdAJeudrPeZePX4MqJ/yqHUsHoNEJmXrDnc4tKjGdqy2wr41+BFSAqvpU0E4oUL45pg==
X-Gm-Message-State: AOJu0Yx3bwl5z48sIj+0etNrbUmis5wLjswlioY+3eKDTckMEJQpB3ox
	RBnTa0S7n/7lzinf0KP/ZVmcrTuxiD5Laou/QBXK2tMd30nX4t4f
X-Google-Smtp-Source: AGHT+IHksCM6QMMN5oCKowkEIaoVhI9skWX8S0kfwKK9ws9t3YFTdPmgNyYWeEUIfdx/qQgRrfSgkw==
X-Received: by 2002:a4a:344e:0:b0:5bd:b100:8ab1 with SMTP id 006d021491bc7-5bdb1008d1bmr1669345eaf.7.1718374714251;
        Fri, 14 Jun 2024 07:18:34 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c1ff4fsm18535236d6.47.2024.06.14.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:18:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B89AD1200068;
	Fri, 14 Jun 2024 10:18:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Jun 2024 10:18:32 -0400
X-ME-Sender: <xms:OFFsZq-MDNYEtrWlAVNXn5jwIg2TfvjhwFoZOkk6yrCqSXCRqQqkQQ>
    <xme:OFFsZqs8ByWvlfpKaf4EKh9YvnHUXjakTr8WzjsHKnQcmFt6z4SmMP-RofnZ4thhx
    U82WO1A5RNTdZYrgg>
X-ME-Received: <xmr:OFFsZgDPmnMk4EopChbpPpI_2yy6dm6Uy_o9XbGFJK-zZB6IXMb8XdEDHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:OFFsZiePx2emfcxiTWodZ11l2uuHwCaxesAzyJKoseaY7n36pBEWYw>
    <xmx:OFFsZvPBzICQ22UxPNB4-q9ZjldwOttwiuMvjv0Kr21Y2h392GsUZw>
    <xmx:OFFsZsmCWdQYsGwRiqbToXL47qfVLgMuY4Z6PufSEHyWHrdKqDCA0A>
    <xmx:OFFsZhvXhif1LhrT9WOTaXBNgrfWLwNPAwGFIGWrXNjzrF2NEccmzw>
    <xmx:OFFsZlulQLnfhLEy8-5lMnjAa0Ufl-7BrHGo-ZZJmlK_d7uhAYvoowqn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 10:18:31 -0400 (EDT)
Date: Fri, 14 Jun 2024 07:18:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZmxRNgrLz2fzZDSw@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <20240614095124.GN8774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614095124.GN8774@noisy.programming.kicks-ass.net>

On Fri, Jun 14, 2024 at 11:51:24AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 13, 2024 at 09:30:26AM -0700, Boqun Feng wrote:
> 
> > We can always add a layer on top of what we have here to provide the
> > generic `Atomic<T>`. However, I personally don't think generic
> > `Atomic<T>` is a good idea, for a few reasons:
> > 
> > *	I'm not sure it will bring benefits to users, the current atomic
> > 	users in kernel are pretty specific on the size of atomic they
> > 	use, so they want to directly use AtomicI32 or AtomicI64 in
> > 	their type definitions rather than use a `Atomic<T>` where their
> > 	users can provide type later.
> > 
> > *	I can also see the future where we have different APIs on
> > 	different types of atomics, for example, we could have a:
> > 
> > 		impl AtomicI64 {
> > 		    pub fn split(&self) -> (&AtomicI32, &AtomicI32)
> > 		}
> > 
> > 	which doesn't exist for AtomicI32. Note this is not a UB because
> > 	we write our atomic implementation in asm, so it's perfectly
> > 	fine for mix-sized atomics.
> > 
> > So let's start with some basic and simple until we really have a need
> > for generic `Atomic<T>`. Thoughts?
> 
> Not on the generic thing, but on the lack of long. atomic_long_t is
> often used when we have pointers with extra bits on. Then you want a
> number type in order to be able to manipulate the low bits.

I mentioned my plan on AtomicPtr, but I think I should have clarified
this more. My plan is:

pub struct AtomicIsize {
    #[cfg(CONFIG_64BIT)]
    inner: AtomicI64
    #[cfg(not(CONFIG_64BIT))]
    inner: AtomicI32
}

i.e. building AtomicIsize (Rust's atomic_long_t) based on AtomicI64 and
AtomicI32. And we can a AtomicPtr type on it:

pub struct AtomicPtr<T> {
    inner: AtomicIsize,
    _type: PhantomData<*mut T>
}

Of course, I need to do some code generating work for AtomicIsize and
AtomicPtr, I plan to do that in Rust not in scripts, this will keep the
rust/kernel/sync/atomic/impl.rs relatively small (i.e. the Rust/C
interface is smaller). I can include this part in the next version, if
you want to see it.

Regards,
Boqun

