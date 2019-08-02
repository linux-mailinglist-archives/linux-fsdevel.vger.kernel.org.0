Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3689680263
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 00:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbfHBWAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 18:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730782AbfHBWAy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:00:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4719FB0BA;
        Fri,  2 Aug 2019 22:00:53 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        ruansy.fnst@cn.fujitsu.com
Subject: [PATCH v2 0/13] Btrfs iomap
Date:   Fri,  2 Aug 2019 17:00:35 -0500
Message-Id: <20190802220048.16142-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an effort to use iomap for btrfs. This would keep most
responsibility of page handling during writes in iomap code, hence
code reduction. For CoW support, changes are needed in iomap code
to make sure we perform a copy before the write.
This is in line with the discussion we had during adding dax support in
btrfs.

Efforts on adding dax support have been put on hold until MM experts can
come with a way of performing multiple mappings to a single page
(primarily the TODO before dax_associate_entry()). While we are waiting
on that we could add support for buffered writes in btrfs.

[1] https://github.com/goldwynr/linux/tree/btrfs-iomap

-- 
Goldwyn

Changes since v1
- Added Direct I/O support
- Remove PagePrivate from btrfs pages for regular files

 fs/btrfs/Makefile           |    2 
 fs/btrfs/compression.c      |    1 
 fs/btrfs/ctree.h            |   15 -
 fs/btrfs/extent_io.c        |   13 
 fs/btrfs/extent_io.h        |    2 
 fs/btrfs/file.c             |  520 --------------------------------------
 fs/btrfs/free-space-cache.c |    1 
 fs/btrfs/inode.c            |  170 +++---------
 fs/btrfs/ioctl.c            |    4 
 fs/btrfs/iomap.c            |  600 +++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.c       |    2 
 fs/dax.c                    |    8 
 fs/ext2/inode.c             |    2 
 fs/ext4/inode.c             |    2 
 fs/gfs2/bmap.c              |    3 
 fs/iomap/apply.c            |    5 
 fs/iomap/buffered-io.c      |   28 +-
 fs/iomap/direct-io.c        |   18 -
 fs/iomap/fiemap.c           |    4 
 fs/iomap/seek.c             |    4 
 fs/iomap/swapfile.c         |    3 
 fs/xfs/xfs_iomap.c          |    9 
 include/linux/iomap.h       |    7 
 23 files changed, 727 insertions(+), 696 deletions(-)


