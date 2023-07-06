Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298D749E67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGFOBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjGFOBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:01:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388581727;
        Thu,  6 Jul 2023 07:01:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EED8421996;
        Thu,  6 Jul 2023 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688652090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CzdWAl5GUnv8I0kt9jYeTkcB/6n8HN8F761KyuKaKo=;
        b=urU8Ht8ZrWrZD8AVCDxIBk3g40w2HlqSnEjBuGk5RBZPv2VJvLx4N1ePcuK4DjAo2nKiRz
        pLRfAQ25nrpj5v2GjhsB3rCc+zhudkIy5egUJ078kHBtdYVOwSo/846vtOg0krwlyruOWj
        wtRlyfIozbIh7MuOMtCLh5uoNbvwc3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688652090;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6CzdWAl5GUnv8I0kt9jYeTkcB/6n8HN8F761KyuKaKo=;
        b=d/yWMrXIHyW66jE/y90oLtIXd4BHj1ddp3sZTyq55lvSiYVKCANeAz3QjLODGUDuOY60Ee
        yHvSYQzoAZLcE6DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B94138EE;
        Thu,  6 Jul 2023 14:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0lsdNzrJpmQ5aAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67169A0707; Thu,  6 Jul 2023 16:01:30 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:01:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 71/92] ramfs: convert to ctime accessor functions
Message-ID: <20230706140130.aaednyxybmatzcqu@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-69-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-69-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:36, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ramfs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index fef477c78107..18e8387cab41 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -65,7 +65,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
>  		inode->i_mapping->a_ops = &ram_aops;
>  		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  		mapping_set_unevictable(inode->i_mapping);
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  		switch (mode & S_IFMT) {
>  		default:
>  			init_special_inode(inode, mode, dev);
> @@ -105,7 +105,7 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  		d_instantiate(dentry, inode);
>  		dget(dentry);	/* Extra count - pin the dentry in core */
>  		error = 0;
> -		dir->i_mtime = dir->i_ctime = current_time(dir);
> +		dir->i_mtime = inode_set_ctime_current(dir);
>  	}
>  	return error;
>  }
> @@ -138,7 +138,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		if (!error) {
>  			d_instantiate(dentry, inode);
>  			dget(dentry);
> -			dir->i_mtime = dir->i_ctime = current_time(dir);
> +			dir->i_mtime = inode_set_ctime_current(dir);
>  		} else
>  			iput(inode);
>  	}
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
