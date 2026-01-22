Return-Path: <linux-fsdevel+bounces-75014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFC1EKEEcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:06:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333165B50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D283D4AAA91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A893F23CC;
	Thu, 22 Jan 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQNHYfx9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC893A35DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078948; cv=none; b=hjn1B9thPay0n80DQ8jolJI+FwutA8eXIuw4jimHezBDhKg4mS+i0eSMOiELPG5ikGmu+wGiL3GZPaol397+ticDFvo8dNPvOAuc/7GfYvHs8YAcRpf78022DmQ01TWVPhpEPfKtgYVGNadZHkgf+JVPaSqVIQAj0OaUF1v0j1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078948; c=relaxed/simple;
	bh=zH6dY7Ry9a8FoaF3H/7Gub4GL/G4Y8WJyua20frOp1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPkrrnQDpZ2iPGs7TFHLc77FG1iYbOgMiatlPluaVL9l0lazYQPAE7H4QKobfPD5pd9o0aPhtMtLukNe8WrltVYy6EcxYBkPiUzCe3gd/zaQotx0SJolnPjP6B77kIG4gno4Vv2fURNOK28eeZ8twcBUCRtKXIck+rq6uRu7A3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQNHYfx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6641BC16AAE;
	Thu, 22 Jan 2026 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078946;
	bh=zH6dY7Ry9a8FoaF3H/7Gub4GL/G4Y8WJyua20frOp1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KQNHYfx9WiwFJbDDx2che5KxF1eZIQzEFYd3JBAVxzXN016+rFZv6cj7O2tVGx8U4
	 Dwmknc6Yg+xJoWrlaTXvkAQlHrhUO49hOb5WvGOlVOXKAqZfl1O39pF7yfCNOdO9zP
	 W+DfCUQT2npVlw+YfAZFmMNWfciySOx1KB3C96toGg2EJC/iOfLw4e8phU8mfC4ywG
	 piVERW2iDGRDP7wzVY0n2uFKM3ZnCu+KHNIlBN0Pnjh8w8NlkkpMKVhNceAE6W58hg
	 h6TfFuRN+8J/SWiG3YxSLG4z0j/ojmMJu60bSoaWSigpJGrWLlnKzSc98YnvB2InbR
	 6ZL2ATja8OnAw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Jan 2026 11:48:48 +0100
Subject: [PATCH 3/7] mount: add FSMOUNT_NAMESPACE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-work-fsmount-namespace-v1-3-5ef0a886e646@kernel.org>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
In-Reply-To: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5439; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zH6dY7Ry9a8FoaF3H/7Gub4GL/G4Y8WJyua20frOp1Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMcz8HOXUVXPkREp7scP673NlFMz8Eh4GJL0p7FP/t
 iNIMje/o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLPpzMy/C5X2Cc+ufdw/0L1
 jOV/259vk9aKv2+du8vnN6/Pz3Pn+RkZXq5unhffffTE+8eRZ5x0DTpqfy60Pzll2qSWWtkFCle
 deQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,toxicpanda.com,cyphar.com];
	TAGGED_FROM(0.00)[bounces-75014-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1333165B50
X-Rspamd-Action: no action

Add FSMOUNT_NAMESPACE flag to fsmount() that creates a new mount
namespace with the newly created filesystem attached to a copy of the
real rootfs. This returns a namespace file descriptor instead of an
O_PATH mount fd, similar to how OPEN_TREE_NAMESPACE works for open_tree().

This allows creating a new filesystem and immediately placing it in a
new mount namespace in a single operation, which is useful for container
runtimes and other namespace-based isolation mechanisms.

The rootfs mount is created before copying the real rootfs for the new
namespace meaning that the mount namespace id for the mount of the root
of the namespace is bigger than the child mounted on top of it. We've
never explicitly given the guarantee for such ordering and I doubt
anyone relies on it. Accepting that lets us avoid copying the mount
again and also avoids having to massage may_copy_tree() to grant an
exception for fsmount->mnt->mnt_ns being NULL.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c             | 53 +++++++++++++++++++++++++++++++++-------------
 include/uapi/linux/mount.h |  1 +
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 46d2eb1c9c3d..30f2991b4a7f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3068,8 +3068,13 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 DEFINE_FREE(put_empty_mnt_ns, struct mnt_namespace *,
 	    if (!IS_ERR_OR_NULL(_T)) free_mnt_ns(_T))
 
+enum open_newns_flags_t {
+	OPEN_NEWNS_RECURSIVE	= BIT(0),
+	OPEN_NEWNS_CLONE	= BIT(1),
+};
+
 static struct mnt_namespace *create_new_namespace(struct path *path,
-						  bool recurse)
+						  enum open_newns_flags_t flags)
 {
 	struct mnt_namespace *new_ns __free(put_empty_mnt_ns) = NULL;
 	struct path to_path __free(path_put) = {};
@@ -3080,6 +3085,9 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	unsigned int copy_flags = 0;
 	bool locked = false;
 
+	if ((flags & (OPEN_NEWNS_RECURSIVE | OPEN_NEWNS_CLONE)) == OPEN_NEWNS_RECURSIVE)
+		return ERR_PTR(-EINVAL);
+
 	if (user_ns != ns->user_ns)
 		copy_flags |= CL_SLAVE;
 
@@ -3122,14 +3130,18 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	if (unlikely(IS_ERR(mp.parent)))
 		return ERR_CAST(mp.parent);
 
-	/*
-	 * We don't emulate unshare()ing a mount namespace. We stick to the
-	 * restrictions of creating detached bind-mounts. It has a lot
-	 * saner and simpler semantics.
-	 */
-	mnt = __do_loopback(path, recurse, copy_flags);
-	if (IS_ERR(mnt))
-		return ERR_CAST(mnt);
+	if (flags & OPEN_NEWNS_CLONE) {
+		/*
+		 * We don't emulate unshare()ing a mount namespace. We stick to
+		 * the restrictions of creating detached bind-mounts. It has a
+		 * lot saner and simpler semantics.
+		 */
+		mnt = __do_loopback(path, flags & OPEN_NEWNS_RECURSIVE, copy_flags);
+		if (IS_ERR(mnt))
+			return ERR_CAST(mnt);
+	} else {
+		mnt = real_mount(mntget(path->mnt));
+	}
 
 	scoped_guard(mount_writer) {
 		if (locked)
@@ -3154,11 +3166,12 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	return no_free_ptr(new_ns);
 }
 
-static struct file *open_new_namespace(struct path *path, bool recurse)
+static struct file *open_new_namespace(struct path *path,
+				       enum open_newns_flags_t flags)
 {
 	struct mnt_namespace *new_ns;
 
-	new_ns = create_new_namespace(path, recurse);
+	new_ns = create_new_namespace(path, flags);
 	if (IS_ERR(new_ns))
 		return ERR_CAST(new_ns);
 	return open_namespace_file(to_ns_common(new_ns));
@@ -3208,7 +3221,9 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 		return ERR_PTR(ret);
 
 	if (flags & OPEN_TREE_NAMESPACE)
-		return open_new_namespace(&path, (flags & AT_RECURSIVE));
+		return open_new_namespace(&path,
+				((flags & AT_RECURSIVE) ? OPEN_NEWNS_RECURSIVE : 0) |
+				OPEN_NEWNS_CLONE);
 
 	if (flags & OPEN_TREE_CLONE)
 		return open_detached_copy(&path, flags);
@@ -4395,11 +4410,15 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	unsigned int mnt_flags = 0;
 	long ret;
 
-	if (!may_mount())
+	if ((flags & ~(FSMOUNT_CLOEXEC | FSMOUNT_NAMESPACE)) != 0)
+		return -EINVAL;
+
+	if ((flags & FSMOUNT_NAMESPACE) &&
+	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
-		return -EINVAL;
+	if (!(flags & FSMOUNT_NAMESPACE) && !may_mount())
+		return -EPERM;
 
 	if (attr_flags & ~FSMOUNT_VALID_FLAGS)
 		return -EINVAL;
@@ -4466,6 +4485,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	 */
 	vfs_clean_context(fc);
 
+	if (flags & FSMOUNT_NAMESPACE)
+		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0,
+			      open_new_namespace(&new_path, 0));
+
 	ns = alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
 	if (IS_ERR(ns))
 		return PTR_ERR(ns);
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index d9d86598d100..2204708dbf7a 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -110,6 +110,7 @@ enum fsconfig_command {
  * fsmount() flags.
  */
 #define FSMOUNT_CLOEXEC		0x00000001
+#define FSMOUNT_NAMESPACE	0x00000002	/* Create the mount in a new mount namespace */
 
 /*
  * Mount attributes.

-- 
2.47.3


