Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519C67BE247
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376702AbjJIOPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIOPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:15:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E39C;
        Mon,  9 Oct 2023 07:15:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C19E31F381;
        Mon,  9 Oct 2023 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696860931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+opQi/y9Q7aQSQHVP/FFlRFOzhPuja6QPtW3T5SYpU=;
        b=bZpWK5uNd27/Q8GgbSGRKKUmhphb9u0IN6kfZ3+4EevRVfH289yV9feBDffVkWSfdT4Rs1
        dx6ssqPWEpzk3/oaLZN6yYRT7N7fYnv+dkOCnVpVGVDDaPHJYBbyA4HKyutAcWxlji8OrF
        ihUGG+hrYmZPrIR72jracWc45ghLvZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696860931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+opQi/y9Q7aQSQHVP/FFlRFOzhPuja6QPtW3T5SYpU=;
        b=3OcJEvhZadqF1PddbAs/TLUIOmLxSGzlSWnr3wnHfJXWjFxX2rX5wBuDvRpNC0/1FWzcKw
        t0srULH3ivp4oODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B363D13905;
        Mon,  9 Oct 2023 14:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KxbAKwMLJGX3BwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 14:15:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3C9C3A04BB; Mon,  9 Oct 2023 16:15:31 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:15:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] reiserfs: centralize freeing of reiserfs info
Message-ID: <20231009141531.hyp7dfx2opkzcrrh@quack3>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
 <20231009-vfs-fixes-reiserfs-v1-2-723a2f1132ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-2-723a2f1132ce@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-10-23 14:33:39, Christian Brauner wrote:
> Currently the reiserfs info is free in multiple locations:
> 
> * in reiserfs_fill_super() if reiserfs_fill_super() fails
> * in reiserfs_put_super() when reiserfs is shut down and
>   reiserfs_fill_super() had succeeded
> 
> Stop duplicating this logic and always free reiserfs info in
> reiserfs_kill_sb().
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/super.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 7eaf36b3de12..6db8ed10a78d 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -549,7 +549,9 @@ int remove_save_link(struct inode *inode, int truncate)
>  
>  static void reiserfs_kill_sb(struct super_block *s)
>  {
> -	if (REISERFS_SB(s)) {
> +	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
> +
> +	if (sbi) {
>  		reiserfs_proc_info_done(s);
>  		/*
>  		 * Force any pending inode evictions to occur now. Any
> @@ -561,13 +563,16 @@ static void reiserfs_kill_sb(struct super_block *s)
>  		 */
>  		shrink_dcache_sb(s);
>  
> -		dput(REISERFS_SB(s)->xattr_root);
> -		REISERFS_SB(s)->xattr_root = NULL;
> -		dput(REISERFS_SB(s)->priv_root);
> -		REISERFS_SB(s)->priv_root = NULL;
> +		dput(sbi->xattr_root);
> +		sbi->xattr_root = NULL;
> +		dput(sbi->priv_root);
> +		sbi->priv_root = NULL;
>  	}
>  
>  	kill_block_super(s);
> +
> +	kfree(sbi);
> +	s->s_fs_info = NULL;
>  }
>  
>  #ifdef CONFIG_QUOTA
> @@ -630,8 +635,6 @@ static void reiserfs_put_super(struct super_block *s)
>  	mutex_destroy(&REISERFS_SB(s)->lock);
>  	destroy_workqueue(REISERFS_SB(s)->commit_wq);
>  	kfree(REISERFS_SB(s)->s_jdev);
> -	kfree(s->s_fs_info);
> -	s->s_fs_info = NULL;
>  }
>  
>  static struct kmem_cache *reiserfs_inode_cachep;
> @@ -2240,9 +2243,6 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
>  	}
>  #endif
>  	kfree(sbi->s_jdev);
> -	kfree(sbi);
> -
> -	s->s_fs_info = NULL;
>  	return errval;
>  }
>  
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
