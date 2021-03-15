Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101BE33BF2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhCOOyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 10:54:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37943 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbhCOOyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:54:41 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lLoc7-0006o5-3n; Mon, 15 Mar 2021 14:54:35 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/3] fs: improve naming for fsid helpers
Date:   Mon, 15 Mar 2021 15:54:18 +0100
Message-Id: <20210315145419.2612537-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek pointed out that the current naming scheme can be misleading as it
conflicts with some of the other helpers naming. So get rid of the
confusion by simply calling those helpers idmapped_fs{u,g}id() that
make it very clear that and idmapped fsuid/fsgid is used. xfs needs to
use them directly in the quota allocation codepaths.

Inspired-by: Vivek Goyal <vgoyal@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/xfs/xfs_inode.c   | 8 ++++----
 fs/xfs/xfs_symlink.c | 4 ++--
 include/linux/fs.h   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f93370bd7b1e..8703408bd1aa 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1007,8 +1007,8 @@ xfs_create(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, fsuid_into_mnt(mnt_userns),
-			fsgid_into_mnt(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, idmapped_fsuid(mnt_userns),
+			idmapped_fsgid(mnt_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
@@ -1158,8 +1158,8 @@ xfs_create_tmpfile(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, fsuid_into_mnt(mnt_userns),
-			fsgid_into_mnt(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, idmapped_fsuid(mnt_userns),
+			idmapped_fsgid(mnt_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 7f368b10ded1..669e8517e2e1 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -182,8 +182,8 @@ xfs_symlink(
 	/*
 	 * Make sure that we have allocated dquot(s) on disk.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, fsuid_into_mnt(mnt_userns),
-			fsgid_into_mnt(mnt_userns), prid,
+	error = xfs_qm_vop_dqalloc(dp, idmapped_fsuid(mnt_userns),
+			idmapped_fsgid(mnt_userns), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index edcb1aa99fd6..189673721726 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1610,12 +1610,12 @@ static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
 	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
 }
 
-static inline kuid_t fsuid_into_mnt(struct user_namespace *mnt_userns)
+static inline kuid_t idmapped_fsuid(struct user_namespace *mnt_userns)
 {
 	return kuid_from_mnt(mnt_userns, current_fsuid());
 }
 
-static inline kgid_t fsgid_into_mnt(struct user_namespace *mnt_userns)
+static inline kgid_t idmapped_fsgid(struct user_namespace *mnt_userns)
 {
 	return kgid_from_mnt(mnt_userns, current_fsgid());
 }
-- 
2.27.0

