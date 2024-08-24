Return-Path: <linux-fsdevel+bounces-27054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31F95DFBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAC61C20CB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5FE1428E5;
	Sat, 24 Aug 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HCl/LWmJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E813C906
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526640; cv=none; b=llny6O3g4ym/16314qLL2yeaMFrCL5ovKMDVzQRTB/PWnGZNxoxI0HHgBvqtmJLS8vDiHNvIzFH3I87CXwJtfFIHuU7+VynVNq2ddrso4FWMRUDhuXbSPBzpOfavWagBlsRK8n+GHc+9fF3nxVm4FI6SgWUwN5eQlLyWtMx3mC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526640; c=relaxed/simple;
	bh=+N5O4TYls8s0AOH9XSqNElpWUgE51yqXS7fyeY1Pj/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC/qprolxypvDdgpTr4Ejms2fy12OwCEib7zYHxGU5FOxPkTsMzEb7yZ1k/XuArjTqYca3z4/fb/WfZW5xpKRpKd18CeT11zpzd7sFniFKbVDZZQ+owQDsYAEV4YD37cCZqYHx5S1zmSkNMu1cb9JR+hz+f3No/u0DSspAC4uZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HCl/LWmJ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIF02eH9k6dm0NzZMiixaw+oq+xhVtrthbaRSnodZvc=;
	b=HCl/LWmJbPvVzwn/ZY3aUrgi1pxURTXeresHi0kDKfH12r0Dn81Qxcx3IsFaNWZka7CS+a
	4lRwMz2Qw5uIGa50IsWt9GUBstO5XMK+fyTy8fJ936oYKvxsHAuvebZUw7S4f0ovBdErkx
	loDj/C2bOYdsxcPpgzTpsvnBl5Mn7rQ=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 09/10] fs/dcache: Add per-sb accounting for nr dentries
Date: Sat, 24 Aug 2024 15:10:16 -0400
Message-ID: <20240824191020.3170516-10-kent.overstreet@linux.dev>
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

Like the previous patch, add a counter for total dentries, so we can
print total vs. reclaimable.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/dcache.c        | 2 ++
 fs/super.c         | 6 ++++++
 include/linux/fs.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 64108cbd52f6..4bbb2c87f824 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -601,6 +601,7 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
 	else
 		spin_unlock(&dentry->d_lock);
 	this_cpu_dec(nr_dentry);
+	this_cpu_dec(*dentry->d_sb->s_dentry_nr);
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
 
@@ -1683,6 +1684,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	}
 
 	this_cpu_inc(nr_dentry);
+	this_cpu_inc(*sb->s_dentry_nr);
 
 	return dentry;
 }
diff --git a/fs/super.c b/fs/super.c
index b1b6ae491b6c..5b0fea6ff1cd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -278,6 +278,7 @@ static void destroy_super_work(struct work_struct *work)
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
+	free_percpu(s->s_dentry_nr);
 	free_percpu(s->s_inodes_nr);
 	for (int i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
@@ -299,6 +300,7 @@ static void destroy_unused_super(struct super_block *s)
 	super_unlock_excl(s);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
+	free_percpu(s->s_dentry_nr);
 	free_percpu(s->s_inodes_nr);
 	shrinker_free(s->s_shrink);
 	/* no delays needed */
@@ -381,6 +383,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	if (!s->s_inodes_nr)
 		goto fail;
 
+	s->s_dentry_nr = alloc_percpu(size_t);
+	if (!s->s_dentry_nr)
+		goto fail;
+
 	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 				     "sb-%s", type->name);
 	if (!s->s_shrink)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 86636831b9d0..493fb8e72bf0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1332,6 +1332,7 @@ struct super_block {
 	 * There is no need to put them into separate cachelines.
 	 */
 	struct list_lru		s_dentry_lru;
+	size_t __percpu		*s_dentry_nr;
 	struct list_lru		s_inode_lru;
 	struct rcu_head		rcu;
 	struct work_struct	destroy_work;
-- 
2.45.2


