Return-Path: <linux-fsdevel+bounces-164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BA7C6B6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0121C21027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3B208D5;
	Thu, 12 Oct 2023 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lw5xjJoO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140F12E43;
	Thu, 12 Oct 2023 10:48:26 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB8BD3;
	Thu, 12 Oct 2023 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XBhUlLUXpFNiQjcNWmFNytrRub9YUYcuDDd8SJGbp9M=; b=Lw5xjJoOsrdpqAGlBpja1izi61
	modJ6b3F4IEVl9yWwMiyNTdVDHS8KTsti7HMPTMM0BTIcdH5Qw1ceOJjlpH6OvOJzA8BWjz9lCO8u
	0JKk5o5FvEvmIcNxOer2v/BzfJeZtIlYiYXSxYL5680TwVUpEJhu9G41pL5BJc0xFYZ0QO2SIJfO2
	e50Q/LO4jvU4iHP8ilGx8/E6yAsF0RcFoNbSGTGxmwLUbYpLnPrnRbMUFs+3zXf/lg784hwvDrg2B
	cvew0YRQLU1UlK1xtJINQcK2tbgSIyAATDxShiiW4YeszBf/Yt081QQg19xEBA5dWRbiMr/nNJkgd
	D/1Lc22w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qqtEE-00GRER-Cd; Thu, 12 Oct 2023 10:47:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11CE830036C; Thu, 12 Oct 2023 12:47:42 +0200 (CEST)
Date: Thu, 12 Oct 2023 12:47:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@google.com>,
	David Gow <davidgow@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
Message-ID: <20231012104741.GN6307@noisy.programming.kicks-ass.net>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net>
 <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
 <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 14, 2022 at 11:34:30AM -0700, Sami Tolvanen wrote:
> On Fri, Oct 14, 2022 at 11:05 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, Oct 11, 2022 at 1:16 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Rust supports IBT with -Z cf-protection=branch, but I don't see this
> > > option being enabled in the kernel yet. Cross-language CFI is going to
> > > require a lot more work though because the type systems are not quite
> > > compatible:
> > >
> > > https://github.com/rust-lang/rfcs/pull/3296
> >
> > I have pinged Ramon de C Valle as he is the author of the RFC above
> > and implementation work too; since a month or so ago he also leads the
> > Exploit Mitigations Project Group in Rust.
> 
> Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
> and he expressed interest in helping with rustc support for it. In the
> meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
> issues here.

Having just read up on the thing it looks like the KCFI thing is
resolved.

I'm not sure I understand most of the objections in that thread through
-- enabling CFI *will* break stuff, so what.

Squashing the integer types seems a workable compromise I suppose. One
thing that's been floated in the past is adding a 'seed' attribute to
some functions in order to distinguish functions of otherwise identical
signature.

The Rust thing would then also need to support this attribute.

Are there any concrete plans for this? It would allow, for example,
to differentiate address_space_operations::swap_deactivate() from any
other random function that takes only a file argument, say:
locks_remove_file().


