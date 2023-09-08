Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E77986E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbjIHML6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHML5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:11:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B42A1BC5;
        Fri,  8 Sep 2023 05:11:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F356C1FE20;
        Fri,  8 Sep 2023 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694175112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62nbVbwjJ1n6ISwwqNPZJtlzBj6XnR4DabkHQX2j/vk=;
        b=ck2HsG6Mob5USAy+Rg+0sTiOKENC1AzIIVYGpptnQk/DnvdQ0+40jlXn3lgsBkRWtJfxiz
        feaL25EP1SRHEbkHL497FV57oZGjjBfcJ+CVBCSfGgFFDQVNz2KJp5WfOadKX3OMrd7R+b
        TkRCogClTe9VglMi0dQShNlusxFZhSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694175112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62nbVbwjJ1n6ISwwqNPZJtlzBj6XnR4DabkHQX2j/vk=;
        b=0NO19Lwp++rB/+x6zMjOEAXlDRRaMtD2GtLyoooCa8J8PGAOjRagFMme1ARVRxAtng2e3R
        QF2NjPfenki4eqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0B59132F2;
        Fri,  8 Sep 2023 12:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PK7VNogP+2RuMQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 12:11:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8083DA0774; Fri,  8 Sep 2023 14:11:52 +0200 (CEST)
Date:   Fri, 8 Sep 2023 14:11:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] fs: don't update the atime if existing atime is
 newer than "now"
Message-ID: <20230908121152.fyjpv4zj4y2bcmqc@quack3>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
 <20230907-ctime-fixes-v1-2-3b74c970d934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907-ctime-fixes-v1-2-3b74c970d934@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-09-23 12:33:48, Jeff Layton wrote:
> It's possible for the atime to be updated with a fine-grained timestamp
> and then later get an update that uses a coarse-grained timestamp which
> makes the atime appear to go backward.
> 
> Fix this by only updating the atime if "now" is later than the current
> value.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 54237f4242ff..cf4726b7f4b5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1905,7 +1905,7 @@ int inode_update_timestamps(struct inode *inode, int flags)
>  	}
>  
>  	if (flags & S_ATIME) {
> -		if (!timespec64_equal(&now, &inode->i_atime)) {
> +		if (timespec64_compare(&inode->i_atime, &now) < 0) {
>  			inode->i_atime = now;
>  			updated |= S_ATIME;
>  		}
> @@ -1991,7 +1991,7 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
>  	if (!relatime_need_update(mnt, inode, now))
>  		return false;
>  
> -	if (timespec64_equal(&inode->i_atime, &now))
> +	if (timespec64_compare(&inode->i_atime, &now) >= 0)
>  		return false;
>  
>  	return true;
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
