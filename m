Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD44A5B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiBALrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:47:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52084 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbiBALrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:47:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F26081F3AC;
        Tue,  1 Feb 2022 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643716039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7iNcT51hZ1Z3NxjkQY5xHCeIRSxzR75ruYUzUbMRxg=;
        b=cpgdqNr9XjsW/lL0T47hms//3hNKTRprkg+XwRD6+ZAVL/l43UvDlIOZt+9LqrmuKoVhna
        F5q7SdFGq0g2rlLgEpX1tgPGuNeYKtx/sFsQVmhB8zp4Wj9vnHs3U9Hi3qNBYQ9Q4ELFwI
        By+2veHZ3YLCftTFb2u7zm9VV8Pd/qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643716039;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7iNcT51hZ1Z3NxjkQY5xHCeIRSxzR75ruYUzUbMRxg=;
        b=z3yEEocq/H1Ni33Uv4SMliROfzI+346W9JYtl7LOyx23F+vmaRwQGHYV3Fts+zv8etB1IT
        KiPfff6357jyFYBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4528A3B81;
        Tue,  1 Feb 2022 11:47:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9C38DA05B1; Tue,  1 Feb 2022 12:47:19 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:47:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 6/6] ext4: Add extra check in ext4_mb_mark_bb() to prevent
 against possible corruption
Message-ID: <20220201114719.dzyeitz26kpde5zf@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <fa6d3adad7e1a4691c4c38b6b670d9330757ce82.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6d3adad7e1a4691c4c38b6b670d9330757ce82.1643642105.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 31-01-22 20:46:55, Ritesh Harjani wrote:
> This patch adds an extra checks in ext4_mb_mark_bb() function
> to make sure we mark & report error if we were to mark/clear any
> of the critical FS metadata specific bitmaps (&bail out) to prevent
> from any accidental corruption.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Again please rather use ext4_inode_block_valid() here. All the callers of
ext4_mb_mark_bb() have the information available.

								Honza

> ---
>  fs/ext4/mballoc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5f20e355d08c..c94888534caa 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3920,6 +3920,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  		len -= overflow;
>  	}
>  
> +	if (!ext4_group_block_valid(sb, group, block, len)) {
> +		ext4_error(sb, "Marking blocks in system zone - "
> +			   "Block = %llu, len = %d", block, len);
> +		bitmap_bh = NULL;
> +		goto out_err;
> +	}
> +
>  	clen = EXT4_NUM_B2C(sbi, len);
>  
>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
