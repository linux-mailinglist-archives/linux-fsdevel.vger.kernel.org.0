Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7120711972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbjEYVsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjEYVsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 17:48:42 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC9012C
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 14:48:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685051317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/htzEy4EHBMdNE/JbpSxK/E6aimlWCZ120WLz6hVPdg=;
        b=k6jGFcUqjzohjB8xz2f7m8Jps7CXkyBO6+5Ta9qstxqh0NLeOgn367GHD3EQsk1sgmfZKd
        DPMXEQ/RFaJQFONq4eZEvQUZC/bfUO7wHYP8CqKmiZDQNXvb5ia9htTi5KjE5B/dPmXp8/
        m6IgFfuoGt5vQIdcp87lhi+vrPF8uxU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] block layer patches for bcachefs
Date:   Thu, 25 May 2023 17:48:15 -0400
Message-Id: <20230525214822.2725616-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens, here's the full series of block layer patches needed for bcachefs:

Some of these (added exports, zero_fill_bio_iter?) can probably go with
the bcachefs pull and I'm just including here for completeness. The main
ones are the bio_iter patches, and the __invalidate_super() patch.

The bio_iter series has a new documentation patch.

I would still like the __invalidate_super() patch to get some review
(from VFS people? unclear who owns this).

Thanks,
Kent

Kent Overstreet (7):
  block: Add some exports for bcachefs
  block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
  block: Bring back zero_fill_bio_iter
  block: Rework bio_for_each_segment_all()
  block: Rework bio_for_each_folio_all()
  block: Add documentation for bio iterator macros
  block: Don't block on s_umount from __invalidate_super()

 block/bdev.c               |   2 +-
 block/bio.c                |  57 ++++++------
 block/blk-core.c           |   1 +
 block/blk-map.c            |  38 ++++----
 block/blk.h                |   1 -
 block/bounce.c             |  12 +--
 drivers/md/bcache/btree.c  |   8 +-
 drivers/md/dm-crypt.c      |  10 +-
 drivers/md/raid1.c         |   4 +-
 fs/btrfs/disk-io.c         |   4 +-
 fs/btrfs/extent_io.c       |  50 +++++-----
 fs/btrfs/raid56.c          |  14 +--
 fs/crypto/bio.c            |   9 +-
 fs/erofs/zdata.c           |   4 +-
 fs/ext4/page-io.c          |   8 +-
 fs/ext4/readpage.c         |   4 +-
 fs/f2fs/data.c             |  20 ++--
 fs/gfs2/lops.c             |  10 +-
 fs/gfs2/meta_io.c          |   8 +-
 fs/iomap/buffered-io.c     |  14 +--
 fs/mpage.c                 |   4 +-
 fs/squashfs/block.c        |  48 +++++-----
 fs/squashfs/lz4_wrapper.c  |  17 ++--
 fs/squashfs/lzo_wrapper.c  |  17 ++--
 fs/squashfs/xz_wrapper.c   |  19 ++--
 fs/squashfs/zlib_wrapper.c |  18 ++--
 fs/squashfs/zstd_wrapper.c |  19 ++--
 fs/super.c                 |  40 ++++++--
 fs/verity/verify.c         |   9 +-
 include/linux/bio.h        | 186 +++++++++++++++++++++++++------------
 include/linux/blkdev.h     |   1 +
 include/linux/bvec.h       |  70 ++++++++------
 include/linux/fs.h         |   1 +
 33 files changed, 429 insertions(+), 298 deletions(-)

-- 
2.40.1

