Return-Path: <linux-fsdevel+bounces-77285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJRjMxkdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:35:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B29143DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0872430117E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E053312834;
	Mon, 16 Feb 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7ZNZED1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F030F934;
	Mon, 16 Feb 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248775; cv=none; b=eQVuKAJEq70pXr4odPFOw43ITkHGW57e9BoAnE0QJXn2ie7+qrIyyDNGdjZD0lXftWQxCz7BnIEQnNdwM7OAj3YRHqZSySgEBdQMjdMZSd5TKlfxPzVPC7O/VD0l3hVIdJPIw21eqUf/a3YPCXbddOtS8YgrZOY0WFCVJXf/ErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248775; c=relaxed/simple;
	bh=og9OzjKrpi8J5E7G7hJ+vPxRQ2I1HIq12Wata8xWsm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IasE0YcJcFTR3aHQzHRCb3WhHyT738+Jz3JAL0fVHYC4vn4Rnaies6Lr6q8Z+EdYP23Izrn23dZWYkhSGH0a8RciamDCYqvm+PNRCgQTlGqgIZLbRfEoqq87KxWspTuMdBdV0i8To63Bx/uhCDG5M10zAtdPnpKceKmVMsG8jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7ZNZED1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F6C116C6;
	Mon, 16 Feb 2026 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248775;
	bh=og9OzjKrpi8J5E7G7hJ+vPxRQ2I1HIq12Wata8xWsm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D7ZNZED1zVSUgXHnknRdsN5fnqrXmOkp67JAmSwDSe+PK8bQFgt96/kDlQo6vPy+e
	 BtM+EBnrBA2O/wQT8jZWiwz0THc1m2jdshzViEFjOlNKWXKETkMPfJYUVAY/oKuMi/
	 YRcDj4uqfAisaXLvE2ZqQlmwx2Fl+UuQVZDRR3Q4A+zR0QqncNqtkl1HIUTW8eId3W
	 yG9hHZEZmservuk4/LjGzCfDRM3RUAxC0jqiXoa9nmmHcS4DFx3hpqMZNDPEvzwBwG
	 Xa3Y+eqrTklaWmhpza74vXKPcQ5ZuOpqpn8xVQ2kSwWVwU70MpzjPsF/vmJ982xeN9
	 Kg/3z4Ayz35Xg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:06 +0100
Subject: [PATCH 10/14] xattr,net: support limited amount of extended
 attributes on sockfs sockets
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-10-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5847; i=brauner@kernel.org;
 h=from:subject:message-id; bh=og9OzjKrpi8J5E7G7hJ+vPxRQ2I1HIq12Wata8xWsm0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlomz2jXPdLuwPOdjplbdwIYlMzUXVL7iWrP81ndR0
 7p3z7RcOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyfyMjw+4fXYaf2bsnPbg7
 c/LP93saJ1y3nx97u7Of58fyldsl/AUZ/tnnXFZP07TV1dp5duaDLW6FUl8e2m9x/W+8nduoa31
 nBB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77285-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73B29143DCB
X-Rspamd-Action: no action

Now that we've generalized the infrastructure for user.* xattrs make it
possible to set up to 128 user.* extended attributes on a sockfs inode
or up to 128kib. kernfs (cgroupfs) has the same limits and it has proven
to be quite sufficient for nearly all use-cases.

This will allow containers to label sockets and will e.g., be used by
systemd and Gnome to find various sockets in containers where
high-privilege or more complicated solutions aren't available.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/socket.c | 119 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 27 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 136b98c54fb3..7aa94fce7a8b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -315,45 +315,70 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 
 static struct kmem_cache *sock_inode_cachep __ro_after_init;
 
+struct sockfs_inode {
+	struct simple_xattrs *xattrs;
+	struct simple_xattr_limits xattr_limits;
+	struct socket_alloc;
+};
+
+static struct sockfs_inode *SOCKFS_I(struct inode *inode)
+{
+	return container_of(inode, struct sockfs_inode, vfs_inode);
+}
+
 static struct inode *sock_alloc_inode(struct super_block *sb)
 {
-	struct socket_alloc *ei;
+	struct sockfs_inode *si;
 
-	ei = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
-	if (!ei)
+	si = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
+	if (!si)
 		return NULL;
-	init_waitqueue_head(&ei->socket.wq.wait);
-	ei->socket.wq.fasync_list = NULL;
-	ei->socket.wq.flags = 0;
+	si->xattrs = NULL;
+	simple_xattr_limits_init(&si->xattr_limits);
+
+	init_waitqueue_head(&si->socket.wq.wait);
+	si->socket.wq.fasync_list = NULL;
+	si->socket.wq.flags = 0;
+
+	si->socket.state = SS_UNCONNECTED;
+	si->socket.flags = 0;
+	si->socket.ops = NULL;
+	si->socket.sk = NULL;
+	si->socket.file = NULL;
 
-	ei->socket.state = SS_UNCONNECTED;
-	ei->socket.flags = 0;
-	ei->socket.ops = NULL;
-	ei->socket.sk = NULL;
-	ei->socket.file = NULL;
+	return &si->vfs_inode;
+}
+
+static void sock_evict_inode(struct inode *inode)
+{
+	struct sockfs_inode *si = SOCKFS_I(inode);
+	struct simple_xattrs *xattrs = si->xattrs;
 
-	return &ei->vfs_inode;
+	if (xattrs) {
+		simple_xattrs_free(xattrs, NULL);
+		kfree(xattrs);
+	}
+	clear_inode(inode);
 }
 
 static void sock_free_inode(struct inode *inode)
 {
-	struct socket_alloc *ei;
+	struct sockfs_inode *si = SOCKFS_I(inode);
 
-	ei = container_of(inode, struct socket_alloc, vfs_inode);
-	kmem_cache_free(sock_inode_cachep, ei);
+	kmem_cache_free(sock_inode_cachep, si);
 }
 
 static void init_once(void *foo)
 {
-	struct socket_alloc *ei = (struct socket_alloc *)foo;
+	struct sockfs_inode *si = (struct sockfs_inode *)foo;
 
-	inode_init_once(&ei->vfs_inode);
+	inode_init_once(&si->vfs_inode);
 }
 
 static void init_inodecache(void)
 {
 	sock_inode_cachep = kmem_cache_create("sock_inode_cache",
-					      sizeof(struct socket_alloc),
+					      sizeof(struct sockfs_inode),
 					      0,
 					      (SLAB_HWCACHE_ALIGN |
 					       SLAB_RECLAIM_ACCOUNT |
@@ -365,6 +390,7 @@ static void init_inodecache(void)
 static const struct super_operations sockfs_ops = {
 	.alloc_inode	= sock_alloc_inode,
 	.free_inode	= sock_free_inode,
+	.evict_inode	= sock_evict_inode,
 	.statfs		= simple_statfs,
 };
 
@@ -417,9 +443,48 @@ static const struct xattr_handler sockfs_security_xattr_handler = {
 	.set = sockfs_security_xattr_set,
 };
 
+static int sockfs_user_xattr_get(const struct xattr_handler *handler,
+				 struct dentry *dentry, struct inode *inode,
+				 const char *suffix, void *value, size_t size)
+{
+	const char *name = xattr_full_name(handler, suffix);
+	struct simple_xattrs *xattrs;
+
+	xattrs = READ_ONCE(SOCKFS_I(inode)->xattrs);
+	if (!xattrs)
+		return -ENODATA;
+
+	return simple_xattr_get(xattrs, name, value, size);
+}
+
+static int sockfs_user_xattr_set(const struct xattr_handler *handler,
+				 struct mnt_idmap *idmap,
+				 struct dentry *dentry, struct inode *inode,
+				 const char *suffix, const void *value,
+				 size_t size, int flags)
+{
+	const char *name = xattr_full_name(handler, suffix);
+	struct sockfs_inode *si = SOCKFS_I(inode);
+	struct simple_xattrs *xattrs;
+
+	xattrs = simple_xattrs_lazy_alloc(&si->xattrs, value, flags);
+	if (IS_ERR_OR_NULL(xattrs))
+		return PTR_ERR(xattrs);
+
+	return simple_xattr_set_limited(xattrs, &si->xattr_limits,
+					name, value, size, flags);
+}
+
+static const struct xattr_handler sockfs_user_xattr_handler = {
+	.prefix = XATTR_USER_PREFIX,
+	.get = sockfs_user_xattr_get,
+	.set = sockfs_user_xattr_set,
+};
+
 static const struct xattr_handler * const sockfs_xattr_handlers[] = {
 	&sockfs_xattr_handler,
 	&sockfs_security_xattr_handler,
+	&sockfs_user_xattr_handler,
 	NULL
 };
 
@@ -572,26 +637,26 @@ EXPORT_SYMBOL(sockfd_lookup);
 static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 				size_t size)
 {
-	ssize_t len;
-	ssize_t used = 0;
+	struct sockfs_inode *si = SOCKFS_I(d_inode(dentry));
+	ssize_t len, used;
 
-	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
+	len = simple_xattr_list(d_inode(dentry), READ_ONCE(si->xattrs),
+				buffer, size);
 	if (len < 0)
 		return len;
-	used += len;
+
+	used = len;
 	if (buffer) {
-		if (size < used)
-			return -ERANGE;
 		buffer += len;
+		size -= len;
 	}
 
-	len = (XATTR_NAME_SOCKPROTONAME_LEN + 1);
+	len = XATTR_NAME_SOCKPROTONAME_LEN + 1;
 	used += len;
 	if (buffer) {
-		if (size < used)
+		if (size < len)
 			return -ERANGE;
 		memcpy(buffer, XATTR_NAME_SOCKPROTONAME, len);
-		buffer += len;
 	}
 
 	return used;

-- 
2.47.3


