Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA2428569
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 05:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhJKDDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 23:03:02 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:51721 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233705AbhJKDC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:02:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UrJTOYb_1633921256;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UrJTOYb_1633921256)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 11:00:57 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hub
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v6 7/7] Documentation/filesystem/dax: record DAX on virtiofs
Date:   Mon, 11 Oct 2021 11:00:52 +0800
Message-Id: <20211011030052.98923-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Record DAX on virtiofs and the semantic difference with that on ext4
and xfs.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/dax.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index 9a1b8fd9e82b..e3b30429d703 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -23,8 +23,8 @@ on it as usual.  The `DAX` code currently only supports files with a block
 size equal to your kernel's `PAGE_SIZE`, so you may need to specify a block
 size when creating the filesystem.
 
-Currently 3 filesystems support `DAX`: ext2, ext4 and xfs.  Enabling `DAX` on them
-is different.
+Currently 4 filesystems support `DAX`: ext2, ext4, xfs and virtiofs.
+Enabling `DAX` on them is different.
 
 Enabling DAX on ext2
 --------------------
@@ -168,6 +168,22 @@ if the underlying media does not support dax and/or the filesystem is
 overridden with a mount option.
 
 
+Enabling DAX on virtiofs
+----------------------------
+The semantic of DAX on virtiofs is basically equal to that on ext4 and xfs,
+except that when '-o dax=inode' is specified, virtiofs client derives the hint
+whether DAX shall be enabled or not from virtiofs server through FUSE protocol,
+rather than the persistent `FS_XFLAG_DAX` flag. That is, whether DAX shall be
+enabled or not is completely determined by virtiofs server, while virtiofs
+server itself may deploy various algorithm making this decision, e.g. depending
+on the persistent `FS_XFLAG_DAX` flag on the host.
+
+It is still supported to set or clear persistent `FS_XFLAG_DAX` flag inside
+guest, but it is not guaranteed that DAX will be enabled or disabled for
+corresponding file then. Users inside guest still need to call statx(2) and
+check the statx flag `STATX_ATTR_DAX` to see if DAX is enabled for this file.
+
+
 Implementation Tips for Block Driver Writers
 --------------------------------------------
 
-- 
2.27.0

