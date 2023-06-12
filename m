Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223A72C2E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFLLfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjFLLez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:34:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31059F2;
        Mon, 12 Jun 2023 04:12:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95A332019C;
        Mon, 12 Jun 2023 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686568357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FdsuIfypP9+C5sC1xRWXW+hoUXrt1zPPIKzJNicbjU=;
        b=Jh2+alp0rMOXOSFRhdlzqjNndlscgFLnVup8y9P/Xre5t5PJDiRxcldkPps0xbNgHzpIY2
        goX9fJNwMNk6nRMp0AkidL0AoFPUd21OBW/nVc22bnr7WIvpuKjTGYN76WzD68le4Vg0TB
        iUIkKsWl18RI55gNjmM4UgXgfblMpuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686568357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FdsuIfypP9+C5sC1xRWXW+hoUXrt1zPPIKzJNicbjU=;
        b=i/TIBvFl//V94x+p2kdgS6tp/dlGXUq0v+MYMVJyGr7uzgDfkV0H37HM438hf7JKz4DAHw
        +ApHtTtuvKjiX2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83EDA138EC;
        Mon, 12 Jun 2023 11:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TvQyIKX9hmQHQAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 11:12:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0585EA0717; Mon, 12 Jun 2023 13:12:37 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:12:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 3/3] fs: Drop wait_unfrozen wait queue
Message-ID: <20230612111236.ycnvi2gll2ihozt3@quack3>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653973399.755178.13985159536040832418.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168653973399.755178.13985159536040832418.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 11-06-23 20:15:34, Darrick J. Wong wrote:
> From: Jan Kara <jack@suse.cz>
> 
> wait_unfrozen waitqueue is used only in quota code to wait for
> filesystem to become unfrozen. In that place we can just use
> sb_start_write() - sb_end_write() pair to achieve the same. So just
> remove the waitqueue.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

I have this already queued in my tree for the merge window... :)

								Honza

> ---
>  fs/quota/quota.c   |    5 +++--
>  fs/super.c         |    4 ----
>  include/linux/fs.h |    1 -
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 052f143e2e0e..0e41fb84060f 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -895,8 +895,9 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  			up_write(&sb->s_umount);
>  		else
>  			up_read(&sb->s_umount);
> -		wait_event(sb->s_writers.wait_unfrozen,
> -			   sb->s_writers.frozen == SB_UNFROZEN);
> +		/* Wait for sb to unfreeze */
> +		sb_start_write(sb);
> +		sb_end_write(sb);
>  		put_super(sb);
>  		goto retry;
>  	}
> diff --git a/fs/super.c b/fs/super.c
> index 151e0eeff2c2..fd04dda6c5c0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -236,7 +236,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  					&type->s_writers_key[i]))
>  			goto fail;
>  	}
> -	init_waitqueue_head(&s->s_writers.wait_unfrozen);
>  	s->s_bdi = &noop_backing_dev_info;
>  	s->s_flags = flags;
>  	if (s->s_user_ns != &init_user_ns)
> @@ -1753,7 +1752,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  	if (ret) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
>  		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
> -		wake_up(&sb->s_writers.wait_unfrozen);
>  		wake_up_var(&sb->s_writers.frozen);
>  		deactivate_locked_super(sb);
>  		return ret;
> @@ -1770,7 +1768,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
>  				"VFS:Filesystem freeze failed\n");
>  			sb->s_writers.frozen = SB_UNFROZEN;
>  			sb_freeze_unlock(sb, SB_FREEZE_FS);
> -			wake_up(&sb->s_writers.wait_unfrozen);
>  			wake_up_var(&sb->s_writers.frozen);
>  			deactivate_locked_super(sb);
>  			return ret;
> @@ -1853,7 +1850,6 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
>  	wake_up_var(&sb->s_writers.frozen);
>  	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
> -	wake_up(&sb->s_writers.wait_unfrozen);
>  	deactivate_locked_super(sb);
>  	return 0;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c58a560569b3..5870fbbecb81 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1147,7 +1147,6 @@ enum {
>  struct sb_writers {
>  	unsigned short			frozen;		/* Is sb frozen? */
>  	unsigned short			freeze_holders;	/* Who froze fs? */
> -	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
>  	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
>  };
>  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
