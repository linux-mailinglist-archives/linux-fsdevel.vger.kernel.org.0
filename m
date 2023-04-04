Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F536D63C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjDDNtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjDDNsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E2198
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 06:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A0C6315E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 13:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B53C4339B;
        Tue,  4 Apr 2023 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680616121;
        bh=vSqwQdgD2srET/ADmzV+Ts391AbzKPWVNMOCV2W1ums=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blD8ShY0ASRyJcmtrG8C2GMr53i1W4GVN2oe5kztE/i0nI+cvI45PeplYp3Dm061P
         7xoNrxgab7eUNHhvVikTk16ZDSohhFQnJtjF3stYNcvAAAbYtnS3rn3oAOh2bUehln
         40HO3KTZcv141pZyPiWBz34JZRsW/y3HSMjqSDxJrKT6tWouetpi0xA7s3d1G+uKCF
         NBHof6R9uIxEwRQAwoR/czy0cYuw/j4Vx1nov6eynnEnYWT1ii4oY1Cirbe1WjhQ/V
         7Cf2pqthxfgjUvhdTxhtwnN6pnUCAexrM2w+XUH+g0T2JJ5eCmz3vuA2aNXdxK+FaZ
         nqKtGHgteddZw==
Date:   Tue, 4 Apr 2023 15:48:36 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Message-ID: <20230404134836.blwy3mfhl3n2bfyj@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-5-cem@kernel.org>
 <4sn9HjMu80MnoBrnTf2T-G0QFQc9QOwiM7e6ahvv7dZ0N6lpoMY-NTul3DgbNZF08r69V6BuAQI1QcdSzdAFKQ==@protonmail.internalid>
 <20230404123442.kettrnpmumpzc2da@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404123442.kettrnpmumpzc2da@quack3>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Honza.

> > +	if (!dquot->dq_dqb.dqb_bhardlimit &&
> > +	    !dquot->dq_dqb.dqb_bsoftlimit &&
> > +	    !dquot->dq_dqb.dqb_ihardlimit &&
> > +	    !dquot->dq_dqb.dqb_isoftlimit)
> > +		set_bit(DQ_FAKE_B, &dquot->dq_flags);
> > +	spin_unlock(&dquot->dq_dqb_lock);
> > +
> > +	/* Make sure flags update is visible after dquot has been filled */
> > +	smp_mb__before_atomic();
> > +	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
> 
> I'm slightly wondering whether we shouldn't have a dquot_mark_active()
> helper for this to hide the barrier details...

This sounds good to me, would be ok for you if I simply add this to my todo
list, and do it once this series is merged? I'd rather avoid to add more patches
to the series now adding more review overhead.
I can send a new patch later creating a new helper and replacing all
set_bit(DQ_ACTIVE_B, ...) calls with the new helper.

> 
> > +out_unlock:
> > +	up_write(&dqopt->dqio_sem);
> > +	mutex_unlock(&dquot->dq_lock);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Store limits from dquot in the tree unless it's fake. If it is fake
> > + * remove the id from the tree since there is no useful information in
> > + * there.
> > + */
> > +static int shmem_release_dquot(struct dquot *dquot)
> > +{
> > +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> > +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > +	struct quota_id *entry = NULL;
> > +
> > +	mutex_lock(&dquot->dq_lock);
> > +	/* Check whether we are not racing with some other dqget() */
> > +	if (dquot_is_busy(dquot))
> > +		goto out_dqlock;
> > +
> > +	down_write(&dqopt->dqio_sem);
> > +	while (node) {
> > +		entry = rb_entry(node, struct quota_id, node);
> > +
> > +		if (id < entry->id)
> > +			node = node->rb_left;
> > +		else if (id > entry->id)
> > +			node = node->rb_right;
> > +		else
> > +			goto found;
> > +	}
> > +
> > +	up_write(&dqopt->dqio_sem);
> > +	mutex_unlock(&dquot->dq_lock);
> 
> We should report some kind of error here, shouldn't we? We do expect to
> have the quota_id allocated from shmem_acquire_dquot() and we will be
> possibly loosing set limits here.
> 

Sounds correct, I'll update it once we agree on how to proceed with your above
suggestion of dquot_mark_active().

> Otherwise the patch looks good to me.
> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
