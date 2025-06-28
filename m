Return-Path: <linux-fsdevel+bounces-53222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBDEAEC8C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651A61BC0885
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30D24C67A;
	Sat, 28 Jun 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AevlfoLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC17A305
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128111; cv=none; b=thxarWMIsKL9RQNbfaPhs4GyScOi38FIQZw6Xn7ZGkX/pvfvKLE8cBB80TtAxiNprN+kcN1pyq/IJdY+XoMWmiYWpagbrrQJclD5Sm711AeeELOzCMy1tqsYYNQNH3G6sxLv70xAkEHGYJqoP3L34CCyrrzfqs2w73Ffjt1pYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128111; c=relaxed/simple;
	bh=xWk0RmuPLJuBRxdv8qjMsmXnKxm5LcgIYjIVwcTtaC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdgiCSHSgkVc57FtBnST+djUx0RkBw3Ci+WXclOUXa5N0C67PH3yMrglb6+sQXjgKZLHVhAHoJFC7VdjI98QaWh7QF7CvbVwSDLUaDP7tmwbCRhtyRLQ5f9pfc4yejcWnbh1DwSzunZQL7nle+1lpeTpGP+2s3tMwdlX6TbFMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AevlfoLq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u6UHpG6qvES/e5vQim/cLwryjnjjsMb0b9OrTuWwL8E=; b=AevlfoLqsL5QcsXOfpDlyCduw6
	+Rsf7AHesTBUGZfCiMsytReLCA/LPTmMgbL7QPbujNcTDejCsCUBT1hgyRCzhzLk8WmWpw6YAfFHJ
	3Yhqax8sxCfYN++c/MM+28KbmQGG6PSM1RsJis6jm9dtoAlULPFvNVhXgQvcfELdv9j472aChAYP7
	xLvEZ9fqj9REZgiVVLlyK18M+rU9LmV/nGk23w7CoJVM4/e87oaXp9pnvbvLNDygZCEBkDHwQ9hbF
	tQnPUgJ/MWfchO33tPpUWWp4TKxJlsdDT55dY5fNtGZEhXxr2mN8yinCDMRxJyEZL7i/YjVKQTayL
	a3hP0wbg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVYPh-0000000HLwp-1tYe;
	Sat, 28 Jun 2025 16:28:25 +0000
Date: Sat, 28 Jun 2025 17:28:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	ebiederm@xmission.com, jack@suse.cz,
	David Howells <dhowells@redhat.com>
Subject: Re: [RFC] vfs_parse_fs_string() calling conventions change (was Re:
 [PATCH v2 17/35] sanitize handling of long-term internal mounts)
Message-ID: <20250628162825.GW1880847@ZenIV>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
 <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
 <20250623170314.GG1880847@ZenIV>
 <20250628075849.GA1959766@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628075849.GA1959766@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jun 28, 2025 at 08:58:49AM +0100, Al Viro wrote:
> Yes, it's a flagday change.  Compiler will immediately catch any place
> that needs to be converted, and D/f/porting.rst part should be clear
> enough.
> 
> How about something like the following (completely untested), on top of -rc3?
> Objections, anyone?
 
After fixing a braino (s/QSTR_INIT/QSTR_LEN/) it even builds and seems to work...

[PATCH] change the calling conventions for vfs_parse_fs_string()

Absolute majority of callers are passing the 4th argument equal to
strlen() of the 3rd one.

Drop the v_size argument, add vfs_parse_fs_qstr() for the cases that
want independent length.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
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
index 3616d7161dab..6ed66ed90eb6 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1249,3 +1249,13 @@ Using try_lookup_noperm() will require linux/namei.h to be included.
 
 Calling conventions for ->d_automount() have changed; we should *not* grab
 an extra reference to new mount - it should be returned with refcount 1.
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
index e13d9ab4f564..c5cc8406d24c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1312,8 +1312,7 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 		return ERR_CAST(fc);
 
 	if (name)
-		ret = vfs_parse_fs_string(fc, "source",
-					  name, strlen(name));
+		ret = vfs_parse_fs_string(fc, "source", name);
 	if (!ret)
 		ret = parse_monolithic_mount_data(fc, data);
 	if (!ret)
@@ -3873,10 +3872,9 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
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
index 13f71ca8c974..de1ecb10831b 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1227,8 +1227,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
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
index a634a34d4086..e750906c9c49 100644
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
index a19e4bd32e4d..a735ed23dd9f 100644
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
index 95ae7c4e5835..77ff2608118b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10277,8 +10277,7 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
-	ret = vfs_parse_fs_string(fc, "source",
-				  "tracefs", strlen("tracefs"));
+	ret = vfs_parse_fs_string(fc, "source", "tracefs");
 	if (!ret)
 		mnt = fc_mount(fc);
 	else

