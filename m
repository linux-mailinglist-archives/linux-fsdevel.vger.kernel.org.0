Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF8595A8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiHPLrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiHPLre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:47:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE0CB5FD;
        Tue, 16 Aug 2022 04:21:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4F164371AE;
        Tue, 16 Aug 2022 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660648887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzhGbva5hBefaLpjvEShS1ChaQcEbODk+AyWbDL94nk=;
        b=ODBpoxKehExsyanPD4hEWq7HBqIK3GbfzB8Acha+rRf8eXb4DEgWQDhmMIz5ns3QcfOTdm
        DpxQHe6X7ftByvdzVGj2GMs5Uvj9cBx2iug0yVIUPFP4FAQjFP8vFtHzzXY6lk3cyre927
        gHbQ9eAI9wQY+Gjb0qoBvwIi5PpHY7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660648887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jzhGbva5hBefaLpjvEShS1ChaQcEbODk+AyWbDL94nk=;
        b=Ag4yuhOVTCeyd6nXs4Ig2CF20+PiyZSPqwumsu+pUMl+sLsp28dmDkKJ5LVHkc4YbckAFX
        al/Um3EWKBtnPLBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2DA6E2C14E;
        Tue, 16 Aug 2022 11:21:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5C254A066C; Tue, 16 Aug 2022 13:21:24 +0200 (CEST)
Date:   Tue, 16 Aug 2022 13:21:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, jlayton@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220816112124.taqvli527475gwv4@quack3>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-2-lczerner@redhat.com>
 <YvaYC+LRFqQJT0U9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvaYC+LRFqQJT0U9@sol.localdomain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-08-22 11:12:27, Eric Biggers wrote:
> On Fri, Aug 12, 2022 at 02:37:26PM +0200, Lukas Czerner wrote:
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> > index 6cd6953e175b..5d72b6ba4e63 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -274,6 +274,8 @@ or bottom half).
> >  	This is specifically for the inode itself being marked dirty,
> >  	not its data.  If the update needs to be persisted by fdatasync(),
> >  	then I_DIRTY_DATASYNC will be set in the flags argument.
> > +	If the inode has dirty timestamp and lazytime is enabled
> > +	I_DIRTY_TIME will be set in the flags.
> 
> The new sentence is not always true, since with this patch if
> __mark_inode_dirty(I_DIRTY_INODE) is called twice on an inode that has
> I_DIRTY_TIME, the second call will no longer include I_DIRTY_TIME -- even though
> the inode still has dirty timestamps.  Please be super clear about what the
> flags actually mean -- I'm still struggling to understand this patch...

Let me chime in here because I was the one who suggested the solution to
Lukas. There are two different things (which is why this is confusing I
guess):

1) I_DIRTY_TIME in the inode->i_state should mean: struct inode has times
updated after we last called ->dirty_inode() callback. Hence
inode_is_dirtytime_only() as well as the chunk:
                /* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
                flags &= ~I_DIRTY_TIME;
you mention in the previous email are compatible with this meaning AFAICT.

2) I_DIRTY_TIME flag passed to ->dirty_inode() callback. This is admittedly
bit of a hack. Currently XFS relies on the fact that the only time its
->dirty_inode() callback needs to do anything is when VFS decides it is
time to writeback timestamps and XFS detects this situation by checking for
I_DIRTY_TIME in inode->i_state. Now to fix the race, we need to first clear
I_DIRTY_TIME in inode->i_state and only then call the ->dirty_inode()
callback (otherwise timestamp update can get lost). So the solution I've
suggested was to propagate the information "timestamp update needed" to XFS
through I_DIRTY_TIME in flags passed to ->dirty_inode().

I hope things are clearer now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
