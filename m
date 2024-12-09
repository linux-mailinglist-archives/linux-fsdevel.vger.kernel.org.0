Return-Path: <linux-fsdevel+bounces-36765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC619E91FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F5E18858F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548B219E90;
	Mon,  9 Dec 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbNUEBV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FB2147FF;
	Mon,  9 Dec 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743075; cv=none; b=fK8obwUdVRq8ypo4Gk07bPmoMIGXMZY59fn9TleU9lT2sc4CaeXu7kEZzVmQo+rGXT24xuPDRIgu/MPoTIxYIDxQM8QoKxtEhOjrDzOT91frDH4nzi5rB14PP5GXJY7egmE0Mn034otzCxXaGGT0GkboH2RMpbSVG/3IxMo8U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743075; c=relaxed/simple;
	bh=gCUPV0kh+sNZWb/Ei12o+FmTpoO1iULqFFxAQL6jImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6PdYH8PKN1+L07qjY6IebnTy84pxHx49E8eaHs4YbDXiU94tv9Yeksh04DB2jxnAkdZxVu9uO+VVlUoZbyikAfXGuTJxaNpd1EK65BNlbhvexxnX09DsFyl3Brp2CpIvsgudTMPQzWLD7dVeikfC34yPc7lfVGsCY08doE4IgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbNUEBV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34EBC4CEE0;
	Mon,  9 Dec 2024 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733743074;
	bh=gCUPV0kh+sNZWb/Ei12o+FmTpoO1iULqFFxAQL6jImE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wbNUEBV7Jn7poGXI/9itfx/L/7MbETTFq0Y3keyUMMxiXV2rdYoBtsjTCFreog58M
	 VDxXhFfevaFcVELajGG1DqIgzDjmPwmlCyIaNGB9dRhVOgOyBJQ6QJqOmlWkCfoZ9a
	 K+P4fpen5MHEg4PkJQNiqhsLWxF+l5Ik6R6alGr8=
Date: Mon, 9 Dec 2024 12:17:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
Message-ID: <2024120909-yield-celery-4257@gregkh>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <Z1bPYb0nDcUN7SKK@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1bPYb0nDcUN7SKK@pollux.localdomain>

On Mon, Dec 09, 2024 at 12:07:13PM +0100, Danilo Krummrich wrote:
> On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > Providing access to the underlying `struct miscdevice` is useful for
> > various reasons. For example, this allows you access the miscdevice's
> > internal `struct device` for use with the `dev_*` printing macros.
> > 
> > Note that since the underlying `struct miscdevice` could get freed at
> > any point after the fops->open() call, only the open call is given
> > access to it. To print from other calls, they should take a refcount on
> > the device to keep it alive.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/miscdevice.rs | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 0cb79676c139..c5af1d5ec4be 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -104,7 +104,7 @@ pub trait MiscDevice {
> >      /// Called when the misc device is opened.
> >      ///
> >      /// The returned pointer will be stored as the private data for the file.
> > -    fn open(_file: &File) -> Result<Self::Ptr>;
> > +    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
> 
> How is the user of this abstraction supposed to access the underlying struct
> miscdevice e.g. from other fops? AFAICS, there is no way for the user to store a
> device pointer / reference in their driver private data.

That should be "hung" off of the miscdevice structure.  In C that's done
through embedding the miscdevice structure within something else, don't
know how you all are going to do that in rust :)

Or, better yet, in your open callback, the rust code can set the file
private data pointer, that's what is done a lot as well, either could
work.

> I also think it's a bit weird to pass the registration structure in open() to
> access the device.

That's what the miscdevice api does today in C.  Well, it's embedded in
the file private pointer, so I guess just a function to call to get it
instead would work.

> I think we need an actual representation of a struct miscdevice, i.e.
> `misc::Device`.

I thought we have that already?

thanks,

greg k-h

