Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AC07160C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjE3M5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjE3M5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:57:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7F170F;
        Tue, 30 May 2023 05:56:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 290C71F8D9;
        Tue, 30 May 2023 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685451384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pImTMv2ejj9AacHDSf7Nt79aDzZx9U+lgS9O/dY3ExM=;
        b=O2yFVCke4J49ugRH1NixduJHaPTEzkagJ3WOmTaYFC+gryTnmWdmluMrshK6UqGORUmf8e
        SCkN5zLyoh5l5nJRqovjdG2PQdnem6sk2Yg8MmuXJip9vNyt/lkOwLks4270ttP+pfijSC
        NOjVITDPD3iAe+nWd+KE8fKLBMuDIds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685451384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pImTMv2ejj9AacHDSf7Nt79aDzZx9U+lgS9O/dY3ExM=;
        b=ZasBD3X7E1qBFMcu23oiaUs9acAGCJhp7+TcLn1O5TXPLaIH3gKADdbDN3X1UA9Ai7Waa/
        WczpmtyKKKrd2PCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1078A13478;
        Tue, 30 May 2023 12:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JYL9A3jydWRFLgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 12:56:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ACBB1A0754; Tue, 30 May 2023 14:56:23 +0200 (CEST)
Date:   Tue, 30 May 2023 14:56:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/13] block: remove blk_drop_partitions
Message-ID: <20230530125623.iwloeckou7l42rwf@quack3>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-9-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-05-23 06:23:17, Christoph Hellwig wrote:
> There is only a single caller left, so fold the loop into that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/partitions/core.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 31ac815d77a83c..2559bb830273eb 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -524,17 +524,6 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
>  	return true;
>  }
>  
> -static void blk_drop_partitions(struct gendisk *disk)
> -{
> -	struct block_device *part;
> -	unsigned long idx;
> -
> -	lockdep_assert_held(&disk->open_mutex);
> -
> -	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> -		delete_partition(part);
> -}
> -
>  static bool blk_add_partition(struct gendisk *disk,
>  		struct parsed_partitions *state, int p)
>  {
> @@ -651,6 +640,8 @@ static int blk_add_partitions(struct gendisk *disk)
>  
>  int bdev_disk_changed(struct gendisk *disk, bool invalidate)
>  {
> +	struct block_device *part;
> +	unsigned long idx;
>  	int ret = 0;
>  
>  	lockdep_assert_held(&disk->open_mutex);
> @@ -663,8 +654,9 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
>  		return -EBUSY;
>  	sync_blockdev(disk->part0);
>  	invalidate_bdev(disk->part0);
> -	blk_drop_partitions(disk);
>  
> +	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> +		delete_partition(part);
>  	clear_bit(GD_NEED_PART_SCAN, &disk->state);
>  
>  	/*
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
