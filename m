Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B214072CEB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFLSrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjFLSrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C3184;
        Mon, 12 Jun 2023 11:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB39621E5;
        Mon, 12 Jun 2023 18:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0ECC4339B;
        Mon, 12 Jun 2023 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686595669;
        bh=z4Jlgn6lx/ba8O675cSjkKpBGRWNnb1/lHHVzYwJ9R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkyAYPrxehJxT4qVkgvI+QWJqaoe4ob4EaRk4S8oWGWT8KoWnmmkIaFcws3bYaZ6l
         mwSDh9Vr1A4Ni6QJ1PQMiIlkYJTCln06tEKaJtq9Uq9Vd+0VPlgCA9kHwmzPNE9Mjw
         arKj3lNOVcKnw44rI0fHvnfdTVuPFKyi5zYiBRVle9GnpCzHcgVDbRw3ZSYIuYNOW6
         qPaOHol5Jh0FesrtdomGdwMCXf9WHox318tPuZWbQmjkQKsGHQ5NbrnBBqJ+hB1kpd
         iha/l1Fb01pNV+/Lv3BCn2zNDtPNPfRbOyS0ySpz2zvxqMCGwN+XNVR45rA6KGHGMu
         R3LN+vNw88Kyw==
Date:   Mon, 12 Jun 2023 11:47:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <20230612184749.GJ11441@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
 <ZIaYrA3Jz5Q75X1P@infradead.org>
 <20230612183302.GH11441@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612183302.GH11441@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:33:02AM -0700, Darrick J. Wong wrote:
> On Sun, Jun 11, 2023 at 09:01:48PM -0700, Christoph Hellwig wrote:
> > On Sun, Jun 11, 2023 at 08:15:28PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Jan Kara suggested that when one thread is in the middle of freezing a
> > > filesystem, another thread trying to freeze the same fs but with a
> > > different freeze_holder should wait until the freezer reaches either end
> > > state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.
> > > 
> > > Plumb in the extra coded needed to wait for the fs freezer to reach an
> > > end state and try the freeze again.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/super.c |   27 +++++++++++++++++++++++++--
> > >  1 file changed, 25 insertions(+), 2 deletions(-)
> > > 
> > > 
> > > diff --git a/fs/super.c b/fs/super.c
> > > index 36adccecc828..151e0eeff2c2 100644
> > > --- a/fs/super.c
> > > +++ b/fs/super.c
> > > @@ -1647,6 +1647,15 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
> > >  	return 0;
> > >  }
> > >  
> > > +static void wait_for_partially_frozen(struct super_block *sb)
> > > +{
> > > +	up_write(&sb->s_umount);
> > > +	wait_var_event(&sb->s_writers.frozen,
> > > +			sb->s_writers.frozen == SB_UNFROZEN ||
> > > +			sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> > > +	down_write(&sb->s_umount);
> > 
> > Does sb->s_writers.frozen need WRITE_ONCE/READ_ONCE treatment if we want
> > to check it outside of s_umount?  Or should we maybe just open code
> > wait_var_event and only drop the lock after checking the variable?
> 
> How about something like:
> 
> 	do {
> 		up_write(&sb->s_umount);
> 		down_write(&sb->s_umount);
> 	} while (sb->s_writers.frozen != SB_UNFROZEN &&
> 		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);
> 
> so that we always return in either end state of a freezer transition?

Of course as soon as I hit send I realize that no, we don't want to be
cycling s_umount repeatedly even sb->s_writers.frozen hasn't changed.
And maybe we want the wait to be killable too?

static int wait_for_partially_frozen(struct super_block *sb)
{
	int ret = 0;

	do {
		unsigned short old = sb->s_writers.frozen;

		up_write(&sb->s_umount);
		ret = wait_var_event_killable(&sb->s_writers.frozen,
					       sb->s_writers.frozen != old);
		down_write(&sb->s_umount);
	} while (ret == 0 &&
		 sb->s_writers.frozen != SB_UNFROZEN &&
		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);

	return ret;
}

I'll try this out and report back.

--D

> > >  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> > > -		deactivate_locked_super(sb);
> > > -		return -EBUSY;
> > > +		if (!try_again) {
> > > +			deactivate_locked_super(sb);
> > > +			return -EBUSY;
> > > +		}
> > > +
> > > +		wait_for_partially_frozen(sb);
> > > +		try_again = false;
> > > +		goto retry;
> > 
> > Can you throw in a comment on wait we're only waiting for a partial
> > freeze one here?
> 
> I didn't want a thread to get stuck in the retry forever if it always
> loses the race.  However, I think any other threads running freeze_super
> will always end at UNFROZEN or COMPLETE; and thaw_super always goes
> straight froM COMPLETE to UNFROZEN, so I think I'll get rid of the retry
> flag logic entirely.
> 
> --D
