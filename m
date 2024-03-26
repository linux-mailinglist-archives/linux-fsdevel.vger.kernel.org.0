Return-Path: <linux-fsdevel+bounces-15348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD788C53B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FFD1F3DDCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE513C3DF;
	Tue, 26 Mar 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DeikNxfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8180C12;
	Tue, 26 Mar 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463728; cv=none; b=aaD5Z8BgM3g97IsHi3P16od05bB90Ip9N3IjpBkoYzulv+Q2NCtHgtRYEue2Hww7yG5CzLjHzonREIZXebCC2TNCVlix0gNBO0N5DvF9J2+kezIVu3AnZfBZY85SlKkQtYRARNZzsZUs0vn533OdF8NWq7ySWFob+oSgQSFRJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463728; c=relaxed/simple;
	bh=G4VayLkDEdgGiDy8YMVdGzeBmWHF8revmHJsqsrO5+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEDv20bmLDybonU8p/kRc+Fzj1tVqrlrhmNyPlh8EjOu1wS5lPZGHONwwvWt4VOrmf0vrUVXi1N2XvresZwMRuWR4y86FE2g1/CRtju9De320p4CbVMsbSBPdA5kc3PP6T76PZnzrZ7gH1NL/Ls9R8yP9ls8dhIKF1MUXSC5Qts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DeikNxfH; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
	:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=2SVrI5jZNwjEti7fw19FvDvELk09Rp4DU6fIvhzRuqc=; b=DeikNxfHevZv6bG0ypUdd4QEVo
	I334M9MJfjVTwzjB5W/+c8j7w0EXJWHbvBnR4M20jaWqZAGybfZZCFgT41Ffgi4rE6fDMgxy4pov2
	LTAXZCe3z1bBvFXmG4S3F2nIl28mm8ITnduc1F7kNlDOjYFAc0kgEVsbXraPezLVrZilvOqjMhGAP
	+Ofb+xNOnl+1AF6+UgXzjpQ8YWdVRntupIBjCQkRFTFjLjifbKiCi2OXspZoPcxQ3whohfO+C+D1h
	IFiRwDWQshQKeJ9vRvWYkBSkfLy563bks+Lvx1ePOQI7jtOHk1VpPB+LDkTqHgVyWEM4X3xievIHh
	3DIV/WNA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1rp7tX-00Ew6P-2G;
	Tue, 26 Mar 2024 14:35:19 +0000
Date: Tue, 26 Mar 2024 14:35:19 +0000
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
Message-ID: <ZgLdJwx1Mld-MJeX@gallifrey>
References: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 14:11:37 up 83 days, 17:01,  1 user,  load average: 0.15, 0.06, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Linus Torvalds (torvalds@linux-foundation.org) wrote:
> On Mon, 25 Mar 2024 at 17:05, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> >
> > Isn't one of the aims of the Rust/C++ idea that you can't forget to access
> > a shared piece of data atomically?
> 
> If that is an aim, it's a really *bad* one.
> 
> Really.
>
> It very much should never have been an aim, and I hope it wasn't. I
> think, and hope, that the source of the C++ and Rust bad decisions is
> cluelessness, not active malice.

Oh that hit a nerve :-)

> Take Rust - one big point of Rust is the whole "safe" thing, but it's
> very much not a straightjacket like Pascal was. There's a "safe" part
> to Rust, but equally importantly, there's also the "unsafe" part to
> Rust.
> 
> The safe part is the one that most programmers are supposed to use.
> It's the one that allows you to not have to worry too much about
> things. It's the part that makes it much harder to screw up.
> 
> But the *unsafe* part is what makes Rust powerful. It's the part that
> works behind the curtain. It's the part that may be needed to make the
> safe parts *work*.
> 
> And yes, an application programmer might never actually need to use
> it, and in fact in many projects the rule might be that unsafe Rust is
> simply never even an option - but that doesn't mean that the unsafe
> parts don't exist.
> 
> Because those unsafe parts are needed to make it all work in reality.
> 
> And you should never EVER base your whole design around the "safe"
> part. Then you get a language that is a straight-jacket.
> 
> So I'd very strongly argue that the core atomics should be done the
> "unsafe" way - allow people to specify exactly when they want exactly
> what access. Allow people to mix and match and have overlapping
> partial aliases, because if you implement things like locking, you
> *need* those partially aliasing accesses, and you need to make
> overlapping atomics where sometimes you access only one part of the
> field.
> 
> And yes, that will be unsafe, and it might even be unportable, but
> it's exactly the kind of thing you need in order to avoid having to
> use assembly language to do your locking.
> 
> And by all means, you should relegate that to the "unsafe corner" of
> the language. And maybe don't talk about the unsafe sharp edges in the
> first chapter of the book about the language.
> 
> But you should _start_ the design of your language memory model around
> the unsafe "raw atomic access operations" model.
> 
> Then you can use those strictly more powerful operations, and you
> create an object model *around* it.
> 
> So you create safe objects like just an atomic counter. In *that*
> corner of the language, you have the "safe atomics" - they aren't the
> fundamental implementation, but they are the safe wrappers *around*
> the more powerful (but unsafe) core.
> 
> With that "atomic counter" you cannot forget to do atomic accesses,
> because that safe corner of the world doesn't _have_ anything but the
> safe atomic accesses for every time you use the object.
> 
> See? Having the capability to do powerful and maybe unsafe things does
> not force people to expose and use all that power. You can - and
> should - wrap the powerful model with safer and simpler interfaces.

I'd agree it's important to get the primitives right; but 
I'd argue that from a design point of view it's probably better to keep
both in mind from early on; you need to create a safe interface which
people can actually use most of the time, otherwise you're not getting
any benefit; so yes get the bases right, but just keep a feel for how
they'll get encapsulated so most of the more boring code can be safe.

> This isn't something specific to atomics. Not even remotely. This is
> quite fundamental. You often literally _cannot_ do interesting things
> using only safe interfaces. You want safe memory allocations - but to
> actually write the allocator itself, you want to have all those unsafe
> escape methods - all those raw pointers with arbitrary arithmetic etc.
> 
> And if you don't have unsafe escapes, you end up doing what so many
> languages did: the libraries are written in something more powerful
> like C, because C literally can do things that other languages
> *cannot* do.

Yeh that's fine, I'm not at all arguing against that; but it doesn't
mean you shouldn't keep an eye on how the safe side should look; even in the
kernel.
Get it right and those unsafe escapes shouldn't be needed too commonly;
get it wrong and you'll either have painful abstractions or end up with
unsafes shotgunned all over the place.

> Don't let people fool you with talk about Turing machines and similar
> smoke-and-mirror garbage. It's a bedtime story for first-year CS
> students. It's not true.

My infinitely long tape is still on back order.

Dave

> things. If your language doesn't have those unsafe escapes, your
> language is inherently weaker, and inherently worse for it.
> 
>            Linus
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

