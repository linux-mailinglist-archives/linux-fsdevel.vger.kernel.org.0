Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000074426AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 06:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhKBF2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 01:28:43 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40445 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhKBF2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:28:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UuiHHRj_1635830764;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UuiHHRj_1635830764)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Nov 2021 13:26:05 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v7 1/7] fuse: add fuse_should_enable_dax() helper
Date:   Tue,  2 Nov 2021 13:25:58 +0800
Message-Id: <20211102052604.59462-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
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
index 79df61ed7481..8c187b04874e 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1332,11 +1332,19 @@ static const struct address_space_operations fuse_dax_file_aops  = {
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

