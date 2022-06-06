Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4553E371
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFFIiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiFFIiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:38:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074C3193A;
        Mon,  6 Jun 2022 01:38:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8DE0D1F461;
        Mon,  6 Jun 2022 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654504695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/ycmcP40JfEr5ZA2cVnkunkPduEzl79HGPWdaa0J4s=;
        b=bfGNF+pd/JsCb2543fqSLDK2cwhTVUdVVgsivmWkvWBvOlY50u3Erg0fkax5sk8W3LdAo5
        AqfBD8smGy/l2AnZJYo+bUj3HeyntbaWPORU6Ti2ZTXiBtrJGAuLmL5TZaj2FUVg6V3tU7
        +EJ+gZl6OcpO6BF6/tQTpAS52pKLXgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654504695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/ycmcP40JfEr5ZA2cVnkunkPduEzl79HGPWdaa0J4s=;
        b=vhIE0NnKC0zBb/W9efmO6bYIz1D0vxZggfAoqi9e8uaTCMm1pxoqLPaySAhUOGThSvdHjT
        KUZP9zRwKDSfvWCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 79B3A2C141;
        Mon,  6 Jun 2022 08:38:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC475A0633; Mon,  6 Jun 2022 10:38:14 +0200 (CEST)
Date:   Mon, 6 Jun 2022 10:38:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.com>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Use generic_quota_read()
Message-ID: <20220606083814.skjv34b2tjn7l7pi@quack3.lan>
References: <20220605143815.2330891-1-willy@infradead.org>
 <20220605143815.2330891-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605143815.2330891-4-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 05-06-22 15:38:15, Matthew Wilcox (Oracle) wrote:
> The comment about the page cache is rather stale; the buffer cache will
> read into the page cache if the buffer isn't present, and the page cache
> will not take any locks if the page is present.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This will not work for couple of reasons, see below. BTW, I don't think the
comment about page cache was stale (but lacking details I admit ;). As far
as I remember (and it was really many years ago - definitely pre-git era)
the problem was (mainly on the write side) that before current state of the
code we were using calls like vfs_read() / vfs_write() to get quota
information and that was indeed prone to deadlocks.

> @@ -6924,20 +6882,21 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
>  		return -EIO;
>  	}
>  
> -	do {
> -		bh = ext4_bread(handle, inode, blk,
> -				EXT4_GET_BLOCKS_CREATE |
> -				EXT4_GET_BLOCKS_METADATA_NOFAIL);
> -	} while (PTR_ERR(bh) == -ENOSPC &&
> -		 ext4_should_retry_alloc(inode->i_sb, &retries));
> -	if (IS_ERR(bh))
> -		return PTR_ERR(bh);
> -	if (!bh)
> +	folio = read_mapping_folio(inode->i_mapping, off / PAGE_SIZE, NULL);
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
> +	head = folio_buffers(folio);
> +	if (!head)
> +		head = alloc_page_buffers(&folio->page, sb->s_blocksize, false);
> +	if (!head)
>  		goto out;
> +	bh = head;
> +	while ((bh_offset(bh) + sb->s_blocksize) <= (off % PAGE_SIZE))
> +		bh = bh->b_this_page;

We miss proper handling of blocks that are currently beyond i_size
(we are extending the quota file), plus we also miss any mapping of buffers
to appropriate disk blocks here...

It could be all fixed by replicating what we do in ext4_write_begin() but
I'm not quite convinced using inode's page cache is really worth it...

								Honza

>  	BUFFER_TRACE(bh, "get write access");
>  	err = ext4_journal_get_write_access(handle, sb, bh, EXT4_JTR_NONE);
>  	if (err) {
> -		brelse(bh);
> +		folio_put(folio);
>  		return err;
>  	}
>  	lock_buffer(bh);
> @@ -6945,14 +6904,14 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
>  	flush_dcache_page(bh->b_page);
>  	unlock_buffer(bh);
>  	err = ext4_handle_dirty_metadata(handle, NULL, bh);
> -	brelse(bh);
>  out:
> +	folio_put(folio);
> +	if (err)
> +		return err;
>  	if (inode->i_size < off + len) {
>  		i_size_write(inode, off + len);
>  		EXT4_I(inode)->i_disksize = inode->i_size;
> -		err2 = ext4_mark_inode_dirty(handle, inode);
> -		if (unlikely(err2 && !err))
> -			err = err2;
> +		err = ext4_mark_inode_dirty(handle, inode);
>  	}
>  	return err ? err : len;
>  }
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
