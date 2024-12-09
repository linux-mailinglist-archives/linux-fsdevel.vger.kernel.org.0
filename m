Return-Path: <linux-fsdevel+bounces-36789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBF79E9675
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE7A281339
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7541ACEAA;
	Mon,  9 Dec 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tX4f0JYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BD1ACEBC;
	Mon,  9 Dec 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750035; cv=none; b=jRxaPPFoBALZnbXziNEqgcB/9cxZMpCn4J+L86zcxAoZfKWtCiGRiSqXacrDr6uNKSc8T7FZh4/DswAnRwyZw3uPf2oqH38q3URAJLD7FE6ox9MK+M2ZAf/8Dn53B7uVKE/xF5lC50RjLfJw7xI8do0ub7RaDF4UzoEZjlva94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750035; c=relaxed/simple;
	bh=/pLbobhPgRwpQTExS0Co3JYQTpmYSbS0pBR+Oa1Jik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcjmR+vzylEpp/AZ+ICAcGClTBJ3kI364mHi4+xDCHtu6N523I+wnHXdJS4CB/NDAsCcwFjPPdheRq6gR6EMw/rqfFqW64CXuTFN7ionyx6s8LFgOZ6tTuM497YIYnbzOA78Lh+k9sUlk7FawDf3JDm/7E4U7GvZSWTRdIhLwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tX4f0JYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D741C4CED1;
	Mon,  9 Dec 2024 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733750034;
	bh=/pLbobhPgRwpQTExS0Co3JYQTpmYSbS0pBR+Oa1Jik0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tX4f0JYMWMcAfg+5Xf5gSfL4U6D1sHmBhuBxPkK0F8kz4gs7x1K/GTRf9TnrtKmuu
	 k1pV6if/LPH+lM2XeicnniPHMJCYnyf3CgjZ+Cfhy+2ZqBSSd/hMt8Z/8HyQYjmgf4
	 2nJKQf1i5jMQNlRmVWkG1TbHf4wMC4iflHcZ0sZ0=
Date: Mon, 9 Dec 2024 14:13:50 +0100
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
Message-ID: <2024120951-botanist-exhale-4845@gregkh>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <2024120925-express-unmasked-76b4@gregkh>
 <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
 <2024120954-boring-skeptic-ad16@gregkh>
 <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
 <2024120908-anemic-previous-3db9@gregkh>
 <CAH5fLgjO50OsNb7sYd8fY4VNoHOzX40w3oH-24uqkuL3Ga4iVQ@mail.gmail.com>
 <2024120939-aide-epidermal-076e@gregkh>
 <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>

On Mon, Dec 09, 2024 at 01:53:42PM +0100, Alice Ryhl wrote:
> On Mon, Dec 9, 2024 at 1:08 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 01:00:05PM +0100, Alice Ryhl wrote:
> > > On Mon, Dec 9, 2024 at 12:53 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > > > > On Mon, Dec 9, 2024 at 12:10 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > > > > > On Mon, Dec 9, 2024 at 9:48 AM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > > > > > > Providing access to the underlying `struct miscdevice` is useful for
> > > > > > > > > various reasons. For example, this allows you access the miscdevice's
> > > > > > > > > internal `struct device` for use with the `dev_*` printing macros.
> > > > > > > > >
> > > > > > > > > Note that since the underlying `struct miscdevice` could get freed at
> > > > > > > > > any point after the fops->open() call, only the open call is given
> > > > > > > > > access to it. To print from other calls, they should take a refcount on
> > > > > > > > > the device to keep it alive.
> > > > > > > >
> > > > > > > > The lifespan of the miscdevice is at least from open until close, so
> > > > > > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > > > > > >
> > > > > > > How is that enforced? What happens if I call misc_deregister while
> > > > > > > there are open fds?
> > > > > >
> > > > > > You shouldn't be able to do that as the code that would be calling
> > > > > > misc_deregister() (i.e. in a module unload path) would not work because
> > > > > > the module reference count is incremented at this point in time due to
> > > > > > the file operation module reference.
> > > > >
> > > > > Oh .. so misc_deregister must only be called when the module is being unloaded?
> > > >
> > > > Traditionally yes, that's when it is called.  Do you see it happening in
> > > > any other place in the kernel today?
> > >
> > > I had not looked, but I know that Binder allows dynamically creating
> > > and removing its devices at runtime. It happens to be the case that
> > > this is only supported when binderfs is used, which is when it doesn't
> > > use miscdevice, so technically Binder does not call misc_deregister()
> > > outside of module unload, but following its example it's not hard to
> > > imagine that such removals could happen.
> >
> > That's why those are files and not misc devices :)
> 
> I grepped for misc_deregister and the first driver I looked at is
> drivers/misc/bcm-vk which seems to allow dynamic deregistration if the
> pci device is removed.

Ah, yeah, that's going to get messy and will be a problem if someone has
the file open then.

> Another tricky path is error cleanup in its probe function.
> Technically, if probe fails after registering the misc device, there's
> a brief moment where you could open the miscdevice before it gets
> removed in the cleanup path, which seems to me that it could lead to
> UAF?
> 
> Or is there something I'm missing?

Nope, that too is a window of a problem, luckily you "should" only
register the misc device after you know the device is safe to use as
once it is registered, it could be used so it "should" be the last thing
you do in probe.

So yes, you are right, and we do know about these issues (again see the
talk I mentioned and some previous ones for many years at plumbers
conferences by different people.)  It's just up to someone to do the
work to fix them.

If you think we can prevent the race in the rust side, wonderful, I'm
all for that being a valid fix.

thanks,

greg k-h

