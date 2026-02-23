Return-Path: <linux-fsdevel+bounces-78111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP5PMb/inGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:29:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1017F6E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B253131A0B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AE377572;
	Mon, 23 Feb 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLwR7Rcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4613635E;
	Mon, 23 Feb 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889122; cv=none; b=Qb8+tGLFm3PIgiE6lAjbajPHgyL6AI5YboVsM12bjlPNevaQjPcumQSHIaRISQPuNUThchjWKsd91d6QvUwmcM3gl/r5sR3OvGJHG/nKKIBv+bb5KLA7OEtcQqxefewbVNfL1PG2gpzqmdCX6u3rP26iu+lv6UaRiTnMsiQBmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889122; c=relaxed/simple;
	bh=o4dP82Bmj9Cr6O/epW1pyd7IkWwGrt8P+e01j/X8dTg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDDH+Hp/mjEdrorm4gK4B+MMsLGpQK2g2t2uhuCEOwwAGBvgOIFw+CYzm2worGOwuYMh7ZxZKrhONwk7hDMeqHSZkeUWjItwVHkHx7/PkYDkMuu5Uw9H+kH1UGrHik10/PzsO0j/EqhY2p8dz468konPGZkteKUGTE+Vvj43h2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLwR7Rcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3140EC116C6;
	Mon, 23 Feb 2026 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889122;
	bh=o4dP82Bmj9Cr6O/epW1pyd7IkWwGrt8P+e01j/X8dTg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QLwR7Rcg2v9YiefL0oPW9MCevUu2P6TRzGDld1sIsKrbGx2FbrZeXHlXS6xJ7PB5H
	 jtYZm1cSVqF6Ld2jn/0FCbDJ+N5bWOnK/gMzgaHbYjN+vsCn55vKPAK+HJlu7mRMbE
	 SieK1oMzBaKH1fNNNqACVqPTZ6U1SwJ/AiKwksZRyF0hhIFhXFDXwtbjCwyCBvoRSq
	 7PKVqND5n66swe+06le9iomIITkbHClP/LvZuuKjRGgdemTVmC4B4bcP+PNSWfPYhx
	 u1vm/W1a3U9hSm3n9htoOrDVVCBFlFpiXD6V3zcsUrhv/pWtVbIAyZbJjE0NAYCmHU
	 cUXbRxxfFLeLg==
Date: Mon, 23 Feb 2026 15:25:21 -0800
Subject: [PATCH 5/5] fuse: make fuse_inode opaque to iomap bpf programs
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, john@groves.net,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188736902.3938194.18133562552252830811.stgit@frogsfrogsfrogs>
In-Reply-To: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
References: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,groves.net,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78111-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72A1017F6E7
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Introduce an opaque type (and some casting helpers) for struct
fuse_inode.  This tricks BTF/BPF into thinking that the "inode" object
we pass to BPF programs is an empty structure, which means that the BPF
program cannot even look at the contents.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap_bpf.h |   41 ++++++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_iomap_bpf.c |   42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 14 deletions(-)


diff --git a/fs/fuse/fuse_iomap_bpf.h b/fs/fuse/fuse_iomap_bpf.h
index f6bfd2133bf2bb..148e8f1fa1d1fb 100644
--- a/fs/fuse/fuse_iomap_bpf.h
+++ b/fs/fuse/fuse_iomap_bpf.h
@@ -15,12 +15,47 @@ enum fuse_iomap_bpf_ret {
 	FIB_HANDLED = 1,
 };
 
+/* opaque structure so that bpf programs cannot see inside a fuse inode */
+struct fuse_bpf_inode { };
+
+static inline const struct fuse_inode *
+__fuse_inode_from_bpf_c(const struct fuse_bpf_inode *fbi)
+{
+	return (const struct fuse_inode *)fbi;
+}
+
+static inline struct fuse_inode *
+__fuse_inode_from_bpf(struct fuse_bpf_inode *fbi)
+{
+	return (struct fuse_inode *)fbi;
+}
+
+#define fuse_inode_from_bpf(x) _Generic((x), \
+	struct fuse_bpf_inode * :	__fuse_inode_from_bpf, \
+	const struct fuse_bpf_inode * :	__fuse_inode_from_bpf_c)(x)
+
+static inline const struct fuse_bpf_inode *
+__fuse_inode_to_bpf_c(const struct fuse_inode *fi)
+{
+	return (const struct fuse_bpf_inode *)fi;
+}
+
+static inline struct fuse_bpf_inode *
+__fuse_inode_to_bpf(struct fuse_inode *fi)
+{
+	return (struct fuse_bpf_inode *)fi;
+}
+
+#define fuse_inode_to_bpf(x) _Generic((x), \
+	struct fuse_inode * :		__fuse_inode_to_bpf, \
+	const struct fuse_inode * :	__fuse_inode_to_bpf_c)(x)
+
 struct fuse_iomap_bpf_ops {
 	/**
 	 * @iomap_begin: override iomap_begin.  See FUSE_IOMAP_BEGIN for
 	 * details.
 	 */
-	enum fuse_iomap_bpf_ret (*iomap_begin)(struct fuse_inode *fi,
+	enum fuse_iomap_bpf_ret (*iomap_begin)(struct fuse_bpf_inode *fbi,
 			uint64_t pos, uint64_t count, uint32_t opflags,
 			struct fuse_iomap_begin_out *outarg);
 
@@ -28,7 +63,7 @@ struct fuse_iomap_bpf_ops {
 	 * @iomap_end: override iomap_end.  See FUSE_IOMAP_END for
 	 * details.
 	 */
-	enum fuse_iomap_bpf_ret (*iomap_end)(struct fuse_inode *fi,
+	enum fuse_iomap_bpf_ret (*iomap_end)(struct fuse_bpf_inode *fbi,
 			uint64_t pos, uint64_t count, int64_t written,
 			uint32_t opflags);
 
@@ -36,7 +71,7 @@ struct fuse_iomap_bpf_ops {
 	 * @iomap_ioend: override iomap_ioend.  See FUSE_IOMAP_IOEND for
 	 * details.
 	 */
-	enum fuse_iomap_bpf_ret (*iomap_ioend)(struct fuse_inode *fi,
+	enum fuse_iomap_bpf_ret (*iomap_ioend)(struct fuse_bpf_inode *fbi,
 			uint64_t pos, int64_t written, uint32_t ioendflags,
 			int error, uint32_t dev, uint64_t new_addr,
 			struct fuse_iomap_ioend_out *outarg);
diff --git a/fs/fuse/fuse_iomap_bpf.c b/fs/fuse/fuse_iomap_bpf.c
index 71bfcddae7f5b7..6f183b6f7e975c 100644
--- a/fs/fuse/fuse_iomap_bpf.c
+++ b/fs/fuse/fuse_iomap_bpf.c
@@ -248,21 +248,21 @@ static void fuse_iomap_bpf_unreg(void *kdata, struct bpf_link *link)
 
 /* Dummy function stubs for control flow integrity hashes */
 static enum fuse_iomap_bpf_ret
-__iomap_begin(struct fuse_inode *fi, uint64_t pos, uint64_t count,
+__iomap_begin(struct fuse_bpf_inode *fbi, uint64_t pos, uint64_t count,
 	      uint32_t opflags, struct fuse_iomap_begin_out *outarg)
 {
 	return FIB_FALLBACK;
 }
 
 static enum fuse_iomap_bpf_ret
-__iomap_end(struct fuse_inode *fi, uint64_t pos, uint64_t count,
+__iomap_end(struct fuse_bpf_inode *fbi, uint64_t pos, uint64_t count,
 	    int64_t written, uint32_t opflags)
 {
 	return FIB_FALLBACK;
 }
 
 static enum fuse_iomap_bpf_ret
-__iomap_ioend(struct fuse_inode *fi, uint64_t pos, int64_t written,
+__iomap_ioend(struct fuse_bpf_inode *fbi, uint64_t pos, int64_t written,
 	      uint32_t ioendflags, int error, uint32_t dev, uint64_t new_addr,
 	      struct fuse_iomap_ioend_out *outarg)
 {
@@ -290,10 +290,11 @@ static struct bpf_struct_ops fuse_iomap_bpf_struct_ops = {
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int
-fuse_bpf_iomap_inval_mappings(struct fuse_inode *fi,
+fuse_bpf_iomap_inval_mappings(struct fuse_bpf_inode *fbi,
 			      const struct fuse_range *read__nullable,
 			      const struct fuse_range *write__nullable)
 {
+	struct fuse_inode *fi = fuse_inode_from_bpf(fbi);
 	struct fuse_iomap_inval_mappings_out outarg = {
 		.nodeid = fi->nodeid,
 		.attr_ino = fi->orig_ino,
@@ -315,10 +316,11 @@ fuse_bpf_iomap_inval_mappings(struct fuse_inode *fi,
 }
 
 __bpf_kfunc int
-fuse_bpf_iomap_upsert_mappings(struct fuse_inode *fi,
+fuse_bpf_iomap_upsert_mappings(struct fuse_bpf_inode *fbi,
 			       const struct fuse_iomap_io *read__nullable,
 			       const struct fuse_iomap_io *write__nullable)
 {
+	struct fuse_inode *fi = fuse_inode_from_bpf(fbi);
 	struct fuse_iomap_upsert_mappings_out outarg = {
 		.nodeid = fi->nodeid,
 		.attr_ino = fi->orig_ino,
@@ -341,6 +343,22 @@ fuse_bpf_iomap_upsert_mappings(struct fuse_inode *fi,
 	return fuse_iomap_upsert_inode(inode, &outarg);
 }
 
+__bpf_kfunc uint64_t
+fuse_bpf_inode_nodeid(const struct fuse_bpf_inode *fbi)
+{
+	const struct fuse_inode *fi = fuse_inode_from_bpf(fbi);
+
+	return fi->nodeid;
+}
+
+__bpf_kfunc uint64_t
+fuse_bpf_inode_orig_ino(const struct fuse_bpf_inode *fbi)
+{
+	const struct fuse_inode *fi = fuse_inode_from_bpf(fbi);
+
+	return fi->orig_ino;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(fuse_iomap_kfunc_ids)
@@ -348,6 +366,8 @@ BTF_ID_FLAGS(func, fuse_bpf_iomap_inval_mappings,
 	     KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, fuse_bpf_iomap_upsert_mappings,
 	     KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, fuse_bpf_inode_nodeid, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, fuse_bpf_inode_orig_ino, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(fuse_iomap_kfunc_ids)
 
 static const struct btf_kfunc_id_set fuse_iomap_kfunc_set = {
@@ -400,8 +420,8 @@ int fuse_iomap_begin_bpf(struct inode *inode,
 
 	trace_fuse_iomap_begin_bpf(inode);
 
-	ret = bpf_ops->iomap_begin(fi, inarg->pos, inarg->count,
-				   inarg->opflags, outarg);
+	ret = bpf_ops->iomap_begin(fuse_inode_to_bpf(fi), inarg->pos,
+				   inarg->count, inarg->opflags, outarg);
 	return bpf_to_errno(ret);
 }
 
@@ -418,7 +438,7 @@ int fuse_iomap_end_bpf(struct inode *inode,
 
 	trace_fuse_iomap_end_bpf(inode);
 
-	ret = bpf_ops->iomap_end(fi, inarg->pos, inarg->count,
+	ret = bpf_ops->iomap_end(fuse_inode_to_bpf(fi), inarg->pos, inarg->count,
 				 inarg->written, inarg->opflags);
 	return bpf_to_errno(ret);
 }
@@ -437,8 +457,8 @@ int fuse_iomap_ioend_bpf(struct inode *inode,
 
 	trace_fuse_iomap_ioend_bpf(inode);
 
-	ret = bpf_ops->iomap_ioend(fi, inarg->pos, inarg->written,
-				   inarg->flags, inarg->error, inarg->dev,
-				   inarg->new_addr, outarg);
+	ret = bpf_ops->iomap_ioend(fuse_inode_to_bpf(fi), inarg->pos,
+				   inarg->written, inarg->flags, inarg->error,
+				   inarg->dev, inarg->new_addr, outarg);
 	return bpf_to_errno(ret);
 }


