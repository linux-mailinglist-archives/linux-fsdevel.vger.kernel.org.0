Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4955B02FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiIGLdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 07:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIGLdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22679B6D01;
        Wed,  7 Sep 2022 04:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B654A6185F;
        Wed,  7 Sep 2022 11:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0801C4347C;
        Wed,  7 Sep 2022 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662550411;
        bh=UtpmRgctuu/Uj5QkJbhrsp/EEwNxyiqmQFCHXeh1350=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEjTJB2eeaSYFBLsRymBFqIkjtbgN0EvVQZJxP0JbjBcr0cQYf1GTTQnoAquh1sPV
         XoLQKuHzKjXpxHuLB882sFfNpVGL7Eb7lsNd1X3d9vEfCv5ndSlM2Bwnmp43dpwmWe
         zDusx1LG8MRqghzMJk8hXwFkEP9c/f+1tazGGZuoyGkc/VbfbYXC8kElAG4TFTy/vx
         tD60GUQvEBofEb+zf/aLJigxZNqoa06xpNZ37zTkf15h3iWfFE51BHdTNMO+MqN+2d
         ud3aGQlz7Sz1LNbJxb+CMzML7D7VyIOQnuvJXQfo0Q3qskmq1C4werVKbMJS5PhbN2
         8DBGmeCN2w9Ag==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Frank Filz <ffilzlnx@mindspring.com>
Subject: [PATCH v4 4/6] vfs: report an inode version in statx for IS_I_VERSION inodes
Date:   Wed,  7 Sep 2022 07:33:16 -0400
Message-Id: <20220907113318.21810-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907113318.21810-1-jlayton@kernel.org>
References: <20220907113318.21810-1-jlayton@kernel.org>
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

The NFS server and IMA both rely heavily on the i_version counter, but
it's largely invisible to userland, which makes it difficult to test its
behavior. This value would also be of use to userland NFS servers, and
other applications that want a reliable way to know whether there might
have been an explicit change to an inode since they last checked.

Claim one of the spare fields in struct statx to hold a 64-bit inode
version attribute. This value must change with any explicit, observeable
metadata or data change. Note that atime updates are excluded from this,
unless it is due to an explicit change via utimes or similar mechanism.

When statx requests this attribute on an IS_I_VERSION inode, do an
inode_query_iversion and fill the result in the field. Also, update the
test-statx.c program to display the inode version and the mountid.

Cc: David Howells <dhowells@redhat.com>
Cc: Frank Filz <ffilzlnx@mindspring.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c                 | 7 +++++++
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 3 ++-
 samples/vfs/test-statx.c  | 8 ++++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 9ced8860e0f3..d892909836aa 100644
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
@@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_dev_major = MAJOR(stat->dev);
 	tmp.stx_dev_minor = MINOR(stat->dev);
 	tmp.stx_mnt_id = stat->mnt_id;
+	tmp.stx_ino_version = stat->ino_version;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 7df06931f25d..9cd77eb7bc1a 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -50,6 +50,7 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	u64		ino_version;
 };
 
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1500a0f58041..48d9307d7f31 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -124,7 +124,7 @@ struct statx {
 	__u32	stx_dev_minor;
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u64	__spare2;
+	__u64	stx_ino_version; /* Inode change attribute */
 	/* 0xa0 */
 	__u64	__spare3[12];	/* Spare space for future expansion */
 	/* 0x100 */
@@ -152,6 +152,7 @@ struct statx {
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_INO_VERSION	0x00002000U	/* Want/got stx_change_attr */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..23e68036fdfb 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -107,6 +107,8 @@ static void dump_statx(struct statx *stx)
 	printf("Device: %-15s", buffer);
 	if (stx->stx_mask & STATX_INO)
 		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
+	if (stx->stx_mask & STATX_MNT_ID)
+		printf(" MountId: %llx", stx->stx_mnt_id);
 	if (stx->stx_mask & STATX_NLINK)
 		printf(" Links: %-5u", stx->stx_nlink);
 	if (stx->stx_mask & STATX_TYPE) {
@@ -145,7 +147,9 @@ static void dump_statx(struct statx *stx)
 	if (stx->stx_mask & STATX_CTIME)
 		print_time("Change: ", &stx->stx_ctime);
 	if (stx->stx_mask & STATX_BTIME)
-		print_time(" Birth: ", &stx->stx_btime);
+		print_time("Birth: ", &stx->stx_btime);
+	if (stx->stx_mask & STATX_INO_VERSION)
+		printf("Inode Version: 0x%llx\n", stx->stx_ino_version);
 
 	if (stx->stx_attributes_mask) {
 		unsigned char bits, mbits;
@@ -218,7 +222,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_MNT_ID | STATX_INO_VERSION;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
-- 
2.37.3

