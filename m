Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F167A2F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjAXTbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjAXTbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:31:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E374FCF8;
        Tue, 24 Jan 2023 11:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4F4B816BF;
        Tue, 24 Jan 2023 19:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00593C433A0;
        Tue, 24 Jan 2023 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588646;
        bh=hGCv1KZZe3GeYILHnAYauWOgUNQlZo/l7V3HpJWTqjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iO9erBwVo9YQ5VD3CeEEIYGF4jgJVgoNTKa0Cst/fW0YKY2hXQyVceYdu1Kumc0xA
         6eufYARO8WsmmwiZOJ19PO+P7Y6+4Uz1KOnUAFmIYFbF50NFfQsc4+3yPSLdaROGB4
         DTF/EJxHTNmrqgo+BLEQHYrTVrLQ0sqMc88HU2HCtnHJ39x0zCSAHCmA3jB/rt6a3M
         1XxWWaE+R0Cqs3uDxXoqgtHSQ0FemJMbNtmn8+e/wkDbTrlAt0ZNtv1ua9euyXeP8y
         ynNcZEK5WdVwEU3QSr9u27ZPH81ELpEvaI21jt+a1HwLSpS0Ye4af/whs/Vhpc6Nx2
         xR31eDqczLJMg==
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
Subject: [PATCH v8 RESEND 8/8] nfsd: remove fetch_iversion export operation
Date:   Tue, 24 Jan 2023 14:30:25 -0500
Message-Id: <20230124193025.185781-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the i_version counter is reported in struct kstat, there is no
need for this export operation.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
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
index 3a01c8601712..76ea268dc420 100644
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
2.39.1

