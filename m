Return-Path: <linux-fsdevel+bounces-30216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF34987E1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1371F2244E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149E17557C;
	Fri, 27 Sep 2024 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AKxAMsoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAD3BBF6;
	Fri, 27 Sep 2024 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417046; cv=none; b=h8ivcb6s7j/krrdvwSUGZ4SEtxf10zHHDP01KJry36bxx7uCVyGI7c/BS0n+oLbm2d8YKlx/oyYuT4cAgJoPLADain7Xs4gg6VXzmn5OR+xaylSCJYL318syQTny9nIMMivA/vZtJHQ2L5YltCI+pMf83QgXXkVOyZIi1cW+hj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417046; c=relaxed/simple;
	bh=7AAsUa2SzzruyreBMUtXklAWJ9cGVHOTxMuEkopbnzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuPm/gULJ2wsBaXUj7AgG7Uw7E2ipTJZ+AsMe+Ztn5rJD/wOdxv+119M1S6GWeOW1MkvB4sG0Yls3tPnHw2QsLatNcFfhgZ4OKuLi8ZFCle5/rXJlf9a1tqKLAi35L+UZ5EOWZv0VFh6UymlO93umvvmpJOTcmeYaFG9jIiDP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AKxAMsoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB17C4CEC4;
	Fri, 27 Sep 2024 06:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727417045;
	bh=7AAsUa2SzzruyreBMUtXklAWJ9cGVHOTxMuEkopbnzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKxAMsoB++wCU2f5bedLH10+8QFXprE/0uZ6PoBNrhIFSf9rsYD+DqXLEsLxYUEuF
	 BqHzvEOxCRtzfN2iPlKFxkWQK5QG8myhfjlGSl8Rls7YliDLEE0BcykRvgBjP9AkwW
	 iDW2OlJe/+7T4TZ9XRTCfF/iXQmRn1tzb7VD8zBs=
Date: Fri, 27 Sep 2024 08:04:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Miscdevices in Rust
Message-ID: <2024092708-rust-wrath-306d@gregkh>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <f7820784-9d9c-4ab9-8c84-b010fead8321@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7820784-9d9c-4ab9-8c84-b010fead8321@proton.me>

On Thu, Sep 26, 2024 at 06:58:10PM +0000, Benno Lossin wrote:
> On 26.09.24 16:58, Alice Ryhl wrote:
> > A misc device is generally the best place to start with your first Rust
> > driver, so having abstractions for miscdevice in Rust will be important
> > for our ability to teach Rust to kernel developers.
> 
> Sounds good!
> 
> > I intend to add a sample driver using these abstractions, and I also
> > intend to use it in Rust Binder to handle the case where binderfs is
> > turned off.
> > 
> > I know that the patchset is still a bit rough. It could use some work on
> > the file position aspect. But I'm sending this out now to get feedback
> > on the overall approach.
> > 
> > This patchset depends on files [1] and vma [2].
> > 
> > Link: https://lore.kernel.org/all/20240915-alice-file-v10-0-88484f7a3dcf@google.com/ [1]
> > Link: https://lore.kernel.org/all/20240806-vma-v5-1-04018f05de2b@google.com/ [2]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Alice Ryhl (3):
> >       rust: types: add Opaque::try_ffi_init
> >       rust: file: add f_pos and set_f_pos
> >       rust: miscdevice: add abstraction for defining miscdevices
> 
> I recall that we had a sample miscdev driver in the old rust branch. Can
> you include that in this series, or is there still some stuff missing? I
> think it would be really useful for people that want to implement such a
> driver to have something to look at.

I agree, I'll dig that up after -rc1 is out and add it to this series.

thanks,

greg k-h

