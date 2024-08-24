Return-Path: <linux-fsdevel+bounces-27053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17F95DFBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795F52828A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBCE13E881;
	Sat, 24 Aug 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wTNonfQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AB13A888
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526639; cv=none; b=USoSl3p+W4eKtXhIGMomPOB6YW9bZm2r23MDc42GqbFeC36gV7RY/IFN9j4jmvDrPmCP1iHV/soK8/uELcmgmaPKdKsml5I/znYqxvo8x0jV29gnA696whBBKY+NZu1UI62a3pwj3abcKtf0ywEn8xeRQS++rq0Wx6L301IYWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526639; c=relaxed/simple;
	bh=dpnYb+nU1F42rtWYT4/44p0IQFEbxguJdMwg3r2vWEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCvgLiFwhzXn+ihTY3d/uLaMTSK23I6mOtb5f33Zh9+j8OqhujpZiWGQ1IFFgQ04hjh6UTiETb5z4zzIA4z00UdbZnxZJKCIjrjwt3mZQPuuwxZ/x7KN3JiBbjpXeV1CJRt6AWYVQxw3Ztar989lMC5vDXJJLyw428/BT1mNCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wTNonfQ8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkjDXacJBIE1tnl8yjf2hTWkksioVHF2A/Lmh31BWug=;
	b=wTNonfQ8/pgi2wT6SpzNvV1SNBGipnFrxT4NfhyDeL4N7vyQtDB52h1ymy/Cw91TCBmyq4
	NMuN/t0hl+jsEGr3Jii46H75JjUhzOIlcDwgZ49INWfPV4i/Kqp/X+vVMVTrZK4R5juNwe
	482emWvPc/dZrYuIJGexZ6pMGuggzW0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 08/10] fs: Add super_block->s_inodes_nr
Date: Sat, 24 Aug 2024 15:10:15 -0400
Message-ID: <20240824191020.3170516-9-kent.overstreet@linux.dev>
In-Reply-To: <20240824191020.3170516-1-kent.overstreet@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Upcoming shrinker debugging patchset is going to give us a callback for
reporting on all memory owned by a shrinker.

This adds a counter for total number of inodes allocated for a given
superblock, so we can compare with the number of reclaimable inodes we
already have.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/inode.c         | 2 ++
 fs/super.c         | 7 +++++++
 include/linux/fs.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 5e7dcdeedd4d..2650c5ce74e1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -489,12 +489,14 @@ void inode_sb_list_add(struct inode *inode)
 	spin_lock(&inode->i_sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
 	spin_unlock(&inode->i_sb->s_inode_list_lock);
+	this_cpu_inc(*inode->i_sb->s_inodes_nr);
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
 static inline void inode_sb_list_del(struct inode *inode)
 {
 	if (!list_empty(&inode->i_sb_list)) {
+		this_cpu_dec(*inode->i_sb->s_inodes_nr);
 		spin_lock(&inode->i_sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&inode->i_sb->s_inode_list_lock);
diff --git a/fs/super.c b/fs/super.c
index b7913b55debc..b1b6ae491b6c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -278,6 +278,7 @@ static void destroy_super_work(struct work_struct *work)
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
+	free_percpu(s->s_inodes_nr);
 	for (int i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
@@ -298,6 +299,7 @@ static void destroy_unused_super(struct super_block *s)
 	super_unlock_excl(s);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
+	free_percpu(s->s_inodes_nr);
 	shrinker_free(s->s_shrink);
 	/* no delays needed */
 	destroy_super_work(&s->destroy_work);
@@ -375,6 +377,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
 
+	s->s_inodes_nr = alloc_percpu(size_t);
+	if (!s->s_inodes_nr)
+		goto fail;
+
 	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 				     "sb-%s", type->name);
 	if (!s->s_shrink)
@@ -408,6 +414,7 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
+		WARN_ON(per_cpu_sum(s->s_inodes_nr));
 		call_rcu(&s->rcu, destroy_super_rcu);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8fc4bad3b6ae..86636831b9d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1346,6 +1346,7 @@ struct super_block {
 	/* s_inode_list_lock protects s_inodes */
 	spinlock_t		s_inode_list_lock ____cacheline_aligned_in_smp;
 	struct list_head	s_inodes;	/* all inodes */
+	size_t __percpu		*s_inodes_nr;
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
-- 
2.45.2


