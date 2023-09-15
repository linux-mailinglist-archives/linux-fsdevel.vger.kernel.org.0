Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184E7A296E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjIOVd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjIOVdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54DF7;
        Fri, 15 Sep 2023 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yV0EfbURKJh4PDYaNYUDtuXfuSlOqQYcsl+NeN4c8pU=; b=LXYofCU61UT766npBrb7d4bqPz
        I8maRneOkt/otlO6AmfY3gCmoxvXu+qP88lIcpICnNwKOVhF0uPVrLBxoRdTfghz+apCgLs3Em1Bi
        EBDweNYcg6qZW98TkDkbtz4pz0Yee6Gec+a9mzOB480fC/vME2k7TqfvWSuLtmpm+IvrW9Ru1LcXM
        DRlcbHbLchQM7mhA0g2ZWfn+46YQ3tK8mAfsYYLq6Q/Min/o1D6XsLBbY2YfsTB29+S4tR0Ojkor5
        zJyWDdA367BmuJ1kAH3JTyp7nBwpF8Mnbax0PT+6B22hutkF7ShUPUfVOs3AaPpMIJSKXVk/G7rfk
        dhYE93fw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQn6-0A;
        Fri, 15 Sep 2023 21:32:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc:     willy@infradead.org, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com, mcgrof@kernel.org
Subject: [RFC v2 00/10] bdev: LBS devices support to coexist with buffer-heads
Date:   Fri, 15 Sep 2023 14:32:44 -0700
Message-Id: <20230915213254.2724586-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph added CONFIG_BUFFER_HEAD on v6.1 enabling a world where we can
live without buffer-heads. When we opt into that world we end up also
using the address space operations of the block device cache using
iomap. Since iomap supports higher order folios it means then that block
devices which do use the iomap aops can end up having a logical block
size or physical block size greater than PAGE_SIZE. We refer to these as
LBS devices. This in turn allows filesystems which support bs > 4k to be
enabled on a 4k PAGE_SIZE world on LBS block devices. This alows LBS
device then to take advantage of the recenlty posted work today to enable
LBS support for filesystems [0].

However, an issue is that disabling CONFIG_BUFFER_HEAD in practice is not viable
for many Linux distributions since it also means disabling support for most
filesystems other than btrfs and XFS. So we either support larger order folios
on buffer-heads, or we draw up a solution to enable co-existence. Since at LSFMM
2023 it was decided we would not support larger order folios on buffer-heads,
this takes the approach to help support co-existence between using buffer-head
based filesystems and using the iomap aops dynamically when needed on block
devices. Folks who want to enhance buffer-heads to support larger order folios
can do so in parallel to this effort. This just allows iomap based filesystems
to support LBS block devices today while also allowing buffer-head based
filesystems to be used on them as well the LBS device also supports a
logical block of PAGE_SIZE.

LBS devices can come in a few flavors. Adopting larger LBA format enables a
logical block sizes to be > 4k. Different block device mechanisms which can also
increase a block device's physical block size to be larger than 4k while still
retaining backward compatibility with a logical block size of 4k. An example is
NVMe drives with an LBA format of 4k and an npwg and awupf | nawupf of 16k. With
this you a logical block size of 4k and a physical block size of 16k. Drives
which do this may be a reality as larger Indirection Units (IUs) on QLC adopt
IUs larger than 4k so to better support larger capacity. At least OCP 2.0 does
require you to expose the IU through npwg. Whether or not a device supports the
same value for awupf | nawupf (large atomic) is device specific. Devices which
*do* sport an LBA format of 4k and npwg & awupf | nawupf >= 16k essentially can
benefit from LBS support such as with XFS [1].

While LBS devices come to market folks can also experiment with NVMe today
what some of this might be like by ignoring power failure and faking the larger
atomic up to the NVMe awun. When the NVMe awun is 0xffff it means awun is
MDTS, so for those drives, in practice you can experiment today with LBS
up to MDTS with real drives. This is documented on the kdevops documentation
for LBS by using something like nvme_core.debug_large_atomics=16384 [2].

To experiment with larger LBA formtas you can also use kdevops and enable
CONFIG_QEMU_ENABLE_EXTRA_DRIVE_LARGEIO. That enables a ton of drives with
logical and physical block sizes >= 4k up to a desriable max target for
experimentation. Since filesystems today only support up to 32k sector sizes,
in practice you may only want to experiment up to 32k physical / logical.

Support for 64k sector sizes requires an XFS format change, which is something
Daniel Gomez has experimental patches for, in case folks are interested in
messing with.

Patch 6 could probably be squashed with patch 5, but I wanted to be
explicit about this, as this should be decided with the community.

There might be a better way to do this than do deal with the switching
of the aops dynamically, ideas welcomed!

The NVMe debug patches are posted for pure experimentation purposes, but
the AWUN patch might be welcomed upsteram. Unless folks really want it,
the goal here is *not* to upstream the support for the debug module
parameter nvme_core.debug_large_atomics=16384. On a v3 RFC I can drop those
patches and just aim to simplify the logic to support LBA formats > ps.

Changes since v1 RFC:

  o Modified the approach to accept we can have different aops per super block
    on the block device cache as suggested by Christoph
  o Try to allow dynamically switching between iomap aops and buffer-head aops
  o Use the iomap aops if the target block size order or min order > ps
  o Loosten restrictions on set_blocksize() so to just check for the iomap
    aops for now, making it easy to allow buffer-heads to later add support
    for bs > ps as well
  o Use buffer-head aops first always unless the min order is > ps so to always
    support buffer-head based filesystems
  o Adopt a flag for buffer-heads so to check for support, buffer-heads based
    filesystems cannot be used while an LBS filesystem is being used, for
    instance
  o Allow iomap aops to be used when the physical block size is > ps as well
  o NVMe changes to experiment with LBS devices without power failure
  o NVMe changes to support LBS devices

[0] https://lkml.kernel.org/r/20230608032404.1887046-1-mcgrof@kernel.org
[1] https://lkml.kernel.org/r/20230915183848.1018717-1-kernel@pankajraghav.com
[2] https://github.com/linux-kdevops/kdevops/blob/master/docs/lbs.md

Luis Chamberlain (10):
  bdev: rename iomap aops
  bdev: dynamically set aops to enable LBS support
  bdev: increase bdev max blocksize depending on the aops used
  filesystems: add filesytem buffer-head flag
  bdev: allow to switch between bdev aops
  bdev: simplify coexistance
  nvme: enhance max supported LBA format check
  nvme: add awun / nawun sanity check
  nvme: add nvme_core.debug_large_atomics to force high awun as phys_bs
  nvme: enable LBS support

 block/bdev.c             | 73 ++++++++++++++++++++++++++++++++++++++--
 block/blk.h              |  1 +
 block/fops.c             | 14 ++++----
 drivers/nvme/host/core.c | 70 +++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 fs/adfs/super.c          |  2 +-
 fs/affs/super.c          |  2 +-
 fs/befs/linuxvfs.c       |  2 +-
 fs/bfs/inode.c           |  2 +-
 fs/efs/super.c           |  2 +-
 fs/exfat/super.c         |  2 +-
 fs/ext2/super.c          |  2 +-
 fs/ext4/super.c          |  7 ++--
 fs/f2fs/super.c          |  2 +-
 fs/fat/namei_msdos.c     |  2 +-
 fs/fat/namei_vfat.c      |  2 +-
 fs/freevxfs/vxfs_super.c |  2 +-
 fs/gfs2/ops_fstype.c     |  4 +--
 fs/hfs/super.c           |  2 +-
 fs/hfsplus/super.c       |  2 +-
 fs/isofs/inode.c         |  2 +-
 fs/jfs/super.c           |  2 +-
 fs/minix/inode.c         |  2 +-
 fs/nilfs2/super.c        |  2 +-
 fs/ntfs/super.c          |  2 +-
 fs/ntfs3/super.c         |  2 +-
 fs/ocfs2/super.c         |  2 +-
 fs/omfs/inode.c          |  2 +-
 fs/qnx4/inode.c          |  2 +-
 fs/qnx6/inode.c          |  2 +-
 fs/reiserfs/super.c      |  2 +-
 fs/super.c               |  3 +-
 fs/sysv/super.c          |  4 +--
 fs/udf/super.c           |  2 +-
 fs/ufs/super.c           |  2 +-
 include/linux/blkdev.h   |  7 ++++
 include/linux/fs.h       |  1 +
 37 files changed, 189 insertions(+), 48 deletions(-)

-- 
2.39.2

