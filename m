Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8197572CE79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbjFLSdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbjFLSdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4E113;
        Mon, 12 Jun 2023 11:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B216297D;
        Mon, 12 Jun 2023 18:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C831DC4339C;
        Mon, 12 Jun 2023 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686594782;
        bh=ZmBL1+op0YvaKwgOhf7gbh6+xQBY0TbuBsNxg5V5y6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Odr7Dsm2YJYZNP6Rsm2epFdKSLoYmMYjBfwrGydzRJWNV7+FWaK8OJXK2R5QVdhpH
         uLWCd3W5SZdDZxxMEgzf4POYFoivnZV1rgxNMCtWI2iQ7C9aac9CqKyIzxd3NomTYU
         aYTWAbU2GanfyghSNeexsqbWggDANBRK8zjk+uhorLrOnGg8v2hb/curU5K6v09anh
         5UT9X6159oDjxALjFn4wKgjc2OkgtS8Ag2TQHFizMibdYrkWwhbShTMassd2HjUHd1
         WgNzBLgKzzjqOuTNqMF7WADYkak25Mx6AOYxZLo/W4JYEaQFmNRgxD2DaReHV+1vD0
         ISp9A2Mccf4Hw==
Date:   Mon, 12 Jun 2023 11:33:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH 2/3] fs: wait for partially frozen filesystems
Message-ID: <20230612183302.GH11441@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
 <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
 <ZIaYrA3Jz5Q75X1P@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIaYrA3Jz5Q75X1P@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 09:01:48PM -0700, Christoph Hellwig wrote:
> On Sun, Jun 11, 2023 at 08:15:28PM -0700, Darrick J. Wong wrote:
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
> > ---
> >  fs/super.c |   27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index 36adccecc828..151e0eeff2c2 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1647,6 +1647,15 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
> >  	return 0;
> >  }
> >  
> > +static void wait_for_partially_frozen(struct super_block *sb)
> > +{
> > +	up_write(&sb->s_umount);
> > +	wait_var_event(&sb->s_writers.frozen,
> > +			sb->s_writers.frozen == SB_UNFROZEN ||
> > +			sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> > +	down_write(&sb->s_umount);
> 
> Does sb->s_writers.frozen need WRITE_ONCE/READ_ONCE treatment if we want
> to check it outside of s_umount?  Or should we maybe just open code
> wait_var_event and only drop the lock after checking the variable?

How about something like:

	do {
		up_write(&sb->s_umount);
		down_write(&sb->s_umount);
	} while (sb->s_writers.frozen != SB_UNFROZEN &&
		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);

so that we always return in either end state of a freezer transition?

> >  	if (sb->s_writers.frozen != SB_UNFROZEN) {
> > -		deactivate_locked_super(sb);
> > -		return -EBUSY;
> > +		if (!try_again) {
> > +			deactivate_locked_super(sb);
> > +			return -EBUSY;
> > +		}
> > +
> > +		wait_for_partially_frozen(sb);
> > +		try_again = false;
> > +		goto retry;
> 
> Can you throw in a comment on wait we're only waiting for a partial
> freeze one here?

I didn't want a thread to get stuck in the retry forever if it always
loses the race.  However, I think any other threads running freeze_super
will always end at UNFROZEN or COMPLETE; and thaw_super always goes
straight froM COMPLETE to UNFROZEN, so I think I'll get rid of the retry
flag logic entirely.

--D
