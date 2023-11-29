Return-Path: <linux-fsdevel+bounces-4269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EE7FE34A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9FF1C20AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46D47A55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MunA49Sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F361FB8;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F0A2C116D7;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294658;
	bh=uFzoiVjJtbvck1BcdPMgWuiZkFJlPHwpLqYlbNGQAXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MunA49SvgqILlcyTsUtk7fgy+OkvtA+Oj81PUI4cdPRthbZnHrxydq95+EQTiu8nv
	 lZLlNKfon5pIQDKEVKEucmEooVF1fW7E1r38rqyQ2KeH4zRznD9piWgMnn6C6SS47H
	 Fd+LUFm87XLhUD6BAqzpjzZZVvkC9RoQHGtAepgtdoAtVdTLTouOpWYiKDPpDMPGdv
	 gHrSl8y4+o/JTMhxGWhewuEjfY2BsK7xfpKV/fPsGwMdIh2rY4Vetk9mmxjd24/CLE
	 EJD3OPVZc34RSV9eAGFfR2P9Q0A2wWqdF0lV2lqJiftJYJigxxBsm5LDE8OjsYaXX1
	 OXzssEsnYb9rA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E745C10DC3;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:32 -0600
Subject: [PATCH 14/16] commoncap: remove cap_inode_getsecurity()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-14-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6309; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=uFzoiVjJtbvck1BcdPMgWuiZkFJlPHwpLqYlbNGQAXY=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I9Ry+ru3s9jQPglbV78Ohwi?=
 =?utf-8?q?5Zi3ZtxSMaZDa/z_LC4reqGJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyPQAKCRBTA5mu5fQxyXyDCA_CUQfFirgZg5wY4TmnfPxiTW/np4Xp05OLEQ?=
 =?utf-8?q?CBV7W1rWsmbDsYrGiA8d6TwhoVMbfXJA8KKOfWZDKjO_RSNVd4r2NRO29XJ7hbMny?=
 =?utf-8?q?I/1f8/4QBaldLAPtkvwxfzRQRQexpHRnNDImwIy7G7e2Z2XKqknELBOFg_K5jhQQ7?=
 =?utf-8?q?TFQiPSoTXaDk7VJ79pNZPSkldpxmJkFtIZHrvTXmjLRtgjNu/GMpORILf4Bgba/fv?=
 =?utf-8?q?2U4AdQ_CAMjnlEHxu6uvvU4AmvaUCropVe3elJFm74aNI9DM+IBSmMH3WWs7BmP5R?=
 =?utf-8?q?wwLn6VV/S16RWb5cgj6c?= bxPoIwdeFE8xzAui/554ryvi2XtD/U
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Reading of fscaps xattrs is now done via vfs_get_fscaps(), so there is
no longer any need to do it from security_inode_getsecurity(). Remove
cap_inode_getsecurity() and its associated helpers which are now unused.

We don't allow reading capabilities xattrs this way anyomre, so remove
the handler and associated helpers.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/security.h |   5 +-
 security/commoncap.c     | 132 -----------------------------------------------
 2 files changed, 1 insertion(+), 136 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326c881..784b85816907 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -158,9 +158,6 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name);
 int cap_inode_need_killpriv(struct dentry *dentry);
 int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
-int cap_inode_getsecurity(struct mnt_idmap *idmap,
-			  struct inode *inode, const char *name, void **buffer,
-			  bool alloc);
 extern int cap_mmap_addr(unsigned long addr);
 extern int cap_mmap_file(struct file *file, unsigned long reqprot,
 			 unsigned long prot, unsigned long flags);
@@ -934,7 +931,7 @@ static inline int security_inode_getsecurity(struct mnt_idmap *idmap,
 					     const char *name, void **buffer,
 					     bool alloc)
 {
-	return cap_inode_getsecurity(idmap, inode, name, buffer, alloc);
+	return -EOPNOTSUPP;
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
diff --git a/security/commoncap.c b/security/commoncap.c
index bd95b806af2f..ced7a3c9685f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -352,137 +352,6 @@ static __u32 sansflags(__u32 m)
 	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
 }
 
-static bool is_v2header(int size, const struct vfs_cap_data *cap)
-{
-	if (size != XATTR_CAPS_SZ_2)
-		return false;
-	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_2;
-}
-
-static bool is_v3header(int size, const struct vfs_cap_data *cap)
-{
-	if (size != XATTR_CAPS_SZ_3)
-		return false;
-	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_3;
-}
-
-/*
- * getsecurity: We are called for security.* before any attempt to read the
- * xattr from the inode itself.
- *
- * This gives us a chance to read the on-disk value and convert it.  If we
- * return -EOPNOTSUPP, then vfs_getxattr() will call the i_op handler.
- *
- * Note we are not called by vfs_getxattr_alloc(), but that is only called
- * by the integrity subsystem, which really wants the unconverted values -
- * so that's good.
- */
-int cap_inode_getsecurity(struct mnt_idmap *idmap,
-			  struct inode *inode, const char *name, void **buffer,
-			  bool alloc)
-{
-	int size;
-	kuid_t kroot;
-	vfsuid_t vfsroot;
-	u32 nsmagic, magic;
-	uid_t root, mappedroot;
-	char *tmpbuf = NULL;
-	struct vfs_cap_data *cap;
-	struct vfs_ns_cap_data *nscap = NULL;
-	struct dentry *dentry;
-	struct user_namespace *fs_ns;
-
-	if (strcmp(name, "capability") != 0)
-		return -EOPNOTSUPP;
-
-	dentry = d_find_any_alias(inode);
-	if (!dentry)
-		return -EINVAL;
-	size = vfs_getxattr_alloc(idmap, dentry, XATTR_NAME_CAPS, &tmpbuf,
-				  sizeof(struct vfs_ns_cap_data), GFP_NOFS);
-	dput(dentry);
-	/* gcc11 complains if we don't check for !tmpbuf */
-	if (size < 0 || !tmpbuf)
-		goto out_free;
-
-	fs_ns = inode->i_sb->s_user_ns;
-	cap = (struct vfs_cap_data *) tmpbuf;
-	if (is_v2header(size, cap)) {
-		root = 0;
-	} else if (is_v3header(size, cap)) {
-		nscap = (struct vfs_ns_cap_data *) tmpbuf;
-		root = le32_to_cpu(nscap->rootid);
-	} else {
-		size = -EINVAL;
-		goto out_free;
-	}
-
-	kroot = make_kuid(fs_ns, root);
-
-	/* If this is an idmapped mount shift the kuid. */
-	vfsroot = make_vfsuid(idmap, fs_ns, kroot);
-
-	/* If the root kuid maps to a valid uid in current ns, then return
-	 * this as a nscap. */
-	mappedroot = from_kuid(current_user_ns(), vfsuid_into_kuid(vfsroot));
-	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
-		size = sizeof(struct vfs_ns_cap_data);
-		if (alloc) {
-			if (!nscap) {
-				/* v2 -> v3 conversion */
-				nscap = kzalloc(size, GFP_ATOMIC);
-				if (!nscap) {
-					size = -ENOMEM;
-					goto out_free;
-				}
-				nsmagic = VFS_CAP_REVISION_3;
-				magic = le32_to_cpu(cap->magic_etc);
-				if (magic & VFS_CAP_FLAGS_EFFECTIVE)
-					nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
-				memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
-				nscap->magic_etc = cpu_to_le32(nsmagic);
-			} else {
-				/* use allocated v3 buffer */
-				tmpbuf = NULL;
-			}
-			nscap->rootid = cpu_to_le32(mappedroot);
-			*buffer = nscap;
-		}
-		goto out_free;
-	}
-
-	if (!rootid_owns_currentns(vfsroot)) {
-		size = -EOVERFLOW;
-		goto out_free;
-	}
-
-	/* This comes from a parent namespace.  Return as a v2 capability */
-	size = sizeof(struct vfs_cap_data);
-	if (alloc) {
-		if (nscap) {
-			/* v3 -> v2 conversion */
-			cap = kzalloc(size, GFP_ATOMIC);
-			if (!cap) {
-				size = -ENOMEM;
-				goto out_free;
-			}
-			magic = VFS_CAP_REVISION_2;
-			nsmagic = le32_to_cpu(nscap->magic_etc);
-			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
-				magic |= VFS_CAP_FLAGS_EFFECTIVE;
-			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
-			cap->magic_etc = cpu_to_le32(magic);
-		} else {
-			/* use unconverted v2 */
-			tmpbuf = NULL;
-		}
-		*buffer = cap;
-	}
-out_free:
-	kfree(tmpbuf);
-	return size;
-}
-
 /**
  * rootid_from_vfs_caps - translate root uid of vfs caps
  *
@@ -1616,7 +1485,6 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_creds_from_file, cap_bprm_creds_from_file),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
-	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
 	LSM_HOOK_INIT(mmap_addr, cap_mmap_addr),
 	LSM_HOOK_INIT(mmap_file, cap_mmap_file),
 	LSM_HOOK_INIT(task_fix_setuid, cap_task_fix_setuid),

-- 
2.43.0


