Return-Path: <linux-fsdevel+bounces-77278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MsCLZ8ck2m11gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:33:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46A143D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2C963012BE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86330F549;
	Mon, 16 Feb 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPG/x2PO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DA30EF97;
	Mon, 16 Feb 2026 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248750; cv=none; b=jaJ4zDw9YgiXGVLXZVL9HvLmdF7oIeKMvj4emvWKX5oIIDfoVfgtIcQxc+bDR7gQwx3Vq4yrS0fGw2VhY0ZONfPurq1CuKmPYH4LEVLAc+0WZiQ7Pz+s6r6AUyicYKoPf8Fy5nAkpoaoMxpo0K+vdeJP22a3tc6MZQzcr7ND1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248750; c=relaxed/simple;
	bh=m6olJ1Aiin2fbb8rm99iZWNuSO99GG/M+f4atiTlDsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyLnELF3uefAKbMbgu+2bFWGzB7tzI44fc3wm+8Mf6lITnOEyWhUUuy9wx3muEFOvMRjow1rZGon/67TkdSVOPlJNbLBH+1GJukQuT/90m88lefq4LfWY2nqPdSgn25V6gQqWgIEg9eF85qhEgarvqjSy3rUHM6/Vd1//QA1g1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPG/x2PO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EFEC2BC9E;
	Mon, 16 Feb 2026 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248749;
	bh=m6olJ1Aiin2fbb8rm99iZWNuSO99GG/M+f4atiTlDsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gPG/x2POnmd4b06vljpEiGw7e59h+pYTmb9s4b5qFyux5J9m4JQtKlmZKVsLLw+gg
	 Tt4nDAlCxEFQLmOaF5g+7xFDRotxNrma1plzKXtrMlfVJA4MKdWdHc9Cx2lZyWDUwc
	 4mDnwpPXF27lZ0RaX160QgrHS5ccJY8U3gh25nWDXtOS2PoAZxFR3JPWChdOon0yn2
	 dkJ6LPPEpOGd5Nywf6PmsHqNTogFPNDaIVZ2AqUufHRNru3uNtEYJeqIMvi9NAHPj9
	 mYfu9qzicHzMWQ593fE1sCWOOt5Fjk36jfvUPHQaGTWLcxblguHqOMjiJJfVN/997n
	 DTUmOtAy7mYrg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:31:59 +0100
Subject: [PATCH 03/14] shmem: adapt to rhashtable-based simple_xattrs with
 lazy allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-3-c2efa4f74cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8768; i=brauner@kernel.org;
 h=from:subject:message-id; bh=m6olJ1Aiin2fbb8rm99iZWNuSO99GG/M+f4atiTlDsM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlolTFd/15cyltedzn5S1P/9iPSX13s9zVXoTd2Q3b
 L/b8e5lUEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE4g4x/JVYvCl5aWS7+zGj
 yvajU3lqnQOtH0+cbXIq2tSQ88Bm3nWMDN/k4vSdlk9uWZp1Lyfz9YYTN3bLdIbbMc/57H2wRK/
 nBiMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77278-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C46A143D5D
X-Rspamd-Action: no action

Adapt tmpfs/shmem to use the rhashtable-based xattr path and switch
from an embedded struct to pointer-based lazy allocation.

Change shmem_inode_info.xattrs from embedded 'struct simple_xattrs' to
a pointer 'struct simple_xattrs *', initialized to NULL. This avoids
the rhashtable overhead for every tmpfs inode, which helps when a lot of
inodes exist.

The xattr store is allocated on first use:

- shmem_initxattrs(): Allocates via simple_xattrs_alloc() when
  security modules set initial xattrs during inode creation.

- shmem_xattr_handler_set(): Allocates on first setxattr, with a
  short-circuit for removal when no xattrs are stored yet.

All read paths (shmem_xattr_handler_get, shmem_listxattr) check for
NULL xattrs pointer and return -ENODATA or 0 respectively.

Replaced xattr entries are freed via simple_xattr_free_rcu() to allow
concurrent RCU readers to finish.

shmem_evict_inode() conditionally frees the xattr store only when
allocated.

Also change simple_xattr_add() from void to int to propagate
rhashtable insertion failures. shmem_initxattrs() is the only caller.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c               | 26 +++++++++++++-------------
 include/linux/shmem_fs.h |  2 +-
 include/linux/xattr.h    |  4 ++--
 mm/shmem.c               | 44 +++++++++++++++++++++++++++++++-------------
 4 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 1d98ea459b7b..eb45ae0fd17f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1677,19 +1677,19 @@ static bool rbtree_simple_xattr_less(struct rb_node *new_node,
  * of matching xattrs is wanted. Should only be called during inode
  * initialization when a few distinct initial xattrs are supposed to be set.
  */
-void simple_xattr_add(struct simple_xattrs *xattrs,
-		      struct simple_xattr *new_xattr)
-{
-	if (xattrs->use_rhashtable) {
-		WARN_ON(rhashtable_insert_fast(&xattrs->ht,
-					       &new_xattr->hash_node,
-					       simple_xattr_params));
-	} else {
-		write_lock(&xattrs->lock);
-		rb_add(&new_xattr->rb_node, &xattrs->rb_root,
-		       rbtree_simple_xattr_less);
-		write_unlock(&xattrs->lock);
-	}
+int simple_xattr_add(struct simple_xattrs *xattrs,
+		     struct simple_xattr *new_xattr)
+{
+	if (xattrs->use_rhashtable)
+		return rhashtable_insert_fast(&xattrs->ht,
+					      &new_xattr->hash_node,
+					      simple_xattr_params);
+
+	write_lock(&xattrs->lock);
+	rb_add(&new_xattr->rb_node, &xattrs->rb_root,
+	       rbtree_simple_xattr_less);
+	write_unlock(&xattrs->lock);
+	return 0;
 }
 
 /**
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e2069b3179c4..53d325409a8b 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -48,7 +48,7 @@ struct shmem_inode_info {
 	};
 	struct timespec64	i_crtime;	/* file creation time */
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
-	struct simple_xattrs	xattrs;		/* list of xattrs */
+	struct simple_xattrs	*xattrs;	/* list of xattrs */
 	pgoff_t			fallocend;	/* highest fallocate endindex */
 	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
 	atomic_t		stop_eviction;	/* hold when working on inode */
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index ee4fd40717a0..3063ecf0004d 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -142,8 +142,8 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
 				      size_t size, int flags);
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size);
-void simple_xattr_add(struct simple_xattrs *xattrs,
-		      struct simple_xattr *new_xattr);
+int simple_xattr_add(struct simple_xattrs *xattrs,
+		     struct simple_xattr *new_xattr);
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
 
 DEFINE_CLASS(simple_xattr,
diff --git a/mm/shmem.c b/mm/shmem.c
index fc8020ce2e9f..8761c9b4f1c5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1426,7 +1426,10 @@ static void shmem_evict_inode(struct inode *inode)
 		}
 	}
 
-	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
+	if (info->xattrs) {
+		simple_xattrs_free(info->xattrs, sbinfo->max_inodes ? &freed : NULL);
+		kfree(info->xattrs);
+	}
 	shmem_free_inode(inode->i_sb, freed);
 	WARN_ON(inode->i_blocks);
 	clear_inode(inode);
@@ -3118,7 +3121,6 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
 	INIT_LIST_HEAD(&info->swaplist);
-	simple_xattrs_init(&info->xattrs);
 	cache_no_acl(inode);
 	if (sbinfo->noswap)
 		mapping_set_unevictable(inode->i_mapping);
@@ -4270,10 +4272,13 @@ static int shmem_initxattrs(struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	const struct xattr *xattr;
-	struct simple_xattr *new_xattr;
 	size_t ispace = 0;
 	size_t len;
 
+	CLASS(simple_xattrs, xattrs)();
+	if (IS_ERR(xattrs))
+		return PTR_ERR(xattrs);
+
 	if (sbinfo->max_inodes) {
 		for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 			ispace += simple_xattr_space(xattr->name,
@@ -4292,24 +4297,24 @@ static int shmem_initxattrs(struct inode *inode,
 	}
 
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
-		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
+		CLASS(simple_xattr, new_xattr)(xattr->value, xattr->value_len);
 		if (IS_ERR(new_xattr))
 			break;
 
 		len = strlen(xattr->name) + 1;
 		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
 					  GFP_KERNEL_ACCOUNT);
-		if (!new_xattr->name) {
-			kvfree(new_xattr);
+		if (!new_xattr->name)
 			break;
-		}
 
 		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
 		       XATTR_SECURITY_PREFIX_LEN);
 		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
 		       xattr->name, len);
 
-		simple_xattr_add(&info->xattrs, new_xattr);
+		if (simple_xattr_add(xattrs, new_xattr))
+			break;
+		retain_and_null_ptr(new_xattr);
 	}
 
 	if (xattr->name != NULL) {
@@ -4318,10 +4323,10 @@ static int shmem_initxattrs(struct inode *inode,
 			sbinfo->free_ispace += ispace;
 			raw_spin_unlock(&sbinfo->stat_lock);
 		}
-		simple_xattrs_free(&info->xattrs, NULL);
 		return -ENOMEM;
 	}
 
+	smp_store_release(&info->xattrs, no_free_ptr(xattrs));
 	return 0;
 }
 
@@ -4330,9 +4335,14 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 				   const char *name, void *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct simple_xattrs *xattrs;
+
+	xattrs = READ_ONCE(info->xattrs);
+	if (!xattrs)
+		return -ENODATA;
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_get(&info->xattrs, name, buffer, size);
+	return simple_xattr_get(xattrs, name, buffer, size);
 }
 
 static int shmem_xattr_handler_set(const struct xattr_handler *handler,
@@ -4343,10 +4353,16 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct simple_xattrs *xattrs;
 	struct simple_xattr *old_xattr;
 	size_t ispace = 0;
 
 	name = xattr_full_name(handler, name);
+
+	xattrs = simple_xattrs_lazy_alloc(&info->xattrs, value, flags);
+	if (IS_ERR_OR_NULL(xattrs))
+		return PTR_ERR(xattrs);
+
 	if (value && sbinfo->max_inodes) {
 		ispace = simple_xattr_space(name, size);
 		raw_spin_lock(&sbinfo->stat_lock);
@@ -4359,13 +4375,13 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 			return -ENOSPC;
 	}
 
-	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
 	if (!IS_ERR(old_xattr)) {
 		ispace = 0;
 		if (old_xattr && sbinfo->max_inodes)
 			ispace = simple_xattr_space(old_xattr->name,
 						    old_xattr->size);
-		simple_xattr_free(old_xattr);
+		simple_xattr_free_rcu(old_xattr);
 		old_xattr = NULL;
 		inode_set_ctime_current(inode);
 		inode_inc_iversion(inode);
@@ -4406,7 +4422,9 @@ static const struct xattr_handler * const shmem_xattr_handlers[] = {
 static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
-	return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, size);
+
+	return simple_xattr_list(d_inode(dentry), READ_ONCE(info->xattrs),
+				 buffer, size);
 }
 #endif /* CONFIG_TMPFS_XATTR */
 

-- 
2.47.3


