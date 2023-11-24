Return-Path: <linux-fsdevel+bounces-3630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD2C7F6C1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0872B21257
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28606B677;
	Fri, 24 Nov 2023 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YT8NS8sX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F3619AE;
	Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XPyaCiQYgDLolwiCNI4gnwbAILovZtP7N3FDBMoCdWg=; b=YT8NS8sXC10KTuFYngOHZj6MLw
	F0rfl7O6hqpLvUe1f0tn7GTUUrF7npWoFU+dksKFXDOzUQ9joU+HTzA5h6T8w9g99A4HJd4RVm5Nu
	SK1Y8bJQf11J50MVIo6vyO7gjy5lhuVaanH4wF5u+i0uv7/8e2AxyTEfpdSk1I7IM/FBJPEfdThlf
	Ln9BJwAzsi/ZWKtMYPgT7q/ZyLXMSiemcb4DQ8jqFzwsG+tQeARTvl7a//YuELXLxJF9Wd3BYXTWD
	YL1Vow9HjBEUUTBDh+NsO4jVIT/xUxa2mpuptZveJa7wbk5xsUN9Mznh9GGstsK46beNMflPMyvCc
	zlBaCVLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKv-002Q0t-2v;
	Fri, 24 Nov 2023 06:06:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] dentry.h: trim externs
Date: Fri, 24 Nov 2023 06:06:32 +0000
Message-Id: <20231124060644.576611-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

d_instantiate_unique() had been gone for 7 years; __d_lookup...()
and shrink_dcache_for_umount() are fs/internal.h fodder.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h          | 4 ++++
 include/linux/dcache.h | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..9e9fc629f935 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -215,6 +215,10 @@ extern struct dentry * d_alloc_pseudo(struct super_block *, const struct qstr *)
 extern char *simple_dname(struct dentry *, char *, int);
 extern void dput_to_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
+extern void shrink_dcache_for_umount(struct super_block *);
+extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
+extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
+				const struct qstr *name, unsigned *seq);
 
 /*
  * pipe.c
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8cd937bb2292..9706bf1dc5de 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -218,7 +218,6 @@ extern seqlock_t rename_lock;
  */
 extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
-extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
@@ -240,7 +239,6 @@ extern struct dentry * d_obtain_alias(struct inode *);
 extern struct dentry * d_obtain_root(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_for_umount(struct super_block *);
 extern void d_invalidate(struct dentry *);
 
 /* only used at mount-time */
@@ -275,9 +273,6 @@ extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry *d_lookup(const struct dentry *, const struct qstr *);
 extern struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
-extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
-extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
-				const struct qstr *name, unsigned *seq);
 
 static inline unsigned d_count(const struct dentry *dentry)
 {
-- 
2.39.2


