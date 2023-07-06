Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37394749E44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjGFNzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjGFNzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:55:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F851BE3;
        Thu,  6 Jul 2023 06:55:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5F022277F;
        Thu,  6 Jul 2023 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwvMPHSu7xNFjpf/tkeHJ2SIRv1M+NRRDyqHqUcYkIo=;
        b=b8SqHJVH9ALTskCt9O4rsNLoxpn3giYYrUMszctCcLJzKuGK9qE6uTm/tMYNWgjUAHjQhi
        x7VCChMaj+XVwZeae7io/NSGjoxG2PUDDTC8NAr0dKTW6Nit5G0/tBlBMyhBMaYBVorEdH
        R6Ft4HK5XXzEuj+9b6ZnGkRDv+EbHIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwvMPHSu7xNFjpf/tkeHJ2SIRv1M+NRRDyqHqUcYkIo=;
        b=513F7K7OruLAfUOTXjNW+VYK3b+OMtcbnip4h6ypWcVNegk2gI7J34PZjwGK72GjQ8lJWp
        71MH2jekxP2yh4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B66C7138EE;
        Thu,  6 Jul 2023 13:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rAOlLMbHpmTHZAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:55:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 54CC3A0707; Thu,  6 Jul 2023 15:55:18 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:55:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@lists.orangefs.org
Subject: Re: [PATCH v2 65/92] orangefs: convert to ctime accessor functions
Message-ID: <20230706135518.xjfzcvf224wfypeg@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-63-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-63-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
