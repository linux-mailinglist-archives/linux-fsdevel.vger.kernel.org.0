Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7096DF2E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 13:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDLLQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjDLLQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6357DA4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 04:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EAB462AA1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 11:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF7DC433D2;
        Wed, 12 Apr 2023 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681298088;
        bh=rHUZtGRkV4yBcmlzGakf5qYn8rNrtTmQ84uzuS2ngHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DH0uPm4wPDUhJDbgf2LQzIFtR3ZOn8KE/hWpH3jcXliklLlbZEIfPrKNivl7Kecof
         MLaJDgg10hv97qefFDfX0DDw/AB39d4XiShyfPXYEFaNW3hnEls3TO5uLXWSW2SQ08
         dbsBCrnzq+AQvBAyCFjUPsVGp+wbzo4peJAkoEtvNvPvZpmtYLnA5vSgLHEe0C0CPk
         zq5DTRT0lZbB8AoHEo0DzwX6I1may44r9mGY4w1ErnE+YnZa6H8w6VtkHm9cgfwBp3
         EmGReuHipsWpSB5WMgSrtpkXtZW/zrTuLMBx4ellM3hF2tA+jbaj5W5lplyiJOaHVr
         B4KJBhMWu+Nwg==
Date:   Wed, 12 Apr 2023 13:14:43 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 4/6] shmem: prepare shmem quota infrastructure
Message-ID: <20230412111443.lr5lqq6mchvmesrz@andromeda>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-5-cem@kernel.org>
 <4sn9HjMu80MnoBrnTf2T-G0QFQc9QOwiM7e6ahvv7dZ0N6lpoMY-NTul3DgbNZF08r69V6BuAQI1QcdSzdAFKQ==@protonmail.internalid>
 <20230404123442.kettrnpmumpzc2da@quack3>
 <20230404134836.blwy3mfhl3n2bfyj@andromeda>
 <20230412094432.p5x3sjolu7tbn5g7@andromeda>
 <_RNo167yxIjXxuLcxRNS79sAk-Hp_67QvILlhEB8sBbXmODJW90YOWDYYU9HHA5MzJ3fFUPxZEfAVbPwlHwfXQ==@protonmail.internalid>
 <20230412100440.pjgbqc6c44rq5ffj@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412100440.pjgbqc6c44rq5ffj@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:04:40PM +0200, Jan Kara wrote:
> Hi Carlos!
> 
> On Wed 12-04-23 11:44:32, Carlos Maiolino wrote:
> > > > > +static int shmem_release_dquot(struct dquot *dquot)
> > > > > +{
> > > > > +	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
> > > > > +	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
> > > > > +	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
> > > > > +	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
> > > > > +	struct quota_id *entry = NULL;
> > > > > +
> > > > > +	mutex_lock(&dquot->dq_lock);
> > > > > +	/* Check whether we are not racing with some other dqget() */
> > > > > +	if (dquot_is_busy(dquot))
> > > > > +		goto out_dqlock;
> > > > > +
> > > > > +	down_write(&dqopt->dqio_sem);
> > > > > +	while (node) {
> > > > > +		entry = rb_entry(node, struct quota_id, node);
> > > > > +
> > > > > +		if (id < entry->id)
> > > > > +			node = node->rb_left;
> > > > > +		else if (id > entry->id)
> > > > > +			node = node->rb_right;
> > > > > +		else
> > > > > +			goto found;
> > > > > +	}
> > > > > +
> > > > > +	up_write(&dqopt->dqio_sem);
> > > > > +	mutex_unlock(&dquot->dq_lock);
> > > >
> > > > We should report some kind of error here, shouldn't we? We do expect to
> > > > have the quota_id allocated from shmem_acquire_dquot() and we will be
> > > > possibly loosing set limits here.
> > > >
> >
> > I've been looking into this today, and I'm not sure if there is any error we
> > should be reporting here, as there isn't anything to really go wrong here. I was
> > comparing it with other filesystems, and most of them uses dquot_release()
> > return value, as a return value for .release_dquot. And on such cases, the error
> > could be other than zero, if something failed while writing the dquot to disk.
> > In the case here, we just write to the RB tree in memory, and it has already
> > been allocated, so, I don't think there is any error we could be returning here.
> > Does it sound right to you?
> 
> My point is that it should never happen that we don't find the entry in the
> rbtree in shmem_release_dquot(). So we should rather WARN_ON_ONCE() and
> bail or something like that, rather then silently return success. Not a big
> deal but for initial debugging it might be useful.
> 

I see. Thanks Honza. What you think about something like this:

	while (node) {
		entry = rb_entry(node, struct quota_id, node);

		if (id < entry->id)
			node = node->rb_left;
		else if (id > entry->id)
			node = node->rb_right;
		else
			goto found;
	}

	/* We should always find the entry in the rb tree */
	WARN_ONCE(1, "quota id not in rb tree!\n", __func__)
	return -ENOENT;


I am not sure if -ENOENT is the best error here though. It seems the most
logical one, as -ENOMEM wouldn't make much sense, any suggestions if you don't
agree with ENOENT?


> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Carlos Maiolino
