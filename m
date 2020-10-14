Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4940C28E0EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgJNNAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 09:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbgJNNAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602680400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Fws2CJAKKqpnH//6QG5i7oTf+CdCwxvrk1+FjGnC3w=;
        b=dFEmeFSiEdJ+6rQXd3P/A8jhvIdDHk2d79yMPIenhSUAcXtQ5jg2c24jQoUTBgg8bpDdmZ
        5V+RPGrvB5EdCPmexulHcTaEWDdt0BEpxMwUQmkKhxkj7lRqV4e40iMEAeAp++Nag2kwx1
        xL0vHhAnv3Ig0m9/Yb+PA04Qj1uSw/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-BAEt4dj-M3KgnMqF-8eO7Q-1; Wed, 14 Oct 2020 08:59:58 -0400
X-MC-Unique: BAEt4dj-M3KgnMqF-8eO7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3477802B4B;
        Wed, 14 Oct 2020 12:59:57 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CC4C75138;
        Wed, 14 Oct 2020 12:59:57 +0000 (UTC)
Date:   Wed, 14 Oct 2020 08:59:55 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: use page dirty state to seek data over
 unwritten extents
Message-ID: <20201014125955.GA1109375@bfoster>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-2-bfoster@redhat.com>
 <20201013225344.GA7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013225344.GA7391@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:53:44AM +1100, Dave Chinner wrote:
> On Mon, Oct 12, 2020 at 10:03:49AM -0400, Brian Foster wrote:
> > iomap seek hole/data currently uses page Uptodate state to track
> > data over unwritten extents. This is odd and unpredictable in that
> > the existence of clean pages changes behavior. For example:
> > 
> >   $ xfs_io -fc "falloc 0 32k" -c "seek -d 0" \
> > 	    -c "pread 16k 4k" -c "seek -d 0" /mnt/file
> >   Whence  Result
> >   DATA    EOF
> >   ...
> >   Whence  Result
> >   DATA    16384
> 
> I don't think there is any way around this, because the page cache
> lookup done by the seek hole/data code is an
> unlocked operation and can race with other IO and operations. That
> is, seek does not take IO serialisation locks at all so
> read/write/page faults/fallocate/etc all run concurrently with it...
> 
> i.e. we get an iomap that is current at the time the iomap_begin()
> call is made, but we don't hold any locks to stabilise that extent
> range while we do a page cache traversal looking for cached data.
> That means any region of the unwritten iomap can change state while
> we are running the page cache seek.
> 

Hm, Ok.. that makes sense..

> We cannot determine what the data contents without major overhead,
> and if we are seeking over a large unwritten extent covered by clean
> pages that then gets partially written synchronously by another
> concurrent write IO then we might trip across clean uptodate pages
> with real data in them by the time the page cache scan gets to it.
> 
> Hence the only thing we are looking at here is whether there is data
> present in the cache or not. As such, I think assuming that only
> dirty/writeback pages contain actual user data in a seek data/hole
> operation is a fundametnally incorrect premise.
> 

... but afaict this kind of thing is already possible because nothing
stops a subsequently cleaned page (i.e., dirtied and written back) from
also being dropped from cache before the scan finds it. IOW, I don't
really see how this justifies using one page state check over another as
opposed to pointing out the whole page scanning thing itself seems to be
racy. Perhaps the reasoning wrt to seek is simply that we should either
see one state (hole) or the next (data) and we don't terribly care much
about seek being racy..?

My concern is more the issue described by patch 2. Note that patch 2
doesn't necessarily depend on this one. The tradeoff without patch 1 is
just that we'd explicitly zero and dirty any uptodate new EOF page as
opposed to a page that was already dirty (or writeback).

Truncate does hold iolock/mmaplock, but ISTM that is still not
sufficient because of the same page reclaim issue mentioned above. E.g.,
a truncate down lands on a dirty page over an unwritten block,
iomap_truncate_page() receives the unwritten mapping, page is flushed
and reclaimed (changing block state), iomap_truncate_page() (still using
the unwritten mapping) has nothing to do without a page and thus stale
data is exposed.

ISTM that either the filesystem needs to be more involved with the
stabilization of unwritten mappings in general or truncate page needs to
do something along the lines of block_truncate_page() (which we used
pre-iomap) and just explicitly zero/dirty the new page if the block is
otherwise mapped. Thoughts? Other ideas?

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

