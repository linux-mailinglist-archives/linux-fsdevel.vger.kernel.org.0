Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C452CC94F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgLBWD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgLBWD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:03:57 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E16C0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:03:17 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id p12so2285844qtp.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QW1YqGh0jstSBT1vrOTPp/c6teinpDzsuVv5/rUdzXY=;
        b=UqocdO8SFbsk05+YEa5voIyzzZbck5Idt+Ojf0XT+CmVaDZl6rGC1mxhm7l2jV6Qd4
         UchbVvg8xjjafePAxLtdzvvhHrZUD8sWGJZFulmFnSr3d3pJGi+ttXp2/dDHoqC+DaOQ
         /Z5lXUsozX3WcpLGI1NwPVD9O+wyn8BIKvylg0/GytoHAq3v6TrH8BGQUAPLFTt2cuth
         MEhrGK8qK/WBQ/QG3cRvt6Jni20usgHfYHxizxq8zpvVV3m0QqdSVOpcImwxANPhG8df
         lLDS48TLZCZVAZeEEDy3DOBE+P3iz/CpWlK7cK6mOi72P8e5jS71MSDXl5p2VPpW9GuV
         Krww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QW1YqGh0jstSBT1vrOTPp/c6teinpDzsuVv5/rUdzXY=;
        b=SjzU+myfDpTtV4sMWZ7c66KX00ymb4noh/MnT46dKBy5JvaBYIc+iqfuV1yjnyPwp5
         Y35EcTQ0e5y//kDwr4Ik0efCJa490QJPSidMs6CSqjiGufjOrv9Rgqjty9mDNa3NDDLo
         2n0f6t5te9arnOPM7dvC50xyU34bi4+Gt7/QbIvb0i2D2MnQ1YHsE41U3zWPfZMzO3s0
         ZiKvbH9qgtpNeDzazchO54PXGYPZCmmSsW1lV2EpDRQ6Ft6JPdMKhWSaZVUwDkw6azLa
         FTt7vQwKYsbJZ1NpqQc8FJo29V6AVHKPee+kJvt1XfJiwiLR5s8BsZiF4tKmdBFUT3TZ
         2rsA==
X-Gm-Message-State: AOAM530MBLcpSVWEcYauzzfD60aRkiYg29dlew6Le96k0jssBrNFbzsX
        WbmWENZxg5W7dSOHYWHD32YHtw==
X-Google-Smtp-Source: ABdhPJxVzuP+Lertp0OGczTWMYLNFBBWlZsLmuEZXuhGPYkrF9qWrtb/QwCSqavAGXdRvJLyzGDYuQ==
X-Received: by 2002:ac8:444e:: with SMTP id m14mr291514qtn.120.1606946596672;
        Wed, 02 Dec 2020 14:03:16 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h13sm277758qtc.4.2020.12.02.14.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:03:16 -0800 (PST)
Subject: Re: [PATCH v6 11/11] btrfs: implement RWF_ENCODED writes
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605723568.git.osandov@fb.com>
 <fe58a0fe2c1455567fe1e9e62232e8b711797a93.1605723568.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1336bfb3-b1e7-62ea-a9c4-21fdf344d1f8@toxicpanda.com>
Date:   Wed, 2 Dec 2020 17:03:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fe58a0fe2c1455567fe1e9e62232e8b711797a93.1605723568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 2:18 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The implementation resembles direct I/O: we have to flush any ordered
> extents, invalidate the page cache, and do the io tree/delalloc/extent
> map/ordered extent dance. From there, we can reuse the compression code
> with a minor modification to distinguish the write from writeback. This
> also creates inline extents when possible.
> 
> Now that read and write are implemented, this also sets the
> FMODE_ENCODED_IO flag in btrfs_file_open().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/btrfs/compression.c  |   7 +-
>   fs/btrfs/compression.h  |   6 +-
>   fs/btrfs/ctree.h        |   2 +
>   fs/btrfs/file.c         |  37 +++++-
>   fs/btrfs/inode.c        | 259 +++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/ordered-data.c |  12 +-
>   fs/btrfs/ordered-data.h |   2 +
>   7 files changed, 313 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index eaa6fe21c08e..015c9e5d75b9 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -336,7 +336,8 @@ static void end_compressed_bio_write(struct bio *bio)
>   			bio->bi_status == BLK_STS_OK);
>   	cb->compressed_pages[0]->mapping = NULL;
>   
> -	end_compressed_writeback(inode, cb);
> +	if (cb->writeback)
> +		end_compressed_writeback(inode, cb);
>   	/* note, our inode could be gone now */
>   
>   	/*
> @@ -372,7 +373,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   				 struct page **compressed_pages,
>   				 unsigned long nr_pages,
>   				 unsigned int write_flags,
> -				 struct cgroup_subsys_state *blkcg_css)
> +				 struct cgroup_subsys_state *blkcg_css,
> +				 bool writeback)
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct bio *bio = NULL;
> @@ -396,6 +398,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	cb->mirror_num = 0;
>   	cb->compressed_pages = compressed_pages;
>   	cb->compressed_len = compressed_len;
> +	cb->writeback = writeback;
>   	cb->orig_bio = NULL;
>   	cb->nr_pages = nr_pages;
>   
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 8001b700ea3a..f95cdc16f503 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -49,6 +49,9 @@ struct compressed_bio {
>   	/* the compression algorithm for this bio */
>   	int compress_type;
>   
> +	/* Whether this is a write for writeback. */
> +	bool writeback;
> +
>   	/* number of compressed pages in the array */
>   	unsigned long nr_pages;
>   
> @@ -96,7 +99,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   				  struct page **compressed_pages,
>   				  unsigned long nr_pages,
>   				  unsigned int write_flags,
> -				  struct cgroup_subsys_state *blkcg_css);
> +				  struct cgroup_subsys_state *blkcg_css,
> +				  bool writeback);
>   blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   				 int mirror_num, unsigned long bio_flags);
>   
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ce78424f1d98..9b585ac9c7a9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3134,6 +3134,8 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>   void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>   					  u64 end, int uptodate);
>   ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
> +ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
> +			       struct encoded_iov *encoded);
>   
>   extern const struct dentry_operations btrfs_dentry_operations;
>   extern const struct iomap_ops btrfs_dio_iomap_ops;
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 193477565200..f815ffb93d43 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1994,6 +1994,32 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>   	return written ? written : err;
>   }
>   
> +static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	struct encoded_iov encoded;
> +	ssize_t ret;
> +
> +	ret = copy_encoded_iov_from_iter(&encoded, from);
> +	if (ret)
> +		return ret;
> +
> +	btrfs_inode_lock(inode, 0);
> +	ret = generic_encoded_write_checks(iocb, &encoded);
> +	if (ret || encoded.len == 0)
> +		goto out;
> +
> +	ret = btrfs_write_check(iocb, from, encoded.len);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = btrfs_do_encoded_write(iocb, from, &encoded);
> +out:
> +	btrfs_inode_unlock(inode, 0);
> +	return ret;
> +}
> +
>   static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>   				    struct iov_iter *from)
>   {
> @@ -2012,14 +2038,17 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>   	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>   		return -EROFS;
>   
> -	if (!(iocb->ki_flags & IOCB_DIRECT) &&
> -	    (iocb->ki_flags & IOCB_NOWAIT))
> +	if ((iocb->ki_flags & IOCB_NOWAIT) &&
> +	    (!(iocb->ki_flags & IOCB_DIRECT) ||
> +	     (iocb->ki_flags & IOCB_ENCODED)))
>   		return -EOPNOTSUPP;
>   
>   	if (sync)
>   		atomic_inc(&BTRFS_I(inode)->sync_writers);
>   
> -	if (iocb->ki_flags & IOCB_DIRECT)
> +	if (iocb->ki_flags & IOCB_ENCODED)
> +		num_written = btrfs_encoded_write(iocb, from);
> +	else if (iocb->ki_flags & IOCB_DIRECT)
>   		num_written = btrfs_direct_write(iocb, from);
>   	else
>   		num_written = btrfs_buffered_write(iocb, from);
> @@ -3586,7 +3615,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
>   
>   static int btrfs_file_open(struct inode *inode, struct file *filp)
>   {
> -	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
> +	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_ENCODED_IO;
>   	return generic_file_open(inode, filp);
>   }
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b0e800897b3b..2bf7b487939f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -935,7 +935,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
>   				    ins.offset, async_extent->pages,
>   				    async_extent->nr_pages,
>   				    async_chunk->write_flags,
> -				    async_chunk->blkcg_css)) {
> +				    async_chunk->blkcg_css, true)) {
>   			struct page *p = async_extent->pages[0];
>   			const u64 start = async_extent->start;
>   			const u64 end = start + async_extent->ram_size - 1;
> @@ -2703,6 +2703,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
>   	 * except if the ordered extent was truncated.
>   	 */
>   	update_inode_bytes = test_bit(BTRFS_ORDERED_DIRECT, &oe->flags) ||
> +	                     test_bit(BTRFS_ORDERED_ENCODED, &oe->flags) ||

Gotta use our git hooks, checkpatch caught the spaces here.  Thanks,

Josef
