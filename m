Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5F61424C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 01:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKAAeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 20:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKAAeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:34:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8615A1A
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k22so12127708pfd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utzzxWhOQdIAcW5lUrYp+XP8QYKoeRU3WklpBYmjPnc=;
        b=vWyPYJ+fCYG+YhZl2nKBLb3u5FSC5ZzYRzlFMVElTZnlflGzky70AJsNZ0BkdoN8Z3
         /o+O7OiPap3mZwX4Z9Mocw2cUxYSfR2ZhkHavSOAtj+N0SFyGgFo5oQ3x736SRzmh/bF
         vAvO7ESoFFEaR4WSDiky3mFNlokhbmTRd7WmwdIl8GR/qk/Xl49Em3AB72aEWMnFH+37
         1S3dih3z11HsGfTADVn2/p0deI716zhf/L2KFrvh9TM2QBxKRasLC8zSJSkt2f8ywgB4
         2qiK2KjPKD/2Z2P9AnJxEnP2bsxvnUd3g1pjI7Azs9HssFtyfzbO3v+yMsKw01beD9IU
         F+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utzzxWhOQdIAcW5lUrYp+XP8QYKoeRU3WklpBYmjPnc=;
        b=Zl9k1h72W6VlsMJmJbjizYRTFyV6r9pegWiD4D5xg6p+U+yu/0uZF0x7dVJz5wTp4w
         GQmzY15kbUpqPDNm6ca9EN1fCigWU90qYUquqeYPeXobXD4ZrH6HarXuEBbZc4p/UaE4
         gJ1a607lvgfNyrOxwUv3MKUY+4bgNtKP2ELkJMznn8IhctAYPqEoYTP+1neDJwBluGFU
         mLznARR+0Ryg1gtg6g4DqXktAA01VOgWvWgPP493ifxxCclBWuQNd9kZnwKOEh7qSq+R
         inaMVy8L75By9AaFi+2lhHjBVvXIEsY4kjrpL1FlH6ZgNb8PrzBQanC7v9OpKyCzQkqH
         w4EQ==
X-Gm-Message-State: ACrzQf24hlvf3Y/6Elb31T4zbvMFegIdKLA7NaED0pinyJYgf7q8mfB1
        xv06wuycSWic5ZADiIxfLTqfMoQ1R8/vhg==
X-Google-Smtp-Source: AMsMyM5Lgaqzgtqye4j2gCBC2cxiEJTWWulzKfsxN9qYm8YA4tDsxofwtYfyhBSx7HUQqST4qsPdwQ==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr16893321pfb.43.1667262858527;
        Mon, 31 Oct 2022 17:34:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090ab70100b00212e5fe09d7sm4763425pjr.10.2022.10.31.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:34:17 -0700 (PDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-008muH-33; Tue, 01 Nov 2022 11:34:15 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-00G7dT-05;
        Tue, 01 Nov 2022 11:34:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: xfs, iomap: fix data corrupton due to stale cached iomaps
Date:   Tue,  1 Nov 2022 11:34:05 +1100
Message-Id: <20221101003412.3842572-1-david@fromorbit.com>
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
it. The code that it is supposed to exercise is now exercised every time we
detect a stale iomap, so we have much better coverage of the failed
write error handling than the error injection provides us with,
anyway....

So, this passes fstests on 1kb and 4kb block sizes and the data
corruption reproducer does not detect data corruption, so this set
of fixes is /finally/ something I'd consider ready for merge.
Comments and testing welcome!

-Dave.

Version 1:
- complete rework of iomap stale detection
- complete rework of XFS partial delalloc write error handling.

Original RFC:
- https://lore.kernel.org/linux-xfs/20220921082959.1411675-1-david@fromorbit.com/


