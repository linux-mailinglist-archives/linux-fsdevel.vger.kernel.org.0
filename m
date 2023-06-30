Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0873F743A78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjF3LK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjF3LKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:10:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79EF5;
        Fri, 30 Jun 2023 04:10:49 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qst034R4vzqV4n;
        Fri, 30 Jun 2023 19:10:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 19:10:46 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 2/5] quota: rename dquot_active() to inode_quota_active()
Date:   Fri, 30 Jun 2023 19:08:19 +0800
Message-ID: <20230630110822.3881712-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230630110822.3881712-1-libaokun1@huawei.com>
References: <20230630110822.3881712-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have a helper function dquot_dirty() to determine if dquot has
DQ_MOD_B bit. dquot_active() can easily be misunderstood as a helper
function to determine if dquot has DQ_ACTIVE_B bit. So we avoid this by
renaming it to inode_quota_active() and later on we will add the helper
function dquot_active() to determine if dquot has DQ_ACTIVE_B bit.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	Rename to inode_quota_active() instead of inode_dquot_active().

 fs/quota/dquot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 108ba9f1e420..a08698d9859a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1418,7 +1418,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
 	return QUOTA_NL_NOWARN;
 }
 
-static int dquot_active(const struct inode *inode)
+static int inode_quota_active(const struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -1441,7 +1441,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 	qsize_t rsv;
 	int ret = 0;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	dquots = i_dquot(inode);
@@ -1549,7 +1549,7 @@ bool dquot_initialize_needed(struct inode *inode)
 	struct dquot **dquots;
 	int i;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return false;
 
 	dquots = i_dquot(inode);
@@ -1660,7 +1660,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) += number;
@@ -1730,7 +1730,7 @@ int dquot_alloc_inode(struct inode *inode)
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
@@ -1773,7 +1773,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) -= number;
 		__inode_add_bytes(inode, number);
@@ -1815,7 +1815,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) += number;
 		__inode_sub_bytes(inode, number);
@@ -1859,7 +1859,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot **dquots;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) -= number;
@@ -1914,7 +1914,7 @@ void dquot_free_inode(struct inode *inode)
 	struct dquot * const *dquots;
 	int index;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return;
 
 	dquots = i_dquot(inode);
@@ -2086,7 +2086,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
 	struct super_block *sb = inode->i_sb;
 	int ret;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	if (i_uid_needs_update(idmap, iattr, inode)) {
-- 
2.31.1

