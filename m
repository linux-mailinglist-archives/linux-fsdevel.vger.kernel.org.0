Return-Path: <linux-fsdevel+bounces-75013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPj+JigGcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:12:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E765C88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48A9F6A9021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9B40B6EF;
	Thu, 22 Jan 2026 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGxb0MSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62461365A0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078946; cv=none; b=EDYgB/74fDoYCBq8S/sPyR1OJyxnVTpP5ekzYaJn52MCc8tnCRxdJEJuN3GRvDa0WgH+d5UTbRE00BlCNDAYWmzyYLQOF/RT5jO3gLkMgiqhCk7hxpBFN0BAZZ5XILx0ISQtF2aYt5YQo5HxPv+8HAHqBRZq8R02Mzehn9ZHleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078946; c=relaxed/simple;
	bh=X7fUStBnFskvjkIHsMTbQ7tDdjZhXDSD2JFr93EDy44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejBEaO41wW+8jTacw3umuOAcrqo5+QAQh0bKIUgPwG9t8THb2SyxPg+tczo3rNU+zaAla6eqSqfNYOV1MbL0fdATnN+nKgofvxi/CM/I2U+GHjs9UnvIVQ8M1JU/t4Jdwbyy8lGXP5Qt4XyQm2Sswa2Vv7wa3lZio1Lxtgy7onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGxb0MSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3417EC116C6;
	Thu, 22 Jan 2026 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078943;
	bh=X7fUStBnFskvjkIHsMTbQ7tDdjZhXDSD2JFr93EDy44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gGxb0MSdMz/6D8M0IVzosGS9QGiUj88s+/kX6TIlcUkSprbMCNcK7WTOn6nGWGSkN
	 AycUCNIMCLPHRnk6AArptOCyiBvIRn428Tq7vgNI6kGAFoVHqrZQARVtJyBVtjPamA
	 MRI4Et2dUGALmqyiUf7KF6mlgI9OcuFdLTtyAW1m/rET9LMXzqpjS43knQkGZF6qJP
	 dxhkNVvAWBZIJMUklfAgwehwua/zjarBD5pimcAC5f3O0S6T69uRYDJHhlYcnI4v2C
	 LUmy3cJuxsbiNg2j1QzRPuAsePj5sfKCJQ/pWmCWSVYjvxoPb0/hxBdS3Bse7GiIRE
	 UPFWXg+rcXAYA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Jan 2026 11:48:47 +0100
Subject: [PATCH 2/7] mount: simplify __do_loopback()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-work-fsmount-namespace-v1-2-5ef0a886e646@kernel.org>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
In-Reply-To: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4268; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X7fUStBnFskvjkIHsMTbQ7tDdjZhXDSD2JFr93EDy44=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMcw4aPymJLiIJ+n31wNF+lbhn7+9bNGdLxJ0X0i1u
 6fz55W6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8aWJk2BLEN/dmyaTSS2bl
 TRz1kW1fyhZukxe7LpTAW/Am+i93KyNDC8OmU/kXvy19+DLbXcRg5/kc2913HngUas6wLbb09dZ
 lAAA=
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
	TAGGED_FROM(0.00)[bounces-75013-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 895E765C88
X-Rspamd-Action: no action

Remove the OPEN_TREE_NAMESPACE flag checking from __do_loopback() and
instead have callers pass CL_COPY_MNT_NS_FILE directly in copy_flags.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 695ea0c37a7b..46d2eb1c9c3d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2950,10 +2950,9 @@ static inline bool may_copy_tree(const struct path *path)
 }
 
 static struct mount *__do_loopback(const struct path *old_path,
-				   unsigned int flags, unsigned int copy_flags)
+				   bool recurse, unsigned int copy_flags)
 {
 	struct mount *old = real_mount(old_path->mnt);
-	bool recurse = flags & AT_RECURSIVE;
 
 	if (IS_MNT_UNBINDABLE(old))
 		return ERR_PTR(-EINVAL);
@@ -2964,18 +2963,6 @@ static struct mount *__do_loopback(const struct path *old_path,
 	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return ERR_PTR(-EINVAL);
 
-	/*
-	 * When creating a new mount namespace we don't want to copy over
-	 * mounts of mount namespaces to avoid the risk of cycles and also to
-	 * minimize the default complex interdependencies between mount
-	 * namespaces.
-	 *
-	 * We could ofc just check whether all mount namespace files aren't
-	 * creating cycles but really let's keep this simple.
-	 */
-	if (!(flags & OPEN_TREE_NAMESPACE))
-		copy_flags |= CL_COPY_MNT_NS_FILE;
-
 	if (recurse)
 		return copy_tree(old, old_path->dentry, copy_flags);
 
@@ -2990,7 +2977,6 @@ static int do_loopback(const struct path *path, const char *old_name,
 {
 	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL;
-	unsigned int flags = recurse ? AT_RECURSIVE : 0;
 	int err;
 
 	if (!old_name || !*old_name)
@@ -3009,7 +2995,7 @@ static int do_loopback(const struct path *path, const char *old_name,
 	if (!check_mnt(mp.parent))
 		return -EINVAL;
 
-	mnt = __do_loopback(&old_path, flags, 0);
+	mnt = __do_loopback(&old_path, recurse, CL_COPY_MNT_NS_FILE);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
@@ -3047,7 +3033,7 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, unsigned
 			ns->seq_origin = src_mnt_ns->ns.ns_id;
 	}
 
-	mnt = __do_loopback(path, flags, 0);
+	mnt = __do_loopback(path, (flags & AT_RECURSIVE), CL_COPY_MNT_NS_FILE);
 	if (IS_ERR(mnt)) {
 		emptied_ns = ns;
 		return ERR_CAST(mnt);
@@ -3082,7 +3068,8 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 DEFINE_FREE(put_empty_mnt_ns, struct mnt_namespace *,
 	    if (!IS_ERR_OR_NULL(_T)) free_mnt_ns(_T))
 
-static struct mnt_namespace *create_new_namespace(struct path *path, unsigned int flags)
+static struct mnt_namespace *create_new_namespace(struct path *path,
+						  bool recurse)
 {
 	struct mnt_namespace *new_ns __free(put_empty_mnt_ns) = NULL;
 	struct path to_path __free(path_put) = {};
@@ -3140,7 +3127,7 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 	 * restrictions of creating detached bind-mounts. It has a lot
 	 * saner and simpler semantics.
 	 */
-	mnt = __do_loopback(path, flags, copy_flags);
+	mnt = __do_loopback(path, recurse, copy_flags);
 	if (IS_ERR(mnt))
 		return ERR_CAST(mnt);
 
@@ -3167,11 +3154,11 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 	return no_free_ptr(new_ns);
 }
 
-static struct file *open_new_namespace(struct path *path, unsigned int flags)
+static struct file *open_new_namespace(struct path *path, bool recurse)
 {
 	struct mnt_namespace *new_ns;
 
-	new_ns = create_new_namespace(path, flags);
+	new_ns = create_new_namespace(path, recurse);
 	if (IS_ERR(new_ns))
 		return ERR_CAST(new_ns);
 	return open_namespace_file(to_ns_common(new_ns));
@@ -3221,7 +3208,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 		return ERR_PTR(ret);
 
 	if (flags & OPEN_TREE_NAMESPACE)
-		return open_new_namespace(&path, flags);
+		return open_new_namespace(&path, (flags & AT_RECURSIVE));
 
 	if (flags & OPEN_TREE_CLONE)
 		return open_detached_copy(&path, flags);

-- 
2.47.3


