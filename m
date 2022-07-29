Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A06584DFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiG2JWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiG2JWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:22:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1F64C5;
        Fri, 29 Jul 2022 02:22:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FF2F2023D;
        Fri, 29 Jul 2022 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659086540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHzMII7PmKpSZu+Cs5j/9PDskHpu0BMOk43FfHJdKQk=;
        b=S6GKQOAhWYnzbVu0TE5UB84iqB66BKVcTXefdopftRLJHl1YcsxVp1FFj/kmuoQRfHBhEA
        09ENhhytmrZq8ess84vton5RnX1ahcB+fx8fT7XZPyFI2UR4ihGg/eMSXRu8C3xHQBakut
        3rWGSApEPPeNgt2Nrs34FTf0f4bQ8ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659086540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHzMII7PmKpSZu+Cs5j/9PDskHpu0BMOk43FfHJdKQk=;
        b=vN4nMwJbNlRYg1gyJSpj0/jFhJQeNO3vyHiQxpK0yF5FYgtBVTpgkVVlQyKtZY5id7TGUr
        4bflt3z5Qw6djRDg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E1FBA2C142;
        Fri, 29 Jul 2022 09:22:17 +0000 (UTC)
Date:   Fri, 29 Jul 2022 10:22:16 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove iomap_writepage v2
Message-ID: <20220729092216.GE3493@suse.de>
References: <20220719041311.709250-1-hch@lst.de>
 <20220728111016.uwbaywprzkzne7ib@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220728111016.uwbaywprzkzne7ib@quack3>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:10:16PM +0200, Jan Kara wrote:
> Hi Christoph!
> 
> On Tue 19-07-22 06:13:07, Christoph Hellwig wrote:
> > this series removes iomap_writepage and it's callers, following what xfs
> > has been doing for a long time.
> 
> So this effectively means "no writeback from page reclaim for these
> filesystems" AFAICT (page migration of dirty pages seems to be handled by
> iomap_migrate_page()) which is going to make life somewhat harder for
> memory reclaim when memory pressure is high enough that dirty pages are
> reaching end of the LRU list. I don't expect this to be a problem on big
> machines but it could have some undesirable effects for small ones
> (embedded, small VMs). I agree per-page writeback has been a bad idea for
> efficiency reasons for at least last 10-15 years and most filesystems
> stopped dealing with more complex situations (like block allocation) from
> ->writepage() already quite a few years ago without any bug reports AFAIK.
> So it all seems like a sensible idea from FS POV but are MM people on board
> or at least aware of this movement in the fs land?
> 
> Added a few CC's for that.
> 

There is some context missing because it's not clear what the full impact is
but it is definitly the case that writepage is ignored in some contexts for
common filesystems so lets assume that writepage from reclaim context always
failed as a worst case scenario. Certainly this type of change is something
linux-mm needs to be aware of because we've been blind-sided before.

I don't think it would be incredibly damaging although there *might* be
issues with small systems or cgroups. In many respects, vmscan has been
moving in this direction for a long time e.g. f84f6e2b0868 ("mm: vmscan:
do not writeback filesystem pages in kswapd except in high priority") and
e2be15f6c3ee ("mm: vmscan: stall page reclaim and writeback pages based on
dirty/writepage pages encountered"). This was roughly 10 years ago when
it was clear that FS writeback from reclaim context was fragile (iirc it
was partially due to concerns about stack depth and later concerns that a
filesystem would simply ignore the writeback request). There also is less
reliance on stalling reclaim by queueing and waiting on writeback but we now
should explicitly throttle if no progress is being made e.g. 69392a403f49
("mm/vmscan: throttle reclaim when no progress is being made") and some
follow-up fixes.

There still is a reliance on swap and shmem pages will not ignore writepage
but I assume that is still ok.

One potential caveat is if wakeup_flusher_threads() is ignored because
there is a reliance in reclaim that if all the pages at the tail of the
LRU are dirty pages not queued for writeback then wakeup_flusher_threads()
will do something so pages get marked for immediate reclaim when writeback
completes. Of course there is no guarantee that flusher threads will start
writeback on the old pages and the pages could be backed by a slow BDI
but wakeup_flusher_threads() should not be ignored.

Another caveat is that comments become misleading. Take for example the
comment "Only kswapd can writeback filesystem folios to avoid risk of
stack overflow." The wording should change to note that writepage may
do nothing at all.  There also might need to be some adjustment on when
pages get marked for immediate reclaim when they are dirty but not under
writeback. pageout() might need a tracepoint for "mapping->a_ops->writepage
== NULL" to help debug problems around a failure to queue pages for writback
although that could be done as a test patch for a bug.

There would need to be some changes made if writepage always or often failed
and there might be some premature throttling based on "NOPROGRESS" on small
systems due to dirty-not-writepage pages at the tail of the LRU but I don't
think it would be an immediate disaster, Reclaim throttling is no longer
based on the ability to queue for writeback or "congestion" state of BDIs
and some care is taken to not prematurely stall on NOPROGRESS. However,
if there was a bug related to premature stalls or excessive CPU usage
from direct reclaimers or kswapd that bisected to a change in writepage
then it should be fixed on the vmscan-side to put an emphasis on handling
"reclaim is in trouble when the bulk of reclaimable pages are FS-only,
dirty and not under writeback but ->writepage is a no-op".

-- 
Mel Gorman
SUSE Labs
