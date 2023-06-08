Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D47286FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjFHSP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 14:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFHSP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B31FDC;
        Thu,  8 Jun 2023 11:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B6865054;
        Thu,  8 Jun 2023 18:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB9C433EF;
        Thu,  8 Jun 2023 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686248126;
        bh=HSkHDkl1RvAqJTbqvoH8kuaiTAB3DjTsVtEeoNWG6d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pK1q/HzkV8X1zoHnGxbnvpwl0WE/W+13njgnV0BQvxyogV+g3FrD8HWvVXCxGFvPa
         qYOvWsPOsnRyxZ8kWbq7mF1smux5esAGrb6u/6VPDUFqFVf6bIszGxNLDv2JAQx74M
         BAZ+fmfhHwEWIm39ZhIKgQXA/1CFNjrgqkDM/v4f5aODUCVoyyB6caTfC+A6BQ0vHS
         MMx4F9S5HosFRgBQCWE03E70BfSx3D2aBLEChKlD7Fi6sQe9jQBkBqnaTMxEhvVwZh
         ZRr/ig3hZIm2xP3T1QvgQTBTrTHN9zXKaLffuYtRS1HLPESfAYUbVJ96eGYzHqTqk/
         Vwt+3nxAwDdSw==
Date:   Thu, 8 Jun 2023 11:15:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230608181525.GE72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <ZIFmEGdJ4CCbS1B3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFmEGdJ4CCbS1B3@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:24:32PM -0700, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 04:42:00PM -0700, Darrick J. Wong wrote:
> > How about this as an alternative patch?  Kernel and userspace freeze
> > state are stored in s_writers; each type cannot block the other (though
> > you still can't have nested kernel or userspace freezes); and the freeze
> > is maintained until /both/ freeze types are dropped.
> > 
> > AFAICT this should work for the two other usecases (quiescing pagefaults
> > for fsdax pmem pre-removal; and freezing fses during suspend) besides
> > online fsck for xfs.
> 
> I think this is fundamentally the right thing.  Can you send this as
> a standalone thread in a separate thread to make it sure it gets
> expedited?

Yeah, I'll do that.

> > -static int thaw_super_locked(struct super_block *sb);
> > +static int thaw_super_locked(struct super_block *sb, unsigned short who);
> 
> Is the unsigned short really worth it?  Even if it's just two values
> I'd also go for a __bitwise type to get the typechecking as that tends
> to help a lot goind down the road.

Instead of __bitwise, I'll make freeze_super() take an enum, since
callers can only initiate one at a time, and the compiler can (in
theory) catch people passing garbage inputs.

> >  /**
> > - * freeze_super - lock the filesystem and force it into a consistent state
> > + * __freeze_super - lock the filesystem and force it into a consistent state
> >   * @sb: the super to lock
> > + * @who: FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
> > + * FREEZE_HOLDER_KERNEL if the kernel wants to freeze it
> >   *
> >   * Syncs the super to make sure the filesystem is consistent and calls the fs's
> > - * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> > + * freeze_fs.  Subsequent calls to this without first thawing the fs may return
> >   * -EBUSY.
> >   *
> > + * The @who argument distinguishes between the kernel and userspace trying to
> > + * freeze the filesystem.  Although there cannot be multiple kernel freezes or
> > + * multiple userspace freezes in effect at any given time, the kernel and
> > + * userspace can both hold a filesystem frozen.  The filesystem remains frozen
> > + * until there are no kernel or userspace freezes in effect.
> > + *
> >   * During this function, sb->s_writers.frozen goes through these values:
> >   *
> >   * SB_UNFROZEN: File system is normal, all writes progress as usual.
> > @@ -1668,12 +1676,61 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
> >   *
> >   * sb->s_writers.frozen is protected by sb->s_umount.
> >   */
> 
> There's really no point in having a kerneldoc for a static function.
> Either this moves to the actual exported functions, or it should
> become a normal non-kerneldoc comment.  But I'm not even sre this split
> makes much sense to start with.  I'd just add a the who argument
> to freeze_super given that we have only very few callers anyway,
> and it is way easier to follow than thse rappers hardoding the argument.

Agreed.

> > +static int __freeze_super(struct super_block *sb, unsigned short who)
> >  {
> > +	struct sb_writers *sbw = &sb->s_writers;
> >  	int ret;
> >  
> >  	atomic_inc(&sb->s_active);
> >  	down_write(&sb->s_umount);
> > +
> > +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> > +		switch (who) {
> 
> Nit, but maybe split evetything inside this branch into a
> freeze_frozen_super helper?

Yes, will do.  I think Jan's simplification will condense this too.

> > +static int thaw_super_locked(struct super_block *sb, unsigned short who)
> > +{
> > +	struct sb_writers *sbw = &sb->s_writers;
> >  	int error;
> >  
> > +	if (sbw->frozen == SB_FREEZE_COMPLETE) {
> > +		switch (who) {
> > +		case FREEZE_HOLDER_KERNEL:
> > +			if (!(sbw->freeze_holders & FREEZE_HOLDER_KERNEL)) {
> > +				/* Caller doesn't hold a kernel freeze. */
> > +				up_write(&sb->s_umount);
> > +				return -EINVAL;
> > +			}
> > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > +				/*
> > +				 * We were sharing the freeze with userspace,
> > +				 * so drop the userspace freeze but exit
> > +				 * without unfreezing.
> > +				 */
> > +				sbw->freeze_holders &= ~who;
> > +				up_write(&sb->s_umount);
> > +				return 0;
> > +			}
> > +			break;
> > +		case FREEZE_HOLDER_USERSPACE:
> > +			if (!(sbw->freeze_holders & FREEZE_HOLDER_USERSPACE)) {
> > +				/* Caller doesn't hold a userspace freeze. */
> > +				up_write(&sb->s_umount);
> > +				return -EINVAL;
> > +			}
> > +			if (sbw->freeze_holders & FREEZE_HOLDER_KERNEL) {
> > +				/*
> > +				 * We were sharing the freeze with the kernel,
> > +				 * so drop the kernel freeze but exit without
> > +				 * unfreezing.
> > +				 */
> > +				sbw->freeze_holders &= ~who;
> > +				up_write(&sb->s_umount);
> > +				return 0;
> > +			}
> > +			break;
> > +		default:
> > +			BUG();
> > +			up_write(&sb->s_umount);
> > +			return -EINVAL;
> > +		}
> 
> To me this screams for another 'is_partial_thaw' or so helper, whith
> which we could doe something like:
> 
> 	if (sbw->frozen != SB_FREEZE_COMPLETE) {
> 		ret = -EINVAL;
> 		goto out_unlock;
> 	}
> 	ret = is_partial_thaw(sb, who);
> 	if (ret) {
> 		if (ret == 1) {
> 			sbw->freeze_holders &= ~who;
> 			ret = 0
> 		}
> 		goto out_unlock;
> 	}

<nod>

> Btw, same comment about the wrappers as on the freeze side.

<nod>

--D
