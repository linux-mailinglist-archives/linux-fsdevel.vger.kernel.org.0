Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AEB4AC679
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiBGQxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 11:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385752AbiBGQoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:44:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAA0C0401D1;
        Mon,  7 Feb 2022 08:44:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39DAC210FC;
        Mon,  7 Feb 2022 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644252271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2qfQ85F6qBmLLZXRvS29YBDakkQ4Y2OXaCE1kHP8c0=;
        b=in42Be8MVnU/2nXcW8a29H9Gs4NZaTq+A4mpXFsiPWkVA0OJm6kP6Xr+SyoySeETwuaAm2
        I8Fbxk/UJzX1EQT7yYzaPG9zrk1qF15OWUy4FvT7ar4Tk5UwU0LDlVE3t5nqbFV+WDFHhd
        zCFp3pC+u0nYN3J483nZvF1diLeJ+Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644252271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2qfQ85F6qBmLLZXRvS29YBDakkQ4Y2OXaCE1kHP8c0=;
        b=D4v6q1rFPFSYP886Axaft6uRpB3Un4GnftS7UsyUxoEEDeNUtvSoVkRBb0JokZv3Mif/Oq
        ddOvUIZCFdmhn5CQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 29E3FA3B89;
        Mon,  7 Feb 2022 16:44:31 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 924EAA05BB; Mon,  7 Feb 2022 17:44:30 +0100 (CET)
Date:   Mon, 7 Feb 2022 17:44:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 8/9] ext4: Add strict range checks while freeing blocks
Message-ID: <20220207164430.pakzk7ycsmqovohh@quack3.lan>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <7d16dee931f42fa415ffe86fc3968b4b3d7269c8.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d16dee931f42fa415ffe86fc3968b4b3d7269c8.1644062450.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-02-22 19:39:57, Ritesh Harjani wrote:
> Currently ext4_mb_clear_bb() & ext4_group_add_blocks() only checks
> whether the given block ranges (which is to be freed) belongs to any FS
> metadata blocks or not, of the block's respective block group.
> But to detect any FS error early, it is better to add more strict
> checkings in those functions which checks whether the given blocks
> belongs to any critical FS metadata or not within system-zone.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 23313963bb56..9f2b3a057918 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5930,13 +5930,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  		goto error_return;
>  	}
>  
> -	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
> -	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
> -	    in_range(block, ext4_inode_table(sb, gdp),
> -		     sbi->s_itb_per_group) ||
> -	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
> -		     sbi->s_itb_per_group)) {
> -
> +	if (!ext4_inode_block_valid(inode, block, count)) {
>  		ext4_error(sb, "Freeing blocks in system zone - "
>  			   "Block = %llu, count = %lu", block, count);
>  		/* err = 0. ext4_std_error should be a no op */
> @@ -6007,7 +6001,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  						 NULL);
>  			if (err && err != -EOPNOTSUPP)
>  				ext4_msg(sb, KERN_WARNING, "discard request in"
> -					 " group:%d block:%d count:%lu failed"
> +					 " group:%u block:%d count:%lu failed"
>  					 " with %d", block_group, bit, count,
>  					 err);
>  		} else
> @@ -6220,11 +6214,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>  		goto error_return;
>  	}
>  
> -	if (in_range(ext4_block_bitmap(sb, desc), block, count) ||
> -	    in_range(ext4_inode_bitmap(sb, desc), block, count) ||
> -	    in_range(block, ext4_inode_table(sb, desc), sbi->s_itb_per_group) ||
> -	    in_range(block + count - 1, ext4_inode_table(sb, desc),
> -		     sbi->s_itb_per_group)) {
> +	if (!ext4_sb_block_valid(sb, NULL, block, count)) {
>  		ext4_error(sb, "Adding blocks in system zones - "
>  			   "Block = %llu, count = %lu",
>  			   block, count);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
