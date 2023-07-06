Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7D7499FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjGFKzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjGFKzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:55:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84376212D;
        Thu,  6 Jul 2023 03:54:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BB7720535;
        Thu,  6 Jul 2023 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRN3hCijOOkQXaBGoxP+fei8gl0a0X8LOKYqS6sTjSg=;
        b=ClMOYx/MLZSr2uMqUZVBuskfjL//VlImIy44TrudSoCor4uMz8hH8Id6B5yQncTb6eAAI9
        D2vTCuK5u40idJyXyp1nZd/GZGz5Cu0anadmKCsAE45BVD6dG4bZRots+BdkC80mowC2WS
        UdrDk4T0Xaw9OTf6bBdiU8luCSGkbEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRN3hCijOOkQXaBGoxP+fei8gl0a0X8LOKYqS6sTjSg=;
        b=8zJI2iKEN2Inh2dswV7ZlYXx2ncvTFbxm8R7IyZoFZxtswr3i8HtJ+ahGv1R354FfvmyI1
        pNdFCL6Z3Yq+hJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EBA2138EE;
        Thu,  6 Jul 2023 10:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N9F3B3edpmTtBAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:54:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A9769A0707; Thu,  6 Jul 2023 12:54:46 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:54:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 32/92] configfs: convert to ctime accessor functions
Message-ID: <20230706105446.r32oft4i3cj5bk3y@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-30-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-30-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:57, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/inode.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index 1c15edbe70ff..fbdcb3582926 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -88,8 +88,7 @@ int configfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  static inline void set_default_inode_attr(struct inode * inode, umode_t mode)
>  {
>  	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime =
> -		inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  }
>  
>  static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
> @@ -99,7 +98,7 @@ static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
>  	inode->i_gid = iattr->ia_gid;
>  	inode->i_atime = iattr->ia_atime;
>  	inode->i_mtime = iattr->ia_mtime;
> -	inode->i_ctime = iattr->ia_ctime;
> +	inode_set_ctime_to_ts(inode, iattr->ia_ctime);
>  }
>  
>  struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
> @@ -172,7 +171,7 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
>  		return ERR_PTR(-ENOMEM);
>  
>  	p_inode = d_inode(dentry->d_parent);
> -	p_inode->i_mtime = p_inode->i_ctime = current_time(p_inode);
> +	p_inode->i_mtime = inode_set_ctime_current(p_inode);
>  	configfs_set_inode_lock_class(sd, inode);
>  	return inode;
>  }
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
