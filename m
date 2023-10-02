Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7907B587C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjJBQYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjJBQYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:24:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370039D
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 09:24:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E513D21863;
        Mon,  2 Oct 2023 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696263874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GkW1jD/WjAlcaqWGAn7H9ocHRS6CaRxGfeUdV72JuE=;
        b=AeevxUIfhKUa/yIcCQOArOlho7YlY0Dvl9PnPtDmPo5otTGodRIbiSj/yM3RudFR7/X8Jv
        /HDQ7SxoEQR/kh86Ugd+Q70PolIwn8Ze7IW1lxcrdS5UABpMuK9fZojhH/gTsw/9thpYI6
        hcRNTl4WPXYuWYn81yhU+2u0cwZy360=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696263874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GkW1jD/WjAlcaqWGAn7H9ocHRS6CaRxGfeUdV72JuE=;
        b=3XLSUqVhsXXHuavc2T5/wWrkdrK0dyqBboPmYpNlgsC7tqMspDl3E+twp4UKZ0uqsDJYaK
        V4vCmli9fhMJSyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D504113456;
        Mon,  2 Oct 2023 16:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aj79M8LuGmW1IAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 16:24:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5ABADA07C9; Mon,  2 Oct 2023 18:24:34 +0200 (CEST)
Date:   Mon, 2 Oct 2023 18:24:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 5/7] super: remove bd_fsfreeze_{mutex,sb}
Message-ID: <20231002162434.drpefjux7qt4inoq@quack3>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 15:21:18, Christian Brauner wrote:
> Both bd_fsfreeze_mutex and bd_fsfreeze_sb are now unused and can be
> removed. Also move bd_fsfreeze_count down to not have it weirdly placed
> in the middle of the holder fields.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c              | 1 -
>  include/linux/blk_types.h | 7 ++-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3deccd0ffcf2..084855b669f7 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -392,7 +392,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
>  
>  	bdev = I_BDEV(inode);
> -	mutex_init(&bdev->bd_fsfreeze_mutex);
>  	spin_lock_init(&bdev->bd_size_lock);
>  	mutex_init(&bdev->bd_holder_lock);
>  	bdev->bd_partno = partno;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 88e1848b0869..0238236852b7 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -56,14 +56,11 @@ struct block_device {
>  	void *			bd_holder;
>  	const struct blk_holder_ops *bd_holder_ops;
>  	struct mutex		bd_holder_lock;
> -	/* The counter of freeze processes */
> -	atomic_t		bd_fsfreeze_count;
>  	int			bd_holders;
>  	struct kobject		*bd_holder_dir;
>  
> -	/* Mutex for freeze */
> -	struct mutex		bd_fsfreeze_mutex;
> -	struct super_block	*bd_fsfreeze_sb;
> +	/* The counter of freeze processes */
> +	atomic_t		bd_fsfreeze_count;
>  
>  	struct partition_meta_info *bd_meta_info;
>  #ifdef CONFIG_FAIL_MAKE_REQUEST
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
