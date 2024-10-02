Return-Path: <linux-fsdevel+bounces-30687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC898D4D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C859B21AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC351D04BE;
	Wed,  2 Oct 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt/HFHmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0881D0486;
	Wed,  2 Oct 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875473; cv=none; b=CFC/HVpfY/3fK3ocuJW2+Jr+4LSQ4jeao57tkRRUyfVgfp+aF1zvBAdb1d3MFJEOSQHCPoF7q7xdoCXw0RiVOWFkE2Y2q7XWHBBXCO9S/KY3OQHvQO3+j/RV0mGDpVkp7wZYN6kuvTyBqTWhvHbK3/hgNUURTHDVC/KtdNFeqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875473; c=relaxed/simple;
	bh=3ynA1f6IiVYsrLVszlNRfaD132cpzUmRP2GQhJKR1RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m50s6Sa3T1m2QjS7gpp1iCWJPiar3NFbpO0H6KrME8qyjcvx/Q/bFTaX7Ny8loJGPgeytQwIaXksMcb+OJtWl7v++oyjHHgpfk1JyQ//3gbHvVfoX1gOSgwkQOSlcDX4GhjyxEcVHXAHZe8+mez04rfNAwGbWD3M/X/yVny6u1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt/HFHmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A02C4CEC5;
	Wed,  2 Oct 2024 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727875473;
	bh=3ynA1f6IiVYsrLVszlNRfaD132cpzUmRP2GQhJKR1RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yt/HFHmEzqyfDLoNmpQLr13zobHNW2UUIM1+wwo4fknrkudB5HJVwBuJx9LQVadP8
	 KmH4GNemsuS2OmgYvQjd1dZdkKG/IYV5zH568Lj5BWYhxvyT6Iy+trskHVcTmzXZvy
	 ukEdM/YIz/wgYwNlQ9GuYeE7G25ZQorRz8Ge+2zENVZPRnQZ+4oDV34G1xwWXTBAh9
	 JgA7bD4fRUy3KHuullG/0iBMFxuw0AryAvwAqBmb/9AGr8srkIzACFXakeiGrIYBoH
	 MjgzbcEJwii/hizcaRT/WAnxuuuni5LUIWPh1bCe21eanN34/N+nEw9HcLYjMIDxHR
	 dnhQLyawM2cqQ==
Date: Wed, 2 Oct 2024 15:24:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>

On Wed, Oct 02, 2024 at 12:48:12PM GMT, Arnd Bergmann wrote:
> On Tue, Oct 1, 2024, at 08:22, Alice Ryhl wrote:
> > +#[cfg(CONFIG_COMPAT)]
> > +unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
> > +    file: *mut bindings::file,
> > +    cmd: c_uint,
> > +    arg: c_ulong,
> > +) -> c_long {
> > +    // SAFETY: The compat ioctl call of a file can access the private 
> > data.
> > +    let private = unsafe { (*file).private_data };
> > +    // SAFETY: Ioctl calls can borrow the private data of the file.
> > +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) 
> > };
> > +
> > +    match T::compat_ioctl(device, cmd as u32, arg as usize) {
> > +        Ok(ret) => ret as c_long,
> > +        Err(err) => err.to_errno() as c_long,
> > +    }
> > +}
> 
> I think this works fine as a 1:1 mapping of the C API, so this
> is certainly something we can do. On the other hand, it would be
> nice to improve the interface in some way and make it better than
> the C version.
> 
> The changes that I think would be straightforward and helpful are:
> 
> - combine native and compat handlers and pass a flag argument
>   that the callback can check in case it has to do something
>   special for compat mode
> 
> - pass the 'arg' value as both a __user pointer and a 'long'
>   value to avoid having to cast. This specifically simplifies
>   the compat version since that needs different types of
>   64-bit extension for incoming 32-bit values.
> 
> On top of that, my ideal implementation would significantly
> simplify writing safe ioctl handlers by using the information
> encoded in the command word:
> 
>  - copy the __user data into a kernel buffer for _IOW()
>    and back for _IOR() type commands, or both for _IOWR()
>  - check that the argument size matches the size of the
>    structure it gets assigned to

- Handle versioning by size for ioctl()s correctly so stuff like:

        /* extensible ioctls */
        switch (_IOC_NR(ioctl)) {
        case _IOC_NR(NS_MNT_GET_INFO): {
                struct mnt_ns_info kinfo = {};
                struct mnt_ns_info __user *uinfo = (struct mnt_ns_info __user *)arg;
                size_t usize = _IOC_SIZE(ioctl);

                if (ns->ops->type != CLONE_NEWNS)
                        return -EINVAL;

                if (!uinfo)
                        return -EINVAL;

                if (usize < MNT_NS_INFO_SIZE_VER0)
                        return -EINVAL;

                return copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
        }

This is not well-known and noone versions ioctl()s correctly and if they
do it's their own hand-rolled thing. Ideally, this would be a first
class concept with Rust bindings and versioning like this would be
universally enforced.

> 
> We have a couple of subsystems in the kernel that already
> do something like this, but they all do it differently.
> For newly written drivers in rust, we could try to do
> this well from the start and only offer a single reliable
> way to do it. For drivers implementing existing ioctl
> commands, an additional complication is that there are
> many command codes that encode incorrect size/direction
> data, or none at all.
> 
> I don't know if there is a good way to do that last bit
> in rust, and even if there is, we may well decide to not
> do it at first in order to get something working.
> 
>       Arnd

