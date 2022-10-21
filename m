Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897186077C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJUNHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJUNHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7826C440;
        Fri, 21 Oct 2022 06:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D8E61E9D;
        Fri, 21 Oct 2022 13:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9A9C43470;
        Fri, 21 Oct 2022 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666357583;
        bh=A8k10DQZe5/j0onCVE9QxI6roj/l9wmzJGTvPKqqG6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFs7aCqFVXAySekdGZ4p3ryfOiNkMaOpcCi7/4qlgmjk3VblAe3HSrtPXkwuMDtrl
         7P37FbVpYNeUO9d28qUit+vYGLEv2jI60BUCYdM2yL4fjYNPTTg+DNSfw0fGli+TOx
         kDj69s1BfwU0UQGg7fQUXOed31wbkFKSTqP5aYXeUm274epkCIIr7AsTuJ2DcvF4RK
         PHjdGEjjp3+y2DEIQgbcG5pdAtKbSXXsmObb4RPSMc865STbUJCy0cdgR94fcpxc5F
         4Ehsb7+6NSOIJVsADEmPsHvLXr9LBTjzX8EfxiGY+hJ4xXXp43WVyIGG04imNsNT8k
         28IwdbMkB7k8w==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v8 8/8] nfsd: remove fetch_iversion export operation
Date:   Fri, 21 Oct 2022 09:06:02 -0400
Message-Id: <20221021130602.99099-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021130602.99099-1-jlayton@kernel.org>
References: <20221021130602.99099-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the i_version counter is reported in struct kstat, there is no
need for this export operation.

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/export.c          | 7 -------
 fs/nfsd/nfsfh.c          | 3 ---
 include/linux/exportfs.h | 1 -
 3 files changed, 11 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 01596f2d0a1e..1a9d5aa51dfb 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -145,17 +145,10 @@ nfs_get_parent(struct dentry *dentry)
 	return parent;
 }
 
-static u64 nfs_fetch_iversion(struct inode *inode)
-{
-	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
-	return inode_peek_iversion_raw(inode);
-}
-
 const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
-	.fetch_iversion = nfs_fetch_iversion,
 	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
 		EXPORT_OP_NOATOMIC_ATTR,
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 3e09129db340..bd450b141ca4 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -778,11 +778,8 @@ u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
 {
 	u64 chattr;
 
-	if (inode->i_sb->s_export_op->fetch_iversion)
-		return inode->i_sb->s_export_op->fetch_iversion(inode);
 	if (stat->result_mask & STATX_CHANGE_COOKIE) {
 		chattr = stat->change_cookie;
-
 		if (S_ISREG(inode->i_mode) &&
 		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
 			chattr += (u64)stat->ctime.tv_sec << 30;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3..9f4d4bcbf251 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -213,7 +213,6 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
-	u64 (*fetch_iversion)(struct inode *);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
-- 
2.37.3

