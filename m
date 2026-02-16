Return-Path: <linux-fsdevel+bounces-77279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D/xHigdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:35:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F4143DD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 336C8302DF64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E730F951;
	Mon, 16 Feb 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0hjoQA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007230ACFF;
	Mon, 16 Feb 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248753; cv=none; b=MXwRDT8SYdtJ3PAiUfbJImPswjOQeukzgyRmduZGLjCuu+h2z0m4pMSCPvwqgVW2ANbzDQJm0nX56FrDopSpAnLE9kbMBIwfOM/CzzULg8zutArb4hmFdYSVBLHN7dNFPev+LvT6ZBbo1kYAJmy0nk/+FqXeVSIkfJRqlw7HTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248753; c=relaxed/simple;
	bh=eNwIVI0p49LTJ3RM4G3gsM8NUnzeeg8PJjJ6WiNm1Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuS+h3Ch2XQA68V1L6ej6GOZ7o0axBihbQPczI5kdtj0hiDM+yWOH9kysj5NqxOOT3CLryIl4BLVSbUGJswhlyeWYrBxOqpqs/2gs1sdP0m3qpSkOI6ONqbxSdDla9X4iX9jV25Wpt9UH6oRwYm4XMXHSWXkx7o2gvoW+Zs5xV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0hjoQA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F471C19424;
	Mon, 16 Feb 2026 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248753;
	bh=eNwIVI0p49LTJ3RM4G3gsM8NUnzeeg8PJjJ6WiNm1Tk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h0hjoQA7I9EL5Q3WT1FOglHuQxa2kzLf4syPEH/qZTg8wH09A53Jgwcmti7giUaki
	 QXx1VmTmr5eBnYaL9MhvBpqjZb40AiS7nDPgg5BclHkp5y44XH5fdwIA6Ap4lQbs6c
	 f9L+bqfmVMtJDWF6CekrukBUTU32y1AngxBMBPLqsiXgBHlcNiQTnH68JQMxl9e45m
	 P8knq8EAcjIK/ZirgcGO0n6OR8dHxAcWlifBnq9N0B0HjaOEkIldzw3EoDJ13JKaOv
	 DU22jqn3TFCFem7mXmbJIBodfNdn0U7kGu7nNshvhOyRm05I14rvLFYqaO7AR+hx1N
	 vzVRcREh1hmeA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:00 +0100
Subject: [PATCH 04/14] kernfs: adapt to rhashtable-based simple_xattrs with
 lazy allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-4-c2efa4f74cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eNwIVI0p49LTJ3RM4G3gsM8NUnzeeg8PJjJ6WiNm1Tk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlomT7ZjzLc5yvpfrvu0r/+Z/eB20Jvu+pvVEObVPl
 /l2nxQu6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIWw7Df5fidafm2ui9W37u
 9/LQxaxT1565fITzBtv7ahtDh6eb5n9jZPj2zKlncsQl+WVPD5t7Mem4ihhy3fxy8NS6V4nL+zK
 PT2UFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77279-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 259F4143DD9
X-Rspamd-Action: no action

Adapt kernfs to use the rhashtable-based xattr path and switch from an
embedded struct to pointer-based lazy allocation.

Change kernfs_iattrs.xattrs from embedded 'struct simple_xattrs' to a
pointer 'struct simple_xattrs *', initialized to NULL (zeroed by
kmem_cache_zalloc). Since kernfs_iattrs is already lazily allocated
itself, this adds a second level of lazy allocation specifically for
the xattr store.

The xattr store is allocated on first setxattr. Read paths
check for NULL and return -ENODATA or empty list.

Replaced xattr entries are freed via simple_xattr_free_rcu() to allow
concurrent RCU readers to finish.

The cleanup paths in kernfs_free_rcu() and __kernfs_new_node() error
handling conditionally free the xattr store only when allocated.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernfs/dir.c             | 15 +++++++++++----
 fs/kernfs/inode.c           | 34 +++++++++++++++++++++++++---------
 fs/kernfs/kernfs-internal.h |  2 +-
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 29baeeb97871..e5735c45fb99 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -547,10 +547,8 @@ static void kernfs_free_rcu(struct rcu_head *rcu)
 	/* If the whole node goes away, then name can't be used outside */
 	kfree_const(rcu_access_pointer(kn->name));
 
-	if (kn->iattr) {
-		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+	if (kn->iattr)
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
-	}
 
 	kmem_cache_free(kernfs_node_cache, kn);
 }
@@ -584,6 +582,12 @@ void kernfs_put(struct kernfs_node *kn)
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
 
+	if (kn->iattr && kn->iattr->xattrs) {
+		simple_xattrs_free(kn->iattr->xattrs, NULL);
+		kfree(kn->iattr->xattrs);
+		kn->iattr->xattrs = NULL;
+	}
+
 	spin_lock(&root->kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
 	spin_unlock(&root->kernfs_idr_lock);
@@ -682,7 +686,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
  err_out4:
 	if (kn->iattr) {
-		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		if (kn->iattr->xattrs) {
+			simple_xattrs_free(kn->iattr->xattrs, NULL);
+			kfree(kn->iattr->xattrs);
+		}
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
  err_out3:
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index a36aaee98dce..dfc3315b5afc 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -45,7 +45,6 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
 	ret->ia_mtime = ret->ia_atime;
 	ret->ia_ctime = ret->ia_atime;
 
-	simple_xattrs_init(&ret->xattrs);
 	atomic_set(&ret->nr_user_xattrs, 0);
 	atomic_set(&ret->user_xattr_size, 0);
 
@@ -146,7 +145,8 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
+	return simple_xattr_list(d_inode(dentry), READ_ONCE(attrs->xattrs),
+				 buf, size);
 }
 
 static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
@@ -298,27 +298,38 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
 		     void *value, size_t size)
 {
 	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
+	struct simple_xattrs *xattrs;
+
 	if (!attrs)
 		return -ENODATA;
 
-	return simple_xattr_get(&attrs->xattrs, name, value, size);
+	xattrs = READ_ONCE(attrs->xattrs);
+	if (!xattrs)
+		return -ENODATA;
+
+	return simple_xattr_get(xattrs, name, value, size);
 }
 
 int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 		     const void *value, size_t size, int flags)
 {
 	struct simple_xattr *old_xattr;
+	struct simple_xattrs *xattrs;
 	struct kernfs_iattrs *attrs;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
+	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
+	if (IS_ERR_OR_NULL(xattrs))
+		return PTR_ERR(xattrs);
+
+	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr))
 		return PTR_ERR(old_xattr);
 
-	simple_xattr_free(old_xattr);
+	simple_xattr_free_rcu(old_xattr);
 	return 0;
 }
 
@@ -376,7 +387,7 @@ static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
 
 	ret = 0;
 	size = old_xattr->size;
-	simple_xattr_free(old_xattr);
+	simple_xattr_free_rcu(old_xattr);
 dec_size_out:
 	atomic_sub(size, sz);
 dec_count_out:
@@ -403,7 +414,7 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
 
 	atomic_sub(old_xattr->size, sz);
 	atomic_dec(nr);
-	simple_xattr_free(old_xattr);
+	simple_xattr_free_rcu(old_xattr);
 	return 0;
 }
 
@@ -415,6 +426,7 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 {
 	const char *full_name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
+	struct simple_xattrs *xattrs;
 	struct kernfs_iattrs *attrs;
 
 	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR))
@@ -424,11 +436,15 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	if (!attrs)
 		return -ENOMEM;
 
+	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
+	if (IS_ERR_OR_NULL(xattrs))
+		return PTR_ERR(xattrs);
+
 	if (value)
-		return kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
+		return kernfs_vfs_user_xattr_add(kn, full_name, xattrs,
 						 value, size, flags);
 	else
-		return kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
+		return kernfs_vfs_user_xattr_rm(kn, full_name, xattrs,
 						value, size, flags);
 
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 6061b6f70d2a..1324ed8c0661 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -26,7 +26,7 @@ struct kernfs_iattrs {
 	struct timespec64	ia_mtime;
 	struct timespec64	ia_ctime;
 
-	struct simple_xattrs	xattrs;
+	struct simple_xattrs	*xattrs;
 	atomic_t		nr_user_xattrs;
 	atomic_t		user_xattr_size;
 };

-- 
2.47.3


