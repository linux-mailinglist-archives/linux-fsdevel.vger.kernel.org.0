Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21804633EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbhK3MO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 07:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbhK3MOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:14:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C14C061746
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 04:10:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B760B818AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 12:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA71C53FC7;
        Tue, 30 Nov 2021 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274256;
        bh=/DvqrDKWGQ/X0qPOaNCR9fbKTpJlf1oO5q1ghuAy+Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kffinqYDCTlYdOEZqnhTSFulpN902wYKvvAhoCI30/G5DFipfKnRJkC/7Sfh7ibUG
         xvMMzo0W+MEeZyV7MFXZKRbrdY5PpOigwjSeotSEnHzHMqmv9VprKa70ejU3X3rq88
         0aqvZyTfrX+twOHiw/UDe8fNtGK89fZ4g2syFJK6tSNYplVvPnOQAxWccm0F3P7D/l
         Pul9mr9GzTo0b+8ZgDV4U92ubQYp3hri0OmQCVBMz0Act6rrqIl0YU6n37WkL84V+N
         MTboIDh15vEss4RYUn5nYbmZa6Npd09X0fIpKixxcX6toAYbz6awFbj373rxgObXjy
         DkaaTlIyQYtGA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 03/10] fs: tweak fsuidgid_has_mapping()
Date:   Tue, 30 Nov 2021 13:10:25 +0100
Message-Id: <20211130121032.3753852-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130121032.3753852-1-brauner@kernel.org>
References: <20211130121032.3753852-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; h=from:subject; bh=E9TqSuG8Iw/Kd8DZnx4QSCCbIkJpGVu7FloOZxFxiWg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQuE1kh/q7goAvrk+z4jVa8uYUfrTWCRUTiSi13/lTfuHfl Gt+JHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxbWJkmHOqmfXa/5W7XdMsdSQrDY Jqvi3Mmz0tdV6uS0RZl1pRMcM/JfYlwkGfMz5va9qy9+mmTT/lplvvPtjvPefa05tLhW795AIA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If the caller's fs{g,u}id aren't mapped in the mount's idmapping we can
return early and skip the check whether the mapped fs{g,u}id also have a
mapping in the filesystem's idmapping. If the fs{g,u}id aren't mapped in
the mount's idmapping they consequently can't be mapped in the
filesystem's idmapping. So there's no point in checking that.

Link: https://lore.kernel.org/r/20211123114227.3124056-4-brauner@kernel.org (v1)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 include/linux/fs.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5d1ae0a783a..28ab20ce0adc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1695,10 +1695,18 @@ static inline void inode_fsgid_set(struct inode *inode,
 static inline bool fsuidgid_has_mapping(struct super_block *sb,
 					struct user_namespace *mnt_userns)
 {
-	struct user_namespace *s_user_ns = sb->s_user_ns;
+	struct user_namespace *fs_userns = sb->s_user_ns;
+	kuid_t kuid;
+	kgid_t kgid;
 
-	return kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) &&
-	       kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns));
+	kuid = mapped_fsuid(mnt_userns);
+	if (!uid_valid(kuid))
+		return false;
+	kgid = mapped_fsgid(mnt_userns);
+	if (!gid_valid(kgid))
+		return false;
+	return kuid_has_mapping(fs_userns, kuid) &&
+	       kgid_has_mapping(fs_userns, kgid);
 }
 
 extern struct timespec64 current_time(struct inode *inode);
-- 
2.30.2

