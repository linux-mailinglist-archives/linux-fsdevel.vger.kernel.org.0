Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B731425016F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHXPtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgHXPsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598284130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UP0GmnQUZczjWQdgtPqOBVeYSbOn6bpQOH6oqkTvgaU=;
        b=VOCN4QOHFUeqxzUs+Rbndid1zUte35pZg2QIxMhUCuaOOzoTWEcX8so9s8FcB0v2LhAUXS
        J2u4+lOJXR+PXuIRxCbqpA5Ov/5N3iJsSwaIhG7/yqSrz00Th2w36mbfSOFIQtEYlOY08p
        81nBX7DKJY6D2T7omalEBqlPA0RU+Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-M8-QL4DHNVSdjwXzyLR64Q-1; Mon, 24 Aug 2020 11:48:46 -0400
X-MC-Unique: M8-QL4DHNVSdjwXzyLR64Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22D481F010;
        Mon, 24 Aug 2020 15:48:44 +0000 (UTC)
Received: from bfoster (ovpn-112-11.rdu2.redhat.com [10.10.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C930B62A13;
        Mon, 24 Aug 2020 15:48:43 +0000 (UTC)
Date:   Mon, 24 Aug 2020 11:48:41 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200824154841.GB295033@bfoster>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824150417.GA12258@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 04:04:17PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> > Do I understand the current code (__bio_try_merge_page() ->
> > page_is_mergeable()) correctly in that we're checking for physical page
> > contiguity and not necessarily requiring a new bio_vec per physical
> > page?
> 
> 
> Yes.
> 

Ok. I also realize now that this occurs on a kernel without commit
07173c3ec276 ("block: enable multipage bvecs"). That is probably a
contributing factor, but it's not clear to me whether it's feasible to
backport whatever supporting infrastructure is required for that
mechanism to work (I suspect not).

> > With regard to Dave's earlier point around seeing excessively sized bio
> > chains.. If I set up a large memory box with high dirty mem ratios and
> > do contiguous buffered overwrites over a 32GB range followed by fsync, I
> > can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> > for the entire write. If I play games with how the buffered overwrite is
> > submitted (i.e., in reverse) however, then I can occasionally reproduce
> > a ~32GB chain of ~32k bios, which I think is what leads to problems in
> > I/O completion on some systems. Granted, I don't reproduce soft lockup
> > issues on my system with that behavior, so perhaps there's more to that
> > particular issue.
> > 
> > Regardless, it seems reasonable to me to at least have a conservative
> > limit on the length of an ioend bio chain. Would anybody object to
> > iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> > if we chain something like more than 1k bios at once?
> 
> So what exactly is the problem of processing a long chain in the
> workqueue vs multiple small chains?  Maybe we need a cond_resched()
> here and there, but I don't see how we'd substantially change behavior.
> 

The immediate problem is a watchdog lockup detection in bio completion:

  NMI watchdog: Watchdog detected hard LOCKUP on cpu 25

This effectively lands at the following segment of iomap_finish_ioend():

		...
               /* walk each page on bio, ending page IO on them */
                bio_for_each_segment_all(bv, bio, iter_all)
                        iomap_finish_page_writeback(inode, bv->bv_page, error);

I suppose we could add a cond_resched(), but is that safe directly
inside of a ->bi_end_io() handler? Another option could be to dump large
chains into the completion workqueue, but we may still need to track the
length to do that. Thoughts?

Brian

