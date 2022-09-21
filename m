Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3041E5BF93F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIUIaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIUIaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:30:09 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4273312757;
        Wed, 21 Sep 2022 01:30:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3F5928A9AB5;
        Wed, 21 Sep 2022 18:30:05 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oav7M-00AKcw-El; Wed, 21 Sep 2022 18:30:04 +1000
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oav7M-005vTU-1H;
        Wed, 21 Sep 2022 18:30:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/2] iomap/xfs: fix data corruption due to stale cached iomaps
Date:   Wed, 21 Sep 2022 18:29:57 +1000
Message-Id: <20220921082959.1411675-1-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=632acb8e
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=Xa1MfhOgUTu0s-797qAA:9
        a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

THese patches address the data corruption first described here:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

This data corruption has been seen in high profile production
systems so there is some urgency to fix it. The underlying flaw is
essentially a zero-day iomap bug, so whatever fix we come up with
needs to be back portable to all supported stable kernels (i.e.
~4.18 onwards).

A combination of concurrent write()s, writeback IO completion, and
memory reclaim combine to expose the fact that the cached iomap that
is held across an iomap_begin/iomap_end iteration can become stale
without the iomap iterator actor being aware that the underlying
filesystem extent map has changed.

Hence actions based on the iomap state (e.g. is unwritten or newly
allocated) may actually be incorrect as writeback actions may have
changed the state (unwritten to written, delalloc to unwritten or
written, etc). This affects partial block/page operations, where we
may need to read from disk or zero cached pages depending on the
actual extent state. Memory reclaim plays it's part here in that it
removes pages containing partial state from the page cache, exposing
future partial page/block operations to incorrect behaviour.

Really, we should have known that this would be a problem - we have
exactly the same issue with cached iomaps for writeback, and the
->map_blocks callback that occurs for every filesystem block we need
to write back is responsible for validating the cached iomap is
still valid. The data corruption on the write() side is a result of
not validating that the iomap is still valid before we initialise
new pages and prepare them for data to be copied in to them....

I'm not really happy with the solution I have for triggering
remapping of an iomap when the current one is considered stale.
Doing the right thing requires both iomap_iter() to handle stale
iomaps correctly (esp. the "map is invalid before the first actor
operation" case), and it requires the filesystem
iomap_begin/iomap_end operations to co-operate and be aware of stale
iomaps.

There are a bunch of *nasty* issues around handling failed writes in
XFS taht this has exposed - a failed write() that races with a
mmap() based write to the same delalloc page will result in the mmap
writes being silently lost if we punch out the delalloc range we
allocated but didn't write to. g/344 and g/346 expose this bug
directly if we punch out delalloc regions allocated by now stale
mappings.

Then, because we can't punch out the delalloc we allocated region
safely when we have a stale iomap, we have to ensure when we remap
it the IOMAP_F_NEW flag is preserved so that the iomap code knows
that it is uninitialised space that is being written into so it will
zero sub page/sub block ranges correctly.

As a result, ->iomap_begin() needs to know if the previous iomap was
IOMAP_F_STALE, and if so, it needs to know if that previous iomap
was IOMAP_F_NEW so it can propagate it to the remap.

So the fix is awful, messy, and I really, really don't like it. But
I don't have any better ideas right now, and the changes as
presented fix the reproducer for the original data corruption and
pass fstests without and XFS regressions for block size <= page size
configurations.

Thoughts?

-Dave.


