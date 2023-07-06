Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8C749E65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGFOBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjGFOBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:01:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA61BF4;
        Thu,  6 Jul 2023 07:01:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 735FC221B7;
        Thu,  6 Jul 2023 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688652065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1iDt/uWIycvAKaQeNchWQPkl5T17PL5WmqM9o48HqY=;
        b=oqgYnuJEJqxeXYFYxOQj5vWN/rcu6SEiEVHdQatAIyaqiVgP2s0JZqACnzBgAut9TpN9aV
        Vf63H2SYiD0z/U8z0R9cldTmP1rj4tyWzNMjj/IiHUXbsdE/rsw2CtgRu+1Nu5Oqayb5im
        TYcRLNI0O8rW+liUrk0MCuQtTlxvJyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688652065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1iDt/uWIycvAKaQeNchWQPkl5T17PL5WmqM9o48HqY=;
        b=NQWWPMByky0aT5I5xHKZFHa85oasW+JUQjcw4DxA9iCNOtpbRIiPcJGocBzJMjkUfSeMec
        4XUOAuTgwAhD41CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65B01138EE;
        Thu,  6 Jul 2023 14:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wIvOGCHJpmT1ZwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:01:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0943DA0707; Thu,  6 Jul 2023 16:01:05 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:01:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 70/92] qnx6: convert to ctime accessor functions
Message-ID: <20230706140105.m45gy2nrw2uahsoz@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-68-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-68-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:35, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/qnx6/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> index 85b2fa3b211c..21f90d519f1a 100644
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c
> @@ -562,8 +562,7 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
>  	inode->i_mtime.tv_nsec = 0;
>  	inode->i_atime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_atime);
>  	inode->i_atime.tv_nsec = 0;
> -	inode->i_ctime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_ctime);
> -	inode->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->di_ctime), 0);
>  
>  	/* calc blocks based on 512 byte blocksize */
>  	inode->i_blocks = (inode->i_size + 511) >> 9;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
