Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB33CB654
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhGPKuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:50:50 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58293 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232622AbhGPKut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:50:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UfyVhOl_1626432473;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfyVhOl_1626432473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 18:47:53 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
Date:   Fri, 16 Jul 2021 18:47:49 +0800
Message-Id: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset adds support of per-file DAX for virtiofs, which is
inspired by Ira Weiny's work on ext4[1] and xfs[2].

There are three related scenarios:
1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
2. Per-file DAX flag changes when the file has been opened. (patch 3)
In this case, the dentry and inode are all marked as DONT_CACHE, and
the DAX state won't be updated until the file is closed and reopened
later.
3. Users can change the per-file DAX flag inside the guest by chattr(1).
(patch 4)
4. Create new files under directories with DAX enabled. When creating
new files in ext4/xfs on host, the new created files will inherit the
per-file DAX flag from the directory, and thus the new created files in
virtiofs will also inherit the per-file DAX flag if the fuse server
derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
DAX flag.


Any comment is welcome.

[1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
[2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")


changes since v1:
- add support for changing per-file DAX flags inside guest (patch 4)

v1:https://www.spinics.net/lists/linux-virtualization/msg51008.html

Jeffle Xu (4):
  fuse: add fuse_should_enable_dax() helper
  fuse: Make DAX mount option a tri-state
  fuse: add per-file DAX flag
  fuse: support changing per-file DAX flag inside guest

 fs/fuse/dax.c             | 36 ++++++++++++++++++++++++++++++++++--
 fs/fuse/file.c            |  4 ++--
 fs/fuse/fuse_i.h          | 16 ++++++++++++----
 fs/fuse/inode.c           |  7 +++++--
 fs/fuse/ioctl.c           |  9 ++++++---
 fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
 include/uapi/linux/fuse.h |  5 +++++
 7 files changed, 78 insertions(+), 15 deletions(-)

-- 
2.27.0

