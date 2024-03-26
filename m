Return-Path: <linux-fsdevel+bounces-15268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0826488B65D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3CB287C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 00:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C831C691;
	Tue, 26 Mar 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UEqU8gaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5622F5E;
	Tue, 26 Mar 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711414187; cv=none; b=PiSFtbcINPRJfrXdLD/AzGezBZjseZNFekB1RGzrVOXSK789cmPtWFFK1fTt4ppLP9I9GeFEB8vdwILewckMunRRyp0bO+fqwM0Os5NXXhzLkczPH3aVjzlwhpg9ooNeFYM0ejD61QToM9pXyV7YHAaIQIRE5KexphO3xBS+xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711414187; c=relaxed/simple;
	bh=J28s9rQt90wDxj1wBF0s5KRA+1w6ylx+IcrcZNAD8Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPC5up8+fmrsT1a3WzqHKn8ga06sW6xr0bHZen7pK6nBnRFzBqtDh/vmj0T0GmXhS21warX5GsCcA2htnYBnhz0o0bAZGgaSlCr+uW/pwyOmaAn0JtzPsrohD3QuVCvPQDhYJtN+mxZLWPSS8znOrbw2KNxQA/R0fiYCNgQMWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UEqU8gaE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=LuYyrQMyWGMOwe8OrvTO4BN9gtnvAnON7zt9Ixqpfy0=; b=UEqU8gaEALfh/lsLw+pY5zIQ1T
	u896m8WTJTPLEHXWOSyX1qPnueTSgnIxfehy+byLJsQLrgGHw4d8JQ6EblAPMq7jGVTLOt0K1alZx
	oQecvQaVl2mxSAHuF7TedHkyzZ9hiS2/a09IQMVLdCjwD4GcjxCns7UnSmMkeH4fNUn7ATq+fa2yC
	9CAkKcPP0Pn98exNRcHhoehv9QokTjjh3mbKywqZnUIWQE0O1OZYRREakW+ND9T45s3qO47Tn8oLA
	eyTnVae4NYSI9MpNo6R8dA+MnUegCBPqlvlr///B9QukS35jW7/ASDytmPo37OtHriDk5fGzW7Fnr
	ox6qMM2Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1rouK4-00EnsC-1H;
	Tue, 26 Mar 2024 00:05:48 +0000
Date: Tue, 26 Mar 2024 00:05:48 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
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
Message-ID: <ZgIRXL5YM2AwBD0Y@gallifrey>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 00:03:19 up 83 days,  2:53,  1 user,  load average: 0.06, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Linus Torvalds (torvalds@linux-foundation.org) wrote:

<snip>

> IOW, the whole access size problem that Boqun described is
> *inherently* tied to the fact that the C++ and Rust memory model is
> badly designed from the wrong principles.
> 
> Instead of designing it as a "this is an atomic object that you can do
> these operations on", it should have been "this is an atomic access,
> and you can use this simple object model to have the compiler generate
> the accesses for you".

Isn't one of the aims of the Rust/C++ idea that you can't forget to access
a shared piece of data atomically?

If you want to have 'atomic accesses' explicitly, how do you tell the compiler
what you can use them on, and when it should stop you mixing them with
normal accesses on the same object?

Dave

> This is why I claim that LKMM is fundamentally better. It didn't start
> out from a bass-ackwards starting point of marking objects "atomic".
> 
> And yes, the LKMM is a bit awkward, because we don't have the
> shorthands, so you have to write out "atomic_read()" and friends.
> 
> Tough. It's better to be correct than to be simple.
> 
>              Linus
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

