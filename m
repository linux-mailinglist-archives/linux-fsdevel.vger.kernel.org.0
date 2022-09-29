Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524315EF5BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiI2MxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2MxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:53:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23051616E3;
        Thu, 29 Sep 2022 05:53:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86C5B219AF;
        Thu, 29 Sep 2022 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664455992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fogQYmZZ4SF+4I88Ka/wpuRIld5RErTgLKiCdZOnp5k=;
        b=c9F3vF6MFBCipNE+PXyAzF6JSFyKejP37pC1zWkTuQiwGL6RA129tk0PUkaSts1wk5XE4Z
        36phdZr+1/lgsywExDcRqWlAE88g0tl7/+ze8M4Tu5OZeBu+EJvObQlwblf3GEGsMoV9DB
        LTB5LG3O/2vw2BDT7Q/yKRcwPsdcplo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664455992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fogQYmZZ4SF+4I88Ka/wpuRIld5RErTgLKiCdZOnp5k=;
        b=mk2BV8NT84yKZuCvQnHOWY40Qr7nNQxtDghqiM6p1VU3FQYDSXJEZKNRRO6UdWe3GZWcjv
        MfxoO4esuRadLCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7835A13A71;
        Thu, 29 Sep 2022 12:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKtMHTiVNWOQFgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 12:53:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0445CA0681; Thu, 29 Sep 2022 14:53:11 +0200 (CEST)
Date:   Thu, 29 Sep 2022 14:53:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 8/8] ext4: Remove the logic to trim inode PAs
Message-ID: <20220929125311.bmkta7gp4a2hmcny@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <a26fdd12f4f60cf506a42b6a95e8014e5f380b05.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26fdd12f4f60cf506a42b6a95e8014e5f380b05.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:48, Ojaswin Mujoo wrote:
> Earlier, inode PAs were stored in a linked list. This caused a need to
> periodically trim the list down inorder to avoid growing it to a very
> large size, as this would severly affect performance during list
> iteration.
> 
> Recent patches changed this list to an rbtree, and since the tree scales
> up much better, we no longer need to have the trim functionality, hence
> remove it.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I'm kind of wondering: Now there won't be performance issues with much
more inode PAs but probably we don't want to let them grow completely out
of control? E.g. I can imagine that if we'd have 1 billion of inode PAs
attached to an inode, things would get wonky both in terms of memory
consumption and also in terms of CPU time spent for the cases where we
still do iterate all of the PAs... Is there anything which keeps inode PAs
reasonably bounded?

								Honza

> ---
>  Documentation/admin-guide/ext4.rst |  3 ---
>  fs/ext4/ext4.h                     |  1 -
>  fs/ext4/mballoc.c                  | 20 --------------------
>  fs/ext4/mballoc.h                  |  5 -----
>  fs/ext4/sysfs.c                    |  2 --
>  5 files changed, 31 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
> index 4c559e08d11e..5740d85439ff 100644
> --- a/Documentation/admin-guide/ext4.rst
> +++ b/Documentation/admin-guide/ext4.rst
> @@ -489,9 +489,6 @@ Files in /sys/fs/ext4/<devname>:
>          multiple of this tuning parameter if the stripe size is not set in the
>          ext4 superblock
>  
> -  mb_max_inode_prealloc
> -        The maximum length of per-inode ext4_prealloc_space list.
> -
>    mb_max_to_scan
>          The maximum number of extents the multiblock allocator will search to
>          find the best extent.
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index d54b972f1f0f..bca4b41cc192 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1612,7 +1612,6 @@ struct ext4_sb_info {
>  	unsigned int s_mb_stats;
>  	unsigned int s_mb_order2_reqs;
>  	unsigned int s_mb_group_prealloc;
> -	unsigned int s_mb_max_inode_prealloc;
>  	unsigned int s_max_dir_size_kb;
>  	/* where last allocation was done - for stream allocation */
>  	unsigned long s_mb_last_group;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index cd19b9e84767..57e1ec88477a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3420,7 +3420,6 @@ int ext4_mb_init(struct super_block *sb)
>  	sbi->s_mb_stats = MB_DEFAULT_STATS;
>  	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
>  	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
> -	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
>  	/*
>  	 * The default group preallocation is 512, which for 4k block
>  	 * sizes translates to 2 megabytes.  However for bigalloc file
> @@ -5546,29 +5545,11 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
>  	return ;
>  }
>  
> -/*
> - * if per-inode prealloc list is too long, trim some PA
> - */
> -static void ext4_mb_trim_inode_pa(struct inode *inode)
> -{
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> -	int count, delta;
> -
> -	count = atomic_read(&ei->i_prealloc_active);
> -	delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
> -	if (count > sbi->s_mb_max_inode_prealloc + delta) {
> -		count -= sbi->s_mb_max_inode_prealloc;
> -		ext4_discard_preallocations(inode, count);
> -	}
> -}
> -
>  /*
>   * release all resource we used in allocation
>   */
>  static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  {
> -	struct inode *inode = ac->ac_inode;
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_prealloc_space *pa = ac->ac_pa;
>  	if (pa) {
> @@ -5604,7 +5585,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
>  		mutex_unlock(&ac->ac_lg->lg_mutex);
>  	ext4_mb_collect_stats(ac);
> -	ext4_mb_trim_inode_pa(inode);
>  	return 0;
>  }
>  
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index f8e8ee493867..6d85ee8674a6 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -73,11 +73,6 @@
>   */
>  #define MB_DEFAULT_GROUP_PREALLOC	512
>  
> -/*
> - * maximum length of inode prealloc list
> - */
> -#define MB_DEFAULT_MAX_INODE_PREALLOC	512
> -
>  /*
>   * Number of groups to search linearly before performing group scanning
>   * optimization.
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index d233c24ea342..f0d42cf44c71 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -214,7 +214,6 @@ EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>  EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> -EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
>  EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> @@ -264,7 +263,6 @@ static struct attribute *ext4_attrs[] = {
>  	ATTR_LIST(mb_order2_req),
>  	ATTR_LIST(mb_stream_req),
>  	ATTR_LIST(mb_group_prealloc),
> -	ATTR_LIST(mb_max_inode_prealloc),
>  	ATTR_LIST(mb_max_linear_groups),
>  	ATTR_LIST(max_writeback_mb_bump),
>  	ATTR_LIST(extent_max_zeroout_kb),
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
