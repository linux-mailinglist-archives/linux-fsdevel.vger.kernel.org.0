Return-Path: <linux-fsdevel+bounces-10208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29288848A9A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C10A1C22ADE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8F210A34;
	Sun,  4 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rK7OcwXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0127499;
	Sun,  4 Feb 2024 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013065; cv=none; b=f+B3g3Xtuc5B32sqCFzQFvtmcJKrukZojpy4cM6o+lTdYsFS0uUJWzTtgy7dRk7Q+qyiiZLMREbHvevi7cvujyVlUmrxWY5W20YV0AHn7eyeJbrzfl2NiG/squSdnuXvnEX8jl9RjMhIAmQoZJHONlKhgpThie1V3HbBjcLDTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013065; c=relaxed/simple;
	bh=wKYT0Nl+K9iZIU8uK5fkG6hh9J3hSCBbl3yHV/LUoDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1fChYy2RjxnF0kyida8/awSXvjqJh9tw+yLaxU49pT72R2ZH7YynC7Yuew1/UdJxPPaVG4twUtKDpg1hLMevXMmp/G64miXrTT7/2r1TGI4AgxV3CnaTeU5VuzGVV8NSGxxqL2XPEl/NvfNcE+HLtYQHVd/omr3+dOWas0CK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rK7OcwXI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vV6DklX0PI+1e7tA40Z3BWWdMFq/uG8yRMvN+zPvgKs=; b=rK7OcwXIXOaVllu2KNzDxZowuI
	wbBANOVrVmrbcRTFnARcE6G7eS6j9xkFrtr5FxwfK6QJwAvRAS+JnJz88QOw5l3aNe1HE+SaECS/n
	fMfZzbNZ+Af3QnG4ZYSy5gKaB7RjbDSprs/eEWnS1cmBS6SBK+HaXUB9/4x4beWEjZuUeCKI+6D+m
	wU62PKZkRAmchB+GMltzJuqimvsG5j/+e6KBNGxzD5srUUthwS8+CHJk4YIViWE0s5JPLI89V2lGY
	lcga2aOJAuyjvuAhFZgHYPZXFTz68iS8S5GpfnD6Wfp6KuAhZZxZYN71ly5x5HbFd2PJiFuT0n1+T
	WHAObTIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDc-1u;
	Sun, 04 Feb 2024 02:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
Date: Sun,  4 Feb 2024 02:17:37 +0000
Message-Id: <20240204021739.1157830-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->permission(), ->get_link() and ->inode_get_acl() might dereference
->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
as well) when called from rcu pathwalk.

Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_fs_info
and dropping ->user_ns rcu-delayed too.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/cuse.c   |  3 +--
 fs/fuse/fuse_i.h |  1 +
 fs/fuse/inode.c  | 15 +++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 91e89e68177e..b6cad106c37e 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -474,8 +474,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 
 static void cuse_fc_release(struct fuse_conn *fc)
 {
-	struct cuse_conn *cc = fc_to_cc(fc);
-	kfree_rcu(cc, fc.rcu);
+	kfree(fc_to_cc(fc));
 }
 
 /**
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..bcbe34488862 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -888,6 +888,7 @@ struct fuse_mount {
 
 	/* Entry on fc->mounts */
 	struct list_head fc_entry;
+	struct rcu_head rcu;
 };
 
 static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..516ea2979a90 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -930,6 +930,14 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
+static void delayed_release(struct rcu_head *p)
+{
+	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
+
+	put_user_ns(fc->user_ns);
+	fc->release(fc);
+}
+
 void fuse_conn_put(struct fuse_conn *fc)
 {
 	if (refcount_dec_and_test(&fc->count)) {
@@ -941,13 +949,12 @@ void fuse_conn_put(struct fuse_conn *fc)
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
-		put_user_ns(fc->user_ns);
 		bucket = rcu_dereference_protected(fc->curr_bucket, 1);
 		if (bucket) {
 			WARN_ON(atomic_read(&bucket->count) != 1);
 			kfree(bucket);
 		}
-		fc->release(fc);
+		call_rcu(&fc->rcu, delayed_release);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
@@ -1366,7 +1373,7 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
-	kfree_rcu(fc, rcu);
+	kfree(fc);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
 
@@ -1902,7 +1909,7 @@ static void fuse_sb_destroy(struct super_block *sb)
 void fuse_mount_destroy(struct fuse_mount *fm)
 {
 	fuse_conn_put(fm->fc);
-	kfree(fm);
+	kfree_rcu(fm, rcu);
 }
 EXPORT_SYMBOL(fuse_mount_destroy);
 
-- 
2.39.2


