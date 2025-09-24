Return-Path: <linux-fsdevel+bounces-62656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78981B9B67C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F0E1BC24DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFC331AE3;
	Wed, 24 Sep 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFDc1nVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28A3314DA;
	Wed, 24 Sep 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737307; cv=none; b=PDMVkJAjCSq1asix0U7JOgO2mies6XE4Vg1pCvhI6nZTe/k4yY6BqX/GsR05MAOtVvfwqR/dgqFWcMxksjkjDwPJoXapz4lKkw/B8jzlxXbmcZlh5hu0L7d76URxS4yMjHUyzhy5cjLM5RUZVmDDsUNvEos+edt2oOIt04Lrz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737307; c=relaxed/simple;
	bh=DtZNjRY8tWag4AeCcEA1EOe4uspRGmv4nqK/ItwGPj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOD2YBm5L7gKX4NCiJrD0KNv6u/QWbppE05caGh9xonmOYilBQJm9TT9nOztllaGXF4Xc2LsdNH71FObH0lV9SNhzvnN+Nyx/JhUdGeeVS5xHjdbWvRzDOEl47RfhvE6rID0W1rpYIyTsCmO66FP3+CjTWO5UhE0Gq/d3aLmK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFDc1nVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF77BC4CEF4;
	Wed, 24 Sep 2025 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737307;
	bh=DtZNjRY8tWag4AeCcEA1EOe4uspRGmv4nqK/ItwGPj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WFDc1nVkBmwqQbbKuBTHa9ICj7hM4t5ur2SkXG6ru75jX0jQVcMxj/AgPuVMMKGEy
	 2e2HjPErIEW6nxS/iAo3MpbytrdYJ6WxEVU979kYsqA3aTTt9BO8F2XwkzN6jZyDbr
	 bgL0O9BvKoXENqUCBxfq+wV/RwdJRlmkzqEV/76LmsXUg5O+e2ZA9pX0C/B7/XUjKa
	 zw9eNtUJxz77wPV1w35thXB78U0EPjBXSO5hHO3xH+hd2g4ZWxoDF2v7b2CLX9C/jZ
	 DKpJ88YBI9T3i337zmP1uNdEngB9l6d/UeWURAkVozCUeUffjbjPKrcM+DZwxi8d7p
	 ZW6w0xTLZTYew==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:24 -0400
Subject: [PATCH v3 38/38] nfsd: add support to CB_NOTIFY for dir attribute
 changes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-38-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6207; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DtZNjRY8tWag4AeCcEA1EOe4uspRGmv4nqK/ItwGPj8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMSfXd0BviLX6qJkRP41buyrnysbMK9w9K9y
 DwJzGm/vqiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEgAKCRAADmhBGVaC
 FaohEACxZHqZnw2iDMwJ8kGClGhlhVaf+EtTzN7McVX+Xuk9SaC06uawNefNeqUzWTt5YiIst7F
 /YV+tYmhXx3W1QKWJPxKNQitRjdBY1OeMIeg9Hy5VL7BfBw/vUgHwhQUJTz4+C+yTSyzyRpXktS
 uLTR/u6zq7LpqqEiZtFukvMZwxRROdE0uFY8Zzh1Kl1Jly7qQCqn8iWvgzrX9najUu1vKF5kW/A
 D3/cEOdZP4QXkq8Ni9o1Un+UgfNFq1emlEtRoJymOqLTyOt3byQkzjcHD0T2iud0lPYv4UvZ+kF
 lZ/GU86lOQjm4RbDo3RetS9sbGZon2mWVTpWXCm9nY677MhoWZzT4jScPKU1irMQInLiVjZvyEw
 HP2YdNcBp+8kMSxyTnpkJVSjedJzGn6gKvviF1EAK2DsYp8PVq/XzqD4iMF/YPbAdg8QkGDuRNR
 hcMMDuNJEcDRud3ucnlFiORJfop9We1jUKs5ZPkUtgWJMPLhieyPpKoWQUAFyIi0VfB8wjmj66w
 vmyPM9ahJEXU6gsE2DRJEVZ17AKq7UIdn0rF0MeAfkotZ0bRvqaDy99BaEgMIuksM6ScAw4DPUR
 GBBJh3zoTgvvbB5WnSKzz4ukX8+uA//4jaO52qa5xnMlPY8iwVDzul2Bh1elK2xsdpuCuZcZ/sJ
 z644ReF32RAM3lg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the client requested dir attribute change notifications, send those
alongside any set of add/remove/rename events. Note that the server will
still recall the delegation on a SETATTR, so these are only sent for
changes to child entries.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++--
 fs/nfsd/nfs4xdr.c   | 60 +++++++++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/xdr4.h      |  1 +
 3 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2381dbb2e48290debf28bbd35d0b9a4bb677ac07..a411ffb5f208a2e4d9b55dd77226b4e1a24eaee2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3342,9 +3342,14 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	struct nfsd_notify_event *events[NOTIFY4_EVENT_QUEUE_SIZE];
 	struct xdr_buf xdr = { .buflen = PAGE_SIZE * NOTIFY4_PAGE_ARRAY_SIZE,
 			       .pages  = ncn->ncn_pages };
+	int limit = NOTIFY4_EVENT_QUEUE_SIZE;
 	struct xdr_stream stream;
-	int count, i;
 	bool error = false;
+	int count, i;
+
+	/* Save a slot for dir attr update if requested */
+	if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS))
+		--limit;
 
 	xdr_init_encode_pages(&stream, &xdr);
 
@@ -3358,7 +3363,7 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 	}
 
 	/* we can't keep up! */
-	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
+	if (count > limit) {
 		spin_unlock(&ncn->ncn_lock);
 		goto out_recall;
 	}
@@ -3396,6 +3401,22 @@ nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
 		nfsd_notify_event_put(nne);
 	}
 	if (!error) {
+		if (dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)) {
+			u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+
+			if (maskp) {
+				u8 *p = nfsd4_encode_dir_attr_change(&stream, dp);
+
+				if (p) {
+					*maskp = BIT(NOTIFY4_CHANGE_DIR_ATTRS);
+					ncn->ncn_nf[count].notify_mask.count = 1;
+					ncn->ncn_nf[count].notify_mask.element = maskp;
+					ncn->ncn_nf[count].notify_vals.data = p;
+					ncn->ncn_nf[count].notify_vals.len = (u8 *)stream.p - p;
+					++count;
+				}
+			}
+		}
 		ncn->ncn_nf_cnt = count;
 		return true;
 	}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0c411c758279177837c078d393048aaebf31d46f..eca2b483e28397166d24756fcc97b5a1e0fdb9aa 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3806,11 +3806,11 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 			  char *name, u32 namelen)
 {
 	struct nfs4_file *fi = dp->dl_stid.sc_file;
-	struct path path =  { .mnt = fi->fi_deleg_file->nf_file->f_path.mnt,
-			      .dentry = dentry };
+	struct path path = fi->fi_deleg_file->nf_file->f_path;
 	struct nfsd4_fattr_args args = { };
 	uint32_t *attrmask;
 	__be32 status;
+	bool parent;
 	int ret;
 
 	/* Reserve space for attrmask */
@@ -3822,6 +3822,9 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 	ne->ne_file.len = namelen;
 	ne->ne_attrs.attrmask.element = attrmask;
 
+	parent = (dentry == path.dentry);
+	path.dentry = dentry;
+
 	/* FIXME: d_find_alias for inode ? */
 	if (!path.dentry || !d_inode(path.dentry))
 		goto noattrs;
@@ -3837,15 +3840,20 @@ nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
 
 	args.change_attr = nfsd4_change_attribute(&args.stat);
 
-	attrmask[0] = dp->dl_child_attrs[0];
-	attrmask[1] = dp->dl_child_attrs[1];
-	attrmask[2] = 0;
+	if (parent) {
+		attrmask[0] = dp->dl_dir_attrs[0];
+		attrmask[1] = dp->dl_dir_attrs[1];
+	} else {
+		attrmask[0] = dp->dl_child_attrs[0];
+		attrmask[1] = dp->dl_child_attrs[1];
 
-	if (!setup_notify_fhandle(dentry, fi, &args))
-		attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
+		if (!setup_notify_fhandle(dentry, fi, &args))
+			attrmask[0] &= ~FATTR4_WORD0_FILEHANDLE;
 
-	if (!(args.stat.result_mask & STATX_BTIME))
-		attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+		if (!(args.stat.result_mask & STATX_BTIME))
+			attrmask[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	}
+	attrmask[2] = 0;
 
 	ne->ne_attrs.attrmask.count = 2;
 	ne->ne_attrs.attr_vals.data = (u8 *)xdr->p;
@@ -3936,6 +3944,40 @@ u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *
 	return NULL;
 }
 
+/**
+ * nfsd4_encode_dir_attr_change
+ * @xdr: stream to which to encode the fattr4
+ * @dp: delegation where the event occurred
+ *
+ * Encode a dir attr change event.
+ */
+u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation *dp)
+{
+	struct nfs4_file *fi = dp->dl_stid.sc_file;
+	struct dentry *dentry = fi->fi_deleg_file->nf_file->f_path.dentry;
+	struct notify_attr4 na = { };
+	struct name_snapshot n;
+	bool ret;
+	u8 *p = NULL;
+
+	if (!(dp->dl_notify_mask & BIT(NOTIFY4_CHANGE_DIR_ATTRS)))
+		return NULL;
+
+	take_dentry_name_snapshot(&n, dentry);
+	ret = nfsd4_setup_notify_entry4(&na.na_changed_entry, xdr,
+					dentry, dp, (char *)n.name.name,
+					n.name.len);
+
+	/* Don't bother with the event if we're not encoding attrs */
+	if (ret && na.na_changed_entry.ne_attrs.attr_vals.len) {
+		p = (u8 *)xdr->p;
+		if (!xdrgen_encode_notify_attr4(xdr, &na))
+			p = NULL;
+	}
+	release_dentry_name_snapshot(&n);
+	return p;
+}
+
 static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
 				struct xdr_buf *buf, __be32 *p, int bytes)
 {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 19f468b5bc54343dca928f0b8286c868f2133241..93a38b104fb425413f3d7a59fa029c760618559c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -969,6 +969,7 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 		u32 *bmval, struct svc_rqst *, int ignore_crossmnt);
 u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *nne,
 			      struct nfs4_delegation *dd, u32 *notify_mask);
+u8 *nfsd4_encode_dir_attr_change(struct xdr_stream *xdr, struct nfs4_delegation *dp);
 extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,

-- 
2.51.0


