Return-Path: <linux-fsdevel+bounces-78356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC+rGIjcnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:27:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9F19675A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96EB5303DF6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75839524D;
	Wed, 25 Feb 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="byGkzESl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07614393DCD;
	Wed, 25 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018721; cv=none; b=ReQOQtYapwZS8JkDlRHRZj536DbBJBgrvAYcG/aWXV3bAqfSuP0QzZiHpm6N2hJmOwhuzl3geqfbx8yCiNcY3ySCorV06y0PEAtcXfcNekitL47b0j796BQo4y1pJ7+qTTHIQzpjekD3ZU/RKuVOV48ZMWwWP1stdlZUPGuMgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018721; c=relaxed/simple;
	bh=dzyiJxL+0IciaVcFaUcwBHiLG2oPDsxQJvk/FQi1UrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXU/grLhNWWUMGcVxFp5YxK8VyZdl7G70FWqp5zs4+cw3vUdhb8SE3e+3AQWqvIFFIimg93SaW0gN0/f36fHECSTWq4Gl3AX8coxxJrufoCGPSjqpjS12raxTRGllndiTohbIYAt/eVPI9mWHXomMcbF83KOzpADmZLSVMIyAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=byGkzESl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+T9xNGkQlR6pAOOmLdTi86TC/esKS7VSnEOEMfQaXK0=; b=byGkzESlXYxD28tyleHXrVy22D
	02qPXjLFNhZjn5R64Dk1kBHXJZLhSsqOYI9p7GiPAyJq5mWO8KayVZM4rsupfsVJRsVUrO0xapPaM
	6Kt77SYD93d+mcgg5q+/2uVYE3jstEfCEtXHgYr1Zlb5Y030LBGo/YZoGONbLw+CIRCn5RyId0tDw
	m3OXrsUlB8qzUS/ZcV9F0DInFyE+lOM0fkUvlcG3c4Wiwk24N2bdQEP0Q/xTpVU+S/fJeiYGBPxUq
	7bOpsvc7Q4Z+j+Zufa5YMtEzh958LqEz5JuSiyT90evyvfEs1jj/gEngJiUq9/Ky6bPMKFsK37BuO
	w3NET8qA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0o-005CmM-1u; Wed, 25 Feb 2026 12:25:02 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 3/8] fuse: store index of the variable length argument
Date: Wed, 25 Feb 2026 11:24:34 +0000
Message-ID: <20260225112439.27276-4-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78356-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83F9F19675A
X-Rspamd-Action: no action

Operations that have a variable length argument assume that it will always
be the last argument on the list.  This patch allows this assumption to be
removed by keeping track of the index of variable length argument.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/compound.c  | 1 +
 fs/fuse/cuse.c      | 1 +
 fs/fuse/dev.c       | 4 ++--
 fs/fuse/dir.c       | 1 +
 fs/fuse/file.c      | 1 +
 fs/fuse/fuse_i.h    | 2 ++
 fs/fuse/inode.c     | 1 +
 fs/fuse/ioctl.c     | 1 +
 fs/fuse/virtio_fs.c | 6 +++---
 fs/fuse/xattr.c     | 2 ++
 10 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/compound.c b/fs/fuse/compound.c
index 1a85209f4e99..2dc024301aad 100644
--- a/fs/fuse/compound.c
+++ b/fs/fuse/compound.c
@@ -153,6 +153,7 @@ ssize_t fuse_compound_send(struct fuse_compound_req *compound)
 		.in_numargs = 2,
 		.out_numargs = 2,
 		.out_argvar = true,
+		.out_argvar_idx = 1,
 	};
 	unsigned int req_count = compound->compound_header.count;
 	size_t total_expected_out_size = 0;
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index dfcb98a654d8..3ce8ee9a4275 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -460,6 +460,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->args.out_args[0].value = &ia->out;
 	ap->args.out_args[1].size = CUSE_INIT_INFO_MAX;
 	ap->args.out_argvar = true;
+	ap->args.out_argvar_idx = 1;
 	ap->args.out_pages = true;
 	ap->num_folios = 1;
 	ap->folios = &ia->folio;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..5b02724f4377 100644
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
index f5eacea44896..a1121feb63ee 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1835,6 +1835,7 @@ static int fuse_readlink_folio(struct inode *inode, struct folio *folio)
 	ap.args.nodeid = get_node_id(inode);
 	ap.args.out_pages = true;
 	ap.args.out_argvar = true;
+	ap.args.out_argvar_idx = 0;
 	ap.args.page_zeroing = true;
 	ap.args.out_numargs = 1;
 	ap.args.out_args[0].size = desc.length;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 49c21498230d..1045d74dd95f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -682,6 +682,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
 	args->in_args[0].size = sizeof(ia->read.in);
 	args->in_args[0].value = &ia->read.in;
 	args->out_argvar = true;
+	args->out_argvar_idx = 0;
 	args->out_numargs = 1;
 	args->out_args[0].size = count;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 135027efec7a..04f09e2ccfd0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -331,6 +331,8 @@ struct fuse_args {
 	uint32_t opcode;
 	uint8_t in_numargs;
 	uint8_t out_numargs;
+	/* The index of the variable length out arg */
+	uint8_t out_argvar_idx;
 	uint8_t ext_idx;
 	bool force:1;
 	bool noreply:1;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8231c207abea..006436a3ad06 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1540,6 +1540,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 	   with interface version < 7.5.  Rest of init_out is zeroed
 	   by do_get_request(), so a short reply is not a problem */
 	ia->args.out_argvar = true;
+	ia->args.out_argvar_idx = 0;
 	ia->args.out_args[0].size = sizeof(ia->out);
 	ia->args.out_args[0].value = &ia->out;
 	ia->args.force = true;
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 07a02e47b2c3..7eb8d7a59edc 100644
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
index 057e65b51b99..dd681bc672b8 100644
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

