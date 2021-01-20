Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0032FD86B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbhATSfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404651AbhATSbW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:31:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F27EF23443;
        Wed, 20 Jan 2021 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167340;
        bh=xfZW5I38ynOxT82Iq3AJ6iU+XMfwQjUmRTU036TpdaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfCXisa1Nu/FsbkchZKdMraCe5ICqePenmBZo0DCGeg2L+0+Nv4REK7HBChW6LWX8
         C4+SwXobjpL87/NC0hPH3Sw0SRHN4tyJH/F3c3ykWCMKaWa1IKCzme3anFziZjY4z/
         m/6LKgAHBjNHdfatYNMWmBc9eg2geNs319joEwEpShSZG0HQDCpqTEbkV1yhbSA+AU
         frHx21w3/a0H4dq2SAlrRqXN2zJKDqhNS3t9Ka/FbxACLgNyRt8fpMwqoJFT3PHzK+
         W2ity16UCvYX5cHP2vkX1duU+f7knIiv5COFxlLsLwYMeejHi+GEZAx4IitOOYZH0a
         IGxrvIAy5IrGQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 17/17] ceph: add fscrypt ioctls
Date:   Wed, 20 Jan 2021 13:28:47 -0500
Message-Id: <20210120182847.644850-18-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the ioctls, we gate on the MDS feature support. The exception is
the key removal and status functions that we still want to work if the
MDS's were to (inexplicably) lose the feature.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/ioctl.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad4..832909f3eb1b 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -6,6 +6,7 @@
 #include "mds_client.h"
 #include "ioctl.h"
 #include <linux/ceph/striper.h>
+#include <linux/fscrypt.h>
 
 /*
  * ioctls
@@ -268,8 +269,29 @@ static long ceph_ioctl_syncio(struct file *file)
 	return 0;
 }
 
+static int vet_mds_for_fscrypt(struct file *file)
+{
+	int i, ret = -EOPNOTSUPP;
+	struct ceph_mds_client	*mdsc = ceph_sb_to_mdsc(file_inode(file)->i_sb);
+
+	mutex_lock(&mdsc->mutex);
+	for (i = 0; i < mdsc->max_sessions; i++) {
+		struct ceph_mds_session *s = __ceph_lookup_mds_session(mdsc, i);
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
 long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	int ret;
+
 	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
 	switch (cmd) {
 	case CEPH_IOC_GET_LAYOUT:
@@ -289,6 +311,45 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case CEPH_IOC_SYNCIO:
 		return ceph_ioctl_syncio(file);
+
+	case FS_IOC_SET_ENCRYPTION_POLICY:
+		ret = vet_mds_for_fscrypt(file);
+		if (ret)
+			return ret;
+		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
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
2.29.2

