Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19A472CE8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjFLShB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFLShA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11504102;
        Mon, 12 Jun 2023 11:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4CE62D25;
        Mon, 12 Jun 2023 18:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF05C433EF;
        Mon, 12 Jun 2023 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686595018;
        bh=ipow/V0PjhrSSq2tJdI44+0zoGqli10Qq6k5fAD2mXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjvCfg+nFEYKJTSxyu2Q5FZfYz/YKd1ec3p3FhpjnteoSa3bhyuRa/5BQIBPv2bjM
         d4X4MgAPthzIM8NVVZ0OuZkiw/cTJajkO85oSmpPoo7ZRZFG1xozI8WhkwNNEa5mML
         tt9mH2meYSQiw0IcS9WyLI93AxTIHoBv3ieyXtAbD2q1coIhXsZrpIwF9kimenVexE
         1+94himrPE6d2zTFjUqpFr0N5ExhQ7+oU41le1UygAAv19m8GQ44PHq52RMlWRBFE+
         IYG6Z1wRDoyCPzZAYLf2AJ+DuG996CoIUbyZuuC3uYThQf/1Q4zGB2hgOLYaCUDgaY
         HxITmB+yKVAbA==
Date:   Mon, 12 Jun 2023 11:36:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, hch@infradead.org, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <20230612183657.GI11441@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
 <20230612113526.xfhpaohiqusq5ixt@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113526.xfhpaohiqusq5ixt@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:35:26PM +0200, Jan Kara wrote:
> On Sun 11-06-23 20:15:28, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Jan Kara suggested that when one thread is in the middle of freezing a
> > filesystem, another thread trying to freeze the same fs but with a
> > different freeze_holder should wait until the freezer reaches either end
> > state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.
> > 
> > Plumb in the extra coded needed to wait for the fs freezer to reach an
> > end state and try the freeze again.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> 
> You can maybe copy my reasoning from my reply to your patch 1/3 to the
> changelog to explain why waiting is more desirable.

Done.

"Neither caller can do anything sensible with this race other than retry
but they cannot really distinguish EBUSY as in "someone other holder of
the same type has the sb already frozen" from "freezing raced with
holder of a different type"

is now added to the commit message.

> > @@ -1690,11 +1699,13 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
> >   */
> >  int freeze_super(struct super_block *sb, enum freeze_holder who)
> >  {
> > +	bool try_again = true;
> >  	int ret;
> >  
> >  	atomic_inc(&sb->s_active);
> >  	down_write(&sb->s_umount);
> >  
> > +retry:
> >  	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> >  		ret = freeze_frozen_super(sb, who);
> >  		deactivate_locked_super(sb);
> > @@ -1702,8 +1713,14 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
> >  	}
> >  
> >  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> > -		deactivate_locked_super(sb);
> > -		return -EBUSY;
> > +		if (!try_again) {
> > +			deactivate_locked_super(sb);
> > +			return -EBUSY;
> > +		}
> 
> Why only one retry? Do you envision someone will be freezing & thawing
> filesystem so intensively that livelocks are possible?

I was worried about that, but the more I think about it, the more I can
convince myself that we can take the simpler approach of cycling
s_umount until we get the state we want.

> In that case I'd
> think the system has other problems than freeze taking long... Honestly,
> I'd be looping as long as we either succeed or return error for other
> reasons.

Ok.

> What we could be doing to limit unnecessary waiting is that we'd update
> freeze_holders already when we enter freeze_super() and lock s_umount
> (bailing if our holder type is already set). That way we'd have at most one
> process for each holder type freezing the fs / waiting for freezing to
> complete.

<shrug> I don't know how often we even really have threads contending
for s_umount and elevated freeze state.  How about we go with the
simpler wait_for_partially_frozen and see if complaints crop up?

> > +
> > +		wait_for_partially_frozen(sb);
> > +		try_again = false;
> > +		goto retry;
> >  	}
> >  
> ...
> > @@ -1810,6 +1831,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
> >  	if (sb_rdonly(sb)) {
> >  		sb->s_writers.freeze_holders &= ~who;
> >  		sb->s_writers.frozen = SB_UNFROZEN;
> > +		wake_up_var(&sb->s_writers.frozen);
> >  		goto out;
> >  	}
> >  
> > @@ -1828,6 +1850,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
> >  
> >  	sb->s_writers.freeze_holders &= ~who;
> >  	sb->s_writers.frozen = SB_UNFROZEN;
> > +	wake_up_var(&sb->s_writers.frozen);
> >  	sb_freeze_unlock(sb, SB_FREEZE_FS);
> >  out:
> >  	wake_up(&sb->s_writers.wait_unfrozen);
> 
> I don't think wakeups on thaw are really needed because the waiter should
> be woken already once the freezing task exits from freeze_super(). I guess
> you've sprinkled them here just for good measure?

I've changed wait_for_partially_frozen to cycle s_umount until we find
the locked state we want, so the wake_up_var calls aren't needed
anymore.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
