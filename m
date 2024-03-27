Return-Path: <linux-fsdevel+bounces-15481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F2588F14F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 22:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4C21C32489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E418153576;
	Wed, 27 Mar 2024 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mtf5vAQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4630153575
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576192; cv=none; b=MgJqJIXJjyLsoFa0kXbL+pEh+475Pvaobozk1KXb/DAsuJ8eM8tFqjuThFJKEcijVQ1XqpEPfLs2BhCqZceDUERrYom9wC9nzel0SDZtsAT5RbmNg2BFhXzyM9RFkuZfOJp9/QMFXDVg/5sXhe3M04lu10Eb4k8gKxR4Zbwt8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576192; c=relaxed/simple;
	bh=9Zl+I9A453cdMrWhPhzO+VutQ/fMadKGy8JNLSWoVfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhBCKDWHQ23p1G1VTmjZb6k8h1F7qD8KAx5zD38uF/JESK7SuqGUckLQ8CQba3UYdHncCVuActJWizUisMGdqqPIFzMfEE9bVFqj8RDjmm0Xa5582gYb9KNZNq7LaKtS3IYpGSCeXVjVdK8h8AbPeaL1fGVn85QWOeVUHe1YcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mtf5vAQM; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Mar 2024 17:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711576188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fq3QMnxkMVCH8b0951Wxyyz2XZrmXpoRDVmVHWK2mo=;
	b=mtf5vAQMnc/zscKPRaqv0R+DY2HacdeTfyNhobDQF4X1GygrV58z9wRqsYUMbpUE1AM1WW
	EY70Rs8bjoRdXGG3IC948oIoowv/mvLSvihXACjQ1fBoFdTTikz2CcI+DCTj9l8x7pZlRq
	32ud8GjxancHf9QZsNGCSK39S7YCrFU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <iurfeuqq5hfwhv66d2wozlzv24avyypgtgoqpmorghmimzqwur@zj2qfot47d76>
References: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <ZgSNvzTkR4CY7kQC@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgSNvzTkR4CY7kQC@boqun-archlinux>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 02:21:03PM -0700, Boqun Feng wrote:
> On Wed, Mar 27, 2024 at 03:41:16PM -0400, Kent Overstreet wrote:
> > On Wed, Mar 27, 2024 at 12:07:26PM -0700, Linus Torvalds wrote:
> > > On Wed, 27 Mar 2024 at 11:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Wed, Mar 27, 2024 at 09:16:09AM -0700, comex wrote:
> > > > > Meanwhile, Rust intentionally lacks strict aliasing.
> > > >
> > > > I wasn't aware of this. Given that unrestricted pointers are a real
> > > > impediment to compiler optimization, I thought that with Rust we were
> > > > finally starting to nail down a concrete enough memory model to tackle
> > > > this safely. But I guess not?
> > > 
> > > Strict aliasing is a *horrible* mistake.
> > > 
> > > It's not even *remotely* "tackle this safely". It's the exact
> > > opposite. It's completely broken.
> > > 
> > > Anybody who thinks strict aliasing is a good idea either
> > > 
> > >  (a) doesn't understand what it means
> > > 
> > >  (b) has been brainwashed by incompetent compiler people.
> > > 
> > > it's a horrendous crock that was introduced by people who thought it
> > > was too complicated to write out "restrict" keywords, and that thought
> > > that "let's break old working programs and make it harder to write new
> > > programs" was a good idea.
> > 
> > Strict aliasing is crap in C and C++ because we started out with
> > unrestricetd pointers, and it just doesn't work in C and C++ with the
> > realities of the kind of code we have to write, and we never got any
> > kind of a model that would have made it workable. Never mind trying to
> > graft that onto existing codebases...
> > 
> > (Restrict was crap too... no scoping, nothing but a single f*cking
> > keyword? Who ever thought _that_ was going to work?)
> > 
> > _But_: the lack of any aliasing guarantees means that writing through
> > any pointer can invalidate practically anything, and this is a real
> 
> I don't know whether I'm 100% correct on this, but Rust has references,
> so things like "you have a unique reference to a part of memory, no one
> would touch it in the meanwhile" are represented by `&mut`, to get a
> `&mut` from a raw pointer, you need unsafe, where programmers can
> provide the reasoning of the safety of the accesses. More like "pointers
> can alias anyone but references cannot" to me.

That's not really a workable rule because in practice every data
structure has unsafe Rust underneath. Strict aliasing would mean that
unsafe Rust very much has to follow the aliasing rules too.

