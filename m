Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825E5B2495
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiIHRZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIHRZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719DB54CAA;
        Thu,  8 Sep 2022 10:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D32B661C61;
        Thu,  8 Sep 2022 17:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F165C433D6;
        Thu,  8 Sep 2022 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657901;
        bh=UwpZrmq+vN+P0GFsdu64X7LMo1+EIMrukCLbnYcvUpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFwRW3oosWundQ5oWMFWA5H3hpqlmGbpV2eiIskY7WQweKj+xUnhmgl+gbpb0sQGe
         ZXAZU23BKc4FI10aF83CY/ZZFfK5l0gTMlA08eh1MPifKYmz0XgX0/k8AyI7xrZw1M
         hHhqVkhjDGkKmzB+0tPqTbc8y8wPJeFXyTbjoXZiTytFsRlGA/ep9fu/0hctskcKZj
         W+ndB0e2ODjjMZ5i3uIjLBLcBFv/0+BE89GfAF0iXD404rpZS1BVRc1H5SwmV+xJ8V
         peIHz2e1h1WoTjUkNjm1m5k3ItjMSDWBAOd2uxsGpUi9Z2xf3VTrer0BxDfnBzzZQD
         t7s16EzwBeQVQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v5 4/8] vfs: plumb i_version handling into struct kstat
Date:   Thu,  8 Sep 2022 13:24:44 -0400
Message-Id: <20220908172448.208585-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908172448.208585-1-jlayton@kernel.org>
References: <20220908172448.208585-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

The NFS server has a lot of special handling for different types of
change attribute access, depending on what sort of inode we have. In
most cases, it's doing a getattr anyway and then fetching that value
after the fact.

Rather that do that, add a new STATX_INO_VERSION flag that is a
kernel-only symbol (for now). If requested and getattr can implement it,
it can fill out this field. For IS_I_VERSION inodes, add a generic
implementation in vfs_getattr_nosec. Take care to mask STATX_INO_VERSION
off in requests from userland and in the result mask.

Eventually if we decide to make this available to userland, we can just
designate a field for it in struct statx, and move the STATX_INO_VERSION
definition to the uapi header.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c            | 14 +++++++++++++-
 include/linux/stat.h |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 9ced8860e0f3..1a9c20ac5090 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -17,6 +17,7 @@
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
 #include <linux/compat.h>
+#include <linux/iversion.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
 				  STATX_ATTR_DAX);
 
+	if ((request_mask & STATX_INO_VERSION) && IS_I_VERSION(inode)) {
+		stat->result_mask |= STATX_INO_VERSION;
+		stat->ino_version = inode_query_iversion(inode);
+	}
+
 	mnt_userns = mnt_user_ns(path->mnt);
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(mnt_userns, path, stat,
@@ -587,7 +593,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 
 	memset(&tmp, 0, sizeof(tmp));
 
-	tmp.stx_mask = stat->result_mask;
+	/* STATX_INO_VERSION is kernel-only for now */
+	tmp.stx_mask = stat->result_mask & ~STATX_INO_VERSION;
 	tmp.stx_blksize = stat->blksize;
 	tmp.stx_attributes = stat->attributes;
 	tmp.stx_nlink = stat->nlink;
@@ -626,6 +633,11 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
+	/* STATX_INO_VERSION is kernel-only for now. Ignore requests
+	 * from userland.
+	 */
+	mask &= ~STATX_INO_VERSION;
+
 	error = vfs_statx(dfd, filename, flags, &stat, mask);
 	if (error)
 		return error;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 7df06931f25d..d482bbfc1358 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -50,6 +50,10 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	u64		ino_version;
 };
 
+/* This definition is internal to the kernel for now. Mainly used by nfsd */
+#define STATX_INO_VERSION	0x40000000U	/* Want/got stx_change_attr */
+
 #endif
-- 
2.37.3

