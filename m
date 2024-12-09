Return-Path: <linux-fsdevel+bounces-36773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A19E92E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6E416367E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83C224885;
	Mon,  9 Dec 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPOTAUsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA462248A1;
	Mon,  9 Dec 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745184; cv=none; b=BKDp9StoSZv2Dh0vNZnTnk4JVKn9d3fftbReQFByP2V+kHErNN8bACiMxAO66TYZgY0iars3v0KC2Rm2N2JdmlP36/zbRE6fGrt/1IovvCmBOKYptJVdnYncjXr+kByhhNzh50DrMuexyZ8pdx4Wu0/HKzaC6KmgjXTVMc2atrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745184; c=relaxed/simple;
	bh=VEEB2A5ayIjGM7EoTOAUoJSPbnrhtAhuLBCL5VEQ0Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnvIkTVzv6d+FRxlhy1vySX9MLHCQhpGV9Y6oaq80QbFu9OOxmfVRB3P/7sn0dsQTFIWelmfA061EAMkgbYST+G85u8DxQtdP/+3X6B0Jp5b0ndhMqr7WngWr1NtpyrhitNeLPt0SoDdFtUA8cmcNZAObPQvyJLuNkc+1nKM2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vPOTAUsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E611C4CEEB;
	Mon,  9 Dec 2024 11:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733745183;
	bh=VEEB2A5ayIjGM7EoTOAUoJSPbnrhtAhuLBCL5VEQ0Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPOTAUsDObEqavBD3e1A/7cXbFb+pu4w8Y2ZzBPHhYXceWM/KqQK/aQghRMvXWqYc
	 QaEfqw3hwI+xd5gTWfajy6pFqkn93vj85GqskNfoQTx5pyGUqoZQXWBg2g3TV3XvNw
	 TXrarP03FmmJ3tf6TU5yj9mg+V1KRZj/fal4ayFY=
Date: Mon, 9 Dec 2024 12:53:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <2024120908-anemic-previous-3db9@gregkh>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <2024120925-express-unmasked-76b4@gregkh>
 <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
 <2024120954-boring-skeptic-ad16@gregkh>
 <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>

On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> On Mon, Dec 9, 2024 at 12:10 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > On Mon, Dec 9, 2024 at 9:48 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > > Providing access to the underlying `struct miscdevice` is useful for
> > > > > various reasons. For example, this allows you access the miscdevice's
> > > > > internal `struct device` for use with the `dev_*` printing macros.
> > > > >
> > > > > Note that since the underlying `struct miscdevice` could get freed at
> > > > > any point after the fops->open() call, only the open call is given
> > > > > access to it. To print from other calls, they should take a refcount on
> > > > > the device to keep it alive.
> > > >
> > > > The lifespan of the miscdevice is at least from open until close, so
> > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > >
> > > How is that enforced? What happens if I call misc_deregister while
> > > there are open fds?
> >
> > You shouldn't be able to do that as the code that would be calling
> > misc_deregister() (i.e. in a module unload path) would not work because
> > the module reference count is incremented at this point in time due to
> > the file operation module reference.
> 
> Oh .. so misc_deregister must only be called when the module is being unloaded?

Traditionally yes, that's when it is called.  Do you see it happening in
any other place in the kernel today?

> > Wait, we are plumbing in the module owner logic here, right?  That
> > should be in the file operations structure.
> 
> Right ... it's missing but I will add it.

Thanks!

> > Yeah, it's a horrid hack, and one day we will put "real" revoke logic in
> > here to detach the misc device from the file operations if this were to
> > happen.  It's a very very common anti-pattern that many subsystems have
> > that is a bug that we all have been talking about for a very very long
> > time.  Wolfram even has a plan for how to fix it all up (see his Japan
> > LinuxCon talk from 2 years ago), but I don't think anyone is doing the
> > work on it :(
> >
> > The media and drm layers have internal hacks/work-arounds to try to
> > handle this issue, but luckily for us, the odds of a misc device being
> > dynamically removed from the system is pretty low.
> >
> > Once / if ever, we get the revoke type logic implemented, then we can
> > apply that to the misc device code and follow it through to the rust
> > side if needed.
> 
> If dynamically deregistering is not safe, then we need to change the
> Rust abstractions to prevent it.

Dynamically deregistering is not unsafe, it's just that I don't think
you will physically ever have the misc_deregister() path called if a
file handle is open.  Same should be the case for rust code, it should
"just work" without any extra code to do so.

thanks,

greg k-h

