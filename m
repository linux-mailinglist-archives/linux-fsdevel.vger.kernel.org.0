Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D5715D92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjE3LmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjE3Llz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 07:41:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDF7180;
        Tue, 30 May 2023 04:41:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A14E1F8B9;
        Tue, 30 May 2023 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685446909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNkvyNSd6Gfbh+iwH/YENF6xAIahzjc7Hs/dYYi9deo=;
        b=xpd3sC6RR6kU3o+umSclYiwAFJjQx7Xjq15U4MxefiLS1Djr47vdhCFNVBdDm681EvHLV2
        9LHRp321nEfc0At1HI7+MfdBtgXNmsm/1moxpg+fKNJ5d611MketQZUDh7REJa5w0gqQ4w
        dKZZC7r2yorXr78gYtl3LX5pyJEdQYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685446909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNkvyNSd6Gfbh+iwH/YENF6xAIahzjc7Hs/dYYi9deo=;
        b=PKIa1ZJciElQ0VLmcrPRG1c8/ltJcnLgwms06I1FJaHnSa8HnALE5RyxTd9A7RfB6gxikd
        Fk8Tdw/m+mlQD9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58A9213597;
        Tue, 30 May 2023 11:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JMMsFf3gdWT+AgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 11:41:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DA200A0754; Tue, 30 May 2023 13:41:48 +0200 (CEST)
Date:   Tue, 30 May 2023 13:41:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/13] block: refactor bd_may_claim
Message-ID: <20230530114148.zobtxdurit24pqev@quack3>
References: <20230518042323.663189-1-hch@lst.de>
 <20230518042323.663189-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518042323.663189-3-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-05-23 06:23:11, Christoph Hellwig wrote:
> The long if/else chain obsfucates the actual logic.  Tidy it up to be
> more structured.  Also drop the whole argument, as it can be trivially
> derived from bdev using bdev_whole, and having the bdev_whole in the
> function makes it easier to follow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Just one nit below but regardless of how you decided feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +static bool bd_may_claim(struct block_device *bdev, void *holder)
>  {
> -	if (bdev->bd_holder == holder)
> -		return true;	 /* already a holder */
> -	else if (bdev->bd_holder != NULL)
> -		return false; 	 /* held by someone else */
> -	else if (whole == bdev)
> -		return true;  	 /* is a whole device which isn't held */
> -
> -	else if (whole->bd_holder == bd_may_claim)
> -		return true; 	 /* is a partition of a device that is being partitioned */
> -	else if (whole->bd_holder != NULL)
> -		return false;	 /* is a partition of a held device */
> -	else
> -		return true;	 /* is a partition of an un-held device */
> +	struct block_device *whole = bdev_whole(bdev);
> +
> +	if (bdev->bd_holder) {
> +		/*
> +		 * The same holder can always re-claim.
> +		 */
> +		if (bdev->bd_holder == holder)
> +			return true;
> +		return false;

With this simple condition I'd just do:
		/* The same holder can always re-claim. */
		return bdev->bd_holder == holder;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
