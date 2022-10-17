Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6F3600D33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJQK6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiJQK6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:58:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E761135;
        Mon, 17 Oct 2022 03:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87ED8B81338;
        Mon, 17 Oct 2022 10:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0C6C43142;
        Mon, 17 Oct 2022 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666004251;
        bh=IFSEjIJ9849haCXwjIMjlrBQFkMr+ez73GPRlwR8RA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTvGFNOCk9adYVcWoJdmaLqoLOr9mZe4vfjD2CR+bk5kFt3mQr3TRyZ9VeVqw3vWc
         75uB9/qN74O3l06iOrAPwNi90tSGXI7QwycTpEVgKJE2n6fAk97o44zi+Y//SeCXgr
         F2SAomQaWPaJgfikV8Apjj9q+0URmKaViRA95YLqHzvGFiQgado/Mih8OM9wnOjY4X
         MUs8KDvXsb9qML6ZaHAFwfy4GW5sDqLZsvK8J+3b0gOBfZSGjEWolSsNVbuWbKcIm5
         9mdCKS4IEoiCpphQqhMigKXqGaXwOLLFn9K6H/3hpF2G680esQ+7AyKwnn9kzXxLYS
         XPQhxSOBNuVUw==
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
Subject: [PATCH v7 8/9] nfsd: remove fetch_iversion export operation
Date:   Mon, 17 Oct 2022 06:57:08 -0400
Message-Id: <20221017105709.10830-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017105709.10830-1-jlayton@kernel.org>
References: <20221017105709.10830-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/nfsd/nfsfh.c          | 2 --
 include/linux/exportfs.h | 1 -
 3 files changed, 10 deletions(-)

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
index 21b64ac97a06..9c1f697ffc72 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -777,8 +777,6 @@ u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
 {
 	u64 chattr;
 
-	if (inode->i_sb->s_export_op->fetch_iversion)
-		return inode->i_sb->s_export_op->fetch_iversion(inode);
 	if (stat->result_mask & STATX_VERSION) {
 		chattr = stat->version;
 
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

