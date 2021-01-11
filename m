Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2542F1644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 14:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbhAKNuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 08:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbhAKNuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:50:02 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D43C06179F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 05:49:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b2so18894601edm.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O0H688X6pJlKu4+88D8pIB5LDvlj2S8doKlOfC5cIRs=;
        b=g3w9cOLI9o05G2/TMeEcc82OCJDJQMliWZqEqAA7HbpM9AyAXH5u0ljkzcDmXY/8n7
         b/zswmirm8LwjCgNxZNT+Ue8duIE8olZuQsvJZ9kHGqD7ub+8E2/fhGStkvms/Z97fQB
         zGMkQv6StE//TVZ1l95yWPhR2hrAGzIt92GNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O0H688X6pJlKu4+88D8pIB5LDvlj2S8doKlOfC5cIRs=;
        b=h44Xl2dQUA7Hqj9oJvB/9OJYWvMWTR2/fOEu0eTa8YgaUOLwwW+8EZBXR2ke8OkTGz
         r1oqRBbLdeAE4h9WH4PmE2PRlZCBJ4ytVWWo8LsQfsx4jJx3m/kr0x2WTUHkWDDZXtNM
         jYfUCGpkfoXwDsBLQjy9EHcAMVxu5l2g8CMeIt6SOTVDEnEusi87dKUGsFhO1cUm8+98
         I1B4YcQhwm3/aI5/Cjiokpg0/6/ED+f4j8+wR10Nmn1EUmdTQawJn0uQXM1swO60UjPs
         SOXyZVD4tX6HdlwipyTbSF0OGT5PJ1qVW2p8br8YsapcaIM74f/7Q7QoqUjXeIqxxadG
         DwGg==
X-Gm-Message-State: AOAM530DfCI+ORPLDRShLU51u2+t5gAtsakNIv1WjNMOCBE1TXd5Ok40
        +K8n9c0NBVZulRPCZ0RpHOEJqQ==
X-Google-Smtp-Source: ABdhPJzmrusw9sZ8P5JVqRVRcmzdj5gM0e7ZYfCIWRwT+E+zktyjy1A3ltsqUYcQGxe/oN9D0t8aOA==
X-Received: by 2002:a05:6402:8d9:: with SMTP id d25mr13935564edz.278.1610372959372;
        Mon, 11 Jan 2021 05:49:19 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id bo20sm7759496edb.1.2021.01.11.05.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:49:18 -0800 (PST)
Date:   Mon, 11 Jan 2021 14:49:16 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into
 vfs_setxattr()
Message-ID: <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
 <20201207163255.564116-2-mszeredi@redhat.com>
 <87czyoimqz.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czyoimqz.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 01, 2021 at 11:35:16AM -0600, Eric W. Biederman wrote:
> Miklos Szeredi <mszeredi@redhat.com> writes:
> 
> > cap_convert_nscap() does permission checking as well as conversion of the
> > xattr value conditionally based on fs's user-ns.
> >
> > This is needed by overlayfs and probably other layered fs (ecryptfs) and is
> > what vfs_foo() is supposed to do anyway.
> 
> Well crap.
> 
> I just noticed this and it turns out this change is wrong.
> 
> The problem is that it reads the rootid from the v3 fscap, using
> current_user_ns() and then writes it using the sb->s_user_ns.
> 
> So any time the stacked filesystems sb->s_user_ns do not match or
> current_user_ns does not match sb->s_user_ns this could be a problem.
> 
> In a stacked filesystem a second pass through vfs_setxattr will result
> in the rootid being translated a second time (with potentially the wrong
> namespaces).  I think because of the security checks a we won't write
> something we shouldn't be able to write to the filesystem.  Still we
> will be writing the wrong v3 fscap which can go quite badly.
> 
> This doesn't look terribly difficult to fix.
> 
> Probably convert this into a fs independent form using uids in
> init_user_ns at input and have cap_convert_nscap convert the v3 fscap
> into the filesystem dependent form.  With some way for stackable
> filesystems to just skip converting it from the filesystem independent
> format.
> 
> Uids in xattrs that are expected to go directly to disk, but aren't
> always suitable for going directly to disk are tricky.

I've been looking at this for a couple of days and can't say I clearly
understand everything yet.

For one: a v2 fscap is supposed to be equivalent to a v3 fscap with a rootid of
zero, right?

If so, why does cap_inode_getsecurity() treat them differently (v2 fscap
succeeding unconditionally while v3 one being either converted to v2, rejected
or left as v3 depending on current_user_ns())?

Anyway, here's a patch that I think fixes getxattr() layering for
security.capability.  Does basically what you suggested.  Slight change of
semantics vs. v1 caps, not sure if that is still needed, getxattr()/setxattr()
hasn't worked for these since the introduction of v3 in 4.14.  Untested.

I still need to wrap my head around the permission requirements for the
setxattr() case...

Thanks,
Miklos

---
 fs/overlayfs/super.c       |   15 +++
 include/linux/capability.h |    2 
 include/linux/fs.h         |    1 
 security/commoncap.c       |  210 ++++++++++++++++++++++++---------------------
 4 files changed, 132 insertions(+), 96 deletions(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -395,6 +395,20 @@ static int ovl_remount(struct super_bloc
 	return ret;
 }
 
+static int ovl_cap_get(struct dentry *dentry,
+		       struct vfs_ns_cap_data *nscap)
+{
+	int res;
+	const struct cred *old_cred;
+	struct dentry *realdentry = ovl_dentry_real(dentry);
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	res = vfs_cap_get(realdentry, nscap);
+	revert_creds(old_cred);
+
+	return res;
+}
+
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
@@ -405,6 +419,7 @@ static const struct super_operations ovl
 	.statfs		= ovl_statfs,
 	.show_options	= ovl_show_options,
 	.remount_fs	= ovl_remount,
+	.cap_get	= ovl_cap_get,
 };
 
 enum {
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -272,4 +272,6 @@ extern int get_vfs_caps_from_disk(const
 
 extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
 
+int vfs_cap_get(struct dentry *dentry, struct vfs_ns_cap_data *nscap);
+
 #endif /* !_LINUX_CAPABILITY_H */
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1963,6 +1963,7 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
+	int (*cap_get)(struct dentry *dentry, struct vfs_ns_cap_data *nscap);
 };
 
 /*
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -341,6 +341,13 @@ static __u32 sansflags(__u32 m)
 	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
 }
 
+static bool is_v1header(size_t size, const struct vfs_cap_data *cap)
+{
+	if (size != XATTR_CAPS_SZ_1)
+		return false;
+	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_1;
+}
+
 static bool is_v2header(size_t size, const struct vfs_cap_data *cap)
 {
 	if (size != XATTR_CAPS_SZ_2)
@@ -355,6 +362,72 @@ static bool is_v3header(size_t size, con
 	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_3;
 }
 
+static bool validheader(size_t size, const struct vfs_cap_data *cap)
+{
+	return is_v1header(size, cap) || is_v2header(size, cap) || is_v3header(size, cap);
+}
+
+static void cap_to_v3(const struct vfs_cap_data *cap,
+			 struct vfs_ns_cap_data *nscap)
+{
+	u32 magic, nsmagic;
+
+	nsmagic = VFS_CAP_REVISION_3;
+	magic = le32_to_cpu(cap->magic_etc);
+	if (magic & VFS_CAP_FLAGS_EFFECTIVE)
+		nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
+	nscap->magic_etc = cpu_to_le32(nsmagic);
+	nscap->rootid = cpu_to_le32(0);
+}
+
+static int default_cap_get(struct dentry *dentry, struct vfs_ns_cap_data *nscap)
+{
+	int err;
+	ssize_t size;
+	kuid_t kroot;
+	uid_t root, mappedroot;
+	char *tmpbuf = NULL;
+	struct vfs_cap_data *cap;
+	struct user_namespace *fs_ns = dentry->d_sb->s_user_ns;
+
+	size = vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS, &tmpbuf,
+				  sizeof(struct vfs_ns_cap_data), GFP_NOFS);
+	if (size < 0)
+		return size;
+
+	cap = (struct vfs_cap_data *) tmpbuf;
+	err = -EINVAL;
+	if (!validheader(size, cap))
+		goto out;
+
+	memset(nscap, 0, sizeof(*nscap));
+	memcpy(nscap, tmpbuf, size);
+	if (!is_v3header(size, cap))
+		cap_to_v3(cap, nscap);
+
+	/* Convert rootid from fs user namespace to init user namespace */
+	root = le32_to_cpu(nscap->rootid);
+	kroot = make_kuid(fs_ns, root);
+	mappedroot = from_kuid(&init_user_ns, kroot);
+	nscap->rootid = cpu_to_le32(mappedroot);
+
+	err = 0;
+out:
+	kfree(tmpbuf);
+	return err;
+}
+
+int vfs_cap_get(struct dentry *dentry, struct vfs_ns_cap_data *nscap)
+{
+	struct super_block *sb = dentry->d_sb;
+
+	if (sb->s_op->cap_get)
+		return sb->s_op->cap_get(dentry, nscap);
+	else
+		return default_cap_get(dentry, nscap);
+}
+EXPORT_SYMBOL(vfs_cap_get);
+
 /*
  * getsecurity: We are called for security.* before any attempt to read the
  * xattr from the inode itself.
@@ -369,14 +442,15 @@ static bool is_v3header(size_t size, con
 int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 			  bool alloc)
 {
-	int size, ret;
+	int ret;
+	ssize_t size;
 	kuid_t kroot;
+	__le32 nsmagic, magic;
 	uid_t root, mappedroot;
-	char *tmpbuf = NULL;
+	void *tmpbuf = NULL;
 	struct vfs_cap_data *cap;
-	struct vfs_ns_cap_data *nscap;
+	struct vfs_ns_cap_data nscap;
 	struct dentry *dentry;
-	struct user_namespace *fs_ns;
 
 	if (strcmp(name, "capability") != 0)
 		return -EOPNOTSUPP;
@@ -385,67 +459,50 @@ int cap_inode_getsecurity(struct inode *
 	if (!dentry)
 		return -EINVAL;
 
-	size = sizeof(struct vfs_ns_cap_data);
-	ret = (int) vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS,
-				 &tmpbuf, size, GFP_NOFS);
+	ret = vfs_cap_get(dentry, &nscap);
 	dput(dentry);
 
 	if (ret < 0)
 		return ret;
 
-	fs_ns = inode->i_sb->s_user_ns;
-	cap = (struct vfs_cap_data *) tmpbuf;
-	if (is_v2header((size_t) ret, cap)) {
-		/* If this is sizeof(vfs_cap_data) then we're ok with the
-		 * on-disk value, so return that.  */
-		if (alloc)
-			*buffer = tmpbuf;
-		else
-			kfree(tmpbuf);
-		return ret;
-	} else if (!is_v3header((size_t) ret, cap)) {
-		kfree(tmpbuf);
-		return -EINVAL;
-	}
+	tmpbuf = kmalloc(sizeof(struct vfs_ns_cap_data), GFP_NOFS);
+	if (!tmpbuf)
+		return -ENOMEM;
 
-	nscap = (struct vfs_ns_cap_data *) tmpbuf;
-	root = le32_to_cpu(nscap->rootid);
-	kroot = make_kuid(fs_ns, root);
+	root = le32_to_cpu(nscap.rootid);
+	kroot = make_kuid(&init_user_ns, root);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
 	mappedroot = from_kuid(current_user_ns(), kroot);
 	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
+		size = sizeof(struct vfs_cap_data);
 		if (alloc) {
 			*buffer = tmpbuf;
-			nscap->rootid = cpu_to_le32(mappedroot);
-		} else
-			kfree(tmpbuf);
-		return size;
+			tmpbuf = NULL;
+			nscap.rootid = cpu_to_le32(mappedroot);
+			memcpy(*buffer, &nscap, size);
+		}
+		goto out;
 	}
 
-	if (!rootid_owns_currentns(kroot)) {
-		kfree(tmpbuf);
-		return -EOPNOTSUPP;
-	}
+	size = -EOPNOTSUPP;
+	if (!rootid_owns_currentns(kroot))
+		goto out;
 
 	/* This comes from a parent namespace.  Return as a v2 capability */
 	size = sizeof(struct vfs_cap_data);
 	if (alloc) {
-		*buffer = kmalloc(size, GFP_ATOMIC);
-		if (*buffer) {
-			struct vfs_cap_data *cap = *buffer;
-			__le32 nsmagic, magic;
-			magic = VFS_CAP_REVISION_2;
-			nsmagic = le32_to_cpu(nscap->magic_etc);
-			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
-				magic |= VFS_CAP_FLAGS_EFFECTIVE;
-			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
-			cap->magic_etc = cpu_to_le32(magic);
-		} else {
-			size = -ENOMEM;
-		}
+		cap = *buffer = tmpbuf;
+		tmpbuf = NULL;
+		magic = VFS_CAP_REVISION_2;
+		nsmagic = le32_to_cpu(nscap.magic_etc);
+		if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
+			magic |= VFS_CAP_FLAGS_EFFECTIVE;
+		memcpy(&cap->data, &nscap.data, sizeof(__le32) * 2 * VFS_CAP_U32);
+		cap->magic_etc = cpu_to_le32(magic);
 	}
+out:
 	kfree(tmpbuf);
 	return size;
 }
@@ -462,11 +519,6 @@ static kuid_t rootid_from_xattr(const vo
 	return make_kuid(task_ns, rootid);
 }
 
-static bool validheader(size_t size, const struct vfs_cap_data *cap)
-{
-	return is_v2header(size, cap) || is_v3header(size, cap);
-}
-
 /*
  * User requested a write of security.capability.  If needed, update the
  * xattr to change from v2 to v3, or to fixup the v3 rootid.
@@ -570,74 +622,40 @@ static inline int bprm_caps_from_vfs_cap
 int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	__u32 magic_etc;
-	unsigned tocopy, i;
-	int size;
-	struct vfs_ns_cap_data data, *nscaps = &data;
-	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
-	kuid_t rootkuid;
-	struct user_namespace *fs_ns;
+	unsigned int i;
+	int ret;
+	struct vfs_ns_cap_data nscaps;
 
 	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
 
 	if (!inode)
 		return -ENODATA;
 
-	fs_ns = inode->i_sb->s_user_ns;
-	size = __vfs_getxattr((struct dentry *)dentry, inode,
-			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
-	if (size == -ENODATA || size == -EOPNOTSUPP)
+	ret = vfs_cap_get((struct dentry *) dentry, &nscaps);
+	if (ret == -ENODATA || ret == -EOPNOTSUPP)
 		/* no data, that's ok */
 		return -ENODATA;
 
-	if (size < 0)
-		return size;
-
-	if (size < sizeof(magic_etc))
-		return -EINVAL;
-
-	cpu_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
+	if (ret < 0)
+		return ret;
 
-	rootkuid = make_kuid(fs_ns, 0);
-	switch (magic_etc & VFS_CAP_REVISION_MASK) {
-	case VFS_CAP_REVISION_1:
-		if (size != XATTR_CAPS_SZ_1)
-			return -EINVAL;
-		tocopy = VFS_CAP_U32_1;
-		break;
-	case VFS_CAP_REVISION_2:
-		if (size != XATTR_CAPS_SZ_2)
-			return -EINVAL;
-		tocopy = VFS_CAP_U32_2;
-		break;
-	case VFS_CAP_REVISION_3:
-		if (size != XATTR_CAPS_SZ_3)
-			return -EINVAL;
-		tocopy = VFS_CAP_U32_3;
-		rootkuid = make_kuid(fs_ns, le32_to_cpu(nscaps->rootid));
-		break;
+	cpu_caps->magic_etc = le32_to_cpu(nscaps.magic_etc);
+	cpu_caps->rootid = make_kuid(&init_user_ns, le32_to_cpu(nscaps.rootid));
 
-	default:
-		return -EINVAL;
-	}
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	if (!rootid_owns_currentns(rootkuid))
+	if (!rootid_owns_currentns(cpu_caps->rootid))
 		return -ENODATA;
 
 	CAP_FOR_EACH_U32(i) {
-		if (i >= tocopy)
-			break;
-		cpu_caps->permitted.cap[i] = le32_to_cpu(caps->data[i].permitted);
-		cpu_caps->inheritable.cap[i] = le32_to_cpu(caps->data[i].inheritable);
+		cpu_caps->permitted.cap[i] = le32_to_cpu(nscaps.data[i].permitted);
+		cpu_caps->inheritable.cap[i] = le32_to_cpu(nscaps.data[i].inheritable);
 	}
 
 	cpu_caps->permitted.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
 	cpu_caps->inheritable.cap[CAP_LAST_U32] &= CAP_LAST_U32_VALID_MASK;
 
-	cpu_caps->rootid = rootkuid;
-
 	return 0;
 }
 
