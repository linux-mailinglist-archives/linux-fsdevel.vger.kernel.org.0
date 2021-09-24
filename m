Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65287417997
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347588AbhIXRTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344766AbhIXRTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eQGrOpfP233mFmIfFg/o+cJ+c+v9gOkxJH/IeGmKkL0=;
        b=HEk5ozOJBbmSwdKPtFE9h7rlnwXj6vdONxfi038CQajJQX+2ewwpQoYjuiHcf20YDgSqD5
        THijPNHOnfoqOcEbb2QPqYwCZPUAFTUcKjwU1tJmRp+HYmqdTCXD/sgGdSIBh9FxvZ+9cH
        RNpjd3E1+Dn9vf88rWX1rhdFJTjWIrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-POZdDApVPBmG1-VdzFXypg-1; Fri, 24 Sep 2021 13:18:05 -0400
X-MC-Unique: POZdDApVPBmG1-VdzFXypg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED37B8015C7;
        Fri, 24 Sep 2021 17:17:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B39FD19D9B;
        Fri, 24 Sep 2021 17:17:53 +0000 (UTC)
Subject: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        Bob Liu <bob.liu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Steve French <sfrench@samba.org>, NeilBrown <neilb@suse.de>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        linux-btrfs@vger.kernel.org, dhowells@redhat.com,
        dhowells@redhat.com, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:17:52 +0100
Message-ID: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Willy, Trond, Christoph,

Here's v3 of a change to make reads and writes from the swapfile use async
DIO, adding a new ->swap_rw() address_space method, rather than readpage()
or direct_IO(), as requested by Willy.  This allows NFS to bypass the write
checks that prevent swapfiles from working, plus a bunch of other checks
that may or may not be necessary.

Whilst trying to make this work, I found that NFS's support for swapfiles
seems to have been non-functional since Aug 2019 (I think), so the first
patch fixes that.  Question is: do we actually *want* to keep this
functionality, given that it seems that no one's tested it with an upstream
kernel in the last couple of years?

There are additional patches to get rid of noop_direct_IO and replace it
with a feature bitmask, to make btrfs, ext4, xfs and raw blockdevs use the
new ->swap_rw method and thence remove the direct BIO submission paths from
swap.

I kept the IOCB_SWAP flag, using it to enable REQ_SWAP.  I'm not sure if
that's necessary, but it seems accounting related.

The synchronous DIO I/O code on NFS, raw blockdev, ext4 swapfile and xfs
swapfile all seem to work fine.  Btrfs refuses to swapon because the file
might be CoW'd.  I've tried doing "chattr +C", but that didn't help.

The async DIO paths fail spectacularly (from I/O errors to ATA failure
messages on the test disk using a normal swapspace); NFS just hangs.

My patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=swap-dio

I tested this using the procedure and program outlined in the NFS patch.

I also encountered occasional instances of the following warning with NFS, so
I'm wondering if there's a scheduling problem somewhere:

BUG: workqueue lockup - pool cpus=0-3 flags=0x5 nice=0 stuck for 34s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 6: cpus=3 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    in-flight: 1565:fill_page_cache_func
workqueue events_highpri: flags=0x10
  pwq 3: cpus=1 node=0 flags=0x1 nice=-20 active=1/256 refcnt=2
    in-flight: 1547:fill_page_cache_func
  pwq 1: cpus=0 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
    in-flight: 1811:fill_page_cache_func
workqueue events_unbound: flags=0x2
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=3/512 refcnt=5
    pending: fsnotify_connector_destroy_workfn, fsnotify_mark_destroy_workfn, cleanup_offline_cgwbs_workfn
workqueue events_power_efficient: flags=0x82
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=4/256 refcnt=6
    pending: neigh_periodic_work, neigh_periodic_work, check_lifetime, do_cache_clean
workqueue writeback: flags=0x4a
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=1/256 refcnt=4
    in-flight: 433(RESCUER):wb_workfn
workqueue rpciod: flags=0xa
  pwq 8: cpus=0-3 flags=0x5 nice=0 active=38/256 refcnt=40
    in-flight: 7:rpc_async_schedule, 1609:rpc_async_schedule, 1610:rpc_async_schedule, 912:rpc_async_schedule, 1613:rpc_async_schedule, 1631:rpc_async_schedule, 34:rpc_async_schedule, 44:rpc_async_schedule
    pending: rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule, rpc_async_schedule
workqueue ext4-rsv-conversion: flags=0x2000a
pool 1: cpus=0 node=0 flags=0x0 nice=-20 hung=59s workers=2 idle: 6
pool 3: cpus=1 node=0 flags=0x1 nice=-20 hung=43s workers=2 manager: 20
pool 6: cpus=3 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 498 29
pool 8: cpus=0-3 flags=0x5 nice=0 hung=34s workers=9 manager: 1623
pool 9: cpus=0-3 flags=0x5 nice=-20 hung=0s workers=2 manager: 5224 idle: 859

Note that this is due to DIO writes to NFS only, as far as I can tell, and
that no reads had happened yet.

Changes:
========
ver #3:
   - Introduced a new ->swap_rw() method.
   - Added feature support flags to the address_space_operations struct and
     got rid of the checks for ->direct_() and noop_direct_IO() and
     similar.
   - Implemented swap_rw for nfs, adjusting the direct I/O code paths.
   - Implemented swap_rw for blockdev, btrfs, ext4 and xfs.
   - Got rid of the return value on swap_readpage() as it's never checked.

ver #2:
   - Remove the callback param to __swap_writepage() as it's invariant.
   - Allocate the kiocb on the stack in sync mode.
   - Do an async DIO write if WB_SYNC_ALL isn't set.
   - Try to remove the BIO submission paths.

David

Link: https://lore.kernel.org/r/162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk/ # v2
---
David Howells (9):
      mm: Remove the callback func argument from __swap_writepage()
      mm: Add 'supports' field to the address_space_operations to list features
      mm: Make swap_readpage() void
      Introduce IOCB_SWAP kiocb flag to trigger REQ_SWAP
      mm: Make swap_readpage() for SWP_FS_OPS use ->swap_rw() not ->readpage()
      mm: Make __swap_writepage() do async DIO if asked for it
      nfs: Fix write to swapfile failure due to generic_write_checks()
      block, btrfs, ext4, xfs: Implement swap_rw
      mm: Remove swap BIO paths and only use DIO paths


 Documentation/filesystems/vfs.rst |   8 +
 block/fops.c                      |   2 +
 drivers/block/loop.c              |   6 +-
 fs/9p/vfs_addr.c                  |   1 +
 fs/affs/file.c                    |   1 +
 fs/btrfs/inode.c                  |  14 +-
 fs/ceph/addr.c                    |  13 +-
 fs/cifs/file.c                    |  21 +-
 fs/direct-io.c                    |   2 +
 fs/erofs/data.c                   |   2 +-
 fs/exfat/inode.c                  |   1 +
 fs/ext2/inode.c                   |   4 +-
 fs/ext4/inode.c                   |  17 +-
 fs/f2fs/data.c                    |   1 +
 fs/fat/inode.c                    |   1 +
 fs/fcntl.c                        |   2 +-
 fs/fuse/dax.c                     |   2 +-
 fs/fuse/file.c                    |   1 +
 fs/gfs2/aops.c                    |   2 +-
 fs/hfs/inode.c                    |   1 +
 fs/hfsplus/inode.c                |   1 +
 fs/jfs/inode.c                    |   1 +
 fs/libfs.c                        |  12 -
 fs/nfs/direct.c                   |  28 +--
 fs/nfs/file.c                     |  15 +-
 fs/nilfs2/inode.c                 |   1 +
 fs/ntfs3/inode.c                  |   1 +
 fs/ocfs2/aops.c                   |   1 +
 fs/open.c                         |   3 +-
 fs/orangefs/inode.c               |   1 +
 fs/overlayfs/file.c               |   2 +-
 fs/overlayfs/inode.c              |   3 +-
 fs/reiserfs/inode.c               |   1 +
 fs/udf/file.c                     |   1 +
 fs/udf/inode.c                    |   1 +
 fs/xfs/xfs_aops.c                 |  13 +-
 fs/zonefs/super.c                 |   2 +-
 include/linux/bio.h               |   2 +
 include/linux/fs.h                |   7 +-
 include/linux/nfs_fs.h            |   2 +-
 include/linux/swap.h              |   2 +-
 mm/page_io.c                      | 356 +++++++++++++++---------------
 mm/swapfile.c                     |   4 +-
 43 files changed, 275 insertions(+), 287 deletions(-)


