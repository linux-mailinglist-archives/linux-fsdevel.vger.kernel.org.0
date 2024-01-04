Return-Path: <linux-fsdevel+bounces-7343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA98823BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 06:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3E0B24DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C61A594;
	Thu,  4 Jan 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbIVDnXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1518EBD;
	Thu,  4 Jan 2024 05:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C056FC433C7;
	Thu,  4 Jan 2024 05:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704346395;
	bh=qj93CEpeNL08A4W7d8MAiGs1eWqfnJrP6Q/gBrB32Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbIVDnXiRevPks8hE+XsLaithb5dx2C6EPVFQiHZmgaL6piP211GEg0ydrMB47Uxm
	 iH+xcUCM30ZDEeoLbIaEEPXIKXnA5xgT7ccfCSOdK8Rt5TKbzRgj/7TbRco4sT6VgM
	 i08hXBsgnnO4kPA4lo7DoOldfQYVg9DzvvklD31L6Z1qm6kWti2CfSjq3pIZhq2VrU
	 RVsE1QgAMdNxFRUkc+76dFha5Vk4o4eM93cor59DGCzyeR154NBoEd3SfIMRh0Yn80
	 86bSHwR508ln3aRfP9Dj3b+sql5rpqYyeL/hxIhn8jo9iTTfDduSxllMxcdKkj8L8Q
	 AvFkVYjxfCVVg==
Date: Wed, 3 Jan 2024 21:33:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 12/19] rust: fs: introduce `FileSystem::statfs`
Message-ID: <20240104053315.GE3964019@frogsfrogsfrogs>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-13-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-13-wedsonaf@gmail.com>

On Wed, Oct 18, 2023 at 09:25:11AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Allow Rust file systems to expose their stats. `overlayfs` requires that
> this be implemented by all file systems that are part of an overlay.
> The planned file systems need to be overlayed with overlayfs, so they
> must be able to implement this.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/error.rs            |  1 +
>  rust/kernel/fs.rs               | 52 ++++++++++++++++++++++++++++++++-
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index fa754c5e85a2..e2b2ccc835e3 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
>  #include <linux/slab.h>
> +#include <linux/statfs.h>
>  #include <linux/pagemap.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 6c167583b275..829756cf6c48 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -83,6 +83,7 @@ macro_rules! declare_err {
>      declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
>      declare_err!(ENODATA, "No data available.");
>      declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
> +    declare_err!(ENOSYS, "Invalid system call number.");
>  }
>  
>  /// Generic integer kernel error.
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index adf9cbee16d2..8f34da50e694 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -50,6 +50,31 @@ pub trait FileSystem {
>      fn read_xattr(_inode: &INode<Self>, _name: &CStr, _outbuf: &mut [u8]) -> Result<usize> {
>          Err(EOPNOTSUPP)
>      }
> +
> +    /// Get filesystem statistics.
> +    fn statfs(_sb: &SuperBlock<Self>) -> Result<Stat> {
> +        Err(ENOSYS)
> +    }
> +}
> +
> +/// File system stats.
> +///
> +/// A subset of C's `kstatfs`.
> +pub struct Stat {
> +    /// Magic number of the file system.
> +    pub magic: u32,
> +
> +    /// The maximum length of a file name.
> +    pub namelen: i64,

Yikes, I hope I never see an 8EB filename.  The C side doesn't handle
names longer than 255 bytes.

> +
> +    /// Block size.
> +    pub bsize: i64,

Or an 8EB block size.  SMR notwithstanding, I think this could be u32.

Why are these values signed?  Nobody has a -1k block filesystem.

> +    /// Number of files in the file system.
> +    pub files: u64,
> +
> +    /// Number of blocks in the file system.
> +    pub blocks: u64,
>  }
>  
>  /// The types of directory entries reported by [`FileSystem::read_dir`].
> @@ -478,7 +503,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>          freeze_fs: None,
>          thaw_super: None,
>          unfreeze_fs: None,
> -        statfs: None,
> +        statfs: Some(Self::statfs_callback),
>          remount_fs: None,
>          umount_begin: None,
>          show_options: None,
> @@ -496,6 +521,31 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>          shutdown: None,
>      };
>  
> +    unsafe extern "C" fn statfs_callback(
> +        dentry: *mut bindings::dentry,
> +        buf: *mut bindings::kstatfs,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `dentry` is valid for read. `d_sb` is
> +            // immutable, so it's safe to read it. The superblock is guaranteed to be valid dor
> +            // the duration of the call.
> +            let sb = unsafe { &*(*dentry).d_sb.cast::<SuperBlock<T>>() };
> +            let s = T::statfs(sb)?;
> +
> +            // SAFETY: The C API guarantees that `buf` is valid for read and write.
> +            let buf = unsafe { &mut *buf };
> +            buf.f_type = s.magic.into();
> +            buf.f_namelen = s.namelen;
> +            buf.f_bsize = s.bsize;
> +            buf.f_files = s.files;
> +            buf.f_blocks = s.blocks;
> +            buf.f_bfree = 0;
> +            buf.f_bavail = 0;
> +            buf.f_ffree = 0;

Why is it necessary to fill out the C structure with zeroes?
statfs_by_dentry zeroes the buffer contents before calling ->statfs.

--D

> +            Ok(0)
> +        })
> +    }
> +
>      const XATTR_HANDLERS: [*const bindings::xattr_handler; 2] = [&Self::XATTR_HANDLER, ptr::null()];
>  
>      const XATTR_HANDLER: bindings::xattr_handler = bindings::xattr_handler {
> -- 
> 2.34.1
> 
> 

