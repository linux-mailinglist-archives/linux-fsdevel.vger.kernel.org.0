Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00524A5B0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiBALVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:21:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiBALVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:21:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D93601F383;
        Tue,  1 Feb 2022 11:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643714494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJ1ecYY+0bG7UTRC4zRt6cXe8+vQ1OBd1yjK4tkYXkY=;
        b=hVKY3gIAMbJZssMF9GJ3DlutU5WvnTYLvG9I/qEFT1zCSekGai+KttBO9Ud7qkzn/Iq49R
        Ki/flM4BClsZA/LnhSQqlL4e6yQeNOp+JGyqBnjRLuHm7Z9wUQ0VGnS6Es+/7rtPR/t6Qj
        jbFR190l9uGFKS7Hi1SKwr2N8Ot7q0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643714494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJ1ecYY+0bG7UTRC4zRt6cXe8+vQ1OBd1yjK4tkYXkY=;
        b=aFKEbA8jVMepswz8U9A738qtq0dS2mSXd9RJZArDu9mTFI/xGH5bzCmPaB/7gAU5Gex+VK
        iqgpvCxfwNvyo0DQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B82B6A3B81;
        Tue,  1 Feb 2022 11:21:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6D5ECA05B1; Tue,  1 Feb 2022 12:21:34 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:21:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 1/6] ext4: Fixes ext4_mb_mark_bb() with flex_bg with
 fast_commit
Message-ID: <20220201112134.aps3kd2ffv4trlhs@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <a9770b46522c03989bdd96f63f7d0bfb2cf499ab.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9770b46522c03989bdd96f63f7d0bfb2cf499ab.1643642105.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 31-01-22 20:46:50, Ritesh Harjani wrote:
> In case of flex_bg feature (which is by default enabled), extents for
> any given inode might span across blocks from two different block group.
> ext4_mb_mark_bb() only reads the buffer_head of block bitmap once for the
> starting block group, but it fails to read it again when the extent length
> boundary overflows to another block group. Then in this below loop it
> accesses memory beyond the block group bitmap buffer_head and results
> into a data abort.
> 
> 	for (i = 0; i < clen; i++)
> 		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
> 			already++;
> 
> This patch adds this functionality for checking block group boundary in
> ext4_mb_mark_bb() and update the buffer_head(bitmap_bh) for every different
> block group.
> 
> w/o this patch, I was easily able to hit a data access abort using Power platform.
> 
> <...>
> [   74.327662] EXT4-fs error (device loop3): ext4_mb_generate_buddy:1141: group 11, block bitmap and bg descriptor inconsistent: 21248 vs 23294 free clusters
> [   74.533214] EXT4-fs (loop3): shut down requested (2)
> [   74.536705] Aborting journal on device loop3-8.
> [   74.702705] BUG: Unable to handle kernel data access on read at 0xc00000005e980000
> [   74.703727] Faulting instruction address: 0xc0000000007bffb8
> cpu 0xd: Vector: 300 (Data Access) at [c000000015db7060]
>     pc: c0000000007bffb8: ext4_mb_mark_bb+0x198/0x5a0
>     lr: c0000000007bfeec: ext4_mb_mark_bb+0xcc/0x5a0
>     sp: c000000015db7300
>    msr: 800000000280b033
>    dar: c00000005e980000
>  dsisr: 40000000
>   current = 0xc000000027af6880
>   paca    = 0xc00000003ffd5200   irqmask: 0x03   irq_happened: 0x01
>     pid   = 5167, comm = mount
> <...>
> enter ? for help
> [c000000015db7380] c000000000782708 ext4_ext_clear_bb+0x378/0x410
> [c000000015db7400] c000000000813f14 ext4_fc_replay+0x1794/0x2000
> [c000000015db7580] c000000000833f7c do_one_pass+0xe9c/0x12a0
> [c000000015db7710] c000000000834504 jbd2_journal_recover+0x184/0x2d0
> [c000000015db77c0] c000000000841398 jbd2_journal_load+0x188/0x4a0
> [c000000015db7880] c000000000804de8 ext4_fill_super+0x2638/0x3e10
> [c000000015db7a40] c0000000005f8404 get_tree_bdev+0x2b4/0x350
> [c000000015db7ae0] c0000000007ef058 ext4_get_tree+0x28/0x40
> [c000000015db7b00] c0000000005f6344 vfs_get_tree+0x44/0x100
> [c000000015db7b70] c00000000063c408 path_mount+0xdd8/0xe70
> [c000000015db7c40] c00000000063c8f0 sys_mount+0x450/0x550
> [c000000015db7d50] c000000000035770 system_call_exception+0x4a0/0x4e0
> [c000000015db7e10] c00000000000c74c system_call_common+0xec/0x250
> --- Exception: c00 (System Call) at 00007ffff7dbfaa4
> 
> Fixes: 8016e29f4362e28 ("ext4: fast commit recovery path")
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c781974df9d0..8d23108cf9d7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3899,12 +3899,29 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int i, clen, err;
> +	int i, err;
>  	int already;
> +	unsigned int clen, overflow;
>  
> -	clen = EXT4_B2C(sbi, len);
> -
> +again:

And maybe structure this as a while loop? Like:

	while (len > 0) {
		...
	}

> +	overflow = 0;
>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> +
> +	/*
> +	 * Check to see if we are freeing blocks across a group
> +	 * boundary.
> +	 * In case of flex_bg, this can happen that (block, len) may span across
> +	 * more than one group. In that case we need to get the corresponding
> +	 * group metadata to work with. For this we have goto again loop.
> +	 */
> +	if (EXT4_C2B(sbi, blkoff) + len > EXT4_BLOCKS_PER_GROUP(sb)) {
> +		overflow = EXT4_C2B(sbi, blkoff) + len -
> +			EXT4_BLOCKS_PER_GROUP(sb);
> +		len -= overflow;

Why not just:

	thisgrp_len = min_t(int, len,
			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
	clen = EXT4_NUM_B2C(sbi, thisgrp_len);

It seems easier to understand to me.

								Honza

> +	}
> +
> +	clen = EXT4_NUM_B2C(sbi, len);
> +
>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
>  	if (IS_ERR(bitmap_bh)) {
>  		err = PTR_ERR(bitmap_bh);
> @@ -3960,6 +3977,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>  	sync_dirty_buffer(gdp_bh);
>  
> +	if (overflow && !err) {
> +		block += len;
> +		len = overflow;
> +		put_bh(bitmap_bh);
> +		goto again;
> +	}
> +
>  out_err:
>  	brelse(bitmap_bh);
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
