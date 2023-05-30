Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E97715E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjE3MJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjE3MJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:09:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B9C7;
        Tue, 30 May 2023 05:09:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0AC31F889;
        Tue, 30 May 2023 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685448583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=za7ozJts1z+R5+jhnlp2wo4ir7fwRpchFa2w7Hd2K7g=;
        b=CE3vEcbEMxnFkAuOpT/GH8olrYjShkUfs4yTcjNuAVkDbYkiaK8jmrvNvDZASQis8QgfhG
        vbyAfw5FOXxNy2y/rWfHHYczldrT3r/1oTT5qquytDvTI+MzzOec9puRb4YhkYDRyboKja
        YgdegPyOWbV5k2RQ47Ck/QwRcEB0aw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685448583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=za7ozJts1z+R5+jhnlp2wo4ir7fwRpchFa2w7Hd2K7g=;
        b=hjmjW4telcNBYP+ba49FUhMfsShtAvsmTLZ4yNnwzQhP75AJBOTOtNT9a0wic4DQ9V4mWr
        jS5KhLGqrRRrIPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC2DC13597;
        Tue, 30 May 2023 12:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D5k8LYfndWR0EwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 12:09:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 45E4FA0754; Tue, 30 May 2023 14:09:43 +0200 (CEST)
Date:   Tue, 30 May 2023 14:09:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/13] block: unhash the inode earlier in delete_partition
Message-ID: <20230530120943.hgqody3chstk4sri@quack3>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-05-23 06:23:15, Christoph Hellwig wrote:
> Move the call to remove_inode_hash to the beginning of delete_partition,
> as we want to prevent opening a block_device that is about to be removed
> ASAP.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The justification looks a bit bogus because we hold disk->open_mutex in
delete_partition() which serializes with any opens anyway. But it's a
harmless code move so if it helps later then sure... Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/partitions/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 49e0496ff23c1e..fa5c707fe0ad2f 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -267,6 +267,12 @@ static void delete_partition(struct block_device *part)
>  {
>  	lockdep_assert_held(&part->bd_disk->open_mutex);
>  
> +	/*
> +	 * Remove the block device from the inode hash, so that it cannot be
> +	 * looked up any more even when openers still hold references.
> +	 */
> +	remove_inode_hash(part->bd_inode);
> +
>  	fsync_bdev(part);
>  	__invalidate_device(part, true);
>  
> @@ -274,12 +280,6 @@ static void delete_partition(struct block_device *part)
>  	kobject_put(part->bd_holder_dir);
>  	device_del(&part->bd_device);
>  
> -	/*
> -	 * Remove the block device from the inode hash, so that it cannot be
> -	 * looked up any more even when openers still hold references.
> -	 */
> -	remove_inode_hash(part->bd_inode);
> -
>  	put_device(&part->bd_device);
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
