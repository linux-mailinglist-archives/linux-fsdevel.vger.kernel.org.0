Return-Path: <linux-fsdevel+bounces-68855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357AC6786E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9108B4F5A52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812F62F6180;
	Tue, 18 Nov 2025 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="foJK7sLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE129AAFD;
	Tue, 18 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442977; cv=none; b=n00LK4Uchd/Zm6FQZ55ZaCKqehVSkbmXYnimywtT/byqrMKO6UDIhXyenN+R7fSkeWp148pkpSwfWSIz3MKzeCQe3jZTnsUmZ3TuopAV3rLhK1Ea2GicD74SPMse/FxLuRGHwHBa+eT7yvLnpJ2ptNvCVb94Db2H71UUj2o22nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442977; c=relaxed/simple;
	bh=Zkw5PIqzgZo1iaAu+8HqtP/RCpmxhagt1hjrnfFaxjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOB25Dhwus5cUQ4Wo7jK7+0LlwD6bXGQC/AgIOYg+jN7AFMaSYTUDQY3XtUFT18Dyzv4SI7wQ0H+RDDZ/021DLidiYVIjJQfvO+lg27nWRf3JcQafZxW5n0Pxq8c3zrnIc9KKTqa2ETbfWjKlVInLiKoTk11XCLVi1WzwN+hm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=foJK7sLd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NeGicC5Z67ZOycdylyHVP58sPv/wzz9kpKbtM8vrBao=; b=foJK7sLdTQuza99mB2bmXypFjg
	misbqZX+4TBMEHJPS/CtDVLH2McNOV5pxbQLZgbbfKRKtXjjwnk2f01dTbYNr9VJA67kQswAXuh51
	v7BUg/u2sW2x15WikQA8wQUoxPjQvUSRM40WHr5yWeQrqH6TIN7Q0CfbUthRf/ZPJEgYcaLwIqney
	EiFj+aQFrcYDib7axbtElcqJ5Z2Zc3O6A2uzMZLefKpMbX2VuLIAZAam2xbQLYKSpMfh0jj6whvUK
	xLyQ6i2VSFIlc42oPP0Ujsax5Y00fFs/iuT46xZx6+SyspurjtX6r0yUUM8mE4LPm/R5jlmNfWkCw
	C8m4O0vQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4U-0000000GERB-3NMQ;
	Tue, 18 Nov 2025 05:16:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 15/54] convert bpf
Date: Tue, 18 Nov 2025 05:15:24 +0000
Message-ID: <20251118051604.3868588-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

object creation goes through the normal VFS paths or approximation
thereof (user_path_create()/done_path_create() in case of bpf_obj_do_pin(),
open-coded simple_{start,done}_creating() in bpf_iter_link_pin_kernel()
at mount time), removals go entirely through the normal VFS paths (and
->unlink() is simple_unlink() there).

Enough to have bpf_dentry_finalize() use d_make_persistent() instead
of dget() and we are done.

Convert bpf_iter_link_pin_kernel() to simple_{start,done}_creating(),
while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/bpf/inode.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 81780bcf8d25..9f866a010dad 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -144,8 +144,7 @@ static int bpf_inode_type(const struct inode *inode, enum bpf_type *type)
 static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 				struct inode *dir)
 {
-	d_instantiate(dentry, inode);
-	dget(dentry);
+	d_make_persistent(dentry, inode);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
@@ -420,16 +419,12 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	struct dentry *dentry;
 	int ret;
 
-	inode_lock(parent->d_inode);
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		inode_unlock(parent->d_inode);
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	}
 	ret = bpf_mkobj_ops(dentry, mode, link, &bpf_link_iops,
 			    &bpf_iter_fops);
-	dput(dentry);
-	inode_unlock(parent->d_inode);
+	simple_done_creating(dentry);
 	return ret;
 }
 
@@ -1080,7 +1075,7 @@ static void bpf_kill_super(struct super_block *sb)
 {
 	struct bpf_mount_opts *opts = sb->s_fs_info;
 
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	kfree(opts);
 }
 
-- 
2.47.3


