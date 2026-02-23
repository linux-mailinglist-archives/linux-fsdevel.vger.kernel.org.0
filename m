Return-Path: <linux-fsdevel+bounces-78122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P+/IZ/inGnrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778D17F6B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E954B3035E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4237F8A9;
	Mon, 23 Feb 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRMQPrXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6E37F753;
	Mon, 23 Feb 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889294; cv=none; b=di9rujZsWs4DS20Yue0297hssavF7SRuywdfMAHvzsX4UXnNoE4wqCSNJ7m09jvrkvYIu3SchghS6QEpknkn54CdURPl5b8+J/bnr1LXuqiTeuERfI8XpCcHylKD61R86grmA2Fp1iNS6upKq5YfNETM/oAjVyaH6ZC+D1njGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889294; c=relaxed/simple;
	bh=9xHOnZtcxGJRs88hmkWENgnvH1jmMTxEKMbPj8gc1Ho=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyYtEk8Mh6X2j+OUeg+jjzZrzVVwALuLWVLnneMw6IXJWB4tIvvxwd38qruw2Xila3zHTr2SG2sdHdXNTO3YRsaTD2HGZom27tntArqsnt793CQCB/6KWHf/w8gQcRJ6wrfWTZNyX9oF+wLrisiQQLTCXVEJ/WykmuIoO+So6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRMQPrXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11967C116C6;
	Mon, 23 Feb 2026 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889294;
	bh=9xHOnZtcxGJRs88hmkWENgnvH1jmMTxEKMbPj8gc1Ho=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gRMQPrXthpNA7i6tcrLnsAH5VulJVkEm+CPaA+em5ijg0fJQ1UH56LMX/xc/1dWpb
	 xUGyMvDPVN8y2WZvDr/xq5hfHFXnaSO28/DFf4Smt+cX6g1GuyiN5bvC/OxfujVlwC
	 62teB4sHeXWd5RBtfxmPBBt9xbXKTSioAYHt4qBHuB+u1ID8lJnE414Mkj0rKSVNRa
	 ues5ykWTJwwTlcbTsNcrDKEgOWSx/JkamM/lCw5469KlUZ/J10K/TUpRrNk8Mpy2HO
	 wsocU8dQGKAFQ2RBqHw0UfUND1GPQWB8yLtgjkq4NP4iPr8U2j67SAMnOzj6FdJGeH
	 f+OLVckt1HF9A==
Date: Mon, 23 Feb 2026 15:28:13 -0800
Subject: [PATCH 11/25] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740132.3940670.11770294463445311195.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78122-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4778D17F6B2
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create a new ->getattr_iflags function so that iomap filesystems can set
the appropriate in-kernel inode flags on instantiation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h |    7 ++
 lib/fuse.c     |  191 ++++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 151 insertions(+), 47 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index dc4b79e98f6cd0..0db5f7e961d8fa 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -911,6 +911,13 @@ struct fuse_operations {
 			    uint64_t written_in, uint32_t ioendflags_in,
 			    int error_in, uint32_t dev_in,
 			    uint64_t new_addr_in, off_t *newsize);
+
+	/**
+	 * Get file attributes and FUSE_IFLAG_* flags.  Otherwise the same as
+	 * getattr.
+	 */
+	int (*getattr_iflags) (const char *path, struct stat *buf,
+			       unsigned int *iflags, struct fuse_file_info *fi);
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/lib/fuse.c b/lib/fuse.c
index 8d6d1686fc733c..78812b66c05106 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -123,6 +123,7 @@ struct fuse {
 	struct list_head partial_slabs;
 	struct list_head full_slabs;
 	pthread_t prune_thread;
+	bool want_iflags;
 };
 
 struct lock {
@@ -144,6 +145,7 @@ struct node {
 	char *name;
 	uint64_t nlookup;
 	int open_count;
+	unsigned int iflags;
 	struct timespec stat_updated;
 	struct timespec mtime;
 	off_t size;
@@ -1628,6 +1630,24 @@ int fuse_fs_getattr(struct fuse_fs *fs, const char *path, struct stat *buf,
 	return fs->op.getattr(path, buf, fi);
 }
 
+static int fuse_fs_getattr_iflags(struct fuse_fs *fs, const char *path,
+				  struct stat *buf, unsigned int *iflags,
+				  struct fuse_file_info *fi)
+{
+	fuse_get_context()->private_data = fs->user_data;
+	if (!fs->op.getattr_iflags)
+		return -ENOSYS;
+
+	if (fs->debug) {
+		char buf[10];
+
+		fuse_log(FUSE_LOG_DEBUG, "getattr_iflags[%s] %s\n",
+			file_info_string(fi, buf, sizeof(buf)),
+			path);
+	}
+	return fs->op.getattr_iflags(path, buf, iflags, fi);
+}
+
 int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath,
 		   const char *newpath, unsigned int flags)
 {
@@ -2484,7 +2504,7 @@ static void update_stat(struct node *node, const struct stat *stbuf)
 }
 
 static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
-		     struct fuse_entry_param *e)
+		     struct fuse_entry_param *e, unsigned int *iflags)
 {
 	struct node *node;
 
@@ -2502,25 +2522,64 @@ static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name,
 		pthread_mutex_unlock(&f->lock);
 	}
 	set_stat(f, e->ino, &e->attr);
+	*iflags = node->iflags;
 	return 0;
 }
 
+static int lookup_and_update(struct fuse *f, fuse_ino_t nodeid,
+			     const char *name, struct fuse_entry_param *e,
+			     unsigned int iflags)
+{
+	struct node *node;
+
+	node = find_node(f, nodeid, name);
+	if (node == NULL)
+		return -ENOMEM;
+
+	e->ino = node->nodeid;
+	e->generation = node->generation;
+	e->entry_timeout = f->conf.entry_timeout;
+	e->attr_timeout = f->conf.attr_timeout;
+	if (f->conf.auto_cache) {
+		pthread_mutex_lock(&f->lock);
+		update_stat(node, &e->attr);
+		pthread_mutex_unlock(&f->lock);
+	}
+	set_stat(f, e->ino, &e->attr);
+	node->iflags = iflags;
+	return 0;
+}
+
+static int getattr(struct fuse *f, const char *path, struct stat *buf,
+		   unsigned int *iflags, struct fuse_file_info *fi)
+{
+	if (f->want_iflags)
+		return fuse_fs_getattr_iflags(f->fs, path, buf, iflags, fi);
+	return fuse_fs_getattr(f->fs, path, buf, fi);
+}
+
 static int lookup_path(struct fuse *f, fuse_ino_t nodeid,
 		       const char *name, const char *path,
-		       struct fuse_entry_param *e, struct fuse_file_info *fi)
+		       struct fuse_entry_param *e, unsigned int *iflags,
+		       struct fuse_file_info *fi)
 {
 	int res;
 
 	memset(e, 0, sizeof(struct fuse_entry_param));
-	res = fuse_fs_getattr(f->fs, path, &e->attr, fi);
-	if (res == 0) {
-		res = do_lookup(f, nodeid, name, e);
-		if (res == 0 && f->conf.debug) {
-			fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu\n",
-				(unsigned long long) e->ino);
-		}
-	}
-	return res;
+	*iflags = 0;
+	res = getattr(f, path, &e->attr, iflags, fi);
+	if (res)
+		return res;
+
+	res = lookup_and_update(f, nodeid, name, e, *iflags);
+	if (res)
+		return res;
+
+	if (f->conf.debug)
+		fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu iflags 0x%x\n",
+			(unsigned long long) e->ino, *iflags);
+
+	return 0;
 }
 
 static struct fuse_context_i *fuse_get_context_internal(void)
@@ -2604,11 +2663,14 @@ static inline void reply_err(fuse_req_t req, int err)
 }
 
 static void reply_entry(fuse_req_t req, const struct fuse_entry_param *e,
-			int err)
+			unsigned int iflags, int err)
 {
 	if (!err) {
 		struct fuse *f = req_fuse(req);
-		if (fuse_reply_entry(req, e) == -ENOENT) {
+		int entry_res;
+
+		entry_res = fuse_reply_entry_iflags(req, e, iflags);
+		if (entry_res == -ENOENT) {
 			/* Skip forget for negative result */
 			if  (e->ino != 0)
 				forget_node(f, e->ino, 1);
@@ -2649,6 +2711,9 @@ static void fuse_lib_init(void *data, struct fuse_conn_info *conn)
 		/* Disable the receiving and processing of FUSE_INTERRUPT requests */
 		conn->no_interrupt = 1;
 	}
+
+	if (conn->want_ext & FUSE_CAP_IOMAP)
+		f->want_iflags = true;
 }
 
 void fuse_fs_destroy(struct fuse_fs *fs)
@@ -2672,6 +2737,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e = { .ino = 0 }; /* invalid ino */
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 	struct node *dot = NULL;
 
@@ -2686,7 +2752,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 				dot = get_node_nocheck(f, parent);
 				if (dot == NULL) {
 					pthread_mutex_unlock(&f->lock);
-					reply_entry(req, &e, -ESTALE);
+					reply_entry(req, &e, -ESTALE, 0);
 					return;
 				}
 				dot->refctr++;
@@ -2706,7 +2772,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		if (f->conf.debug)
 			fuse_log(FUSE_LOG_DEBUG, "LOOKUP %s\n", path);
 		fuse_prepare_interrupt(f, req, &d);
-		err = lookup_path(f, parent, name, path, &e, NULL);
+		err = lookup_path(f, parent, name, path, &e, &iflags, NULL);
 		if (err == -ENOENT && f->conf.negative_timeout != 0.0) {
 			e.ino = 0;
 			e.entry_timeout = f->conf.negative_timeout;
@@ -2720,7 +2786,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_ino_t parent,
 		unref_node(f, dot);
 		pthread_mutex_unlock(&f->lock);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void do_forget(struct fuse *f, fuse_ino_t ino, uint64_t nlookup)
@@ -2756,6 +2822,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2767,7 +2834,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 	if (!err) {
 		struct fuse_intr_data d;
 		fuse_prepare_interrupt(f, req, &d);
-		err = fuse_fs_getattr(f->fs, path, &buf, fi);
+		err = getattr(f, path, &buf, &iflags, fi);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
@@ -2780,9 +2847,11 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_ino_t ino,
 			buf.st_nlink--;
 		if (f->conf.auto_cache)
 			update_stat(node, &buf);
+		node->iflags = iflags;
 		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		fuse_reply_attr_iflags(req, &buf, iflags,
+				       f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -2891,6 +2960,7 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 	struct fuse *f = req_fuse_prepare(req);
 	struct stat buf;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	memset(&buf, 0, sizeof(buf));
@@ -2949,19 +3019,23 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			err = fuse_fs_utimens(f->fs, path, tv, fi);
 		}
 		if (!err) {
-			err = fuse_fs_getattr(f->fs, path, &buf, fi);
+			err = getattr(f, path, &buf, &iflags, fi);
 		}
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, ino, path);
 	}
 	if (!err) {
-		if (f->conf.auto_cache) {
-			pthread_mutex_lock(&f->lock);
-			update_stat(get_node(f, ino), &buf);
-			pthread_mutex_unlock(&f->lock);
-		}
+		struct node *node;
+
+		pthread_mutex_lock(&f->lock);
+		node = get_node(f, ino);
+		if (f->conf.auto_cache)
+			update_stat(node, &buf);
+		node->iflags = iflags;
+		pthread_mutex_unlock(&f->lock);
 		set_stat(f, ino, &buf);
-		fuse_reply_attr(req, &buf, f->conf.attr_timeout);
+		fuse_reply_attr_iflags(req, &buf, iflags,
+				       f->conf.attr_timeout);
 	} else
 		reply_err(req, err);
 }
@@ -3012,6 +3086,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3028,7 +3103,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_create(f->fs, path, mode, &fi);
 			if (!err) {
 				err = lookup_path(f, parent, name, path, &e,
-						  &fi);
+						  &iflags, &fi);
 				fuse_fs_release(f->fs, path, &fi);
 			}
 		}
@@ -3036,12 +3111,12 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
 			err = fuse_fs_mknod(f->fs, path, mode, rdev);
 			if (!err)
 				err = lookup_path(f, parent, name, path, &e,
-						  NULL);
+						  &iflags, NULL);
 		}
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -3050,6 +3125,7 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3059,11 +3135,12 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_mkdir(f->fs, path, mode);
 		if (!err)
-			err = lookup_path(f, parent, name, path, &e, NULL);
+			err = lookup_path(f, parent, name, path, &e, &iflags,
+					  NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_unlink(fuse_req_t req, fuse_ino_t parent,
@@ -3133,6 +3210,7 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 	struct fuse *f = req_fuse_prepare(req);
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3142,11 +3220,12 @@ static void fuse_lib_symlink(fuse_req_t req, const char *linkname,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_symlink(f->fs, linkname, path);
 		if (!err)
-			err = lookup_path(f, parent, name, path, &e, NULL);
+			err = lookup_path(f, parent, name, path, &e, &iflags,
+					  NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path(f, parent, path);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
@@ -3194,6 +3273,7 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 	struct fuse_entry_param e;
 	char *oldpath;
 	char *newpath;
+	unsigned int iflags = 0;
 	int err;
 
 	err = get_path2(f, ino, NULL, newparent, newname,
@@ -3205,11 +3285,11 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
 		err = fuse_fs_link(f->fs, oldpath, newpath);
 		if (!err)
 			err = lookup_path(f, newparent, newname, newpath,
-					  &e, NULL);
+					  &e, &iflags, NULL);
 		fuse_finish_interrupt(f, req, &d);
 		free_path2(f, ino, newparent, NULL, NULL, oldpath, newpath);
 	}
-	reply_entry(req, &e, err);
+	reply_entry(req, &e, iflags, err);
 }
 
 static void fuse_do_release(struct fuse *f, fuse_ino_t ino, const char *path,
@@ -3252,6 +3332,7 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 	struct fuse_intr_data d;
 	struct fuse_entry_param e;
 	char *path;
+	unsigned int iflags;
 	int err;
 
 	err = get_path_name(f, parent, name, &path);
@@ -3259,7 +3340,8 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_prepare_interrupt(f, req, &d);
 		err = fuse_fs_create(f->fs, path, mode, fi);
 		if (!err) {
-			err = lookup_path(f, parent, name, path, &e, fi);
+			err = lookup_path(f, parent, name, path, &e,
+					  &iflags, fi);
 			if (err)
 				fuse_fs_release(f->fs, path, fi);
 			else if (!S_ISREG(e.attr.st_mode)) {
@@ -3279,10 +3361,14 @@ static void fuse_lib_create(fuse_req_t req, fuse_ino_t parent,
 		fuse_finish_interrupt(f, req, &d);
 	}
 	if (!err) {
+		int create_res;
+
 		pthread_mutex_lock(&f->lock);
 		get_node(f, e.ino)->open_count++;
 		pthread_mutex_unlock(&f->lock);
-		if (fuse_reply_create(req, &e, fi) == -ENOENT) {
+
+		create_res = fuse_reply_create_iflags(req, &e, iflags, fi);
+		if (create_res == -ENOENT) {
 			/* The open syscall was interrupted, so it
 			   must be cancelled */
 			fuse_do_release(f, e.ino, path, fi);
@@ -3316,13 +3402,16 @@ static void open_auto_cache(struct fuse *f, fuse_ino_t ino, const char *path,
 		if (diff_timespec(&now, &node->stat_updated) >
 		    f->conf.ac_attr_timeout) {
 			struct stat stbuf;
+			unsigned int iflags = 0;
 			int err;
+
 			pthread_mutex_unlock(&f->lock);
-			err = fuse_fs_getattr(f->fs, path, &stbuf, fi);
+			err = getattr(f, path, &stbuf, &iflags, fi);
 			pthread_mutex_lock(&f->lock);
-			if (!err)
+			if (!err) {
 				update_stat(node, &stbuf);
-			else
+				node->iflags = iflags;
+			} else
 				node->cache_valid = 0;
 		}
 	}
@@ -3651,6 +3740,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 		.ino = 0,
 	};
 	struct fuse *f = dh->fuse;
+	unsigned int iflags = 0;
 	int res;
 
 	if ((flags & ~FUSE_FILL_DIR_PLUS) != 0) {
@@ -3675,6 +3765,7 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 	if (off) {
 		size_t newlen;
+		size_t thislen;
 
 		if (dh->filled) {
 			dh->error = -EIO;
@@ -3690,7 +3781,8 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 
 		if (statp && (flags & FUSE_FILL_DIR_PLUS)) {
 			if (!is_dot_or_dotdot(name)) {
-				res = do_lookup(f, dh->nodeid, name, &e);
+				res = do_lookup(f, dh->nodeid, name, &e,
+						&iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
@@ -3698,10 +3790,12 @@ static int fill_dir_plus(void *dh_, const char *name, const struct stat *statp,
 			}
 		}
 
-		newlen = dh->len +
-			fuse_add_direntry_plus(dh->req, dh->contents + dh->len,
-					       dh->needlen - dh->len, name,
-					       &e, off);
+		thislen = fuse_add_direntry_plus_iflags(dh->req,
+							dh->contents + dh->len,
+							dh->needlen - dh->len,
+							name, iflags, &e, off);
+		newlen = dh->len + thislen;
+
 		if (newlen > dh->needlen)
 			return 1;
 		dh->len = newlen;
@@ -3788,6 +3882,7 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 		unsigned rem = dh->needlen - dh->len;
 		unsigned thislen;
 		unsigned newlen;
+		unsigned int iflags = 0;
 		pos++;
 
 		if (flags & FUSE_READDIR_PLUS) {
@@ -3799,15 +3894,17 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
 			if (de->flags & FUSE_FILL_DIR_PLUS &&
 			    !is_dot_or_dotdot(de->name)) {
 				res = do_lookup(dh->fuse, dh->nodeid,
-						de->name, &e);
+						de->name, &e, &iflags);
 				if (res) {
 					dh->error = res;
 					return 1;
 				}
 			}
 
-			thislen = fuse_add_direntry_plus(req, p, rem,
-							 de->name, &e, pos);
+			thislen = fuse_add_direntry_plus_iflags(req, p, rem,
+								de->name,
+								iflags, &e,
+								pos);
 		} else {
 			thislen = fuse_add_direntry(req, p, rem,
 						    de->name, &de->stat, pos);


