Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6958AFD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbiHESfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbiHESfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:35:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE396765E;
        Fri,  5 Aug 2022 11:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E28B829F2;
        Fri,  5 Aug 2022 18:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58042C433C1;
        Fri,  5 Aug 2022 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659724547;
        bh=rTxZdWYcyUDsw35HfXDcwe1teGLqBNlOzMdnw0TScoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0JzmwCxMunXMqz2W2d286b6qohBaha2Iuo9HihcbgTlmjZgdBgFgvrU7GOCyGDjP
         6P7uNyz2m2QFpvrRIrn92mlo03Ua/yjJeCMnxBmnVKRUc/Z3sG/Wx9fJqx+eyYQRnf
         p6UGCCMEk/jy5Oy0O2Mvi8S+j12UyEQ05flmSDk8FyAdOkKgPMACPKQuvqkvOpIvF7
         LBfmXYcwBsbZ/EP9Eewexcu1Ic1lPOUGiIEO3y6pL42atW1aKWUSdBVDDWNnkb469O
         PfCldYXv0zezlS7DiJ31tAEAsCSEXTUlAgd8D66fbAnKQWmPtSBRhJo2hv9LdHMrcW
         itIW3V6IPHqDQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 1/4] vfs: report change attribute in statx for IS_I_VERSION inodes
Date:   Fri,  5 Aug 2022 14:35:40 -0400
Message-Id: <20220805183543.274352-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805183543.274352-1-jlayton@kernel.org>
References: <20220805183543.274352-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Claim one of the spare fields in struct statx to hold a 64-bit change
attribute. When statx requests this attribute, do an
inode_query_iversion and fill the result in the field.

Also update the test-statx.c program to fetch the change attribute as
well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/stat.c                 | 7 +++++++
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 3 ++-
 samples/vfs/test-statx.c  | 4 +++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 9ced8860e0f3..976e0a59ab23 100644
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
 
+	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
+		stat->result_mask |= STATX_CHGATTR;
+		stat->chgattr = inode_query_iversion(inode);
+	}
+
 	mnt_userns = mnt_user_ns(path->mnt);
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(mnt_userns, path, stat,
@@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_dev_major = MAJOR(stat->dev);
 	tmp.stx_dev_minor = MINOR(stat->dev);
 	tmp.stx_mnt_id = stat->mnt_id;
+	tmp.stx_chgattr = stat->chgattr;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 7df06931f25d..4a17887472f6 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -50,6 +50,7 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	u64		chgattr;
 };
 
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1500a0f58041..b45243a0fbc5 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -124,7 +124,7 @@ struct statx {
 	__u32	stx_dev_minor;
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u64	__spare2;
+	__u64	stx_chgattr;	/* Inode change attribute */
 	/* 0xa0 */
 	__u64	__spare3[12];	/* Spare space for future expansion */
 	/* 0x100 */
@@ -152,6 +152,7 @@ struct statx {
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_CHGATTR		0x00002000U	/* Want/git stx_chgattr */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..767208d2f564 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -109,6 +109,8 @@ static void dump_statx(struct statx *stx)
 		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
 	if (stx->stx_mask & STATX_NLINK)
 		printf(" Links: %-5u", stx->stx_nlink);
+	if (stx->stx_mask & STATX_CHGATTR)
+		printf(" Change Attr: 0x%llx", stx->stx_chgattr);
 	if (stx->stx_mask & STATX_TYPE) {
 		switch (stx->stx_mode & S_IFMT) {
 		case S_IFBLK:
@@ -218,7 +220,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_CHGATTR;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
-- 
2.37.1

