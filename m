Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5F1097FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 04:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKZDPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 22:15:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfKZDPT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:15:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4163DAE00;
        Tue, 26 Nov 2019 03:15:18 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org
Subject: [PATCH 0/5 v2] btrfs direct-io using iomap
Date:   Mon, 25 Nov 2019 21:14:51 -0600
Message-Id: <20191126031456.12150-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an effort to use iomap for direct I/O in btrfs. This would
change the call from __blockdev_direct_io() to iomap_dio_rw().

The main objective is to lose the buffer head and use bio defined by
iomap code, and hopefully to use more of generic-FS codebase.

These patches are based on xfs/iomap-for-next, though I tested it
against the patches on xfs/iomap-for-next on top of v5.4 (there are no
changes to existing iomap patches).

I have tested it against xfstests/btrfs.

Changes since v1
- Incorporated back the efficiency change for inode locking
- Review comments about coding style and git comments
- Merge related patches into one
- Direct read to go through btrfs_direct_IO()
- Removal of no longer used function dio_end_io()

 fs/btrfs/ctree.h      |    2 
 fs/btrfs/extent_io.c  |   33 ++++-----
 fs/btrfs/file.c       |   15 +++-
 fs/btrfs/inode.c      |  171 +++++++++++++++++++++++---------------------------
 fs/direct-io.c        |   19 -----
 fs/iomap/direct-io.c  |   14 ++--
 include/linux/fs.h    |    3 
 include/linux/iomap.h |    2 
 mm/filemap.c          |   13 ++-
 9 files changed, 131 insertions(+), 141 deletions(-)

--
Goldwyn

