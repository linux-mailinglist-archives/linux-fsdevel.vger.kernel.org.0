Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D74595B04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiHPL6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiHPL6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:58:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4417074;
        Tue, 16 Aug 2022 04:41:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 47A4134E59;
        Tue, 16 Aug 2022 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660650080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGB06ZyirLByT/J4O+VTvoN/lP4JtvsZMfjQ3RxIuEg=;
        b=lXwflhH7gpOeDTmu5AlqmwFNd04l4Iwh0e9r1F8nr5NQMU7sW4Q3w7iY35lsQuDNw3794y
        RH9jeS8w+pB9QHGmr1sXh1e5gY5K02jmakVCRvOFPbhPmyV/TN7ZnHH+bbqgk9ZfRcZEa6
        YzZpQ2dlOydJ33lcMpl8Di0ghho670c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660650080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGB06ZyirLByT/J4O+VTvoN/lP4JtvsZMfjQ3RxIuEg=;
        b=+7afhtIWxEEYKy3+PI2c5RzyudU0acLEFzCblzAV+DvFi48kEe/yh/hq2iW3WpNQ/bLyW/
        VB5szXObSfAfATAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 302292C149;
        Tue, 16 Aug 2022 11:41:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CEBFEA066C; Tue, 16 Aug 2022 13:41:19 +0200 (CEST)
Date:   Tue, 16 Aug 2022 13:41:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, jlayton@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220816114119.d32uhdvmjfa7aywo@quack3>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-2-lczerner@redhat.com>
 <YvafDTI544HpvpWu@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvafDTI544HpvpWu@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-08-22 11:42:21, Eric Biggers wrote:
> On Fri, Aug 12, 2022 at 02:37:26PM +0200, Lukas Czerner wrote:
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
> > with -o iversion mount option.
> > 
> > Fix it by allowing I_DIRTY_TIME to be set even if the inode already has
> > I_DIRTY_INODE. Also make sure that the case is properly handled in
> > writeback_single_inode() as well. Additionally changes in
> > xfs_fs_dirty_inode() was made to accommodate for I_DIRTY_TIME in flag.
> > 
> > Thanks Jan Kara for suggestions on how to make this work properly.
> > 
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Suggested-by: Jan Kara <jack@suse.cz>
> 
> Sorry for so many separate emails.  One more thought: isn't there a much more
> straightforward fix to this bug that wouldn't require changing the semantics of
> the inode flags: on __mark_inode_dirty(I_DIRTY_TIME), if the inode already has
> i_state & I_DIRTY_INODE, just call ->dirty_inode with i_state & I_DIRTY_INODE?
> That would fix the bug by making the filesystem update the on-disk inode.

This is a good question and I was also considering this when we first
discussed the problem with Lukas. It should fix the bug for ext4 but
eventually I've decided against this because XFS would still need something
else to fix the problem (see my previous email) and for ext4 it seemed as
unnecessary overhead (see below).

> Perhaps you aren't doing that in order to strictly maintain the semantics of
> 'lazytime', where timestamp updates are only persisted at certain times?  Is
> this useful even in the short window of time that an inode is dirty?

The result of this for ext4 will be that after the inode is dirtied for
some reason, we will be logging every timestamp update to the journal
(effectively disabling lazytime for the inode) for the 30s time window that
the inode stays dirty before writeback code decides to do writeback (which
just results in clearing the I_DIRTY_INODE flag for ext4). Not too bad I
guess but I'd prefer to avoid this overhead.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
