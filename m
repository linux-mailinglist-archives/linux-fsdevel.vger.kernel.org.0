Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2907C67AD83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjAYJLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjAYJLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:11:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E0244BDD;
        Wed, 25 Jan 2023 01:10:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05BFE1FED3;
        Wed, 25 Jan 2023 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674637853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4b+KqNSeXuL31zczv+cDYoPMPAAPzJdVbzeMH7l7Wcg=;
        b=rRrFyWUxlSJOlLvF/uYMDW1s53wazhxFP1EKx+gm8r2j3PgzvSOUeSAAlu6OuyW13/04UK
        1lsVBVMpVX1QAF/AYQ3i+sDaxO6hy/w4FcF13CLBwxIvccuqFFW2MiH/w05b2yd34hvL2Z
        i1+UDSbHDI8DCm6XrY9KQ6mlHblwPmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674637853;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4b+KqNSeXuL31zczv+cDYoPMPAAPzJdVbzeMH7l7Wcg=;
        b=nraMvOtVj94wX6K+a5ay9wrQZCA2F2APcsHZvwQtGtD8yu7qWQyj4WOLO8q/pyp3HFGsxO
        zwJe1NeqAGMITTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC7101339E;
        Wed, 25 Jan 2023 09:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7bOzORzy0GNyEQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:10:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7BCE7A06B5; Wed, 25 Jan 2023 10:10:52 +0100 (CET)
Date:   Wed, 25 Jan 2023 10:10:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: move sb_init_dio_done_wq out of direct-io.c
Message-ID: <20230125091052.fam755fliaq2tann@quack3>
References: <20230125065839.191256-1-hch@lst.de>
 <20230125065839.191256-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125065839.191256-2-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-01-23 07:58:38, Christoph Hellwig wrote:
> sb_init_dio_done_wq is also used by the iomap code, so move it to
> super.c in preparation for building direct-io.c conditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/direct-io.c | 24 ------------------------
>  fs/internal.h  |  4 +---
>  fs/super.c     | 24 ++++++++++++++++++++++++
>  3 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 03d381377ae10a..ab0d7ea89813a6 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -558,30 +558,6 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
>  	return ret;
>  }
>  
> -/*
> - * Create workqueue for deferred direct IO completions. We allocate the
> - * workqueue when it's first needed. This avoids creating workqueue for
> - * filesystems that don't need it and also allows us to create the workqueue
> - * late enough so the we can include s_id in the name of the workqueue.
> - */
> -int sb_init_dio_done_wq(struct super_block *sb)
> -{
> -	struct workqueue_struct *old;
> -	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> -						      WQ_MEM_RECLAIM, 0,
> -						      sb->s_id);
> -	if (!wq)
> -		return -ENOMEM;
> -	/*
> -	 * This has to be atomic as more DIOs can race to create the workqueue
> -	 */
> -	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
> -	/* Someone created workqueue before us? Free ours... */
> -	if (old)
> -		destroy_workqueue(wq);
> -	return 0;
> -}
> -
>  static int dio_set_defer_completion(struct dio *dio)
>  {
>  	struct super_block *sb = dio->inode->i_sb;
> diff --git a/fs/internal.h b/fs/internal.h
> index a803cc3cf716ab..cb0c0749661aae 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -120,6 +120,7 @@ extern bool trylock_super(struct super_block *sb);
>  struct super_block *user_get_super(dev_t, bool excl);
>  void put_super(struct super_block *sb);
>  extern bool mount_capable(struct fs_context *);
> +int sb_init_dio_done_wq(struct super_block *sb);
>  
>  /*
>   * open.c
> @@ -187,9 +188,6 @@ extern void mnt_pin_kill(struct mount *m);
>   */
>  extern const struct dentry_operations ns_dentry_operations;
>  
> -/* direct-io.c: */
> -int sb_init_dio_done_wq(struct super_block *sb);
> -
>  /*
>   * fs/stat.c:
>   */
> diff --git a/fs/super.c b/fs/super.c
> index 12c08cb20405d5..904adfbacdcf3c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1764,3 +1764,27 @@ int thaw_super(struct super_block *sb)
>  	return thaw_super_locked(sb);
>  }
>  EXPORT_SYMBOL(thaw_super);
> +
> +/*
> + * Create workqueue for deferred direct IO completions. We allocate the
> + * workqueue when it's first needed. This avoids creating workqueue for
> + * filesystems that don't need it and also allows us to create the workqueue
> + * late enough so the we can include s_id in the name of the workqueue.
> + */
> +int sb_init_dio_done_wq(struct super_block *sb)
> +{
> +	struct workqueue_struct *old;
> +	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> +						      WQ_MEM_RECLAIM, 0,
> +						      sb->s_id);
> +	if (!wq)
> +		return -ENOMEM;
> +	/*
> +	 * This has to be atomic as more DIOs can race to create the workqueue
> +	 */
> +	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
> +	/* Someone created workqueue before us? Free ours... */
> +	if (old)
> +		destroy_workqueue(wq);
> +	return 0;
> +}
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
