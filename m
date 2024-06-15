Return-Path: <linux-fsdevel+bounces-21742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E589095B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 04:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D1282C21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A010A2A;
	Sat, 15 Jun 2024 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcG5Okpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B02EAF6;
	Sat, 15 Jun 2024 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419580; cv=none; b=JDvnFgdd/A+niQ6jCpMYzjhAsDLW8bgtIn4WfmwJf+LLAH71F6d2xjPIFysOUlNt/unYVtu6jUBRAIgBQZofXQNcESLxTUht8eICw0lUto36gXXOT+HyZyvCIU6QFZaYbnFvWGjAebQlyhpQDinAFWjCo6nmKQoDerufJkTjuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419580; c=relaxed/simple;
	bh=CayOm4G1CctrOMeeJE+sX0Qmi5vmbd/5D18sZkUGXDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAEjLn1cvJnmleZYY+44bcdXlAiym2P/dhxETDq3eFtYX9RE7ITtjJ8DUmuHhY0VE0YpGp2xNt5HYDRrimIuoMIq5A8YSmultIXPee0pQqUWoQ+FDOqF1xnd4HDPa4L/bCws2RPTIS3r02WD51cUXGluFne/1rnlSzDodnPDkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcG5Okpe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-440530cadc7so16705771cf.0;
        Fri, 14 Jun 2024 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718419577; x=1719024377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OT2RssNaSUa1rWMkNzd+1pQBqOCAu8315Wi2zKuipi0=;
        b=CcG5Okpej1GIx/DOoCRUZi6IMWQh2WJek2aay5WQCoI0YExblU4otNqz1QWsP+Raoj
         xqx6O3VqqOPUr1/RinVV9krvBrF06H35HdBFphYaMgEvmv6DmhL+T3KIkG/w/bpTln9+
         YMdVDXFPqWCIFY2+v7VPKGzdXL/E/zI+RDA2J7eYPZqs2DMQrsn9WPrI2kY0HJ1Ccvda
         G2cgb6PR+WwqA96lOSOi8BrUW0SKvwJWIs3ELfRR/Ygc/o8BGC/jlSabzHSV6Zs6Aadc
         a5xIax6XejxZ2gqgIDFe6ZYIXKGIk7wKPaWP6SCSTE1V+fyLyBKWlPgA59TVyVQHn1tX
         U2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718419577; x=1719024377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OT2RssNaSUa1rWMkNzd+1pQBqOCAu8315Wi2zKuipi0=;
        b=rRLd6+xkUJXNN1OXtcPATQEGKSCoxg0e0vQ9d26YxLbj/phl874ka1ZmGf7to+eb1i
         xYg7ohJBbkYH+hAtJHexIQjaz9MrcyDtvdBhjDRmAppwTfgSyc5du8CJLvDCgWLsJSsy
         rn5kMPBbZli48QHHKfBQbhyGd29Ac+cKnhdzaWM6RqCBzrjYvQj7r0fdx3QVe2ymAEzh
         494j591TEg8yLJpyv39w2CtZ468YovepRJU1xfH8TEKWY75w3keet/xXKxCVXyi1ekfg
         KbVr7v7/YEdjL0BoAqowKWGz1WzSmOn4kXf7y0nhfjSKBFnlq/62GMpk0FhwDg2RhrG0
         U2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX613EAkWg2q8Gp+yGzsnCSiApdsboi2Atblk2sqspY0Yasp1urko+keosV8MIHLCN9Kkhp1gCgHTy5iFaGeQYdNuGVNrWAWHC0cfP2wgvuRaKLWiEysURdB7TaDpejTJKOsOYF6AzJOZZotLDt5JTHznqka84f2vGiN4o5zhcd7GpzCeZUF7YEvqcHM/flU9BGzDHXBB5Qvx+DyU7U88lK3a79XMAjtA==
X-Gm-Message-State: AOJu0Yz0LVPibtUvgnqUO0Ay+tzKQNnZClUndgib1me8FtPtWrUN9nYP
	cRF92g+R/+RS028a6vMUMOBX3PNoJc9GlSIb2ToJ3wCDEl6uGxAt
X-Google-Smtp-Source: AGHT+IG3nzFdI5+53c3/xvx6gEm8fdTfMr49LEKpg9JdpL+E4lnmp5VenTGHRK+8HEy1H5IpoWTJsA==
X-Received: by 2002:a05:622a:3cf:b0:441:1536:2fb2 with SMTP id d75a77b69052e-442168fc2a2mr45239521cf.5.1718419577401;
        Fri, 14 Jun 2024 19:46:17 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4fe986sm22655881cf.33.2024.06.14.19.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 19:46:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id CAF0C120006A;
	Fri, 14 Jun 2024 22:39:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Jun 2024 22:39:30 -0400
X-ME-Sender: <xms:4v5sZiCIkC7OszPaUMssT74wKmoECu4NE3RGQzb4_kL-fa3KTqBvVA>
    <xme:4v5sZsjRTDNULmmpq4LUBGajNRHiHpO44d6AHaheZfdWL7aP1aLnYujuVwmBpznVz
    5sLlwRaEkwmqRPLCw>
X-ME-Received: <xmr:4v5sZlla76dvvjrvfJE3piPANyg0H7c46z6K4hRNgykWR9spKeHvhQ5J6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgffgheejtdfhheehtdejffehgedujeekudfgieejledttedvvdeiuefg
    fedvffdvnecuffhomhgrihhnpegtrhgrthgvshdrihhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4v5sZgzaBElSuRsdP-fIruFKFOgjWwtV1baN426HYu8I6PfEIPzAOA>
    <xmx:4v5sZnRjSxrDCuN6DGH0_4-0MOYUdqTl-VxIZsMqeK6RcIRc2Oz78Q>
    <xmx:4v5sZrYsSrUFyWL_jSB8sb-y4KoJnCVTOzEV18gaRiSiQsbvUrF3Ww>
    <xmx:4v5sZgQfJlOXaOAh22tp-ts-48dH7scU06sYeeL82FDAZ0UPUuL_OA>
    <xmx:4v5sZpCZeb_TruU314g99fB0tIfDrUP-OMsFkOT3w92vuLSbwBGFHpa5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 22:39:29 -0400 (EDT)
Date: Fri, 14 Jun 2024 19:39:27 -0700
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
Message-ID: <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
 <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
 <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>

On Fri, Jun 14, 2024 at 06:28:00PM -0700, John Hubbard wrote:
> On 6/14/24 6:24 PM, Boqun Feng wrote:
> > On Fri, Jun 14, 2024 at 06:03:37PM -0700, John Hubbard wrote:
> > > On 6/14/24 2:59 AM, Miguel Ojeda wrote:
> > > > On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > 
> > > > > Does this make sense?
> > > > 
> > > > Implementation-wise, if you think it is simpler or more clear/elegant
> > > > to have the extra lower level layer, then that sounds fine.
> > > > 
> > > > However, I was mainly talking about what we would eventually expose to
> > > > users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> > > > then we could make the lower layer private already.
> > > > 
> > > > We can defer that extra layer/work if needed even if we go for
> > > > `Atomic<T>`, but it would be nice to understand if we have consensus
> > > > for an eventual user-facing API, or if someone has any other opinion
> > > > or concerns on one vs. the other.
> > > 
> > > Well, here's one:
> > > 
> > > The reason that we have things like atomic64_read() in the C code is
> > > because C doesn't have generics.
> > > 
> > > In Rust, we should simply move directly to Atomic<T>, as there are,
> > > after all, associated benefits. And it's very easy to see the connection
> > 
> > What are the associated benefits you are referring to? Rust std doesn't
> > use Atomic<T>, that somewhat proves that we don't need it.
> Just the stock things that a generic provides: less duplicated code,

It's still a bit handwavy, sorry.

Admittedly, I haven't looked into too much Rust concurrent code, maybe
it's even true for C code ;-) So I took a look at the crate that Gary
mentioned (the one provides generic atomic APIs):

	https://crates.io/crates/atomic

there's a "Dependent" tab where you can see the other crates that
depends on it. With a quick look, I haven't found any Rust concurrent
project I'm aware of (no crossbeam, no tokio, no futures). On the other
hand, there is a non-generic based atomic library:

	https://crates.io/crates/portable-atomic

which has more projects depend on it, and there are some Rust concurrent
projects that I'm aware of: futures, async-task etc. Note that people
can get the non-generic based atomic API from Rust std library, and
the "portable-atomic" crate is only 2-year old, while "atomic" crate is
8-year old.

More interestingly, the same author of "atomic" crate, who is an expert
in concurrent areas, has another project (there are a lot projects from
the author, but this is the one I'm mostly aware of) "parking_lot",
which "provides implementations of Mutex, RwLock, Condvar and Once that
are smaller, faster and more flexible than those in the Rust standard
library, as well as a ReentrantMutex type which supports recursive
locking.", and it doesn't use the "atomic" crate either.

These data could mean nothing, there are multiple reasons affecting the
popularity of a library. But all the above seems to suggests that you
don't really need generic on atomic, at least for a lot of meaningful
concurent code.


So if we were to make a decision right now, I don't see that generic
atomics are winning. Of course, as I said previously, we can always add
them if we have learned more and have the consensus.


(Don't make me wrong, I love generic in general, I just want to avoid
the "I have a generic hammer and everything looks like generic nails"
situation.)

Regards,
Boqun

> automatic support for future types (although here it's really just
> integer types we care about of course).
> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

