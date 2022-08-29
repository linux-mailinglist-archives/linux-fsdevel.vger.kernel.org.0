Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168B5A4C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiH2MxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiH2Mwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:52:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24E722295
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F1B8611F3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 12:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE34C433C1;
        Mon, 29 Aug 2022 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661776911;
        bh=pqLKDL54CcQESYFLu6mjNcMxrsqEba72ScNwiNwlHhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GK5mn4x5QIq1075URWZiPn2v6ffq7b4ToFNWLSb4Rb0SiTtCUtlh0n8S0V8sdFXY7
         TqHsvZliXVdi18hayoYg0IkyAb0ibJ5i0sxm8VUGJHWdMvXtfGCDI3GP4WXp1ZW6wi
         WT2qXqSdDa45NnRyIP2B5QEuHJulf8g8H/YrxqxxUi60rwxj1QBTkBrRDuZ1+JXHBW
         SQvU17ZFKt4FSGyhui5fYAFhoN6GC9R3SxTnw7TswiHQQ3iiqXYTLeYmeUi7ZZJg1K
         5nZfGYTA/171ELzfFfjn0DYwtbLxiPUqVz+jtq1oJxqTapbEFsSQI3r0x49b1winIk
         KYp3Fjer49q7w==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 4/6] acl: move idmapping handling into posix_acl_xattr_set()
Date:   Mon, 29 Aug 2022 14:38:43 +0200
Message-Id: <20220829123843.1146874-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829123843.1146874-1-brauner@kernel.org>
References: <20220829123843.1146874-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6043; i=brauner@kernel.org; h=from:subject; bh=pqLKDL54CcQESYFLu6mjNcMxrsqEba72ScNwiNwlHhw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTzbPp9ebrNtkMeWX8fNsilPrJMC1T9GSCR6THzjgSvhNlR nZ5XHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpWsbIsPZL7POXPw6vkE8t3avaV7 LsQXN79DuHVF7lr0Y/V07mucDI8H5tap3mUvNTUcLXs7rXnnnjXSN+1ZJb7iWDw6qWx4vMOAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

The uapi POSIX ACL struct passed through the value argument during
setxattr() contains {g,u}id values encoded via ACL_{GROUP,USER} entries
that should actually be stored in the form of k{g,u}id_t (See [1] for a
long explanation of the issue.).

In 0c5fd887d2bb ("acl: move idmapped mount fixup into vfs_{g,s}etxattr()")
we took the mount's idmapping into account in order to let overlayfs
handle POSIX ACLs on idmapped layers correctly. The fixup is currently
performed directly in vfs_setxattr() which piles on top of the earlier
hackiness by handling the mount's idmapping and stuff the vfs{g,u}id_t
values into the uapi struct as well. While that is all correct and works
fine it's just ugly.

Now that we have introduced vfs_make_posix_acl() earlier move handling
idmapped mounts out of vfs_setxattr() and into the POSIX ACL handler
where it belongs.

Note that we also need to call vfs_make_posix_acl() for EVM which
interpretes POSIX ACLs during security_inode_setxattr(). Leave them a
longer comment for future reference.

All filesystems that support idmapped mounts via FS_ALLOW_IDMAP use the
standard POSIX ACL xattr handlers and are covered by this change. This
includes overlayfs which simply calls vfs_{g,s}etxattr().

The following filesystems use custom POSIX ACL xattr handlers: 9p, cifs,
ecryptfs, and ntfs3 (and overlayfs but we've covered that in the paragraph
above) and none of them support idmapped mounts yet.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org/ [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c                    | 52 +++++++------------------------
 fs/xattr.c                        |  3 --
 security/integrity/evm/evm_main.c | 17 ++++++++--
 3 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 31eac28e6582..c759b8eef62e 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -771,46 +771,6 @@ void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 	}
 }
 
-void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
-				     const struct inode *inode,
-				     void *value, size_t size)
-{
-	struct posix_acl_xattr_header *header = value;
-	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
-	struct user_namespace *fs_userns = i_user_ns(inode);
-	int count;
-	vfsuid_t vfsuid;
-	vfsgid_t vfsgid;
-	kuid_t uid;
-	kgid_t gid;
-
-	if (no_idmapping(mnt_userns, i_user_ns(inode)))
-		return;
-
-	count = posix_acl_fix_xattr_common(value, size);
-	if (count <= 0)
-		return;
-
-	for (end = entry + count; entry != end; entry++) {
-		switch (le16_to_cpu(entry->e_tag)) {
-		case ACL_USER:
-			uid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
-			vfsuid = VFSUIDT_INIT(uid);
-			uid = from_vfsuid(mnt_userns, fs_userns, vfsuid);
-			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns, uid));
-			break;
-		case ACL_GROUP:
-			gid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
-			vfsgid = VFSGIDT_INIT(gid);
-			gid = from_vfsgid(mnt_userns, fs_userns, vfsgid);
-			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns, gid));
-			break;
-		default:
-			break;
-		}
-	}
-}
-
 static void posix_acl_fix_xattr_userns(
 	struct user_namespace *to, struct user_namespace *from,
 	void *value, size_t size)
@@ -1211,7 +1171,17 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 	int ret;
 
 	if (value) {
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
+		/*
+		 * By the time we end up here the {g,u}ids stored in
+		 * ACL_{GROUP,USER} have already been mapped according to the
+		 * caller's idmapping. The vfs_set_acl_prepare() helper will
+		 * recover them and take idmapped mounts into account. The
+		 * filesystem will receive the POSIX ACLs in in the correct
+		 * format ready to be cached or written to the backing store
+		 * taking the filesystem idmapping into account.
+		 */
+		acl = vfs_set_acl_prepare(mnt_userns, i_user_ns(inode),
+					  value, size);
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
diff --git a/fs/xattr.c b/fs/xattr.c
index a1f4998bc6be..3ac68ec0c023 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -305,9 +305,6 @@ vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		size = error;
 	}
 
-	if (size && is_posix_acl_xattr(name))
-		posix_acl_setxattr_idmapped_mnt(mnt_userns, inode, value, size);
-
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(mnt_userns, dentry, name, value, size,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2e6fb6e2ffd2..23d484e05e6f 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -457,10 +457,21 @@ static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
 	int rc;
 
 	/*
-	 * user_ns is not relevant here, ACL_USER/ACL_GROUP don't have impact
-	 * on the inode mode (see posix_acl_equiv_mode()).
+	 * An earlier comment here mentioned that the idmappings for
+	 * ACL_{GROUP,USER} don't matter since EVM is only interested in the
+	 * mode stored as part of POSIX ACLs. Nonetheless, if it must translate
+	 * from the uapi POSIX ACL representation to the VFS internal POSIX ACL
+	 * representation it should do so correctly. There's no guarantee that
+	 * we won't change POSIX ACLs in a way that ACL_{GROUP,USER} matters
+	 * for the mode at some point and it's difficult to keep track of all
+	 * the LSM and integrity modules and what they do to POSIX ACLs.
+	 *
+	 * Frankly, EVM shouldn't try to interpret the uapi struct for POSIX
+	 * ACLs it received. It requires knowledge that only the VFS is
+	 * guaranteed to have.
 	 */
-	acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
+	acl = vfs_set_acl_prepare(mnt_userns, i_user_ns(inode),
+				  xattr_value, xattr_value_len);
 	if (IS_ERR_OR_NULL(acl))
 		return 1;
 
-- 
2.34.1

