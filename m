Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2071D748D07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjGETGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjGETF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97A526AB;
        Wed,  5 Jul 2023 12:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F0161705;
        Wed,  5 Jul 2023 19:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07038C433C7;
        Wed,  5 Jul 2023 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583836;
        bh=agaQfFLs97B/2laDvZLTXaipIE9mmbV688h50qblTPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbAiKeFwgLo61vRFNDyy+Zg2tk4IEJSRgdihuWLOcuSYFYDLHRWkc3bFDWt2pv+6p
         YYlkIHYAwU7f3QBhErbQ09dAHiCR/lrKLDRn2zFvLgAir7wREK3FzSp2Cy5nbr6wBX
         Bkqv2A7eixzvZyQhIC/ywkVCTP3o3xcmdGmy/SXDsANqZdBTVosQyTLibPeQvT0nH2
         9lIoK6yQ+XKQVKNZFq93MI+ZCmEoNc7zpdEPf4199iQEq5v2ZcpH35i4ReN7JYS7jn
         XFrziUiZH8LCk2pjVadEMShdoXf/dphspLeh8uuEkGUoy3eltkz6K85WcGeoL81wZN
         VAh6z9WNkzWXQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH v2 30/92] ceph: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:55 -0400
Message-ID: <20230705190309.579783-28-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/acl.c   |  2 +-
 fs/ceph/caps.c  |  2 +-
 fs/ceph/inode.c | 17 ++++++++++-------
 fs/ceph/snap.c  |  2 +-
 fs/ceph/xattr.c |  2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 6945a938d396..c91b293267d7 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -93,7 +93,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	char *value = NULL;
 	struct iattr newattrs;
 	struct inode *inode = d_inode(dentry);
-	struct timespec64 old_ctime = inode->i_ctime;
+	struct timespec64 old_ctime = inode_get_ctime(inode);
 	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP) {
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e2bb0d0072da..09cd6d334604 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1400,7 +1400,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 
 	arg->mtime = inode->i_mtime;
 	arg->atime = inode->i_atime;
-	arg->ctime = inode->i_ctime;
+	arg->ctime = inode_get_ctime(inode);
 	arg->btime = ci->i_btime;
 	arg->change_attr = inode_peek_iversion_raw(inode);
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e5f41d45283..bcdb1a0beccf 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -100,7 +100,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	inode->i_uid = parent->i_uid;
 	inode->i_gid = parent->i_gid;
 	inode->i_mtime = parent->i_mtime;
-	inode->i_ctime = parent->i_ctime;
+	inode_set_ctime_to_ts(inode, inode_get_ctime(parent));
 	inode->i_atime = parent->i_atime;
 	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
@@ -688,6 +688,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 			 struct timespec64 *mtime, struct timespec64 *atime)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct timespec64 ictime = inode_get_ctime(inode);
 	int warn = 0;
 
 	if (issued & (CEPH_CAP_FILE_EXCL|
@@ -696,11 +697,12 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
-		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
+		    timespec64_compare(ctime, &ictime) > 0) {
 			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
-			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+			     inode_get_ctime(inode).tv_sec,
+			     inode_get_ctime(inode).tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
-			inode->i_ctime = *ctime;
+			inode_set_ctime_to_ts(inode, *ctime);
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
@@ -738,7 +740,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 	} else {
 		/* we have no write|excl caps; whatever the MDS says is true */
 		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) >= 0) {
-			inode->i_ctime = *ctime;
+			inode_set_ctime_to_ts(inode, *ctime);
 			inode->i_mtime = *mtime;
 			inode->i_atime = *atime;
 			ci->i_time_warp_seq = time_warp_seq;
@@ -2166,7 +2168,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
 		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
-		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+		     inode_get_ctime(inode).tv_sec,
+		     inode_get_ctime(inode).tv_nsec,
 		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
 		     only ? "ctime only" : "ignored");
 		if (only) {
@@ -2191,7 +2194,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (dirtied) {
 		inode_dirty_flags = __ceph_mark_dirty_caps(ci, dirtied,
 							   &prealloc_cf);
-		inode->i_ctime = attr->ia_ctime;
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 		inode_inc_iversion_raw(inode);
 	}
 
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 343d738448dc..c9920ade15f5 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -660,7 +660,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	capsnap->size = i_size_read(inode);
 	capsnap->mtime = inode->i_mtime;
 	capsnap->atime = inode->i_atime;
-	capsnap->ctime = inode->i_ctime;
+	capsnap->ctime = inode_get_ctime(inode);
 	capsnap->btime = ci->i_btime;
 	capsnap->change_attr = inode_peek_iversion_raw(inode);
 	capsnap->time_warp_seq = ci->i_time_warp_seq;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 806183959c47..1cbd84cc82a8 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1238,7 +1238,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL,
 					       &prealloc_cf);
 		ci->i_xattrs.dirty = true;
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 	}
 
 	spin_unlock(&ci->i_ceph_lock);
-- 
2.41.0

