Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA14A5B43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiBALez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:34:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiBALey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:34:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D9B6221100;
        Tue,  1 Feb 2022 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643715293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbuHJy6CrGouy41rG/0CABF4plHh4zuZeKwTmZ0I87M=;
        b=jN3XkKHuR1+Dgaa0woCbskeD/BMUSPvAIfspTTI7lz8xXsxrL1rYj/S6aYhYdyK1Krgxd0
        foedoVB0rgzGIjHYzLbfXrWaJ/YBuDdIlHLMGKLUEddXvki8Bjpm3XD7M+uEdMSzNN1X+5
        4tlUc1bX1EWDEenV9f8knHmLuS2YY20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643715293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbuHJy6CrGouy41rG/0CABF4plHh4zuZeKwTmZ0I87M=;
        b=4z4TZZG2d+m1zkOx3yIEl2luWzPPMsfJns0B4Y+NapWd3+xFv4XDLD6IElTBWf/wnViBcn
        btjVRaqVGXlJoYBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4B8EA3B83;
        Tue,  1 Feb 2022 11:34:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39F37A05B1; Tue,  1 Feb 2022 12:34:53 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:34:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 2/6] ext4: Implement ext4_group_block_valid() as common
 function
Message-ID: <20220201113453.exaikdfsc3vubqel@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <40c85b86dd324a11c962843d8ef242780a84b25f.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c85b86dd324a11c962843d8ef242780a84b25f.1643642105.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 31-01-22 20:46:51, Ritesh Harjani wrote:
> This patch implements ext4_group_block_valid() check functionality,
> and refactors all the callers to use this common function instead.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
...

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8d23108cf9d7..60d32d3d8dc4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6001,13 +6001,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
> +	if (!ext4_group_block_valid(sb, block_group, block, count)) {
>  		ext4_error(sb, "Freeing blocks in system zone - "
>  			   "Block = %llu, count = %lu", block, count);
>  		/* err = 0. ext4_std_error should be a no op */

When doing this, why not rather directly use ext4_inode_block_valid() here?

> @@ -6194,11 +6188,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>  		goto error_return;
>  	}
>  
> -	if (in_range(ext4_block_bitmap(sb, desc), block, count) ||
> -	    in_range(ext4_inode_bitmap(sb, desc), block, count) ||
> -	    in_range(block, ext4_inode_table(sb, desc), sbi->s_itb_per_group) ||
> -	    in_range(block + count - 1, ext4_inode_table(sb, desc),
> -		     sbi->s_itb_per_group)) {
> +	if (!ext4_group_block_valid(sb, block_group, block, count)) {
>  		ext4_error(sb, "Adding blocks in system zones - "
>  			   "Block = %llu, count = %lu",
>  			   block, count);

And here I'd rather refactor ext4_inode_block_valid() a bit to provide a
more generic helper not requiring an inode and use it here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
