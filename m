Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D765E5EF43C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiI2LZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiI2LY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:24:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4212EDB1;
        Thu, 29 Sep 2022 04:24:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FBD921AC4;
        Thu, 29 Sep 2022 11:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664450695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6O4FPnXSlhjPq+S068RqZ2q0RwWz5vWZUIecrgaOBnk=;
        b=oGFezCy3MFwxgCctvsgzqD9ZEPfsorkpC+wmGy3FrJLYgIlzRBcASTAnvNNdMpfN3ZRXKA
        1bcd83PsfrQz9b1K7d1e5F9CkLpJetS2TyH25is7b61It6CN0ggFlRqyvQSvcHVaffWYxO
        sa5SgUCdipZBHeh5iGf4HJmxmo7U5FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664450695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6O4FPnXSlhjPq+S068RqZ2q0RwWz5vWZUIecrgaOBnk=;
        b=U9k5yAA0xsbygtnTyyi2TTkEMojGuGrwMPKqbPcFBuQYtHC49PzJQ9XKbev8AKfWjQ0xhy
        ujaONt/OcKzzRwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E6CD1348E;
        Thu, 29 Sep 2022 11:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WZzpGoeANWNcbQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 11:24:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 02DCEA0681; Thu, 29 Sep 2022 13:24:54 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:24:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 1/8] ext4: Stop searching if PA doesn't satisfy
 non-extent file
Message-ID: <20220929112454.ribbghdrz3qvyy2b@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <113e30014fdcf409680e20ec1ef4455ace33884d.1664269665.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113e30014fdcf409680e20ec1ef4455ace33884d.1664269665.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-09-22 14:46:41, Ojaswin Mujoo wrote:
> If we come across a PA that matches the logical offset but is unable to
> satisfy a non-extent file due to its physical start being higher than
> that supported by non extent files, then simply stop searching for
> another PA and break out of loop. This is because, since PAs don't
> overlap, we won't be able to find another inode PA which can satisfy the
> original request.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 71f5b67d7f28..2e3eb632a216 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4383,8 +4383,13 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		/* non-extent files can't have physical blocks past 2^32 */
>  		if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)) &&
>  		    (pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) >
> -		     EXT4_MAX_BLOCK_FILE_PHYS))
> -			continue;
> +		     EXT4_MAX_BLOCK_FILE_PHYS)) {
> +			/*
> +			 * Since PAs don't overlap, we won't find any
> +			 * other PA to satisfy this.
> +			 */
> +			break;
> +		}
>  
>  		/* found preallocated blocks, use them */
>  		spin_lock(&pa->pa_lock);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
