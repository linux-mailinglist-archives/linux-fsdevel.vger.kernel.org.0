Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD93F2D59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhHTNpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:45:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53112 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhHTNpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:45:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E02A61FE1C;
        Fri, 20 Aug 2021 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629467067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5raNlKgvypG7IvfRrvozam7fNEdYbSYncKz54HTIlg=;
        b=AXJTqRgTe7+ZMMjypRJG30qUS5KwW+B5C7xNBu7XN26GRX6JVdXzyNnkW6lLINsTMe75HH
        1t/3zOOrFEBGy5aeWN7tKX4FcBnwtrqXTgjQYtsOEziIXEpwjQ3u6YXRxamZ5HK7rUWgPo
        We+sOQMk74pzsWhDr/KnvCFd3LV2/fE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 83A6213ADF;
        Fri, 20 Aug 2021 13:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 457LHLuxH2HnGwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 20 Aug 2021 13:44:27 +0000
Subject: Re: [PATCH v10 09/14] btrfs: add BTRFS_IOC_ENCODED_WRITE
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <cover.1629234193.git.osandov@fb.com>
 <497af8b97838225920491f9146d9f65b6539e2d2.1629234193.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <bb47ef73-0f9c-55b2-c916-5774a3fe5278@suse.com>
Date:   Fri, 20 Aug 2021 16:44:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <497af8b97838225920491f9146d9f65b6539e2d2.1629234193.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.08.21 г. 0:06, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The implementation resembles direct I/O: we have to flush any ordered
> extents, invalidate the page cache, and do the io tree/delalloc/extent
> map/ordered extent dance. From there, we can reuse the compression code
> with a minor modification to distinguish the write from writeback. This
> also creates inline extents when possible.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

<snip>

>   * Add an entry indicating a block group or device which is pinned by a
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7a0a9c752624..13a0a65c6a43 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -103,6 +103,8 @@ struct btrfs_ioctl_encoded_io_args_32 {
>  
>  #define BTRFS_IOC_ENCODED_READ_32 _IOR(BTRFS_IOCTL_MAGIC, 64, \
>  				       struct btrfs_ioctl_encoded_io_args_32)
> +#define BTRFS_IOC_ENCODED_WRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 64, \
> +					struct btrfs_ioctl_encoded_io_args_32)
>  #endif
>  
>  /* Mask out flags that are inappropriate for the given type of inode. */
> @@ -4992,6 +4994,102 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
>  	return ret;
>  }
>  
> +static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp,
> +				     bool compat)
> +{
> +	struct btrfs_ioctl_encoded_io_args args;
> +	struct iovec iovstack[UIO_FASTIOV];
> +	struct iovec *iov = iovstack;
> +	struct iov_iter iter;
> +	loff_t pos;
> +	struct kiocb kiocb;
> +	ssize_t ret;
> +
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		ret = -EPERM;
> +		goto out_acct;
> +	}
> +
> +	if (!(file->f_mode & FMODE_WRITE)) {
> +		ret = -EBADF;
> +		goto out_acct;
> +	}
> +
> +	if (compat) {
> +#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
> +		struct btrfs_ioctl_encoded_io_args_32 args32;
> +
> +		if (copy_from_user(&args32, argp, sizeof(args32))) {
> +			ret = -EFAULT;
> +			goto out_acct;
> +		}
> +		args.iov = compat_ptr(args32.iov);
> +		args.iovcnt = args.iovcnt;
> +		memcpy(&args.offset, &args32.offset,
> +		       sizeof(args) -
> +		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
> +#else
> +		return -ENOTTY;
> +#endif
> +	} else {
> +		if (copy_from_user(&args, argp, sizeof(args))) {
> +			ret = -EFAULT;
> +			goto out_acct;
> +		}
> +	}
> +
> +	ret = -EINVAL;
> +	if (args.flags != 0)
> +		goto out_acct;
> +	if (memchr_inv(args.reserved, 0, sizeof(args.reserved)))
> +		goto out_acct;
> +	if (args.compression == BTRFS_ENCODED_IO_COMPRESSION_NONE &&
> +	    args.encryption == BTRFS_ENCODED_IO_ENCRYPTION_NONE)

Do you intend on supporting encrypted data writeout in the future, given
that in btrfs_do_encoded_write EINVAL is returned if the data to be
written is encrypted? If not then this check could be moved earlier to
fail fast.

<snip>

> @@ -5138,9 +5236,13 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		return fsverity_ioctl_measure(file, argp);
>  	case BTRFS_IOC_ENCODED_READ:
>  		return btrfs_ioctl_encoded_read(file, argp, false);
> +	case BTRFS_IOC_ENCODED_WRITE:
> +		return btrfs_ioctl_encoded_write(file, argp, false);
>  #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
>  	case BTRFS_IOC_ENCODED_READ_32:
>  		return btrfs_ioctl_encoded_read(file, argp, true);
> +	case BTRFS_IOC_ENCODED_WRITE_32:
> +		return btrfs_ioctl_encoded_write(file, argp, true);
>  #endif
>  	}
>  
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 550c34fa0e6d..180f302dee93 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -521,9 +521,15 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
>  	spin_lock(&btrfs_inode->lock);
>  	btrfs_mod_outstanding_extents(btrfs_inode, -1);
>  	spin_unlock(&btrfs_inode->lock);
> -	if (root != fs_info->tree_root)
> -		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
> -						false);
> +	if (root != fs_info->tree_root) {
> +		u64 release;
> +
> +		if (test_bit(BTRFS_ORDERED_ENCODED, &entry->flags))
> +			release = entry->disk_num_bytes;
> +		else
> +			release = entry->num_bytes;
> +		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
> +	}
>  
>  	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
>  				 fs_info->delalloc_batch);
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 0feb0c29839e..04588ccad34c 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -74,6 +74,8 @@ enum {
>  	BTRFS_ORDERED_LOGGED_CSUM,
>  	/* We wait for this extent to complete in the current transaction */
>  	BTRFS_ORDERED_PENDING,
> +	/* RWF_ENCODED I/O */

nit: RWF_ENCODED is no longer, we simply have ioctl-based encoded io. So
this needs to be renamed to avoid confusion for people not necessarily
faimilar with the development history of the feature.

> +	BTRFS_ORDERED_ENCODED,
>  };
>  
>  /* BTRFS_ORDERED_* flags that specify the type of the extent. */
> @@ -81,7 +83,8 @@ enum {
>  				  (1UL << BTRFS_ORDERED_NOCOW) |	\
>  				  (1UL << BTRFS_ORDERED_PREALLOC) |	\
>  				  (1UL << BTRFS_ORDERED_COMPRESSED) |	\
> -				  (1UL << BTRFS_ORDERED_DIRECT))
> +				  (1UL << BTRFS_ORDERED_DIRECT) |	\
> +				  (1UL << BTRFS_ORDERED_ENCODED))
>  
>  struct btrfs_ordered_extent {
>  	/* logical offset in the file */
> 
