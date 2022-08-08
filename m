Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265058C654
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbiHHK0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 06:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiHHK0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAB9AEBA
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659954374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdXQa3jk2tERG3z0xEmPh3dxhv9AB24nx7bC8R2QZ+M=;
        b=e0Knku5rtRYbjtWVHOi6i7VBBWcsgRIR4CQ/F1u7e6xEFz2G9ZTRxWiyL5/uTMND8uxE46
        EK9dmeiaXAEC7DkJUj4V+Prc2CFj1wWiFEoKnBJTncoRHS3PG8oVcCzr6ZIWeyqj1rgc/3
        e0i7SsVWrSLe/7Lp9IUdM58Yqg/78pI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-c696xEXwMfeok6kgVayt9g-1; Mon, 08 Aug 2022 06:26:11 -0400
X-MC-Unique: c696xEXwMfeok6kgVayt9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39B6E108C0DE;
        Mon,  8 Aug 2022 10:26:09 +0000 (UTC)
Received: from fedora (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B78B40C1241;
        Mon,  8 Aug 2022 10:26:07 +0000 (UTC)
Date:   Mon, 8 Aug 2022 12:26:05 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220808102605.racoct6amqn55uqc@fedora>
References: <20220803105340.17377-1-lczerner@redhat.com>
 <20220803105340.17377-2-lczerner@redhat.com>
 <20220807230810.GF3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807230810.GF3861211@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 09:08:10AM +1000, Dave Chinner wrote:
> On Wed, Aug 03, 2022 at 12:53:39PM +0200, Lukas Czerner wrote:
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
> > ---
> > v2: Reworked according to suggestions from Jan
> 
> ....
> 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index aa977c7ea370..cff05a4771b5 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -658,7 +658,8 @@ xfs_fs_dirty_inode(
> >  
> >  	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
> >  		return;
> > -	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
> > +	if ((flag & ~I_DIRTY_TIME) != I_DIRTY_SYNC ||
> > +	    !((inode->i_state | flag) & I_DIRTY_TIME))
> >  		return;
> 
> My eyes, they bleed. The dirty time code was already a horrid
> abomination, and this makes it worse.
> 
> From looking at the code, I cannot work out what the new semantics
> for I_DIRTY_TIME and I_DIRTY_SYNC are supposed to be, nor can I work

Hi Dave,

please see the other thready for this patch with Eric Biggers, where I
try to explain and give some suggestion to change the doc. Does it make
sense to you, or am I missing something?

https://marc.info/?l=linux-ext4&m=165970194205621&w=2

> out what the condition this is new code is supposed to be doing. I
> *can't verify it is correct* by reading the code.

The ->dirty_inode() needed to be changed to clear I_DIRTY_TIME from
i_state *before* we call ->dirty_inode() to avoid race where we would
lose timestamp update that comes just a little later, after
-dirty_inode() call with I_DRITY_INODE.

But that would break xfs, so I decided to keep the condition and loosen
the requirement so that I_DIRTY_TIME can also be se in 'flag', not just
the i_state. Hence the abomination.

> 
> Can you please add a comment here explaining the conditions where we
> don't have to log a new timestamp update?

How about something like this?

Only do the timestamp update if the inode is dirty (I_DIRTY_SYNC) and
has dirty timestamp (I_DIRTY_TIME). I_DIRTY_TIME can be either already
set in i_state, or passed in flags possibly together with I_DIRTY_SYNC.

> 
> Also, if "flag" now contains multiple flags, can you rename it
> "flags"?

Sure, I can do that.

Thanks!
-Lukas

> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

