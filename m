Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF7609FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJXLNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJXLNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE847474C3;
        Mon, 24 Oct 2022 04:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B6361229;
        Mon, 24 Oct 2022 11:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9F5C43470;
        Mon, 24 Oct 2022 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609984;
        bh=tugYmxTjSAmzWp2HuL0/jzrCLECCOvxL5Y8QWdWcmyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoQigfp5QwNhzlzOw0CuMvP1+g+rxQ/Bn7ADsH8zy2xk21/H+C3V06qefpbl4SEYM
         fpC4DhTMUed5woeQqMsYhVVxM9LKd30sTZNKgUcbosobZqR6t6T2/dhlkDk5CN5Cvz
         MujWhw2NSWeP3Lx7ZcPYOXAOMFjxAZYkJmWAnjmylxyhrGevNto+S+BTbzHH2SdXRt
         XrNHCrikVa9FDGCf6LMOQsVAgRgp4k8uRdA+xDyHWAAruIVIJGbQg8ovwp9+gl9Y6l
         hGdMvsfgiKPUV+XyiKc4HYmo8ovbAjs4LPXM3v0GvIu17qGkXsllL7q1NqpqGbuRI6
         dDwJ+skbQQPiQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH 3/8] caps: use type safe idmapping helpers
Date:   Mon, 24 Oct 2022 13:12:44 +0200
Message-Id: <20221024111249.477648-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024111249.477648-1-brauner@kernel.org>
References: <20221024111249.477648-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6289; i=brauner@kernel.org; h=from:subject; bh=tugYmxTjSAmzWp2HuL0/jzrCLECCOvxL5Y8QWdWcmyI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSHFesKFqgLrligm/vvmfyuDd9ZTeOl2y9Xx39QPnF7w+Ww iQVbO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyoYGRYfPB9p3Xs/95h5QvMDtk4r 3t54Uth1M9ZCac+bPtqpF8LivDf48JaQoKTcWTGmT3eUkdef/Hpjr/Et//yKnmu2qWPP40lwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We already ported most parts and filesystems over for v6.0 to the new
vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
places so we can remove all the old helpers.
This is a non-functional change.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:

 kernel/capability.c  |  4 ++--
 security/commoncap.c | 51 ++++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index 765194f5d678..860fd22117c1 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -489,8 +489,8 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
 				 struct user_namespace *mnt_userns,
 				 const struct inode *inode)
 {
-	return kuid_has_mapping(ns, i_uid_into_mnt(mnt_userns, inode)) &&
-	       kgid_has_mapping(ns, i_gid_into_mnt(mnt_userns, inode));
+	return vfsuid_has_mapping(ns, i_uid_into_vfsuid(mnt_userns, inode)) &&
+	       vfsgid_has_mapping(ns, i_gid_into_vfsgid(mnt_userns, inode));
 }
 
 /**
diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986c3c77..b4ce33e20715 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -328,14 +328,16 @@ int cap_inode_killpriv(struct user_namespace *mnt_userns, struct dentry *dentry)
 	return error;
 }
 
-static bool rootid_owns_currentns(kuid_t kroot)
+static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
 {
 	struct user_namespace *ns;
+	kuid_t kroot;
 
-	if (!uid_valid(kroot))
+	if (!vfsuid_valid(rootvfsuid))
 		return false;
 
-	for (ns = current_user_ns(); ; ns = ns->parent) {
+	kroot = vfsuid_into_kuid(rootvfsuid);
+	for (ns = current_user_ns();; ns = ns->parent) {
 		if (from_kuid(ns, kroot) == 0)
 			return true;
 		if (ns == &init_user_ns)
@@ -381,6 +383,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 {
 	int size, ret;
 	kuid_t kroot;
+	vfsuid_t vfsroot;
 	u32 nsmagic, magic;
 	uid_t root, mappedroot;
 	char *tmpbuf = NULL;
@@ -419,11 +422,11 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	kroot = make_kuid(fs_ns, root);
 
 	/* If this is an idmapped mount shift the kuid. */
-	kroot = mapped_kuid_fs(mnt_userns, fs_ns, kroot);
+	vfsroot = make_vfsuid(mnt_userns, fs_ns, kroot);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
-	mappedroot = from_kuid(current_user_ns(), kroot);
+	mappedroot = from_kuid(current_user_ns(), vfsuid_into_kuid(vfsroot));
 	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
 		size = sizeof(struct vfs_ns_cap_data);
 		if (alloc) {
@@ -450,7 +453,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 		goto out_free;
 	}
 
-	if (!rootid_owns_currentns(kroot)) {
+	if (!rootid_owns_currentns(vfsroot)) {
 		size = -EOVERFLOW;
 		goto out_free;
 	}
@@ -488,29 +491,17 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
  * @value:	vfs caps value which may be modified by this function
  * @size:	size of @ivalue
  * @task_ns:	user namespace of the caller
- * @mnt_userns:	user namespace of the mount the inode was found from
- * @fs_userns:	user namespace of the filesystem
- *
- * If the inode has been found through an idmapped mount the user namespace of
- * the vfsmount must be passed through @mnt_userns. This function will then
- * take care to map the inode according to @mnt_userns before checking
- * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply passs init_user_ns.
  */
-static kuid_t rootid_from_xattr(const void *value, size_t size,
-				struct user_namespace *task_ns,
-				struct user_namespace *mnt_userns,
-				struct user_namespace *fs_userns)
+static vfsuid_t rootid_from_xattr(const void *value, size_t size,
+				  struct user_namespace *task_ns)
 {
 	const struct vfs_ns_cap_data *nscap = value;
-	kuid_t rootkid;
 	uid_t rootid = 0;
 
 	if (size == XATTR_CAPS_SZ_3)
 		rootid = le32_to_cpu(nscap->rootid);
 
-	rootkid = make_kuid(task_ns, rootid);
-	return mapped_kuid_user(mnt_userns, fs_userns, rootkid);
+	return VFSUIDT_INIT(make_kuid(task_ns, rootid));
 }
 
 static bool validheader(size_t size, const struct vfs_cap_data *cap)
@@ -548,6 +539,7 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 	struct user_namespace *task_ns = current_user_ns(),
 		*fs_ns = inode->i_sb->s_user_ns;
 	kuid_t rootid;
+	vfsuid_t vfsrootid;
 	size_t newsize;
 
 	if (!*ivalue)
@@ -561,7 +553,11 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 			/* user is privileged, just write the v2 */
 			return size;
 
-	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns, fs_ns);
+	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
+	if (!vfsuid_valid(vfsrootid))
+		return -EINVAL;
+
+	rootid = from_vfsuid(mnt_userns, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
@@ -655,6 +651,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	struct vfs_ns_cap_data data, *nscaps = &data;
 	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
 	kuid_t rootkuid;
+	vfsuid_t rootvfsuid;
 	struct user_namespace *fs_ns;
 
 	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
@@ -699,11 +696,15 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	default:
 		return -EINVAL;
 	}
+
+	rootvfsuid = make_vfsuid(mnt_userns, fs_ns, rootkuid);
+	if (!vfsuid_valid(rootvfsuid))
+		return -ENODATA;
+
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	rootkuid = mapped_kuid_fs(mnt_userns, fs_ns, rootkuid);
-	if (!rootid_owns_currentns(rootkuid))
+	if (!rootid_owns_currentns(rootvfsuid))
 		return -ENODATA;
 
 	CAP_FOR_EACH_U32(i) {
@@ -716,7 +717,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	cpu_caps->permitted.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
 	cpu_caps->inheritable.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
 
-	cpu_caps->rootid = rootkuid;
+	cpu_caps->rootid = vfsuid_into_kuid(rootvfsuid);
 
 	return 0;
 }
-- 
2.34.1

