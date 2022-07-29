Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E42584F70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiG2LSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiG2LSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:18:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C57FE5C;
        Fri, 29 Jul 2022 04:18:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E2CE348CD;
        Fri, 29 Jul 2022 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659093521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/lKSasX/1DXxqiFOXKfLbZqYgAxcwzKDEqTPp4vlLI=;
        b=hSkt98MfuKeYQ34uvxjmVWKf3aIX/CXMjWnGpzWnonSuTTd9Nl7N943ab1tvvIlWwfakG2
        7lRwVbnEP1BQyT9tN6/A6GZPYxS7q7iosXOOiDyKdKiLTiVabarZwS/ucU3henoqD6FKnQ
        HIb1yXfh5EZzJpmBqaoIAtsvaPMBJYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659093521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/lKSasX/1DXxqiFOXKfLbZqYgAxcwzKDEqTPp4vlLI=;
        b=TE79SUG6iJSZkpd8YOKuNPS5SkKKA2+NsnFsQmN/PDG3q0dgHBgSaFNGndw1ztJnxdnqS7
        jvjU1q+pHMMzKPBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B2782C141;
        Fri, 29 Jul 2022 11:18:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 898B3A0666; Fri, 29 Jul 2022 13:18:40 +0200 (CEST)
Date:   Fri, 29 Jul 2022 13:18:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        jlayton@kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220729111840.a7qmh3vjtr662tvx@quack3>
References: <20220728133914.49890-1-lczerner@redhat.com>
 <20220728133914.49890-2-lczerner@redhat.com>
 <20220728165332.cu2kiduob2xyvoep@quack3>
 <20220729085219.3mbn7vrrdsxvdcyf@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729085219.3mbn7vrrdsxvdcyf@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-07-22 10:52:19, Lukas Czerner wrote:
> On Thu, Jul 28, 2022 at 06:53:32PM +0200, Jan Kara wrote:
> > On Thu 28-07-22 15:39:14, Lukas Czerner wrote:
> > > Currently the I_DIRTY_TIME will never get set if the inode already has
> > > I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> > > true, however ext4 will only update the on-disk inode in
> > > ->dirty_inode(), not on actual writeback. As a result if the inode
> > > already has I_DIRTY_INODE state by the time we get to
> > > __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> > > into on-disk inode and will not get updated until the next I_DIRTY_INODE
> > > update, which might never come if we crash or get a power failure.
> > > 
> > > The problem can be reproduced on ext4 by running xfstest generic/622
> > > with -o iversion mount option. Fix it by setting I_DIRTY_TIME even if
> > > the inode already has I_DIRTY_INODE.
> 
> Hi Jan,
> 
> thanks for th review.
> 
> > 
> > As a datapoint I've checked and XFS has the very same problem as ext4.
> 
> Very interesting, I did look at xfs when I was debugging this problem
> and wans't able to tell whether they have the same problem or not, but
> it certainly can't be reproduced by generic/622. Or at least I can't
> reproduce it on XFS.
> 
> So I wonder what is XFS doing differently in that case.

OK, that's a bit curious but xfs has xfs_fs_dirty_inode() that's there
exactly to update timestamps when lazytime period expires. So in theory it
seems possible we lose the timestamp update.

> > > Also clear the I_DIRTY_TIME after ->dirty_inode() otherwise it may never
> > > get cleared.
> > > 
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > ---
> > >  fs/fs-writeback.c | 18 +++++++++++++++---
> > >  1 file changed, 15 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 05221366a16d..174f01e6b912 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -2383,6 +2383,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
> > >  
> > >  		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
> > >  		flags &= ~I_DIRTY_TIME;
> > > +		if (inode->i_state & I_DIRTY_TIME) {
> > > +			spin_lock(&inode->i_lock);
> > > +			inode->i_state &= ~I_DIRTY_TIME;
> > > +			spin_unlock(&inode->i_lock);
> > > +		}
> > 
> > Hum, so this is a bit dangerous because inode->i_state may be inconsistent
> > with the writeback list inode is queued in (wb->b_dirty_time) and these two
> > are supposed to be in sync. So I rather think we need to make sure we go
> > through the full round of 'update flags and writeback list' below in case
> > we need to clear I_DIRTY_TIME from inode->i_state.
> 
> Ok, so we're clearing I_DIRTY_TIME in __ext4_update_other_inode_time()
> which will opportunistically update the time fields for inodes in the
> same block as the inode we're doing an update for via
> ext4_do_update_inode(). Don't we also need to rewire that differently?
> 
> XFS is also clearing it on it's own in log code, but I can't tell if it
> has the same problem as you describe here.

Yes, we'll possibly have clean inodes still on wb->b_dirty_time list.
Checking the code, this should be safe in the end.

But thinking more about the possible races these two places clearing
I_DIRTY_TIME are safe because we copy timestamps to on-disk inode after
clearing I_DIRTY_TIME. But your clearing of I_DIRTY_TIME in
__mark_inode_dirty() could result in loosing timestamp update if it races
in the wrong way (basically the bug you're trying to fix would remain
unfixed).

Hum, thinking about it, even clearing of I_DIRTY_TIME later in
__mark_inode_dirty is problematic. There is still a race like:

CPU1					CPU2
					__mark_inode_dirty(inode, I_DIRTY_TIME)
					  sets I_DIRTY_TIME in inode->i_state

__mark_inode_dirty(inode, I_DIRTY_SYNC)
  ->dirty_inode() - copies timestamps

					__mark_inode_dirty(inode, I_DIRTY_TIME)
					  I_DIRTY_TIME already set -> bail
  ...
  if (flags & I_DIRTY_INODE)
    inode->i_state &= ~I_DIRTY_TIME;

and we have just lost the second timestamp update.

To fix this we'd need to clear I_DIRTY_TIME in inode->i_state before
calling ->dirty_inode() but that clashes with XFS' usage of ->dirty_inode
which uses I_DIRTY_TIME in inode->i_state to detect that timestamp update
is requested. I think we could do something like:

	if (flags & I_DIRTY_INODE) {
		/* Inode timestamp update will piggback on this dirtying */
		if (inode->i_state & I_DIRTY_TIME) {
			spin_lock(&inode->i_lock);
			if (inode->i_state & I_DIRTY_TIME) {
				inode->i_state &= ~I_DIRTY_TIME;
				flags |= I_DIRTY_TIME;
			}
			spin_unlock(&inode->i_lock);
		}
		...
		if (sb->s_op->dirty_inode)
			sb->s_op->dirty_inode(inode,
				flags & (I_DIRTY_INODE | I_DIRTY_TIME));
		...
	}

And then XFS could check for I_DIRTY_TIME in flags to detect what it needs
to do.

Hopefully now things are correct ;). Famous last words...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
