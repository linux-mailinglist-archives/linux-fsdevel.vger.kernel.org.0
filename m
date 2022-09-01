Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EE5A90AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiIAHm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiIAHm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:42:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC011D92F;
        Thu,  1 Sep 2022 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wxUc/dypL4JMwiJXvvioz7M8d2sEfLuwK1C5YZR0euw=; b=EkhJnMmXQDx7zfPV5SAXZQ4Zsg
        KKEitwv5J/qc5XjZEW5diR2e3o3A8QDyrsRBeU0vmFfTdsJBsBLE54LgZd4LDoIjpYRNdTJqxDaob
        QAshM0xVjo+XTD2C2l5VqPJZbhWfyMJy5dOsPGGugi/S9h/QB7xkWAFzS8kPE5JqO7TLm6SSW/vDT
        gMRn75CycGR9HeLaxUVKr+pVfIBZPGpS35Psyyi90UC23D2Kivt+Ie/3qtHMAKZ8h8u+62e/qqQfo
        Yd6rvZOX/A3HCeeIrEYxsJt2ukXMaXoWw6Zw89jyHtNhpEsKtdK1E0nB1m4GtujDAyhOeAehzN9tK
        9DIOrJFA==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeqC-00ANU6-1n; Thu, 01 Sep 2022 07:42:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: consolidate btrfs checksumming, repair and bio splitting
Date:   Thu,  1 Sep 2022 10:41:59 +0300
Message-Id: <20220901074216.1849941-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series moves a large amount of duplicate code below btrfs_submit_bio
into what I call the 'storage' layer.  Instead of duplicating code to
checksum, check checksums and repair and split bios in all the caller
of btrfs_submit_bio (buffered I/O, direct I/O, compressed I/O, encoded
I/O), the work is done one in a central place, often more optiomal and
without slight changes in behavior.  Once that is done the upper layers
also don't need to split the bios for extent boundaries, as the storage
layer can do that itself, including splitting the bios for the zone
append limits for zoned I/O.

The split work is inspired by an earlier series from Qu, from which it
also reuses a few patches.

Note: this adds a fair amount of code to volumes.c, which already is
quite large.  It might make sense to add a prep patch to move
btrfs_submit_bio into a new bio.c file, but I only want to do that
if we have agreement on the move as the conflicts will be painful
when rebasing.

A git tree is also available:

    git://git.infradead.org/users/hch/misc.git btrfs-bio-split

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-split

Diffstat:
 block/blk-merge.c                |    3 
 fs/btrfs/btrfs_inode.h           |    5 
 fs/btrfs/compression.c           |  273 ++------------
 fs/btrfs/compression.h           |    3 
 fs/btrfs/ctree.h                 |   24 -
 fs/btrfs/disk-io.c               |  198 +---------
 fs/btrfs/disk-io.h               |    6 
 fs/btrfs/extent-io-tree.h        |   19 
 fs/btrfs/extent_io.c             |  739 ++------------------------------------
 fs/btrfs/extent_io.h             |   32 -
 fs/btrfs/file-item.c             |   67 +--
 fs/btrfs/inode.c                 |  664 ++++------------------------------
 fs/btrfs/ordered-data.h          |    1 
 fs/btrfs/tests/extent-io-tests.c |    1 
 fs/btrfs/volumes.c               |  753 +++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.h               |   83 +---
 fs/btrfs/zoned.c                 |   69 +--
 fs/btrfs/zoned.h                 |   16 
 fs/iomap/direct-io.c             |   10 
 include/linux/bio.h              |    4 
 include/linux/iomap.h            |    1 
 include/trace/events/btrfs.h     |    2 
 22 files changed, 924 insertions(+), 2049 deletions(-)
