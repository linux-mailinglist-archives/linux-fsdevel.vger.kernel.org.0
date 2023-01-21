Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D5676438
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAUGup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjAUGum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BE960C8F;
        Fri, 20 Jan 2023 22:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jhKySX47uJIFkNYY5HfKOBcVXW5rJ9FUQrF22Q3B5ak=; b=dvLMnU32mWeIsKlHR0iumnQ0MT
        rbEM4vwQYQa0DOMmFF2DrW5EmbZ68ek8xiGis9hZbfzNUfy5tdts1Ftfa0sdvowXrUKcqvkCGcKwH
        hnkeVRd/eznkLuskQ8Yr7+FtOql+ta4e8ZqSqIsu68dYycDVP3cC4MnQ6lxuqZis6jlvbN31/eTT5
        hLYZpSV7yy+4lgGAni/qgTSJP7aAu0BYQa+nNvgqprJ0jGIyT9R/tQUq7RnvN8myDS0vHJklCzrty
        nlBcS0lKuN57bX3rjKoXRwNMowFuNWKMNKcHKXaQEEXIaSwss0+LwAo6vNlq5VgKoK/b4SDyEjOoo
        cGjZnT/A==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7hx-00DREz-Pr; Sat, 21 Jan 2023 06:50:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: consolidate btrfs checksumming, repair and bio splitting v4
Date:   Sat, 21 Jan 2023 07:49:57 +0100
Message-Id: <20230121065031.1139353-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

A git tree is also available:

    git://git.infradead.org/users/hch/misc.git btrfs-bio-split

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-split

Changes since v2:
 - split up one patch into 15 and update the commit message
 - fix a use after free in run_one_async_done
   (the end result is identical to v2 except for the one line fix
   in run_one_async_done)

Changes since v2:
 - minor rebase to latest misc-next
 - pick up various reviews for all patches

Changes since v1:
 - rebased to latest btrfs/misc-next
 - added a new patch to remove the fs_info argument to btrfs_submit_bio
 - clean up the repair_one_sector calling convention a bit
 - don't move file_offset for ONE_ORDERED bios in btrfs_split_bio
 - temporarily use btrfs_zoned_get_device in alloc_compressed_bio
 - minor refactoring of some of the checksum helpers
 - split up a few patches
 - drop a few of the blk_status_t to int conversion for now
 - various whitespace fixes

Diffstat:
 block/blk-merge.c         |    3 
 fs/btrfs/bio.c            |  547 ++++++++++++++++++++++++++++++++++++----
 fs/btrfs/bio.h            |   67 +---
 fs/btrfs/btrfs_inode.h    |   22 -
 fs/btrfs/compression.c    |  273 +++-----------------
 fs/btrfs/compression.h    |    3 
 fs/btrfs/disk-io.c        |  203 +--------------
 fs/btrfs/disk-io.h        |   11 
 fs/btrfs/extent-io-tree.h |    1 
 fs/btrfs/extent_io.c      |  556 ++++-------------------------------------
 fs/btrfs/extent_io.h      |   31 --
 fs/btrfs/file-item.c      |   74 +----
 fs/btrfs/file-item.h      |    8 
 fs/btrfs/fs.h             |    5 
 fs/btrfs/inode.c          |  621 ++++++----------------------------------------
 fs/btrfs/volumes.c        |  115 ++------
 fs/btrfs/volumes.h        |   18 -
 fs/btrfs/zoned.c          |   85 ++----
 fs/btrfs/zoned.h          |   16 -
 fs/iomap/direct-io.c      |   10 
 include/linux/bio.h       |    4 
 include/linux/iomap.h     |    3 
 22 files changed, 819 insertions(+), 1857 deletions(-)
