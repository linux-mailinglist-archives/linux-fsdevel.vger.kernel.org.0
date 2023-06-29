Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AD1742493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjF2LAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjF2K76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:59:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1164A1719;
        Thu, 29 Jun 2023 03:59:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCB4F1F8AA;
        Thu, 29 Jun 2023 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688036394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UflGxvJZAGlcSQONkPiY7NaAwRRyehPihG1F0eVZXlg=;
        b=h39xgmrQKPLoSQ1QSVePdodyofGGwsexYVjD+yv7QDs4lfJT7VCpZqrOCoUVTJbMEOFQHN
        ofv9TawCHSgtgr0VfWaBBlXQuNT3BYVjlYNzvQTmYAG2S+vW/4KMYeviMpvV2T8QfHnWil
        0mVJ301Pi5qcg9nGj+99wD0WuOFdcYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688036394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UflGxvJZAGlcSQONkPiY7NaAwRRyehPihG1F0eVZXlg=;
        b=Zt+MiqTIwiDrgQRQYGDy9g50IHnD/cFZwWfijiBZfYvtcFnS6LfCorxk22or5wcl2hIFPu
        Y4nnWMCfsOqDO3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9906139FF;
        Thu, 29 Jun 2023 10:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uIlYKSpknWS/LAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 10:59:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 395CEA0722; Thu, 29 Jun 2023 12:59:54 +0200 (CEST)
Date:   Thu, 29 Jun 2023 12:59:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 5/7] quota: fix dqput() to follow the guarantees
 dquot_srcu should provide
Message-ID: <20230629105954.5cpqpch46ik4bg27@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-6-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628132155.1560425-6-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-06-23 21:21:53, Baokun Li wrote:
> The dquot_mark_dquot_dirty() using dquot references from the inode
> should be protected by dquot_srcu. quota_off code takes care to call
> synchronize_srcu(&dquot_srcu) to not drop dquot references while they
> are used by other users. But dquot_transfer() breaks this assumption.
> We call dquot_transfer() to drop the last reference of dquot and add
> it to free_dquots, but there may still be other users using the dquot
> at this time, as shown in the function graph below:
> 
>        cpu1              cpu2
> _________________|_________________
> wb_do_writeback         CHOWN(1)
>  ...
>   ext4_da_update_reserve_space
>    dquot_claim_block
>     ...
>      dquot_mark_dquot_dirty // try to dirty old quota
>       test_bit(DQ_ACTIVE_B, &dquot->dq_flags) // still ACTIVE
>       if (test_bit(DQ_MOD_B, &dquot->dq_flags))
>       // test no dirty, wait dq_list_lock
>                     ...
>                      dquot_transfer
>                       __dquot_transfer
>                       dqput_all(transfer_from) // rls old dquot
>                        dqput // last dqput
>                         dquot_release
>                          clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
>                         atomic_dec(&dquot->dq_count)
>                         put_dquot_last(dquot)
>                          list_add_tail(&dquot->dq_free, &free_dquots)
>                          // add the dquot to free_dquots
>       if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
>         add dqi_dirty_list // add released dquot to dirty_list
> 
> This can cause various issues, such as dquot being destroyed by
> dqcache_shrink_scan() after being added to free_dquots, which can trigger
> a UAF in dquot_mark_dquot_dirty(); or after dquot is added to free_dquots
> and then to dirty_list, it is added to free_dquots again after
> dquot_writeback_dquots() is executed, which causes the free_dquots list to
> be corrupted and triggers a UAF when dqcache_shrink_scan() is called for
> freeing dquot twice.
> 
> As Honza said, we need to fix dquot_transfer() to follow the guarantees
> dquot_srcu should provide. But calling synchronize_srcu() directly from
> dquot_transfer() is too expensive (and mostly unnecessary). So we add
> dquot whose last reference should be dropped to the new global dquot
> list releasing_dquots, and then queue work item which would call
> synchronize_srcu() and after that perform the final cleanup of all the
> dquots on releasing_dquots.
> 
> Fixes: 4580b30ea887 ("quota: Do not dirty bad dquots")
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/quota/dquot.c | 85 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 09787e4f6a00..e8e702ac64e5 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -270,6 +270,9 @@ static qsize_t inode_get_rsv_space(struct inode *inode);
>  static qsize_t __inode_get_rsv_space(struct inode *inode);
>  static int __dquot_initialize(struct inode *inode, int type);
>  
> +static void quota_release_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(quota_release_work, quota_release_workfn);
> +
>  static inline unsigned int
>  hashfn(const struct super_block *sb, struct kqid qid)
>  {
> @@ -569,6 +572,8 @@ static void invalidate_dquots(struct super_block *sb, int type)
>  	struct dquot *dquot, *tmp;
>  
>  restart:
> +	flush_delayed_work(&quota_release_work);
> +
>  	spin_lock(&dq_list_lock);
>  	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
>  		if (dquot->dq_sb != sb)
> @@ -577,6 +582,12 @@ static void invalidate_dquots(struct super_block *sb, int type)
>  			continue;
>  		/* Wait for dquot users */
>  		if (atomic_read(&dquot->dq_count)) {
> +			/* dquot in releasing_dquots, flush and retry */
> +			if (!list_empty(&dquot->dq_free)) {
> +				spin_unlock(&dq_list_lock);
> +				goto restart;
> +			}
> +
>  			atomic_inc(&dquot->dq_count);
>  			spin_unlock(&dq_list_lock);
>  			/*
> @@ -760,6 +771,8 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	struct dquot *dquot;
>  	unsigned long freed = 0;
>  
> +	flush_delayed_work(&quota_release_work);
> +

I would not flush the work here. Sure, it can make more dquots available
for reclaim but I think it is more important for the shrinker to not wait
on srcu period as shrinker can be called very frequently under memory
pressure.

>  	spin_lock(&dq_list_lock);
>  	while (!list_empty(&free_dquots) && sc->nr_to_scan) {
>  		dquot = list_first_entry(&free_dquots, struct dquot, dq_free);
> @@ -787,6 +800,60 @@ static struct shrinker dqcache_shrinker = {
>  	.seeks = DEFAULT_SEEKS,
>  };
>  
> +/*
> + * Safely release dquot and put reference to dquot.
> + */
> +static void quota_release_workfn(struct work_struct *work)
> +{
> +	struct dquot *dquot;
> +	struct list_head rls_head;
> +
> +	spin_lock(&dq_list_lock);
> +	/* Exchange the list head to avoid livelock. */
> +	list_replace_init(&releasing_dquots, &rls_head);
> +	spin_unlock(&dq_list_lock);
> +
> +restart:
> +	synchronize_srcu(&dquot_srcu);
> +	spin_lock(&dq_list_lock);
> +	while (!list_empty(&rls_head)) {

I think the logic below needs a bit more work. Firstly, I think that
dqget() should removing dquots from releasing_dquots list - basically just
replace the:
	if (!atomic_read(&dquot->dq_count))
		remove_free_dquot(dquot);
with
	/* Dquot on releasing_dquots list? Drop ref kept by that list. */
	if (atomic_read(&dquot->dq_count) == 1 && !list_empty(&dquot->dq_free))
		atomic_dec(&dquot->dq_count);
	remove_free_dquot(dquot);
	atomic_inc(&dquot->dq_count);

That way we are sure that while we are holding dq_list_lock, all dquots on
rls_head list have dq_count == 1.

> +		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
> +		if (dquot_dirty(dquot)) {
> +			spin_unlock(&dq_list_lock);
> +			/* Commit dquot before releasing */
> +			dquot_write_dquot(dquot);
> +			goto restart;
> +		}
> +		/* Always clear DQ_ACTIVE_B, unless racing with dqget() */
> +		if (dquot_active(dquot)) {
> +			spin_unlock(&dq_list_lock);
> +			dquot->dq_sb->dq_op->release_dquot(dquot);

I'd just go to restart here to make the logic simple. Forward progress is
guaranteed anyway and it isn't really much less efficient.

> +			spin_lock(&dq_list_lock);
> +		}
> +		/*
> +		 * During the execution of dquot_release() outside the
> +		 * dq_list_lock, another process may have completed
> +		 * dqget()/dqput()/mark_dirty().
> +		 */
> +		if (atomic_read(&dquot->dq_count) == 1 &&
> +		    (dquot_active(dquot) || dquot_dirty(dquot))) {
> +			spin_unlock(&dq_list_lock);
> +			goto restart;
> +		}

This can be dropped then...

> +		/*
> +		 * Now it is safe to remove this dquot from releasing_dquots
> +		 * and reduce its reference count.
> +		 */
> +		remove_free_dquot(dquot);
> +		atomic_dec(&dquot->dq_count);
> +
> +		/* We may be racing with some other dqget(). */
> +		if (!atomic_read(&dquot->dq_count))

This condition can also be dropped then.

> +			put_dquot_last(dquot);
> +	}
> +	spin_unlock(&dq_list_lock);
> +}
> +

The rest looks good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
