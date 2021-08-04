Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864683DFBBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhHDHHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 03:07:09 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59080 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhHDHHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:07:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhxBmec_1628060813;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UhxBmec_1628060813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 15:06:53 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH v3 1/8] fuse: add fuse_should_enable_dax() helper
Date:   Wed,  4 Aug 2021 15:06:46 +0800
Message-Id: <20210804070653.118123-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
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
index 0e5407f48e6a..c6f4e82e65f3 100644
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

