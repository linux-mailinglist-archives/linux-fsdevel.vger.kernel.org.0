Return-Path: <linux-fsdevel+bounces-15272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E988B6F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 02:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98521C34805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4176288DB;
	Tue, 26 Mar 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UQ3hSSuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0C1BF47;
	Tue, 26 Mar 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416955; cv=none; b=n3avQIgovji2+pqS+W7io2xUJmZACh0aswpA1jAruncqcjoyakwdV+08YeyL6wPvh8nphidHm0U2Ju8ypcykjpWC0hnX2jNcGkYRmEkffKoOuFjxKZ8WBE1fhwyyOtojgvsjpAO1mcq5VtdCa9ZSvBCiqOZ3DFb+GTGWSkdbrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416955; c=relaxed/simple;
	bh=Cto5rrUQ3AB9cCrvDWtrx00MykIQlk8+5ByUeyjpQz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s86e+9wXu5KPnXzgsir2KGjkci7T4bhYN7xKdxI9lkyQ0auDAflDnvxh1H6fUX7comckwBAWMNWOvpaJuhw7tp69iFTKz247sKyzCghJ0obZZZYkxcj1eQdIKClNqk7XjD38wn/lY7eXbSaliBNuiCznsBSybmuzWARq8ULbNxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UQ3hSSuq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=7MTd97O9BSApms3QxNYhwJPeXymy6xECMh8DYUL0Obg=; b=UQ3hSSuqboARrf6bU2CsIRc5oL
	FduPfMjLWW8VgJRnHBb/aTsKkN0ZxDd1/zcpZZvPrAxWEdiE81zkuQjxZFpHqyYlF6yTOGcOFllKj
	qrnQDtL4jmRGexVtVElsSnx4JjCi7Eezd+bstJYaXaSJ2BGXWn3BdihxAKiLf8mWM4vDX5+AGWPxl
	AWqnVEL6168JZrNbvDFkgyty8CDn/aUk1w8aJ/+vBH/mUAe9wvh4Nk3rV2qzjBAjunODJ4nuF7Wso
	zFo7KdMixQHRL8UvoW/PnQyPNKdGjqU1oFaHYS33bvOtMva1AyjvN+0sBTZC585ydAuuWE+EN4Gkn
	zziXhjAg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1rovj9-00EokP-00;
	Tue, 26 Mar 2024 01:35:47 +0000
Date: Tue, 26 Mar 2024 01:35:46 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZgImcq2vRcDZtF6z@gallifrey>
References: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <vevxfv67ureybf7sjwfxzdvl4tt62khyn2gfzn7o74ke2m554s@xxddzz6nurbn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <vevxfv67ureybf7sjwfxzdvl4tt62khyn2gfzn7o74ke2m554s@xxddzz6nurbn>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 01:29:31 up 83 days,  4:19,  1 user,  load average: 0.03, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kent Overstreet (kent.overstreet@linux.dev) wrote:
> On Tue, Mar 26, 2024 at 12:05:48AM +0000, Dr. David Alan Gilbert wrote:
> > * Linus Torvalds (torvalds@linux-foundation.org) wrote:
> > 
> > <snip>
> > 
> > > IOW, the whole access size problem that Boqun described is
> > > *inherently* tied to the fact that the C++ and Rust memory model is
> > > badly designed from the wrong principles.
> > > 
> > > Instead of designing it as a "this is an atomic object that you can do
> > > these operations on", it should have been "this is an atomic access,
> > > and you can use this simple object model to have the compiler generate
> > > the accesses for you".
> > 
> > Isn't one of the aims of the Rust/C++ idea that you can't forget to access
> > a shared piece of data atomically?
> > 
> > If you want to have 'atomic accesses' explicitly, how do you tell the compiler
> > what you can use them on, and when it should stop you mixing them with
> > normal accesses on the same object?
> 
> "can't forget to access data atomically" - that's only half of it. And
> atomic accesses loads/stores are not a thing under the hood, they're
> just loads and stores (possibly, but not necessarily, with memory
> barriers).

That's quite architecturally specific isn't it?
Or is this the distinction between accesses that are implicitly atomic
(i.e. naturally aligned word) and things that are locked/exclusive?
(either with a 'lock' on x86 or load-exclusive/store exclusive on some others)?
Which are we talking about here?

> The other half is at the _source_ level you don't want to treat accesses
> to volatiles/atomics like accesses to normal variables, you really want
> those to be explicit, and not look like normal variable accesses.
> 
> std:atomic_int is way better than volatile in the sense that it's not a
> barely specified mess, but adding operator overloading was just
> gratuitious and unnecessary.
> 
> This is a theme with C++ - they add a _ton_ of magic to make things
> concise and pretty, but you have to understand in intimate detail what
> all that magic is doing or you're totally fucked.
> 
> std::atomic_int makes it such that just changing a single line of code
> in a single location in your program will change the semantics of your
> _entire_ program and the only obserable result will be that it's faster
> but a ticking time bomb because you just introduced a ton of races.
> 
> With Rust - I honestly haven't looked at whether they added operator
> overlaoding for their atomics, but it's _much_ less of a concern because
> changing the type to the non-atomic version means your program won't
> compile if it's now racy.

OK, so that's essentially the opposite worry of what I was saying; I was
worrying about people forgetting to use an atomic access to a shared
variable; I think you're worrying about people forgetting to mark
a variable shared and since the accesses are the same nothing shouts?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

