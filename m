Return-Path: <linux-fsdevel+bounces-4356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E297FED10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6FB20C55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1B3B2B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K6nZwXf0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259810EF;
	Thu, 30 Nov 2023 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MJ2Nv64cnRBVTENP4eJGBA77a/TG6CtKUt1zxTIVNGY=; b=K6nZwXf03a42iyVAFAzroplPQo
	P/ws9/5VH+Ywxwg/qSNQLTq+yC4vsVlHgESDQE7QbF5DPIlSshkjwz0WlgO9lyfjkUlGAdzO32e8M
	k1T4Ft0aUtY8ZpsIKgQWv05ZatBrpHQw5Tl6Jb+e2y+b1rQf2gn3cB+0uJDfT/6FgxB6IAQeShUng
	lNuwTuX/dW9Q135DZkOE5LHr1g6xcCh+KL69x8rj9mr6jDE4DnI0zwMqA0uIyTLrmUD6eahm9QjPx
	6EVh6RqcrI4tMQp36J/Sga9pyeFrfqxxa/0YZbXC6Vx/qxN7ZZVsnQ3/DanB1xDe432+ZbEuAYT8N
	X7Nfgctw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8ePL-0011fC-2j;
	Thu, 30 Nov 2023 10:36:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 265D8300293; Thu, 30 Nov 2023 11:36:35 +0100 (CET)
Date: Thu, 30 Nov 2023 11:36:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231130103635.GA20191@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-5-f81afe8c7261@google.com>

On Wed, Nov 29, 2023 at 01:12:17PM +0000, Alice Ryhl wrote:

> diff --git a/rust/helpers.c b/rust/helpers.c
> index fd633d9db79a..58e3a9dff349 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +kuid_t rust_helper_task_uid(struct task_struct *task)
> +{
> +	return task_uid(task);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> +
> +kuid_t rust_helper_task_euid(struct task_struct *task)
> +{
> +	return task_euid(task);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_task_euid);

Aren't these like ideal speculation gadgets? And shouldn't we avoid
functions like this for exactly that reason?


