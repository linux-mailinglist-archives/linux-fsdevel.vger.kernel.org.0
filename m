Return-Path: <linux-fsdevel+bounces-4227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1C7FDF72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10737B20A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887205DF03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9BTJ3na"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80AB6;
	Wed, 29 Nov 2023 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tiPBXf1kZm2l8+7WRSaX1GLajBl09o/Tkot6Kx1Gxo0=; b=o9BTJ3na+CayHjCSRZpl2hxliT
	eZWFH3ECXx+oJ7DlR9ag0VtHn0Z2tXkZTZiOvVe7bHtsuQ2Zk9r/lDdgnScTBopq4dC6DPa2dPJLe
	GESlCC6PcoctemBjNadjUc3b0BfqJynYCAP/nZ2+XcPvqv/AXjCMh8rDWbqRguQroRYlEihFRLapB
	WN7LI1bGNDmTpb6vOAozO/72c90oKSQmni3CfkKhnCbzWDdaoenV2KOOJIPzsP5kG6gXPdkT7oHQk
	N4a3SxtqtYwrH4xc8IqSk38EGJBCMQEF9RsKJuWJSCttRemeHKUGu9TW6jqf3w3QQiY15NlTOpSVL
	TMUlR9wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8NjU-000QPZ-1K;
	Wed, 29 Nov 2023 16:48:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2EE9E30017D; Wed, 29 Nov 2023 17:48:15 +0100 (CET)
Date: Wed, 29 Nov 2023 17:48:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231129164815.GI23596@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-etappen-knapp-08e2e3af539f@brauner>

On Wed, Nov 29, 2023 at 05:28:27PM +0100, Christian Brauner wrote:

> > +pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
> > +				  struct pid_namespace *ns)
> > +{
> > +	return task_tgid_nr_ns(tsk, ns);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
> 
> I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> why they are needed? Because they are/can be static inlines and that
> somehow doesn't work?

Correct, because Rust can only talk to C ABI, it cannot use C headers.
Bindgen would need to translate the full C headers into valid Rust for
that to work.

I really think the Rust peoples should spend more effort on that,
because you are quite right, all this wrappery is tedious at best.

