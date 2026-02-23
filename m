Return-Path: <linux-fsdevel+bounces-78042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMzHHLHdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:07:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55117ED62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BDA53031239
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2437E2E7;
	Mon, 23 Feb 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPh+oZbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501334EF0F;
	Mon, 23 Feb 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888042; cv=none; b=Zjc91ag9jjJb31ZZzxckgNVyWfdptX4oqxhJhFt+J3U0gtu/5YbQp58+d8dbn5xBooE9Quya5qP+OaZ2KDPDZYLX7hzkewm9oYQ5ho/RWwb9KghTibVT48o+ubqW2KzR81EXOKO+3k8ZyvxVM7Eq4GqQgCbiMHJFp+noYqrLYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888042; c=relaxed/simple;
	bh=84CwJjraj0D5cE9KR1IloUjtmsUwajesRfj5LRkrAIc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar/ZYaWMFq53T/oWY+zgRG2OEFZ40ujzl95oe78hH1yF+hko1pLTxpPrV/ug7MJBVixKdroqCT82SYD+KJJuExNlSUPw2epS+ZNgG7aT8ZYNZHF37McHh2NeNdijMtHNUUU9l1fcnS2pt9MCcx7xw/DdsIctnFtWIMFYO2gx/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPh+oZbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80361C116C6;
	Mon, 23 Feb 2026 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888042;
	bh=84CwJjraj0D5cE9KR1IloUjtmsUwajesRfj5LRkrAIc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZPh+oZbZy71QTuZAWWkd1NTY7us5rW+9aOf0Pg9DNucxY35aVLZ55ZRHgtPKxsskz
	 d1bJUbudM4K7D943t8BMLxvUnpyK6XHcOmzdB01SyzqqZijNvde5jyvyEXI5EsqrN9
	 8m0RzZ5HOJbzIhZchnm/yzmKrq9vNWfYFd1pY+4ams/PffniZke/QhhltwDCNSaNn1
	 Nnp7RYQhla3vh4T2lmVj94+QJh4se9gKxh0bqcpGKS8Vo2rft2ar/jmWOAAUtWFrf+
	 qIWygZ/VahbENVIoM92eN6EMpo7GhVhRgohj03oG6pL9GLDgdA/pPb5Kik5lqOMx01
	 jZnGsugvEK/yQ==
Date: Mon, 23 Feb 2026 15:07:22 -0800
Subject: [PATCH 4/5] fuse: update file mode when updating acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188733196.3935219.3172887920210313838.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78042-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B55117ED62
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

If someone sets ACLs on a file that can be expressed fully as Unix DAC
mode bits, most local filesystems will then update the mode bits and
drop the ACL xattr to reduce inefficiency in the file access paths.
Let's do that too.  Note that means that we can setacl and end up with
no ACL xattrs, so we also need to tolerate ENODATA returns from
fuse_removexattr.

Note that here we define a "local" fuse filesystem as one that uses
fuseblk mode; we'll shortly add fuse servers that use iomap for the file
IO path to that list.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 +-
 fs/fuse/acl.c    |   43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 79793db3e9a743..a1880599455c0a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1051,7 +1051,7 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
 	return get_fuse_mount_super(inode->i_sb);
 }
 
-static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
+static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index cbde6ac1add35a..f2b959efd67490 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -11,6 +11,18 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 
+/*
+ * If this fuse server behaves like a local filesystem, we can implement the
+ * kernel's optimizations for ACLs for local filesystems instead of passing
+ * the ACL requests straight through to another server.
+ */
+static inline bool fuse_inode_has_local_acls(const struct inode *inode)
+{
+	const struct fuse_conn *fc = get_fuse_conn(inode);
+
+	return fc->posix_acl && fuse_inode_is_exclusive(inode);
+}
+
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
 					struct inode *inode, int type, bool rcu)
 {
@@ -98,6 +110,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -113,6 +126,18 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		return -EINVAL;
 
+	/*
+	 * If the ACL can be represented entirely with changes to the mode
+	 * bits, then most filesystems will update the mode bits and delete
+	 * the ACL xattr.
+	 */
+	if (acl && type == ACL_TYPE_ACCESS &&
+	    fuse_inode_has_local_acls(inode)) {
+		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (ret)
+			return ret;
+	}
+
 	if (acl) {
 		unsigned int extra_flags = 0;
 		/*
@@ -139,7 +164,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * through POSIX ACLs. Such daemons don't expect setgid bits to
 		 * be stripped.
 		 */
-		if (fc->posix_acl &&
+		if (fc->posix_acl && mode == inode->i_mode &&
 		    !in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
@@ -148,6 +173,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
+		/* If the acl didn't exist to start with that's fine. */
+		if (ret == -ENODATA)
+			ret = 0;
+	}
+
+	/* If we scheduled a mode update above, push that to userspace now. */
+	if (!ret) {
+		struct iattr attr = { };
+
+		if (mode != inode->i_mode) {
+			attr.ia_valid |= ATTR_MODE;
+			attr.ia_mode = mode;
+		}
+
+		if (attr.ia_valid)
+			ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
 	}
 
 	if (fc->posix_acl) {


