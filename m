Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2513478A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 13:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhCXMja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 08:39:30 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:39034 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhCXMjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:39:07 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id ECD2D4002DC;
        Wed, 24 Mar 2021 20:39:03 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] fs/fuse/virtio_fs: Fix a potential memory allocation failure
Date:   Wed, 24 Mar 2021 05:38:43 -0700
Message-Id: <1616589523-32024-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSk1LHU8YShhPSx9LVkpNSk1OQ0JOT05JSk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6Hxw6Tj8PQz8*LwMuVjgx
        FTwaCT1VSlVKTUpNTkNCTk9OTkNKVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlLTU03Bg++
X-HM-Tid: 0a78643edeb0d991kuwsecd2d4002dc
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allocate memory for struct fuse_conn may fail, we should not jump to
out_err to kfree(fc).

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 fs/fuse/virtio_fs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f73..1f333c6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1430,11 +1430,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	err = -ENOMEM;
 	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
 	if (!fc)
-		goto out_err;
+		goto out_err_fc;
 
 	fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
 	if (!fm)
-		goto out_err;
+		goto out_err_fm;
 
 	fuse_conn_init(fc, fm, get_user_ns(current_user_ns()),
 		       &virtio_fs_fiq_ops, fs);
@@ -1468,8 +1468,9 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fsc->root = dget(sb->s_root);
 	return 0;
 
-out_err:
+out_err_fm:
 	kfree(fc);
+out_err_fc:
 	mutex_lock(&virtio_fs_mutex);
 	virtio_fs_put(fs);
 	mutex_unlock(&virtio_fs_mutex);
-- 
2.7.4

