Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1CF380198
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 03:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhENB4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 21:56:41 -0400
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:17412 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhENB4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 21:56:40 -0400
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 879092800AB;
        Fri, 14 May 2021 09:55:26 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH] fuse: fix inconsistent status between faccess and mkdir
Date:   Fri, 14 May 2021 09:55:17 +0800
Message-Id: <20210514015517.258-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhhIGVYZQ00eTh5OSEMaGk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Chw4Tz8IDTATLw8cHRpK
        TUIwCVZVSlVKTUlLQk5MSElMS0hKVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSkJMTjcG
X-HM-Tid: 0a796895ed44da03kuws879092800ab
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

since FUSE caches dentries and attributes with separate timeout, It may
happen that checking the permission returns -ENOENT, but because the
dentries cache has not timed out, creating the file returns -EEXIST.
Fix this by when return ENOENT, mark the entry as stale.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/fuse/dir.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 06a18700a845..154dd4578762 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1065,6 +1065,14 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 				fuse_fillattr(inode, &outarg.attr, stat);
 		}
 	}
+	if (err == -ENOENT) {
+		struct dentry *entry;
+
+		entry = d_obtain_alias(inode);
+		if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+			fuse_invalidate_entry_cache(entry);
+	}
+
 	return err;
 }

@@ -1226,6 +1234,14 @@ static int fuse_access(struct inode *inode, int mask)
 		fm->fc->no_access = 1;
 		err = 0;
 	}
+	if (err == -ENOENT) {
+		struct dentry *entry;
+
+		entry = d_obtain_alias(inode);
+		if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+			fuse_invalidate_entry_cache(entry);
+	}
+
 	return err;
 }

-- 
2.29.0

