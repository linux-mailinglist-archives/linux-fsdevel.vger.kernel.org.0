Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6174287F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjF2OeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjF2Odh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:33:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A435B6;
        Thu, 29 Jun 2023 07:33:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8D6721862;
        Thu, 29 Jun 2023 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688049184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vz32fmlHi5odwx+tnDz9Q3kgjj/P9DMRTzxO9oNWLGE=;
        b=0qgxloJ5gILsJw2B4hTNWenffCctS663fNWFPd2jULcVBQjBV2A0ZVqIwua1s8rCHgpS6B
        WH5AH9U2toouKgwm69NiIqF7xmKVyp2OGrE3anbjUWn/CJqInorGA+sYOMU5VKESX8lCN7
        oewpWHtr7VmqHCWToJcgLT2lP1QX6Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688049184;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vz32fmlHi5odwx+tnDz9Q3kgjj/P9DMRTzxO9oNWLGE=;
        b=O3mGDKOBli+l2OghNHnJjaK4xaKr0ZiUl5eyTax23DL80Bu4gmAx3rztOXLhaqDqSKaS1m
        d4NDI9jod2OrfyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7B9513905;
        Thu, 29 Jun 2023 14:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id immhNCCWnWSgGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 14:33:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63AE0A0722; Thu, 29 Jun 2023 16:33:04 +0200 (CEST)
Date:   Thu, 29 Jun 2023 16:33:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 5/7] quota: fix dqput() to follow the guarantees
 dquot_srcu should provide
Message-ID: <20230629143304.2t45zta3f57imowa@quack3>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-6-libaokun1@huawei.com>
 <20230629105954.5cpqpch46ik4bg27@quack3>
 <9ac4fdcf-f236-8a05-bb96-b0b85a63b54e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ac4fdcf-f236-8a05-bb96-b0b85a63b54e@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-06-23 19:47:08, Baokun Li wrote:
> On 2023/6/29 18:59, Jan Kara wrote:
> > On Wed 28-06-23 21:21:53, Baokun Li wrote:
> > > @@ -760,6 +771,8 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > >   	struct dquot *dquot;
> > >   	unsigned long freed = 0;
> > > +	flush_delayed_work(&quota_release_work);
> > > +
> > I would not flush the work here. Sure, it can make more dquots available
> > for reclaim but I think it is more important for the shrinker to not wait
> > on srcu period as shrinker can be called very frequently under memory
> > pressure.
> This is because I want to use remove_free_dquot() directly, and if I don't
> do
> flush here anymore, then DQST_FREE_DQUOTS will not be accurate.
> Since that's the case, I'll remove the flush here and add a determination
> to remove_free_dquot() whether to increase DQST_FREE_DQUOTS.

OK.

> > >   	spin_lock(&dq_list_lock);
> > >   	while (!list_empty(&free_dquots) && sc->nr_to_scan) {
> > >   		dquot = list_first_entry(&free_dquots, struct dquot, dq_free);
> > > @@ -787,6 +800,60 @@ static struct shrinker dqcache_shrinker = {
> > >   	.seeks = DEFAULT_SEEKS,
> > >   };
> > > +/*
> > > + * Safely release dquot and put reference to dquot.
> > > + */
> > > +static void quota_release_workfn(struct work_struct *work)
> > > +{
> > > +	struct dquot *dquot;
> > > +	struct list_head rls_head;
> > > +
> > > +	spin_lock(&dq_list_lock);
> > > +	/* Exchange the list head to avoid livelock. */
> > > +	list_replace_init(&releasing_dquots, &rls_head);
> > > +	spin_unlock(&dq_list_lock);
> > > +
> > > +restart:
> > > +	synchronize_srcu(&dquot_srcu);
> > > +	spin_lock(&dq_list_lock);
> > > +	while (!list_empty(&rls_head)) {
> > I think the logic below needs a bit more work. Firstly, I think that
> > dqget() should removing dquots from releasing_dquots list - basically just
> > replace the:
> > 	if (!atomic_read(&dquot->dq_count))
> > 		remove_free_dquot(dquot);
> > with
> > 	/* Dquot on releasing_dquots list? Drop ref kept by that list. */
> > 	if (atomic_read(&dquot->dq_count) == 1 && !list_empty(&dquot->dq_free))
> > 		atomic_dec(&dquot->dq_count);
> > 	remove_free_dquot(dquot);
> > 	atomic_inc(&dquot->dq_count);
> > 
> > That way we are sure that while we are holding dq_list_lock, all dquots on
> > rls_head list have dq_count == 1.
> I wrote it this way at first, but that would have been problematic, so I
> ended up dropping the dq_count == 1 constraint for dquots on
> releasing_dquots.  Like the following, we will get a bad dquot directly:
> 
> quota_release_workfn
>  spin_lock(&dq_list_lock)
>  dquot = list_first_entry(&rls_head, struct dquot, dq_free)
>  spin_unlock(&dq_list_lock)
>  dquot->dq_sb->dq_op->release_dquot(dquot)
>  release_dquot
>        dqget
>         atomic_dec(&dquot->dq_count)
>         remove_free_dquot(dquot)
>         atomic_inc(&dquot->dq_count)
>         spin_unlock(&dq_list_lock)
>         wait_on_dquot(dquot)
>         if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>         // still active
>  mutex_lock(&dquot->dq_lock)
>  dquot_is_busy(dquot)
>   atomic_read(&dquot->dq_count) > 1
>  clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
>  mutex_unlock(&dquot->dq_lock)
> 
> Removing dquot from releasing_dquots and its reduced reference count
> will cause dquot_is_busy() in dquot_release to fail. wait_on_dquot(dquot)
> in dqget would have no effect. This is also the reason why I did not restart
> at dquot_active. Adding dquot to releasing_dquots only in dqput() and
> removing dquot from releasing_dquots only in quota_release_workfn() is
> a simple and effective way to ensure consistency.

Indeed, that's a good point. Still cannot we simplify the loop like:

	while (!list_empty(&rls_head)) {
		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
		/* Dquot got used again? */
		if (atomic_read(&dquot->dq_count) > 1) {
			atomic_dec(&dquot->dq_count);
			remove_free_dquot(dquot);
			continue;
		}
		if (dquot_dirty(dquot)) {
			keep what you had
		}
		if (dquot_active(dquot)) {
			spin_unlock(&dq_list_lock);
			dquot->dq_sb->dq_op->release_dquot(dquot);
			goto restart;
		}
		/* Dquot is inactive and clean, we can move it to free list */
		atomic_dec(&dquot->dq_count);
		remove_free_dquot(dquot);
		put_dquot_last(dquot);
	}

What do you think?
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
