Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7A7289F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjFHVKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHVKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD82D74;
        Thu,  8 Jun 2023 14:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB9B65113;
        Thu,  8 Jun 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F18DC433EF;
        Thu,  8 Jun 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686258621;
        bh=XViKg2onIRHkaR3bxOXk8HIsG3cq5Z9NWQifOKWD3uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrJNZN5vy4gUdsAb2fVJYPtTm+RrjguGIHksArF3V9UpzQ7/QYzdfe0ICwJLm7HhK
         l/zCXRPqx9SlpEncrcdmXvVGmJuPekXlw7MZEiatQHSfHRZeNzM5Z5HhMGzyBYMjXt
         MytLC1WfZVKClLuBonar3ZSzZnczZ6aBS+mGZ/LlaLrQW9mKPYzp92qrfGcXc+oh2s
         dXBrugaDDr/XAhdowf3X6/pBBhA+TKsZ7WoIkAk3X7FZDzxsoRUXsOnVWPRFrn7EuL
         v9N6ftiiqlvheEFmC56yYACeLIgbfCOnnb0MKvJNLkkVQ8K56SQISzHcVVIHOh09X0
         Qm3Nzvz8YHyHQ==
Date:   Thu, 8 Jun 2023 14:10:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, sandeen@sandeen.net, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: distinguish between user initiated freeze and
 kernel initiated freeze
Message-ID: <20230608211020.GH72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-4-mcgrof@kernel.org>
 <20230522234200.GC11598@frogsfrogsfrogs>
 <ZII5awqVCr9IUWtH@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZII5awqVCr9IUWtH@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:26:19PM -0700, Luis Chamberlain wrote:
> On Mon, May 22, 2023 at 04:42:00PM -0700, Darrick J. Wong wrote:
> > How about this as an alternative patch?
> 
> I'm all for it, this is low hanging fruit and I try to get back to it
> as no one else does, so I'm glad someone else is looking and trying too!
> 
> Hopefully dropping patch 1 and 2 would help with this.
> 
> Comments below.
> 
> > From: Darrick J. Wong <djwong@kernel.org>
> > Subject: fs: distinguish between user initiated freeze and kernel initiated freeze
> > 
> > Userspace can freeze a filesystem using the FIFREEZE ioctl or by
> > suspending the block device; this state persists until userspace thaws
> > the filesystem with the FITHAW ioctl or resuming the block device.
> > Since commit 18e9e5104fcd ("Introduce freeze_super and thaw_super for
> > the fsfreeze ioctl") we only allow the first freeze command to succeed.
> > 
> > The kernel may decide that it is necessary to freeze a filesystem for
> > its own internal purposes, such as suspends in progress, filesystem fsck
> > activities, or quiescing a device prior to removal.  Userspace thaw
> > commands must never break a kernel freeze, and kernel thaw commands
> > shouldn't undo userspace's freeze command.
> > 
> > Introduce a couple of freeze holder flags and wire it into the
> > sb_writers state.  One kernel and one userspace freeze are allowed to
> > coexist at the same time; the filesystem will not thaw until both are
> > lifted.
> 
> This mix-match stuff is also important to document so we can get
> userspace to understand what is allowed and we get a sense of direction
> written / documented. Without this trying to navigate around this is
> all implied. We may need to adjust things with time for thing we may
> not have considered.

That's captured in the kernledoc for freeze_super, which is no longer
getting cut up into __freeze_super here.

> > -int freeze_super(struct super_block *sb)
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
> <-- snip -->
> 
> > +		case FREEZE_HOLDER_USERSPACE:
> > +			if (sbw->freeze_holders & FREEZE_HOLDER_USERSPACE) {
> > +				/*
> > +				 * Userspace freeze already in effect; tell
> > +				 * the caller we're busy.
> > +				 */
> > +				deactivate_locked_super(sb);
> > +				return -EBUSY;
> 
> I'm thinking some userspace might find this OK so thought maybe
> something like -EALREADY would be better, to then allow userspace
> to decide, however, since userspace would not control the thaw it
> seems like risky business to support that.

It already has to, since we've been returning EBUSY for "fs already
frozen or being frozen" for years.

--D

> Anyway, I'm all for any alternative!
> 
>   Luis
