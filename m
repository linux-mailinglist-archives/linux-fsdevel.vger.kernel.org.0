Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3074EF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFUT2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 15:28:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfFUT2e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:28:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38636AEE9;
        Fri, 21 Jun 2019 19:28:33 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com
Subject: [PATCH 0/6] Btrfs iomap
Date:   Fri, 21 Jun 2019 14:28:22 -0500
Message-Id: <20190621192828.28900-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an effort to use iomap with btrfs. This would keep most
responsibility of page handling during writes in iomap code, hence
code reduction. For CoW support, changes are needed in iomap code
to make sure we perform a copy before the write.
This is in line with the discussion we had during adding dax support in
btrfs.

Efforts on adding dax support have been put on hold until MM experts can
come with a way of performing multiple mappings to a single page
(primarily the TODO before dax_associate_entry()). While we are waiting
on that we could add support for buffered writes in btrfs.

I have managed to add Direct I/O with iomap support as well, but it
still needs to be refined with respect to locking. If you are
interested in that effort (on top of this one), it is available
at [1].

[1] https://github.com/goldwynr/linux/tree/btrfs-iomap


 fs/btrfs/Makefile     |    2 
 fs/btrfs/ctree.h      |    1 
 fs/btrfs/file.c       |  468 --------------------------------------------------
 fs/btrfs/iomap.c      |  430 +++++++++++++++++++++++++++++++++++++++++++++
 fs/dax.c              |    8 
 fs/ext2/inode.c       |    2 
 fs/ext4/inode.c       |    2 
 fs/gfs2/bmap.c        |    3 
 fs/internal.h         |    2 
 fs/iomap.c            |   45 ++--
 fs/xfs/xfs_iomap.c    |    9 
 include/linux/iomap.h |    7 
 12 files changed, 479 insertions(+), 500 deletions(-)


