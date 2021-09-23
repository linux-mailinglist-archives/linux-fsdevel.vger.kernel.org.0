Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0BE415AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhIWJ1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 05:27:00 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:43533 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240124AbhIWJ07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:26:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpJnqxn_1632389126;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpJnqxn_1632389126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 17:25:27 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v5 0/5] fuse,virtiofs: support per-file DAX
Date:   Thu, 23 Sep 2021 17:25:21 +0800
Message-Id: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
eventually gave up since the complexity of the implementation [4][5][6][7].

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

chanegs since v4:
- drop support for setting/clearing FS_DAX inside guest
- and thus drop the negotiation phase during FUSE_INIT

changes since v3:
- bug fix (patch 6): s/"IS_DAX(inode) != newdax"/"!!IS_DAX(inode) !=
  newdax"
- during FUSE_INIT, advertise capability for per-file DAX only when
  mounted as "-o dax=inode" (patch 4)

changes since v2:
- modify fuse_show_options() accordingly to make it compatible with
  new tri-state mount option (patch 2)
- extract FUSE protocol changes into one seperate patch (patch 3)
- FUSE server/client need to negotiate if they support per-file DAX
  (patch 4)
- extract DONT_CACHE logic into patch 6/7

v4: https://lore.kernel.org/linux-fsdevel/20210817022220.17574-1-jefflexu@linux.alibaba.com/
v3: https://www.spinics.net/lists/linux-fsdevel/msg200852.html
v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html


Jeffle Xu (5):
  fuse: add fuse_should_enable_dax() helper
  fuse: make DAX mount option a tri-state
  fuse: support per-file DAX
  fuse: enable per-file DAX
  fuse: mark inode DONT_CACHE when per-file DAX hint changes

 fs/fuse/dax.c             | 32 +++++++++++++++++++++++++++++---
 fs/fuse/file.c            |  4 ++--
 fs/fuse/fuse_i.h          | 19 +++++++++++++++----
 fs/fuse/inode.c           | 15 +++++++++++----
 fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
 include/uapi/linux/fuse.h |  7 ++++++-
 6 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.27.0

