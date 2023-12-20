Return-Path: <linux-fsdevel+bounces-6568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08881982F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8772886D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8D11CBA;
	Wed, 20 Dec 2023 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o/4agRSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8420125AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kccFgVGlbm9kT2ZOcrKRGrw8T0580qXJFRiqe+lUSzM=; b=o/4agRSkMZ45eg1tgx/RV30YP9
	lxB0Vxb5VRtufyO1p7RaZLPPsnC2ivPQjEzhm4qFZmyEqWpDoAdzaaKRd0Qu4AeyFAT7df40CEHgp
	BpUPhPG3O+PqR6i06aZclzLJ11jLN5zeKoqUATx2U5F4KJwyzzcnifbndciYhi2JNO28PtTnGWSO/
	JWFkEdk2qS+AWze3L6fkIpwXLoswGdAIBqATdk4OMPpCNsC9yKtBEj5b18x+bEwnqmn59bA2OG6o/
	YjMJXVhGQDiAqXZkygFiWQ0ZdKtHsg6+QDFXcrhA3eyJX15DKkFHT93DUxtHYZJ3cLXXu24t4GYIU
	uPGl8pIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpCA-00HJje-2p;
	Wed, 20 Dec 2023 05:32:39 +0000
Date: Wed, 20 Dec 2023 05:32:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: devel@lists.orangefs.org
Subject: [PATCH 21/22] orangefs: saner arguments passing in readdir guts
Message-ID: <20231220053238.GT1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

orangefs_dir_fill() doesn't use oi and dentry arguments at all
do_readdir() gets dentry, uses only dentry->d_inode; it also
gets oi, which is ORANGEFS_I(dentry->d_inode) (i.e. ->d_inode -
constant offset).
orangefs_dir_mode() gets dentry and oi, uses only to pass those
to do_readdir().
orangefs_dir_iterate() uses dentry and oi only to pass those to
orangefs_dir_fill() and orangefs_dir_more().

The only thing it really needs is ->d_inode; moreover, that's
better expressed as file_inode(file) - no need to go through
->f_path.dentry->d_inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/orangefs/dir.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/orangefs/dir.c b/fs/orangefs/dir.c
index 9cacce5d55c1..6d1fbeca9d81 100644
--- a/fs/orangefs/dir.c
+++ b/fs/orangefs/dir.c
@@ -58,10 +58,10 @@ struct orangefs_dir {
  * first part of the part list.
  */
 
-static int do_readdir(struct orangefs_inode_s *oi,
-    struct orangefs_dir *od, struct dentry *dentry,
+static int do_readdir(struct orangefs_dir *od, struct inode *inode,
     struct orangefs_kernel_op_s *op)
 {
+	struct orangefs_inode_s *oi = ORANGEFS_I(inode);
 	struct orangefs_readdir_response_s *resp;
 	int bufi, r;
 
@@ -87,7 +87,7 @@ static int do_readdir(struct orangefs_inode_s *oi,
 	op->upcall.req.readdir.buf_index = bufi;
 
 	r = service_operation(op, "orangefs_readdir",
-	    get_interruptible_flag(dentry->d_inode));
+	    get_interruptible_flag(inode));
 
 	orangefs_readdir_index_put(bufi);
 
@@ -158,8 +158,7 @@ static int parse_readdir(struct orangefs_dir *od,
 	return 0;
 }
 
-static int orangefs_dir_more(struct orangefs_inode_s *oi,
-    struct orangefs_dir *od, struct dentry *dentry)
+static int orangefs_dir_more(struct orangefs_dir *od, struct inode *inode)
 {
 	struct orangefs_kernel_op_s *op;
 	int r;
@@ -169,7 +168,7 @@ static int orangefs_dir_more(struct orangefs_inode_s *oi,
 		od->error = -ENOMEM;
 		return -ENOMEM;
 	}
-	r = do_readdir(oi, od, dentry, op);
+	r = do_readdir(od, inode, op);
 	if (r) {
 		od->error = r;
 		goto out;
@@ -238,9 +237,7 @@ static int fill_from_part(struct orangefs_dir_part *part,
 	return 1;
 }
 
-static int orangefs_dir_fill(struct orangefs_inode_s *oi,
-    struct orangefs_dir *od, struct dentry *dentry,
-    struct dir_context *ctx)
+static int orangefs_dir_fill(struct orangefs_dir *od, struct dir_context *ctx)
 {
 	struct orangefs_dir_part *part;
 	size_t count;
@@ -304,15 +301,10 @@ static loff_t orangefs_dir_llseek(struct file *file, loff_t offset,
 static int orangefs_dir_iterate(struct file *file,
     struct dir_context *ctx)
 {
-	struct orangefs_inode_s *oi;
-	struct orangefs_dir *od;
-	struct dentry *dentry;
+	struct orangefs_dir *od = file->private_data;
+	struct inode *inode = file_inode(file);
 	int r;
 
-	dentry = file->f_path.dentry;
-	oi = ORANGEFS_I(dentry->d_inode);
-	od = file->private_data;
-
 	if (od->error)
 		return od->error;
 
@@ -342,7 +334,7 @@ static int orangefs_dir_iterate(struct file *file,
 	 */
 	while (od->token != ORANGEFS_ITERATE_END &&
 	    ctx->pos > od->end) {
-		r = orangefs_dir_more(oi, od, dentry);
+		r = orangefs_dir_more(od, inode);
 		if (r)
 			return r;
 	}
@@ -351,17 +343,17 @@ static int orangefs_dir_iterate(struct file *file,
 
 	/* Then try to fill if there's any left in the buffer. */
 	if (ctx->pos < od->end) {
-		r = orangefs_dir_fill(oi, od, dentry, ctx);
+		r = orangefs_dir_fill(od, ctx);
 		if (r)
 			return r;
 	}
 
 	/* Finally get some more and try to fill. */
 	if (od->token != ORANGEFS_ITERATE_END) {
-		r = orangefs_dir_more(oi, od, dentry);
+		r = orangefs_dir_more(od, inode);
 		if (r)
 			return r;
-		r = orangefs_dir_fill(oi, od, dentry, ctx);
+		r = orangefs_dir_fill(od, ctx);
 	}
 
 	return r;
-- 
2.39.2


