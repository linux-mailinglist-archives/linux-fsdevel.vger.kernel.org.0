Return-Path: <linux-fsdevel+bounces-36831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4AD9E9A16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153E01623FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0A1BEF9B;
	Mon,  9 Dec 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i97qv8dI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F12233133;
	Mon,  9 Dec 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757090; cv=none; b=KbcFbUTZL/ZAczv1d0H1TF1GdqYMNMZ7an2fOvKCD/6/CpUjWTaRazNj7Y+piT7okIBnWTsbgUDSTzNolRi5GIxpEx2Q9LpKoR+oH69D7EOnszo+C/58SpFze2HHDh3FsQL0BwBWPEAwf/ZQ51IKBfI0voZ9BL9ZmjPhEJRijz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757090; c=relaxed/simple;
	bh=FmOlznKOYOfLj+ux44kcsjBWkD966SYEWmnJtDbp7go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnFFWrLTKwNniaGPPGFQaV0EDpKwIDhnAZbo4juijvBxn9sGCkv4Gk4/zDlj850goTSk9VzRlPLXcIKnA52/QpAJ2s7AtEjZQr/me5vFt7uF7xrUilC6oofHr4vvL1mkDSPwbA9Fh5GOhUtDeaRKtHJG50q5I/lsZGxGBWn4lqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i97qv8dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE17C4CED1;
	Mon,  9 Dec 2024 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733757089;
	bh=FmOlznKOYOfLj+ux44kcsjBWkD966SYEWmnJtDbp7go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i97qv8dI3bsdkF3fMLLqdxDvSJu//7KCjFPBEmwgiCgMc5DCA/cMzqVyVN/VqMqun
	 9RtQwh818sRkQ4BzUm+tOOvexJGcG4h8nXAg7l9WB2mQ2wG0zuG5KxCocU+ViOQ9lo
	 3eKAz8zww/Fuo0GIWTDGd+H/0Qh5TXT0iXm5EZPwIslrXfuSKLuEVYLrUqVtMP/x3L
	 g5PyHie/QR5FFJcb/tek5/gP4JEPLyoZrR+ipjSEKJSumGvrUFJdybhYqCL+qyc48+
	 q1uXg8gVpGJ1a6Udt+sWg+0sVruG/Jk7h8RiNIbevn2Dx/Kue0KMhAR5fHBEgxaaFQ
	 62PYQtO6bQdiw==
Date: Mon, 9 Dec 2024 16:11:22 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <Z1cImntcEwsPHQgO@pollux.localdomain>
References: <2024120954-boring-skeptic-ad16@gregkh>
 <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
 <2024120908-anemic-previous-3db9@gregkh>
 <CAH5fLgjO50OsNb7sYd8fY4VNoHOzX40w3oH-24uqkuL3Ga4iVQ@mail.gmail.com>
 <2024120939-aide-epidermal-076e@gregkh>
 <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>
 <2024120951-botanist-exhale-4845@gregkh>
 <CAH5fLgjxMH71fQ5A8F8JaO2c54wxCTCnuMEqnQqpV3L=2BUWEA@mail.gmail.com>
 <Z1cGWBFm0uVA07WN@pollux.localdomain>
 <CAH5fLgisVC15muFB0eThiMveFBoauB4jUVwW9Zez3cKT0Q=_iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgisVC15muFB0eThiMveFBoauB4jUVwW9Zez3cKT0Q=_iA@mail.gmail.com>

On Mon, Dec 09, 2024 at 04:04:48PM +0100, Alice Ryhl wrote:
> On Mon, Dec 9, 2024 at 4:01 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 02:36:31PM +0100, Alice Ryhl wrote:
> > > On Mon, Dec 9, 2024 at 2:13 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 01:53:42PM +0100, Alice Ryhl wrote:
> > > > > On Mon, Dec 9, 2024 at 1:08 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 09, 2024 at 01:00:05PM +0100, Alice Ryhl wrote:
> > > > > > > On Mon, Dec 9, 2024 at 12:53 PM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > > > > > > > > On Mon, Dec 9, 2024 at 12:10 PM Greg Kroah-Hartman
> > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > > > > > > > > > On Mon, Dec 9, 2024 at 9:48 AM Greg Kroah-Hartman
> > > > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > > > > > > > > > > Providing access to the underlying `struct miscdevice` is useful for
> > > > > > > > > > > > > various reasons. For example, this allows you access the miscdevice's
> > > > > > > > > > > > > internal `struct device` for use with the `dev_*` printing macros.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Note that since the underlying `struct miscdevice` could get freed at
> > > > > > > > > > > > > any point after the fops->open() call, only the open call is given
> > > > > > > > > > > > > access to it. To print from other calls, they should take a refcount on
> > > > > > > > > > > > > the device to keep it alive.
> > > > > > > > > > > >
> > > > > > > > > > > > The lifespan of the miscdevice is at least from open until close, so
> > > > > > > > > > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > > > > > > > > > >
> > > > > > > > > > > How is that enforced? What happens if I call misc_deregister while
> > > > > > > > > > > there are open fds?
> > > > > > > > > >
> > > > > > > > > > You shouldn't be able to do that as the code that would be calling
> > > > > > > > > > misc_deregister() (i.e. in a module unload path) would not work because
> > > > > > > > > > the module reference count is incremented at this point in time due to
> > > > > > > > > > the file operation module reference.
> > > > > > > > >
> > > > > > > > > Oh .. so misc_deregister must only be called when the module is being unloaded?
> > > > > > > >
> > > > > > > > Traditionally yes, that's when it is called.  Do you see it happening in
> > > > > > > > any other place in the kernel today?
> > > > > > >
> > > > > > > I had not looked, but I know that Binder allows dynamically creating
> > > > > > > and removing its devices at runtime. It happens to be the case that
> > > > > > > this is only supported when binderfs is used, which is when it doesn't
> > > > > > > use miscdevice, so technically Binder does not call misc_deregister()
> > > > > > > outside of module unload, but following its example it's not hard to
> > > > > > > imagine that such removals could happen.
> > > > > >
> > > > > > That's why those are files and not misc devices :)
> > > > >
> > > > > I grepped for misc_deregister and the first driver I looked at is
> > > > > drivers/misc/bcm-vk which seems to allow dynamic deregistration if the
> > > > > pci device is removed.
> > > >
> > > > Ah, yeah, that's going to get messy and will be a problem if someone has
> > > > the file open then.
> > > >
> > > > > Another tricky path is error cleanup in its probe function.
> > > > > Technically, if probe fails after registering the misc device, there's
> > > > > a brief moment where you could open the miscdevice before it gets
> > > > > removed in the cleanup path, which seems to me that it could lead to
> > > > > UAF?
> > > > >
> > > > > Or is there something I'm missing?
> > > >
> > > > Nope, that too is a window of a problem, luckily you "should" only
> > > > register the misc device after you know the device is safe to use as
> > > > once it is registered, it could be used so it "should" be the last thing
> > > > you do in probe.
> > > >
> > > > So yes, you are right, and we do know about these issues (again see the
> > > > talk I mentioned and some previous ones for many years at plumbers
> > > > conferences by different people.)  It's just up to someone to do the
> > > > work to fix them.
> > > >
> > > > If you think we can prevent the race in the rust side, wonderful, I'm
> > > > all for that being a valid fix.
> > >
> > > The current patch prevents the race by only allowing access to the
> > > `struct miscdevice` in fops->open(). That's safe since
> > > `file->f_op->open` runs with `misc_mtx` held. Do we really need the
> > > miscdevice to stay alive for longer? You can already take a refcount
> > > on `this_device` if you want to keep the device alive for longer for
> > > dev_* printing purposes, but it seems like that is the only field you
> > > really need from the `struct miscdevice` past fops->open()?
> >
> > Good point, I also can't really see anything within struct miscdevice that a
> > driver could need other than `this_device`.
> >
> > How would you provide the `device::Device` within the `MiscDevice` trait
> > functions?
> >
> > If we don't guarantee that the `struct miscdevice` is still alive past open() we
> > need to take a reference on `this_device` in open().
> >
> > I guess the idea would be to let `MiscDeviceRegistration` provide a function to
> > obtain an `ARef<device::Device>`?
> 
> Yes, you take a refcount on the device and store an
> ARef<device::Device> in your own struct. You would need Lee's accessor
> to obtain the device refcount:
> https://lore.kernel.org/all/20241206090515.752267-3-lee@kernel.org/

Sounds good!

> 
> Alice

