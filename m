Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20612595AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiHPL4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 07:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiHPL4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1987268A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 04:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D937611FE
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C98C433C1;
        Tue, 16 Aug 2022 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660649726;
        bh=18iH9zVDGXfpWegkwX2jDKkU/+Xbxd4dZIN6MAMFG+o=;
        h=From:To:Cc:Subject:Date:From;
        b=Fq1ASFikDXGjloYdVsgC4Dk48Dl4hTnnxNQUcSF9vNMoLGjfWF45ipfDsCpq9/wdR
         IrbTnh86tbUaqGKP6UxIGEvWeD+kvWz7ejvAShBmEa5e4aeMZL8kWdmKioD4RTV8OZ
         CdlUCgmAZqsQ4mQ2573hls6fxe8Tx1IVi6l+pH2qw50fu+udBXsGO/2UpHxJTEikdK
         eTzEHcr8wNolK0ApNCBUawKy0GWrO+1r5a2aiKozZ20Ly2LTRbxCX5w4TwOEIUqUh/
         vSv6o9o3fQ/IOrvgvIz+xiqkl9SXP1vhIyGeTPy32qZWXfqaaxYDAsB/GQ6LA4hTgq
         t3I6aQskKXl8Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH 1/2] acl: handle idmapped mounts for idmapped filesystems
Date:   Tue, 16 Aug 2022 13:35:13 +0200
Message-Id: <20220816113514.43304-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Ensure that POSIX ACLs checking, getting, and setting works correctly
for filesystems mountable with a filesystem idmapping ("fs_idmapping")
that want to support idmapped mounts ("mnt_idmapping").

Note that no filesystems mountable with an fs_idmapping do yet support
idmapped mounts. This is required infrastructure work to unblock this.

As we explained in detail in [1] the fs_idmapping is irrelevant for
getxattr() and setxattr() when mapping the ACL_{GROUP,USER} {g,u}ids
stored in the uapi struct posix_acl_xattr_entry in
posix_acl_fix_xattr_{from,to}_user().

But for acl_permission_check() and posix_acl_{g,s}etxattr_idmapped_mnt()
the fs_idmapping matters.

acl_permission_check():
  During lookup POSIX ACLs are retrieved directly via i_op->get_acl() and
  are returned via the kernel internal struct posix_acl which contains
  e_{g,u}id members of type k{g,u}id_t that already take the
  fs_idmapping into acccount.

  For example, a POSIX ACL stored with u4 on the backing store is mapped
  to k10000004 in the fs_idmapping. The mnt_idmapping remaps the POSIX ACL
  to k20000004. In order to do that the fs_idmapping needs to be taken
  into account but that doesn't happen yet (Again, this is a
  counterfactual currently as fuse doesn't support idmapped mounts
  currently. It's just used as a convenient example.):

  fs_idmapping:  u0:k10000000:r65536
  mnt_idmapping: u0:v20000000:r65536
  ACL_USER:      k10000004

  acl_permission_check()
  -> check_acl()
     -> get_acl()
        -> i_op->get_acl() == fuse_get_acl()
           -> posix_acl_from_xattr(u0:k10000000:r65536 /* fs_idmapping */, ...)
              {
                      k10000004 = make_kuid(u0:k10000000:r65536 /* fs_idmapping */,
                                            u4 /* ACL_USER */);
              }
     -> posix_acl_permission()
        {
                -1 = make_vfsuid(u0:v20000000:r65536 /* mnt_idmapping */,
                                 &init_user_ns,
                                 k10000004);
                vfsuid_eq_kuid(-1, k10000004 /* caller_fsuid */)
        }

  In order to correctly map from the fs_idmapping into mnt_idmapping we
  require the relevant fs_idmaping to be passed:

  acl_permission_check()
  -> check_acl()
     -> get_acl()
        -> i_op->get_acl() == fuse_get_acl()
           -> posix_acl_from_xattr(u0:k10000000:r65536 /* fs_idmapping */, ...)
              {
                      k10000004 = make_kuid(u0:k10000000:r65536 /* fs_idmapping */,
                                            u4 /* ACL_USER */);
              }
     -> posix_acl_permission()
        {
                v20000004 = make_vfsuid(u0:v20000000:r65536 /* mnt_idmapping */,
                                        u0:k10000000:r65536 /* fs_idmapping */,
                                        k10000004);
                vfsuid_eq_kuid(v20000004, k10000004 /* caller_fsuid */)
        }

  The initial_idmapping is only correct for the current situation because
  all filesystems that currently support idmapped mounts do not support
  being mounted with an fs_idmapping.

  Note that ovl_get_acl() is used to retrieve the POSIX ACLs from the
  relevant lower layer and the lower layer's mnt_idmapping needs to be
  taken into account and so does the fs_idmapping. See 0c5fd887d2bb ("acl:
  move idmapped mount fixup into vfs_{g,s}etxattr()") for more details.

For posix_acl_{g,s}etxattr_idmapped_mnt() it is not as obvious why the
fs_idmapping matters as it is for acl_permission_check(). Especially
because it doesn't matter for posix_acl_fix_xattr_{from,to}_user() (See
[1] for more context.).

Because posix_acl_{g,s}etxattr_idmapped_mnt() operate on the uapi
struct posix_acl_xattr_entry which contains {g,u}id_t values and thus
give the impression that the fs_idmapping is irrelevant as at this point
appropriate {g,u}id_t values have seemlingly been generated.

As we've stated multiple times this assumption is wrong and in fact the
uapi struct posix_acl_xattr_entry is taking idmappings into account
depending at what place it is operated on.

posix_acl_getxattr_idmapped_mnt()
  When posix_acl_getxattr_idmapped_mnt() is called the values stored in
  the uapi struct posix_acl_xattr_entry are mapped according to the
  fs_idmapping. This happened when they were read from the backing store
  and then translated from struct posix_acl into the uapi
  struct posix_acl_xattr_entry during posix_acl_to_xattr().

  In other words, the fs_idmapping matters as the values stored as
  {g,u}id_t in the uapi struct posix_acl_xattr_entry have been generated
  by it.

  So we need to take the fs_idmapping into account during make_vfsuid()
  in posix_acl_getxattr_idmapped_mnt().

posix_acl_setxattr_idmapped_mnt()
  When posix_acl_setxattr_idmapped_mnt() is called the values stored as
  {g,u}id_t in uapi struct posix_acl_xattr_entry are intended to be the
  values that ultimately get turned back into a k{g,u}id_t in
  posix_acl_from_xattr() (which turns the uapi
  struct posix_acl_xattr_entry into the kernel internal struct posix_acl).

  In other words, the fs_idmapping matters as the values stored as
  {g,u}id_t in the uapi struct posix_acl_xattr_entry are intended to be
  the values that will be undone in the fs_idmapping when writing to the
  backing store.

  So we need to take the fs_idmapping into account during from_vfsuid()
  in posix_acl_setxattr_idmapped_mnt().

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Fixes: 0c5fd887d2bb ("acl: move idmapped mount fixup into vfs_{g,s}etxattr()")
Cc: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 11 +++++++----
 fs/posix_acl.c       | 15 +++++++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b45fea69fff3..0fbcb590af84 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -460,9 +460,12 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
  * of the POSIX ACLs retrieved from the lower layer to this function to not
  * alter the POSIX ACLs for the underlying filesystem.
  */
-static void ovl_idmap_posix_acl(struct user_namespace *mnt_userns,
+static void ovl_idmap_posix_acl(struct inode *realinode,
+				struct user_namespace *mnt_userns,
 				struct posix_acl *acl)
 {
+	struct user_namespace *fs_userns = i_user_ns(realinode);
+
 	for (unsigned int i = 0; i < acl->a_count; i++) {
 		vfsuid_t vfsuid;
 		vfsgid_t vfsgid;
@@ -470,11 +473,11 @@ static void ovl_idmap_posix_acl(struct user_namespace *mnt_userns,
 		struct posix_acl_entry *e = &acl->a_entries[i];
 		switch (e->e_tag) {
 		case ACL_USER:
-			vfsuid = make_vfsuid(mnt_userns, &init_user_ns, e->e_uid);
+			vfsuid = make_vfsuid(mnt_userns, fs_userns, e->e_uid);
 			e->e_uid = vfsuid_into_kuid(vfsuid);
 			break;
 		case ACL_GROUP:
-			vfsgid = make_vfsgid(mnt_userns, &init_user_ns, e->e_gid);
+			vfsgid = make_vfsgid(mnt_userns, fs_userns, e->e_gid);
 			e->e_gid = vfsgid_into_kgid(vfsgid);
 			break;
 		}
@@ -536,7 +539,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 	if (!clone)
 		clone = ERR_PTR(-ENOMEM);
 	else
-		ovl_idmap_posix_acl(mnt_user_ns(realpath.mnt), clone);
+		ovl_idmap_posix_acl(realinode, mnt_user_ns(realpath.mnt), clone);
 	/*
 	 * Since we're not in RCU path walk we always need to release the
 	 * original ACLs.
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 1d17d7b13dcd..5af33800743e 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -361,6 +361,7 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		     const struct posix_acl *acl, int want)
 {
 	const struct posix_acl_entry *pa, *pe, *mask_obj;
+	struct user_namespace *fs_userns = i_user_ns(inode);
 	int found = 0;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -376,7 +377,7 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				vfsuid = make_vfsuid(mnt_userns, &init_user_ns,
+				vfsuid = make_vfsuid(mnt_userns, fs_userns,
 						     pa->e_uid);
 				if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
                                         goto mask;
@@ -390,7 +391,7 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                 }
 				break;
                         case ACL_GROUP:
-				vfsgid = make_vfsgid(mnt_userns, &init_user_ns,
+				vfsgid = make_vfsgid(mnt_userns, fs_userns,
 						     pa->e_gid);
 				if (vfsgid_in_group_p(vfsgid)) {
 					found = 1;
@@ -736,6 +737,7 @@ void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 {
 	struct posix_acl_xattr_header *header = value;
 	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
+	struct user_namespace *fs_userns = i_user_ns(inode);
 	int count;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -753,13 +755,13 @@ void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 		switch (le16_to_cpu(entry->e_tag)) {
 		case ACL_USER:
 			uid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
-			vfsuid = make_vfsuid(mnt_userns, &init_user_ns, uid);
+			vfsuid = make_vfsuid(mnt_userns, fs_userns, uid);
 			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns,
 						vfsuid_into_kuid(vfsuid)));
 			break;
 		case ACL_GROUP:
 			gid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
-			vfsgid = make_vfsgid(mnt_userns, &init_user_ns, gid);
+			vfsgid = make_vfsgid(mnt_userns, fs_userns, gid);
 			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns,
 						vfsgid_into_kgid(vfsgid)));
 			break;
@@ -775,6 +777,7 @@ void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 {
 	struct posix_acl_xattr_header *header = value;
 	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
+	struct user_namespace *fs_userns = i_user_ns(inode);
 	int count;
 	vfsuid_t vfsuid;
 	vfsgid_t vfsgid;
@@ -793,13 +796,13 @@ void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
 		case ACL_USER:
 			uid = make_kuid(&init_user_ns, le32_to_cpu(entry->e_id));
 			vfsuid = VFSUIDT_INIT(uid);
-			uid = from_vfsuid(mnt_userns, &init_user_ns, vfsuid);
+			uid = from_vfsuid(mnt_userns, fs_userns, vfsuid);
 			entry->e_id = cpu_to_le32(from_kuid(&init_user_ns, uid));
 			break;
 		case ACL_GROUP:
 			gid = make_kgid(&init_user_ns, le32_to_cpu(entry->e_id));
 			vfsgid = VFSGIDT_INIT(gid);
-			gid = from_vfsgid(mnt_userns, &init_user_ns, vfsgid);
+			gid = from_vfsgid(mnt_userns, fs_userns, vfsgid);
 			entry->e_id = cpu_to_le32(from_kgid(&init_user_ns, gid));
 			break;
 		default:

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.34.1

