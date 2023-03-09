Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52ED6B2345
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCILm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjCILm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:42:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A002E3893;
        Thu,  9 Mar 2023 03:42:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6E8021ECC;
        Thu,  9 Mar 2023 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678362144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=javPwsDyuj6lcKC104MumxMR5I6nKFoW2gFXCThKCKY=;
        b=t35Eg/nE8nki3nPqb/CHxm3NgciZB70A1rykejK4As4gzzP2CiaV+cC5WqiWJ9M0it4vjM
        LNp9hPzIRHx0C/a1ICwj5vXJoPy/jpejTXALNHJsfGUz3pYtu7MH7o6KX6kYqTbBtCSGpw
        vrQr7b2nMM5oTLomsw03oBFcgFotyVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678362144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=javPwsDyuj6lcKC104MumxMR5I6nKFoW2gFXCThKCKY=;
        b=qTb8sYz/PVnxHOl5dibGcTyyJuhaQ2+wN3MZHr64yljpwa13wvJWolyizaV0BdYX85qOVD
        I4B3tsW9/rv8UmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D77011391B;
        Thu,  9 Mar 2023 11:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nCSRNCDGCWTYVwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Mar 2023 11:42:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5BB8FA06FF; Thu,  9 Mar 2023 12:42:24 +0100 (CET)
Date:   Thu, 9 Mar 2023 12:42:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 03/11] ext4: mballoc: Fix getting the right group desc in
 ext4_mb_prefetch_fini
Message-ID: <20230309114224.rj5grbon3g2wxzly@quack3>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 18:07:30, Ojaswin Mujoo wrote:
> group descriptor and group info are not of the same group in
> ext4_mb_prefetch_fini(). This problem was found during code
> review/walkthrough and seems like a bug, so fix it.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 572e79a698d4..8b22cc07b054 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2569,14 +2569,14 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
>  void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>  			   unsigned int nr)
>  {
> -	while (nr-- > 0) {
> -		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
> -								  NULL);
> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
> +	struct ext4_group_desc *gdp;
> +	struct ext4_group_info *grp;
>  
> +	while (nr-- > 0) {
>  		if (!group)
>  			group = ext4_get_groups_count(sb);
>  		group--;
> +		gdp = ext4_get_group_desc(sb, group, NULL);
>  		grp = ext4_get_group_info(sb, group);
>  
>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
