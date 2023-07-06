Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B09749A79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGFLTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGFLTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:19:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B911709;
        Thu,  6 Jul 2023 04:19:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECA7D21B73;
        Thu,  6 Jul 2023 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688642359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsfdjJzcVmUmbdUYICzms04Nh4quxK4Q2NAWzm+kkS8=;
        b=o2oZmklID6Q9VtspxlrERNHrGsJVZtFimQrMkS6qqEX/t7ic1+v74UtfjdX4MbeTo/i/Gs
        /51COCFZGWnvnP1tXEUtMuV7Uwb5Sq5WWebh12QQiKbiZIQXNgoiQFe0UVDZ1gopFVb/Ub
        rtmCRNfFvwHfGtA3ad6ftjo+zBBcRmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688642359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BsfdjJzcVmUmbdUYICzms04Nh4quxK4Q2NAWzm+kkS8=;
        b=B15iE44OMhqH2gYIdJjzaGa3KvNAR9a+6V26apUWMXqEM8+X3Oz7wCJOAQRwKqNKJnwZgr
        zfbF9roSGlolIFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB5C5138EE;
        Thu,  6 Jul 2023 11:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LuaINTejpmSVEgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 11:19:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 58DF6A0707; Thu,  6 Jul 2023 13:19:19 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:19:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 45/92] freevxfs: convert to ctime accessor functions
Message-ID: <20230706111919.qolfsbnvwiuxbwgo@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-43-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-43-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:10, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/freevxfs/vxfs_inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/freevxfs/vxfs_inode.c b/fs/freevxfs/vxfs_inode.c
> index ceb6a12649ba..ac5d43b164b5 100644
> --- a/fs/freevxfs/vxfs_inode.c
> +++ b/fs/freevxfs/vxfs_inode.c
> @@ -110,10 +110,9 @@ static inline void dip2vip_cpy(struct vxfs_sb_info *sbi,
>  	inode->i_size = vip->vii_size;
>  
>  	inode->i_atime.tv_sec = vip->vii_atime;
> -	inode->i_ctime.tv_sec = vip->vii_ctime;
> +	inode_set_ctime(inode, vip->vii_ctime, 0);
>  	inode->i_mtime.tv_sec = vip->vii_mtime;
>  	inode->i_atime.tv_nsec = 0;
> -	inode->i_ctime.tv_nsec = 0;
>  	inode->i_mtime.tv_nsec = 0;
>  
>  	inode->i_blocks = vip->vii_blocks;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
