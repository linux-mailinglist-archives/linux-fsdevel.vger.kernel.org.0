Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1303CB657
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhGPKuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:50:54 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33534 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231937AbhGPKuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:50:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UfyYkGE_1626432475;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfyYkGE_1626432475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 18:47:55 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v2 4/4] fuse: support changing per-file DAX flag inside guest
Date:   Fri, 16 Jul 2021 18:47:53 +0800
Message-Id: <20210716104753.74377-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fuse client can enable or disable per-file DAX inside guest by
chattr(1). Similarly the new state won't be updated until the file is
closed and reopened later.

It is worth nothing that it is a best-effort style, since whether
per-file DAX is enabled or not is controlled by fuse_attr.flags retrieved
by FUSE LOOKUP routine, while the algorithm constructing fuse_attr.flags
is totally fuse server specific, not to mention ioctl may not be
supported by fuse server at all.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 546ea3d58fb4..172e05c3f038 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -460,6 +460,7 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 	struct fuse_file *ff;
 	unsigned int flags = fa->flags;
 	struct fsxattr xfa;
+	bool newdax;
 	int err;
 
 	ff = fuse_priv_ioctl_prepare(inode);
@@ -467,10 +468,9 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 		return PTR_ERR(ff);
 
 	if (fa->flags_valid) {
+		newdax = flags & FS_DAX_FL;
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_SETFLAGS,
 				      &flags, sizeof(flags));
-		if (err)
-			goto cleanup;
 	} else {
 		memset(&xfa, 0, sizeof(xfa));
 		xfa.fsx_xflags = fa->fsx_xflags;
@@ -479,11 +479,14 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
 		xfa.fsx_projid = fa->fsx_projid;
 		xfa.fsx_cowextsize = fa->fsx_cowextsize;
 
+		newdax = fa->fsx_xflags & FS_XFLAG_DAX;
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
 	}
 
-cleanup:
+	if (!err && IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_dontcache(inode, newdax);
+
 	fuse_priv_ioctl_cleanup(inode, ff);
 
 	return err;
-- 
2.27.0

