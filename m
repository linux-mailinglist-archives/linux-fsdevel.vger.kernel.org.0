Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4A611AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJ1TXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 15:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1TXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:23:51 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C522EC9E;
        Fri, 28 Oct 2022 12:23:50 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666985028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=NxZNy+IcQhm7mEv+x16u9ApiFgxKE6daq9Dhu2pJXuA=;
        b=QPlLtjoTqfpwdxfTXfCjX7fyoLxFyY8nTFurb3Nt8k9IN3M47Vp30x8G4pnlz+T82D8M2T
        Mewo/SlzTLrE8XjgYEiLHpRjgBp4hbOJQxwBbZmzJGJ8tLFxBJV0M5T2pQuRM6dMshFvh8
        ZsdPZyQ2pI04N/xzW0OMR1CuuOKnoOg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: bcachefs status update
Message-ID: <Y1wsQVSQ6ipWyFlX@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


New allocator
-------------

The old allocator, fundamentally unchanged from bcache had been thoroughly
outgrown and was in need of a rewrite. It kept allocation information pinned in
memory and it did periodic full scans of that aloc info to find free buckets,
which had become a real scalability issue. It was also problematic to debug,
being based around purely in-memory state with tricky locking and tricky state
transitions.

That's all been completely rewritten and replaced with new algorithms based on
new persistent data structures. The new code is simpler, vastly more scalable
(and we had users with 50 TB filesystems before), and since all state
transitions show up in the journal it's been much easier to debug.

Backpointers
------------

Backpointers are enable doing a lookup from physical device:lba to the extent
that owns that lba. There's a number of reasons filesystems might want them, but
in our context we specifically needed them to improve copygc scalability.
Before, copygc had to periodically walk the entire extents + reflink btrees; now
it just picks the next-most-empty bucket and moves all the extents it contains.

With backpointers done we're now largely done with scalability work - excepting
online fsck. We also still need to add a rebalance_work btree to fix rebalance
scanning, but that's not as serious since we never depend on rebalance for
allocations to make forward progress, but this'll be a relatively small chunk of
work.

Snapshots largely stabilized
----------------------------

Quotas don't yet work with snapshots, but aside from this all tests are passing.
There's still a few minor bugs we're trying to get reproduced, but nothing that
should affect system availability (exception: snapshot delete path still sucks,
the code to tear down the pagecache should be improved).

Erasure coding (RAID 5/6) getting close to usable
-------------------------------------------------

The codepath for deciding when to create new stripes or update an existing,
partially-empty stripe still needs to be improved.

Background: bcachefs avoids the write hole problem in other raid
implementations (by being COW), and it doesn't fragment writes like ZFS does;
stripes are big (which we want for avoiding fragmentation), and they're created
on demand out of physical buckets on different devices.

Foreground writes are initially replicated, then when we accumulate a full
stripe we write out p+q blocks and update extents in the stripe with the stripe
information and drop the now unnneeded replicas. The buckets containing the
extra replicas will get reused right away, so if we don't have to send a cache
flush before they're overwritten with something else they only cost bus
bandwidth.

As data gets overwritten, or moved by copygc, we'll end up with some of the
buckets in a stripe becoming empty. The stripe creation path has the ability to
create a new stripe using the buckets that still contain live data in an
existing stripe - but it's more efficient in terms of IO to create new stripes
if the data in an existing stripe is going to die at some point in the future -
OTOH it requires more disk space.

Once this logic is figured out, erasure coding should be pretty close to ready.

Lock cycle detector
-------------------

We'd outgrown the old deadlock avoidance strategy: before blocking on a lock
we'd check for lock ordering violation, and if necessary issue a transaction
restart which would re-traverse iterators in the correct order. The lock
ordering rules had become too complicated and this was getting us too many
transaction restarts, so I stole the standard technique from databases, which is
now working beautifully - transaction restarts due to deadlock are a tiny
fraction of what they were before.

Performance work
----------------

We now have _lots_ of persistent counters, including for transaction restarts
(of every type), and every slowpath - and, the automated tests now check these
counters at the end of every test, and fail the test if any of them were too
high.

And, thanks to a lot of miscellaneous performance work, our 4k O_DIRECT random
write performance is now > 50% better than it was a few months ago.

Automated test infrastructure!
------------------------------

I finally built the CI I always wanted: you point it at a git branch and it runs
tests and gives you the results in a git log view. See it in action here:

https://evilpiepirate.org/~testdashboard/ci?log=bcachefs/master

Since then I've been putting a ton of time into grinding through bugs, and the
the new test dashboard has been amazing for tracking down regressions.

There's not much more work planned prior to upstreaming: on disk format changes
have slowed down considerably. I just revved the on disk format version to
introduce a new inode format (which doesn't varint encode i_sectors or i_size,
which makes the data write path faster), and I'm going to _attempt_ to expand
the u64s field of struct bkey from one byte to two, but other than that -
nothing big expected for awhile.

I also just gave a talk to RH staff - lots of good stuff in there:
https://bcachefs.org/bcachefs_talk_2022_10.mpv

Cheers, and thanks for reading
Kent
