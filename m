Return-Path: <linux-fsdevel+bounces-77280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNZAG0sdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:36:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6B143DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DCD6305FC48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DBB30FF25;
	Mon, 16 Feb 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+BfJKAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD030ACFF;
	Mon, 16 Feb 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248757; cv=none; b=XAYYi08VI2xi78ZLf8Io2yg2rdXkRi7WUDm1t/AlMOdDwXTtjHZGU5cpvJE1x49p2cNw6H4HEeJEZzh/EIfBBoTbASZmEWJFkR8DR/utbZQ8qosFpOF6rBeDB2htdHNWamFj6qqNGjcm70Ya45IjOhfc9cE711fjJ4wnxy04BkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248757; c=relaxed/simple;
	bh=07ziX3ZBWcGP0yXHy4c2MCvyc7P5td2Iy64SBWqQAOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEKklVyRyuNcqIHfb/JLbaqFZ8O6asTEaBsK8OU+DXZTsLYzg70tN0plGy2ZOoIlm/zqyAglFtSbOz7CxRVwpIiyAbT+NzINpq8GOkHl2WSDmSs0VfPEcPnC8XTqR05VNhi+xEZKmP0/PjmcVobKlnRGwOdkGvNnPe8Hgx7YrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+BfJKAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B37C2BC87;
	Mon, 16 Feb 2026 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248756;
	bh=07ziX3ZBWcGP0yXHy4c2MCvyc7P5td2Iy64SBWqQAOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+BfJKAzYWN4zRNOyeAKZFgosWaCsFhQr5OoKBjrtGva6kKKZwcb4Xc0ENxQhwZxW
	 Cav9RWXEa+GqmdMN4mjcEvTPYAQCyQdnVHTDK9l9ZeV1F5FvfS7/FWV+11RQzgpRkF
	 4rmR0JlI0gQAlZyfJfnpMvbYhHETArqW/CI4j4FDhOp6Pon5WyNlwzcYKDOM2vm5Qw
	 SEqGiKWWZqeMDdbRHB4bAs1PJucx+LVd55gKbstS54PNXycvtc6h34CoTNbW4oQiJJ
	 +gnSRdqpHPesrG/aDcLIUKe9KQh9Vqc8j76cTO1y+hKdouYYBRgMoTOHeZGvKG8jKv
	 uOpT/x1XDiSQw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:01 +0100
Subject: [PATCH 05/14] pidfs: adapt to rhashtable-based simple_xattrs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-5-c2efa4f74cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4671; i=brauner@kernel.org;
 h=from:subject:message-id; bh=07ziX3ZBWcGP0yXHy4c2MCvyc7P5td2Iy64SBWqQAOo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlonrmOSRt8BdI/uU0iNeMd706vvT+u6knXFNkOs8E
 xV/M0yqo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL5rYwMO/OFTrtsmf/w+sqq
 mxcSshzvbYzPqk0T37/IOnD3e7FdQYwMZ+xlClubDmjJHnt5zIFpR9KCF1cXVz2Tecu5sTdn3e4
 b7AA=
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
	TAGGED_FROM(0.00)[bounces-77280-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: DEB6B143DF1
X-Rspamd-Action: no action

Adapt pidfs to use the rhashtable-based xattr path by switching from a
dedicated slab cache to simple_xattrs_alloc().

Previously pidfs used a custom kmem_cache (pidfs_xattr_cachep) that
allocated a struct containing an embedded simple_xattrs plus
simple_xattrs_init(). Replace this with simple_xattrs_alloc() which
combines kzalloc + rhashtable_init, and drop the dedicated slab cache
entirely.

Use simple_xattr_free_rcu() for replaced xattr entries to allow
concurrent RCU readers to finish.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 65 +++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1e20e36e0ed5..cb62000681df 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -21,6 +21,7 @@
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
 #include <linux/coredump.h>
+#include <linux/llist.h>
 #include <linux/xattr.h>
 
 #include "internal.h"
@@ -29,7 +30,6 @@
 #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
 
 static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
-static struct kmem_cache *pidfs_xattr_cachep __ro_after_init;
 
 static struct path pidfs_root_path = {};
 
@@ -44,9 +44,8 @@ enum pidfs_attr_mask_bits {
 	PIDFS_ATTR_BIT_COREDUMP	= 1,
 };
 
-struct pidfs_attr {
+struct pidfs_anon_attr {
 	unsigned long attr_mask;
-	struct simple_xattrs *xattrs;
 	struct /* exit info */ {
 		__u64 cgroupid;
 		__s32 exit_code;
@@ -55,6 +54,14 @@ struct pidfs_attr {
 	__u32 coredump_signal;
 };
 
+struct pidfs_attr {
+	struct simple_xattrs *xattrs;
+	union {
+		struct pidfs_anon_attr;
+		struct llist_node pidfs_llist;
+	};
+};
+
 static struct rb_root pidfs_ino_tree = RB_ROOT;
 
 #if BITS_PER_LONG == 32
@@ -147,10 +154,30 @@ void pidfs_remove_pid(struct pid *pid)
 	write_seqcount_end(&pidmap_lock_seq);
 }
 
+static LLIST_HEAD(pidfs_free_list);
+
+static void pidfs_free_attr_work(struct work_struct *work)
+{
+	struct pidfs_attr *attr, *next;
+	struct llist_node *head;
+
+	head = llist_del_all(&pidfs_free_list);
+	llist_for_each_entry_safe(attr, next, head, pidfs_llist) {
+		struct simple_xattrs *xattrs = attr->xattrs;
+
+		if (xattrs) {
+			simple_xattrs_free(xattrs, NULL);
+			kfree(xattrs);
+		}
+		kfree(attr);
+	}
+}
+
+static DECLARE_WORK(pidfs_free_work, pidfs_free_attr_work);
+
 void pidfs_free_pid(struct pid *pid)
 {
-	struct pidfs_attr *attr __free(kfree) = no_free_ptr(pid->attr);
-	struct simple_xattrs *xattrs __free(kfree) = NULL;
+	struct pidfs_attr *attr = pid->attr;
 
 	/*
 	 * Any dentry must've been wiped from the pid by now.
@@ -169,9 +196,10 @@ void pidfs_free_pid(struct pid *pid)
 	if (IS_ERR(attr))
 		return;
 
-	xattrs = no_free_ptr(attr->xattrs);
-	if (xattrs)
-		simple_xattrs_free(xattrs, NULL);
+	if (likely(!attr->xattrs))
+		kfree(attr);
+	else if (llist_add(&attr->pidfs_llist, &pidfs_free_list))
+		schedule_work(&pidfs_free_work);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -998,7 +1026,7 @@ static int pidfs_xattr_get(const struct xattr_handler *handler,
 
 	xattrs = READ_ONCE(attr->xattrs);
 	if (!xattrs)
-		return 0;
+		return -ENODATA;
 
 	name = xattr_full_name(handler, suffix);
 	return simple_xattr_get(xattrs, name, value, size);
@@ -1018,22 +1046,16 @@ static int pidfs_xattr_set(const struct xattr_handler *handler,
 	/* Ensure we're the only one to set @attr->xattrs. */
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	xattrs = READ_ONCE(attr->xattrs);
-	if (!xattrs) {
-		xattrs = kmem_cache_zalloc(pidfs_xattr_cachep, GFP_KERNEL);
-		if (!xattrs)
-			return -ENOMEM;
-
-		simple_xattrs_init(xattrs);
-		smp_store_release(&pid->attr->xattrs, xattrs);
-	}
+	xattrs = simple_xattrs_lazy_alloc(&attr->xattrs, value, flags);
+	if (IS_ERR_OR_NULL(xattrs))
+		return PTR_ERR(xattrs);
 
 	name = xattr_full_name(handler, suffix);
 	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr))
 		return PTR_ERR(old_xattr);
 
-	simple_xattr_free(old_xattr);
+	simple_xattr_free_rcu(old_xattr);
 	return 0;
 }
 
@@ -1108,11 +1130,6 @@ void __init pidfs_init(void)
 					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
 					  SLAB_ACCOUNT | SLAB_PANIC), NULL);
 
-	pidfs_xattr_cachep = kmem_cache_create("pidfs_xattr_cache",
-					       sizeof(struct simple_xattrs), 0,
-					       (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
-						SLAB_ACCOUNT | SLAB_PANIC), NULL);
-
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");

-- 
2.47.3


