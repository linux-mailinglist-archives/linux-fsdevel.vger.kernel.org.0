Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BF707A10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjERGHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 02:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjERGHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 02:07:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600326B7;
        Wed, 17 May 2023 23:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8EC64D33;
        Thu, 18 May 2023 06:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93638C433EF;
        Thu, 18 May 2023 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684390039;
        bh=HK3CkWSKrQ6yuSAe8MCDAB+KCr+OL69gK1pIK4YL77g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azqGx4Few5ZCs7UrLHWvYgAZLdgH8KOoCGHPUhKF/OG+ZDirxmoT8itjNXcwiAiLM
         QLSGe4SVahQjUgnTyTxg3a7gsP+/CrUpNqiXSyYlwkfvvC6/ggqw813FXMJDYN4sp3
         y+a3h+K6c1KZSra/73Nc+1uentY2UAh6hPfHaK9j3bqRHPNV8ZDHJ5qLO+nIzAhj/j
         y9OzprkpB/Bvf9TjF6KNQ5YnyNkXtl/PorOfbgWFaJ6I7zt8RpPdI3YK+b/I0OuRdi
         kS2R8Qp09RSNj5olhbX6gnCENkg+mhfeNv4nFsllqdZ8pil5LizbJxZHAEUZapUv4P
         Wa5SVL34GQJnw==
Date:   Wed, 17 May 2023 23:07:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jan Kara <jack@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] vfs: allow filesystem freeze callers to denote who
 froze the fs
Message-ID: <20230518060718.GC11642@frogsfrogsfrogs>
References: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
 <168308293892.734377.10931394426623343285.stgit@frogsfrogsfrogs>
 <ZFc1wVFeHsi7rK01@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFc1wVFeHsi7rK01@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 06, 2023 at 10:23:13PM -0700, Luis Chamberlain wrote:
> On Tue, May 02, 2023 at 08:02:18PM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/super.c b/fs/super.c
> > index 04bc62ab7dfe..01891f9e6d5e 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1736,18 +1747,33 @@ int freeze_super(struct super_block *sb)
> >  	up_write(&sb->s_umount);
> >  	return 0;
> >  }
> > +
> > +/*
> > + * freeze_super - lock the filesystem and force it into a consistent state
> > + * @sb: the super to lock
> > + *
> > + * Syncs the super to make sure the filesystem is consistent and calls the fs's
> > + * freeze_fs.  Subsequent calls to this without first thawing the fs will return
> > + * -EBUSY.  See the comment for __freeze_super for more information.
> > + */
> > +int freeze_super(struct super_block *sb)
> > +{
> > +	return __freeze_super(sb, USERSPACE_FREEZE_COOKIE);
> > +}
> >  EXPORT_SYMBOL(freeze_super);
> >  
> > -static int thaw_super_locked(struct super_block *sb)
> > +static int thaw_super_locked(struct super_block *sb, unsigned long cookie)
> >  {
> >  	int error;
> >  
> > -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> > +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE ||
> > +	    sb->s_writers.freeze_cookie != cookie) {
> >  		up_write(&sb->s_umount);
> >  		return -EINVAL;
> 
> We get the same by just having drivers use freeze_super(sb, true) in the
> patches I have, ie, we treat it a user-initiated.
> 
> On freeze() we have:
> 
> int freeze_super(struct super_block *sb, bool usercall)                                              
> {                                                                                                    
> 	int ret;                                                                                     
> 	
> 	if(!usercall && sb_is_frozen(sb))                                                           
> 		return 0;                                                                            
> 
> 	if (!sb_is_unfrozen(sb))
> 	return -EBUSY;
> 	...
> }
> 
> On thaw we end up with:
> 
> int thaw_super(struct super_block *sb, bool usercall)
> {
> 	int error;
> 
> 	if (!usercall) {
> 		/*
> 		 * If userspace initiated the freeze don't let the kernel
> 		 *  thaw it on return from a kernel initiated freeze.
> 		 */
> 		 if (sb_is_unfrozen(sb) || sb_is_frozen_by_user(sb))
> 		 	return 0;
> 	}
> 
> 	if (!sb_is_frozen(sb))
> 		return -EINVAL;
> 	...
> }
> 
> As I had it, I had made the drivers and the bdev freeze use the usercall as
> true and so there is no change.
> 
> In case there is a filesystem already frozen then which was initiated by
> the filesystem, for whatever reason, the filesystem the kernel auto-freeze
> will chug on happy with the system freeze, it bails out withour error
> and moves on to the next filesystem to freeze.

Yes.  Your patchset has the nicer behavior that a kernel freeze isn't
preempted by userspace already having frozen the fs, but at a cost that
userspace can thaw the fs while the kernel still thinks it's frozen.

> Upon thaw, the kernel auto-thaw will detect that the filesystem was
> frozen by user on sb_is_frozen_by_user() and so will just bail and not
> thaw it.
> 
> If the mechanism you want to introduce is to allow a filesystem to even
> prevent kernel auto-freeze with -EBUSY it begs the question if that

For the scrub case, yes, we do want to block suspend because (a) we're
running metadata transactions and (b) we haven't quiesced the xfs log,
because scrub doesn't need (or want) to wait for that.  It only needs to
prevent writes, write faults, writeback, and background garbage
collection.  And it can't allow userspace to turn any of that back on.

> shouldn't also prevent suspend. Because it would anyway as you have it
> right now with your patch but it would return -EINVAL.

Huh?  With this patchset, freeze_super returns EBUSY if the fs is
frozen, no matter who froze it, or who wants to freeze it.

> I also ask because of
> the possible issues with the filesystem not going to suspend but the backing
> or other possible related devices going to suspend.

Hm.  Perhaps the freeze state needs to track one bit for userspace
freeze and another for kernel freeze.  Kernel freezes are mutually
exclusive, but they can combine with userspace freezes.  Userspace
freezes remain shared.

Kernel thaw cannot break a userspace thaw, nor can userspace thaws break
a kernel thaw.

Eh, it's late, I'll think about this more tomorrow.

> Since I think the goal is to prevent the kernel auto-freeze due to
> online fsck to complete, then I think you *do* want to prevent full
> system suspend from moving forward. In that case, why not just have
> the filesystem check for that and return -EBUSY on its respective
> filesystem sb->s_op->freeze_fs(sb) callback?

Well... either we forego the fscounters optimization, or I guess we
figure out how to take s_umount and then set a flag.

--D

>   Luis
