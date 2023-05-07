Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D936FB0C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjEHNBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjEHNBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 09:01:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7187394AA;
        Mon,  8 May 2023 06:01:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B5CF21FBA;
        Mon,  8 May 2023 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pj7CvqzR8CXSddpYxdqP0Iqe3iGGk2qRYVYbSelEOBI=;
        b=Td6pEa7uWupCHlSHMr02WSOjEha94ei/ucC6nL8pYzn0RcJamr57e3hucpKhpb6IAhexWM
        RZFxCUn+qTJmzgk2z2EgLLMXZMOEhONq10wGtRRHXhEa5BrbFTNEpLp/1KmHWWNkSyIR2O
        uadiwYFSDWFD1tbZyD4upsNqKiq2gHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pj7CvqzR8CXSddpYxdqP0Iqe3iGGk2qRYVYbSelEOBI=;
        b=2cEiSAIna6+NxO7+nSsMxpJnBNqeORxyI0AnsPXM/PbvBqwQTQ88oHTtFNIWvkF/5KT5kE
        +IFhTZiRFjtuIgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03E9313A5E;
        Mon,  8 May 2023 13:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lm4VAKvyWGSlXQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0551AA0762; Sun,  7 May 2023 21:19:46 +0200 (CEST)
Date:   Sun, 7 May 2023 21:19:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/9] block: add a mark_dead holder operation
Message-ID: <20230507191946.lwndaj75bxpldeab@quack3>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-7-hch@lst.de>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 05-05-23 13:51:29, Christoph Hellwig wrote:
> Add a mark_dead method to blk_holder_ops that is called from blk_mark_disk_dead
> to notify the holder that the block device it is using has been marked dead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One question below:

> ---
>  block/genhd.c          | 24 ++++++++++++++++++++++++
>  include/linux/blkdev.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d1c673b967c254..af97a4ef1e926c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -575,6 +575,28 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  }
>  EXPORT_SYMBOL(device_add_disk);
>  
> +static void blk_report_disk_dead(struct gendisk *disk)
> +{
> +	struct block_device *bdev;
> +	unsigned long idx;
> +
> +	rcu_read_lock();
> +	xa_for_each(&disk->part_tbl, idx, bdev) {
> +		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
> +			continue;
> +		rcu_read_unlock();
> +
> +		mutex_lock(&bdev->bd_holder_lock);
> +		if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
> +			bdev->bd_holder_ops->mark_dead(bdev);
> +		mutex_unlock(&bdev->bd_holder_lock);
> +
> +		put_device(&bdev->bd_device);
> +		rcu_read_lock();
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * blk_mark_disk_dead - mark a disk as dead
>   * @disk: disk to mark as dead
> @@ -602,6 +624,8 @@ void blk_mark_disk_dead(struct gendisk *disk)
>  	 * Prevent new I/O from crossing bio_queue_enter().
>  	 */
>  	blk_queue_start_drain(disk->queue);
> +
> +	blk_report_disk_dead(disk);

Hum, but this gets called from del_gendisk() after blk_drop_partitions()
happens. So how is this going to be able to iterate anything?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
