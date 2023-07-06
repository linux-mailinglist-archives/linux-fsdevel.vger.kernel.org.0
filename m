Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77B749993
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGFKk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFKk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:40:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8DF19B2;
        Thu,  6 Jul 2023 03:40:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED57C2019E;
        Thu,  6 Jul 2023 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AtPqbv/I5XTvRHzRa1le0miyUrAIJk4DE9riJNaL0W4=;
        b=kYlD/4Y11bqPwRxjACIaXhrUB5JS5c0IcjFm+K1U2d7mhFQ4NJX58DF+IjRMGdkMwXlfnt
        kUWpbAZxfhsgQHbYqymse72ZrpUkQijkl8l6oOajA8mixabYyhpNIT5psP6n7kyWXboI/h
        I6QcHlTlrHZk5Ds1ia0uxdnyE1rh9ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AtPqbv/I5XTvRHzRa1le0miyUrAIJk4DE9riJNaL0W4=;
        b=FPZWntPHr5F/tAZlUZEaLRKY0UnmVO17+4grDsFTYxmL+8MptQVtk4TuevTPery7QdcufA
        u86dJcECBFjUuaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF1AC138FC;
        Thu,  6 Jul 2023 10:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CtJ1NhmapmTZewAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:40:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7DE80A0707; Thu,  6 Jul 2023 12:40:25 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:40:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev
Subject: Re: [PATCH v2 13/92] ntfs3: convert to simple_rename_timestamp
Message-ID: <20230706104025.gm66visyl3cer7vs@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-11-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-11-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:38, Jeff Layton wrote:
> A rename potentially involves updating 4 different inode timestamps.
> Convert to the new simple_rename_timestamp helper function.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ntfs3/namei.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 70f8c859e0ad..bfd986699f9e 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -324,14 +324,11 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
>  		/* Restore after failed rename failed too. */
>  		_ntfs_bad_inode(inode);
>  	} else if (!err) {
> -		inode->i_ctime = dir->i_ctime = dir->i_mtime =
> -			current_time(dir);
> +		simple_rename_timestamp(dir, dentry, new_dir, new_dentry);
>  		mark_inode_dirty(inode);
>  		mark_inode_dirty(dir);
> -		if (dir != new_dir) {
> -			new_dir->i_mtime = new_dir->i_ctime = dir->i_ctime;
> +		if (dir != new_dir)
>  			mark_inode_dirty(new_dir);
> -		}
>  
>  		if (IS_DIRSYNC(dir))
>  			ntfs_sync_inode(dir);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
