Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97AE38B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfFGNLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53156 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfFGNLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913072; x=1591449072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zNdfBMk/0Ll1/6zgIVFQjA05zAgxi2hPkJU9V5VK9MI=;
  b=Qa2GLaMRXSPv4VrQqKRYlFK/yd6Lt6Zba/f4xN4Z4VKXhj1Xd5LedR7v
   KdIkOdow287t7QfYReVq7k0jAlqyj9BmLmEx6262Lt5yV0DctaYYonhoR
   wUSw4rbfUZtLyI5GCl3MpX/xQ3joy0oFFiyOIrngdMVnFNpXKj3wMkhXN
   g9s6LZH4esNIfQRs0CFUktR2O3V7FalWV1IQH/OH+l6hXHcrAlHf8gpl9
   6CoC1FDugIUw4vejdNYI3U2339ft1GMUtAOdXWRK4F7xfNpW4JT7pw+5x
   Q7/r36286LgtLzXyrPEKOxFzyY1ljJfk57+tJlJHB7VFPqCZ3w7ypjtPr
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027757"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:12 +0800
IronPort-SDR: 0G7vY6zepLWCadsUy8exvEQQrd+Tc/fA2wgYSmVfcRCIoh4UlVFcSrKVD31Hu6mmT7mZvV9HBh
 jv4w0IfCcmbxwgcofLOqeOOHAjQVDJqPc6+aC/iIFkvahW/su7ii/o78FtqAcvtKGQJdf7dUyU
 RInhdkxFUpKzs36+uClUsIpO73LzD52rm299PlH7D8/GenHACfR1Q0mjYBSLwha89knd/itv9b
 OWIEKmGl7G40wLbYX6PTwSjh+DcvHetyxp2FCSD1gg+kCl4nLo9Adzb+wsFt5TRpxZgdrYuhn7
 MySI5q37lR84hK/gNfEsfXiP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:29 -0700
IronPort-SDR: M58K70zWa5mGNsVrm8EEyhuoYywykETbgsLM+fZK9R8XlrMyVdQQYpmfF+IsgBzfDaJa0M1vgA
 /VaxxsFQJEQpekfHjjYSzyPtzi22+MqIesmqi1kJXLoClb6l05SqUbEEypO77EOO654NNDUWtX
 K40LdoMg7U7bnLiWzRjMLaclZbMdFdRM9Wmu45NkFywjqTTGnI6QAO2l7LJVy7cutv3OuP3Puh
 kZtQh7fzHHztOLuaMzH1m+GpmkAvoaywLTWMIiWd/n8OVaKVo1EVLVmOcZAJhsE5irSgGm+cjs
 BdE=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 00/19] btrfs zoned block device support
Date:   Fri,  7 Jun 2019 22:10:06 +0900
Message-Id: <20190607131025.31996-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs zoned block device support

This series adds zoned block device support to btrfs.

A zoned block device consists of a number of zones. Zones are either
conventional and accepting random writes or sequential and requiring that
writes be issued in LBA order from each zone write pointer position. This
patch series ensures that the sequential write constraint of sequential
zones is respected while fundamentally not changing BtrFS block and I/O
management for block stored in conventional zones.

To achieve this, the default chunk size of btrfs is changed on zoned block
devices so that chunks are always aligned to a zone. Allocation of blocks
within a chunk is changed so that the allocation is always sequential from
the beginning of the chunks. To do so, an allocation pointer is added to
block groups and used as the allocation hint.  The allocation changes also
ensures that block freed below the allocation pointer are ignored,
resulting in sequential block allocation regardless of the chunk usage.

While the introduction of the allocation pointer ensure that blocks will be
allocated sequentially, I/Os to write out newly allocated blocks may be
issued out of order, causing errors when writing to sequential zones. This
problem s solved by introducing a submit_buffer() function and changes to
the internal I/O scheduler to ensure in-order issuing of write I/Os for
each chunk and corresponding to the block allocation order in the chunk.

The zone of a chunk is reset to allow reuse of the zone only when the block
group is being freed, that is, when all the chunks of the block group are
unused.

For btrfs volumes composed of multiple zoned disks, restrictions are added
to ensure that all disks have the same zone size. This matches the existing
constraint that all chunks in a block group must have the same size.

As discussed with Chris Mason in LSFMM, we enabled device replacing in
HMZONED mode. But still drop fallocate for now.

Patch 1 introduces the HMZONED incompatible feature flag to indicate that
the btrfs volume was formatted for use on zoned block devices.

Patches 2 and 3 implement functions to gather information on the zones of
the device (zones type and write pointer position).

Patches 4 and 5 disable features which are not compatible with the
sequential write constraints of zoned block devices. This includes
fallocate and direct I/O support.

Patches 6 and 7 tweak the extent buffer allocation for HMZONED mode to
implement sequential block allocation in block groups and chunks.

Patch 8 mark block group read only when write pointers of devices which
compose e.g. RAID1 block group devices are mismatch.

Patch 9 restrict the possible locations of super blocks to conventional
zones to preserve the existing update in-place mechanism for the super
blocks.

Patches 10 to 12 implement the new submit buffer I/O path to ensure
sequential write I/O delivery to the device zones.

Patches 13 to 17 modify several parts of btrfs to handle free blocks
without breaking the sequential block allocation and sequential write order
as well as zone reset for unused chunks.

Patch 18 add support for device replacing.

Finally, patch 19 adds the HMZONED feature to the list of supported
features.

This series applies on kdave/for-5.2-rc2.

Changelog
v2:
 - Add support for dev-replace
 -- To support dev-replace, moved submit_buffer one layer up. It now
    handles bio instead of btrfs_bio.
 -- Mark unmirrored Block Group readonly only when there is writable
    mirrored BGs. Necessary to handle degraded RAID.
 - Expire worker use vanilla delayed_work instead of btrfs's async-thread
 - Device extent allocator now ensure that region is on the same zone type.
 - Add delayed allocation shrinking.
 - Rename btrfs_drop_dev_zonetypes() to btrfs_destroy_dev_zonetypes
 - Fix
 -- Use SECTOR_SHIFT (Nikolay)
 -- Use btrfs_err (Nikolay)

Naohiro Aota (19):
  btrfs: introduce HMZONED feature flag
  btrfs: Get zone information of zoned block devices
  btrfs: Check and enable HMZONED mode
  btrfs: disable fallocate in HMZONED mode
  btrfs: disable direct IO in HMZONED mode
  btrfs: align dev extent allocation to zone boundary
  btrfs: do sequential extent allocation in HMZONED mode
  btrfs: make unmirroed BGs readonly only if we have at least one
    writable BG
  btrfs: limit super block locations in HMZONED mode
  btrfs: rename btrfs_map_bio()
  btrfs: introduce submit buffer
  btrfs: expire submit buffer on timeout
  btrfs: avoid sync IO prioritization on checksum in HMZONED mode
  btrfs: redirty released extent buffers in sequential BGs
  btrfs: reset zones of unused block groups
  btrfs: wait existing extents before truncating
  btrfs: shrink delayed allocation size in HMZONED mode
  btrfs: support dev-replace in HMZONED mode
  btrfs: enable to mount HMZONED incompat flag

 fs/btrfs/ctree.h             |  47 ++-
 fs/btrfs/dev-replace.c       | 103 ++++++
 fs/btrfs/disk-io.c           |  49 ++-
 fs/btrfs/disk-io.h           |   1 +
 fs/btrfs/extent-tree.c       | 479 +++++++++++++++++++++++-
 fs/btrfs/extent_io.c         |  28 ++
 fs/btrfs/extent_io.h         |   2 +
 fs/btrfs/file.c              |   4 +
 fs/btrfs/free-space-cache.c  |  33 ++
 fs/btrfs/free-space-cache.h  |   5 +
 fs/btrfs/inode.c             |  14 +
 fs/btrfs/scrub.c             | 171 +++++++++
 fs/btrfs/super.c             |  30 +-
 fs/btrfs/sysfs.c             |   2 +
 fs/btrfs/transaction.c       |  35 ++
 fs/btrfs/transaction.h       |   3 +
 fs/btrfs/volumes.c           | 684 ++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h           |  37 ++
 include/trace/events/btrfs.h |  43 +++
 include/uapi/linux/btrfs.h   |   1 +
 20 files changed, 1734 insertions(+), 37 deletions(-)

-- 
2.21.0

