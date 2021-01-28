Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715E0306A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 02:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhA1BOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 20:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhA1BMt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:12:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C716E64DDF;
        Thu, 28 Jan 2021 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611796290;
        bh=3FKSeGnFSwLkGexruEOmwHRIKSYHxicnwpAlMSpiAT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/ERDr1EtOYI56UIZB9j2JNHozqDhWyX+bjnXABK2JTnrz8WrPrA2NdNmR0S9Vwr9
         lCeyOi7twFAPbik55xmmPhKyASSD6zfxImNaOv48LzamOPI5XseRZvAgrmHnbUyhJS
         a2ds6MwGuxgOJRvJMdqSRxff+ar+YatPn0QgEzuJ6NbH87qnMp1L5myO7J0pNt4LXm
         wSnzuUHTIWHRh6N5cKhi/twUilgk4nPUTj5KxVVW2mkmCXZlkr8V4hFmuhLnpb4tSn
         VA4e39wM1WfUKoBlSW3DsRlxU0/jt+jFHv7xTXzUR9SdZVZXnqazqZCy/SMpOmbsQY
         3N/OLFEoH0yqw==
Date:   Wed, 27 Jan 2021 17:11:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 6/6] fs-verity: support reading signature with ioctl
Message-ID: <YBIPQOGtzsTUFsNg@google.com>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115181819.34732-7-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/15, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for FS_VERITY_METADATA_TYPE_SIGNATURE to
> FS_IOC_READ_VERITY_METADATA.  This allows a userspace server program to
> retrieve the built-in signature (if present) of a verity file for
> serving to a client which implements fs-verity compatible verification.
> See the patch which introduced FS_IOC_READ_VERITY_METADATA for more
> details.
> 
> The ability for userspace to read the built-in signatures is also useful
> because it allows a system that is using the in-kernel signature
> verification to migrate to userspace signature verification.
> 
> This has been tested using a new xfstest which calls this ioctl via a
> new subcommand for the 'fsverity' program from fsverity-utils.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  Documentation/filesystems/fsverity.rst |  9 +++++++-
>  fs/verity/read_metadata.c              | 30 ++++++++++++++++++++++++++
>  include/uapi/linux/fsverity.h          |  1 +
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> index 6dc5772037ef9..1d831e3cbcb33 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst
> @@ -236,6 +236,7 @@ This ioctl takes in a pointer to the following structure::
>  
>     #define FS_VERITY_METADATA_TYPE_MERKLE_TREE     1
>     #define FS_VERITY_METADATA_TYPE_DESCRIPTOR      2
> +   #define FS_VERITY_METADATA_TYPE_SIGNATURE       3
>  
>     struct fsverity_read_metadata_arg {
>             __u64 metadata_type;
> @@ -256,6 +257,10 @@ This ioctl takes in a pointer to the following structure::
>  - ``FS_VERITY_METADATA_TYPE_DESCRIPTOR`` reads the fs-verity
>    descriptor.  See `fs-verity descriptor`_.
>  
> +- ``FS_VERITY_METADATA_TYPE_SIGNATURE`` reads the signature which was
> +  passed to FS_IOC_ENABLE_VERITY, if any.  See `Built-in signature
> +  verification`_.
> +
>  The semantics are similar to those of ``pread()``.  ``offset``
>  specifies the offset in bytes into the metadata item to read from, and
>  ``length`` specifies the maximum number of bytes to read from the
> @@ -279,7 +284,9 @@ FS_IOC_READ_VERITY_METADATA can fail with the following errors:
>  - ``EINTR``: the ioctl was interrupted before any data was read
>  - ``EINVAL``: reserved fields were set, or ``offset + length``
>    overflowed
> -- ``ENODATA``: the file is not a verity file
> +- ``ENODATA``: the file is not a verity file, or
> +  FS_VERITY_METADATA_TYPE_SIGNATURE was requested but the file doesn't
> +  have a built-in signature
>  - ``ENOTTY``: this type of filesystem does not implement fs-verity, or
>    this ioctl is not yet implemented on it
>  - ``EOPNOTSUPP``: the kernel was not configured with fs-verity
> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index 2dea6dd3bb05a..7e2d0c7bdf0de 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -114,6 +114,34 @@ static int fsverity_read_descriptor(struct inode *inode,
>  	kfree(desc);
>  	return res;
>  }
> +
> +static int fsverity_read_signature(struct inode *inode,
> +				   void __user *buf, u64 offset, int length)
> +{
> +	struct fsverity_descriptor *desc;
> +	size_t desc_size;
> +	int res;
> +
> +	res = fsverity_get_descriptor(inode, &desc, &desc_size);
> +	if (res)
> +		return res;
> +
> +	if (desc->sig_size == 0) {
> +		res = -ENODATA;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Include only the signature.  Note that fsverity_get_descriptor()
> +	 * already verified that sig_size is in-bounds.
> +	 */
> +	res = fsverity_read_buffer(buf, offset, length, desc->signature,
> +				   le32_to_cpu(desc->sig_size));
> +out:
> +	kfree(desc);
> +	return res;
> +}
> +
>  /**
>   * fsverity_ioctl_read_metadata() - read verity metadata from a file
>   * @filp: file to read the metadata from
> @@ -158,6 +186,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
>  						 length);
>  	case FS_VERITY_METADATA_TYPE_DESCRIPTOR:
>  		return fsverity_read_descriptor(inode, buf, arg.offset, length);
> +	case FS_VERITY_METADATA_TYPE_SIGNATURE:
> +		return fsverity_read_signature(inode, buf, arg.offset, length);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
> index 41abc283dbccb..15384e22e331e 100644
> --- a/include/uapi/linux/fsverity.h
> +++ b/include/uapi/linux/fsverity.h
> @@ -85,6 +85,7 @@ struct fsverity_formatted_digest {
>  
>  #define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
>  #define FS_VERITY_METADATA_TYPE_DESCRIPTOR	2
> +#define FS_VERITY_METADATA_TYPE_SIGNATURE	3
>  
>  struct fsverity_read_metadata_arg {
>  	__u64 metadata_type;
> -- 
> 2.30.0
