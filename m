Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B65F0A63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiI3L1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiI3L03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8174238467;
        Fri, 30 Sep 2022 04:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39EEDB827BA;
        Fri, 30 Sep 2022 11:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04497C43470;
        Fri, 30 Sep 2022 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536731;
        bh=OiWqH9H96RIYc4sQV4NyZY0vkQDrR45eK/XVH8S1FtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdbjRPFWkSzB6MCZ18crcDxdhPQchA/8rL+mJpt+iG2f3ETidE58kob/wyZuk8Sh+
         30vZpPbChd95ytHLRm1uTjN1VA1H8u7Q7Bz7yvUX6pElumMlxhUhQynFthmKyTolsP
         nk5LpQbwiZlKnDNENa5+PGoxcm3rMS92gyLPnPTV5qSH2A5Yt+QkphTB9wiGj0bC9N
         PkMyqoCQ2/EBPVZLZqXPWF98f/lQEYHqi01ba2ICkR2MHMH7hCEE2EXrDeIiBYAYR9
         Ut80RrJ1iPXj1GVQOMtzlBpHwZH4AaKqu8L3n8TeQ7wwcdrqzzC1ufwbaWZYcLAcJX
         sg4uwlHjitrHg==
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
Subject: [PATCH v6 3/9] vfs: plumb i_version handling into struct kstat
Date:   Fri, 30 Sep 2022 07:18:34 -0400
Message-Id: <20220930111840.10695-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930111840.10695-1-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Rather that do that, add a new STATX_VERSION flag that is a kernel-only
symbol (for now). If requested and getattr can implement it, it can fill
out this field. For IS_I_VERSION inodes, add a generic implementation in
vfs_getattr_nosec. Take care to mask STATX_VERSION off in requests from
userland and in the result mask.

Eventually if we decide to make this available to userland, we can just
designate a field for it in struct statx, and move the STATX_VERSION
definition to the uapi header.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c            | 17 +++++++++++++++--
 include/linux/stat.h |  9 +++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index a7930d744483..e7f8cd4b24e1 100644
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
 
+	if ((request_mask & STATX_VERSION) && IS_I_VERSION(inode)) {
+		stat->result_mask |= STATX_VERSION;
+		stat->version = inode_query_iversion(inode);
+	}
+
 	mnt_userns = mnt_user_ns(path->mnt);
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(mnt_userns, path, stat,
@@ -587,9 +593,11 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 
 	memset(&tmp, 0, sizeof(tmp));
 
-	tmp.stx_mask = stat->result_mask;
+	/* STATX_VERSION is kernel-only for now */
+	tmp.stx_mask = stat->result_mask & ~STATX_VERSION;
 	tmp.stx_blksize = stat->blksize;
-	tmp.stx_attributes = stat->attributes;
+	/* STATX_ATTR_VERSION_MONOTONIC is kernel-only for now */
+	tmp.stx_attributes = stat->attributes & ~STATX_ATTR_VERSION_MONOTONIC;
 	tmp.stx_nlink = stat->nlink;
 	tmp.stx_uid = from_kuid_munged(current_user_ns(), stat->uid);
 	tmp.stx_gid = from_kgid_munged(current_user_ns(), stat->gid);
@@ -628,6 +636,11 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
+	/* STATX_VERSION is kernel-only for now. Ignore requests
+	 * from userland.
+	 */
+	mask &= ~STATX_VERSION;
+
 	error = vfs_statx(dfd, filename, flags, &stat, mask);
 	if (error)
 		return error;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index ff277ced50e9..4e9428d86a3a 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -52,6 +52,15 @@ struct kstat {
 	u64		mnt_id;
 	u32		dio_mem_align;
 	u32		dio_offset_align;
+	u64		version;
 };
 
+/* These definitions are internal to the kernel for now. Mainly used by nfsd. */
+
+/* mask values */
+#define STATX_VERSION		0x40000000U	/* Want/got stx_change_attr */
+
+/* file attribute values */
+#define STATX_ATTR_VERSION_MONOTONIC	0x8000000000000000ULL /* version monotonically increases */
+
 #endif
-- 
2.37.3

