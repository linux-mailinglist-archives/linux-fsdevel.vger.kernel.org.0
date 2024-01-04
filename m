Return-Path: <linux-fsdevel+bounces-7341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F776823BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 06:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD1E1C23972
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DEC1A70F;
	Thu,  4 Jan 2024 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjbdbUL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92118EBF;
	Thu,  4 Jan 2024 05:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F059C433C8;
	Thu,  4 Jan 2024 05:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704345295;
	bh=vrs+0DPrO9fX6l9WjdFBkjwlcIPZPMUtpgan0Iq9AZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjbdbUL5NB2LHVHs9bLoe823PIDehLD04lFAXKgNdk/ypMP7Vgy65FBqUG2ho1P7e
	 9MKpGNYt3Suwgcstz3EWgQETReFSV4zuUYtL/kfhpeCBAyJ23AAQSIYeMh7rk0o0MG
	 bPC53m48JlP1IJas4taIwbp9VwxvgvgdvPhVN1DiIvtXphQNDF2zjkkRaWFwMR9Wem
	 MRNlo43cq9wHNUSnknUxkwskCUNE7On9FYQ0BgyZ/SPwMikUiHdBY/y5EOYkBL03SX
	 lLktE4VNCAb05Ksl6+QMlWUGFfykALbUQDuFgJIcvfzFK3LgIeMBnNgwi4Hk2Wy7+7
	 XLKeT1kpc2YJA==
Date: Wed, 3 Jan 2024 21:14:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Message-ID: <20240104051454.GC3964019@frogsfrogsfrogs>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-6-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-6-wedsonaf@gmail.com>

On Wed, Oct 18, 2023 at 09:25:04AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Allow Rust file systems to handle typed and ref-counted inodes.
> 
> This is in preparation for creating new inodes (for example, to create
> the root inode of a new superblock), which comes in the next patch in
> the series.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/helpers.c    |  7 +++++++
>  rust/kernel/fs.rs | 53 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 4c86fe4a7e05..fe45f8ddb31f 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -25,6 +25,7 @@
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
>  #include <linux/errname.h>
> +#include <linux/fs.h>
>  #include <linux/mutex.h>
>  #include <linux/refcount.h>
>  #include <linux/sched/signal.h>
> @@ -144,6 +145,12 @@ struct kunit *rust_helper_kunit_get_current_test(void)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
>  
> +off_t rust_helper_i_size_read(const struct inode *inode)

i_size_read returns a loff_t (aka __kernel_loff_t (aka long long)),
but this returns    an off_t (aka __kernel_off_t (aka long)).

Won't that cause truncation issues for files larger than 4GB on some
architectures?

> +{
> +	return i_size_read(inode);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
>   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 31cf643aaded..30fa1f312f33 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -7,9 +7,9 @@
>  //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
>  
>  use crate::error::{code::*, from_result, to_result, Error, Result};
> -use crate::types::Opaque;
> +use crate::types::{AlwaysRefCounted, Opaque};
>  use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
> -use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
> +use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
>  use macros::{pin_data, pinned_drop};
>  
>  /// Maximum size of an inode.
> @@ -94,6 +94,55 @@ fn drop(self: Pin<&mut Self>) {
>      }
>  }
>  
> +/// The number of an inode.
> +pub type Ino = u64;
> +
> +/// A node in the file system index (inode).
> +///
> +/// Wraps the kernel's `struct inode`.
> +///
> +/// # Invariants
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `ihold` ensures that the
> +/// allocation remains valid at least until the matching call to `iput`.
> +#[repr(transparent)]
> +pub struct INode<T: FileSystem + ?Sized>(Opaque<bindings::inode>, PhantomData<T>);
> +
> +impl<T: FileSystem + ?Sized> INode<T> {
> +    /// Returns the number of the inode.
> +    pub fn ino(&self) -> Ino {
> +        // SAFETY: `i_ino` is immutable, and `self` is guaranteed to be valid by the existence of a
> +        // shared reference (&self) to it.
> +        unsafe { (*self.0.get()).i_ino }

Is "*self.0.get()" the means by which the Rust bindings get at the
actual C object?

(Forgive me, I've barely finished drying the primer coat on my rust-fu.)

> +    }
> +
> +    /// Returns the super-block that owns the inode.
> +    pub fn super_block(&self) -> &SuperBlock<T> {
> +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
> +        // shared reference (&self) to it.
> +        unsafe { &*(*self.0.get()).i_sb.cast() }
> +    }
> +
> +    /// Returns the size of the inode contents.
> +    pub fn size(&self) -> i64 {

I'm a little surprised I didn't see a

pub type loff_t = i64

followed by this function returning a loff_t.  Or maybe it would be
better to define it as:

struct loff_t(i64);

So that dopey fs developers like me cannot so easily assign a file
position (bytes) to a pgoff_t (page index) without either supplying an
actual conversion operator or seeing complaints from the compiler.

> +        // SAFETY: `self` is guaranteed to be valid by the existence of a shared reference.
> +        unsafe { bindings::i_size_read(self.0.get()) }

It's confusing that rust_i_size_read returns a long but on the rust side,
INode::size returns an i64.

--D

> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `INode` is always ref-counted.
> +unsafe impl<T: FileSystem + ?Sized> AlwaysRefCounted for INode<T> {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::ihold(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::iput(obj.cast().as_ptr()) }
> +    }
> +}
> +
>  /// A file system super block.
>  ///
>  /// Wraps the kernel's `struct super_block`.
> -- 
> 2.34.1
> 
> 

