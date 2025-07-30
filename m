Return-Path: <linux-fsdevel+bounces-56340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2EB16180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5071E3B806F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85232BD582;
	Wed, 30 Jul 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7OGUU0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269362BCF4C;
	Wed, 30 Jul 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881911; cv=none; b=AhVF+BCE/1OmlADXrQcXJEY63+Y2DfuT6ZVSNvvP9LbmlMB4xi0RYuxzVkHP12jzP7zzZrCSH93AwaEQ1xOJe0fCTN/7PuH4nwpFPttIOLhx7gdIF+Ql2RZCEAHRLXWzIpqIy1DJLL6+oDrAnreNn67wye6B+gVRBwEdMgvvEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881911; c=relaxed/simple;
	bh=ISrKgET4NpOpfmn2MuleOE6e3bVTq1FJQoGUMNqYgbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU2IS8wc4mkJ2jo4oeA6EkDquAVowAJgbVq1nFswiqA7JDfOOYVVXKr6ApxMyxpf7c/62N6KcdGyHMolsHBQTwOGunlrKiV/ahwX6BWQZeEPLDDeFrGK5w+dacS2HAF3nbFYJ33Pi9NS8qxexa4ATIKIYdYXfeaTiUsbQvkWc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7OGUU0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3CC4CEEB;
	Wed, 30 Jul 2025 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881910;
	bh=ISrKgET4NpOpfmn2MuleOE6e3bVTq1FJQoGUMNqYgbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q7OGUU0YCM7FQooxSQnK8TNOzYrCpPhclF7yDGTPaE0J2z1kKIqjWmu5F6zSduMcY
	 875L1xKa4WEcw71D7wrlCIh6fTTY/5bHuywkhhtJ5BXzzq3DHOooAYu5dq/m4t/6b/
	 aT3sDWX9TLWw6kPSkmOjMYthVsVso4gStMnvq5ZJfEI8vJRwQRitpXfS77ZawMmU+q
	 eBdUE/5l6s+0xQgbC7P65tKkA/1ntFau0xI3ieytM7Y7F8GGkopgO4T4zkkpsE/i24
	 TL1VxRbnuCYi/eikzEfcMBZbeJU9WjGaNDAl5hSpKPDSeZ0nFIQFCj2t8p3kiKhI7o
	 2TSQwJr5lWVhA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:37 -0400
Subject: [PATCH v4 8/8] nfsd: freeze c/mtime updates with outstanding
 WRITE_ATTRS delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6819; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ISrKgET4NpOpfmn2MuleOE6e3bVTq1FJQoGUMNqYgbE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0og1N698dK6ZFCVZt672W1JKoOllLpqXl1V
 +AgdaXj79OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodKAAKCRAADmhBGVaC
 Fbx3D/0VyweYADN22GxHgVNSPqY+dlvRP3/doTFl7Eyd88Yz+DDqX9pU4Uj2MgW5C/OzRL7A+2r
 GyGVIMZeFvo90iXmU26vVN782zXyD7TclC3rHV3i5aIlcHOQ6nJGkZFuTPkIcXOIo3kP0bFB712
 /3G8XkfQVYVKWaPp1jMaBD1r82FzqhVjaFWlN7M4lwDxwM63ccW1DJqyyTKqw/TsdAMSDrn+r4J
 N5j6/7U6icJiFTBC8mDFD8at9oFeVUA4hJYrs8QTiXmpVhRAoj+u9YdlepWveMl27hBF3zBJJ3x
 4o1gle+2hLBgWaVyd0XWUZ9MNNCEDy3crmAow9bnnQtHWPcXqOfQjtP4YXGy68dYf5hEBlcXqdk
 RZjeyLZVXOYDdP3gI7xhlsnW1/+bk24Cdx/eOVPkRm49Frohhk94VgTQZTq7DoPYxolSUEPSaTe
 MfCTz6OFZfbtNmQ0ZOUH2tH+zB/nmSTdukl8/k9CE9aJj0U9iK4kLo1ZQzXzsMIjQ+1cuHhl/qI
 nvcoMgAvZrolivt0yW2eyIS9z2LAQ9GdjlfuyRMPb7Mut7EiWpoe4grUgXZ2GMKzNSPTx4V3K++
 VOQa0t17+PzxID9GcndbZ0SoIEtaEOsVdOQlR2G7FJaaj/EiwnSEULaPQwVD9mN+T7Nr9ZRt0rX
 xCn6atRaeK/v3Fw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Instead of allowing the ctime to roll backward with a WRITE_ATTRS
delegation, set FMODE_NOCMTIME on the file and have it skip mtime and
ctime updates.

It is possible that the client will never send a SETATTR to set the
times before returning the delegation. Add two new bools to struct
nfs4_delegation:

dl_written: tracks whether the file has been written since the
delegation was granted. This is set in the WRITE and LAYOUTCOMMIT
handlers.

dl_setattr: tracks whether the client has sent at least one valid
mtime that can also update the ctime in a SETATTR.

When unlocking the lease for the delegation, clear FMODE_NOCMTIME. If
the file has been written, but no setattr for the delegated mtime and
ctime has been done, update the timestamps to current_time().

Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 26 ++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h     |  4 +++-
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index aacd912a5fbe29ba5ccac206d13243308f36b7fa..bfebe6e25638a76d3607bb79a239bdc92e42e7b5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1151,7 +1151,9 @@ vet_deleg_attrs(struct nfsd4_setattr *setattr, struct nfs4_delegation *dp)
 	if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
 		if (nfsd4_vet_deleg_time(&iattr->ia_mtime, &dp->dl_mtime, &now)) {
 			iattr->ia_ctime = iattr->ia_mtime;
-			if (!nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->dl_ctime, &now))
+			if (nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->dl_ctime, &now))
+				dp->dl_setattr = true;
+			else
 				iattr->ia_valid &= ~(ATTR_CTIME | ATTR_CTIME_SET);
 		} else {
 			iattr->ia_valid &= ~(ATTR_CTIME | ATTR_CTIME_SET |
@@ -1238,12 +1240,26 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
+static void nfsd4_file_mark_deleg_written(struct nfs4_file *fi)
+{
+	spin_lock(&fi->fi_lock);
+	if (!list_empty(&fi->fi_delegations)) {
+		struct nfs4_delegation *dp = list_first_entry(&fi->fi_delegations,
+							      struct nfs4_delegation, dl_perfile);
+
+		if (dp->dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG)
+			dp->dl_written = true;
+	}
+	spin_unlock(&fi->fi_lock);
+}
+
 static __be32
 nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	    union nfsd4_op_u *u)
 {
 	struct nfsd4_write *write = &u->write;
 	stateid_t *stateid = &write->wr_stateid;
+	struct nfs4_stid *stid = NULL;
 	struct nfsd_file *nf = NULL;
 	__be32 status = nfs_ok;
 	unsigned long cnt;
@@ -1256,10 +1272,15 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-						stateid, WR_STATE, &nf, NULL);
+						stateid, WR_STATE, &nf, &stid);
 	if (status)
 		return status;
 
+	if (stid) {
+		nfsd4_file_mark_deleg_written(stid->sc_file);
+		nfs4_put_stid(stid);
+	}
+
 	write->wr_how_written = write->wr_stable_how;
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, &write->wr_payload,
@@ -2550,6 +2571,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	mutex_unlock(&ls->ls_mutex);
 
 	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
+	nfsd4_file_mark_deleg_written(ls->ls_stid.sc_file);
 	nfs4_put_stid(&ls->ls_stid);
 out:
 	return nfserr;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 205ee8cc6fa2b9f74d08f7938b323d03bdf8286c..81fa7cc6c77b3cdc5ff22bc60ab0654f95dc258d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1222,6 +1222,42 @@ static void put_deleg_file(struct nfs4_file *fp)
 		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
 }
 
+static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
+{
+	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME };
+	struct inode *inode = file_inode(f);
+	int ret;
+
+	/* don't do anything if FMODE_NOCMTIME isn't set */
+	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) == 0)
+		return;
+
+	spin_lock(&f->f_lock);
+	f->f_mode &= ~FMODE_NOCMTIME;
+	spin_unlock(&f->f_lock);
+
+	/* was it never written? */
+	if (!dp->dl_written)
+		return;
+
+	/* did it get a setattr for the timestamps at some point? */
+	if (dp->dl_setattr)
+		return;
+
+	/* Stamp everything to "now" */
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
+	inode_unlock(inode);
+	if (ret) {
+		struct inode *inode = file_inode(f);
+
+		pr_notice_ratelimited("Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
+					MAJOR(inode->i_sb->s_dev),
+					MINOR(inode->i_sb->s_dev),
+					inode->i_ino, ret);
+	}
+}
+
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
@@ -1229,6 +1265,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
+	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
@@ -6265,6 +6302,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		struct file *f = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+
 		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
 				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -6278,6 +6317,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		dp->dl_atime = stat.atime;
 		dp->dl_ctime = stat.ctime;
 		dp->dl_mtime = stat.mtime;
+		spin_lock(&f->f_lock);
+		f->f_mode |= FMODE_NOCMTIME;
+		spin_unlock(&f->f_lock);
 		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
 		open->op_delegate_type = deleg_ts && nfs4_delegation_stat(dp, currentfh, &stat) ?
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index bf9436cdb93c5dd5502ecf83433ea311e3678711..b6ac0f37e9cdfcfddde5861c8c0c51bad60101b7 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -217,10 +217,12 @@ struct nfs4_delegation {
 	struct nfs4_clnt_odstate *dl_clnt_odstate;
 	time64_t		dl_time;
 	u32			dl_type;
-/* For recall: */
+	/* For recall: */
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
 	bool			dl_recalled;
+	bool			dl_written;
+	bool			dl_setattr;
 
 	/* for CB_GETATTR */
 	struct nfs4_cb_fattr    dl_cb_fattr;

-- 
2.50.1


