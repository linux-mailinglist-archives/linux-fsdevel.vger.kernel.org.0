Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A500F53DC45
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 16:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiFEOid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbiFEOib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:38:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4709DFBF;
        Sun,  5 Jun 2022 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uBRhQRR/tN31opvAhjL6O3F8yw8vziQWAC+xAJKQG7Y=; b=kyBAPQ2EzL+54K5R18CvAvQNSY
        7az/EotbUPE4HGEVknJY0cIJfgusEmPNfL1Okchrzg+eqi4dgaLNv0mniD1uBRe0xy/4iTSG2jhOb
        cR+YfL+oTtX0NJ8GN8Pan4UpP8OhPnuNdrMR/OZoBhQhtI6klTdta3tDxHpw3Rwd3easXRmLGF+Nt
        qglBCF+F3u2tS35iA4Xp4iTA/y6HKOvd35WUrXpinSXNeF4F7dbBDKBZmVBRUhkEMzOnN2DUV0URi
        Nc8eOMSYhhWNxXr/gAF5Wh+pDvF3Qa9+0FF66Sri7Jk8sp+VojeKDJACX1pEVEMA3EDVBLwWwAwbH
        XVm4wvzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxrOU-009mNq-MT; Sun, 05 Jun 2022 14:38:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] quota: Prevent memory allocation recursion while holding dq_lock
Date:   Sun,  5 Jun 2022 15:38:13 +0100
Message-Id: <20220605143815.2330891-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220605143815.2330891-1-willy@infradead.org>
References: <20220605143815.2330891-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As described in commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in
read_cache_page_gfp while doing f2fs_quota_read"), we must not enter
filesystem reclaim while holding the dq_lock.  Prevent this more generally
by using memalloc_nofs_save() while holding the lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/quota/dquot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a74aef99bd3d..cdb22d6d7488 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -425,9 +425,11 @@ EXPORT_SYMBOL(mark_info_dirty);
 int dquot_acquire(struct dquot *dquot)
 {
 	int ret = 0, ret2 = 0;
+	unsigned int memalloc;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	mutex_lock(&dquot->dq_lock);
+	memalloc = memalloc_nofs_save();
 	if (!test_bit(DQ_READ_B, &dquot->dq_flags)) {
 		ret = dqopt->ops[dquot->dq_id.type]->read_dqblk(dquot);
 		if (ret < 0)
@@ -458,6 +460,7 @@ int dquot_acquire(struct dquot *dquot)
 	smp_mb__before_atomic();
 	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 out_iolock:
+	memalloc_nofs_restore(memalloc);
 	mutex_unlock(&dquot->dq_lock);
 	return ret;
 }
@@ -469,9 +472,11 @@ EXPORT_SYMBOL(dquot_acquire);
 int dquot_commit(struct dquot *dquot)
 {
 	int ret = 0;
+	unsigned int memalloc;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	mutex_lock(&dquot->dq_lock);
+	memalloc = memalloc_nofs_save();
 	if (!clear_dquot_dirty(dquot))
 		goto out_lock;
 	/* Inactive dquot can be only if there was error during read/init
@@ -481,6 +486,7 @@ int dquot_commit(struct dquot *dquot)
 	else
 		ret = -EIO;
 out_lock:
+	memalloc_nofs_restore(memalloc);
 	mutex_unlock(&dquot->dq_lock);
 	return ret;
 }
@@ -492,9 +498,11 @@ EXPORT_SYMBOL(dquot_commit);
 int dquot_release(struct dquot *dquot)
 {
 	int ret = 0, ret2 = 0;
+	unsigned int memalloc;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	mutex_lock(&dquot->dq_lock);
+	memalloc = memalloc_nofs_save();
 	/* Check whether we are not racing with some other dqget() */
 	if (dquot_is_busy(dquot))
 		goto out_dqlock;
@@ -510,6 +518,7 @@ int dquot_release(struct dquot *dquot)
 	}
 	clear_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 out_dqlock:
+	memalloc_nofs_restore(memalloc);
 	mutex_unlock(&dquot->dq_lock);
 	return ret;
 }
-- 
2.35.1

