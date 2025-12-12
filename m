Return-Path: <linux-fsdevel+bounces-71205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97983CB986D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76103308CB63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F92F7449;
	Fri, 12 Dec 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AvTD13PT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF42F6579;
	Fri, 12 Dec 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563196; cv=none; b=nvcwvpBr5RRHO1w904LUt0SyX4JyEN5r6K9FpV9eFrvugMCuRM8Q9XzmE2LpJOroGCQ4Cv30nrM1Zo/57WixLoz6Y9xQfjnrqqga3SM3YOOqmSdZdjup3TEn0KK005OyUTEl4WZ14cwju34Ridtm965rD8wmFLkHOIrB1SGhJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563196; c=relaxed/simple;
	bh=sE1U2JT29IIyaZXGY4gYUCAGTYj8W24heMfIOeCkHnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxR0gRQfksG/04AURm4AEL8GhxIlHraO3krU35Yj9U+D0weRl1CSPnG/aWKYJ0mqJZJ5wl6zOHsB1hTV+EBqKSk5qS991LDtLvVgGjQkry6S1t1EBVAxc/hGvRRLxcVGMy65zz7JX0Ij4SDH6DWl+Ph+zht5IMPvYs3xt0/EJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AvTD13PT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wh/bmeeiRnR220UJ6v12aSATo70mRqQdcfMFQLSOHB4=; b=AvTD13PTmVny7+UU1gZsU0ZPrI
	1M4yvngLeCzAFkimDh/Wh+mT4zavqujlgPoMdo2zjeDKfMD5LGzLTexNxftu1gyF/P+sdxdTgGhMl
	Hf1q7FG+uqGzP5+mfk21MEg5Mnl28+UKdodL58LzHvWXNM1SaiI2HhLuB+vUF/lUoI57WONm2oJiC
	TC2AjAcQPtWtU8je++Q1l65iBIzboyUxcdaPd6/eM389sAeZ0HoELhTx9lZaVkXY/C1FwButns7th
	oqJMz3Wtlh8eZBa2RF1cPY6s40q0ly3oXYZ8p2hTFwzBiMBwiRCqFdMEMuWAeqFqBjZqf8DqRUVzf
	oupWD65A==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU7dR-00C798-40; Fri, 12 Dec 2025 19:12:57 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Kevin Chen <kchen@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2 1/6] fuse: store index of the variable length argument
Date: Fri, 12 Dec 2025 18:12:49 +0000
Message-ID: <20251212181254.59365-2-luis@igalia.com>
In-Reply-To: <20251212181254.59365-1-luis@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Operations that have a variable length argument assume that it will always
be the last argument on the list.  This patch allows this assumption to be
removed by keeping track of the index of variable length argument.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/cuse.c      | 1 +
 fs/fuse/dev.c       | 4 ++--
 fs/fuse/dir.c       | 1 +
 fs/fuse/file.c      | 1 +
 fs/fuse/fuse_i.h    | 2 ++
 fs/fuse/inode.c     | 1 +
 fs/fuse/ioctl.c     | 1 +
 fs/fuse/virtio_fs.c | 6 +++---
 fs/fuse/xattr.c     | 2 ++
 9 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 28c96961e85d..9d93a3023b19 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -460,6 +460,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->args.out_args[0].value = &ia->out;
 	ap->args.out_args[1].size = CUSE_INIT_INFO_MAX;
 	ap->args.out_argvar = true;
+	ap->args.out_argvar = 1;
 	ap->args.out_pages = true;
 	ap->num_folios = 1;
 	ap->folios = &ia->folio;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d70..629e8a043079 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -694,7 +694,7 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 	ret = req->out.h.error;
 	if (!ret && args->out_argvar) {
 		BUG_ON(args->out_numargs == 0);
-		ret = args->out_args[args->out_numargs - 1].size;
+		ret = args->out_args[args->out_argvar_idx].size;
 	}
 	fuse_put_request(req);
 
@@ -2157,7 +2157,7 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 	if (reqsize < nbytes || (reqsize > nbytes && !args->out_argvar))
 		return -EINVAL;
 	else if (reqsize > nbytes) {
-		struct fuse_arg *lastarg = &args->out_args[args->out_numargs-1];
+		struct fuse_arg *lastarg = &args->out_args[args->out_argvar_idx];
 		unsigned diffsize = reqsize - nbytes;
 
 		if (diffsize > lastarg->size)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a1..4dfe964a491c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1629,6 +1629,7 @@ static int fuse_readlink_folio(struct inode *inode, struct folio *folio)
 	ap.args.nodeid = get_node_id(inode);
 	ap.args.out_pages = true;
 	ap.args.out_argvar = true;
+	ap.args.out_argvar_idx = 0;
 	ap.args.page_zeroing = true;
 	ap.args.out_numargs = 1;
 	ap.args.out_args[0].size = desc.length;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05..0fef3da1585c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -581,6 +581,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 	args->in_args[0].size = sizeof(ia->read.in);
 	args->in_args[0].value = &ia->read.in;
 	args->out_argvar = true;
+	args->out_argvar_idx = 0;
 	args->out_numargs = 1;
 	args->out_args[0].size = count;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c2f2a48156d6..a5714bae4c45 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -319,6 +319,8 @@ struct fuse_args {
 	uint32_t opcode;
 	uint8_t in_numargs;
 	uint8_t out_numargs;
+	/* The index of the variable lenght out arg */
+	uint8_t out_argvar_idx;
 	uint8_t ext_idx;
 	bool force:1;
 	bool noreply:1;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1babf56f254..8917e5b7a009 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1534,6 +1534,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	   with interface version < 7.5.  Rest of init_out is zeroed
 	   by do_get_request(), so a short reply is not a problem */
 	ia->args.out_argvar = true;
+	ia->args.out_argvar_idx = 0;
 	ia->args.out_args[0].size = sizeof(ia->out);
 	ia->args.out_args[0].value = &ia->out;
 	ia->args.force = true;
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f74..03a2b321e611 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -337,6 +337,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 	ap.args.out_args[1].size = out_size;
 	ap.args.out_pages = true;
 	ap.args.out_argvar = true;
+	ap.args.out_argvar_idx = 1;
 
 	transferred = fuse_send_ioctl(fm, &ap.args, &outarg);
 	err = transferred;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b2f6486fe1d5..26fb9c29f935 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -738,7 +738,7 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 		unsigned int argsize = args->out_args[i].size;
 
 		if (args->out_argvar &&
-		    i == args->out_numargs - 1 &&
+		    i == args->out_argvar_idx &&
 		    argsize > remaining) {
 			argsize = remaining;
 		}
@@ -746,13 +746,13 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 		memcpy(args->out_args[i].value, req->argbuf + offset, argsize);
 		offset += argsize;
 
-		if (i != args->out_numargs - 1)
+		if (i != args->out_argvar_idx)
 			remaining -= argsize;
 	}
 
 	/* Store the actual size of the variable-length arg */
 	if (args->out_argvar)
-		args->out_args[args->out_numargs - 1].size = remaining;
+		args->out_args[args->out_argvar_idx].size = remaining;
 
 	kfree(req->argbuf);
 	req->argbuf = NULL;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 93dfb06b6cea..f123446fe537 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -73,6 +73,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	args.out_numargs = 1;
 	if (size) {
 		args.out_argvar = true;
+		args.out_argvar_idx = 0;
 		args.out_args[0].size = size;
 		args.out_args[0].value = value;
 	} else {
@@ -135,6 +136,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	args.out_numargs = 1;
 	if (size) {
 		args.out_argvar = true;
+		args.out_argvar_idx = 0;
 		args.out_args[0].size = size;
 		args.out_args[0].value = list;
 	} else {

