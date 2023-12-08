Return-Path: <linux-fsdevel+bounces-5349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364F80AC2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767DF1C20752
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60223C068
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlOPMzwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA998;
	Fri,  8 Dec 2023 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+bKWbY0TFFFJG7vCNdsapguiWXk5Tcdbxhr2FyThgV4=; b=IlOPMzwGrh/jGe5Kiyfmvz91r2
	DMe8pUz8Wq3s7w2GLz1XHY4A9XDGCfk8/cVEQOmWA48/RiYZAMXOFYmmFcYkZDbQ5h502Wb3TteF8
	J+eVsnXCtfTIqVDaqmNfQaeBL86u5r2eivNqXVdqQpxBYVdwzmBs1BA8ZCzTCsdSRbxTyZ1USB4J9
	WncYy/GVXmd4+KowpHmPKlrXohHcN4yI5nLjOt0B0uwCa+az5Q3b1GwQobVLUap62blhtXCZj5CqS
	L1pdQEwmXmBrsIwdIpFqU3ZwVZtB7ZPqAn6DPNNDcZ9YYoiHW7fcc5aBqNppVII1H9it+czae4xK0
	Ekm1eL/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBe9v-0066Wi-1l; Fri, 08 Dec 2023 16:57:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2652A3003F0; Fri,  8 Dec 2023 17:57:02 +0100 (CET)
Date: Fri, 8 Dec 2023 17:57:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231208165702.GI28727@noisy.programming.kicks-ass.net>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
 <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>

On Fri, Dec 08, 2023 at 05:31:59PM +0100, Miguel Ojeda wrote:
> On Wed, Dec 6, 2023 at 2:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Anywhoo, the longer a function is, the harder it becomes, since you need
> > to deal with everything a function does and consider the specuation
> > window length. So trivial functions like the above that do an immediate
> > dereference and are (and must be) a valid indirect target (because
> > EXPORT) are ideal.
> 
> We discussed this in our weekly meeting, and we would like to ask a
> few questions:
> 
>   - Could you please describe an example attack that you are thinking
> of? (i.e. a "full" attack, rather than just Spectre itself). For
> instance, would it rely on other vulnerabilities?

There's a fairly large amount of that on github, google spectre poc and
stuff like that.

>   - Is this a kernel rule everybody should follow now? i.e. "no (new?)
> short, exported symbols that just dereference their pointer args". If
> so, could this please be documented? Or is it already somewhere?

Gadget scanners are ever evolving and I think there's a bunch of groups
running them against Linux, but most of us don't have spare time beyond
trying to plug the latest hole.

>   - Are we checking for this in some way already, e.g. via `objtool`?
> Especially if this is a rule, then it would be nice to have a way to
> double-check if we are getting rid of (most of) these "dangerous"
> symbols (or at least not introduce new ones, and not just in Rust but
> C too).

Objtool does not look for these (gadget scanners are quite complicated
by now and I don't think I want to go there with objtool). At the moment
I'm simply fixing whatever gets reported from 3rd parties when and where
time permits.

The thing at hand was just me eyeballing it.

> > That would be good, but how are you going to do that without duplicating
> > the horror that is struct task_struct ?
> 
> As Alice pointed out, `bindgen` "solves" that, but it is nevertheless
> extra maintenance effort.
> 
> > Well, I really wish the Rust community would address the C
> > interoperability in a hurry. Basically make it a requirement for
> > in-kernel Rust.
> 
> Yeah, some of us have advocated for more integrated C support within
> Rust (or within `rustc` at least).

\o/

> > I mean, how hard can it be to have clang parse the C headers and inject
> > them into the Rust IR as if they're external FFI things.
> 
> That is what `bindgen` does (it uses Clang as a library), except it
> does not create Rust IR, it outputs normal Rust code, i.e. similar to
> C declarations.

Right, but then you get into the problem that Rust simply cannot express
a fair amount of the things we already do, like asm-goto, or even simple
asm with memops apparently.

> But note that using Clang does not solve the issue of `#define`s in
> the general case. That is why we would still need "helpers" like these
> so that the compiler knows how to expand the macro in a C context,
> which then can be inlined as LLVM IR or similar (which is what I
> suspect you were actually thinking about, rather than "Rust IR"?).

Yeah, LLVM-IR. And urgh yeah, CPP, this is another down-side of Rust not
being in the C language family, you can't sanely run CPP on it. Someone
really should do a Rust like language in the C family, then perhaps it
will stop looking like line noise to me :-)

I suppose converting things to enum and inline functions where possible
might help a bit with that, but things like tracepoints, which are built
from a giant pile of CPP are just not going to be happy :/

Anyway, I think it would be a giant step forwards from where we are
today.

> That "mix the LLVM IRs from Clang and `rustc`" ("local LTO hack")
> approach is something we have been discussing in the past for
> performance reasons (i.e. to inline these small C functions that Rust
> needs, cross-language, even in non-LTO builds). And if it helps to
> avoid certain attacks around speculation, then even better. So if the
> LLVM folks do not have any major concerns about it, then I think we
> should go ahead with that (please see also my reply to comex).

But does LTO make any guarantees about inlining? The thing is, with
actual LLVM-IR you can express the __always_inline attribute and
inlining becomes guaranteed, I don't think you can rely on LTO for the
same level of guarantees.

And you still need to create these C functions by hand in this
local-LTO scenario, which is less than ideal.

