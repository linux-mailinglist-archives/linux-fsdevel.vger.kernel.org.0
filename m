Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C313977797F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjHJNW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHJNWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:22:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3226BA;
        Thu, 10 Aug 2023 06:22:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87C491F45B;
        Thu, 10 Aug 2023 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691673743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ip4/n/Ixm1Bk8FuN4QHn1uJbC9drYLK9GfOJr4AAEtM=;
        b=BxZn5CuV7wSpq0tyhpXX46wxkC2eNhpvXtx+4SQAFpJ9pyye7By5GEEIEfZKNGGEQE6JsB
        7eWPID76Yfe8zcKuuGvCFoi6OQXj+UFFnF5q3oQPQcN7OTcyHYBi8RHG5YL/n4BTpIko7U
        Tmo3/RhJ+l6WQoLcKvmo7+XmOISCrfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691673743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ip4/n/Ixm1Bk8FuN4QHn1uJbC9drYLK9GfOJr4AAEtM=;
        b=hZgJnbzJyp/A1AEZ80ZKTjDXrhIyKheFLlnGkTPjjeBvRLc/clNMuNeIEKUlwbW17I76ym
        sGmnBRPav34yKgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76CA6138E2;
        Thu, 10 Aug 2023 13:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9LoYHY/k1GQLaQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 13:22:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E5E1BA076F; Thu, 10 Aug 2023 15:22:22 +0200 (CEST)
Date:   Thu, 10 Aug 2023 15:22:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fat: make fat_update_time get its own timestamp
Message-ID: <20230810132222.vzz5mqu3r64tz4yr@quack3>
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
 <20230810-ctime-fat-v1-2-327598fd1de8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-ctime-fat-v1-2-327598fd1de8@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-08-23 09:12:05, Jeff Layton wrote:
> In later patches, we're going to drop the "now" parameter from the
> update_time operation. Fix fat_update_time to fetch its own timestamp.
> It turns out that this is easily done by just passing a NULL timestamp
> pointer to fat_truncate_time.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fat/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 37f4afb346af..f2304a1054aa 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -347,7 +347,7 @@ int fat_update_time(struct inode *inode, int flags)
>  		return 0;
>  
>  	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> -		fat_truncate_time(inode, now, flags);
> +		fat_truncate_time(inode, NULL, flags);
>  		if (inode->i_sb->s_flags & SB_LAZYTIME)
>  			dirty_flags |= I_DIRTY_TIME;
>  		else
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
