Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BBA72CF36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjFLTRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbjFLTQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:16:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE319A8;
        Mon, 12 Jun 2023 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5iMzfKYGoYXJMs2DvECMAgUC6fthexzcIdFRLPC12J4=; b=hSzhdzlulH509idd6KUif5hPgE
        9NvEAxYZBp6QEgZ0c5iuKQ3ur2MnoHmENFfrVv9eAzDF5P2ix2OdGCwUc8nLYPK94NialjEcd8BgX
        ILnagqNg3/b+s7Ehkj+RdSSHhmHqgHUY2z1U7dOKpLzytBQLqWrgPVfEGnkyPnCt/mQL1LgtM9NPo
        VRb/reQIKd+ahh7ZMENO1jcwSQqkAkZiaoz2+5cAveXAISOHJbcMtVgnFyhepHdo2B0FiljZlacR2
        9LkXl/yqjQfPfG8ppD/B5Ppe2lpcZpUUbjFks/YjMZHBFjvOI+kWHqsybmtqBW0aj2yMQRQp8ViDK
        4KQzwlTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8n24-002y1T-Mh; Mon, 12 Jun 2023 19:16:52 +0000
Date:   Mon, 12 Jun 2023 20:16:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from
 mpage_submit_folio
Message-ID: <ZIdvJLE945Qbzy+H@casper.infradead.org>
References: <ZIdZKSLidg1o89qX@casper.infradead.org>
 <87352w7d1o.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87352w7d1o.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:55:55PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> I couldn't respond to your change because I still had some confusion
> around this suggestion - 
> 
> > So do we care if we write a random fragment of a page after a truncate?
> > If so, we should add:
> > 
> >         if (folio_pos(folio) >= size)
> >                 return 0; /* Do we need to account nr_to_write? */
> 
> I was not sure whether if go with above case then whether it will
> work with collapse_range. I initially thought that collapse_range will
> truncate the pages between start and end of the file and then
> it can also reduce the inode->i_size. That means writeback can find an
> inode->i_size smaller than folio_pos(folio) which it is writing to.
> But in this case we can't skip the write in writeback case like above
> because that write is still required (a spurious write) even though
> i_size is reduced as it's corresponding FS blocks are not truncated.
> 
> But just now looking at ext4_collapse_range() code it doesn't look like
> it is the problem because it waits for any dirty data to be written
> before truncate. So no matter which folio_pos(folio) the writeback is
> writing, there should not be an issue if we simply return 0 like how
> you suggested above.
> 
>     static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
> 
>     <...>
>         ioffset = round_down(offset, PAGE_SIZE);
>         /*
>         * Write tail of the last page before removed range since it will get
>         * removed from the page cache below.
>         */
> 
>         ret = filemap_write_and_wait_range(mapping, ioffset, offset);
>         if (ret)
>             goto out_mmap;
>         /*
>         * Write data that will be shifted to preserve them when discarding
>         * page cache below. We are also protected from pages becoming dirty
>         * by i_rwsem and invalidate_lock.
>         */
>         ret = filemap_write_and_wait_range(mapping, offset + len,
>                         LLONG_MAX);
>         truncate_pagecache(inode, ioffset);
> 
>         <... within i_data_sem>
>         i_size_write(inode, new_size);
> 
>     <...>
> 
> 
> However to avoid problems like this I felt, I will do some more code
> reading. And then I was mostly considering your second suggestion which
> is this. This will ensure we keep the current behavior as is and not
> change that.
> 
> > If we simply don't care that we're doing a spurious write, then we can
> > do something like:
> > 
> > -               len = size & ~PAGE_MASK;
> > +               len = size & (len - 1);

For all I know, I've found a bug here.  I don't know enough about ext4; if
we have truncated a file, and then writeback a page that is past i_size,
will the block its writing to have been freed?  Is this potentially a
silent data corruptor?
