Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3C666D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 10:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjALJLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 04:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjALJKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFE517D6;
        Thu, 12 Jan 2023 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Tko9eKbjkyt4wSrlR3e8NXL7dgXUGaa8h+OV4dGo39g=; b=ty3akuZPgFsW8w3F43KUtsxn8y
        TZYxlKaifUHH2WDxUgPoPSWk0U0A8y9Y82C5Xnz/ZOy+jvDk2k6bVn8FzdhOmNW+bcQMiQZhJh4PK
        P6Uv/1erA3rJN+vJeB1F3anDqxzoHq8u8YukhyQXSNyyWxF5hnDzhdM7iDwVG7C4lzMAruxR+dYHR
        PWb6OdMUzik+xeSBKEOxJiIffl4qQ+4kWzhdgpkWxuvo8+gxGENW1Q9gTGMBqT4lZBFeBvs6itcbQ
        DOttE/MY7KX07B5g0C4LyVVfpw8oq3uZ8H9kXIzxrDoP37ox1UAOeYUXFX7I2WVVXzXsqPXM4Dqa+
        fJmXt2Uw==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtWg-00EGAX-2d; Thu, 12 Jan 2023 09:05:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: consolidate btrfs checksumming, repair and bio splitting v3
Date:   Thu, 12 Jan 2023 10:05:12 +0100
Message-Id: <20230112090532.1212225-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Note that Dave commented on patch 2 to be split due to "doing multiple
things at once".  I've got not comment on how that should be done,
except for the discussion with Josef on the previous iteration, where
opting into the new functionality by the callers through a new flag
would be possible, but actually making the whole series more complex
and harder to bisect.  I can still do that even if I think it's not
very helpful, but I can't really think of any other split.

A git tree is also available:

    git://git.infradead.org/users/hch/misc.git btrfs-bio-split

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-split

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
