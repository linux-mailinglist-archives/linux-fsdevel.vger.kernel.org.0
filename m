Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9515F0A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiI3L1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiI3L0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:26:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA4E33F;
        Fri, 30 Sep 2022 04:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AC6DB82796;
        Fri, 30 Sep 2022 11:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0497C4347C;
        Fri, 30 Sep 2022 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664536739;
        bh=St1cCChc0lbaP2GGgoYTfAcwzz9QW4MhOm7A/jIRCQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMwAocvfHTBKUtRqGroqE07NXObF5mX7jhX8Yb75KJ4sLpO6GlqOMMbKvITUPYfDG
         VhfFiQdBwCDsLYoWGp0y+JBTZy+X6CxdqsNIuRCyrFFtQE6m6Dd31cQAhlMcTrWUin
         uCWwnsAOKlIMBSMoOqhAfKjdBmumYru8t29F21uX2gOVDn61SaA/jZieZliVKTQMhh
         5T5zCYz+IqB3XcLMC2kFSiwNDl43vnl61dWKX8TqFGByzF3u0ZsTTogDC4YAuoJVcS
         O9LWMRwSxm/DtMXhe3LJPWKnvulaQEsZvuS1TFagOrdQ/WbFuCNC/LAvnRxGdJ7/NV
         uwyWWsIN1JHtQ==
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
Subject: [PATCH v6 7/9] vfs: expose STATX_VERSION to userland
Date:   Fri, 30 Sep 2022 07:18:38 -0400
Message-Id: <20220930111840.10695-8-jlayton@kernel.org>
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

Claim one of the spare fields in struct statx to hold a 64-bit inode
version attribute. When userland requests STATX_VERSION, copy the
value from the kstat struct there, and stop masking off
STATX_ATTR_VERSION_MONOTONIC.

Update the test-statx sample program to output the change attr and
MountId.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c                 | 12 +++---------
 include/linux/stat.h      |  9 ---------
 include/uapi/linux/stat.h |  6 ++++--
 samples/vfs/test-statx.c  |  8 ++++++--
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index e7f8cd4b24e1..8396c372022f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -593,11 +593,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 
 	memset(&tmp, 0, sizeof(tmp));
 
-	/* STATX_VERSION is kernel-only for now */
-	tmp.stx_mask = stat->result_mask & ~STATX_VERSION;
+	tmp.stx_mask = stat->result_mask;
 	tmp.stx_blksize = stat->blksize;
-	/* STATX_ATTR_VERSION_MONOTONIC is kernel-only for now */
-	tmp.stx_attributes = stat->attributes & ~STATX_ATTR_VERSION_MONOTONIC;
+	tmp.stx_attributes = stat->attributes;
 	tmp.stx_nlink = stat->nlink;
 	tmp.stx_uid = from_kuid_munged(current_user_ns(), stat->uid);
 	tmp.stx_gid = from_kgid_munged(current_user_ns(), stat->gid);
@@ -621,6 +619,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_version = stat->version;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
@@ -636,11 +635,6 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
-	/* STATX_VERSION is kernel-only for now. Ignore requests
-	 * from userland.
-	 */
-	mask &= ~STATX_VERSION;
-
 	error = vfs_statx(dfd, filename, flags, &stat, mask);
 	if (error)
 		return error;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 4e9428d86a3a..69c79e4fd1b1 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -54,13 +54,4 @@ struct kstat {
 	u32		dio_offset_align;
 	u64		version;
 };
-
-/* These definitions are internal to the kernel for now. Mainly used by nfsd. */
-
-/* mask values */
-#define STATX_VERSION		0x40000000U	/* Want/got stx_change_attr */
-
-/* file attribute values */
-#define STATX_ATTR_VERSION_MONOTONIC	0x8000000000000000ULL /* version monotonically increases */
-
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..4a0a1f27c059 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -127,7 +127,8 @@ struct statx {
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u64	stx_version; /* Inode change attribute */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -154,6 +155,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_VERSION		0x00004000U	/* Want/got stx_version */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -189,6 +191,6 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
-
+#define STATX_ATTR_VERSION_MONOTONIC	0x00400000 /* stx_version increases w/ every change */
 
 #endif /* _UAPI_LINUX_STAT_H */
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..bdbc371c9774 100644
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
+	if (stx->stx_mask & STATX_VERSION)
+		printf("Inode Version: 0x%llx\n", stx->stx_version);
 
 	if (stx->stx_attributes_mask) {
 		unsigned char bits, mbits;
@@ -218,7 +222,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_MNT_ID | STATX_VERSION;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
-- 
2.37.3

