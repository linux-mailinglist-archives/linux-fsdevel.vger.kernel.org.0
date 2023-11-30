Return-Path: <linux-fsdevel+bounces-4431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93B7FF66B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7CC28166D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F855766
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="a8gcQNdf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96710D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:00:04 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AUFwk8W004285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 10:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701359933; bh=BjVDdMUb3qZehcj6DA8wvdpKegLaOPtxZqO2+/FFhb0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=a8gcQNdfZkXjAbUuRvU06ckniT0U6Xq0/voW7hMdkEM9H3q0zuODL+kjJVJQ5fxXC
	 MEJqEYXOsoPo622TQy8bxCXIfC2GbnO6mbJJwBpXxCEhp5adqzt2hHMetUNmAcMnJV
	 kyC7rSorNTxzd2fjsms3A6HkL/jpQ0LVY6JcOZJNUjXKTIvUgrP6fz0Y/0Rw2ZDjtT
	 6+SG8BuPnrdnWTwHxq9TAvLmwHcJeIHdq6qg2WrCHzVXaaSYWLTVW4Ue3oCAALCzT7
	 PKd0tUFJKnRi9I1XW7D0/KLmQIkfaWp9FpaU8dlQnzkJqjiB4mCwKfesDKwYN6JOmX
	 JlWDigUCUH05w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6A78815C027C; Thu, 30 Nov 2023 10:58:46 -0500 (EST)
Date: Thu, 30 Nov 2023 10:58:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <20231130155846.GA534667@mit.edu>
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
> >>> +    pub const O_APPEND: u32 = bindings::O_APPEND;
> >>
> >> Why do all of these constants begin with `O_`?
> > 
> > Because that is how they are defined in the kernel in the C code.  Why
> > would they not be the same here?
> 
> Then why does the C side name them that way? Is it because `O_*` is
> supposed to mean something, or is it done due to namespacing?

It's because these sets of constants were flags passed to the open(2)
system call, and so they are dictated by the POSIX specification.  So
O_ means that they are a set of integer values which are used by
open(2), and they are defined when userspace #include's the fcntl.h
header file.  One could consider it be namespacing --- we need to
distinguish these from other constants: MAY_APPEND, RWF_APPEND,
ESCAPE_APPEND, STATX_ATTR_APPEND, BTRFS_INODE_APPEND.

But it's also a convention that dates back for ***decades*** and if we
want code to be understandable by kernel programmers, we need to obey
standard kernel naming conventions.  

> In Rust we have namespacing, so we generally drop common prefixes.

I don't know about Rust namespacing, but in other languages, how you
have to especify namespaces tend to be ***far*** more verbose than
just adding an O_ prefix.

Cheers,

					- Ted

