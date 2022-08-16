Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913DE595B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiHPMFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiHPMFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:05:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E329B6016;
        Tue, 16 Aug 2022 04:52:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 358F51FB22;
        Tue, 16 Aug 2022 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660650769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pm9H1mLMuxBifvpl8R+KWSy9XKybiqGOTBkfvvveSCQ=;
        b=GvZIDXDbsBaXWRc20mHJ8mNjye+kyz6tweEU4L7nulXRKObKoMd/ZO3S6eUI1u8BCisi8i
        dN1Zck7aU2re7joXtJSXVHm7qUeBqAW5DOppre79bN1yv5JGMdP3pZwuV8Ezcw7CqRfmop
        JO1Yp8vM5TfcGVUquDXrHk3pXTnCgwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660650769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pm9H1mLMuxBifvpl8R+KWSy9XKybiqGOTBkfvvveSCQ=;
        b=fE+IndYeWcT1MbkYhoCw1O4fFZIvHFQ1VEIZYEO/Jq32rbnRrb0fyAzhcPE2VMesnC8L/V
        dK+YX3sC9ULZAtDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D0862C149;
        Tue, 16 Aug 2022 11:52:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8D382A066C; Tue, 16 Aug 2022 13:52:48 +0200 (CEST)
Date:   Tue, 16 Aug 2022 13:52:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        ebiggers@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v3 1/3] ext4: don't increase iversion counter for
 ea_inodes
Message-ID: <20220816115248.2xj25pcays7dkrpp@quack3>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <b2e18765bc22ea851c2293c15a8aa4c3cec0fde5.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e18765bc22ea851c2293c15a8aa4c3cec0fde5.camel@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-08-22 14:42:36, Jeff Layton wrote:
> On Fri, 2022-08-12 at 14:37 +0200, Lukas Czerner wrote:
> > ea_inodes are using i_version for storing part of the reference count so
> > we really need to leave it alone.
> > 
> > The problem can be reproduced by xfstest ext4/026 when iversion is
> > enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
> > inodes in ext4_mark_iloc_dirty().
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > v2, v3: no change
> > 
> >  fs/ext4/inode.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 601214453c3a..2a220be34caa 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5731,7 +5731,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> >  	}
> >  	ext4_fc_track_inode(handle, inode);
> >  
> > -	if (IS_I_VERSION(inode))
> > +	/*
> > +	 * ea_inodes are using i_version for storing reference count, don't
> > +	 * mess with it
> > +	 */
> > +	if (IS_I_VERSION(inode) &&
> > +	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> >  		inode_inc_iversion(inode);
> >  
> >  	/* the do_update_inode consumes one bh->b_count */
> 
> 
> I've spent some time writing tests for the i_version counter (still
> quite rough right now), and what I've found is that this particular
> inode_inc_iversion results in the counter being bumped on _reads_ as
> well as writes, due to the atime changing. This call to
> inode_inc_iversion seems to make no sense, as we aren't bumping the
> mtime here.
> 
> I'm still working on and testing this, but I think we'll probably just
> want to remove this inode_inc_iversion entirely, and leave the i_version
> bumping for normal files to happen when the timestamps are updated. So
> far, my testing seems to indicate that that does the right thing.

I agree that inode_inc_iversion() may be overly agressive here but where
else does get iversion updated for things like inode owner update or
permission changes?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
