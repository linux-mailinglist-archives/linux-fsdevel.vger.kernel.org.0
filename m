Return-Path: <linux-fsdevel+bounces-27029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C6695DDE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082C22833F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856611714BD;
	Sat, 24 Aug 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrydaYVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5DC13B;
	Sat, 24 Aug 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724503586; cv=none; b=rdmZqdYHHURVaT5nr46WL/M65qXfY2xRktl8EwAczGAvxmIYIEhHgx2xxQsfnzV3qs30KX7HKTgG2gkPs5D2dd0N2fMYCtLpq3KmK1y0O/S8p8R/bllQUuiQcU0x83ZCBne/CsX/5kxqi5Ygmbd+4h3oON0WBvgVzQCpb+XVXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724503586; c=relaxed/simple;
	bh=QgFlSSZj3jODyO8ZZSAuohBWNbyJSMb2BzhYeBlbvvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pq0HnzScISLoDbAnIdRGN3b8Xiz22DAz+DsxWC/iRr6QDoLKKV3YXOxbkgiNv2qzkBMWFeaHt2S6eendM2dbhejv7/teospXH+ZDVpHq15qPENUDdOFeIum0LUt0lIkhk24+dL/xKYc8VguDjtNuwWbjrJ8M7GEp5UVBJR0isvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrydaYVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52426C32781;
	Sat, 24 Aug 2024 12:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724503585;
	bh=QgFlSSZj3jODyO8ZZSAuohBWNbyJSMb2BzhYeBlbvvk=;
	h=From:Date:Subject:To:Cc:From;
	b=TrydaYVRBlRbsrCEmvbVse8EwC6wq3ejO+G4CbDIcwbNg7+oNB7TMZSde4s1xn0ui
	 ODZwggAZurAatuo9+PHBFIhEgJLjAK8SdLWPIfe8ZP+YSE+xlMnmTufRAGZoiCKEFL
	 piPaYdjU8nLR3TMxNKpQ2Kbbmg5aauaRarb1Nt/oajMYLe/8zSZkiG67nYCdJav6LY
	 HWd5Zhz3Dae3xn37VsMQyh+/LaVKvUA0mZ3akR7V5sBsymjDC3WuWWHZoDAqglP3YW
	 aOfEVRf0MFMNzctgfO6RJSxjXlZee9QgO9zQW3uhxfsZhQZZYWmGEsZJ2Lwn3mtaDy
	 Ga+7j/i9jnuKg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 24 Aug 2024 08:46:18 -0400
Subject: [PATCH] fs/nfsd: fix update of inode attrs in CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
X-B4-Tracking: v=1; b=H4sIABnWyWYC/22MTQ7CIBBGr9LM2jEMWmxdeQ/TBYGhJRpowBBNw
 93Frl2+7+dtkDl5znDtNkhcfPYxNKBDB2bRYWb0tjFIIc9ikCcMLlt0/s0ZFTlhLkNvSfbQDmv
 ivWj7+9R48fkV02d3F/qlfzWFUKAz46g1Kae0uD04BX4eY5phqrV+AUwqnVqlAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5768; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=QgFlSSZj3jODyO8ZZSAuohBWNbyJSMb2BzhYeBlbvvk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmydYgUhcilDBaLvpOPeFK2MjGjsOnQuLM3/NZn
 3Zc2DMNJryJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsnWIAAKCRAADmhBGVaC
 FZB3EACqHsC2pjSLEHXi7mJEyZ27yu/Lgl75KhwrN9SNkz7RrAY3v9sOiHHkX/g0zvuk+l/nALm
 /77pY7lgOhyb1Z9elR+piL2Cmb8voJMOvRXyx9UdgZP3xOzrmj01G0XS4f08pa6t5Bwi1rGCYit
 BDVWBgfjS+AE1PTD+Xq3WXECzkYA4UBXrAgNjZjamA6mp29A0w6M3DUE5KZihZ5eAEW+EZJjMp2
 Z7quaRDd5G6ABG8Fc6toPec8mwr9wrdntqOcdRG6Adtc375YdL0TxG+Xb6zJHZCxekjWDk0se9f
 OzrUnWOFZ3jq28zCwx/4oH204gfysqBv8D+RW7jaUEs97nH/7iwaIYNoWyeF20UeeVH4NpW9Dvj
 AMtdSb4nYtOjV62OkwO0ciZuneVAsLJjRJ12h/zzaBjvjnxxICaBlEjWxl3A2ip7WnPyT2L11e1
 plk5itJqZcjX1/wnqgMN+32P4DtdHC4wO648rQTiz4K5cGT3e1nayiCQNC7x/Z/kmSd39tCbPmx
 dEAuLdV7C6kS4Pl+75K8KhN9xRrytWFaCYdEazn+w3+STjY38Tmoc81UxgMyTCwlMZGZKkqCNgG
 OmL8Su9+sI4fbltIW/SJ3zXEGRRZAGMdp7lQclLOB04xy6ScmtzsNZRhZDA1l4H/VAiXEKrCEqj
 3Js48ZX9QT3L/kg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, we copy the mtime and ctime to the in-core inode and then
mark the inode dirty. This is fine for certain types of filesystems, but
not all. Some require a real setattr to properly change these values
(e.g. ceph or reexported NFS).

Fix this code to call notify_change() instead, which is the proper way
to effect a setattr. There is one problem though:

In this case, the client is holding a write delegation and has sent us
attributes to update our cache. We don't want to break the delegation
for this since that would defeat the purpose. Add a new ATTR_DELEG flag
that makes notify_change bypass the try_break_deleg call.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
One more CB_GETATTR fix. This one involves a little change at the VFS
layer to avoid breaking the delegation.

Christian, unless you have objections, this should probably go in
via Chuck's tree as this patch depends on a nfsd patch [1] that I sent
yesterday. An A-b or R-b would be welcome though.

[1]: https://lore.kernel.org/linux-nfs/20240823-nfsd-fixes-v1-1-fc99aa16f6a0@kernel.org/T/#u
---
 fs/attr.c           |  9 ++++++---
 fs/nfsd/nfs4state.c | 18 +++++++++++++-----
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/state.h     |  2 +-
 include/linux/fs.h  |  1 +
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 960a310581eb..a40a2fb406f0 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -489,9 +489,12 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	error = security_inode_setattr(idmap, dentry, attr);
 	if (error)
 		return error;
-	error = try_break_deleg(inode, delegated_inode);
-	if (error)
-		return error;
+
+	if (!(ia_valid & ATTR_DELEG)) {
+		error = try_break_deleg(inode, delegated_inode);
+		if (error)
+			return error;
+	}
 
 	if (inode->i_op->setattr)
 		error = inode->i_op->setattr(idmap, dentry, attr);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dafff707e23a..e0e3d3ca0d45 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8815,7 +8815,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 /**
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
- * @inode: file to be checked for a conflict
+ * @dentry: dentry of inode to be checked for a conflict
  * @modified: return true if file was modified
  * @size: new size of file if modified is true
  *
@@ -8830,7 +8830,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
  * code is returned.
  */
 __be32
-nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
+nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 				bool *modified, u64 *size)
 {
 	__be32 status;
@@ -8840,6 +8840,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 	struct nfs4_delegation *dp;
 	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
+	struct inode *inode = d_inode(dentry);
 
 	*modified = false;
 	ctx = locks_inode_context(inode);
@@ -8887,15 +8888,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 					ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
 				ncf->ncf_file_modified = true;
 			if (ncf->ncf_file_modified) {
+				int err;
+
 				/*
 				 * Per section 10.4.3 of RFC 8881, the server would
 				 * not update the file's metadata with the client's
 				 * modified size
 				 */
 				attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
-				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
-				setattr_copy(&nop_mnt_idmap, inode, &attrs);
-				mark_inode_dirty(inode);
+				attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
+				inode_lock(inode);
+				err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
+				inode_unlock(inode);
+				if (err) {
+					nfs4_put_stid(&dp->dl_stid);
+					return nfserrno(err);
+				}
 				ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
 				*size = ncf->ncf_cur_fsize;
 				*modified = true;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 43ccf6119cf1..97f583777972 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3565,7 +3565,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	}
 	args.size = 0;
 	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
+		status = nfsd4_deleg_getattr_conflict(rqstp, dentry,
 					&file_modified, &size);
 		if (status)
 			goto out;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ffc217099d19..ec4559ecd193 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -781,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-		struct inode *inode, bool *file_modified, u64 *size);
+		struct dentry *dentry, bool *file_modified, u64 *size);
 #endif   /* NFSD4_STATE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..3fe289c74869 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -208,6 +208,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
 #define ATTR_TIMES_SET	(1 << 16)
 #define ATTR_TOUCH	(1 << 17)
+#define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */
 
 /*
  * Whiteout is represented by a char device.  The following constants define the

---
base-commit: a204501e1743d695ca2930ed25a2be9f8ced96d3
change-id: 20240823-nfsd-fixes-61f0c785d125

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


