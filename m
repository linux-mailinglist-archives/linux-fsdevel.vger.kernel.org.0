Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3EB4D7D50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 09:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiCNIJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 04:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiCNIHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:07:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88741F99;
        Mon, 14 Mar 2022 01:05:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87454218FE;
        Mon, 14 Mar 2022 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647245140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OzrrCIOc03LWU33BuZwOlRtUjqpB/1gQj5SnYfBFyBI=;
        b=vz8xCLs3GA+SbXd8C5WMv2WikqAOLN10T7cX48Z3b/L/Zmbsmrc5NIq9a7rgnMBforI+W4
        qT5LpKbZfVyQ/aXghPuCj8PyytIuL2CnEz5PQP0fddec0o3BpIEDr+JZPxFcCDfZZQT67d
        XcdIAEuo2D8xyI7PScdhVaLP1wR+bx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647245140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OzrrCIOc03LWU33BuZwOlRtUjqpB/1gQj5SnYfBFyBI=;
        b=4gl7/H4/gzhDT42W7eUjbVQYhf+uegiC4EgmKzLlmxGmJUMyCZHdCJhpOky+doOhti0L6P
        gOx8yDmtRl/nl1Bw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7760DA3B9A;
        Mon, 14 Mar 2022 08:05:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C635A0615; Mon, 14 Mar 2022 09:05:40 +0100 (CET)
Date:   Mon, 14 Mar 2022 09:05:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bang Li <libang.linuxer@gmail.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: remove redundant parameter judgment
Message-ID: <20220314080540.ovk66yvuyzfbi4zt@quack3.lan>
References: <20220311151240.62045-1-libang.linuxer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311151240.62045-1-libang.linuxer@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-03-22 23:12:40, Bang Li wrote:
> iput() has already judged the incoming parameter, so there is no need to
> repeat the judgment here.
> 
> Signed-off-by: Bang Li <libang.linuxer@gmail.com>

Thanks. I've applied the patch to my tree.

								Honza

> ---
>  fs/notify/fsnotify.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 494f653efbc6..70a8516b78bc 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -70,8 +70,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  		spin_unlock(&inode->i_lock);
>  		spin_unlock(&sb->s_inode_list_lock);
>  
> -		if (iput_inode)
> -			iput(iput_inode);
> +		iput(iput_inode);
>  
>  		/* for each watch, send FS_UNMOUNT and then remove it */
>  		fsnotify_inode(inode, FS_UNMOUNT);
> @@ -85,8 +84,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
>  
> -	if (iput_inode)
> -		iput(iput_inode);
> +	iput(iput_inode);
>  }
>  
>  void fsnotify_sb_delete(struct super_block *sb)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
