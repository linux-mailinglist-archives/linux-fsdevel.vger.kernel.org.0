Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A63628F4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKOBba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiKOBbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:31:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5D634E
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id io19so11753490plb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5N43iYmA9gOqNH26g6U8tPSlRYbFsMmkcbybRtbhv4Q=;
        b=acLdmTWbI5zgaJ6Ok/t8arfyQ4I/c0j7IeNJZzq6tGKNv11iGyOLUqF8YCxyn4uozI
         Z0BpF88y43ejIwK4pL6xe2mxlyzCVf4Tpq5Q3t6gDHy8l0xpfL2ubHSiFfqMQ2sfG0Kt
         pYyJl6f1AlSRkqwyT6+DbKsUokiv9lA64UxVl0vS9D6i8gZj74ll/aZ7Oge8rNkNpX1Z
         AEthffEMpv2hHp6Z8AiBgwyBe5mRPn34uv4vOFUhflMOyRhH6ZYIPTN+sb1j+217h5l2
         cJx7tjBHjB5HZbXSmpPsTbNFH4/VU05cfhwyIRj0h7E3DHovtLeE8+5QkV9MDYoN2BKx
         CU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N43iYmA9gOqNH26g6U8tPSlRYbFsMmkcbybRtbhv4Q=;
        b=itdBLsgRJuJy6iYUHDtaeSQGkOQBkeBD5AUpfnY6zbwoMOcvFB+89Te73RuAQBSzOs
         DqR06Eedi0eHVbUlqYqaK0pMeV5gEZLzgehPMmc0Nlk7zb+QC7l+ANWVPZCwFvhsj/QJ
         jB2yf3urBNxuQ+rtOhzgyDh/BSfL+qAlot/Wt5lgVTtzfEQ2a0rNEKLdh1idzwo1xqcA
         WYFGcWIw7+Fdbf8ySb8utb6caDzyQTWyssYtu0NnFBOsVeWA1Wtbrkbqcot5PrCyCP/F
         AIWO8f4mnEfZ/JvKED6b7OPY3SEoi8YjhWuH0dlKmvx+eryH8adLsOdNIx5ZUQHmHVH+
         Wahw==
X-Gm-Message-State: ANoB5pl6Ep88XanjB1Ug2DQAIHW5tYXGEVW178O9iD5ZNqs9kv2rNFCk
        q/e4vIhylhL3KDOUXUePhldPRg==
X-Google-Smtp-Source: AA0mqf4ZLJvMk5vwVcIh13aU/7X30E3OcuX/nLke3djjf8jPAOwRSwgnEdyspytWO6Cqa+cFbuR8LA==
X-Received: by 2002:a17:902:8c8d:b0:17f:73d6:4375 with SMTP id t13-20020a1709028c8d00b0017f73d64375mr1858594plo.24.1668475851588;
        Mon, 14 Nov 2022 17:30:51 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id kb6-20020a17090ae7c600b001fde655225fsm348240pjb.2.2022.11.14.17.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:51 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKFt-8F; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001VpB-0e;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/9] xfs, iomap: fix data corrupton due to stale cached iomaps
Date:   Tue, 15 Nov 2022 12:30:34 +1100
Message-Id: <20221115013043.360610-1-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc linux-mm for exporting mapping_seek_hole_data())]

Recently a customer workload encountered a data corruption in a
specific multi-threaded write operation. The workload combined
racing unaligned adjacent buffered writes with low memory conditions
that caused both writeback and memory reclaim to race with the
writes.

The result of this was random partial blocks containing zeroes
instead of the correct data.  The underlying problem is that iomap
caches the write iomap for the duration of the write() operation,
but it fails to take into account that the extent underlying the
iomap can change whilst the write is in progress.

The short story is that an iomap can span mutliple folios, and so
under low memory writeback can be cleaning folios the write()
overlaps. Whilst the overlapping data is cached in memory, this
isn't a problem, but because the folios are now clean they can be
reclaimed. Once reclaimed, the write() does the wrong thing when
re-instantiating partial folios because the iomap no longer reflects
the underlying state of the extent. e.g. it thinks the extent is
unwritten, so it zeroes the partial range, when in fact the
underlying extent is now written and so it should have read the data
from disk.  This is how we get random zero ranges in the file
instead of the correct data.

The gory details of the race condition can be found here:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

Fixing the problem has two aspects. The first aspect of the problem
is ensuring that iomap can detect a stale cached iomap during a
write in a race-free manner. We already do this stale iomap
detection in the writeback path, so we have a mechanism for
detecting that the iomap backing the data range may have changed
and needs to be remapped.

In the case of the write() path, we have to ensure that the iomap is
validated at a point in time when the page cache is stable and
cannot be reclaimed from under us. We also need to validate the
extent before we start performing any modifications to the folio
state or contents. Combine these two requirements together, and the
only "safe" place to validate the iomap is after we have looked up
and locked the folio we are going to copy the data into, but before
we've performed any initialisation operations on that folio.

If the iomap fails validation, we then mark it stale, unlock the
folio and end the write. This effectively means a stale iomap
results in a short write. Filesystems should already be able to
handle this, as write operations can end short for many reasons and
need to iterate through another mapping cycle to be completed. Hence
the iomap changes needed to detect and handle stale iomaps during
write() operations is relatively simple....

However, the assumption is that filesystems should already be able
to handle write failures safely, and that's where the second
(first?) part of the problem exists. That is, handling a partial
write is harder than just "punching out the unused delayed
allocation extent". This is because mmap() based faults can race
with writes, and if they land in the delalloc region that the write
allocated, then punching out the delalloc region can cause data
corruption.

This data corruption problem is exposed by generic/346 when iomap is
converted to detect stale iomaps during write() operations. Hence
write failure in the filesytems needs to handle the fact that the
write() in progress doesn't necessarily own the data in the page
cache over the range of the delalloc extent it just allocated.

As a result, we can't just truncate the page cache over the range
the write() didn't reach and punch all the delalloc extent. We have
to walk the page cache over the untouched range and skip over any
dirty data region in the cache in that range. Which is ....
non-trivial.

That is, iterating the page cache has to handle partially populated
folios (i.e. block size < page size) that contain data. The data
might be discontiguous within a folio. Indeed, there might be
*multiple* discontiguous data regions within a single folio. And to
make matters more complex, multi-page folios mean we just don't know
how many sub-folio regions we might have to iterate to find all
these regions. All the corner cases between the conversions and
rounding between filesystem block size, folio size and multi-page
folio size combined with unaligned write offsets kept breaking my
brain.

Eventually, I realised that if the XFS code tracked the processed
write regions by byte ranges instead of fileysetm block or page
cache index, we could simply use mapping_seek_hole_data() to find
the start and end of each discrete data region within the range we
needed to scan. SEEK_DATA finds the start of the cached data region,
SEEK_HOLE finds the end of the region. THese are byte based
interfaces that understand partially uptodate folio regions, and so
can iterate discrete sub-folio data regions directly. This largely
solved the problem of discovering the dirty regions we need to keep
the delalloc extent over.

Of course, now xfs/196 fails. This is a error injection test that is
supposed to exercise the delalloc extent recover code that the above
fixes just completely reworked. the error injection assumes that it
can just truncate the page cache over the write and then punch out
the delalloc extent completely. This is fundamentally broken, and
only has been working by chance - the chance is that writes are page
aligned and page aligned writes don't install large folios in the
page cache.

IOWs, with sub-folio block size, and not know what size folios are
in the cache, we can't actually guarantee that we can remove the
cached dirty folios from the cache via truncation, and hence the new
code will not remove the delalloc extents under those dirty folios.
As a result the error injection results is writing zeroes to disk
rather that removing the delalloc extents from memory. I can't make
this error injection to work the way it was intended, so I removed
it. The code that it is supposed to exercise is now exercised every time we
detect a stale iomap, so we have much better coverage of the failed
write error handling than the error injection provides us with,
anyway....

So, this passes fstests on 1kb and 4kb block sizes and the data
corruption reproducer does not detect data corruption, so this set
of fixes is /finally/ something I'd consider ready for merge.
Comments and testing welcome!

-Dave.

Version 2:
- export mapping_seek_hole_data()
- fix missing initialisation of the iomap sequence in xfs_fs_map_blocks() in the
  pnfs code.
- move ->iomap_valid callback to the struct iomap_page_ops so that it is
  returned with the iomap rather than having the iomap_ops plumbed through the
  entire stack.
- added a u64 validity_cookie to the struct iomap for carrying iomap
  verification information along with the iomap itself.
- added IOMAP_F_XATTR for XFS to be able to tell the difference between iomaps
  that map attribute extents instead of file data extents.
- converted the IOMAP_F_* flags to use the (1U << NN) definition pattern.
- added patch to convert xfs_bmap_punch_delalloc_range() to take a byte range.


Version 1:
- https://lore.kernel.org/linux-xfs/20221101003412.3842572-1-david@fromorbit.com/
- complete rework of iomap stale detection
- complete rework of XFS partial delalloc write error handling.

Original RFC:
- https://lore.kernel.org/linux-xfs/20220921082959.1411675-1-david@fromorbit.com/

