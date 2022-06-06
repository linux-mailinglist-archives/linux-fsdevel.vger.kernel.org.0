Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97053E328
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiFFIDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiFFIDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:03:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6B36697;
        Mon,  6 Jun 2022 01:03:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7121F1F390;
        Mon,  6 Jun 2022 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654502615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogqbE5NzZi+TJG9/q/rBuKyT8evWsuBQvF0qh7N7vck=;
        b=xEg0gB9keZVdMC9CdjHfHSQzUfvzerYj+DZnrMJK30mcavXbxDsE+8m3mDxCBmuUAdsunM
        vAqv5Yxmg7TQDpErVq4CeTYyUnym/T6E5e8epdBaqPkzq6Qy643OnPpQL5JkunNCwtMwF4
        hs5J+p/sa0XI+R1GQVJBA98uz2e6Ijs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654502615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogqbE5NzZi+TJG9/q/rBuKyT8evWsuBQvF0qh7N7vck=;
        b=zSYCBlRVzrmyhVklXZbV8gGtNtz3lh3+6lEszHLjvDnKBuoHYAWF8a6Y9UIQ8+o921caPD
        qg2WsI62SPP9ovDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B3212C141;
        Mon,  6 Jun 2022 08:03:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 04FD3A0633; Mon,  6 Jun 2022 10:03:34 +0200 (CEST)
Date:   Mon, 6 Jun 2022 10:03:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.com>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] quota: Prevent memory allocation recursion while
 holding dq_lock
Message-ID: <20220606080334.tv5r7kljang55fat@quack3.lan>
References: <20220605143815.2330891-1-willy@infradead.org>
 <20220605143815.2330891-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605143815.2330891-2-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 05-06-22 15:38:13, Matthew Wilcox (Oracle) wrote:
> As described in commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in
> read_cache_page_gfp while doing f2fs_quota_read"), we must not enter
> filesystem reclaim while holding the dq_lock.  Prevent this more generally
> by using memalloc_nofs_save() while holding the lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This is definitely a good cleanup to have and seems mostly unrelated to the
rest. I'll take it rightaway into my tree. Thanks for the patch!

								Honza

> ---
>  fs/quota/dquot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index a74aef99bd3d..cdb22d6d7488 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -425,9 +425,11 @@ EXPORT_SYMBOL(mark_info_dirty);
>  int dquot_acquire(struct dquot *dquot)
>  {
>  	int ret = 0, ret2 = 0;
> +	unsigned int memalloc;
>  	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
>  
>  	mutex_lock(&dquot->dq_lock);
> +	memalloc = memalloc_nofs_save();
>  	if (!test_bit(DQ_READ_B, &dquot->dq_flags)) {
>  		ret = dqopt->ops[dquot->dq_id.type]->read_dqblk(dquot);
>  		if (ret < 0)
> @@ -458,6 +460,7 @@ int dquot_acquire(struct dquot *dquot)
>  	smp_mb__before_atomic();
>  	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
>  out_iolock:
> +	memalloc_nofs_restore(memalloc);
>  	mutex_unlock(&dquot->dq_lock);
>  	return ret;
>  }
> @@ -469,9 +472,11 @@ EXPORT_SYMBOL(dquot_acquire);
>  int dquot_commit(struct dquot *dquot)
>  {
>  	int ret = 0;
> +	unsigned int memalloc;
>  	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
>  
>  	mutex_lock(&dquot->dq_lock);
> +	memalloc = memalloc_nofs_save();
>  	if (!clear_dquot_dirty(dquot))
>  		goto out_lock;
>  	/* Inactive dquot can be only if there was error during read/init
> @@ -481,6 +486,7 @@ int dquot_commit(struct dquot *dquot)
>  	else
>  		ret = -EIO;
>  out_lock:
> +	memalloc_nofs_restore(memalloc);
>  	mutex_unlock(&dquot->dq_lock);
>  	return ret;
>  }
> @@ -492,9 +498,11 @@ EXPORT_SYMBOL(dquot_commit);
>  int dquot_release(struct dquot *dquot)
>  {
>  	int ret = 0, ret2 = 0;
> +	unsigned int memalloc;
>  	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
>  
>  	mutex_lock(&dquot->dq_lock);
> +	memalloc = memalloc_nofs_save();
>  	/* Check whether we are not racing with some other dqget() */
>  	if (dquot_is_busy(dquot))
>  		goto out_dqlock;
> @@ -510,6 +518,7 @@ int dquot_release(struct dquot *dquot)
>  	}
>  	clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
>  out_dqlock:
> +	memalloc_nofs_restore(memalloc);
>  	mutex_unlock(&dquot->dq_lock);
>  	return ret;
>  }
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
