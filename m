Return-Path: <linux-fsdevel+bounces-67906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B614C4D4B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C47618C3976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0D357737;
	Tue, 11 Nov 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou6eijKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F1357725;
	Tue, 11 Nov 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858546; cv=none; b=h4bGZ7j14dp781McoN6IqQrf5nUlDhg2FY7ccREPp2k2FcFs+ErwbnH/MyZbxTe3pH523AslwaeIzg5kV7rjAI+3818PBNc704l+VYk4L94A7rGlTszcfXSt3o1PCS1dlS5aXJVQQl7syRk8XlrJ67++S50GFM+Vjo4aGrtzncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858546; c=relaxed/simple;
	bh=H0X4UWPxfP0HtpuLKbuoNGl0NODn/gG9NPCPa1XRwas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwFPEcDyfrWg9YmBhVAaXiwvs9SyS96aIw9AVgt7N9TypjUvZM1gzCQysQFQ/yizaTsozknGRQNDF2IO/DxfrtGWsp/tSZg0593P6Pq3agc3hUd+zrbRAapV/XSY1MYcWV2AA7Nm4xn/p6aW/xuAF2bNvqR0bi9dMTJoUIDP3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou6eijKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90ABC116D0;
	Tue, 11 Nov 2025 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858546;
	bh=H0X4UWPxfP0HtpuLKbuoNGl0NODn/gG9NPCPa1XRwas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ou6eijKQUCD6/ezjdxy05/4K9NcjBNoq7BVw6xpcAA1Ja2S7Ia9M9H4Xj4m7DW4w8
	 UsQqUAYcAr0lLEvMc1p69vfRPLGQvdzG7Zi6ewHNwSuumvsVattqCD3y7UKvvN/WQy
	 wmt4QjSRAKFkyL5wYf+evSyj+MDQiusk1oIrJfNU9NIPb1szFKWk4O63MaL3htZrGB
	 ql/HItjVNrX5Vnghj8suD+/WICqQhBKGzxE3bQPjq3FZnR1IbSGo04HRb7pS0yHswE
	 g+n+4fKjlRq7+PnZtEVtwTKFM6JdHhhjhoaUy8lszG01TQ9/x3EsqKMW+RQSW5xb2W
	 5oByRKVsFwULA==
Date: Tue, 11 Nov 2025 11:55:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111102435.GW2441659@ZenIV>

On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
> On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
> 
> > > +	sbi->owner = current->nsproxy->mnt_ns;
> > 
> > ns_ref_get()
> > Can be called directly on the mount namespace.
> 
> ... and would leak all mounts in the mount tree, unless I'm missing
> something subtle.

Right, I thought you actually wanted to pin it.
Anyway, you could take a passive reference but I think that's nonsense
as well. The following should do it:

UNTESTED, UNCOMPILED

---
 fs/autofs/autofs_i.h |  4 ++++
 fs/autofs/inode.c    |  3 +++
 fs/autofs/root.c     | 10 ++++++++++
 fs/namespace.c       |  6 ++++++
 include/linux/fs.h   |  1 +
 5 files changed, 24 insertions(+)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 23cea74f9933..2b9d2300d351 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <uapi/linux/mount.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/uaccess.h>
@@ -109,11 +110,14 @@ struct autofs_wait_queue {
 #define AUTOFS_SBI_STRICTEXPIRE 0x0002
 #define AUTOFS_SBI_IGNORE	0x0004
 
 struct autofs_sb_info {
 	u32 magic;
 	int pipefd;
 	struct file *pipe;
 	struct pid *oz_pgrp;
+	u64 mnt_ns_id;
 	int version;
 	int sub_version;
 	int min_proto;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index f5c16ffba013..247a5784d192 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -6,8 +6,10 @@
 
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
+#include <linux/ns_common.h>
 
 #include "autofs_i.h"
+#include "../mount.h"
 
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *sbi)
 {
@@ -251,6 +253,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
 	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
 	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
 	sbi->pipefd = -1;
+	sbi->mnt_ns_id = to_ns_common(current->nsproxy->mnt_ns)->ns_id;
 
 	set_autofs_type_indirect(&sbi->type);
 	mutex_init(&sbi->wq_mutex);
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 174c7205fee4..f06f62d23e76 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -7,8 +7,10 @@
 
 #include <linux/capability.h>
 #include <linux/compat.h>
+#include <linux/ns_common.h>
 
 #include "autofs_i.h"
+#include "../mount.h"
 
 static int autofs_dir_permission(struct mnt_idmap *, struct inode *, int);
 static int autofs_dir_symlink(struct mnt_idmap *, struct inode *,
@@ -341,6 +343,14 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 	if (autofs_oz_mode(sbi))
 		return NULL;
 
+	/* Refuse to trigger mount if current namespace is not the owner
+	 * and the mount is propagation private.
+	 */
+	if (sbi->mnt_ns_id != to_ns_common(current->nsproxy->mnt_ns)->ns_id) {
+		if (vfsmount_to_propagation_flags(path->mnt) & MS_PRIVATE)
+			return ERR_PTR(-EPERM);
+	}
+
 	/*
 	 * If an expire request is pending everyone must wait.
 	 * If the expire fails we're still mounted so continue
diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..27bb12693cba 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5150,6 +5150,12 @@ static u64 mnt_to_propagation_flags(struct mount *m)
 	return propagation;
 }
 
+u64 vfsmount_to_propagation_flags(struct vfsmount *mnt)
+{
+	return mnt_to_propagation_flags(real_mount(mnt));
+}
+EXPORT_SYMBOL_GPL(vfsmount_to_propagation_flags);
+
 static void statmount_sb_basic(struct kstatmount *s)
 {
 	struct super_block *sb = s->mnt->mnt_sb;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..a5c2077ce6ed 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3269,6 +3269,7 @@ extern struct file * open_exec(const char *);
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
+u64 vfsmount_to_propagation_flags(struct vfsmount *mnt);
 
 extern char *file_path(struct file *, char *, int);
 

