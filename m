Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFB76CC1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjHBLyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjHBLyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:54:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2910C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fKQvnXWxKFqqsxQqkbIY9VJr6BVySQDXY/l1WucdCUs=; b=Hv02kf37S3uzXCUYwFpWdxg7jm
        /v3nU4fYjtHIn44uOFYyGAJAOjR4ZNzdR0z+//Y+40Oa7YUDO6q7wBSnGX+vnz99Y6/hv101FeBaY
        aGXNKR5X0UpVLEAW6Po/Bw0H8tdO4+ROz/zAVKb25bJGVsX9nW1y3phqDgqQiXZ/vilK6D9Lv8krk
        G3GG4LeSQb9p0LNqGmrXQsV09xgfnMFg5MRBUnMJXXBLpQP093kvibCfw53pTgfYr/kQ4ssmogMXG
        uG8rbg+upRDXRTnTft8fhScujtMT629o5eXuDpQNPUDKVz+nAzjFzbaqWIrpacBu+Z94esxWrr0sk
        JbwoLovw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRAR9-004qdL-1Q;
        Wed, 02 Aug 2023 11:54:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jack@suse.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] quota: mark dquot_load_quota_sb static
Date:   Wed,  2 Aug 2023 13:54:38 +0200
Message-Id: <20230802115439.2145212-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dquot_load_quota_sb is only used in dquot.c, so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/quota/dquot.c         | 5 ++---
 include/linux/quotaops.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e3e4f40476579c..a0c577ab2b7b26 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2352,8 +2352,8 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
 	return 0;
 }
 
-int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
-	unsigned int flags)
+static int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
+		unsigned int flags)
 {
 	struct quota_format_type *fmt = find_quota_format(format_id);
 	struct quota_info *dqopt = sb_dqopt(sb);
@@ -2429,7 +2429,6 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	return error;
 }
-EXPORT_SYMBOL(dquot_load_quota_sb);
 
 /*
  * More powerful function for turning on quotas on given quota inode allowing
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 11a4becff3a983..671fd306ccf01c 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -95,8 +95,6 @@ int dquot_mark_dquot_dirty(struct dquot *dquot);
 
 int dquot_file_open(struct inode *inode, struct file *file);
 
-int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
-	unsigned int flags);
 int dquot_load_quota_inode(struct inode *inode, int type, int format_id,
 	unsigned int flags);
 int dquot_quota_on(struct super_block *sb, int type, int format_id,
-- 
2.39.2

