Return-Path: <linux-fsdevel+bounces-29421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96B979960
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 00:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71EC282891
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE773501;
	Sun, 15 Sep 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mfQMqo0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DE1EB35;
	Sun, 15 Sep 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726437938; cv=none; b=iIHb/zd+LZuBawuvtv4yppQRIsW0xVqiVql9lsq4zvAdey5YnZVY+Jx56MlOdHtDVKALrar4DGYrmZmwZCs5i8dLTlDNBoeryxZEa0f6JhfqtRyvgLd1391gZZVWssrJbjR7np2ol9G3dgEZ7roejZOs1l0XaDl9SmT81ULkdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726437938; c=relaxed/simple;
	bh=Dqf16xxmKXc0Xq9NEQiRVkhivChl6iBtUI3bo0Xg7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHxBsoW4sGLRAaC7o35gZWv6IgOpwKxaIPggf6Fov7WYteGOcW97sCRUDt0tMzEzsFsLM6PgaErs24/ycc81ADPksFoCdgPi892IVkz6dDSm5JZy2Aiz3uGhRB6jk4aQy65YD+sFfkicVDr/lk0TUsIEP6zCVGuoiHWzxCnNP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mfQMqo0z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/adAEHyd5WxOAKHUz3Yg2C+W9ssk43MsRIrF8KsG2IQ=; b=mfQMqo0zAT8SW4qhYmHffFCZQB
	e3MIhktMVgIeyO0IvyoYkPEfqb4XRrhdiTB7AWHfifSfLEaElyQUeZnKDAGI2bJl6N1Z87QBFiRBH
	UO9QwIioCA8Y6WbFHHmeAlvN6vJ6peu0rbayhHKQAnvjRH2XwUn0rfh89keZ+u7ajT8AeoPjj7YQF
	0E8lPi7YeAzKRkSgBocJmiR0YcDrAKh8Smlse3fwT1nsw+/tnvnnjfq2QcWZ9AU3TGA0F0KpdWJRw
	S1gWEmIzi4LAfLWaqv7eNGqeYS2g9LyE746y7xU/BzvYukVe//T3IFPKsVGZUXcBkak+j2WhG0V8n
	ejfJgwIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spxMx-0000000ClQB-1nNE;
	Sun, 15 Sep 2024 22:05:23 +0000
Date: Sun, 15 Sep 2024 23:05:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v10 6/8] rust: file: add `FileDescriptorReservation`
Message-ID: <20240915220523.GM2825852@ZenIV>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
 <20240915183905.GI2825852@ZenIV>
 <CAH5fLghu1NAoj1hSUOD2ULz2XEed329OtHY+w2eAnFd5GrXOKQ@mail.gmail.com>
 <20240915220126.GL2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915220126.GL2825852@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 15, 2024 at 11:01:26PM +0100, Al Viro wrote:

> There's not a lot of binary formats (5 of those currently -
> all in fs/binmt_*.c), but there's nothing to prohibit more
            binfmt_*.c, sorry.

> of them.  If somebody decides to add the infrastructure for
> writing those in Rust, begin_new_exec() wrapper will need
> to be documented as "never call that in scope of reserved
> descriptor".  Maybe by marking that wrapper unsafe and
> telling the users about the restriction wrt descriptor
> reservations, maybe by somehow telling the compiler to
> watch out for that - or maybe the constraint will be gone
> by that time.
> 
> In any case, the underlying constraint ("a thread with
> reserved descriptors should not try to get a private
> descriptor table until all those descriptors are disposed
> of one way or another") needs to be documented.
> 

