Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9766DF0CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLJpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 05:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDLJpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBC67ED8
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 02:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C16763250
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 09:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8DAC4339B;
        Wed, 12 Apr 2023 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681292677;
        bh=nCmFY+qDV6ZYrQbcRhBQpIZydqqv+V7F/dGcomHCuyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq1KfR/3mjMH/vzKlMlBl+gHjvyX/1qyOBroZxiXBVxFd+UsYBYEtaC80GlcgJ4rB
         Nm4VhAwqC9sJTJelmFS1U5qfLwzoZOHlryzPZGBJx5ZQyKWqdk9ng3lRpqc3wTZ1HT
         yuvaD+hiYv7bBeBBRYnTyLf5gSIQY9ZihnEHF4fSDILsKBKWDOKLD5knxWHLcYL2T5
         qiXkCjp+TGOJMh+OnLTcI/uRreINZapBtpqBgjoToBZXXLC6l8XFHO4VdgabNYDa0m
         qt4JT4eJCSRmIc+yvEZg71PWh0lrvtnA7nU75fbNJ9yWXRLw1DJX1ZWiAI2tD8o8oP
         yIJFq7U3zZBSg==
Date:   Wed, 12 Apr 2023 11:44:32 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Message-ID: <20230412094432.p5x3sjolu7tbn5g7@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-5-cem@kernel.org>
 <4sn9HjMu80MnoBrnTf2T-G0QFQc9QOwiM7e6ahvv7dZ0N6lpoMY-NTul3DgbNZF08r69V6BuAQI1QcdSzdAFKQ==@protonmail.internalid>
 <20230404123442.kettrnpmumpzc2da@quack3>
 <20230404134836.blwy3mfhl3n2bfyj@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134836.blwy3mfhl3n2bfyj@andromeda>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Honza

> > > +static int shmem_release_dquot(struct dquot *dquot)
> > > +{
> > > +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > > +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> > > +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > > +	struct quota_id *entry = NULL;
> > > +
> > > +	mutex_lock(&dquot->dq_lock);
> > > +	/* Check whether we are not racing with some other dqget() */
> > > +	if (dquot_is_busy(dquot))
> > > +		goto out_dqlock;
> > > +
> > > +	down_write(&dqopt->dqio_sem);
> > > +	while (node) {
> > > +		entry = rb_entry(node, struct quota_id, node);
> > > +
> > > +		if (id < entry->id)
> > > +			node = node->rb_left;
> > > +		else if (id > entry->id)
> > > +			node = node->rb_right;
> > > +		else
> > > +			goto found;
> > > +	}
> > > +
> > > +	up_write(&dqopt->dqio_sem);
> > > +	mutex_unlock(&dquot->dq_lock);
> > 
> > We should report some kind of error here, shouldn't we? We do expect to
> > have the quota_id allocated from shmem_acquire_dquot() and we will be
> > possibly loosing set limits here.
> > 

I've been looking into this today, and I'm not sure if there is any error we
should be reporting here, as there isn't anything to really go wrong here. I was
comparing it with other filesystems, and most of them uses dquot_release()
return value, as a return value for .release_dquot. And on such cases, the error
could be other than zero, if something failed while writing the dquot to disk.
In the case here, we just write to the RB tree in memory, and it has already
been allocated, so, I don't think there is any error we could be returning here.
Does it sound right to you?

Cheers.


-- 
Carlos Maiolino
