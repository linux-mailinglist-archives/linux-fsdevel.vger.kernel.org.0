Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5F380396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 08:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhENGTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 02:19:15 -0400
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:49046 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhENGTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 02:19:15 -0400
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 66DCD2800C6;
        Fri, 14 May 2021 14:18:02 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH v2] fuse: fix inconsistent status between faccess and mkdir
Date:   Fri, 14 May 2021 14:17:57 +0800
Message-Id: <20210514061757.1077-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkMdH1YfTk4fSUNOS0MaH0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBQ6Dzo5TD8NFTAQCUsQHTwD
        OjMKChRVSlVKTUlLQkxIS0NJQ0hPVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSU9KTTcG
X-HM-Tid: 0a796986579fda03kuws66dcd2800c6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

since FUSE caches dentries and attributes with separate timeout, It may
happen that checking the permission returns -ENOENT, but because the
dentries cache has not timed out, creating the file returns -EEXIST.
Fix this by when return -ENOENT, mark the entry as stale.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/fuse/dir.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 06a18700a845..a22206290da9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1065,6 +1065,24 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 				fuse_fillattr(inode, &outarg.attr, stat);
 		}
 	}
+	if (err == -ENOENT && get_node_id(inode) != FUSE_ROOT_ID) {
+		if (S_ISDIR(inode->i_mode)) {
+			struct dentry *dir = d_find_any_alias(inode);
+
+			if (dir) {
+				fuse_invalidate_entry_cache(dir);
+				dput(dir);
+			}
+		} else {
+			struct dentry *dentry;
+
+			while ((dentry = d_find_alias(inode))) {
+				fuse_invalidate_entry_cache(dentry);
+				dput(dentry);
+			}
+		}
+	}
+
 	return err;
 }
 
@@ -1226,6 +1244,24 @@ static int fuse_access(struct inode *inode, int mask)
 		fm->fc->no_access = 1;
 		err = 0;
 	}
+	if (err == -ENOENT && get_node_id(inode) != FUSE_ROOT_ID) {
+		if (S_ISDIR(inode->i_mode)) {
+			struct dentry *dir = d_find_any_alias(inode);
+
+			if (dir) {
+				fuse_invalidate_entry_cache(dir);
+				dput(dir);
+			}
+		} else {
+			struct dentry *dentry;
+
+			while ((dentry = d_find_alias(inode))) {
+				fuse_invalidate_entry_cache(dentry);
+				dput(dentry);
+			}
+		}
+	}
+
 	return err;
 }
 
-- 
2.29.0

