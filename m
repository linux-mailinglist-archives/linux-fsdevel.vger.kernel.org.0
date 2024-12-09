Return-Path: <linux-fsdevel+bounces-36751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F89E8DC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC918853FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F87215712;
	Mon,  9 Dec 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x8UdDn/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773671EB3D;
	Mon,  9 Dec 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734127; cv=none; b=KrJ6O3PIfJ2KJDg6uka05Wfw/BOnGLAxvEuNwhUEzpbMlhiPBTYwxY0Gsz5mRUa1V1Vn+KW89//E/HJnZ4GD7lNDt8Y1T3V0IQJXqgWqSlQpYCibpNzTrVVrYRsIYkx6XvnaBkXPUD0OrWGS/+NW+fcPt5aTvydeau/4c3/Yy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734127; c=relaxed/simple;
	bh=0puQfJttu0wk+szabfo5NeG637ftnthHgnUH89CbeCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZgAWH184DhUq5jPguCfibhigAIgsYxdsxAKnX/6X9+4JW/OphQc4tbtLLefoj28vX7JE4kklTfLA6uYCeuWYfSW3DTqTQhFeev/zWFo9cbIdpKOcXznUFuKW/j9mRwBL0dvIx3CLDXyHHgXo/Me8vG7F+Va3mv5nJAGwfk6p50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x8UdDn/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E76EC4CED1;
	Mon,  9 Dec 2024 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733734127;
	bh=0puQfJttu0wk+szabfo5NeG637ftnthHgnUH89CbeCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x8UdDn/ovjmgS2gKKVJsZBCTALXQ4zWxEN7WKWLcHloMd/wCcBO6UOE3wpwlc1Wkj
	 FOkATrkz0a/nCHk8g0hz7gvrpaACNJzG07BM8qllN6I43+dyOmgGRuiW8jLzJoNsMn
	 OURWlgxB4S+etfyHldxRjD9aC6OG0icr0vxH+hD0=
Date: Mon, 9 Dec 2024 09:48:43 +0100
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
Message-ID: <2024120925-express-unmasked-76b4@gregkh>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>

On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> Providing access to the underlying `struct miscdevice` is useful for
> various reasons. For example, this allows you access the miscdevice's
> internal `struct device` for use with the `dev_*` printing macros.
> 
> Note that since the underlying `struct miscdevice` could get freed at
> any point after the fops->open() call, only the open call is given
> access to it. To print from other calls, they should take a refcount on
> the device to keep it alive.

The lifespan of the miscdevice is at least from open until close, so
it's safe for at least then (i.e. read/write/ioctl/etc.)

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 0cb79676c139..c5af1d5ec4be 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -104,7 +104,7 @@ pub trait MiscDevice {
>      /// Called when the misc device is opened.
>      ///
>      /// The returned pointer will be stored as the private data for the file.
> -    fn open(_file: &File) -> Result<Self::Ptr>;
> +    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
>  
>      /// Called when the misc device is released.
>      fn release(device: Self::Ptr, _file: &File) {
> @@ -190,14 +190,27 @@ impl<T: MiscDevice> VtableHelper<T> {
>          return ret;
>      }
>  
> +    // SAFETY: The opwn call of a file can access the private data.

s/opwn/open/ :)

> +    let misc_ptr = unsafe { (*file).private_data };

Blank line here?

> +    // SAFETY: This is a miscdevice, so `misc_open()` set the private data to a pointer to the
> +    // associated `struct miscdevice` before calling into this method. Furthermore, `misc_open()`
> +    // ensures that the miscdevice can't be unregistered and freed during this call to `fops_open`.

Aren't we wrapping comment lines at 80 columns still?  I can't remember
anymore...

> +    let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
> +
>      // SAFETY:
> -    // * The file is valid for the duration of this call.
> +    // * The file is valid for the duration of the `T::open` call.

It's valid for the lifespan between open/release.

>      // * There is no active fdget_pos region on the file on this thread.
> -    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
> +    let file = unsafe { File::from_raw_file(file) };
> +
> +    let ptr = match T::open(file, misc) {
>          Ok(ptr) => ptr,
>          Err(err) => return err.to_errno(),
>      };
>  
> +    // This overwrites the private data from above. It makes sense to not hold on to the misc
> +    // pointer since the `struct miscdevice` can get unregistered as soon as we return from this
> +    // call, so the misc pointer might be dangling on future file operations.
> +    //

Wait, what are we overwriting this here with?  Now private data points
to the misc device when before it was the file structure.  No other code
needed to be changed because of that?  Can't we enforce this pointer
type somewhere so that any casts in any read/write/ioctl also "knows" it
has the right type?  This feels "dangerous" to me.

>      // SAFETY: The open call of a file owns the private data.
>      unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };

Is this SAFETY comment still correct?

thanks,

greg k-h

