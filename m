Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F409B3B72E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhF2NFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 09:05:44 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:41326 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhF2NFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:05:43 -0400
DKIM-Signature: a=rsa-sha256;
        b=Osau8ZIcAEoVSZkSiBgyy65LinW8AzqrW0iGF3OcM1HIeIO6e/jSdQlk5Aa2Z5Ii8pug8FiOjmuRnMnTXusaAOf8C2FcMZJfy9DTUAKnRWwkwVHq2696wSMUFe3mLy5OJ82cEOLXGYGphOaKMVZeS99aIiVs2ZSyjMmFNMiExCY=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=+E6qaEn67JBpxzpxcbfmH1gAeCq+yUiAnivaZS80yR0=;
        h=date:mime-version:subject:message-id:from;
Received: from comdg01144017.vivo.xyz (unknown [218.104.188.164])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 08011AC031E;
        Tue, 29 Jun 2021 21:03:12 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH v3] fuse: use newer inode info when writeback cache is enabled
Date:   Tue, 29 Jun 2021 21:03:11 +0800
Message-Id: <20210629130311.238638-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0tIH1ZOS0geTENIGR8aSEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9PTlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6Qhw*HT9JPikzEiEdOi0p
        EjUKCxVVSlVKTUlPQkxKTEJIT05CVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WUlKQ1VKS09VSkNDVUpNT1lXWQgBWUFJQ0hNNwY+
X-HM-Tid: 0a7a57ddd2ffb039kuuu08011ac031e
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
 fs/fuse/fuse_i.h | 6 ++++++
 fs/fuse/inode.c  | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 07829ce78695..98fc2ba91a03 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -909,6 +909,12 @@ static inline void fuse_page_descs_length_init(struct fuse_page_desc *descs,
 	for (i = index; i < index + nr_pages; i++)
 		descs[i].length = PAGE_SIZE - descs[i].offset;
 }
+static inline bool attr_newer_than_local(struct fuse_attr *attr, struct inode *inode)
+{
+	return (attr->mtime > inode->i_mtime.tv_sec) ||
+		((attr->mtime == inode->i_mtime.tv_sec) &&
+		 (attr->mtimensec > inode->i_mtime.tv_nsec));
+}
 
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b9beb39a4a18..32545f488274 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -241,8 +241,10 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	 * extend local i_size without keeping userspace server in sync. So,
 	 * attr->size coming from server can be stale. We cannot trust it.
 	 */
-	if (!is_wb || !S_ISREG(inode->i_mode))
+	if (!is_wb || !S_ISREG(inode->i_mode)
+		|| (attr_newer_than_local(attr, inode) && !inode_is_open_for_write(inode))) {
 		i_size_write(inode, attr->size);
+	}
 	spin_unlock(&fi->lock);
 
 	if (!is_wb && S_ISREG(inode->i_mode)) {
-- 
2.29.0

