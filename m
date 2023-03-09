Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA66B2405
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 13:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCIMVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 07:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCIMU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:20:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70658EBD8A;
        Thu,  9 Mar 2023 04:20:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E59121C64;
        Thu,  9 Mar 2023 12:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678364453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKbZx6TtvvZrdoncoAg1xqx4lpdy7mH4dBdFHH9uKF8=;
        b=MJCIEsQCgeC27bjh86nsop45tDNMCwvbnosbVd4L2w/UZS+cF7wrGUFNgl+2eGgVOVX1RL
        AuSolJXOmUvDRBbYBfURYCKCIyeFwPJNIqU9m2OX+B+4vBMve5ZQOtgCmeRIg72RFZbEGu
        X7TOSWgZ9uhX3ysmFMvuftZFe9djpGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678364453;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKbZx6TtvvZrdoncoAg1xqx4lpdy7mH4dBdFHH9uKF8=;
        b=JX053uw/7Iliple9s043aOaN3nPTX3D2Itl4jgLKHzuP92RTn2ye+kUT6OQBMM39hd2JCM
        MMRJrv3wQOHrb5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10B5313A10;
        Thu,  9 Mar 2023 12:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nY4OBCXPCWSEbQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 12:20:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 38FF2A06FF; Thu,  9 Mar 2023 13:20:52 +0100 (CET)
Date:   Thu, 9 Mar 2023 13:20:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 07/11] ext4: Avoid scanning smaller extents in BG during CR1
Message-ID: <20230309122052.73k3tye5ev72elkt@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <6fefb97af05081d344185334a36e90f093ccf310.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fefb97af05081d344185334a36e90f093ccf310.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:34, Ojaswin Mujoo wrote:
> When we are inside ext4_mb_complex_scan_group() in CR1, we can be sure
> that this group has atleast 1 big enough continuous free extent to satisfy
> our request because (free / fragments) > goal length.
> 
> Hence, instead of wasting time looping over smaller free extents, only
> try to consider the free extent if we are sure that it has enough
> continuous free space to satisfy goal length. This is particularly
> useful when scanning highly fragmented BGs in CR1 as, without this
> patch, the allocator might stop scanning early before reaching the big
> enough free extent (due to ac_found > mb_max_to_scan) which causes us to
> uncessarily trim the request.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c4ab8f412d32..14529d2fe65f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2279,7 +2279,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>  	struct super_block *sb = ac->ac_sb;
>  	void *bitmap = e4b->bd_bitmap;
>  	struct ext4_free_extent ex;
> -	int i;
> +	int i, j, freelen;
>  	int free;
>  
>  	free = e4b->bd_info->bb_free;
> @@ -2306,6 +2306,23 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>  			break;
>  		}
>  
> +		if (ac->ac_criteria < CR2) {
> +			/*
> +			 * In CR1, we are sure that this group will
> +			 * have a large enough continuous free extent, so skip
> +			 * over the smaller free extents
> +			 */
> +			j = mb_find_next_bit(bitmap,
> +						EXT4_CLUSTERS_PER_GROUP(sb), i);
> +			freelen = j - i;
> +
> +			if (freelen < ac->ac_g_ex.fe_len) {
> +				i = j;
> +				free -= freelen;
> +				continue;
> +			}
> +		}
> +
>  		mb_find_extent(e4b, i, ac->ac_g_ex.fe_len, &ex);
>  		if (WARN_ON(ex.fe_len <= 0))
>  			break;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
