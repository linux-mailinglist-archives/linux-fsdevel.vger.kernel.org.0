Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E76EAE46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 12:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfJaLED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 07:04:03 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:41840 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727073AbfJaLEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:04:02 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 26A3F2E1486;
        Thu, 31 Oct 2019 14:03:59 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GiObEs4vO4-3wiSUIiv;
        Thu, 31 Oct 2019 14:03:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572519839; bh=D+6O7iUMBkZ3sqVRjui7jk+wGVzrqyDNlvlVRTMTN3s=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=gMHioc8MePvpAfs8uJE0MK0GT5EOkh1wfN+OjtOidy08Pn3dmiPcu61v0RCim1Cnf
         lMGUV79++VKVn/tH80J1xU4xqxhklACtfx0c7nMO872QXWhk+Gwwg4Cn+KR1LP+jBU
         kj0IE0N6RotOC9FN99E4D8YWxwDPq7W5DodpNosY=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id q8PWovi3A9-3wV8jBkp;
        Thu, 31 Oct 2019 14:03:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@openvz.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, lixi@ddn.com,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] fs/ext4: get project quota from inode for mangling statfs results
Date:   Thu, 31 Oct 2019 11:03:48 +0000
Message-Id: <20191031110348.6991-1-dmonakhov@openvz.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

Right now ext4_statfs_project() does quota lookup by id every time.
This is costly operation, especially if there is no inode who hold
reference to this dquot. This means that each statfs performs useless
ext4_acquire_dquot()/ext4_release_dquot() which serialized on __jbd2_log_wait_for_space()
dqget()
 ->ext4_acquire_dquot
   -> ext4_journal_start
      -> __jbd2_log_wait_for_space
dqput()
  -> ext4_release_dquot
     ->ext4_journal_start
       ->__jbd2_log_wait_for_space


Function ext4_statfs_project() could be moved into generic quota code,
it is required for every filesystem which uses generic project quota.

Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/ext4/super.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2318e5f..4e8f97d68 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5532,18 +5532,23 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 }
 
 #ifdef CONFIG_QUOTA
-static int ext4_statfs_project(struct super_block *sb,
-			       kprojid_t projid, struct kstatfs *buf)
+static int ext4_statfs_project(struct inode *inode, struct kstatfs *buf)
 {
-	struct kqid qid;
+	struct super_block *sb = inode->i_sb;
 	struct dquot *dquot;
 	u64 limit;
 	u64 curblock;
+	int err;
+
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
+
+	spin_lock(&inode->i_lock);
+	dquot = ext4_get_dquots(inode)[PRJQUOTA];
+	if (!dquot)
+		goto out_unlock;
 
-	qid = make_kqid_projid(projid);
-	dquot = dqget(sb, qid);
-	if (IS_ERR(dquot))
-		return PTR_ERR(dquot);
 	spin_lock(&dquot->dq_dqb_lock);
 
 	limit = (dquot->dq_dqb.dqb_bsoftlimit ?
@@ -5569,7 +5574,9 @@ static int ext4_statfs_project(struct super_block *sb,
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);
-	dqput(dquot);
+out_unlock:
+	spin_unlock(&inode->i_lock);
+
 	return 0;
 }
 #endif
@@ -5609,7 +5616,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
 #ifdef CONFIG_QUOTA
 	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
 	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
-		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
+		ext4_statfs_project(dentry->d_inode, buf);
 #endif
 	return 0;
 }
-- 
2.7.4

