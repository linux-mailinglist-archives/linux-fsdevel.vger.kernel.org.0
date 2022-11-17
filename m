Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5462D31F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiKQF6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiKQF6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:58:19 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B66828F
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 21:58:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so644604ply.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 21:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3lQ/ocQYFCBXSdbz2/8nLNQ7hCVLAIEXFIWuAX3wwaM=;
        b=MW8SAzZUrM/qQlvfC/OANuwfWpSTmkduMU9UL3FOXHw4fbVTCXKXLAtLMKifVldw63
         I29GNMsAwYdUgxl6S0jasOKUa+cJFyUbm2x3SXBexIzet3SINL7geHC+Yw/hw9yPyIN3
         EiuJxfkNiKGUUYgBC1/kyrxNEYId9kWWT3rElg2m5Egwjl4FLwE3d0kRxjKujNjkEpyZ
         KYmzjp+Eq3ZRGJZLY7dZ5v64QT24VvKas51TL+7JjXQVQiR/7Bbl3yhMbeFcDWZvPzP5
         VxGm+ymAsESSnUIFjoziYf95jnAVCI0YmhhkhgAN4X2Clqfr8utN/UTd81tE+8YIv1kN
         A4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lQ/ocQYFCBXSdbz2/8nLNQ7hCVLAIEXFIWuAX3wwaM=;
        b=yXh01l19lrvuKedpX21Go0dpBInn/SpsVyXEMf1q9De/zWdR+IhwSRlvyOjVVYwTfN
         5WucI90WAGpXDVFtoKyhQdJOhfOohSM7ckYcEFX74Tk0kV07lrqDoMddjRODhLaDhypL
         lEO6Z4UqMcdQbWaaKHuG3jV0dDtPE6wy0HSfwrycONDs+tO8YrES/z3/HoDSebGefQ3/
         b99I8ND9yjynsGwqce/ttEA4HZKgOsVGzAinGOrS2A0eA/KMIUOK6gJq5BBoT0+IE/5N
         zYLUOSqVQL2Bw+Xujnram85C8kHS5/43K9+VjWp6IBGLyjNuMi9paZEAU947y/GSquUJ
         Eiog==
X-Gm-Message-State: ANoB5pmompJj2gu1URgXvyzdCTEqSY8+v1Iixz/3Qx764Y6saUbU2XET
        u/4zQNLTDdybCq9iFKYnMULCKIGgg3g2Bw==
X-Google-Smtp-Source: AA0mqf4b2qy54uDFUKvuw85g9tQ0mtQKzD+XXEfxvD+/rKQOcZkmYGmp/+NMOUJboIhmm5f6rF+4xg==
X-Received: by 2002:a17:90a:c90a:b0:218:6ba0:cd8c with SMTP id v10-20020a17090ac90a00b002186ba0cd8cmr2187292pjt.133.1668664697442;
        Wed, 16 Nov 2022 21:58:17 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016c9e5f291bsm234482plh.111.2022.11.16.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:58:15 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ovXue-00FBpB-3k; Thu, 17 Nov 2022 16:58:12 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1ovXue-0025ap-0F;
        Thu, 17 Nov 2022 16:58:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/8 v3] xfs, iomap: fix data corrupton due to stale cached iomaps
Date:   Thu, 17 Nov 2022 16:58:01 +1100
Message-Id: <20221117055810.498014-1-david@fromorbit.com>
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
it. The code that it is supposed to exercise is now exercised every
time we detect a stale iomap, so we have much better coverage of the
failed write error handling than the error injection provides us
with, anyway....

So, this passes fstests on 1kb and 4kb block sizes and the data
corruption reproducer does not detect data corruption, so this set
of fixes is /finally/ something I'd consider ready for merge.
Comments and testing welcome!

-Dave.

Version 3:
- Rearrange the deck chairs.
- Remove mapping_seek_hole_data() export.
- move code to iomap to allow mapping_seek_hole_data() not to be
  exported.
- add export to iomap to allow filesystems access to functionality
  that uses mapping_seek_hole_data().
- add punch callback to iomap export to allow filesystem specific
  functionality for ranges found with mapping_seek_hole_data().
- call the new iomap export from from filesystem ->iomap_end
  callback so that iomap can call back into the filesystem again to
  do the stuff the filesystem needs to do.
- Document that the iomap punch callback assumes that the filesystem
  must skip all extent types except for delalloc extents.
- Document the lock order and limits on what the punch callback can
  actually do.
- cleaned up xfs_iomap_valid().


Version 2:
- https://lore.kernel.org/linux-xfs/20221115013043.360610-1-david@fromorbit.com/
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

