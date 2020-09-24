Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A942776E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgIXQji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:39:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQji (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:39:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F965ABD1;
        Thu, 24 Sep 2020 16:39:36 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com
Subject: [PATCH 0/14 v3] BTRFS DIO inode locking/D_SYNC fix
Date:   Thu, 24 Sep 2020 11:39:07 -0500
Message-Id: <20200924163922.2547-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series attempts to arrange inode locking and unlocking to be more
aligned to ext4 and xfs handling of things, and makes it simpler in
logic. The main goal is to have shared inode lock for direct reads and
direct writes within EOF to make sure we do not race with truncate.

I have merged two series here:
(1) Using inode_lock_shared for <EOF DIO writes
(2) Fix O_DSYNC | O_DIRECT

Both require inode locking to be pushed closer to I/O calls and thought
was relevant. (2) requires changes in iomap code.

Tested xfstests on btrfs, ext4 and xfs

Git: https://github.com/goldwynr/linux/tree/btrfs-inode-lock

Changes since v1:

 - Changed fix for deadlock due to O_DSYNC (iomap patches added)
 - btrfs_inode_lock() shifted to inode.c
 - Reinstated lockdep_assert_held() in iomap_dio_rw()

Changes since v2:
 - Review comments incorporated:
   - comments got BTRFS_SUPER_FLAG_ERROR deleted
   - Function comments for btrfs_inode_lock()/unlock()
   - Unsetting current->backing_dev_info
 - Corrected ret from __iomap_dio_rw()
 - Removed unused err in btrfs_file_write_iter()

--
Goldwyn



