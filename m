Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43134AD98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCZRdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhCZRcn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCEFC61A28;
        Fri, 26 Mar 2021 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779962;
        bh=OK2KGWFptjTIN1OXjEChJKuyV3fd0j4GvVod8RQV4Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtkXBn9ItWo8N68h8CWZRXbKHxgxgwiMkBuu7RmK9NDAQc71iT8t2vX0ucRZ5/HCQ
         wsPlurc++bKJ6ckHKTWiTGl7NavTLyNA7eMPRuiiYUqidglaS5jEvi+eBhCM+ZMRIS
         CcjGrvOMl0tFvk+Rg1sMLdDRvT//6xQmSUG+Zxpp5XmJo6kyDh7BilQ6BHlHS9tSQq
         NXWc52APLZRIy5c7+J49QAQ3cWVLOPk9Eu7Xg5DRj+BwAFQrMydzxvIGYrssLM48bt
         btMvMh31P8ZG55HwFPbJln0i0C8lfnTt6GNgf6usyfnck7L05FmTl6WHCCIlinVeVf
         dMxk27nemf3oA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 19/19] ceph: add fscrypt ioctls
Date:   Fri, 26 Mar 2021 13:32:27 -0400
Message-Id: <20210326173227.96363-20-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326173227.96363-1-jlayton@kernel.org>
References: <20210326173227.96363-1-jlayton@kernel.org>
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
 fs/ceph/ioctl.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad4..34b85bcfcfc7 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -6,6 +6,7 @@
 #include "mds_client.h"
 #include "ioctl.h"
 #include <linux/ceph/striper.h>
+#include <linux/fscrypt.h>
 
 /*
  * ioctls
@@ -268,8 +269,56 @@ static long ceph_ioctl_syncio(struct file *file)
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
+	struct page *page = NULL;
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
+	ret = ceph_get_caps(file, CEPH_CAP_FILE_SHARED, 0, -1, &got, &page);
+	if (ret)
+		return ret;
+	if (page)
+		put_page(page);
+	ret = fscrypt_ioctl_set_policy(file, (const void __user *)arg);
+	if (got)
+		ceph_put_cap_refs(ci, got);
+	return ret;
+}
+
 long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	int ret;
+	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
+
 	dout("ioctl file %p cmd %u arg %lu\n", file, cmd, arg);
 	switch (cmd) {
 	case CEPH_IOC_GET_LAYOUT:
@@ -289,6 +338,51 @@ long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
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
+		atomic_inc(&ci->i_shared_gen);
+		ceph_dir_clear_ordered(file_inode(file));
+		ceph_dir_clear_complete(file_inode(file));
+		return fscrypt_ioctl_add_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+		atomic_inc(&ci->i_shared_gen);
+		ceph_dir_clear_ordered(file_inode(file));
+		ceph_dir_clear_complete(file_inode(file));
+		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
+		atomic_inc(&ci->i_shared_gen);
+		ceph_dir_clear_ordered(file_inode(file));
+		ceph_dir_clear_complete(file_inode(file));
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
2.30.2

