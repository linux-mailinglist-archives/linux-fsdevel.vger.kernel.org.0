Return-Path: <linux-fsdevel+bounces-16321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B889AF3B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 09:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29C41F23DDC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF3101F7;
	Sun,  7 Apr 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6+sgDLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DECA7A;
	Sun,  7 Apr 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712475099; cv=none; b=jDvrwSz1EtGGvjwCTMEA4b9IJdsKg64JiVPorbnV6FvZGOw4NZPruFIWn9EzILXtc0+e65OppNgQnK3s1ilKuG9SjFZmqW2Ujm+xDrB/y7dDRrzmBZ604r4ic2WnnM6mLx08wNgoREuEETHv3QCUfQtjdkqXrzNm4Au8Oep/fTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712475099; c=relaxed/simple;
	bh=2/0x+pGO2mDSJuLq4AV+U67ydy3QJW8qPn5DR/tXu7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAcYQ2a9wKKYabHV4j6L4WV/85X8PNDF63D0lJAmysxX0ZLCjj5IL+QpS4V0J9X4Z+3FwxN2axzucL6O/j7m4tgZURig0dZ+eW99wGGc0ClZFZiOQlCZR+Awjr/jDRM4hapg7eZF5hzMME0Jb/FMuSIiYKxW8o3tbbD8QLmDKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6+sgDLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0A1C433F1;
	Sun,  7 Apr 2024 07:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712475098;
	bh=2/0x+pGO2mDSJuLq4AV+U67ydy3QJW8qPn5DR/tXu7M=;
	h=From:To:Cc:Subject:Date:From;
	b=S6+sgDLCxBKN2cW/PAEpm26hBflmn3XI7Qb1NH7Rhtu25Ci/Rv894J2SwVy2Q2Pc8
	 f2099vC2pcgsDAawlDh/xlnbFRJqXn6VE+wZ0emqYgPYZuWkjBaGEIwRL1OlS6tgXR
	 c7H1OD5Vk4mm3siSlysuA9QJeM5n3qwl789MtZXKKPRX6nzePmSSvN0vHpoOLiUSWB
	 eJ932kj2wH1j/nuWR+/LC5P5ThMuW+Fs/i4jFLp2YrJ3r9cRVWTLXUO/NVlnU95oNV
	 cYmNVqARd8aZHjSh1JF/SsXasKoETWWYEvHti/4XumVLeEVuU8zwisEOSrWlACKaJw
	 zkDNu0Iizfc3w==
From: Chao Yu <chao@kernel.org>
To: jack@suse.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] quota: don't let mark_dquot_dirty() fail silently
Date: Sun,  7 Apr 2024 15:31:28 +0800
Message-Id: <20240407073128.3489785-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mark_dquot_dirty() will callback to specified filesystem function,
it may fail due to any reasons, however, no caller will check return
value of mark_dquot_dirty(), so, it may fail silently, let's print
one line message for such case.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/quota/dquot.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index dacbee455c03..c5df7863942a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -399,21 +399,20 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 EXPORT_SYMBOL(dquot_mark_dquot_dirty);
 
 /* Dirtify all the dquots - this can block when journalling */
-static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
+static inline void mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
 {
-	int ret, err, cnt;
+	int ret, cnt;
 	struct dquot *dquot;
 
-	ret = err = 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
-		if (dquot)
-			/* Even in case of error we have to continue */
-			ret = mark_dquot_dirty(dquot);
-		if (!err)
-			err = ret;
+		if (!dquot)
+			continue;
+		ret = mark_dquot_dirty(dquot);
+		if (ret < 0)
+			quota_error(dquot->dq_sb,
+				"mark_all_dquot_dirty fails, ret: %d", ret);
 	}
-	return err;
 }
 
 static inline void dqput_all(struct dquot **dquot)
@@ -2725,6 +2724,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
 {
 	struct mem_dqblk *dm = &dquot->dq_dqb;
 	int check_blim = 0, check_ilim = 0;
+	int ret;
 	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
 
 	if (di->d_fieldmask & ~VFS_QC_MASK)
@@ -2807,7 +2807,10 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
 	else
 		set_bit(DQ_FAKE_B, &dquot->dq_flags);
 	spin_unlock(&dquot->dq_dqb_lock);
-	mark_dquot_dirty(dquot);
+	ret = mark_dquot_dirty(dquot);
+	if (ret < 0)
+		quota_error(dquot->dq_sb,
+			"mark_dquot_dirty fails, ret: %d", ret);
 
 	return 0;
 }
-- 
2.40.1


