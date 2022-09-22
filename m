Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C15E5A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 06:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiIVEZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 00:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIVEZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F997D50;
        Wed, 21 Sep 2022 21:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C81766339B;
        Thu, 22 Sep 2022 04:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28344C433D6;
        Thu, 22 Sep 2022 04:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663820727;
        bh=fhxb9Ujouso7mvKXcXZZreR1NM0VJLISASIaPz93N8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWtqiZ0YbFW4yNaCEOkZvlHlWyp89VGLQu48e1x1Lrn3VGGdEqhOn/soLInZNDFU6
         g5XCPETAaaLw46iY7H6Lau/qhxAQy9r+hU/s/ekk4qFWEV4gujt4Jk3+vVnaFVsgvB
         J5681NXALapd2gfO+aw1Ddq9hAXu/56+8lfDaiP1XyM+viTashCOwA7nr1Ecm4gb6h
         rBLDll9h4PgREJlpIBlMh/TCZ+M6dgV/uIZAWUBpKxgvHSkKlCqP0IFWyQQAKo7wpi
         LjU6CpdQy28VHJ9Sc6Ym6+S5dGtI0GsxRM/7HzYq6tpyx19/LItOiYawDaJz9NAkJt
         sDLT4QRDInPvw==
Date:   Wed, 21 Sep 2022 21:25:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iomap/xfs: fix data corruption due to stale
 cached iomaps
Message-ID: <Yyvjtpi49YSUej+w@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921082959.1411675-1-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 06:29:57PM +1000, Dave Chinner wrote:
> Hi folks,
> 
> THese patches address the data corruption first described here:
> 
> https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> 
> This data corruption has been seen in high profile production
> systems so there is some urgency to fix it. The underlying flaw is
> essentially a zero-day iomap bug, so whatever fix we come up with
> needs to be back portable to all supported stable kernels (i.e.
> ~4.18 onwards).
> 
> A combination of concurrent write()s, writeback IO completion, and
> memory reclaim combine to expose the fact that the cached iomap that
> is held across an iomap_begin/iomap_end iteration can become stale
> without the iomap iterator actor being aware that the underlying
> filesystem extent map has changed.
> 
> Hence actions based on the iomap state (e.g. is unwritten or newly
> allocated) may actually be incorrect as writeback actions may have
> changed the state (unwritten to written, delalloc to unwritten or
> written, etc). This affects partial block/page operations, where we
> may need to read from disk or zero cached pages depending on the
> actual extent state. Memory reclaim plays it's part here in that it
> removes pages containing partial state from the page cache, exposing
> future partial page/block operations to incorrect behaviour.
> 
> Really, we should have known that this would be a problem - we have
> exactly the same issue with cached iomaps for writeback, and the
> ->map_blocks callback that occurs for every filesystem block we need
> to write back is responsible for validating the cached iomap is
> still valid. The data corruption on the write() side is a result of
> not validating that the iomap is still valid before we initialise
> new pages and prepare them for data to be copied in to them....
> 
> I'm not really happy with the solution I have for triggering
> remapping of an iomap when the current one is considered stale.
> Doing the right thing requires both iomap_iter() to handle stale
> iomaps correctly (esp. the "map is invalid before the first actor
> operation" case), and it requires the filesystem
> iomap_begin/iomap_end operations to co-operate and be aware of stale
> iomaps.
> 
> There are a bunch of *nasty* issues around handling failed writes in
> XFS taht this has exposed - a failed write() that races with a
> mmap() based write to the same delalloc page will result in the mmap
> writes being silently lost if we punch out the delalloc range we
> allocated but didn't write to. g/344 and g/346 expose this bug
> directly if we punch out delalloc regions allocated by now stale
> mappings.

Yuck.  I'm pretty sure that callers (xfs_buffered_write_iomap_end) is
supposed to call truncate_pagecache_range with the invalidatelock (fka
MMAPLOCK) held.

> Then, because we can't punch out the delalloc we allocated region
> safely when we have a stale iomap, we have to ensure when we remap
> it the IOMAP_F_NEW flag is preserved so that the iomap code knows
> that it is uninitialised space that is being written into so it will
> zero sub page/sub block ranges correctly.

Hm.  IOMAP_F_NEW results in zeroing around, right?  So if the first
->iomap_begin got a delalloc mapping, but by the time we got the folio
locked someone else managed to writeback and evict the page, we'd no
longer want that zeroing ... right?

> As a result, ->iomap_begin() needs to know if the previous iomap was
> IOMAP_F_STALE, and if so, it needs to know if that previous iomap
> was IOMAP_F_NEW so it can propagate it to the remap.
> 
> So the fix is awful, messy, and I really, really don't like it. But
> I don't have any better ideas right now, and the changes as
> presented fix the reproducer for the original data corruption and
> pass fstests without and XFS regressions for block size <= page size
> configurations.
> 
> Thoughts?

I have a related question about another potential corruption vector in
writeback.  If write_cache_pages selects a folio for writeback, it'll
call clear_page_dirty_for_io to clear the PageDirty bit before handing
it to iomap_writepage, right?

What happens if iomap_writepage_map errors out (say because ->map_blocks
returns an error) without adding the folio to any ioend?  I think in
that case we'll follow the (error && !count) case, in which we unlock
the folio and exit without calling folio_redirty_for_writepage, right?
The error will get recorded in the mapping for the next fsync, I think,
but I also wonder if we *should* redirty because the mapping failed, not
the attempt at persistence.

This isn't a problem for XFS because the next buffered write will mark
the page dirty again, but I've been trawling through the iomap buffer
head code (because right now we have a serious customer escalation on
4.14) and I noticed that we never clear the dirty state on the buffer
heads.  gfs2 is the only user of iomap buffer head code, but that stands
out as something that doesn't quite smell right.  I /think/ this is a
result of XFS dropping buffer heads in 4.19, hoisting the writeback
framework to fs/iomap/ in 5.5, and only adding buffer heads back to
iomap later.

The reason I even noticed this at all is because of what 4.14 does --
back in those days, initiating writeback on a page clears the dirty
bit from the attached buffer heads in xfs_start_buffer_writeback.  If
xfs_writepage_map fails to initiate any writeback IO at all, then it
simply unlocks the page and exits without redirtying the page.  IOWs, it
causes the page and buffer head state to become inconsistent, because
now the page thinks it is clean but the BHs think they are dirty.

Worse yet, if userspace responds to the EIO by reissuing the write()
calls, the write code will see BH_Dirty set on the buffer and doesn't
even try to set PageDirty, which means ... that the page never gets
written to disk again!

There are three questions in my mind:

A. Upstream iomap writeback code doesn't change (AFAICT) the buffer head
dirty state.  I don't know if this is really broken?  Or maybe gfs2 just
doesn't notice or care?

B. Should writeback be redirtying any folios that aren't added to an
ioend?  I'm not sure that doing so is correct, since writeback to a
shutdown filesystem won't clear the dirty pages.

C. Gotta figure out why our 4.14 kernel doesn't initiate writeback.
At this point we're pretty sure it's because we're actually hitting the
same RCA as commit d9252d526ba6 ("xfs: validate writeback mapping using
data fork seq counter").  Given the (stale) data it has, it never
manages to get a valid mapping, and just... exits xfs_map_blocks without
doing anything.

--D

> -Dave.
> 
> 
