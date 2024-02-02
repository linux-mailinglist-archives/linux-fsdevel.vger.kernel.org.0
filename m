Return-Path: <linux-fsdevel+bounces-9967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535A846A9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DE1C26316
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA91B59F;
	Fri,  2 Feb 2024 08:20:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8281A27D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862051; cv=none; b=aXOSO139VNZmNIyQ0YjNOj9tS7H5WistCOy5iwE5Ace7QZzJyRIpYUnwySll7rUlCNX1l8G7E7mN+ZbhZu8RLqSSPIK5cwBHpiGwZimkKveM1taruJL6bcxC4xFP+bIIGPfZvDUoU96a3tdjAfXKfz3V0tSmqu+FjSd5Q4M/lT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862051; c=relaxed/simple;
	bh=+4s8Dop2FMCD50JsPRXtUY6gNMki1aASbLRp3Xb59wc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpJ0Y86GHZIEGtCh/Mmu9cG4wp0RweMWVFXzZHp4N7x6HyOd80sI1o6D0QqFOfyxXtGfHnvza1cVqRo7wPW4w+LOq3EdkgzwhMRMQToZTU2n+93WxLDyjwXQo4kqXPmx7SBIMytrK9isR9nYF75tH8Ge76U3OmzCTAwdNCcGcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TR7wg6mY7z1Q8k0
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:19:31 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 5025714059B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:20:46 +0800 (CST)
Received: from huawei.com (10.113.213.244) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 16:20:45 +0800
From: Wang Jianjian <wangjianjian3@huawei.com>
To: <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>
CC: <zhangzhikang1@huawei.com>, <liujie1@huawei.com>, <yunlanying@huawei.com>,
	<gudehe@huawei.com>
Subject: [PATCH v2] quota: Fix potential NULL pointer dereference
Date: Fri, 2 Feb 2024 16:18:52 +0800
Message-ID: <20240202081852.2514092-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)

Below race may cause NULL pointer dereference

P1					P2
dquot_free_inode			quota_off
					  drop_dquot_ref
					   remove_dquot_ref
					   dquots = i_dquot(inode)
  dquots = i_dquot(inode)
  srcu_read_lock
  dquots[cnt]) != NULL (1)
					     dquots[type] = NULL (2)
  spin_lock(&dquots[cnt]->dq_dqb_lock) (3)
   ....

If dquot_free_inode(or other routines) checks inode's quota pointers (1)
before quota_off sets it to NULL(2) and use it (3) after that, NULL pointer
dereference will be triggered.

So let's fix it by using a temporary pointer to avoid this issue.

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
 fs/quota/dquot.c | 92 +++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 40 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 1f0c754416b6..929a720c72fc 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -402,12 +402,14 @@ EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 static inline int mark_all_dquot_dirty(struct dquot * const *dquot)
 {
 	int ret, err, cnt;
+	struct dquot *dq;
 
 	ret = err = 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquot[cnt])
+		dq = srcu_dereference(dquot[cnt], &dquot_srcu);
+		if (dq)
 			/* Even in case of error we have to continue */
-			ret = mark_dquot_dirty(dquot[cnt]);
+			ret = mark_dquot_dirty(dq);
 		if (!err)
 			err = ret;
 	}
@@ -1678,6 +1680,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot_warn warn[MAXQUOTAS];
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode)) {
 		if (reserve) {
@@ -1697,27 +1700,26 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	index = srcu_read_lock(&dquot_srcu);
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
 		if (reserve) {
-			ret = dquot_add_space(dquots[cnt], 0, number, flags,
-					      &warn[cnt]);
+			ret = dquot_add_space(dquot, 0, number, flags, &warn[cnt]);
 		} else {
-			ret = dquot_add_space(dquots[cnt], number, 0, flags,
-					      &warn[cnt]);
+			ret = dquot_add_space(dquot, number, 0, flags, &warn[cnt]);
 		}
 		if (ret) {
 			/* Back out changes we already did */
 			for (cnt--; cnt >= 0; cnt--) {
-				if (!dquots[cnt])
+				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+				if (!dquot)
 					continue;
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
 				if (reserve)
-					dquot_free_reserved_space(dquots[cnt],
-								  number);
+					dquot_free_reserved_space(dquot, number);
 				else
-					dquot_decr_space(dquots[cnt], number);
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+					dquot_decr_space(dquot, number);
+				spin_unlock(&dquot->dq_dqb_lock);
 			}
 			spin_unlock(&inode->i_lock);
 			goto out_flush_warn;
@@ -1748,6 +1750,7 @@ int dquot_alloc_inode(struct inode *inode)
 	int cnt, ret = 0, index;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
+	struct dquot *dquot;
 
 	if (!inode_quota_active(inode))
 		return 0;
@@ -1758,17 +1761,19 @@ int dquot_alloc_inode(struct inode *inode)
 	index = srcu_read_lock(&dquot_srcu);
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		ret = dquot_add_inodes(dquots[cnt], 1, &warn[cnt]);
+		ret = dquot_add_inodes(dquot, 1, &warn[cnt]);
 		if (ret) {
 			for (cnt--; cnt >= 0; cnt--) {
-				if (!dquots[cnt])
+				dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+				if (!dquot)
 					continue;
 				/* Back out changes we already did */
-				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				dquot_decr_inodes(dquots[cnt], 1);
-				spin_unlock(&dquots[cnt]->dq_dqb_lock);
+				spin_lock(&dquot->dq_dqb_lock);
+				dquot_decr_inodes(dquot, 1);
+				spin_unlock(&dquot->dq_dqb_lock);
 			}
 			goto warn_put_all;
 		}
@@ -1790,6 +1795,7 @@ EXPORT_SYMBOL(dquot_alloc_inode);
 void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1805,9 +1811,8 @@ void dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_lock(&inode->i_lock);
 	/* Claim reserved quotas to allocated quotas */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquots[cnt]) {
-			struct dquot *dquot = dquots[cnt];
-
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot) {
 			spin_lock(&dquot->dq_dqb_lock);
 			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_rsvspace < number))
 				number = dquot->dq_dqb.dqb_rsvspace;
@@ -1832,6 +1837,7 @@ EXPORT_SYMBOL(dquot_claim_space_nodirty);
 void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 {
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int cnt, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1847,9 +1853,8 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	spin_lock(&inode->i_lock);
 	/* Claim reserved quotas to allocated quotas */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (dquots[cnt]) {
-			struct dquot *dquot = dquots[cnt];
-
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (dquot) {
 			spin_lock(&dquot->dq_dqb_lock);
 			if (WARN_ON_ONCE(dquot->dq_dqb.dqb_curspace < number))
 				number = dquot->dq_dqb.dqb_curspace;
@@ -1876,6 +1881,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot **dquots;
+	struct dquot *dquot;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
 	if (!inode_quota_active(inode)) {
@@ -1896,17 +1902,18 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 		int wtype;
 
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		spin_lock(&dquots[cnt]->dq_dqb_lock);
-		wtype = info_bdq_free(dquots[cnt], number);
+		spin_lock(&dquot->dq_dqb_lock);
+		wtype = info_bdq_free(dquot, number);
 		if (wtype != QUOTA_NL_NOWARN)
-			prepare_warning(&warn[cnt], dquots[cnt], wtype);
+			prepare_warning(&warn[cnt], dquot, wtype);
 		if (reserve)
-			dquot_free_reserved_space(dquots[cnt], number);
+			dquot_free_reserved_space(dquot, number);
 		else
-			dquot_decr_space(dquots[cnt], number);
-		spin_unlock(&dquots[cnt]->dq_dqb_lock);
+			dquot_decr_space(dquot, number);
+		spin_unlock(&dquot->dq_dqb_lock);
 	}
 	if (reserve)
 		*inode_reserved_space(inode) -= number;
@@ -1931,6 +1938,7 @@ void dquot_free_inode(struct inode *inode)
 	unsigned int cnt;
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
+	struct dquot *dquot;
 	int index;
 
 	if (!inode_quota_active(inode))
@@ -1941,16 +1949,16 @@ void dquot_free_inode(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		int wtype;
-
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
-		if (!dquots[cnt])
+		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
+		if (!dquot)
 			continue;
-		spin_lock(&dquots[cnt]->dq_dqb_lock);
-		wtype = info_idq_free(dquots[cnt], 1);
+		spin_lock(&dquot->dq_dqb_lock);
+		wtype = info_idq_free(dquot, 1);
 		if (wtype != QUOTA_NL_NOWARN)
-			prepare_warning(&warn[cnt], dquots[cnt], wtype);
-		dquot_decr_inodes(dquots[cnt], 1);
-		spin_unlock(&dquots[cnt]->dq_dqb_lock);
+			prepare_warning(&warn[cnt], dquot, wtype);
+		dquot_decr_inodes(dquot, 1);
+		spin_unlock(&dquot->dq_dqb_lock);
 	}
 	spin_unlock(&inode->i_lock);
 	mark_all_dquot_dirty(dquots);
@@ -1977,7 +1985,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t rsv_space = 0;
 	qsize_t inode_usage = 1;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
-	int cnt, ret = 0;
+	int cnt, index, ret = 0;
 	char is_valid[MAXQUOTAS] = {};
 	struct dquot_warn warn_to[MAXQUOTAS];
 	struct dquot_warn warn_from_inodes[MAXQUOTAS];
@@ -2066,8 +2074,12 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&dq_data_lock);
 
+	/* acquire rcu lock to avoid assertion check warning */
+	index = srcu_read_lock(&dquot_srcu);
 	mark_all_dquot_dirty(transfer_from);
 	mark_all_dquot_dirty(transfer_to);
+	srcu_read_unlock(&dquot_srcu, index);
+
 	flush_warnings(warn_to);
 	flush_warnings(warn_from_inodes);
 	flush_warnings(warn_from_space);
-- 
2.25.1


