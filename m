Return-Path: <linux-fsdevel+bounces-78102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJeqBYnhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032D17F46F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 126EE3032665
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86F37F752;
	Mon, 23 Feb 2026 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svrzx6ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9537C11B;
	Mon, 23 Feb 2026 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888982; cv=none; b=dZQI77VrVb4JV1x9ye08kQSbE94Jj1x7q6B4ze5L1pJ0DNCDp079sdBmbDb1qarIZuTvw6NP6DeZpBfHGQcKMlUj8CxsmF+Tw+fz5vUaD8FdkCNHSeZBcPRyFq1wS8l25U7hDQ54Bc3SqUNVSoF4D3s0DzFfHe7jhSx1NMzxFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888982; c=relaxed/simple;
	bh=35yVX/eILJ0h0+PVhKzrBaQSarPOFuUoEzl6SNbp9oI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WltBIIFfc75PNRNydlnxGv6LtBEPNc/1fIK4dGnft/3W47b9F/aa/GQ8XD0RZOyHuz5q+MpE82+D+OgtL+CIOtNBuDU63XHmuZC1QVQIStlwEUifujTprUsXiqOLW7Xb9FRHUi2P3fKCBW0ciINIf4BoZwR3HW2QN0AiDkT7wqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svrzx6ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939ABC116C6;
	Mon, 23 Feb 2026 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888981;
	bh=35yVX/eILJ0h0+PVhKzrBaQSarPOFuUoEzl6SNbp9oI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=svrzx6ZSIhkeceMMPXLursmq1GIzMv5L9nqbNC4JVr9D/U4RTLpNk9h6jUOoRBngT
	 PhdGlRkH8vbiyRt/lWbFou8FXyuF0tq8CYRBQFuGtZKz7hgFfRZJPzWY3e3MVSmgfL
	 okKIM4uIFgb5uQseN0iIJzw2p1VH7rEeJMYDuAYnbsVYPyfoP7KrTEmDbyTxhJHYtl
	 W682v81uPnr+/BnFBLeaZ9Qyck1vTPdsS6AejVDKbZSFEnNyC0ED98AtJU1p+FUMah
	 R2brvvwW1VxIjAR6SsAtychs7Bh3jVdNL/4rF7Be+t30yMtDNyOeOitAcNTXpBykWp
	 l2N4HOobXYDsQ==
Date: Mon, 23 Feb 2026 15:23:01 -0800
Subject: [PATCH 10/12] fuse: constrain iomap mapping cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736241.3937557.11859724699615172303.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
References: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78102-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4032D17F46F
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Provide a means to constrain the size of each iomap mapping cache.
Most files (at least on XFS) don't have more than 1000 extents, so we'll
set the absolute maximum to 10000 and let the fuse server set a lower
limit if it so desires.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h           |    3 +++
 fs/fuse/fuse_iomap_cache.h |    8 ++++++++
 include/uapi/linux/fuse.h  |    7 ++++++-
 fs/fuse/fuse_iomap.c       |    9 ++++++++-
 fs/fuse/fuse_iomap_cache.c |   24 ++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f6725d699b3e26..5c10be0d02538e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -683,6 +683,9 @@ struct fuse_iomap_conn {
 
 	/* fuse server doesn't implement iomap_ioend */
 	unsigned int no_ioend:1;
+
+	/* maximum mapping cache size */
+	unsigned int cache_maxbytes;
 };
 #endif
 
diff --git a/fs/fuse/fuse_iomap_cache.h b/fs/fuse/fuse_iomap_cache.h
index eba90d9519b8c3..cb312b0720d6b7 100644
--- a/fs/fuse/fuse_iomap_cache.h
+++ b/fs/fuse/fuse_iomap_cache.h
@@ -108,6 +108,14 @@ static inline int fuse_iomap_cache_invalidate(struct inode *inode,
 	return fuse_iomap_cache_invalidate_range(inode, offset,
 						 FUSE_IOMAP_INVAL_TO_EOF);
 }
+
+/* absolute maximum memory consumption per iomap mapping cache */
+#define FUSE_IOMAP_CACHE_MAX_MAXBYTES		(SZ_2M)
+
+/* default maximum memory consumption per iomap mapping cache */
+#define FUSE_IOMAP_CACHE_DEFAULT_MAXBYTES	(SZ_256K)
+
+void fuse_iomap_cache_set_maxbytes(struct fuse_conn *fc, unsigned int maxbytes);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_CACHE_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 8c5e67731b21b8..035e1a59ce50d3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1512,7 +1512,9 @@ struct fuse_iomap_ioend_out {
 struct fuse_iomap_config_in {
 	uint64_t flags;		/* supported FUSE_IOMAP_CONFIG_* flags */
 	int64_t maxbytes;	/* maximum supported file size */
-	uint64_t padding[6];	/* zero */
+	uint32_t cache_maxbytes; /* mapping cache maxbytes */
+	uint32_t zero;		/* zero */
+	uint64_t padding[5];	/* zero */
 };
 
 /* Which fields are set in fuse_iomap_config_out? */
@@ -1522,6 +1524,7 @@ struct fuse_iomap_config_in {
 #define FUSE_IOMAP_CONFIG_MAX_LINKS	(1 << 3ULL)
 #define FUSE_IOMAP_CONFIG_TIME		(1 << 4ULL)
 #define FUSE_IOMAP_CONFIG_MAXBYTES	(1 << 5ULL)
+#define FUSE_IOMAP_CONFIG_CACHE_MAXBYTES (1 << 6ULL)
 
 struct fuse_iomap_config_out {
 	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
@@ -1544,6 +1547,8 @@ struct fuse_iomap_config_out {
 	int64_t s_time_max;
 
 	int64_t s_maxbytes;	/* max file size */
+
+	uint32_t cache_maxbytes; /* mapping cache maximum size */
 };
 
 struct fuse_range {
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 2e428b6e6b0ce6..8fad9278293bff 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1141,7 +1141,8 @@ struct fuse_iomap_config_args {
 			       FUSE_IOMAP_CONFIG_BLOCKSIZE | \
 			       FUSE_IOMAP_CONFIG_MAX_LINKS | \
 			       FUSE_IOMAP_CONFIG_TIME | \
-			       FUSE_IOMAP_CONFIG_MAXBYTES)
+			       FUSE_IOMAP_CONFIG_MAXBYTES | \
+			       FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
 
 static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 				     const struct fuse_iomap_config_out *outarg)
@@ -1206,6 +1207,9 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
 	if (outarg->flags & FUSE_IOMAP_CONFIG_MAXBYTES)
 		sb->s_maxbytes = outarg->s_maxbytes;
 
+	if (outarg->flags & FUSE_IOMAP_CONFIG_CACHE_MAXBYTES)
+		fuse_iomap_cache_set_maxbytes(fm->fc, outarg->cache_maxbytes);
+
 	return 0;
 }
 
@@ -1267,6 +1271,9 @@ fuse_iomap_new_mount(struct fuse_mount *fm)
 	ia->inarg.maxbytes = MAX_LFS_FILESIZE;
 	ia->inarg.flags = FUSE_IOMAP_CONFIG_ALL;
 
+	fm->fc->iomap_conn.cache_maxbytes = FUSE_IOMAP_CACHE_DEFAULT_MAXBYTES;
+	ia->inarg.cache_maxbytes = fm->fc->iomap_conn.cache_maxbytes;
+
 	ia->args.opcode = FUSE_IOMAP_CONFIG;
 	ia->args.nodeid = 0;
 	ia->args.in_numargs = 1;
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index 277311c7c0c4ea..b9e6083a18ce63 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1654,6 +1654,28 @@ void fuse_iomap_cache_free(struct inode *inode)
 	kfree(ic);
 }
 
+void fuse_iomap_cache_set_maxbytes(struct fuse_conn *fc, unsigned int maxbytes)
+{
+	if (!maxbytes)
+		return;
+
+	fc->iomap_conn.cache_maxbytes = clamp(maxbytes, NODE_SIZE,
+					      FUSE_IOMAP_CACHE_MAX_MAXBYTES);
+}
+
+static void
+fuse_iomap_cache_cleanup(
+	struct inode		*inode,
+	enum fuse_iomap_iodir	iodir)
+{
+	struct fuse_inode	*fi = get_fuse_inode(inode);
+	struct fuse_mount	*fm = get_fuse_mount(inode);
+	struct fuse_iext_root	*ir = fuse_iext_root_ptr(fi->cache, iodir);
+
+	if (ir && ir->ir_bytes > fm->fc->iomap_conn.cache_maxbytes)
+		fuse_iext_destroy(ir);
+}
+
 int
 fuse_iomap_cache_upsert(
 	struct inode			*inode,
@@ -1680,6 +1702,8 @@ fuse_iomap_cache_upsert(
 	if (err)
 		return err;
 
+	fuse_iomap_cache_cleanup(inode, iodir);
+
 	return fuse_iomap_cache_add(inode, iodir, map);
 }
 


