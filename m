Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9DD715E39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjE3L7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 07:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjE3L7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 07:59:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5AFE;
        Tue, 30 May 2023 04:58:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E7681F889;
        Tue, 30 May 2023 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685447917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kb5vc4AG4J83fkXSYmJ56zVUujGuPMlPp79zGyvNEfk=;
        b=x8pNSyRZfwWeFhGNTtNEL7iVGMovfmHJC0hoZsSud6JoKkvIVxTvMxeqRFRWv50jwDbafK
        dJyS8RqyZOFl6ikNUZZw/XW7a7KTnpoAu0fhb4Pi+VYepxATjMhoAgAod4P2LLrgBd+g6v
        eyuIFZn8zUkOo3TV9biYs4Z/tbWDFSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685447917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kb5vc4AG4J83fkXSYmJ56zVUujGuPMlPp79zGyvNEfk=;
        b=ic8kPdgtHkVtqgDkYacVGeaBkUCOryYSeNBagz7h9+eLA8pefRvXbBJ4kVobE/wk89TvBC
        GGpZZiojBZupx/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 106D313597;
        Tue, 30 May 2023 11:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JD33A+3kdWStDAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 11:58:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A33BEA0754; Tue, 30 May 2023 13:58:36 +0200 (CEST)
Date:   Tue, 30 May 2023 13:58:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/13] block: consolidate the shutdown logic in
 blk_mark_disk_dead and del_gendisk
Message-ID: <20230530115836.sja2pxjs554nfjle@quack3>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-5-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-05-23 06:23:13, Christoph Hellwig wrote:
> blk_mark_disk_dead does very similar work a a section of del_gendisk:
> 
>  - set the GD_DEAD flag
>  - set the capacity to zero
>  - start a queue drain
> 
> but del_gendisk also sets QUEUE_FLAG_DYING on the queue if it is owned by
> the disk, sets the capacity to zero before starting the drain, and both
> with sending a uevent and kernel message for this fake capacity change.
> 
> Move the exact logic from the more heavily used del_gendisk into
> blk_mark_disk_dead and then call blk_mark_disk_dead from del_gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. I've convinced myself the removed notification of device
capacity going to 0 before KOBJ_REMOVE event should not matter to userspace
;). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 1cb489b927d50a..d8fe40c7d1f0a2 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -572,13 +572,22 @@ EXPORT_SYMBOL(device_add_disk);
>   */
>  void blk_mark_disk_dead(struct gendisk *disk)
>  {
> +	/*
> +	 * Fail any new I/O.
> +	 */
>  	set_bit(GD_DEAD, &disk->state);
> -	blk_queue_start_drain(disk->queue);
> +	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> +		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
>  
>  	/*
>  	 * Stop buffered writers from dirtying pages that can't be written out.
>  	 */
> -	set_capacity_and_notify(disk, 0);
> +	set_capacity(disk, 0);
> +
> +	/*
> +	 * Prevent new I/O from crossing bio_queue_enter().
> +	 */
> +	blk_queue_start_drain(disk->queue);
>  }
>  EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
>  
> @@ -620,18 +629,7 @@ void del_gendisk(struct gendisk *disk)
>  	fsync_bdev(disk->part0);
>  	__invalidate_device(disk->part0, true);
>  
> -	/*
> -	 * Fail any new I/O.
> -	 */
> -	set_bit(GD_DEAD, &disk->state);
> -	if (test_bit(GD_OWNS_QUEUE, &disk->state))
> -		blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> -	set_capacity(disk, 0);
> -
> -	/*
> -	 * Prevent new I/O from crossing bio_queue_enter().
> -	 */
> -	blk_queue_start_drain(q);
> +	blk_mark_disk_dead(disk);
>  
>  	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>  		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
