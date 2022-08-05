Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368FB58AAD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiHEMXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 08:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHEMXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01A7D31F
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659702197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XfQitbedfzAjVF7NuSHjlQLXbv3BgZJq1rQlqHH/PQ=;
        b=IlZPTxndxSVA/CizdjUBuWKiIF6lIO08dcp/DDEK7XjDG0Ku4hgJ1iuRLM87A2q4VNjbJr
        Qe1fBf9Ui4HlYYeKKm3j5M0MRZ9/PrE8sKyKEabKXw5ge+XFnkCnoBHHIh11/Z0iGjwjh4
        UqGavuY/cn8yqzx/Jy3T+Aq5Yo1Btsc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-vEsnCNv3NgqZcY_wQER0ng-1; Fri, 05 Aug 2022 08:23:13 -0400
X-MC-Unique: vEsnCNv3NgqZcY_wQER0ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C2893C138B3;
        Fri,  5 Aug 2022 12:23:10 +0000 (UTC)
Received: from fedora (unknown [10.40.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6392026D4C;
        Fri,  5 Aug 2022 12:23:08 +0000 (UTC)
Date:   Fri, 5 Aug 2022 14:23:06 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/3] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <20220805122306.anavrrmt6lqwd2yt@fedora>
References: <20220803105340.17377-1-lczerner@redhat.com>
 <20220803105340.17377-2-lczerner@redhat.com>
 <YuzPWfCuVNkmar2n@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuzPWfCuVNkmar2n@sol.localdomain>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 01:05:45AM -0700, Eric Biggers wrote:
> On Wed, Aug 03, 2022 at 12:53:39PM +0200, Lukas Czerner wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 9ad5e3520fae..2243797badf2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2245,9 +2245,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >   *			The inode itself only has dirty timestamps, and the
> >   *			lazytime mount option is enabled.  We keep track of this
> >   *			separately from I_DIRTY_SYNC in order to implement
> >   *			lazytime.  This gets cleared if I_DIRTY_INODE
> > - *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set.  I.e.
> > - *			either I_DIRTY_TIME *or* I_DIRTY_INODE can be set in
> > - *			i_state, but not both.  I_DIRTY_PAGES may still be set.
> > + *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
> > + *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
> > + *			in place.
> 
> I'm still having a hard time understanding the new semantics.  The first
> sentence above needs to be updated since I_DIRTY_TIME no longer means "the inode
> itself only has dirty timestamps", right?

The problem is that it was always assumed that I_DIRTY_INODE superseeds
I_DIRTY_TIME and so it would get cleared in __mark_inode_dirty() when we
have I_DIRTY_INODE. That's true, we call sb->s_op->dirty_inode(), the
time update gets pushed into on-disk inode structure, I_DIRTY_TIME
cleared and it will get queued for writeback.

Any subsequent dirtying with I_DIRTY_TIME gets ignored simply because
I_DIRTY_INODE is already set in i_state. But in ext4 this time update
will never get pushed into on disk inode and there is no I_DIRTY_TIME so
once the writeback is done we've lost all those I_DIRTY_TIME updates in
between even if there was a sync.

Now, we still clear I_DIRTY_TIME when we get I_DIRTY_INODE, but any
subsequent I_DIRTY_TIME only updates won't be ignored and we set it into
i_state. After the writeback is done it'll be moved to b_dirty_time
list.

So I am not sure how would you like it to be re-worded, simply removing
the 'only' would be ok?

> 
> Also, have you checked all the places that I_DIRTY_TIME is used and verified
> they do the right thing now?  What about inode_is_dirtytime_only()?

Yes, that's fine, despite the slightly misleading name ;)

> 
> Also what is the precise meaning of the flags argument to ->dirty_inode now?
> 
> 	sb->s_op->dirty_inode(inode,
> 			flags & (I_DIRTY_INODE | I_DIRTY_TIME));
> 
> Note that dirty_inode is documented in Documentation/filesystems/vfs.rst.

Don't know. It alredy don't mention I_DIRTY_SYNC that can be there as
well. Additionaly it can have I_DIRTY_TIME to inform the fs we have a
dirty timestamp as well (in case of lazytime).

Perhaps we can add:

If the inode has dirty timestamp and lazytime is enabled I_DIRTY_TIME
will be set in the flags.

-Lukas

> 
> - Eric
> 

