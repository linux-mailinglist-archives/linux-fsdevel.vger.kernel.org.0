Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1424426AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 06:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBF2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 01:28:42 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54298 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhKBF2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:28:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uuh8MWr_1635830764;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uuh8MWr_1635830764)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 13:26:04 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v7 0/7] fuse,virtiofs: support per-file DAX
Date:   Tue,  2 Nov 2021 13:25:57 +0800
Message-Id: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since v6:
- rename the feature bit of FUSE_INIT to 'FUSE_HAS_INODE_DAX'
- rename 'per-file DAX' to 'per inode DAX'

Some user visible behavior elaboration:
1. The default behavior equals to 'dax=inode' when neither '-o dax' nor
'-o dax=always|never|inode' is specified.
2. It will silently fallback to 'dax=never' if server doesn't support
per inode DAX when it's in 'dax=inode' mode, no matter whether it's
mounted in 'dax=inode' mode explicitly or by default. Thus virtiofs can
be consistnet with ext4/xfs, since 'dax=inode' is advisory only.
Server may not support per inode DAX due to the following reasons:
  - the virtiofs device doesn't support DAX at all
    (VIRTIO_FS_SHMCAP_ID_CACHE not defined at all)
  - server's map alignment is non-compliant (fail
    fuse_dax_check_alignment())
  - server doesn't advertise support for per inode DAX
    (FUSE_HAS_INODE_DAX) during FUSE_INIT
3. As said before, the default behavior equals to 'dax=inode' when no
DAX related mount option specified, however it won't be printed among
the mount option. (consistnet with ext4/xfs).
4. As said before, it may fallback to 'dax=never' when it's in
'dax=inode' mode, however the mount option will always be printed as
'dax=inode'. (same as ext4, though xfs indeed print 'dax=never' if
it fallback to 'dax=never')
5. By default per inode DAX won't be enabled on the virtiofsd side, and
thus guest virtiofs will see that all files are DAX disabled though it
works in 'dax=inode' mode by default. That is, the default behavior won't
surprise users. If users indeed want to use per inode DAX feature, then
they need to enable this feature *explicitly* on the virtiofsd side.

v6: https://lore.kernel.org/all/20211011030052.98923-1-jefflexu@linux.alibaba.com/
v5: https://lore.kernel.org/all/20210923092526.72341-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/linux-fsdevel/20210817022220.17574-1-jefflexu@linux.alibaba.com/
v3: https://www.spinics.net/lists/linux-fsdevel/msg200852.html
v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html


Original Rationale for this Patchset
====================================

This patchset adds support of per-file DAX for virtiofs, which is
inspired by Ira Weiny's work on ext4[1] and xfs[2].

Any comment is welcome.

[1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
[2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")

[Purpose]
DAX may be limited in some specific situation. When the number of usable
DAX windows is under watermark, the recalim routine will be triggered to
reclaim some DAX windows. It may have a negative impact on the
performance, since some processes may need to wait for DAX windows to be
recalimed and reused then. To mitigate the performance degradation, the
overall DAX window need to be expanded larger.

However, simply expanding the DAX window may not be a good deal in some
scenario. To maintain one DAX window chunk (i.e., 2MB in size), 32KB
(512 * 64 bytes) memory footprint will be consumed for page descriptors
inside guest, which is greater than the memory footprint if it uses
guest page cache when DAX disabled. Thus it'd better disable DAX for
those files smaller than 32KB, to reduce the demand for DAX window and
thus avoid the unworthy memory overhead.

Per-file DAX feature is introduced to address this issue, by offering a
finer grained control for dax to users, trying to achieve a balance
between performance and memory overhead.


[Note]
When the per-file DAX hint changes while the file is still *opened*, it
is quite complicated and maybe fragile to dynamically change the DAX
state, since dynamic switching needs to switch a_ops atomiclly. Ira
Weiny had ever implemented a so called i_aops_sem lock [3] but
eventually gave up since the complexity of the implementation
[4][5][6][7].

Hence mark the inode and corresponding dentries as DONE_CACHE once the
per-file DAX hint changes, so that the inode instance will be evicted
and freed as soon as possible once the file is closed and the last
reference to the inode is put. And then when the file gets reopened next
time, the new instantiated inode will reflect the new DAX state.

In summary, when the per-file DAX hint changes for an *opened* file, the
DAX state of the file won't be updated until this file is closed and
reopened later. This is also how ext4/xfs per-file DAX works.

[3] https://lore.kernel.org/lkml/20200227052442.22524-7-ira.weiny@intel.com/
[4] https://patchwork.kernel.org/project/xfs/cover/20200407182958.568475-1-ira.weiny@intel.com/
[5] https://lore.kernel.org/lkml/20200305155144.GA5598@lst.de/
[6] https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
[7] https://lore.kernel.org/lkml/20200403182904.GP80283@magnolia/

Jeffle Xu (7):
  fuse: add fuse_should_enable_dax() helper
  fuse: make DAX mount option a tri-state
  fuse: support per inode DAX in fuse protocol
  fuse: enable per inode DAX
  fuse: negotiate per inode DAX in FUSE_INIT
  fuse: mark inode DONT_CACHE when per inode DAX hint changes
  Documentation/filesystem/dax: record DAX on virtiofs

 Documentation/filesystems/dax.rst | 20 +++++++++++++++++--
 fs/fuse/dax.c                     | 32 +++++++++++++++++++++++++++++--
 fs/fuse/file.c                    |  4 ++--
 fs/fuse/fuse_i.h                  | 28 +++++++++++++++++++++++----
 fs/fuse/inode.c                   | 31 +++++++++++++++++++++++-------
 fs/fuse/virtio_fs.c               | 18 ++++++++++++++---
 include/uapi/linux/fuse.h         |  9 ++++++++-
 7 files changed, 121 insertions(+), 21 deletions(-)

-- 
2.27.0

