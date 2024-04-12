Return-Path: <linux-fsdevel+bounces-16791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186C8A2B92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29DD1C211D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3798C535DB;
	Fri, 12 Apr 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNeCk35+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8F524B8;
	Fri, 12 Apr 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915391; cv=none; b=nxCtI0YOx3SmaEPpzDqAD8uocge+HYVpguCMlbdNMU+sCU3SScI/x5SvnTUSY0W+DUNe1lbea6ITin6BSAzimJbTG2yq5ZFdztKYsU1YKBb++L8HDMCNTjv0TRa0Xt24gBmj6SxVU6uHCToN8FqeE4HBwpPSPAJBNNXyC5IL7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915391; c=relaxed/simple;
	bh=6P8XYJG2gjvHIFspaQMqxg4nwxIZmt8EeJiCgo0GJSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMaPHpsQjpMpNDN/a3sTv+GyH5/y66kcXQmTCRh0yhtEqsyYSt03NW++gM09I8bFuIG4XlZ7PAAHf9Wn3rIBOCir0a4Ulb7aQlP/cpttzTxQD5NBrpUOLVL83rSBEtlLW9IEAt7gvAmAVLhgc4m7p0qvtgdZy9lqBgkq1TEStMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNeCk35+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A996CC113CC;
	Fri, 12 Apr 2024 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712915391;
	bh=6P8XYJG2gjvHIFspaQMqxg4nwxIZmt8EeJiCgo0GJSI=;
	h=From:To:Cc:Subject:Date:From;
	b=qNeCk35+z/bd9zlkuxcGeX3zlkJ+CuDUAeEfSHJuKUjZsObzQkJry2KmE+Yum6qFJ
	 bH5KmxbcyNnyOiiZoXb26S6iRAon7YOJrhm3wrBWtmVqRxAwOHC3K1RCZBlzKtux7g
	 odCYn7ULHZSfzMN2jKbuGtb7OmN7+Y8kHYNmx5p6COWQTARerA59yL+1Icr0A6Ua5M
	 Trqj1p9L5kO9XMOQyODSwz4uYZh+kPH2OD37z4H7feunVpKItbCIvuh5+qZ77Uu2kG
	 bGXDdN+S/shjmaHUID28/VlieUg6A6LwpBz86LKN2038WYvbef/yAhfjfRQOl5Trt6
	 MnMD2rob/IVXw==
From: Chao Yu <chao@kernel.org>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] quota: fix to propagate error of mark_dquot_dirty() to caller
Date: Fri, 12 Apr 2024 17:49:42 +0800
Message-Id: <20240412094942.2131243-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in order to let caller be aware of failure of mark_dquot_dirty().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/quota/dquot.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index dacbee455c03..b2a109d8b198 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1737,7 +1737,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 
 	if (reserve)
 		goto out_flush_warn;
-	mark_all_dquot_dirty(dquots);
+	ret = mark_all_dquot_dirty(dquots);
 out_flush_warn:
 	srcu_read_unlock(&dquot_srcu, index);
 	flush_warnings(warn);
@@ -1786,7 +1786,7 @@ int dquot_alloc_inode(struct inode *inode)
 warn_put_all:
 	spin_unlock(&inode->i_lock);
 	if (ret == 0)
-		mark_all_dquot_dirty(dquots);
+		ret = mark_all_dquot_dirty(dquots);
 	srcu_read_unlock(&dquot_srcu, index);
 	flush_warnings(warn);
 	return ret;
@@ -1990,7 +1990,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	qsize_t inode_usage = 1;
 	struct dquot __rcu **dquots;
 	struct dquot *transfer_from[MAXQUOTAS] = {};
-	int cnt, index, ret = 0;
+	int cnt, index, ret = 0, err;
 	char is_valid[MAXQUOTAS] = {};
 	struct dquot_warn warn_to[MAXQUOTAS];
 	struct dquot_warn warn_from_inodes[MAXQUOTAS];
@@ -2087,8 +2087,12 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	 * mark_all_dquot_dirty().
 	 */
 	index = srcu_read_lock(&dquot_srcu);
-	mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
-	mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
+	err = mark_all_dquot_dirty((struct dquot __rcu **)transfer_from);
+	if (err < 0)
+		ret = err;
+	err = mark_all_dquot_dirty((struct dquot __rcu **)transfer_to);
+	if (err < 0)
+		ret = err;
 	srcu_read_unlock(&dquot_srcu, index);
 
 	flush_warnings(warn_to);
@@ -2098,7 +2102,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (is_valid[cnt])
 			transfer_to[cnt] = transfer_from[cnt];
-	return 0;
+	return ret;
 over_quota:
 	/* Back out changes we already did */
 	for (cnt--; cnt >= 0; cnt--) {
@@ -2726,6 +2730,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
 	struct mem_dqblk *dm = &dquot->dq_dqb;
 	int check_blim = 0, check_ilim = 0;
 	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
+	int ret;
 
 	if (di->d_fieldmask & ~VFS_QC_MASK)
 		return -EINVAL;
@@ -2807,7 +2812,9 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
 	else
 		set_bit(DQ_FAKE_B, &dquot->dq_flags);
 	spin_unlock(&dquot->dq_dqb_lock);
-	mark_dquot_dirty(dquot);
+	ret = mark_dquot_dirty(dquot);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.40.1


