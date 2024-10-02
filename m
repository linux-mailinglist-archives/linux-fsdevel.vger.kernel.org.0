Return-Path: <linux-fsdevel+bounces-30704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E298DB29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80B6B27237
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204C1D14F4;
	Wed,  2 Oct 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liR9s509"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FF1D079C;
	Wed,  2 Oct 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879019; cv=none; b=NNOVj7lFVOcJ/shZ40zSU7wPLnRAN+p0OLDCOwDfaFCyZ9hHG0nZDgLezvmq11/WFVmg1zeUa6TSVQrYoRLnkrO0ksOh0x8xOt2dKF9LC5TyXlg4UVZE3ToFFTj8xugPVyWDm019KoVmV73IkvlXLpvnapSTWfQ3hZ6H37eYOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879019; c=relaxed/simple;
	bh=Etw8Kvj3yR6KcIYoIXh+WEHqmGJJT0c58kIzsVAY/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qivit81LP/WcKuC9jhfRqUVvAsXcVfqrRUCIrw8jPrGyf+b7IRmSTMHMCIL2M1JE1LBiTosAIXe+S5TD1JzMVrEzWlz1eh/5cUmBLDy2zsL08cYTW8da61xq/fRR90WEnGeOW5JSZIl6iQjZUVwj2P+ePK7aSF6LPtR9R7mxutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liR9s509; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575A8C4CED7;
	Wed,  2 Oct 2024 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727879019;
	bh=Etw8Kvj3yR6KcIYoIXh+WEHqmGJJT0c58kIzsVAY/eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liR9s509X59OUNcaU9oA2lBwqrm/Okegp/38OgtHqUVr7PKOh9dleUB3DTnKVfNmh
	 6pD605pPpgG0p3JHo8qDAGUAoiMluOQeYXrX7XUrEJORCvGbqc3rPrFufjc9hFxpc6
	 QewewL6GKWQlNF0OxhCheTWqY8q320lFtzWEAVu+FtZpen0DWqELbk4p3re4GVLRa8
	 Op6rH6KSqZ8Bsk9MBCgKwgR6Oe2T6RMgy6Z0kYIMUYl+leG8Y9+9kLRcv/477ZsXyU
	 W5eN5edPIQH5P90Y1U9o+P+MrwGqp76VirfwYtzm/8GBbMpIMnylB7d/ES49+d9Jgt
	 bmj4uBkCILC2A==
Date: Wed, 2 Oct 2024 16:23:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <20241002-inbegriff-getadelt-9275ce925594@brauner>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
 <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>

On Wed, Oct 02, 2024 at 03:36:33PM GMT, Alice Ryhl wrote:
> On Wed, Oct 2, 2024 at 3:24 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Oct 02, 2024 at 12:48:12PM GMT, Arnd Bergmann wrote:
> > > On Tue, Oct 1, 2024, at 08:22, Alice Ryhl wrote:
> > > > +#[cfg(CONFIG_COMPAT)]
> > > > +unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
> > > > +    file: *mut bindings::file,
> > > > +    cmd: c_uint,
> > > > +    arg: c_ulong,
> > > > +) -> c_long {
> > > > +    // SAFETY: The compat ioctl call of a file can access the private
> > > > data.
> > > > +    let private = unsafe { (*file).private_data };
> > > > +    // SAFETY: Ioctl calls can borrow the private data of the file.
> > > > +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private)
> > > > };
> > > > +
> > > > +    match T::compat_ioctl(device, cmd as u32, arg as usize) {
> > > > +        Ok(ret) => ret as c_long,
> > > > +        Err(err) => err.to_errno() as c_long,
> > > > +    }
> > > > +}
> > >
> > > I think this works fine as a 1:1 mapping of the C API, so this
> > > is certainly something we can do. On the other hand, it would be
> > > nice to improve the interface in some way and make it better than
> > > the C version.
> > >
> > > The changes that I think would be straightforward and helpful are:
> > >
> > > - combine native and compat handlers and pass a flag argument
> > >   that the callback can check in case it has to do something
> > >   special for compat mode
> > >
> > > - pass the 'arg' value as both a __user pointer and a 'long'
> > >   value to avoid having to cast. This specifically simplifies
> > >   the compat version since that needs different types of
> > >   64-bit extension for incoming 32-bit values.
> > >
> > > On top of that, my ideal implementation would significantly
> > > simplify writing safe ioctl handlers by using the information
> > > encoded in the command word:
> > >
> > >  - copy the __user data into a kernel buffer for _IOW()
> > >    and back for _IOR() type commands, or both for _IOWR()
> > >  - check that the argument size matches the size of the
> > >    structure it gets assigned to
> >
> > - Handle versioning by size for ioctl()s correctly so stuff like:
> >
> >         /* extensible ioctls */
> >         switch (_IOC_NR(ioctl)) {
> >         case _IOC_NR(NS_MNT_GET_INFO): {
> >                 struct mnt_ns_info kinfo = {};
> >                 struct mnt_ns_info __user *uinfo = (struct mnt_ns_info __user *)arg;
> >                 size_t usize = _IOC_SIZE(ioctl);
> >
> >                 if (ns->ops->type != CLONE_NEWNS)
> >                         return -EINVAL;
> >
> >                 if (!uinfo)
> >                         return -EINVAL;
> >
> >                 if (usize < MNT_NS_INFO_SIZE_VER0)
> >                         return -EINVAL;
> >
> >                 return copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
> >         }
> >
> > This is not well-known and noone versions ioctl()s correctly and if they
> > do it's their own hand-rolled thing. Ideally, this would be a first
> > class concept with Rust bindings and versioning like this would be
> > universally enforced.
> 
> Could you point me at some more complete documentation or example of
> how to correctly do versioning?

So I don't want you to lead astray so if this is out of reach for now I
understand but basically we do have the concept of versioning structs by
size.

So I'm taking an example from the mount_setattr() man page though
openat2() would also work:

   Extensibility
       In order to allow for future extensibility, mount_setattr()
       requires the user-space application to specify the size of the
       mount_attr structure that it is passing.  By  providing  this
       information,  it  is  possible for mount_setattr() to provide
       both forwards- and backwards-compatibility, with size acting as
       an implicit version number.  (Because new extension fields will
       always be appended, the structure size will always increase.)
       This extensibility design is very similar  to  other  system
       calls  such  as  perf_setattr(2),  perf_event_open(2), clone3(2)
       and openat2(2).

       Let  usize  be the size of the structure as specified by the
       user-space application, and let ksize be the size of the
       structure which the kernel supports, then there are three cases
       to consider:

       •  If ksize equals usize, then there is no version mismatch and
          attr can be used verbatim.

       •  If ksize is larger than usize, then there are some extension
	  fields that the kernel supports which the user-space
	  application is unaware of.  Because a zero value in any  added
	  extension field signifies a no-op, the kernel treats all of
	  the extension fields not provided by the user-space
	  application as having zero values.  This provides
	  backwards-compatibility.

       •  If ksize is smaller than usize, then there are some extension
	  fields which the user-space application is aware of but which
	  the kernel does not support.  Because any extension field must
	  have  its  zero  values signify a no-op, the kernel can safely
	  ignore the unsupported extension fields if they are all zero.
	  If any unsupported extension fields are non-zero, then -1 is
	  returned and errno is set to E2BIG.  This provides
	  forwards-compatibility.

   [...]

In essence ioctl()s are already versioned by size because the size of
the passed argument is encoded in the ioctl cmd:

struct my_struct {
	__u64 a;
};

ioctl(fd, MY_IOCTL, &my_struct);

then _IOC_SIZE(MY_IOCTL) will give you the expected size.

If the kernel extends the struct to:

struct my_struct {
	__u64 a;
	__u64 b;
};

then the value of MY_IOCTL changes. Most code currently cannot deal with
such an extension because it's coded as a simple switch on the ioctl
command:

switch (cmd) {
	case MY_IOCTL:
		/* do something */
		break;
}

So on an older kernel the ioctl would now fail because it won't be able
to handle MY_STRUCT with an increased struct my_struct size because the
switch wouldn't trigger.

The correct way to handle this is to grab the actual ioctl number out
from the ioctl command:

switch (_IOC_NR(cmd)) {
        case _IOC_NR(MY_STRUCT): {

and then grab the size of the ioctl:

        size_t usize = _IOC_SIZE(ioctl);

perform sanity checks:

	// garbage
        if (usize < MY_STRUCT_SIZE_VER0)
                return -EINVAL;

	// ¿qué?
	if (usize > PAGE_SIZE)
		return -EINVAL;

and then copy the stuff via copy_struct_from_user() or copy back out to
user via other means.

This way you can safely extend ioctl()s in a backward and forward
compatible manner and if we can enforce this for new drivers then I
think that's what we should do.

