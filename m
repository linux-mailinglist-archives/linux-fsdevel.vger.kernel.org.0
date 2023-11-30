Return-Path: <linux-fsdevel+bounces-4376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338027FF281
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C8DB2103C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BB4A9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqekIxo6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFD47780;
	Thu, 30 Nov 2023 12:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607AAC433C8;
	Thu, 30 Nov 2023 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348405;
	bh=Turv8447m0iSBp/1OD7/8HA4BfAu143dTXX+sHwM0FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqekIxo6sLR+ZJAdumnjYlqU2xkYUbQi9E5yxc7xwxXoiHS8WTSoDX0k4CjTjTNrR
	 mBpKj8soTxt0h5dT2M1MGA24pCTg3NAesXV4tzAC9rhTph2SKpsKTbwyGUr5AGKDt0
	 BKmvPGyXA1E1rXsB0Z63r3ja5QnXla6gxH+w2XWJA/IZGsFVlUrcKe1XXdzwkbV39B
	 JO9RtBINtp9hZHoTwT3yS/3fbPClifFhi6JVfwLdzwOFWnQJOaz7pFJhZQs5tGLxq1
	 YQOCR3pEWHtg3zf9Nrm8ATXKwUppSWBHxpCnrNUtsCElu0jKG+SGXVteOhAYrDjsf5
	 ZjTutNZycpi8w==
Date: Thu, 30 Nov 2023 13:46:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
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
Message-ID: <20231130-wohle-einfuhr-1708e9c3e596@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129164815.GI23596@noisy.programming.kicks-ass.net>

On Wed, Nov 29, 2023 at 05:48:15PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 29, 2023 at 05:28:27PM +0100, Christian Brauner wrote:
> 
> > > +pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
> > > +				  struct pid_namespace *ns)
> > > +{
> > > +	return task_tgid_nr_ns(tsk, ns);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
> > 
> > I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> > why they are needed? Because they are/can be static inlines and that
> > somehow doesn't work?
> 
> Correct, because Rust can only talk to C ABI, it cannot use C headers.
> Bindgen would need to translate the full C headers into valid Rust for
> that to work.
> 
> I really think the Rust peoples should spend more effort on that,
> because you are quite right, all this wrappery is tedious at best.

The problem is that we end up with a long list of explicit exports that
also are all really weirdly named like rust_helper_*(). I wouldn't even
complain if it they were somehow auto-generated but as you say that
might be out of scope.

The thing is though that if I want to change the static inlines I know
also have to very likely care about these explicit Rust wrappers which
seems less than ideal.

So if we could not do rust_helper_*() exports we'd probably be better
off.

