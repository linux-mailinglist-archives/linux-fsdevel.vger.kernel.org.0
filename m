Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581E677797A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjHJNWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjHJNWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:22:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C92691;
        Thu, 10 Aug 2023 06:22:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4C9A21866;
        Thu, 10 Aug 2023 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691673719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Odcv0eOJAvYvLqQ3V9A0vveLhJ6HJBOtwnTBYXFgak=;
        b=xrQMKNxvThXckQEJJYKIi91J5WuBLaQjoxQfCIaYnTB8TvCKRpGOqaX37eI4Ly4sm0+Khk
        zAHktKylu0V4e1qaBJyHqHEZTVScE7aHVzpN4N3kjKo5pdeqWcdh9euohpGTQ6w8sRUETP
        tNzWxnNmYsvffsMdm9kQPxFQZAx4rkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691673719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Odcv0eOJAvYvLqQ3V9A0vveLhJ6HJBOtwnTBYXFgak=;
        b=W1xhEVJRC2hmvV6h/g2FqVLGwKKkEnc9n24+VNOC7p0wQ8Rhq54iBAxiVVJiDLMzn9rnrS
        tJcuHnaVuE637HDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8436139D1;
        Thu, 10 Aug 2023 13:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QdEJKXfk1GTLaAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 13:21:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F908A076F; Thu, 10 Aug 2023 15:21:59 +0200 (CEST)
Date:   Thu, 10 Aug 2023 15:21:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fat: remove i_version handling from fat_update_time
Message-ID: <20230810132159.zahg4mkc6yugcoul@quack3>
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
 <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-08-23 09:12:04, Jeff Layton wrote:
> commit 6bb885ecd746 (fat: add functions to update and truncate
> timestamps appropriately") added an update_time routine for fat. That
> patch added a section for handling the S_VERSION bit, even though FAT
> doesn't enable SB_I_VERSION and the S_VERSION bit will never be set when
> calling it.
> 
> Remove the section for handling S_VERSION since it's effectively dead
> code, and will be problematic vs. future changes.
> 
> Cc: Frank Sorenson <sorenson@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fat/misc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index ab28173348fa..37f4afb346af 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -354,9 +354,6 @@ int fat_update_time(struct inode *inode, int flags)
>  			dirty_flags |= I_DIRTY_SYNC;
>  	}
>  
> -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> -		dirty_flags |= I_DIRTY_SYNC;
> -
>  	__mark_inode_dirty(inode, dirty_flags);
>  	return 0;
>  }
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
