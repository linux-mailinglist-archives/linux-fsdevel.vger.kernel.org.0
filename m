Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8183BE6FBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfJ1Kis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:38:48 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56058 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388234AbfJ1Kis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:38:48 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 63A172E146B;
        Mon, 28 Oct 2019 13:38:44 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BUnN8RUcgy-ch9WZfD9;
        Mon, 28 Oct 2019 13:38:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572259124; bh=BUd74mhZhB63Gk6S1rzlQQdwN5kUFsdKTQsJCf4kM78=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=ZuHBSifukQ1eCeHwe634/PMRXHkwuSqZdtr+YKRUCcjvaYRdOEzOIZu+qP6o4ws/a
         nEn4BVc315P13VWZUqVeQfXgElqXXxCCsw8lcDlTTEqZ8JiSUcae3YDtnbthAFIfoW
         EGB5eZISd+9TO3GOv+73O0nYbYRAIah4v87sCh4w=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id k7moP2jRqY-chWOJ7us;
        Mon, 28 Oct 2019 13:38:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] fs/ext4: get project quota from inode for mangling statfs
 results
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Cc:     Li Xi <lixi@ddn.com>, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Mon, 28 Oct 2019 13:38:43 +0300
Message-ID: <157225912326.3929.8539227851002947260.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now ext4_statfs_project() does quota lookup by id every time.
This is costly operation, especially if there is no inode who hold
reference to this quota and dqget() reads it from disk each time.

Function ext4_statfs_project() could be moved into generic quota code,
it is required for every filesystem which uses generic project quota.

Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/ext4/super.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..f841c66aa499 100644
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

