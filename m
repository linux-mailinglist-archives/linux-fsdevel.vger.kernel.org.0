Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585893DFBBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 09:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhHDHHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 03:07:11 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47169 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235485AbhHDHHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:07:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhwuUVR_1628060816;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UhwuUVR_1628060816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 15:06:56 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH v3 7/8] fuse: support changing per-file DAX flag inside guest
Date:   Wed,  4 Aug 2021 15:06:52 +0800
Message-Id: <20210804070653.118123-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fuse client can enable or disable per-file DAX inside kernel/guest by
chattr(1). Similarly the new state won't be updated until the file is
closed and reopened later.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/ioctl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 546ea3d58fb4..a9ed53c5dbd1 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -469,8 +469,6 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 	if (fa->flags_valid) {
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_SETFLAGS,
 				      &flags, sizeof(flags));
-		if (err)
-			goto cleanup;
 	} else {
 		memset(&xfa, 0, sizeof(xfa));
 		xfa.fsx_xflags = fa->fsx_xflags;
@@ -483,6 +481,19 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 				      &xfa, sizeof(xfa));
 	}
 
+	if (err)
+		goto cleanup;
+
+	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
+		bool newdax;
+
+		if (fa->flags_valid)
+			newdax = flags & FS_DAX_FL;
+		else
+			newdax = fa->fsx_xflags & FS_XFLAG_DAX;
+		fuse_dax_dontcache(inode, newdax);
+	}
+
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
 
-- 
2.27.0

