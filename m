Return-Path: <linux-fsdevel+bounces-4430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B27FF669
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDD71C20B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1E55762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1xfiPH0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FC524A9;
	Thu, 30 Nov 2023 15:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66DDC433C7;
	Thu, 30 Nov 2023 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701359777;
	bh=Atqz2R8S5CFNofHmkfbPck2yrnj1PJGSJBWuitp3Lps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1xfiPH0vRvQNxh0H18ebsiz+QfXIO8h49qtn0BttXKyyJSgU0KjgGqV7EineszNcM
	 YfXWi3JxZnBYtdyoZLPf+lHo4BaXOhVIFSsRS6ZLrN4JIawZIMxnELgiDZvOoDIXKG
	 IS9mpPQxycqq6pikqdDmy03gNorSUfMJRnf9Zav0=
Date: Thu, 30 Nov 2023 15:56:14 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <2023113010-situated-brunch-d52d@gregkh>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me>
 <2023113041-bring-vagrancy-a417@gregkh>
 <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>

On Thu, Nov 30, 2023 at 03:46:55PM +0000, Benno Lossin wrote:
> On 11/30/23 15:59, Greg Kroah-Hartman wrote:
> > On Thu, Nov 30, 2023 at 02:53:35PM +0000, Benno Lossin wrote:
> >> On 11/29/23 13:51, Alice Ryhl wrote:
> >>> +/// Flags associated with a [`File`].
> >>> +pub mod flags {
> >>> +    /// File is opened in append mode.
> >>> +    pub const O_APPEND: u32 = bindings::O_APPEND;
> >>
> >> Why do all of these constants begin with `O_`?
> > 
> > Because that is how they are defined in the kernel in the C code.  Why
> > would they not be the same here?
> 
> Then why does the C side name them that way? Is it because `O_*` is
> supposed to mean something, or is it done due to namespacing?

Because this is a unix-like system, we all "know" what they mean. :)

See 'man 2 open' for details.

> In Rust we have namespacing, so we generally drop common prefixes.

Fine, but we know what this namespace is, please don't override it to be
something else.

thanks,

greg k-h

