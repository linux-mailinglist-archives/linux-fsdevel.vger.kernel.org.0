Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E2749C62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGFMsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGFMsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:48:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7302113;
        Thu,  6 Jul 2023 05:47:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D415021C4E;
        Thu,  6 Jul 2023 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nO7HoBp+tBDfiO8NyqBxFWNIdjOzmscimrRAo3po1O4=;
        b=n+Y6nDQXpv79YjzQkvXGkus7Qt0TtPVGo9RQs3l5LAwKX3w7PXijWXmIMgNXw02cjZsaFT
        GgbCr43AP+f5+JT+x2ryzTU5q+HVv9q6ANT4/O/FYRCqXkrRBqaDfcnGuz33puZbFB1iQf
        ZsU/sn57IVTgLisPwiA0ACfhP8T4UO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nO7HoBp+tBDfiO8NyqBxFWNIdjOzmscimrRAo3po1O4=;
        b=UcI+C+HTa4GWg8vtBITaev7k5cEqqqBCrt69ZHj8vo/Q+7kD8Kf/vTXM+5vpQs3nRqNzmg
        VPShQWuf2S+N8BCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C566C138FC;
        Thu,  6 Jul 2023 12:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HrQnMOa3pmToQQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:47:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63516A0707; Thu,  6 Jul 2023 14:47:34 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:47:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 51/92] hpfs: convert to ctime accessor functions
Message-ID: <20230706124734.ew57trrtzkegqg6y@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-49-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-49-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:16, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

...

> diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
> index 69fb40b2c99a..36babb78b510 100644
> --- a/fs/hpfs/namei.c
> +++ b/fs/hpfs/namei.c
> @@ -13,10 +13,10 @@ static void hpfs_update_directory_times(struct inode *dir)
>  {
>  	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
>  	if (t == dir->i_mtime.tv_sec &&
> -	    t == dir->i_ctime.tv_sec)
> +	    t == inode_get_ctime(dir).tv_sec)
>  		return;
> -	dir->i_mtime.tv_sec = dir->i_ctime.tv_sec = t;
> -	dir->i_mtime.tv_nsec = dir->i_ctime.tv_nsec = 0;
> +	dir->i_mtime.tv_sec = inode_set_ctime(dir, t, 0).tv_sec;
> +	dir->i_mtime.tv_nsec = 0;

Easier to read:

	dir->i_mtime = inode_set_ctime(dir, t, 0);

> @@ -59,8 +59,9 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	result->i_ino = fno;
>  	hpfs_i(result)->i_parent_dir = dir->i_ino;
>  	hpfs_i(result)->i_dno = dno;
> -	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> -	result->i_ctime.tv_nsec = 0; 
> +	inode_set_ctime(result,
> +			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
> +			0);
>  	result->i_mtime.tv_nsec = 0; 
>  	result->i_atime.tv_nsec = 0; 

Here also:
	result->i_mtime = result->i_atime = inode_set_ctime(result,
		local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)), 0)

> @@ -167,8 +168,9 @@ static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	result->i_fop = &hpfs_file_ops;
>  	set_nlink(result, 1);
>  	hpfs_i(result)->i_parent_dir = dir->i_ino;
> -	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> -	result->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(result,
> +			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
> +			0);
>  	result->i_mtime.tv_nsec = 0;
>  	result->i_atime.tv_nsec = 0;

And here exactly the same.

> @@ -250,8 +252,9 @@ static int hpfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	hpfs_init_inode(result);
>  	result->i_ino = fno;
>  	hpfs_i(result)->i_parent_dir = dir->i_ino;
> -	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> -	result->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(result,
> +			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
> +			0);
>  	result->i_mtime.tv_nsec = 0;
>  	result->i_atime.tv_nsec = 0;
>  	hpfs_i(result)->i_ea_size = 0;
> @@ -326,8 +329,9 @@ static int hpfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	result->i_ino = fno;
>  	hpfs_init_inode(result);
>  	hpfs_i(result)->i_parent_dir = dir->i_ino;
> -	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
> -	result->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(result,
> +			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
> +			0);
>  	result->i_mtime.tv_nsec = 0;
>  	result->i_atime.tv_nsec = 0;
>  	hpfs_i(result)->i_ea_size = 0;

And in above two as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
