Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5A5FB7DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJKQCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJKQCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:02:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93743E7D
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 09:02:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A45F1F8B0;
        Tue, 11 Oct 2022 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665504158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glS0kcQph4RJblZZ5TyerDWbn/8s7SxJCxEvot79KfQ=;
        b=yTtS5R2oX5xrU5KhqphSzqxrlmQprAsatNAaqaMaPaxelODyndGCTUeULymT5xjMC759R2
        jX0xlbBMc1i/yI/eXVTmr08LHlkRHA8PHAoyTErktt3VU0xdNcOhG5AVp6A/zP0Fpz8uZz
        AYWmQVr5EWU/bVFPWYxSXA8LOwHGRQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665504158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glS0kcQph4RJblZZ5TyerDWbn/8s7SxJCxEvot79KfQ=;
        b=4A61mSl3o/A8Oy+Avd0aSi4VUM1hRiNYG+CylM+dZEmivjXWPJfZ/T+xyy1WeZ8F/tQaUx
        CQ+QBFRy+esuVpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0183813AAC;
        Tue, 11 Oct 2022 16:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fydgAJ6TRWOAZgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Oct 2022 16:02:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77877A06ED; Tue, 11 Oct 2022 18:02:37 +0200 (CEST)
Date:   Tue, 11 Oct 2022 18:02:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, shr@fb.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: clarify the rerurn value check for
 inode_needs_update_time
Message-ID: <20221011160237.rpjmcoxgmdxm4wpe@quack3>
References: <20221011020212.131100-1-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011020212.131100-1-joseph.qi@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-10-22 10:02:12, Joseph Qi wrote:
> inode_needs_update_time() can only returns >0 or 0, which means inode
> needs sync or not.
> So cleanup the callers return value check, and also cleanup redundant
> check in the function before return.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

OK, makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index b608528efd3a..d8f4ba98549a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2071,9 +2071,6 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
>  	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
>  		sync_it |= S_VERSION;
>  
> -	if (!sync_it)
> -		return 0;
> -
>  	return sync_it;
>  }
>  
> @@ -2113,7 +2110,7 @@ int file_update_time(struct file *file)
>  	struct timespec64 now = current_time(inode);
>  
>  	ret = inode_needs_update_time(inode, &now);
> -	if (ret <= 0)
> +	if (!ret)
>  		return ret;
>  
>  	return __file_update_time(file, &now, ret);
> @@ -2153,7 +2150,7 @@ static int file_modified_flags(struct file *file, int flags)
>  		return 0;
>  
>  	ret = inode_needs_update_time(inode, &now);
> -	if (ret <= 0)
> +	if (!ret)
>  		return ret;
>  	if (flags & IOCB_NOWAIT)
>  		return -EAGAIN;
> -- 
> 2.24.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
