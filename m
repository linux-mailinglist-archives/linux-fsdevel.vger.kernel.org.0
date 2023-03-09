Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184496B267C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjCIOP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjCIOOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:14:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD62D6C89D;
        Thu,  9 Mar 2023 06:14:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B4B021AC1;
        Thu,  9 Mar 2023 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678371263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MAeNio66Sy8fGsRbcBC3bQyJOx6KSakN7zbDA0MApCc=;
        b=ertoE+G5cL/4KfEKoleEMhltazLAN0+pV0lN3uWcC6Kp4knwMdBh6PBKuMAmNm8Hd5le1L
        Iyo6s9Yu04Tj3Uj6k8jzVQl9KoNsobFHZhICA7qIJkEzPJaiVQ+TIYd33JtAnvoTLQNJzs
        ua5xA0PzOv5mnZlreEDZLcOXrpdY4l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678371263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MAeNio66Sy8fGsRbcBC3bQyJOx6KSakN7zbDA0MApCc=;
        b=AnGTrCHyRD/ptUPCQXcgavl1jK3VdYazbBw7TdaHOw5UbGzz+j/psz5O0QTHht/YoUbGDC
        VXjkNKKmz3bMr1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D2741391B;
        Thu,  9 Mar 2023 14:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FDOzFr/pCWQpMQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 14:14:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D8E74A06FF; Thu,  9 Mar 2023 15:14:22 +0100 (CET)
Date:   Thu, 9 Mar 2023 15:14:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 08/11] ext4: Don't skip prefetching BLOCK_UNINIT groups
Message-ID: <20230309141422.b2nbl554ngna327k@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4881693a4f5ba1fed367310b27c793e4e78520d3.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:35, Ojaswin Mujoo wrote:
> Currently, ext4_mb_prefetch() and ext4_mb_prefetch_fini() skip
> BLOCK_UNINIT groups since fetching their bitmaps doesn't need disk IO.
> As a consequence, we end not initializing the buddy structures and CR0/1
> lists for these BGs, even though it can be done without any disk IO
> overhead. Hence, don't skip such BGs during prefetch and prefetch_fini.
> 
> This improves the accuracy of CR0/1 allocation as earlier, we could have
> essentially empty BLOCK_UNINIT groups being ignored by CR0/1 due to their buddy
> not being initialized, leading to slower CR2 allocations. With this patch CR0/1
> will be able to discover these groups as well, thus improving performance.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

The patch looks good. I just somewhat wonder - this change may result in
uninitialized groups being initialized and used earlier (previously we'd
rather search in other already initialized groups) which may spread
allocations more. But I suppose that's fine and uninit groups are not
really a feature meant to limit fragmentation and as the filesystem ages
the differences should be minimal. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 14529d2fe65f..48726a831264 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2557,9 +2557,7 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
>  		 */
>  		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
>  		    EXT4_MB_GRP_NEED_INIT(grp) &&
> -		    ext4_free_group_clusters(sb, gdp) > 0 &&
> -		    !(ext4_has_group_desc_csum(sb) &&
> -		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
> +		    ext4_free_group_clusters(sb, gdp) > 0 ) {
>  			bh = ext4_read_block_bitmap_nowait(sb, group, true);
>  			if (bh && !IS_ERR(bh)) {
>  				if (!buffer_uptodate(bh) && cnt)
> @@ -2600,9 +2598,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>  		grp = ext4_get_group_info(sb, group);
>  
>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> -		    ext4_free_group_clusters(sb, gdp) > 0 &&
> -		    !(ext4_has_group_desc_csum(sb) &&
> -		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
> +		    ext4_free_group_clusters(sb, gdp) > 0) {
>  			if (ext4_mb_init_group(sb, group, GFP_NOFS))
>  				break;
>  		}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
