Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9810E307385
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhA1KR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 05:17:27 -0500
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:37282 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhA1KRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:17:07 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 05:17:06 EST
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.231])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A61CA9801C4;
        Thu, 28 Jan 2021 18:07:43 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, changfengnan <changfengnan@vivo.com>
Subject: [PATCH] When writeback cache is enabled, same file in two different directory maybe inconsistent
Date:   Thu, 28 Jan 2021 18:07:38 +0800
Message-Id: <20210128100739.1022-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSE4dTkpLTklKGUwYVkpNSkpDSUNPTUhDTUJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46ISo*IT8UVjNJOjpLNCgP
        HxxPCxJVSlVKTUpKQ0lDT01PSUpCVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSEpZV1kIAVlBSUJCTzcG
X-HM-Tid: 0a77487688a7d992kuwsa61ca9801c4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: changfengnan <changfengnan@vivo.com>

When writeback cache is enabled, the inode information in cached is
considered new by default, and the inode information of lowerfs is
stale.
When a lower fs is mount in a different directory through different
connection, for example PATHA and PATHB, since writeback cache is
enabled by default, when the file is modified through PATHA, viewing
the same file from the PATHB, PATHB will think that cached inode is
newer than lowerfs, resulting in file size and time from under PATHA
and PATHB is inconsistent.
We have a solution, add a judgment condition to check whether to use the
info in the cache according to mtime.

Signed-off-by: changfengnan <changfengnan@vivo.com>
---
 fs/fuse/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..e63984bfac48 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -182,7 +182,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	inode->i_atime.tv_sec   = attr->atime;
 	inode->i_atime.tv_nsec  = attr->atimensec;
 	/* mtime from server may be stale due to local buffered write */
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode)) {
+	if (!fc->writeback_cache || !S_ISREG(inode->i_mode)
+		|| (attr->mtime >= inode->i_mtime.tv_sec)
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
+		|| (attr->mtime >= inode->i_mtime.tv_sec)
+		|| ((attr->mtime == inode->i_mtime.tv_sec)
+			&& (attr->mtimensec >= inode->i_mtime.tv_nsec))) {
 		i_size_write(inode, attr->size);
+	}
 	spin_unlock(&fi->lock);
 
 	if (!is_wb && S_ISREG(inode->i_mode)) {
-- 
2.29.0

