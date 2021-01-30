Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1303092E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 10:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhA3JIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 04:08:25 -0500
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:57050 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhA3JIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:08:00 -0500
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.231])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id E9513980229;
        Sat, 30 Jan 2021 16:50:28 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
Date:   Sat, 30 Jan 2021 16:50:03 +0800
Message-Id: <20210130085003.1392-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkMYQxlLSBhIQ01CVkpNSkpCQk1NSUJKT0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6HDo4MD8XCzE1PjgQLDYu
        HT8wChhVSlVKTUpKQkJNTUlCTkpCVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSEpZV1kIAVlBSUNMSDcG
X-HM-Tid: 0a77527c8844d992kuwse9513980229
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When writeback cache is enabled, the inode information in cached is
considered new by default, and the inode information of lowerfs is
stale.
When a lower fs is mount in a different directory through different
connection, for example PATHA and PATHB, since writeback cache is
enabled by default, when the file is modified through PATHA, viewing the
same file from the PATHB, PATHB will think that cached inode is newer
than lowerfs, resulting in file size and time from under PATHA and PATHB
is inconsistent.
Add a judgment condition to check whether to use the info in the cache
according to mtime.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/fuse/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..55fdafcaca34 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -182,7 +182,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
 	/* mtime from server may be stale due to local buffered write */
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode)) {
+	if (!fc->writeback_cache || !S_ISREG(inode->i_mode)
+		|| (attr->mtime > inode->i_mtime.tv_sec)
+		|| ((attr->mtime == inode->i_mtime.tv_sec)
+			&& (attr->mtimensec >= inode->i_mtime.tv_nsec))) {
 		inode->i_mtime.tv_sec   = attr->mtime;
 		inode->i_mtime.tv_nsec  = attr->mtimensec;
 		inode->i_ctime.tv_sec   = attr->ctime;
@@ -241,8 +244,12 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	 * extend local i_size without keeping userspace server in sync. So,
 	 * attr->size coming from server can be stale. We cannot trust it.
 	 */
-	if (!is_wb || !S_ISREG(inode->i_mode))
+	if (!is_wb || !S_ISREG(inode->i_mode)
+		|| (attr->mtime > inode->i_mtime.tv_sec)
+		|| ((attr->mtime == inode->i_mtime.tv_sec)
+			&& (attr->mtimensec >= inode->i_mtime.tv_nsec))) {
 		i_size_write(inode, attr->size);
+	}
 	spin_unlock(&fi->lock);

 	if (!is_wb && S_ISREG(inode->i_mode)) {
--
2.29.0

