Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9D42EFE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhJOLrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 07:47:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50018 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbhJOLry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:47:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5026A1FD57;
        Fri, 15 Oct 2021 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634298347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBp8w7xMCDpu9yJTLtMWaL+eb2DX5zEZEsPx6eVJxTs=;
        b=f8TaSGmexkahjz7nAQws0t8ab/cwV+TXVfJn+rFPp7cDlV7qokh6+Uh44a7PNol8gcQa3G
        7Ggl6v0Ps/lpHmi3nOrfi6Md4cMPcR1CqU1JbhU8a0G19PQu5Tc6aoKFIcPyEyKG2EF6BL
        FcumO7Hakhe0Ovg2B9APqfr1pdIl1ko=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0986D13C1B;
        Fri, 15 Oct 2021 11:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RPFnO+ppaWFqegAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 15 Oct 2021 11:45:46 +0000
Subject: Re: [PATCH v11 08/14] btrfs: add BTRFS_IOC_ENCODED_READ
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <c8c9bc3a546359bda7420d92d3d61d1023c1cb96.1630514529.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4a64bf3a-b691-1986-80c8-21ddf9e446a0@suse.com>
Date:   Fri, 15 Oct 2021 14:45:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c8c9bc3a546359bda7420d92d3d61d1023c1cb96.1630514529.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There are 4 main cases:
> 
> 1. Inline extents: we copy the data straight out of the extent buffer.
> 2. Hole/preallocated extents: we fill in zeroes.
> 3. Regular, uncompressed extents: we read the sectors we need directly
>    from disk.
> 4. Regular, compressed extents: we read the entire compressed extent
>    from disk and indicate what subset of the decompressed extent is in
>    the file.
> 
> This initial implementation simplifies a few things that can be improved
> in the future:
> 
> - We hold the inode lock during the operation.
> - Cases 1, 3, and 4 allocate temporary memory to read into before
>   copying out to userspace.
> - We don't do read repair, because it turns out that read repair is
>   currently broken for compressed data.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/ctree.h |   4 +
>  fs/btrfs/inode.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/ioctl.c | 111 +++++++++++
>  3 files changed, 604 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b95ec5fb68d5..cbd7e07c1c34 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3223,6 +3223,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
>  void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
>  					  struct page *page, u64 start,
>  					  u64 end, bool uptodate);
> +struct btrfs_ioctl_encoded_io_args;
> +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> +			   struct btrfs_ioctl_encoded_io_args *encoded);
> +
>  extern const struct dentry_operations btrfs_dentry_operations;
>  extern const struct iomap_ops btrfs_dio_iomap_ops;
>  extern const struct iomap_dio_ops btrfs_dio_ops;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a87a34f56234..1940f22179ba 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10500,6 +10500,495 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
>  	}
>  }
>  

<snip>

> +
> +static blk_status_t btrfs_encoded_read_check_bio(struct btrfs_io_bio *io_bio)

nit: The gist of this function is to check the csum so how about
renaming it to btrfs_encoded_read_verify_csum

<snip>

> +
> +static void btrfs_encoded_read_endio(struct bio *bio)
> +{
> +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
> +	blk_status_t status;
> +
> +	status = btrfs_encoded_read_check_bio(io_bio);
> +	if (status) {
> +		/*
> +		 * The memory barrier implied by the atomic_dec_return() here
> +		 * pairs with the memory barrier implied by the
> +		 * atomic_dec_return() or io_wait_event() in

nit: I think atomic_dec_return in read_regular_fill_pages is
inconsequential, what we want to ensure is that when the caller of
io_wait_event is woken up by this thread it will observe the
priv->status, which it will, because the atomic-dec_return in this
function has paired with the general barrier interpolated by wait_event.

So for brevity just leave the text to say "by io_wait_event".

> +		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
> +		 * write is observed before the load of status in
> +		 * btrfs_encoded_read_regular_fill_pages().
> +		 */
> +		WRITE_ONCE(priv->status, status);
> +	}
> +	if (!atomic_dec_return(&priv->pending))
> +		wake_up(&priv->wait);
> +	btrfs_io_bio_free_csum(io_bio);
> +	bio_put(bio);
> +}

<snip>

> @@ -4824,6 +4841,94 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
>  	return ret;
>  }
>  

<snip>

> +	memset((char *)&args + copy_end_kernel, 0,
> +	       sizeof(args) - copy_end_kernel);

nit: This memset can be eliminated ( in source) by marking args = {};
and just leaving copy from user above.

> +
> +	ret = import_iovec(READ, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
> +			   &iov, &iter);
> +	if (ret < 0)
> +		goto out_acct;
> +
> +	if (iov_iter_count(&iter) == 0) {
> +		ret = 0;
> +		goto out_iov;
> +	}
> +	pos = args.offset;
> +	ret = rw_verify_area(READ, file, &pos, args.len);
> +	if (ret < 0)
> +		goto out_iov;
> +
> +	init_sync_kiocb(&kiocb, file);
> +	ret = kiocb_set_rw_flags(&kiocb, 0);

This call is a noop due to:
	if (!flags)
		return 0;

in kiocb_set_rw_flags.


<snip>
