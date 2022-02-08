Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD44AD6EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356265AbiBHLah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 06:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355902AbiBHJ75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:59:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAFC03FEC0;
        Tue,  8 Feb 2022 01:59:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 55C4F1F383;
        Tue,  8 Feb 2022 09:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644314394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHyQ2O1KZBEX+zV3kl/9JXPa9d0AYN+NCxFdOlGBJS4=;
        b=EKB29ouv/C9jpJ5G0mnFrfuT5B4ZOzXlF7IhcCjDEzMuKovbISp2IPAIgczhtRpJSYetQl
        aKFJpINZMaQWcl3PIBXjRRROGpPW8uFcWx9wB3euchA1PzaDpBS+xbDfmtAsNUcqFPQDcZ
        ZXAGUcDWk7KTWx6hNO4fSka8g1/oqrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644314394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHyQ2O1KZBEX+zV3kl/9JXPa9d0AYN+NCxFdOlGBJS4=;
        b=OqGUQA90nxyyw3INZYkJxL/wG83EGgsd9wCOOkT1hJ5irgkSVT63IkYBUr6zur7ZlwbfjH
        O8yBI7k/10Iy4nBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3EA63A3B85;
        Tue,  8 Feb 2022 09:59:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EDD28A05C2; Tue,  8 Feb 2022 10:59:53 +0100 (CET)
Date:   Tue, 8 Feb 2022 10:59:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 2/9] ext4: Fixes ext4_mb_mark_bb() with flex_bg with
 fast_commit
Message-ID: <20220208095953.7araha5uw4itu5pr@quack3.lan>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <53596bdf7bd7aed66020db98d903b1653a1dbc7a.1644062450.git.riteshh@linux.ibm.com>
 <20220207163722.lxpgbmct2vqsadpm@quack3.lan>
 <20220208031107.pxb6qavtl4h5yqrl@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208031107.pxb6qavtl4h5yqrl@riteshh-domain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-02-22 08:41:07, Ritesh Harjani wrote:
> On 22/02/07 05:37PM, Jan Kara wrote:
> > On Sat 05-02-22 19:39:51, Ritesh Harjani wrote:
> > > In case of flex_bg feature (which is by default enabled), extents for
> > > any given inode might span across blocks from two different block group.
> > > ext4_mb_mark_bb() only reads the buffer_head of block bitmap once for the
> > > starting block group, but it fails to read it again when the extent length
> > > boundary overflows to another block group. Then in this below loop it
> > > accesses memory beyond the block group bitmap buffer_head and results
> > > into a data abort.
> > >
> > > 	for (i = 0; i < clen; i++)
> > > 		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
> > > 			already++;
> > >
> > > This patch adds this functionality for checking block group boundary in
> > > ext4_mb_mark_bb() and update the buffer_head(bitmap_bh) for every different
> > > block group.
> > >
> > > w/o this patch, I was easily able to hit a data access abort using Power platform.
> > >
> > > <...>
> > > [   74.327662] EXT4-fs error (device loop3): ext4_mb_generate_buddy:1141: group 11, block bitmap and bg descriptor inconsistent: 21248 vs 23294 free clusters
> > > [   74.533214] EXT4-fs (loop3): shut down requested (2)
> > > [   74.536705] Aborting journal on device loop3-8.
> > > [   74.702705] BUG: Unable to handle kernel data access on read at 0xc00000005e980000
> > > [   74.703727] Faulting instruction address: 0xc0000000007bffb8
> > > cpu 0xd: Vector: 300 (Data Access) at [c000000015db7060]
> > >     pc: c0000000007bffb8: ext4_mb_mark_bb+0x198/0x5a0
> > >     lr: c0000000007bfeec: ext4_mb_mark_bb+0xcc/0x5a0
> > >     sp: c000000015db7300
> > >    msr: 800000000280b033
> > >    dar: c00000005e980000
> > >  dsisr: 40000000
> > >   current = 0xc000000027af6880
> > >   paca    = 0xc00000003ffd5200   irqmask: 0x03   irq_happened: 0x01
> > >     pid   = 5167, comm = mount
> > > <...>
> > > enter ? for help
> > > [c000000015db7380] c000000000782708 ext4_ext_clear_bb+0x378/0x410
> > > [c000000015db7400] c000000000813f14 ext4_fc_replay+0x1794/0x2000
> > > [c000000015db7580] c000000000833f7c do_one_pass+0xe9c/0x12a0
> > > [c000000015db7710] c000000000834504 jbd2_journal_recover+0x184/0x2d0
> > > [c000000015db77c0] c000000000841398 jbd2_journal_load+0x188/0x4a0
> > > [c000000015db7880] c000000000804de8 ext4_fill_super+0x2638/0x3e10
> > > [c000000015db7a40] c0000000005f8404 get_tree_bdev+0x2b4/0x350
> > > [c000000015db7ae0] c0000000007ef058 ext4_get_tree+0x28/0x40
> > > [c000000015db7b00] c0000000005f6344 vfs_get_tree+0x44/0x100
> > > [c000000015db7b70] c00000000063c408 path_mount+0xdd8/0xe70
> > > [c000000015db7c40] c00000000063c8f0 sys_mount+0x450/0x550
> > > [c000000015db7d50] c000000000035770 system_call_exception+0x4a0/0x4e0
> > > [c000000015db7e10] c00000000000c74c system_call_common+0xec/0x250
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> >
> > Just two nits below. Otherwise feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > > ---
> > >  fs/ext4/mballoc.c | 131 +++++++++++++++++++++++++++-------------------
> > >  1 file changed, 76 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 2f117ce3bb73..d0bd51b1e1ad 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -3901,72 +3901,93 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> > >  	ext4_grpblk_t blkoff;
> > >  	int i, err;
> > >  	int already;
> > > -	unsigned int clen, clen_changed;
> > > +	unsigned int clen, clen_changed, thisgrp_len;
> > >
> > > -	clen = EXT4_NUM_B2C(sbi, len);
> > > -
> > > -	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> > > -	bitmap_bh = ext4_read_block_bitmap(sb, group);
> > > -	if (IS_ERR(bitmap_bh)) {
> > > -		err = PTR_ERR(bitmap_bh);
> > > -		bitmap_bh = NULL;
> > > -		goto out_err;
> > > -	}
> > > -
> > > -	err = -EIO;
> > > -	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> > > -	if (!gdp)
> > > -		goto out_err;
> > > +	while (len > 0) {
> > > +		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> > >
> > > -	ext4_lock_group(sb, group);
> > > -	already = 0;
> > > -	for (i = 0; i < clen; i++)
> > > -		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
> > > -			already++;
> > > -
> > > -	clen_changed = clen - already;
> > > -	if (state)
> > > -		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
> > > -	else
> > > -		mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
> > > -	if (ext4_has_group_desc_csum(sb) &&
> > > -	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> > > -		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> > > -		ext4_free_group_clusters_set(sb, gdp,
> > > -					     ext4_free_clusters_after_init(sb,
> > > -						group, gdp));
> > > -	}
> > > -	if (state)
> > > -		clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
> > > -	else
> > > -		clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
> > > +		/*
> > > +		 * Check to see if we are freeing blocks across a group
> > > +		 * boundary.
> > > +		 * In case of flex_bg, this can happen that (block, len) may
> > > +		 * span across more than one group. In that case we need to
> > > +		 * get the corresponding group metadata to work with.
> > > +		 * For this we have goto again loop.
> > > +		 */
> > > +		thisgrp_len = min_t(unsigned int, (unsigned int)len,
> > > +			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
> > > +		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
> > >
> > > -	ext4_free_group_clusters_set(sb, gdp, clen);
> > > -	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
> > > -	ext4_group_desc_csum_set(sb, group, gdp);
> > > +		bitmap_bh = ext4_read_block_bitmap(sb, group);
> > > +		if (IS_ERR(bitmap_bh)) {
> > > +			err = PTR_ERR(bitmap_bh);
> > > +			bitmap_bh = NULL;
> > > +			break;
> > > +		}
> > >
> > > -	ext4_unlock_group(sb, group);
> > > +		err = -EIO;
> > > +		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> > > +		if (!gdp)
> > > +			break;
> > >
> > > -	if (sbi->s_log_groups_per_flex) {
> > > -		ext4_group_t flex_group = ext4_flex_group(sbi, group);
> > > -		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> > > -					   s_flex_groups, flex_group);
> > > +		ext4_lock_group(sb, group);
> > > +		already = 0;
> > > +		for (i = 0; i < clen; i++)
> > > +			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> > > +					 !state)
> > > +				already++;
> > >
> > > +		clen_changed = clen - already;
> > >  		if (state)
> > > -			atomic64_sub(clen_changed, &fg->free_clusters);
> > > +			ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
> > >  		else
> > > -			atomic64_add(clen_changed, &fg->free_clusters);
> > > +			mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
> > > +		if (ext4_has_group_desc_csum(sb) &&
> > > +		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> > > +			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> > > +			ext4_free_group_clusters_set(sb, gdp,
> > > +			     ext4_free_clusters_after_init(sb, group, gdp));
> > > +		}
> > > +		if (state)
> > > +			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
> > > +		else
> > > +			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
> > > +
> > > +		ext4_free_group_clusters_set(sb, gdp, clen);
> > > +		ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
> > > +		ext4_group_desc_csum_set(sb, group, gdp);
> > > +
> > > +		ext4_unlock_group(sb, group);
> > > +
> > > +		if (sbi->s_log_groups_per_flex) {
> > > +			ext4_group_t flex_group = ext4_flex_group(sbi, group);
> > > +			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> > > +						   s_flex_groups, flex_group);
> > > +
> > > +			if (state)
> > > +				atomic64_sub(clen_changed, &fg->free_clusters);
> > > +			else
> > > +				atomic64_add(clen_changed, &fg->free_clusters);
> > > +
> > > +		}
> > > +
> > > +		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> > > +		if (err)
> > > +			break;
> > > +		sync_dirty_buffer(bitmap_bh);
> > > +		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> > > +		sync_dirty_buffer(gdp_bh);
> > > +		if (err)
> > > +			break;
> > > +
> > > +		block += thisgrp_len;
> > > +		len = len - thisgrp_len;
> > 		^^^ Maybe: len -= thisgrp_len;
> >
> > > +		put_bh(bitmap_bh);
> > 		^^ brelse() would be more usual here...
> 
> Sure, will make above two changes.
> 
> Btw, any general rules of when should we use put_bh() v/s brelse()?
> 
> Assumption about why I used put_bh() above was that in a non-error loop,
> where we are doing ext4_read_block_bitmap() (which will return bh with
> b_count elevated), I thought, we could simply do put_bh() in the end.
> 
> But when there is a possibility of an error occurred somewhere in
> between, then it's safe to do brelse().

The difference between put_bh() and brelse() are just the safety checks in
brelse(). So I generally use brelse() in higher level code and put_bh() in
lowlevel code where the overhead of additional checks could matter. But I
guess the opinions can differ :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
