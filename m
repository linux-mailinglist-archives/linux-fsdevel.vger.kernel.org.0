Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D41DFA64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEWS6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEWS6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931D6C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so4761366plv.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSyL9nA+53Bvqa5M3mPCVCWXeLpByAjCJu0zD/ohw+8=;
        b=1MtbvOz1/nCvQ0+b3EzjI6QTcR9fFRtdVoM6dpuHEDAGi8YBUc9ych6ORcbliyXYKf
         /7MQtjg1+IKRFOMm0/SlTC5B/B08eLyupnncF4JyInt48DdiI+tAogAwcdkCl69fG6tf
         3ysRpTIUj2Cq7aLRaERGdelcLx2rnXbbh/2WycAfMFz2yG+ABSNvKapSq5DTv6avZIuI
         5z026Fb6tuDkYeB5yuNsrMmN4s5WUZ2fla9q6cReBMZhm+Ojrh0X35rMa5jhARBwmBPD
         +deMnRUWCXW5hBenDn7Mpdf9KEh7qQ07ZZTQ7RpnB8toxIOUvpOh2fc4PlViZbb+IB2M
         tOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSyL9nA+53Bvqa5M3mPCVCWXeLpByAjCJu0zD/ohw+8=;
        b=hnd5jsFXZWB8b4uZokHOvywLNPkrV1jckUDbXvnv7LLATSwraYywOwsCwLE5TPrzBO
         N0+dAhtonaojZReTIZLArwcgqbsMlB7uyJYvWzRuXLNrQqEMSkIkeFidXv1zQGcGVbHc
         OIx6eueIcDNuHUP4Y0Qs7O7SeqoSwN8l5KTV/XIgV+LKZjTLj8KdKn7Ia9ySTGunZx8n
         ImqxmsFfZRNiEOficzgnx7/2uyKkq/6DnBQLR1ywJj2NXvZPoytYW4BdONo6XEI4ctVn
         CSQYoGGss4YDK6Mn+JfhVwExrq6jFJSdMnckvqORw7K+qoPPVrEum3tPmbfEw1CaIBce
         HNmA==
X-Gm-Message-State: AOAM530ZyJ6YEhTqqljP7mU3Hy/4G7HrKXrIA04pT2wxfQYWTfusc9XU
        5eN+5cbeWjP1kcUSbHpFC2bcw4URoDqTGQ==
X-Google-Smtp-Source: ABdhPJyrMCBfxmmC26HOKoShcD6Ly68WzB+R2ReanKFkNbhK0MuG3y8yEmsp7Tv65+SbVJgmAkFi2A==
X-Received: by 2002:a17:90b:245:: with SMTP id fz5mr11847967pjb.232.1590260279405;
        Sat, 23 May 2020 11:57:59 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:57:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCHSET v2 0/12] Add support for async buffered reads
Date:   Sat, 23 May 2020 12:57:43 -0600
Message-Id: <20200523185755.8494-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We technically support this already through io_uring, but it's
implemented with a thread backend to support cases where we would
block. This isn't ideal.

After a few prep patches, the core of this patchset is adding support
for async callbacks on page unlock. With this primitive, we can simply
retry the IO operation. With io_uring, this works a lot like poll based
retry for files that support it. If a page is currently locked and
needed, -EIOCBQUEUED is returned with a callback armed. The callers
callback is responsible for restarting the operation.

With this callback primitive, we can add support for
generic_file_buffered_read(), which is what most file systems end up
using for buffered reads. XFS/ext4/btrfs/bdev is wired up, but probably
trivial to add more.

The file flags support for this by setting FMODE_BUF_RASYNC, similar
to what we do for FMODE_NOWAIT. Open to suggestions here if this is
the preferred method or not.

In terms of results, I wrote a small test app that randomly reads 4G
of data in 4K chunks from a file hosted by ext4. The app uses a queue
depth of 32. If you want to test yourself, you can just use buffered=1
with ioengine=io_uring with fio. No application changes are needed to
use the more optimized buffered async read.

preadv for comparison:
	real    1m13.821s
	user    0m0.558s
	sys     0m11.125s
	CPU	~13%

Mainline:
	real    0m12.054s
	user    0m0.111s
	sys     0m5.659s
	CPU	~32% + ~50% == ~82%

This patchset:
	real    0m9.283s
	user    0m0.147s
	sys     0m4.619s
	CPU	~52%

The CPU numbers are just a rough estimate. For the mainline io_uring
run, this includes the app itself and all the threads doing IO on its
behalf (32% for the app, ~1.6% per worker and 32 of them). Context
switch rate is much smaller with the patchset, since we only have the
one task performing IO.

The goal here is efficiency. Async thread offload adds latency, and
it also adds noticable overhead on items such as adding pages to the
page cache. By allowing proper async buffered read support, we don't
have X threads hammering on the same inode page cache, we have just
the single app actually doing IO.

Been beating on this and it's solid for me, and I'm now pretty happy
with how it all turned out. Not aware of any missing bits/pieces or
code cleanups that need doing.

Series can also be found here:

https://git.kernel.dk/cgit/linux-block/log/?h=async-buffered.3

or pull from:

git://git.kernel.dk/linux-block async-buffered.3

 fs/block_dev.c            |   2 +-
 fs/btrfs/file.c           |   2 +-
 fs/ext4/file.c            |   2 +-
 fs/io_uring.c             |  99 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_file.c         |   2 +-
 include/linux/blk_types.h |   3 +-
 include/linux/fs.h        |   5 ++
 include/linux/pagemap.h   |  64 ++++++++++++++++++++++
 mm/filemap.c              | 111 ++++++++++++++++++++++++--------------
 9 files changed, 245 insertions(+), 45 deletions(-)

Changes since v2:
- Get rid of unnecessary wait_page_async struct, just use wait_page_async
- Add another prep handler, adding wake_page_match()
- Use wake_page_match() in both callers
Changes since v1:
- Fix an issue with inline page locking
- Fix a potential race with __wait_on_page_locked_async()
- Fix a hang related to not setting page_match, thus missing a wakeup

-- 
Jens Axboe


