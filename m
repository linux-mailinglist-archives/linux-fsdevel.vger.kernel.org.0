Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36E645D51A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351229AbhKYHKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 02:10:44 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52546 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352521AbhKYHIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:08:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyESXVx_1637823931;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UyESXVx_1637823931)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Nov 2021 15:05:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v8 1/7] fuse: add fuse_should_enable_dax() helper
Date:   Thu, 25 Nov 2021 15:05:24 +0800
Message-Id: <20211125070530.79602-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is in prep for following per inode DAX checking.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 5778ebfbce5e..4c48a57632bd 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1329,11 +1329,19 @@ static const struct address_space_operations fuse_dax_file_aops  = {
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

