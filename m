Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17DD584DB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiG2IxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiG2IxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 357FC83F20
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659084792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=py4nC9RcneVm7rtf/qpXgPVxI4j21Dc4T3UzN7ARlTs=;
        b=bi8kTPuwaI/WmB2aRKYPylPZwiqL86bOqQ09c8ZbdAeO7zQve7iyN2jk9GR91yhHoMsE31
        m9XAB3t5Ey0pB3fKndgI67BAU9O5CVPLAaI832uXeoT/2CmhOdnPF0EzeiakbIaaOgJ8CW
        aS3WyBtqb0xT6CAbMpwXDzLnvKEk1Cc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-x79EmJKlMSOtjMGiOhz6MQ-1; Fri, 29 Jul 2022 04:52:23 -0400
X-MC-Unique: x79EmJKlMSOtjMGiOhz6MQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4FBB1C05190;
        Fri, 29 Jul 2022 08:52:22 +0000 (UTC)
Received: from fedora (unknown [10.40.194.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA925C15D4F;
        Fri, 29 Jul 2022 08:52:21 +0000 (UTC)
Date:   Fri, 29 Jul 2022 10:52:19 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220729085219.3mbn7vrrdsxvdcyf@fedora>
References: <20220728133914.49890-1-lczerner@redhat.com>
 <20220728133914.49890-2-lczerner@redhat.com>
 <20220728165332.cu2kiduob2xyvoep@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728165332.cu2kiduob2xyvoep@quack3>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 06:53:32PM +0200, Jan Kara wrote:
> On Thu 28-07-22 15:39:14, Lukas Czerner wrote:
> > Currently the I_DIRTY_TIME will never get set if the inode already has
> > I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> > true, however ext4 will only update the on-disk inode in
> > ->dirty_inode(), not on actual writeback. As a result if the inode
> > already has I_DIRTY_INODE state by the time we get to
> > __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> > into on-disk inode and will not get updated until the next I_DIRTY_INODE
> > update, which might never come if we crash or get a power failure.
> > 
> > The problem can be reproduced on ext4 by running xfstest generic/622
> > with -o iversion mount option. Fix it by setting I_DIRTY_TIME even if
> > the inode already has I_DIRTY_INODE.

Hi Jan,

thanks for th review.

> 
> As a datapoint I've checked and XFS has the very same problem as ext4.

Very interesting, I did look at xfs when I was debugging this problem
and wans't able to tell whether they have the same problem or not, but
it certainly can't be reproduced by generic/622. Or at least I can't
reproduce it on XFS.

So I wonder what is XFS doing differently in that case.

> 
> > Also clear the I_DIRTY_TIME after ->dirty_inode() otherwise it may never
> > get cleared.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  fs/fs-writeback.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 05221366a16d..174f01e6b912 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2383,6 +2383,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >  
> >  		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
> >  		flags &= ~I_DIRTY_TIME;
> > +		if (inode->i_state & I_DIRTY_TIME) {
> > +			spin_lock(&inode->i_lock);
> > +			inode->i_state &= ~I_DIRTY_TIME;
> > +			spin_unlock(&inode->i_lock);
> > +		}
> 
> Hum, so this is a bit dangerous because inode->i_state may be inconsistent
> with the writeback list inode is queued in (wb->b_dirty_time) and these two
> are supposed to be in sync. So I rather think we need to make sure we go
> through the full round of 'update flags and writeback list' below in case
> we need to clear I_DIRTY_TIME from inode->i_state.

Ok, so we're clearing I_DIRTY_TIME in __ext4_update_other_inode_time()
which will opportunistically update the time fields for inodes in the
same block as the inode we're doing an update for via
ext4_do_update_inode(). Don't we also need to rewire that differently?

XFS is also clearing it on it's own in log code, but I can't tell if it
has the same problem as you describe here.

> 
> >  	} else {
> >  		/*
> >  		 * Else it's either I_DIRTY_PAGES, I_DIRTY_TIME, or nothing.
> > @@ -2399,13 +2404,20 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> >  	 */
> >  	smp_mb();
> >  
> > -	if (((inode->i_state & flags) == flags) ||
> > -	    (dirtytime && (inode->i_state & I_DIRTY_INODE)))
> > +	if ((inode->i_state & flags) == flags)
> >  		return;
> >  
> >  	spin_lock(&inode->i_lock);
> > -	if (dirtytime && (inode->i_state & I_DIRTY_INODE))
> > +	if (dirtytime && (inode->i_state & I_DIRTY_INODE)) {
> > +		/*
> > +		 * We've got a new lazytime update. Make sure it's recorded in
> > +		 * i_state, because the time might have already got updated in
> > +		 * ->dirty_inode() and will not get updated until next
> > +		 *  I_DIRTY_INODE update.
> > +		 */
> > +		inode->i_state |= I_DIRTY_TIME;
> >  		goto out_unlock_inode;
> > +	}
> 
> So I'm afraid this combination is not properly handled in
> writeback_single_inode() where we have at the end:
> 
>         if (!(inode->i_state & I_DIRTY_ALL))
>                 inode_cgwb_move_to_attached(inode, wb);
>         else if (!(inode->i_state & I_SYNC_QUEUED) &&
>                  (inode->i_state & I_DIRTY))
>                 redirty_tail_locked(inode, wb);
> 
> So inode that had I_DIRTY_SYNC | I_DIRTY_TIME will not be properly refiled
> to wb->b_dirty_time list after writeback was done and I_DIRTY_SYNC got
> cleared.
> 
> So we need to refine it to something like:
> 
> 	if (!(inode->i_state & I_DIRTY_ALL))
> 		inode_cgwb_move_to_attached(inode, wb);
> 	else if (!(inode->i_state & I_SYNC_QUEUED)) {
> 		if (inode->i_state & I_DIRTY) {
> 			redirty_tail_locked(inode, wb);
> 		} else if (inode->i_state & I_DIRTY_TIME) {
> 			inode->dirtied_when = jiffies;
> 			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> 		}
> 	}

Very nice, thanks, I'll have a look.

-Lukas

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

