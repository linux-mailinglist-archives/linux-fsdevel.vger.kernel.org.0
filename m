Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2260DE8CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfD2R1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728748AbfD2R1K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DA90AD0A;
        Mon, 29 Apr 2019 17:27:08 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org
Subject: [PATCH v4 00/18] btrfs dax support
Date:   Mon, 29 Apr 2019 12:26:31 -0500
Message-Id: <20190429172649.8288-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set adds support for dax on the BTRFS filesystem.
In order to support for CoW for btrfs, there were changes which had to be
made to the dax handling. The important one is copying blocks into the
same dax device before using them which is performed by iomap
type IOMAP_DAX_COW.

Snapshotting and CoW features are supported (including mmap preservation
across snapshots).

Git: https://github.com/goldwynr/linux/tree/btrfs-dax

Changes since v3:
 - Fixed memcpy bug
 - used flags for dax_insert_entry instead of bools for dax_insert_entry()

Changes since v2:
 - Created a new type IOMAP_DAX_COW as opposed to flag IOMAP_F_COW
 - CoW source address is presented in iomap.inline_data
 - Split the patches to more elaborate dax/iomap patches

Changes since v1:
 - use iomap instead of redoing everything in btrfs
 - support for mmap writeprotecting on snapshotting

 fs/btrfs/Makefile            |    1 
 fs/btrfs/ctree.h             |   38 +++++
 fs/btrfs/dax.c               |  289 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/disk-io.c           |    4 
 fs/btrfs/file.c              |   37 ++++-
 fs/btrfs/inode.c             |  114 ++++++++++++----
 fs/btrfs/ioctl.c             |   29 +++-
 fs/btrfs/send.c              |    4 
 fs/btrfs/super.c             |   30 ++++
 fs/dax.c                     |  183 ++++++++++++++++++++++++---
 fs/iomap.c                   |    9 -
 fs/ocfs2/file.c              |    2 
 fs/read_write.c              |   11 -
 fs/xfs/xfs_reflink.c         |    2 
 include/linux/dax.h          |   15 +-
 include/linux/fs.h           |    8 +
 include/linux/iomap.h        |    7 +
 include/trace/events/btrfs.h |   56 ++++++++
 18 files changed, 752 insertions(+), 87 deletions(-)


