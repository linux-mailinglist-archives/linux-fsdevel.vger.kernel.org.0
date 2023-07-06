Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CBA749E83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjGFOEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjGFOEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:04:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0281BF6;
        Thu,  6 Jul 2023 07:04:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35FFF221B7;
        Thu,  6 Jul 2023 14:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688652287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tQz1feiDEhtXdQ1+Xvk2RnXZbkr1bbUMrwQ0luZZaE=;
        b=f4bSqGyn9hQRjX61KLQg0MHwGXXLCBntTgSydnSsBFVU+KjHRJ+3cmnoWjxG4x51iQfyIU
        8fwNv+cOtPQEoxUv9OVWzWipm+l41oRbbDj6j6Aa3sg7DcadT2d18RkiOHm7M3okekCE8q
        reCCpxp5aYYaEDfCcNnuw0qlS8uedCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688652287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5tQz1feiDEhtXdQ1+Xvk2RnXZbkr1bbUMrwQ0luZZaE=;
        b=I0SAAOdjncOsXIeYyROotcdh3KBkEMhr+XAyy8QOpjd+nUto4od8SOHJRfLcDR/AZEK/+K
        MgBfXWamHqlOdFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28255138EE;
        Thu,  6 Jul 2023 14:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EpHKCf/JpmTPaQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:04:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C462EA0707; Thu,  6 Jul 2023 16:04:46 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:04:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 75/92] squashfs: convert to ctime accessor functions
Message-ID: <20230706140446.r5z63gqjfg64bido@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-73-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-73-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:40, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/squashfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
> index 24463145b351..c6e626b00546 100644
> --- a/fs/squashfs/inode.c
> +++ b/fs/squashfs/inode.c
> @@ -61,7 +61,7 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
>  	inode->i_ino = le32_to_cpu(sqsh_ino->inode_number);
>  	inode->i_mtime.tv_sec = le32_to_cpu(sqsh_ino->mtime);
>  	inode->i_atime.tv_sec = inode->i_mtime.tv_sec;
> -	inode->i_ctime.tv_sec = inode->i_mtime.tv_sec;
> +	inode_set_ctime(inode, inode->i_mtime.tv_sec, 0);
>  	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
>  	inode->i_size = 0;
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
