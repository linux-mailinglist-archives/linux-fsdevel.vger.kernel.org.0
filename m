Return-Path: <linux-fsdevel+bounces-5108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301FF808347
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2C3B21B98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB9328BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2h2n9dZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC415EBF;
	Thu,  7 Dec 2023 07:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EDAC433C8;
	Thu,  7 Dec 2023 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701933521;
	bh=BF7TDxqLcMq2E5qMJ/3ynCjfbn2PALtyLY3w15WsBCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2h2n9dZBOw11c1KhkrPCGR4LahCXbV23f3FC0i/A5Ot2FwlBomGl8d4yimN/s8K3
	 ezr7ew+vPcraIlX4Nz1QzjJQZeflJ2Mk3W6alfE0FQ54b9JjRs7eJLliBHCEvHGU7q
	 bW2a3bRZ8k/qFYlCEjRJVMjIaL1160Zk0mK8jGPM=
Date: Thu, 7 Dec 2023 08:18:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <2023120716-ferocious-saffron-c595@gregkh>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231130103635.GA20191@noisy.programming.kicks-ass.net>
 <20231206200224.rkdkuozztzg2wusj@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206200224.rkdkuozztzg2wusj@moria.home.lan>

On Wed, Dec 06, 2023 at 03:02:24PM -0500, Kent Overstreet wrote:
> On Thu, Nov 30, 2023 at 11:36:35AM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 29, 2023 at 01:12:17PM +0000, Alice Ryhl wrote:
> > 
> > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > index fd633d9db79a..58e3a9dff349 100644
> > > --- a/rust/helpers.c
> > > +++ b/rust/helpers.c
> > > @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
> > >  }
> > >  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> > >  
> > > +kuid_t rust_helper_task_uid(struct task_struct *task)
> > > +{
> > > +	return task_uid(task);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> > > +
> > > +kuid_t rust_helper_task_euid(struct task_struct *task)
> > > +{
> > > +	return task_euid(task);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_task_euid);
> > 
> > Aren't these like ideal speculation gadgets? And shouldn't we avoid
> > functions like this for exactly that reason?
> 
> I think asking the Rust people to care about that is probably putting
> too many constraints on them, unless you actually have an idea for
> something better to do...

It's not a constraint, it is a "we can not do this as it is buggy
because cpus are broken and we need to protect users from those bugs."

If we were to accept this type of code, then the people who are going
"it's safer to write kernel code in Rust" would be "pleasantly
surprised" when it turns out that their systems are actually more
insecure.

Hint, when "known broken" code is found in code review, it can not just
be ignored.

thanks,

greg k-h

