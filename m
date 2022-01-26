Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF449C7BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 11:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiAZKnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 05:43:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiAZKnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:43:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A4CA3212BC;
        Wed, 26 Jan 2022 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643193830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMRml9+dnqoEBhzzW820t4W8tAM3CWF8L3CsjTUU3As=;
        b=U3oN+cn76LPVHdmzOmy7wqyWn5OclTvHUL7KnKkZBqszwGS8by23ffGRfDuuBKMdpX2HHS
        yYNghoDf1Q/A4uEaCThhmGY/d27cPOvvLyc7VAE5ZOGKYBRICIHa3kMCvcHBc9W+rlYGbY
        2sPNRhlebL+opaQKp3P86qmLGcGKHt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643193830;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMRml9+dnqoEBhzzW820t4W8tAM3CWF8L3CsjTUU3As=;
        b=JQkPbcY46RJN7aps4TCPtMFOktpOBoSIjGrJYY88NM525yARnbC+Nrkvqm7uh8SpJZY2Mk
        6MfI0OnGBxuuW2BA==
Received: from quack3.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B715A3B83;
        Wed, 26 Jan 2022 10:43:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 38D5EA05E6; Wed, 26 Jan 2022 11:43:50 +0100 (CET)
Date:   Wed, 26 Jan 2022 11:43:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCH 1/4] vfs: make freeze_super abort when sync_filesystem
 returns error
Message-ID: <20220126104350.tk3v4mez37qbr7yx@quack3.lan>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <164316349509.2600168.11461158492068710281.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164316349509.2600168.11461158492068710281.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-01-22 18:18:15, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If we fail to synchronize the filesystem while preparing to freeze the
> fs, abort the freeze.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/super.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> 
> diff --git a/fs/super.c b/fs/super.c
> index 7af820ba5ad5..f1d4a193602d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1616,11 +1616,9 @@ static void lockdep_sb_freeze_acquire(struct super_block *sb)
>  		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
>  }
>  
> -static void sb_freeze_unlock(struct super_block *sb)
> +static void sb_freeze_unlock(struct super_block *sb, int level)
>  {
> -	int level;
> -
> -	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
> +	for (level--; level >= 0; level--)
>  		percpu_up_write(sb->s_writers.rw_sem + level);
>  }
>  
> @@ -1691,7 +1689,14 @@ int freeze_super(struct super_block *sb)
>  	sb_wait_write(sb, SB_FREEZE_PAGEFAULT);
>  
>  	/* All writers are done so after syncing there won't be dirty data */
> -	sync_filesystem(sb);
> +	ret = sync_filesystem(sb);
> +	if (ret) {
> +		sb->s_writers.frozen = SB_UNFROZEN;
> +		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
> +		wake_up(&sb->s_writers.wait_unfrozen);
> +		deactivate_locked_super(sb);
> +		return ret;
> +	}
>  
>  	/* Now wait for internal filesystem counter */
>  	sb->s_writers.frozen = SB_FREEZE_FS;
> @@ -1703,7 +1708,7 @@ int freeze_super(struct super_block *sb)
>  			printk(KERN_ERR
>  				"VFS:Filesystem freeze failed\n");
>  			sb->s_writers.frozen = SB_UNFROZEN;
> -			sb_freeze_unlock(sb);
> +			sb_freeze_unlock(sb, SB_FREEZE_FS);
>  			wake_up(&sb->s_writers.wait_unfrozen);
>  			deactivate_locked_super(sb);
>  			return ret;
> @@ -1748,7 +1753,7 @@ static int thaw_super_locked(struct super_block *sb)
>  	}
>  
>  	sb->s_writers.frozen = SB_UNFROZEN;
> -	sb_freeze_unlock(sb);
> +	sb_freeze_unlock(sb, SB_FREEZE_FS);
>  out:
>  	wake_up(&sb->s_writers.wait_unfrozen);
>  	deactivate_locked_super(sb);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
