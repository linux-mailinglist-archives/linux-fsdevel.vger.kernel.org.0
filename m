Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600B36E45FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjDQLEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjDQLE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:04:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2EC4214;
        Mon, 17 Apr 2023 04:03:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B429B1F86C;
        Mon, 17 Apr 2023 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681729309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SS3bez6CP/3CF6Uq5lLeJvDqNlw7dIr/fp2FmnGCM5k=;
        b=mFsRl/lKO22xWXubMNqkTtcw7xRT0/gfDCgsGtao30zDYvXCOoNdNNbYen9TuLhSM1QvaC
        97t++Bp/AImgWQdh9U4dHb47pIt788sPbBS4VCUORBZmy2F8a1MIo6OKORJl+1nPhAA+Mc
        FUgdJjrIPGTsrzlHZZUMZC3ODeBKoOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681729309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SS3bez6CP/3CF6Uq5lLeJvDqNlw7dIr/fp2FmnGCM5k=;
        b=AvgTEsHlIjO+0GMSl7enHFgiKta18FLX5DMg2edq4GvEc+a1EKLh5CwkvDbplK3Bl+lCDV
        x0EVTO5fH4viLlBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4ABA1390E;
        Mon, 17 Apr 2023 11:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eeglKB0nPWRIGQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Apr 2023 11:01:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 284C9A0744; Mon, 17 Apr 2023 13:01:49 +0200 (CEST)
Date:   Mon, 17 Apr 2023 13:01:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv5 2/9] fs/buffer.c: Add generic_buffer_fsync
 implementation
Message-ID: <20230417110149.mhrksh4owqkfw5pa@quack3>
References: <cover.1681639164.git.ritesh.list@gmail.com>
 <7a7c48bf0a91d00f1114db2dc6b1269c25f7513b.1681639164.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a7c48bf0a91d00f1114db2dc6b1269c25f7513b.1681639164.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 16-04-23 15:38:37, Ritesh Harjani (IBM) wrote:
> Some of the higher layers like iomap takes inode_lock() when calling
> generic_write_sync().
> Also writeback already happens from other paths without inode lock,
> so it's difficult to say that we really need sync_mapping_buffers() to
> take any inode locking here. Having said that, let's add
> generic_buffer_fsync() implementation in buffer.c with no
> inode_lock/unlock() for now so that filesystems like ext2 and
> ext4's nojournal mode can use it.
> 
> Ext4 when got converted to iomap for direct-io already copied it's own
> variant of __generic_file_fsync() without lock. Hence let's add a helper
> API and use it both in ext2 and ext4.
> 
> Later we can review other filesystems as well to see if we can make
> generic_buffer_fsync() which does not take any inode_lock() as the
> default path.
> 
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

There is a problem with generic_buffer_fsync() that it does not call
blkdev_issue_flush() so the caller is responsible for doing that. That's
necessary for ext2 & ext4 so fine for now. But historically this was the
case with generic_file_fsync() as well and that led to many filesystem
forgetting to flush caches from fsync(2). What is our transition plan for
these filesystems that currently do the cache flush from
generic_file_fsync()? Do we want to eventually keep generic_file_fsync()
doing the cache flush and call generic_buffer_fsync() instead of
__generic_buffer_fsync() from it?

								Honza

> ---
>  fs/buffer.c                 | 43 +++++++++++++++++++++++++++++++++++++
>  include/linux/buffer_head.h |  2 ++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9e1e2add541e..df98f1966a71 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -593,6 +593,49 @@ int sync_mapping_buffers(struct address_space *mapping)
>  }
>  EXPORT_SYMBOL(sync_mapping_buffers);
>  
> +/**
> + * generic_buffer_fsync - generic buffer fsync implementation
> + * for simple filesystems with no inode lock
> + *
> + * @file:	file to synchronize
> + * @start:	start offset in bytes
> + * @end:	end offset in bytes (inclusive)
> + * @datasync:	only synchronize essential metadata if true
> + *
> + * This is a generic implementation of the fsync method for simple
> + * filesystems which track all non-inode metadata in the buffers list
> + * hanging off the address_space structure.
> + */
> +int generic_buffer_fsync(struct file *file, loff_t start, loff_t end,
> +			 bool datasync)
> +{
> +	struct inode *inode = file->f_mapping->host;
> +	int err;
> +	int ret;
> +
> +	err = file_write_and_wait_range(file, start, end);
> +	if (err)
> +		return err;
> +
> +	ret = sync_mapping_buffers(inode->i_mapping);
> +	if (!(inode->i_state & I_DIRTY_ALL))
> +		goto out;
> +	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> +		goto out;
> +
> +	err = sync_inode_metadata(inode, 1);
> +	if (ret == 0)
> +		ret = err;
> +
> +out:
> +	/* check and advance again to catch errors after syncing out buffers */
> +	err = file_check_and_advance_wb_err(file);
> +	if (ret == 0)
> +		ret = err;
> +	return ret;
> +}
> +EXPORT_SYMBOL(generic_buffer_fsync);
> +
>  /*
>   * Called when we've recently written block `bblock', and it is known that
>   * `bblock' was for a buffer_boundary() buffer.  This means that the block at
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 8f14dca5fed7..3170d0792d52 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -211,6 +211,8 @@ int inode_has_buffers(struct inode *);
>  void invalidate_inode_buffers(struct inode *);
>  int remove_inode_buffers(struct inode *inode);
>  int sync_mapping_buffers(struct address_space *mapping);
> +int generic_buffer_fsync(struct file *file, loff_t start, loff_t end,
> +			 bool datasync);
>  void clean_bdev_aliases(struct block_device *bdev, sector_t block,
>  			sector_t len);
>  static inline void clean_bdev_bh_alias(struct buffer_head *bh)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
