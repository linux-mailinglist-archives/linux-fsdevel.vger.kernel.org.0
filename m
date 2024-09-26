Return-Path: <linux-fsdevel+bounces-30190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74F98779A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FE6B24A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DEA15A86B;
	Thu, 26 Sep 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmFf8xkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5C12BEBB;
	Thu, 26 Sep 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368417; cv=none; b=AA3OnRQaLGrgDejNQJgwwrxsoxJfhty2C4fr7akMKV4eamogkqWUxiAKbtzJ/ipWsOQ6VxauiD+PP4pI+52QF/HAZjpfUvhnzmXKeXfb/bWzqCzWRSpxFBK91qBOAshk96RMQ7bwkwWvws1bsqwJfKvbq38E0p3XPQbfCSAERSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368417; c=relaxed/simple;
	bh=ejaVUT8P5sthltU9KFU5rxsOBgn1t9y5j9O71lgbcTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKdLAtd2mr6nrosOebchFr356GkSEtVXSXzhz+HheS/Kn8r6WYam3xCwJLrDlET/k/5crFGBO0zTzT61XVu/WuXrDPJttQYrHWQlw5PyFTnKV5jf7SoMy1ueC6tsFyGXxMPW9Y7s7TIFoT9kbOfAfqlPYF37zWQwKLbBHQjjMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmFf8xkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C929C4CEC5;
	Thu, 26 Sep 2024 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727368417;
	bh=ejaVUT8P5sthltU9KFU5rxsOBgn1t9y5j9O71lgbcTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmFf8xkUqQEBV4U5U7Uy6ywRX7H5+GmCC/aCAViW/aPypmjg+umwE++TQPZXyqxiq
	 X4Kgo1lgkMYe+HIBC7FyS5GRSdnSmgAFHhSMN8qNpMwcGuYXGHwthq/6L7GrQRTrQ0
	 FM8o/+ypRxh6WPLV9MRZT9QneXWcKL24f+njtc1QJ58Q950C0u6VWqBalFApvFdhDi
	 Mgzr5rM1a4ZWHf0AeGVHfI5sqs5SDK6BUxWlMsvWAw1R5f4kyNVuq9vp+hGfPT59qx
	 GvscRxgVC/m7tW59RV/t9O27X5IW0Xm3oS0Ukjk9La5q/TlUvJoAaWNgLiAOw9MDMZ
	 EZ+MN1TcQuodg==
Date: Thu, 26 Sep 2024 18:33:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v10 7/8] rust: file: add `Kuid` wrapper
Message-ID: <20240926-bewundere-beseitigen-59808f199f82@brauner>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-7-88484f7a3dcf@google.com>
 <20240915230211.420f48a9.gary@garyguo.net>
 <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>

On Mon, Sep 23, 2024 at 11:13:56AM GMT, Alice Ryhl wrote:
> On Mon, Sep 16, 2024 at 12:02 AM Gary Guo <gary@garyguo.net> wrote:
> >
> > On Sun, 15 Sep 2024 14:31:33 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > > +    /// Returns the given task's pid in the current pid namespace.
> > > +    pub fn pid_in_current_ns(&self) -> Pid {
> > > +        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
> > > +        // pointer as the namespace is correct for using the current namespace.
> > > +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
> >
> > Do we want to rely on the behaviour of `task_tgid_nr_ns` with null
> > pointer as namespace, or use `task_tgid_vnr`?
> 
> Hmm. Looks like C Binder actually does:
> trd->sender_pid = task_tgid_nr_ns(sender, task_active_pid_ns(current));
> 
> Not sure why I'm using a null pointer here.

Passing a NULL pointer for task_tgid_nr_ns() is fine. Under the hood
it's just __task_pid_nr_ns(task, PIDTYPE_TGID, NULL) which causes
task_active_pid_ns(current) to be called internally. So it's equivalent.

In any case, I did add Rust wrappers for struct pid_namespace just to
see how far I would get as task_active_pid_ns() is rather subtle even if
it isn't obvious at first glance. Sending that in a second.

