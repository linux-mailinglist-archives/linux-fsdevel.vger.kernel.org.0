Return-Path: <linux-fsdevel+bounces-15277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5343288B87D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 04:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB2B1F3E6F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE686129A69;
	Tue, 26 Mar 2024 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iPRgLzgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF55128381;
	Tue, 26 Mar 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423730; cv=none; b=cRmye+RqwMhARjAABOJh277T1hocC8RlMemaFHouUezGsX+WYm9hFYK0ge1e20wS16So5V51otftGVhxsdo+BmRB+Hp+E42FjxoUkPDNAPDCRTtmHEY1mNN1GcfZdyIb567oKOSBSjmx9TM2N1rYhyv9SwyyC1/DYWoP01XO06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423730; c=relaxed/simple;
	bh=zbz8JSdX4HImrXyDSvkZNWHjmt/U+lnpC2qNDFF4hDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d22Necv/EMbCiC2O78+/kDp2kos5IQJpAAnVe9JrkCDlb7wRm2fP3RWkruaObTB/pETgCuvDGsQ/5cmHuvVqSzfGw6LPubQe0tYcc7XGF+xcBRlry0p4pQ5moonuN7C+H93juMnyPsjKfUGUMndYdnJr5dhl4Tw3/N+c//Aq3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iPRgLzgy; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 23:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711423726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zbz8JSdX4HImrXyDSvkZNWHjmt/U+lnpC2qNDFF4hDk=;
	b=iPRgLzgyqe8KY1dSoWPYlt/aLh26NUBnBpny3uA+K8hQM6biRkS8YxVymU+AB0tgmAfTHH
	VbEu5miz1s3JErGsWakBsX2Unnpvso/q0bxFyUZTzY70FSuse4dOSVWy2xyabsWKBeP95k
	xdeHD23g82UYYfGhnWk/GMILpw/WhTE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <iobxouxkp3yf5vna7fy2bfvwknhghmzevty645xpbdjwefxxrj@3ac4ewjezv3l>
References: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <vevxfv67ureybf7sjwfxzdvl4tt62khyn2gfzn7o74ke2m554s@xxddzz6nurbn>
 <ZgImcq2vRcDZtF6z@gallifrey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgImcq2vRcDZtF6z@gallifrey>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 26, 2024 at 01:35:46AM +0000, Dr. David Alan Gilbert wrote:
> OK, so that's essentially the opposite worry of what I was saying; I was
> worrying about people forgetting to use an atomic access to a shared
> variable; I think you're worrying about people forgetting to mark
> a variable shared and since the accesses are the same nothing shouts?

In biological evolution, novel useful traits are generally not
accessible via a single mutation; many neutral mutations are required
first.

Evolution is able to proceed quickly because there are a great many
neutral mutations (that is, evolution quickly searches all possible
paths to find accessible positive mutations), and because negative
mutations are culled quickly - often before the first cell division.

(The most common mutation being the addition or deletion of a base pair;
but amino acids are coded for by groups of three base pairs, so that
shifts everything on the chromosone after the mutation so that it codes
for completely different amino acids. That cell won't live to divide
again).

Actual genetic diseases that significantly impair fitness are quite
rare, and if they weren't we'd have a major problem.

Programming at scale is million monkeys stuff - we're all hammering on
our keyboards at random, the good programs survive and the bad programs
are forgotten.

Similarly to biological evolution, we want most edits to a program to
result in a program that either still works, or fails immediately -
fails to compile, or is caught immediately by basic testing.

If edits can result in latent undefined behaviour or programs that
_mostly_ work, and then explode in unpredictable ways weeks/months/years
later - that's a huge problem. In the worst case, those bugs/negative
mutations accumulate faster than they can be culled.

Thank god we have source control.

Places where we're working with extremely loose synchronization - no
locking, raw memory barriers - are the worst kind of hand grenade, they
result in bugs that are impossible to cull quickly.

In kernel programming, we're always walking around with live hand
grenades.

So what do we do?

We slow down, we take every step slowly and intentionally while telling
everyone not to bump us because we're holding a live hand grenade - raw
atomics, raw unlocked variables, memory barriers, they all get special
care and extra comments.

And we all have fuck-tons of code we need to be able to understand,
review, debug and maintain, so we always try to write our code in a
style where the if it's wrong, we'll see that _locally_, without having
to go through and remember how _everything_ out of the possibly
thousands of relevant lines work.

I'm personally responsible for over 100k LOC of highly intricate code
with high consequences for failure, and regularly have to debug issues
arising somewhere in north of a million LOC - and when something goes
wrong I have to be able to fully debug it _quickly_.

What C++ does is like taking those hand grenades, with the pin already
out - and leaving one under the couch cushions, another in the
silverware drawer, another in the laundry basket - and expecting you to
remember where you put them.

Going back to the C++ example, the really fatal thing with how they do
it is how a change in one line of code can completely change the
semantics of a bunch of different code, and no human reviewer can be
expected to catch bugs that might introduce and the compiler certainly
won't.

Now imagine multiple people working on the same code, at different
times.

Now imagine patches getting mixed up, reordered, one of them getting
lost, merge conflicts - i.e. shit that happens all the time, and what
happens if you're using C++ style atomics.

Terrifying stuff.

