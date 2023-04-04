Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6A06D60D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjDDMgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjDDMfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:35:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAF422E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 05:34:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA4192297B;
        Tue,  4 Apr 2023 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680611682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsWqIVQMlejDSW23EJAmwIj/GHRNWK6PJ/N+41zghf0=;
        b=TAlzRYiBIjxaVMC6H76pOUtE2YdpkCpNIcr3pS4cDWzMs67s4lsnBvSOVeVUoyu/xUpNRG
        QDxXPlJa9jSZKhF1zpC6iPn2tId+S/s4LaMoVg75zZuG4v91vIrjmvJjEpw8/fMzqVlqQN
        hLH0Y7waEaM+6MiqNJYrqhOpR1HQzz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680611682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsWqIVQMlejDSW23EJAmwIj/GHRNWK6PJ/N+41zghf0=;
        b=RFzj5oPiX8/kqEb2S48gUC78Isi3jZVq+KosWDmavhuDbzFWW7Kb42kMuzbDMbbJI+1kTG
        b4FG03JuVXwgmNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B2BB13920;
        Tue,  4 Apr 2023 12:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wG/ZJWIZLGSRJQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Apr 2023 12:34:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 15E0FA0732; Tue,  4 Apr 2023 14:34:42 +0200 (CEST)
Date:   Tue, 4 Apr 2023 14:34:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Message-ID: <20230404123442.kettrnpmumpzc2da@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-5-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403084759.884681-5-cem@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 10:47:57, cem@kernel.org wrote:
> From: Lukas Czerner <lczerner@redhat.com>
> 
> Add new shmem quota format, its quota_format_ops together with
> dquot_operations
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Just two small things below.

> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> new file mode 100644
> index 0000000000000..c415043a71e67
> --- /dev/null
> +++ b/mm/shmem_quota.c
...
> +/*
> + * Load dquot with limits from existing entry, or create the new entry if
> + * it does not exist.
> + */
> +static int shmem_acquire_dquot(struct dquot *dquot)
> +{
> +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> +	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
> +	struct rb_node *parent = NULL, *new_node = NULL;
> +	struct quota_id *new_entry, *entry;
> +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> +	int ret = 0;
> +
> +	mutex_lock(&dquot->dq_lock);
> +
> +	down_write(&dqopt->dqio_sem);
> +	while (*n) {
> +		parent = *n;
> +		entry = rb_entry(parent, struct quota_id, node);
> +
> +		if (id < entry->id)
> +			n = &(*n)->rb_left;
> +		else if (id > entry->id)
> +			n = &(*n)->rb_right;
> +		else
> +			goto found;
> +	}
> +
> +	/* We don't have entry for this id yet, create it */
> +	new_entry = kzalloc(sizeof(struct quota_id), GFP_NOFS);
> +	if (!new_entry) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	new_entry->id = id;
> +	new_node = &new_entry->node;
> +	rb_link_node(new_node, parent, n);
> +	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
> +	entry = new_entry;
> +
> +found:
> +	/* Load the stored limits from the tree */
> +	spin_lock(&dquot->dq_dqb_lock);
> +	dquot->dq_dqb.dqb_bhardlimit = entry->bhardlimit;
> +	dquot->dq_dqb.dqb_bsoftlimit = entry->bsoftlimit;
> +	dquot->dq_dqb.dqb_ihardlimit = entry->ihardlimit;
> +	dquot->dq_dqb.dqb_isoftlimit = entry->isoftlimit;
> +
> +	if (!dquot->dq_dqb.dqb_bhardlimit &&
> +	    !dquot->dq_dqb.dqb_bsoftlimit &&
> +	    !dquot->dq_dqb.dqb_ihardlimit &&
> +	    !dquot->dq_dqb.dqb_isoftlimit)
> +		set_bit(DQ_FAKE_B, &dquot->dq_flags);
> +	spin_unlock(&dquot->dq_dqb_lock);
> +
> +	/* Make sure flags update is visible after dquot has been filled */
> +	smp_mb__before_atomic();
> +	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);

I'm slightly wondering whether we shouldn't have a dquot_mark_active()
helper for this to hide the barrier details...

> +out_unlock:
> +	up_write(&dqopt->dqio_sem);
> +	mutex_unlock(&dquot->dq_lock);
> +	return ret;
> +}
> +
> +/*
> + * Store limits from dquot in the tree unless it's fake. If it is fake
> + * remove the id from the tree since there is no useful information in
> + * there.
> + */
> +static int shmem_release_dquot(struct dquot *dquot)
> +{
> +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> +	struct quota_id *entry = NULL;
> +
> +	mutex_lock(&dquot->dq_lock);
> +	/* Check whether we are not racing with some other dqget() */
> +	if (dquot_is_busy(dquot))
> +		goto out_dqlock;
> +
> +	down_write(&dqopt->dqio_sem);
> +	while (node) {
> +		entry = rb_entry(node, struct quota_id, node);
> +
> +		if (id < entry->id)
> +			node = node->rb_left;
> +		else if (id > entry->id)
> +			node = node->rb_right;
> +		else
> +			goto found;
> +	}
> +
> +	up_write(&dqopt->dqio_sem);
> +	mutex_unlock(&dquot->dq_lock);

We should report some kind of error here, shouldn't we? We do expect to
have the quota_id allocated from shmem_acquire_dquot() and we will be
possibly loosing set limits here.

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
