Return-Path: <linux-fsdevel+bounces-59451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC63B38F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 02:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F43E189D0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F281CA81;
	Thu, 28 Aug 2025 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b8rsF1r7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BA1A26B;
	Thu, 28 Aug 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339244; cv=none; b=E1BQMk6lxHKwtWtLbidghkpn7imxK5Uzv63uD1UmKHXO03wezFTxFNt8uauBI1/VolLSLXoEVxodjxAIPtJ7UIlDGHyanXDcBg60CoRYfxhvvNqX0PwJXxP4m46u93zTcqAFZLs9ltSDvpCya20HhV//jyJxJopM/Z9HUuOvve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339244; c=relaxed/simple;
	bh=hUB4jXYm2jOyc1ZM6ZAeXrkBLPV8j8p4GAHwMfn8nxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhQkFn3s4jfm2dhHX2v38xnWTRT6jmwkXxf/t+JCdtirD3nGv3g9ijz6vowVejkooNjVYDLnlmlhx9bJfYJFG50OrIzX65/RnkOmIdEAFJOzxjdPDsT2z+9UqyJjrexJRUjY/vP7V5OGq5ywXTmdmcqfL26Az95MGxDWth5nxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b8rsF1r7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JKTlisnzss8xAGKeDwCMntmR8j2dqeoW6r5DqPwN/xo=; b=b8rsF1r7NF/QHI/OFDnEp3SB7C
	SSBtQfkiXFVwv7anYfWqxCKB8zBM1Xc1Kq8Tfeky86UIL34uAJ6QZqYJlNllajXrFgYc4gZwilONP
	HMVKGgjB/P7Tt3wz24WznZlDPNTk8rGrkcmgxFe62u3O/NYtbULst2T2yi1hHC0Zqf6C5geFHiR0E
	kqucwqLCkYtaOhnmeS7GpzCiy92wYRraxIBf3Vwk4JsUNorgtt6qM+1TnqL0Gz4fRr7SRggUMhOm4
	H+56utHyhwmgYhwJQURpgRUw29a8oyIbuJdtU7bKU7ED6K7F+QMHakw7i3RaPeydl8mkSGrwicrrz
	OPYghRNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urQ4F-0000000Cdkr-45OJ;
	Thu, 28 Aug 2025 00:00:40 +0000
Date: Thu, 28 Aug 2025 01:00:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] change the calling conventions for vfs_parse_fs_string()
Message-ID: <20250828000039.GA3011378@ZenIV>
References: <20250828000001.GY39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828000001.GY39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Absolute majority of callers are passing the 4th argument equal to
strlen() of the 3rd one.

Drop the v_size argument, add vfs_parse_fs_qstr() for the cases that
want independent length.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/mount_api.rst | 10 +++++++++-
 Documentation/filesystems/porting.rst   | 10 ++++++++++
 drivers/gpu/drm/i915/gem/i915_gemfs.c   |  9 ++-------
 drivers/gpu/drm/v3d/v3d_gemfs.c         |  9 ++-------
 fs/afs/mntpt.c                          |  3 ++-
 fs/fs_context.c                         | 17 +++++++----------
 fs/namespace.c                          |  8 +++-----
 fs/nfs/fs_context.c                     |  3 +--
 fs/nfs/namespace.c                      |  3 ++-
 fs/smb/client/fs_context.c              |  4 +---
 include/linux/fs_context.h              |  9 +++++++--
 kernel/trace/trace.c                    |  3 +--
 12 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index e149b89118c8..c99ab1f7fea4 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -504,10 +504,18 @@ returned.
      clear the pointer, but then becomes responsible for disposing of the
      object.
 
+   * ::
+
+       int vfs_parse_fs_qstr(struct fs_context *fc, const char *key,
+			       const struct qstr *value);
+
+     A wrapper around vfs_parse_fs_param() that copies the value string it is
+     passed.
+
    * ::
 
        int vfs_parse_fs_string(struct fs_context *fc, const char *key,
-			       const char *value, size_t v_size);
+			       const char *value);
 
      A wrapper around vfs_parse_fs_param() that copies the value string it is
      passed.
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..a9ef6851b8c0 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,13 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+---
+
+**mandatory**
+
+Calling conventions for vfs_parse_fs_string() have changed; it does *not*
+take length anymore (value ? strlen(value) : 0 is used).  If you want
+a different length, use
+	vfs_parse_fs_qstr(fc, key, &QSTR_LEN(value, len))
+instead.
diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index a09e2eb47175..8f13ec4ff0d0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -11,11 +11,6 @@
 #include "i915_gemfs.h"
 #include "i915_utils.h"
 
-static int add_param(struct fs_context *fc, const char *key, const char *val)
-{
-	return vfs_parse_fs_string(fc, key, val, strlen(val));
-}
-
 void i915_gemfs_init(struct drm_i915_private *i915)
 {
 	struct file_system_type *type;
@@ -48,9 +43,9 @@ void i915_gemfs_init(struct drm_i915_private *i915)
 	fc = fs_context_for_mount(type, SB_KERNMOUNT);
 	if (IS_ERR(fc))
 		goto err;
-	ret = add_param(fc, "source", "tmpfs");
+	ret = vfs_parse_fs_string(fc, "source", "tmpfs");
 	if (!ret)
-		ret = add_param(fc, "huge", "within_size");
+		ret = vfs_parse_fs_string(fc, "huge", "within_size");
 	if (!ret)
 		gemfs = fc_mount_longterm(fc);
 	put_fs_context(fc);
diff --git a/drivers/gpu/drm/v3d/v3d_gemfs.c b/drivers/gpu/drm/v3d/v3d_gemfs.c
index 8ec6ed82b3d9..c1a30166c099 100644
--- a/drivers/gpu/drm/v3d/v3d_gemfs.c
+++ b/drivers/gpu/drm/v3d/v3d_gemfs.c
@@ -7,11 +7,6 @@
 
 #include "v3d_drv.h"
 
-static int add_param(struct fs_context *fc, const char *key, const char *val)
-{
-	return vfs_parse_fs_string(fc, key, val, strlen(val));
-}
-
 void v3d_gemfs_init(struct v3d_dev *v3d)
 {
 	struct file_system_type *type;
@@ -38,9 +33,9 @@ void v3d_gemfs_init(struct v3d_dev *v3d)
 	fc = fs_context_for_mount(type, SB_KERNMOUNT);
 	if (IS_ERR(fc))
 		goto err;
-	ret = add_param(fc, "source", "tmpfs");
+	ret = vfs_parse_fs_string(fc, "source", "tmpfs");
 	if (!ret)
-		ret = add_param(fc, "huge", "within_size");
+		ret = vfs_parse_fs_string(fc, "huge", "within_size");
 	if (!ret)
 		gemfs = fc_mount_longterm(fc);
 	put_fs_context(fc);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 9434a5399f2b..1ad048e6e164 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -137,7 +137,8 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 
 		ret = -EINVAL;
 		if (content[size - 1] == '.')
-			ret = vfs_parse_fs_string(fc, "source", content, size - 1);
+			ret = vfs_parse_fs_qstr(fc, "source",
+						&QSTR_LEN(content, size - 1));
 		do_delayed_call(&cleanup);
 		if (ret < 0)
 			return ret;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 666e61753aed..93b7ebf8d927 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -161,25 +161,24 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 EXPORT_SYMBOL(vfs_parse_fs_param);
 
 /**
- * vfs_parse_fs_string - Convenience function to just parse a string.
+ * vfs_parse_fs_qstr - Convenience function to just parse a string.
  * @fc: Filesystem context.
  * @key: Parameter name.
  * @value: Default value.
- * @v_size: Maximum number of bytes in the value.
  */
-int vfs_parse_fs_string(struct fs_context *fc, const char *key,
-			const char *value, size_t v_size)
+int vfs_parse_fs_qstr(struct fs_context *fc, const char *key,
+			const struct qstr *value)
 {
 	int ret;
 
 	struct fs_parameter param = {
 		.key	= key,
 		.type	= fs_value_is_flag,
-		.size	= v_size,
+		.size	= value ? value->len : 0,
 	};
 
 	if (value) {
-		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+		param.string = kmemdup_nul(value->name, value->len, GFP_KERNEL);
 		if (!param.string)
 			return -ENOMEM;
 		param.type = fs_value_is_string;
@@ -189,7 +188,7 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 	kfree(param.string);
 	return ret;
 }
-EXPORT_SYMBOL(vfs_parse_fs_string);
+EXPORT_SYMBOL(vfs_parse_fs_qstr);
 
 /**
  * vfs_parse_monolithic_sep - Parse key[=val][,key[=val]]* mount data
@@ -218,16 +217,14 @@ int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
 
 	while ((key = sep(&options)) != NULL) {
 		if (*key) {
-			size_t v_len = 0;
 			char *value = strchr(key, '=');
 
 			if (value) {
 				if (unlikely(value == key))
 					continue;
 				*value++ = 0;
-				v_len = strlen(value);
 			}
-			ret = vfs_parse_fs_string(fc, key, value, v_len);
+			ret = vfs_parse_fs_string(fc, key, value);
 			if (ret < 0)
 				break;
 		}
diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..88636124c8fe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1281,8 +1281,7 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 		return ERR_CAST(fc);
 
 	if (name)
-		ret = vfs_parse_fs_string(fc, "source",
-					  name, strlen(name));
+		ret = vfs_parse_fs_string(fc, "source", name);
 	if (!ret)
 		ret = parse_monolithic_mount_data(fc, data);
 	if (!ret)
@@ -3793,10 +3792,9 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	fc->oldapi = true;
 
 	if (subtype)
-		err = vfs_parse_fs_string(fc, "subtype",
-					  subtype, strlen(subtype));
+		err = vfs_parse_fs_string(fc, "subtype", subtype);
 	if (!err && name)
-		err = vfs_parse_fs_string(fc, "source", name, strlen(name));
+		err = vfs_parse_fs_string(fc, "source", name);
 	if (!err)
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9e94d18448ff..b4679b7161b0 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1269,8 +1269,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 			int ret;
 
 			data->context[NFS_MAX_CONTEXT_LEN] = '\0';
-			ret = vfs_parse_fs_string(fc, "context",
-						  data->context, strlen(data->context));
+			ret = vfs_parse_fs_string(fc, "context", data->context);
 			if (ret < 0)
 				return ret;
 #else
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 7f1ec9c67ff2..5735c0448b4c 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -290,7 +290,8 @@ int nfs_do_submount(struct fs_context *fc)
 		nfs_errorf(fc, "NFS: Couldn't determine submount pathname");
 		ret = PTR_ERR(p);
 	} else {
-		ret = vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
+		ret = vfs_parse_fs_qstr(fc, "source",
+					&QSTR_LEN(p, buffer + 4096 - p));
 		if (!ret)
 			ret = vfs_get_tree(fc);
 	}
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 072383899e81..306b76e97783 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -773,16 +773,14 @@ static int smb3_fs_context_parse_monolithic(struct fs_context *fc,
 		}
 
 
-		len = 0;
 		value = strchr(key, '=');
 		if (value) {
 			if (value == key)
 				continue;
 			*value++ = 0;
-			len = strlen(value);
 		}
 
-		ret = vfs_parse_fs_string(fc, key, value, len);
+		ret = vfs_parse_fs_string(fc, key, value);
 		if (ret < 0)
 			break;
 	}
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7773eb870039..97b514a79a49 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -134,8 +134,13 @@ extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_ty
 
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
-extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
-			       const char *value, size_t v_size);
+extern int vfs_parse_fs_qstr(struct fs_context *fc, const char *key,
+				const struct qstr *value);
+static inline int vfs_parse_fs_string(struct fs_context *fc, const char *key,
+			       const char *value)
+{
+	return vfs_parse_fs_qstr(fc, key, value ? &QSTR(value) : NULL);
+}
 int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
 			     char *(*sep)(char **));
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..15375b45fd74 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10201,8 +10201,7 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 
 	pr_warn("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030\n");
 
-	ret = vfs_parse_fs_string(fc, "source",
-				  "tracefs", strlen("tracefs"));
+	ret = vfs_parse_fs_string(fc, "source", "tracefs");
 	if (!ret)
 		mnt = fc_mount(fc);
 	else
-- 
2.47.2


