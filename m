Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59A595D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiHPNdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiHPNdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:33:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9593E77F;
        Tue, 16 Aug 2022 06:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15F71B819FD;
        Tue, 16 Aug 2022 13:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3064C433D6;
        Tue, 16 Aug 2022 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660656825;
        bh=K7rgA97bYm7qFa7naN/9mIfuUpUlqcqW7RXJWAgCJAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SN93oLQcJLuyo6N5dB4naekgOzQ2oFkKyJn9OV8jpEtZdJm6GEU/CmeTV7zBeLg+V
         YwgtGhcaCxMv9camLjjZ1Qnoet23spYh1Z2MFiWr1OEHaBUGmSPrjA7pPJl+8P4bFq
         sA/S3AzxrPg7dEJx8zjcJeKkZjMpn0xYLZuzqWQb30Y3JY6tgeqJyQ1q7PdDnuMAO/
         OrSyhCXXCQzpssQ56bFmPMuuJjZeNZ7QkoePpCTXMS5q731l0K+GPdEb6nw3hAlwpH
         v5s4aIqPNx3MQvkhhnJValCcluc9XOHm7ZuO80Pdyj6ORIz06DpzBHudVQC8ILrubZ
         6+wTLB1JNBNrA==
Date:   Tue, 16 Aug 2022 15:33:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: fix i_version handling in ext4
Message-ID: <20220816133340.mtaa7mxmgvhzffoh@wittgenstein>
References: <20220816131522.42467-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220816131522.42467-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:15:22AM -0400, Jeff Layton wrote:
> ext4 currently updates the i_version counter when the atime is updated
> during a read. This is less than ideal as it can cause unnecessary cache
> invalidations with NFSv4. The increment in ext4_mark_iloc_dirty is also
> problematic since it can also corrupt the i_version counter for
> ea_inodes.
> 
> We aren't bumping the file times in ext4_mark_iloc_dirty, so changing
> the i_version there seems wrong, and is the cause of both problems.
> Remove that callsite and add increments to the setattr and setxattr
> codepaths (at the same time that we update the ctime). The i_version
> bump that already happens during timestamp updates should take care of
> the rest.
> 
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Seems good to me. But it seems that the xfs patch you sent does have
inode_inc_version() right after setattr_copy() as well. So I wonder if
we couldn't just try and move inode_inc_version() into setattr_copy()
itself.

>  fs/ext4/inode.c | 10 +++++-----
>  fs/ext4/xattr.c |  2 ++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> I think this patch should probably supersede Lukas' patch entitled:
> 
>     ext4: don't increase iversion counter for ea_inodes
> 
> This will also mean that we'll need to respin the patch to turn on the
> i_version counter unconditionally in ext4 (though that should be
> trivial).
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 601214453c3a..a70921df89a5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5342,6 +5342,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	int error, rc = 0;
>  	int orphan = 0;
>  	const unsigned int ia_valid = attr->ia_valid;
> +	bool inc_ivers = IS_IVERSION(inode);
>  
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
> @@ -5425,8 +5426,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  			return -EINVAL;
>  		}
>  
> -		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
> -			inode_inc_iversion(inode);
> +		if (attr->ia_size == inode->i_size)
> +			inc_ivers = false;
>  
>  		if (shrink) {
>  			if (ext4_should_order_data(inode)) {
> @@ -5528,6 +5529,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	}
>  
>  	if (!error) {
> +		if (inc_ivers)
> +			inode_inc_iversion(inode);
>  		setattr_copy(mnt_userns, inode, attr);
>  		mark_inode_dirty(inode);
>  	}
> @@ -5731,9 +5734,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	}
>  	ext4_fc_track_inode(handle, inode);
>  
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> -
>  	/* the do_update_inode consumes one bh->b_count */
>  	get_bh(iloc->bh);
>  
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 533216e80fa2..4d84919d1c9c 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2412,6 +2412,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
>  	if (!error) {
>  		ext4_xattr_update_super_block(handle, inode->i_sb);
>  		inode->i_ctime = current_time(inode);
> +		if (IS_IVERSION(inode))
> +			inode_inc_iversion(inode);
>  		if (!value)
>  			no_expand = 0;
>  		error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
> -- 
> 2.37.2
> 
