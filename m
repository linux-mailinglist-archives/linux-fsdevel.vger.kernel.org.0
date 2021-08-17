Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1883EE43C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 04:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhHQCW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 22:22:56 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33600 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233528AbhHQCWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:22:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjH7KAY_1629166940;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UjH7KAY_1629166940)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 10:22:21 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Date:   Tue, 17 Aug 2021 10:22:12 +0800
Message-Id: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
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


changes since v3:
- bug fix (patch 6): s/"IS_DAX(inode) != newdax"/"!!IS_DAX(inode) != newdax"
- during FUSE_INIT, advertise capability for per-file DAX only when
  mounted as "-o dax=inode" (patch 4)

changes since v2:
- modify fuse_show_options() accordingly to make it compatible with
  new tri-state mount option (patch 2)
- extract FUSE protocol changes into one seperate patch (patch 3)
- FUSE server/client need to negotiate if they support per-file DAX
  (patch 4)
- extract DONT_CACHE logic into patch 6/7

v3: https://www.spinics.net/lists/linux-fsdevel/msg200852.html
v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html

Jeffle Xu (8):
  fuse: add fuse_should_enable_dax() helper
  fuse: Make DAX mount option a tri-state
  fuse: support per-file DAX
  fuse: negotiate if server/client supports per-file DAX
  fuse: enable per-file DAX
  fuse: mark inode DONT_CACHE when per-file DAX indication changes
  fuse: support changing per-file DAX flag inside guest
  fuse: show '-o dax=inode' option only when FUSE server supports

 fs/fuse/dax.c             | 32 +++++++++++++++++++++++++++++---
 fs/fuse/file.c            |  4 ++--
 fs/fuse/fuse_i.h          | 22 ++++++++++++++++++----
 fs/fuse/inode.c           | 27 +++++++++++++++++++--------
 fs/fuse/ioctl.c           | 15 +++++++++++++--
 fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
 include/uapi/linux/fuse.h |  9 ++++++++-
 7 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.27.0

