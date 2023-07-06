Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2574A022
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjGFO5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjGFO5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:57:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF671BFD;
        Thu,  6 Jul 2023 07:57:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D95081F88F;
        Thu,  6 Jul 2023 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJEM6bD3baXfKwVmrUUZvxYT3AKqRBG+HXOO4JRx2k0=;
        b=P6Fui+t4vyteVR038WrkFSmdUkghFdvgIPL13ylpec9zRRxuuIdZPsch9fWFrjaLfj6c1/
        gBTJXEe+iRDhXv/I3gZct5M/9bT9p9WJPtjPibW6hvnmzP3lZcUYxHgxm7sNHhXOiplhC1
        MHhnN8DKKOJAreIorTawfZI6C8xHle4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJEM6bD3baXfKwVmrUUZvxYT3AKqRBG+HXOO4JRx2k0=;
        b=EHsWZw93r7MnEk131Nf6ZZrIx0Ar3jCQjLdBqNT4Dj/cgWVA7OZgiOLowuFnasJWAXWOOI
        hlwMbfUTl9rlokCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7232138FC;
        Thu,  6 Jul 2023 14:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KVWQMEfWpmTDBQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:57:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 525C1A0707; Thu,  6 Jul 2023 16:57:11 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:57:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 89/92] apparmor: convert to ctime accessor functions
Message-ID: <20230706145711.qq6lpczp5zjv7lva@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-87-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-87-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:54, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  security/apparmor/apparmorfs.c    | 6 +++---
>  security/apparmor/policy_unpack.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 3d0d370d6ffd..7dbd0a5aaeeb 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -226,7 +226,7 @@ static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
>  
>  	inode->i_ino = get_next_ino();
>  	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	inode->i_private = data;
>  	if (S_ISDIR(mode)) {
>  		inode->i_op = iops ? iops : &simple_dir_inode_operations;
> @@ -1557,7 +1557,7 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
>  		if (new->dents[i]) {
>  			struct inode *inode = d_inode(new->dents[i]);
>  
> -			inode->i_mtime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode_set_ctime_current(inode);
>  		}
>  		old->dents[i] = NULL;
>  	}
> @@ -2546,7 +2546,7 @@ static int aa_mk_null_file(struct dentry *parent)
>  
>  	inode->i_ino = get_next_ino();
>  	inode->i_mode = S_IFCHR | S_IRUGO | S_IWUGO;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
>  			   MKDEV(MEM_MAJOR, 3));
>  	d_instantiate(dentry, inode);
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index ed180722a833..8b8846073e14 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -89,10 +89,10 @@ void __aa_loaddata_update(struct aa_loaddata *data, long revision)
>  		struct inode *inode;
>  
>  		inode = d_inode(data->dents[AAFS_LOADDATA_DIR]);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  
>  		inode = d_inode(data->dents[AAFS_LOADDATA_REVISION]);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  	}
>  }
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
