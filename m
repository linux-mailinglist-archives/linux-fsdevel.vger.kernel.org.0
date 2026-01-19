Return-Path: <linux-fsdevel+bounces-74431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F317AD3A424
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 11:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9844F30533BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F45356A22;
	Mon, 19 Jan 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5fYjPVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EC339843;
	Mon, 19 Jan 2026 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816964; cv=none; b=OWFc7SKoMKOjrLxs6xg63zyD+z4IQQ/lFcBU5X5UA2yEitm7TfNcUrZ8QECrdIGnlr3XN60kteJ58PGBJnyYCkELwtvYuxAS8Kt5tNZJLNx8FQHctNhz9q0vklteTYvYR//X0xUDDcdxcfGiqKaQB/c92TJQmttxt3Ljd5oWJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816964; c=relaxed/simple;
	bh=R6+7JktKk3jk1q6Wgbu71GPUTrJx4O0fAkPrMYm/Vcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nto+9SYv7tD3kIJiEvPB1jgFsEOREh8a28SrTrVbfhjW1NZcnQxaB+/iDYXicfEgsdDm+DLpH+amdEWY1ulBxEn1ZB3C/S8hF4T3XIcjFsMtMQYXkRIWdVrWDOpL6TRr97hLe7apU5NWGemvOWhWwVK2S6Eetgp5b4vKmk4anEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5fYjPVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAD4C116C6;
	Mon, 19 Jan 2026 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768816963;
	bh=R6+7JktKk3jk1q6Wgbu71GPUTrJx4O0fAkPrMYm/Vcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5fYjPVd7i+FiuyY+5V1e9j+yvd89tOwa/NfHqyl9kE+9r/pK/fkSMy1yUCff+6K0
	 Ho329GpWfGSLhqOqwdk2JSa64n5sQNDX35A1a8ceQoCK2XN8tka1azT1OB14YIUSlI
	 uLODq03HIEkqgBNRswNIkTVOo+BsRAhxaT7vrxQlLwoOgO6bEwBYWfAlK15c4KYd5Y
	 RZsJ9jp2mGgmaY1DDDwa+eo7o+ERdA7ptn8ue4gKvsvGX/1WORIlJrt3CgArpdwubF
	 xNr9usbeiF7lYAh+jqmVPklZkvMg/N5/cNZmTHKX7kXZ3xyQfXmCqzHLFRH5R8BA4C
	 TreSJLUGlS1qg==
Date: Mon, 19 Jan 2026 11:02:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 3/6] fs,fsverity: handle fsverity in generic_file_open
Message-ID: <20260119-davon-krippenkind-78d683621491@brauner>
References: <20260119062250.3998674-1-hch@lst.de>
 <20260119062250.3998674-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119062250.3998674-4-hch@lst.de>

On Mon, Jan 19, 2026 at 07:22:44AM +0100, Christoph Hellwig wrote:
> Call into fsverity_file_open from generic_file_open instead of requiring
> the file system to handle it explicitly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/file.c          |  6 ------
>  fs/ext4/file.c           |  4 ----
>  fs/f2fs/file.c           |  4 ----
>  fs/open.c                |  8 +++++++-
>  fs/verity/open.c         | 10 ++++++++--
>  include/linux/fsverity.h | 32 +-------------------------------
>  6 files changed, 16 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1abc7ed2990e..4b3a31b2b52e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3808,16 +3808,10 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
>  
>  static int btrfs_file_open(struct inode *inode, struct file *filp)
>  {
> -	int ret;
> -
>  	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
>  		return -EIO;
>  
>  	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> -
> -	ret = fsverity_file_open(inode, filp);
> -	if (ret)
> -		return ret;
>  	return generic_file_open(inode, filp);
>  }
>  
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..a7dc8c10273e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -906,10 +906,6 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  	if (ret)
>  		return ret;
>  
> -	ret = fsverity_file_open(inode, filp);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * Set up the jbd2_inode if we are opening the inode for
>  	 * writing and the journal is present
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index da029fed4e5a..f1510ab657b6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -624,10 +624,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>  	if (!f2fs_is_compress_backend_ready(inode))
>  		return -EOPNOTSUPP;
>  
> -	err = fsverity_file_open(inode, filp);
> -	if (err)
> -		return err;
> -
>  	filp->f_mode |= FMODE_NOWAIT;
>  	filp->f_mode |= FMODE_CAN_ODIRECT;
>  
> diff --git a/fs/open.c b/fs/open.c
> index f328622061c5..dea93bab8795 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -10,6 +10,7 @@
>  #include <linux/file.h>
>  #include <linux/fdtable.h>
>  #include <linux/fsnotify.h>
> +#include <linux/fsverity.h>
>  #include <linux/module.h>
>  #include <linux/tty.h>
>  #include <linux/namei.h>
> @@ -1604,10 +1605,15 @@ SYSCALL_DEFINE0(vhangup)
>   * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
>   * on this flag in sys_open.
>   */
> -int generic_file_open(struct inode * inode, struct file * filp)
> +int generic_file_open(struct inode *inode, struct file *filp)
>  {
>  	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
>  		return -EOVERFLOW;
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> +		if (filp->f_mode & FMODE_WRITE)
> +			return -EPERM;
> +		return fsverity_file_open(inode, filp);
> +	}

This is the only one where I'm not happy about the location.
This hides the ordering requirement between fsverity and fscrypt. It's
easier to miss now. This also really saves very little compared to the
other changes. So I wonder whether it's really that big of a deal to
have the call located in the open routines of the filesystems.

