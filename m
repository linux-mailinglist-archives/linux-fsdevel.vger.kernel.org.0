Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EFE58439A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiG1PxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 11:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiG1PxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:53:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62CF2E9CC;
        Thu, 28 Jul 2022 08:53:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6DBD21F8D0;
        Thu, 28 Jul 2022 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659023584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRazPMMQgCNoZTT8t5E+ydoF4IaYw/yvSCZueBX2vlc=;
        b=Wp0uWZIheJ9zb1Rc4LorCsj+g6x3DWfXF5vbllhKRksxE/RZKcv/prLu3c8eCgj2KzSOGh
        DRX3yTcRuKsyr/ugUePcCfY09e3FzttIzI1xT0DQ82/jcCgv9nWcqrXt6Dosprh2NSK/+/
        cvKBnFYfDd+KB8ADt0jbNuOTYepdla0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659023584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRazPMMQgCNoZTT8t5E+ydoF4IaYw/yvSCZueBX2vlc=;
        b=ibID4RGaYu7op8jW6cl1Q6w8I7GyCAQsd3LQ0YZNYqB8+5ib2FB2fMgf+RyFAIwSLCjfgy
        f+5vePk+N98wmQDA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D82A2C141;
        Thu, 28 Jul 2022 15:53:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14FDCA0668; Thu, 28 Jul 2022 17:52:42 +0200 (CEST)
Date:   Thu, 28 Jul 2022 17:52:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: don't increase iversion counter for ea_inodes
Message-ID: <20220728155242.byfyjs3oswru7stt@quack3>
References: <20220728133914.49890-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728133914.49890-1-lczerner@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 28-07-22 15:39:13, Lukas Czerner wrote:
> ea_inodes are using i_version for storing part of the reference count so
> we really need to leave it alone.
> 
> The problem can be reproduced by xfstest ext4/026 when iversion is
> enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
> inodes in ext4_mark_iloc_dirty().
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..b76554124224 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5717,7 +5717,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	}
>  	ext4_fc_track_inode(handle, inode);
>  
> -	if (IS_I_VERSION(inode))
> +	/*
> +	 * ea_inodes are using i_version for storing reference count, don't
> +	 * mess with it
> +	 */
> +	if (IS_I_VERSION(inode) &&
> +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
>  		inode_inc_iversion(inode);
>  
>  	/* the do_update_inode consumes one bh->b_count */
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
