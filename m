Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE35798603
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjIHKmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjIHKme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:42:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10B1BC6;
        Fri,  8 Sep 2023 03:42:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9BB111FD95;
        Fri,  8 Sep 2023 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694169749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUQKt/H3ZP7ajcYBxY10gBBVeTKZFcXnIqtiBFBJ8L8=;
        b=E2XPOzAd2/wOYuRyPXwWksDqPCtj539n3ttrPi6iyeICdPf1vGuUZa3luzUOgR62kdbBK2
        J2nmjukT1qV5D3EOXuWHPAKsdLSC1ru7cth8m1aftFMSPuP1VsIFv82yhBLmkb7tj+2yDI
        1YRhhA7ydKp3HRVGefMJfVuTvJJ4vn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694169749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUQKt/H3ZP7ajcYBxY10gBBVeTKZFcXnIqtiBFBJ8L8=;
        b=FoUYrRLeeDvFNKS70jwXnA7nGxBlsrV/U1fU8qL75SGW2EKBe2eDarsVDOftbChvHSR5X1
        USiYjLuV5gPwZBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D768131FD;
        Fri,  8 Sep 2023 10:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3Q6CIpX6+mSafQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 10:42:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 31D20A0774; Fri,  8 Sep 2023 12:42:29 +0200 (CEST)
Date:   Fri, 8 Sep 2023 12:42:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] fs: initialize inode->__i_ctime to the epoch
Message-ID: <20230908104229.5tsr2sn7oyfy53ih@quack3>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
 <20230907-ctime-fixes-v1-1-3b74c970d934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-ctime-fixes-v1-1-3b74c970d934@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-09-23 12:33:47, Jeff Layton wrote:
> With the advent of multigrain timestamps, we use inode_set_ctime_current
> to set the ctime, which can skip updating if the existing ctime appears
> to be in the future. Because we don't initialize this field at
> allocation time, that could prevent the ctime from being initialized
> properly when the inode is instantiated.
> 
> Always initialize the ctime field to the epoch so that the filesystem
> can set the timestamps properly later.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good but don't you need the same treatment to atime after your patch
2/2?

								Honza

> ---
>  fs/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 35fd688168c5..54237f4242ff 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -168,6 +168,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	inode->i_fop = &no_open_fops;
>  	inode->i_ino = 0;
>  	inode->__i_nlink = 1;
> +	inode->__i_ctime.tv_sec = 0;
> +	inode->__i_ctime.tv_nsec = 0;
>  	inode->i_opflags = 0;
>  	if (sb->s_xattr)
>  		inode->i_opflags |= IOP_XATTR;
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
