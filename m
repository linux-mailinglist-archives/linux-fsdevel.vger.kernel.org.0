Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49373EADA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfJaKja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 06:39:30 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:39086 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfJaKja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:39:30 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4313A2E0DD2;
        Thu, 31 Oct 2019 13:39:27 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 3cec8TshNm-dQei0e3i;
        Thu, 31 Oct 2019 13:39:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572518367; bh=L9UYXWAgwZMaVyLOOzOt+ACtOFd1s/GUXWoDpY54l7s=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=FxquD+5RhfjDSq5dXzcScL6eS8oKzAE+Mo/0o2dZ9OXaVEfQGdcX/1jB1JrGhq5hl
         /+lBPkWy3ZflQRUXM7J2rdjsEu7Yk4yGSO1IdKv3t967ErW6zbP+CQwANLqHNWyOSN
         bMUAqV7cFsqHLblJgGV+x/H3tdXwDp4OyduA4OEw=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id N03nYWr42k-dQWKoRGl;
        Thu, 31 Oct 2019 13:39:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@openvz.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH 2/2] fs/quota: Check that quota is not dirty before release
Date:   Thu, 31 Oct 2019 10:39:20 +0000
Message-Id: <20191031103920.3919-2-dmonakhov@openvz.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191031103920.3919-1-dmonakhov@openvz.org>
References: <20191031103920.3919-1-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

There is a race window where quota was redirted once we drop dq_list_lock inside dqput(),
but before we grab dquot->dq_lock inside dquot_release()

TASK1                                                       TASK2 (chowner)
->dqput()
  we_slept:
    spin_lock(&dq_list_lock)
    if (dquot_dirty(dquot)) {
          spin_unlock(&dq_list_lock);
          dquot->dq_sb->dq_op->write_dquot(dquot);
          goto we_slept
    if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
          spin_unlock(&dq_list_lock);
          dquot->dq_sb->dq_op->release_dquot(dquot);
                                                            dqget()
							    mark_dquot_dirty()
							    dqput()
          goto we_slept;
        }
So dquot dirty quota will be released by TASK1, but on next we_sleept loop
we detect this and call ->write_dquot() for it.
XFSTEST: https://github.com/dmonakhov/xfstests/commit/440a80d4cbb39e9234df4d7240aee1d551c36107

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 fs/ocfs2/quota_global.c  |  2 +-
 fs/quota/dquot.c         |  2 +-
 include/linux/quotaops.h | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 7a92219..eda8348 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -728,7 +728,7 @@ static int ocfs2_release_dquot(struct dquot *dquot)
 
 	mutex_lock(&dquot->dq_lock);
 	/* Check whether we are not racing with some other dqget() */
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (dquot_is_busy(dquot))
 		goto out;
 	/* Running from downconvert thread? Postpone quota processing to wq */
 	if (current == osb->dc_task) {
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b492b9e..72d24a5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -497,7 +497,7 @@ int dquot_release(struct dquot *dquot)
 
 	mutex_lock(&dquot->dq_lock);
 	/* Check whether we are not racing with some other dqget() */
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (dquot_is_busy(dquot))
 		goto out_dqlock;
 	if (dqopt->ops[dquot->dq_id.type]->release_dqblk) {
 		ret = dqopt->ops[dquot->dq_id.type]->release_dqblk(dquot);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 185d948..91e0b76 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -54,6 +54,16 @@ static inline struct dquot *dqgrab(struct dquot *dquot)
 	atomic_inc(&dquot->dq_count);
 	return dquot;
 }
+
+static inline bool dquot_is_busy(struct dquot *dquot)
+{
+	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
+		return true;
+	if (atomic_read(&dquot->dq_count) > 1)
+		return true;
+	return false;
+}
+
 void dqput(struct dquot *dquot);
 int dquot_scan_active(struct super_block *sb,
 		      int (*fn)(struct dquot *dquot, unsigned long priv),
-- 
2.7.4

