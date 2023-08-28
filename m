Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E081F78AF59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjH1Lz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjH1Lza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:55:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CA11A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 04:55:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 662C61F899;
        Mon, 28 Aug 2023 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693223726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OYjv8oiZxMP9Ccn2OpwRnQNoUW5xM4Uy4lEJ8tOqPw=;
        b=a8z0M0OgKEnDq0gC3BwKmji9M9DBDX5mZMaX0EiB59R0wSpNp83t+TYBDwR/RPQL7/EWu9
        Y889M1/DDEls0G1J7TFmKMHx5TAJ5XTfeSj0uvdPymRdjWpSComJxWJQ3lJPxQ0ydn+6io
        Rf8CPRcUskvChlAxS1Or6LF9VEeh5nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693223726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8OYjv8oiZxMP9Ccn2OpwRnQNoUW5xM4Uy4lEJ8tOqPw=;
        b=smFN8Dki0O8+chJ4mb6ZobfZG3b+OaAznSU/H4gPHzGnEP5YxMWTy46LeYdRLbJIKI0MPD
        bHHCyCQLFLoNQfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E0DF139CC;
        Mon, 28 Aug 2023 11:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LI3+Ei6L7GT3BQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 11:55:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CDC53A0774; Mon, 28 Aug 2023 13:55:25 +0200 (CEST)
Date:   Mon, 28 Aug 2023 13:55:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] super: move lockdep assert
Message-ID: <20230828115525.vxw7q2jrh54x6bd6@quack3>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
 <20230828-vfs-super-fixes-v1-1-b37a4a04a88f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-vfs-super-fixes-v1-1-b37a4a04a88f@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-08-23 13:26:23, Christian Brauner wrote:
> Fix braino and move the lockdep assertion after put_super() otherwise we
> risk a use-after-free.
> 
> Fixes: 2c18a63b760a ("super: wait until we passed kill super")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yeah, pretty obvious. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index ef87103e2a51..779247eb219c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -570,8 +570,8 @@ static bool grab_super_dead(struct super_block *sb)
>  		return true;
>  	}
>  	wait_var_event(&sb->s_flags, wait_dead(sb));
> -	put_super(sb);
>  	lockdep_assert_not_held(&sb->s_umount);
> +	put_super(sb);
>  	return false;
>  }
>  
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
