Return-Path: <linux-fsdevel+bounces-60884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452FB527FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91A8580532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A624BD04;
	Thu, 11 Sep 2025 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YSYfuLqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898A21C160;
	Thu, 11 Sep 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567138; cv=none; b=PDyASY2Z7Hox9lMN67p0tZyrZtVJbl2d7jRSimcCIszeMW+6kFUOOuhquVplrtE6XnUctpqnSZK/jlUIZLypO/rSWpT2Jr43UGIpmUs+zgY6UblMRtpgVqLDfu8Hgzwe0TU6/2DEjXrt7b4PrWeghn2w/NLd2AQ6uplx6E1JAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567138; c=relaxed/simple;
	bh=glpgGqMyPX1WzvhFr1t2cS7C9dXSXSxwAH/vX786+3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEldBINO9/Y1DKdGGE1OM6pynL5H2ipc5fopIsDA5jgK0TvG5a2ZDjFwsY2OsSJtBM1vg3I3nO1l1JwzvBLPyLY4PReLV7Srf2wkbGMcFe4qGQ0pwvE2weLP+PmGexbq6BRllW+UTNt83jqT/48xKP2fy42/lpuKe+krCsa7LcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YSYfuLqI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0CcKvldIZNJW79kRmpAdQE4cnrrBpI7RXSbDm77cZJY=; b=YSYfuLqIekKKX0gyv8gAWtg9zr
	D7Jzy3Iy7GMj1hYnj+N/ejjVsi0DlLa/t6G3jYWbBcg4kNmVeiDF5kIh6GrQkK4AMU9ucpGsCrksU
	crW5ZHYVA1NCYqwXM+aXn4j+CYkpIRiWf7nyD99n35P15LaI4BuXGBqR7FSOAzl6L7l/nZaHOIrx+
	KGmzDtiYbie1L/yqjfKjtjD5hkRDPicg2P52Lq891wmPbhk3fwvrfATCttVm/mKRu1OKvtJIYrWnn
	flH0bhwJMZJq4ahUfznJo2cUeptcDSpBs1M89k17/uBDEB+9mdxtq/xkkUkm3KL1M9+UO4t/yVLqn
	GkZOuQAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZV1-0000000D4l0-22UM;
	Thu, 11 Sep 2025 05:05:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	linkinjeon@kernel.org
Subject: [PATCH 6/6] make it easier to catch those who try to modify ->d_name
Date: Thu, 11 Sep 2025 06:05:34 +0100
Message-ID: <20250911050534.3116491-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Turn d_name into an anon union of const struct qstr d_name with
struct qstr __d_name.  Very few places need to modify it (all
in fs/dcache.c); those are switched to use of ->__d_name.

Note that ->d_name can actually change under you unless you have
the right locking environment; this const just prohibits accidentally
doing stores without being easily spotted.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 26 +++++++++++++-------------
 include/linux/dcache.h |  5 ++++-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..b4cd5e1321b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1717,13 +1717,13 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		dname = dentry->d_shortname.string;
 	}	
 
-	dentry->d_name.len = name->len;
-	dentry->d_name.hash = name->hash;
+	dentry->__d_name.len = name->len;
+	dentry->__d_name.hash = name->hash;
 	memcpy(dname, name->name, name->len);
 	dname[name->len] = 0;
 
 	/* Make sure we always see the terminating NUL character */
-	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
+	smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
 
 	dentry->d_flags = 0;
 	lockref_init(&dentry->d_lockref);
@@ -2743,15 +2743,15 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			/*
 			 * Both external: swap the pointers
 			 */
-			swap(target->d_name.name, dentry->d_name.name);
+			swap(target->__d_name.name, dentry->__d_name.name);
 		} else {
 			/*
 			 * dentry:internal, target:external.  Steal target's
 			 * storage and make target internal.
 			 */
-			dentry->d_name.name = target->d_name.name;
+			dentry->__d_name.name = target->__d_name.name;
 			target->d_shortname = dentry->d_shortname;
-			target->d_name.name = target->d_shortname.string;
+			target->__d_name.name = target->d_shortname.string;
 		}
 	} else {
 		if (unlikely(dname_external(dentry))) {
@@ -2759,9 +2759,9 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * dentry:external, target:internal.  Give dentry's
 			 * storage to target and make dentry internal
 			 */
-			target->d_name.name = dentry->d_name.name;
+			target->__d_name.name = dentry->__d_name.name;
 			dentry->d_shortname = target->d_shortname;
-			dentry->d_name.name = dentry->d_shortname.string;
+			dentry->__d_name.name = dentry->d_shortname.string;
 		} else {
 			/*
 			 * Both are internal.
@@ -2771,7 +2771,7 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 				     target->d_shortname.words[i]);
 		}
 	}
-	swap(dentry->d_name.hash_len, target->d_name.hash_len);
+	swap(dentry->__d_name.hash_len, target->__d_name.hash_len);
 }
 
 static void copy_name(struct dentry *dentry, struct dentry *target)
@@ -2781,11 +2781,11 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		old_name = external_name(dentry);
 	if (unlikely(dname_external(target))) {
 		atomic_inc(&external_name(target)->count);
-		dentry->d_name = target->d_name;
+		dentry->__d_name = target->__d_name;
 	} else {
 		dentry->d_shortname = target->d_shortname;
-		dentry->d_name.name = dentry->d_shortname.string;
-		dentry->d_name.hash_len = target->d_name.hash_len;
+		dentry->__d_name.name = dentry->d_shortname.string;
+		dentry->__d_name.hash_len = target->__d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->count)))
 		kfree_rcu(old_name, head);
@@ -3133,7 +3133,7 @@ void d_mark_tmpfile(struct file *file, struct inode *inode)
 		!d_unlinked(dentry));
 	spin_lock(&dentry->d_parent->d_lock);
 	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-	dentry->d_name.len = sprintf(dentry->d_shortname.string, "#%llu",
+	dentry->__d_name.len = sprintf(dentry->d_shortname.string, "#%llu",
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dentry->d_parent->d_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index cc3e1c1a3454..c83e02b94389 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -95,7 +95,10 @@ struct dentry {
 	seqcount_spinlock_t d_seq;	/* per dentry seqlock */
 	struct hlist_bl_node d_hash;	/* lookup hash list */
 	struct dentry *d_parent;	/* parent directory */
-	struct qstr d_name;
+	union {
+	struct qstr __d_name;		/* for use ONLY in fs/dcache.c */
+	const struct qstr d_name;
+	};
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
 	union shortname_store d_shortname;
-- 
2.47.2


