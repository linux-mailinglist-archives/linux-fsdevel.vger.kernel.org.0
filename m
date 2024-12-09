Return-Path: <linux-fsdevel+bounces-36764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD549E91D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF7E163A19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FB3219E83;
	Mon,  9 Dec 2024 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="anVeeApt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F1218E89;
	Mon,  9 Dec 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742599; cv=none; b=IQlAl/tV/TnG04TFovWQDQiN9aJ1dlKGgE4RBQujtGxAfIQ4Ogn/x9g58KygMy+7su27NQPaY4kD/8vjbIzWpWGvZs9naneAAPkvel3eD22OmBZKHpid4uJrlV0Ps4lDg8xmlkQ1K5GXkrr7rhGoLnNt6fcKL/f0zyeTmYaf3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742599; c=relaxed/simple;
	bh=VumTmRaCzRQISnd6p9lOWbjB9d5HmoTLpCD91tuivAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7TMS3HramoOzBSTmJJk+typf7H+KZ/RG8fF+WhuvaqXntZvjRWGqdtSKuRdezsFQSRtCm8HNkh8H9jbaVQY6VnkK31QWVApGax3sJgxzIEVXA2ZUYd3/hmJUgyH8clgyQaVnoRlf8i0ncGimD/UdKS6iXrShH5yDvuezJfTuu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=anVeeApt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68118C4CEDE;
	Mon,  9 Dec 2024 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733742599;
	bh=VumTmRaCzRQISnd6p9lOWbjB9d5HmoTLpCD91tuivAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anVeeAptfSlRvOf5a+YpVl+UDWbl2kh6+C9xWuzkNrbQQlVGbbnhe1v/umRp/wNK1
	 HqBfQcFnPcEaODzSmIyTV2VCS26SuvG6keieW/Rte+seM7+UjcvzggnNw3bgJycCEW
	 kQTI9L9xbiZZ3GpQc9k8fgE7fVoIEaomk7yWOTc4=
Date: Mon, 9 Dec 2024 12:09:55 +0100
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
Message-ID: <2024120954-boring-skeptic-ad16@gregkh>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <2024120925-express-unmasked-76b4@gregkh>
 <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>

On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> On Mon, Dec 9, 2024 at 9:48 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > Providing access to the underlying `struct miscdevice` is useful for
> > > various reasons. For example, this allows you access the miscdevice's
> > > internal `struct device` for use with the `dev_*` printing macros.
> > >
> > > Note that since the underlying `struct miscdevice` could get freed at
> > > any point after the fops->open() call, only the open call is given
> > > access to it. To print from other calls, they should take a refcount on
> > > the device to keep it alive.
> >
> > The lifespan of the miscdevice is at least from open until close, so
> > it's safe for at least then (i.e. read/write/ioctl/etc.)
> 
> How is that enforced? What happens if I call misc_deregister while
> there are open fds?

You shouldn't be able to do that as the code that would be calling
misc_deregister() (i.e. in a module unload path) would not work because
the module reference count is incremented at this point in time due to
the file operation module reference.

Wait, we are plumbing in the module owner logic here, right?  That
should be in the file operations structure.

Yeah, it's a horrid hack, and one day we will put "real" revoke logic in
here to detach the misc device from the file operations if this were to
happen.  It's a very very common anti-pattern that many subsystems have
that is a bug that we all have been talking about for a very very long
time.  Wolfram even has a plan for how to fix it all up (see his Japan
LinuxCon talk from 2 years ago), but I don't think anyone is doing the
work on it :(

The media and drm layers have internal hacks/work-arounds to try to
handle this issue, but luckily for us, the odds of a misc device being
dynamically removed from the system is pretty low.

Once / if ever, we get the revoke type logic implemented, then we can
apply that to the misc device code and follow it through to the rust
side if needed.

> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  rust/kernel/miscdevice.rs | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > index 0cb79676c139..c5af1d5ec4be 100644
> > > --- a/rust/kernel/miscdevice.rs
> > > +++ b/rust/kernel/miscdevice.rs
> > > @@ -104,7 +104,7 @@ pub trait MiscDevice {
> > >      /// Called when the misc device is opened.
> > >      ///
> > >      /// The returned pointer will be stored as the private data for the file.
> > > -    fn open(_file: &File) -> Result<Self::Ptr>;
> > > +    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
> > >
> > >      /// Called when the misc device is released.
> > >      fn release(device: Self::Ptr, _file: &File) {
> > > @@ -190,14 +190,27 @@ impl<T: MiscDevice> VtableHelper<T> {
> > >          return ret;
> > >      }
> > >
> > > +    // SAFETY: The opwn call of a file can access the private data.
> >
> > s/opwn/open/ :)
> >
> > > +    let misc_ptr = unsafe { (*file).private_data };
> >
> > Blank line here?
> >
> > > +    // SAFETY: This is a miscdevice, so `misc_open()` set the private data to a pointer to the
> > > +    // associated `struct miscdevice` before calling into this method. Furthermore, `misc_open()`
> > > +    // ensures that the miscdevice can't be unregistered and freed during this call to `fops_open`.
> >
> > Aren't we wrapping comment lines at 80 columns still?  I can't remember
> > anymore...
> 
> Not sure what the rules are, but I don't think Rust comments are being
> wrapped at 80.

Ok, that's fine, I didn't remember either.

> > > +    let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
> > > +
> > >      // SAFETY:
> > > -    // * The file is valid for the duration of this call.
> > > +    // * The file is valid for the duration of the `T::open` call.
> >
> > It's valid for the lifespan between open/release.
> >
> > >      // * There is no active fdget_pos region on the file on this thread.
> > > -    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
> > > +    let file = unsafe { File::from_raw_file(file) };
> > > +
> > > +    let ptr = match T::open(file, misc) {
> > >          Ok(ptr) => ptr,
> > >          Err(err) => return err.to_errno(),
> > >      };
> > >
> > > +    // This overwrites the private data from above. It makes sense to not hold on to the misc
> > > +    // pointer since the `struct miscdevice` can get unregistered as soon as we return from this
> > > +    // call, so the misc pointer might be dangling on future file operations.
> > > +    //
> >
> > Wait, what are we overwriting this here with?  Now private data points
> > to the misc device when before it was the file structure.  No other code
> > needed to be changed because of that?  Can't we enforce this pointer
> > type somewhere so that any casts in any read/write/ioctl also "knows" it
> > has the right type?  This feels "dangerous" to me.
> 
> Ultimately, when interfacing with C code using void pointers, Rust is
> going to need a pointer cast somewhere to assert what the type is.
> With the current design, that place is the fops_* functions. We need
> to get the pointer casts right there, but anywhere else the types are
> enforced.

So where else is this type enforced?  A read/write/ioctl call also wants
this pointer, or is it up to the open call to stash it somewhere that
those calls can get to it?  It's hanging off of the file pointer now:

> > >      // SAFETY: The open call of a file owns the private data.
> > >      unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };

So any place that casts back from that structure needs to get this
correct.  Is that up to each individual misc device driver to do it (to
be fair, that's what the C drivers do, just wanting to be sure here.)

Ah, wait, I get it, you are just storing the "raw" pointer to the rust
implementation of the structure, NOT the C "raw" pointer like it
currently is today.  You are making this all match up with the existing
code.

Sorry for the noise, this all makes sense to me now, I didn't have
enough coffee for that first code review.

> >
> > Is this SAFETY comment still correct?
> 
> Well, it could probably be worded better at least. The point is that
> nobody else is going to touch this field and we can do what we want
> with it.

True, ok, that's fine.

Care to respin this with at least the typo fixed?

thanks,

greg k-h

