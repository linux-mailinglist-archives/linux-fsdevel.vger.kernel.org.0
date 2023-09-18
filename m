Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C995B7A47EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbjIRLGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjIRLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC8103;
        Mon, 18 Sep 2023 04:05:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7200121AAF;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hiZ67VsJwWSd2gCuLZhIzDylPHqXuAjYStRK9uVLrOQ=;
        b=izEau36HssT4JCnb1DZQxp2OyGMfY+h9BZf1Vox+BgnCC5bj5yWcLascp2R3fH0rN5kuHh
        URhhoG6uAI5Qvy8XW6S5MKxsOL4g0BZO8/ng/b4PYkpkAd3CTwYSJGPw9VJtMHo842FJTX
        Hlf9eIZPd8wMtufFd0aDMtOATeecBNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hiZ67VsJwWSd2gCuLZhIzDylPHqXuAjYStRK9uVLrOQ=;
        b=26ix+2FNqJ8kY7wTfkdQQzSI5pgnnVSNKzeOAh9d4kPpPlQ4ehTz63bUIo8lWKyRd6Aq7e
        bs+h29iqu2fJZkDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id DA6A22C142;
        Mon, 18 Sep 2023 11:05:16 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E0C0C51CD13D; Mon, 18 Sep 2023 13:05:16 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 00/18] block: update buffer_head for Large-block I/O
Date:   Mon, 18 Sep 2023 13:04:52 +0200
Message-Id: <20230918110510.66470-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

to make life a little bit more interesting, here is an alternative
patchset to enable large-block I/O for buffer_head. Based on top of
current linus master, no special tweaking required.
And yes, I am _very_ much aware of hch's work to disable buffer_head for iomap.

Key point here is that we can enable large block I/O for buffer heads
if we always consider the page reference in 'struct buffer_head' to be
a folio, and always calculcate the size of the page reference with using
folio_size(). That way we keep the assumptions that each page (or, in our
context, each folio) has a pointer (or a list of pointers) to a struct
buffer_head, and each buffer_head has a pointer to exactly one page/folio.
Then it's just a matter of auditing the page cache to always looks at the
folio and not the page, and the work's pretty much done.

Famous last words.

Patchset also contains an update to 'brd' to enable large block sizes.
For testing please do:

# modprobe brd rd_size=524288 rd_blksize=16384 rd_logical_blksize=16384
# mkfs.xfs -b size=16384

As usual, comments and reviews are welcome.

Hannes Reinecke (16):
  mm/readahead: rework loop in page_cache_ra_unbounded()
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  block/buffer_head: introduce block_{index_to_sector,sector_to_index}
  fs/buffer.c: use accessor function to translate page index to sectors
  fs/mpage: use accessor function to translate page index to sectors
  mm/filemap: allocate folios with mapping order preference
  mm/readahead: allocate folios with mapping order preference
  fs/buffer: use mapping order in grow_dev_page()
  block/bdev: lift restrictions on supported blocksize
  block/bdev: enable large folio support for large logical block sizes
  brd: convert to folios
  brd: abstract page_size conventions
  brd: use memcpy_{to,from}_folio()
  brd: make sector size configurable
  brd: make logical sector size configurable
  xfs: remove check for block sizes smaller than PAGE_SIZE

Matthew Wilcox (Oracle) (1):
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (1):
  nvme: enable logical block size > PAGE_SIZE

 block/bdev.c                |  15 ++-
 drivers/block/brd.c         | 256 ++++++++++++++++++++----------------
 drivers/nvme/host/core.c    |   2 +-
 fs/buffer.c                 |  20 +--
 fs/mpage.c                  |  54 ++++----
 fs/xfs/xfs_super.c          |  12 --
 include/linux/buffer_head.h |  17 +++
 include/linux/pagemap.h     |  48 ++++++-
 mm/filemap.c                |  20 ++-
 mm/readahead.c              |  52 +++++---
 10 files changed, 305 insertions(+), 191 deletions(-)

-- 
2.35.3

