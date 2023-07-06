Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEE749E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGFNwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjGFNwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:52:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DF41996;
        Thu,  6 Jul 2023 06:52:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1653D1F747;
        Thu,  6 Jul 2023 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Sj9VUA4GJfNyaQsPPXQVWLzzQPtEFaq0FKlOFBweB8=;
        b=ZWtfyFn0+oBXKGWIRcbzdj6DoUjUSoJBJ5Ft2sp7vENnJvvK0G0bc84unCM3zlE4JXMgme
        ssHtSA5Pisty1GXx0tiNTm09FOqZf4qTo+XMo6MVd/p1vjdPRWp+YSJsGQPr88We8le9OQ
        PrYUOiu30IZnrioSRIaoQYh8G4Zar+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Sj9VUA4GJfNyaQsPPXQVWLzzQPtEFaq0FKlOFBweB8=;
        b=i4gRNiBpBFXTknJ4lqn7wmRext82M8OxhqGxnl9F/9Q0BhKcmnr8EcIscAWP7K0Ubbbg7O
        wr+3BdcZO+I+9WBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08934138EE;
        Thu,  6 Jul 2023 13:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbsZAiLHpmRuYwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:52:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8FCEAA0707; Thu,  6 Jul 2023 15:52:33 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:52:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 64/92] openpromfs: convert to ctime accessor functions
Message-ID: <20230706135233.mbqotvupjlpwpegi@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-62-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-62-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:29, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/openpromfs/inode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index f0b7f4d51a17..b2457cb97fa0 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -237,7 +237,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
>  	if (IS_ERR(inode))
>  		return ERR_CAST(inode);
>  	if (inode->i_state & I_NEW) {
> -		inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  		ent_oi = OP_I(inode);
>  		ent_oi->type = ent_type;
>  		ent_oi->u = ent_data;
> @@ -387,8 +387,7 @@ static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
>  		goto out_no_root;
>  	}
>  
> -	root_inode->i_mtime = root_inode->i_atime =
> -		root_inode->i_ctime = current_time(root_inode);
> +	root_inode->i_mtime = root_inode->i_atime = inode_set_ctime_current(root_inode);
>  	root_inode->i_op = &openprom_inode_operations;
>  	root_inode->i_fop = &openprom_operations;
>  	root_inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
