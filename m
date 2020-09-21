Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17827288C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgIUOoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgIUOoG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6268FAD5F;
        Mon, 21 Sep 2020 14:44:40 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com
Subject: [PATCH 0/15 v2] BTRFS DIO inode locking/D_SYNC fix
Date:   Mon, 21 Sep 2020 09:43:38 -0500
Message-Id: <20200921144353.31319-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have merged two series here:
(1) Using inode_lock_shared for <EOF DIO writes
(2) Fix O_DSYNC | O_DIRECT

Both require inode locking to be pushed closer to I/O calls and thought
was relevant. (2) requires changes in iomap code. If there is a need to 
separate the two please let me know. I don't have any ulterior motives
here ;)

Testing: xfstests on both btrfs and xfs

Git: https://github.com/goldwynr/linux/tree/btrfs-inode-lock

Changes since v1:

 - Changed fix for deadlock due to O_DSYNC (iomap patches added)
 - btrfs_inode_lock() shifted to inode.c
 - Reinstated lockdep_assert_held() in iomap_dio_rw()

-- 
Goldwyn

 fs/btrfs/btrfs_inode.h |   28 --
 fs/btrfs/ctree.h       |   13 +
 fs/btrfs/file.c        |  497 +++++++++++++++++++++++++++----------------------
 fs/btrfs/inode.c       |  176 +++--------------
 fs/btrfs/transaction.h |    1
 fs/direct-io.c         |   19 -
 fs/iomap/direct-io.c   |   38 ++-
 include/linux/fs.h     |    2
 include/linux/iomap.h  |    5
 9 files changed, 355 insertions(+), 424 deletions(-)



