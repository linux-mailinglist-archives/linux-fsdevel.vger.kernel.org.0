Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B1749E48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGFN4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjGFN4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:56:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407DA1BC9;
        Thu,  6 Jul 2023 06:56:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E550022789;
        Thu,  6 Jul 2023 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwvMPHSu7xNFjpf/tkeHJ2SIRv1M+NRRDyqHqUcYkIo=;
        b=SrPlnn8hoCWK28Iw5u0lS8EU4nUp8x4Xv8JO97SrSMK6nGaVC6dJy/9V8ObTwLFXscGwxW
        tUAC2MwOJguZmwL0zRGXv+HNVJXGns77N1Ig/YnI210ErooqOSZasrroda8dOE9mf0K3N+
        1tSyUZDBnIs/U9ViOmBAHTZhkcaTpbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwvMPHSu7xNFjpf/tkeHJ2SIRv1M+NRRDyqHqUcYkIo=;
        b=Pn3Sv6sYCtR+EqmiPs05bo7/Lf5Ury4XfdWSkeX/RA/XVLctpf3gU9BKN+679zJRACOQNG
        25IFR+kl8IZrhqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD84E138EE;
        Thu,  6 Jul 2023 13:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bxgrMhPIpmRfZQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:56:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 66EBBA0707; Thu,  6 Jul 2023 15:56:35 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:56:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@lists.orangefs.org
Subject: Re: [PATCH v2 65/92] orangefs: convert to ctime accessor functions
Message-ID: <20230706135635.jhz2dksvol5mfvp3@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-63-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-63-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:30, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/orangefs/namei.c          | 2 +-
>  fs/orangefs/orangefs-utils.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> index 77518e248cf7..c9dfd5c6a097 100644
> --- a/fs/orangefs/namei.c
> +++ b/fs/orangefs/namei.c
> @@ -421,7 +421,7 @@ static int orangefs_rename(struct mnt_idmap *idmap,
>  		     ret);
>  
>  	if (new_dentry->d_inode)
> -		new_dentry->d_inode->i_ctime = current_time(new_dentry->d_inode);
> +		inode_set_ctime_current(d_inode(new_dentry));
>  
>  	op_release(new_op);
>  	return ret;
> diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
> index 46b7dcff18ac..0a9fcfdf552f 100644
> --- a/fs/orangefs/orangefs-utils.c
> +++ b/fs/orangefs/orangefs-utils.c
> @@ -361,11 +361,11 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
>  	    downcall.resp.getattr.attributes.atime;
>  	inode->i_mtime.tv_sec = (time64_t)new_op->
>  	    downcall.resp.getattr.attributes.mtime;
> -	inode->i_ctime.tv_sec = (time64_t)new_op->
> -	    downcall.resp.getattr.attributes.ctime;
> +	inode_set_ctime(inode,
> +			(time64_t)new_op->downcall.resp.getattr.attributes.ctime,
> +			0);
>  	inode->i_atime.tv_nsec = 0;
>  	inode->i_mtime.tv_nsec = 0;
> -	inode->i_ctime.tv_nsec = 0;
>  
>  	/* special case: mark the root inode as sticky */
>  	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
