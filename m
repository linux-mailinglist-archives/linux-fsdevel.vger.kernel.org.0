Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFD3F8BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbhHZQVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243120AbhHZQVO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 324236113C;
        Thu, 26 Aug 2021 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994826;
        bh=qAOHxnIZk3tSgi3BA+m9G4u0Cp+PHP8aHsxMnlNFgFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmXZQWDtSx6JpwBuQeWQWG3gfFAcAK4K112MDVoQwUlhNld1WHiZohH7nYlbyQvHN
         HLvArZOjyKyn4iGzIz4QcIOJy0ny3jj2qcQJa4GjC2wZvnYn8mdyXYCBBcgEjACI8a
         KHcgF6sQ/nB1P9DRXJ0TOMI/5ld+u7TkmhuQbzsLQC2TbsQtA6BepvawYWUkyANRo0
         QhCYu0r8pI+/GU7ic2xigKtDTZ/3ih8zC4TWuznYR9LbrBv7EacGqQIqOtcFbhc9W7
         mjInOzTUSHHnU7Ey5PQqO40vGaSVwHs2ZoOTmUgo91RWNMGFlca3PxrWAcxAHqlcyU
         eDp6kgIkvUcGw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 11/24] ceph: add fscrypt ioctls
Date:   Thu, 26 Aug 2021 12:20:01 -0400
Message-Id: <20210826162014.73464-12-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We gate most of the ioctls on MDS feature support. The exception is the
key removal and status functions that we still want to work if the MDS's
were to (inexplicably) lose the feature.

For the set_policy ioctl, we take Fcx caps to ensure that nothing can
create files in the directory while the ioctl is running. That should
be enough to ensure that the "empty_dir" check is reliable.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad4..477ecc667aee 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -6,6 +6,7 @@
 #include "mds_client.h"
 #include "ioctl.h"
 #include <linux/ceph/striper.h>
+#include <linux/fscrypt.h>
 
 /*
  * ioctls
@@ -268,8 +269,54 @@ static long ceph_ioctl_syncio(struct file *file)
 	return 0;
 }
 
+static int vet_mds_for_fscrypt(struct file *file)
+{
+	int i, ret = -EOPNOTSUPP;
+	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
+
+	mutex_lock(&mdsc->mutex);
+	for (i = 0; i < mdsc->max_sessions; i++) {
+		struct ceph_mds_session *s = mdsc->sessions[i];
+
+		if (!s)
+			continue;
+		if (test_bit(CEPHFS_FEATURE_ALTERNATE_NAME, &s->s_features))
+			ret = 0;
+		break;
+	}
+	mutex_unlock(&mdsc->mutex);
+	return ret;
+}
+
+static long ceph_set_encryption_policy(struct file *file, unsigned long arg)
+{
+	int ret, got = 0;
+	struct inode *inode = file_inode(file);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	ret = vet_mds_for_fscrypt(file);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ensure we hold these caps so that we _know_ that the rstats check
+	 * in the empty_dir check is reliable.
+	 */
+	ret = ceph_get_caps(file, CEPH_CAP_FILE_SHARED, 0, -1, &got);
+	if (ret)
+		return ret;
+
+	ret = fscrypt_ioctl_set_policy(file, (const void __user *)arg);
+	if (got)
+		ceph_put_cap_refs(ci, got);
+
+	return ret;
+}
+
 long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	int ret;
+
 	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
 	switch (cmd) {
 	case CEPH_IOC_GET_LAYOUT:
@@ -289,6 +336,42 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case CEPH_IOC_SYNCIO:
 		return ceph_ioctl_syncio(file);
+
+	case FS_IOC_SET_ENCRYPTION_POLICY:
+		return ceph_set_encryption_policy(file, arg);
+
+	case FS_IOC_GET_ENCRYPTION_POLICY:
+		ret = vet_mds_for_fscrypt(file);
+		if (ret)
+			return ret;
+		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
+
+	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
+		ret = vet_mds_for_fscrypt(file);
+		if (ret)
+			return ret;
+		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
+
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+		ret = vet_mds_for_fscrypt(file);
+		if (ret)
+			return ret;
+		return fscrypt_ioctl_add_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
+		return fscrypt_ioctl_remove_key_all_users(file, (void __user *)arg);
+
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
+
+	case FS_IOC_GET_ENCRYPTION_NONCE:
+		ret = vet_mds_for_fscrypt(file);
+		if (ret)
+			return ret;
+		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
 	}
 
 	return -ENOTTY;
-- 
2.31.1

