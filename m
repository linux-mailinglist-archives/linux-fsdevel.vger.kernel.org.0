Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6807B3C9BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhGOJd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:33:26 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35161 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233886AbhGOJd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:33:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfrwCzW_1626341431;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfrwCzW_1626341431)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Jul 2021 17:30:32 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bo.liu@linux.alibaba.com
Subject: [RFC PATCH 1/3] fuse: add fuse_should_enable_dax() helper
Date:   Thu, 15 Jul 2021 17:30:29 +0800
Message-Id: <20210715093031.55667-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is in prep for following per-file DAX checking.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0e5407f48e6a..97b8bd09baa3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1336,11 +1336,19 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 	.invalidatepage	= noop_invalidatepage,
 };
 
-void fuse_dax_inode_init(struct inode *inode)
+static bool fuse_should_enable_dax(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	if (!fc->dax)
+		return false;
+ 
+	return true;
+}
+
+void fuse_dax_inode_init(struct inode *inode)
+{
+	if (!fuse_should_enable_dax(inode))
 		return;
 
 	inode->i_flags |= S_DAX;
-- 
2.27.0

