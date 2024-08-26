Return-Path: <linux-fsdevel+bounces-27185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323295F3EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7851F1C21C16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E44818D641;
	Mon, 26 Aug 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKKGr+X8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766A17D35B;
	Mon, 26 Aug 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682759; cv=none; b=XgxfSnzzHZ1NfHmUi0K6G4pDshJ6azBOf+2VngMGZS3geokxMOustMMDiGaS9zjQyLdT5MotCOwuoKf3GPGs+2RV3vN+rMW+o32Na1SrJxlvgESmrbkS8Sgq0BXmDpj8j1H63akM1vjtRPND46iIkht/8BHE2Ssy96hjMnEbyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682759; c=relaxed/simple;
	bh=YXTK2J5YB64tUBeZ1eHaaaaCG+jc9iYf70n2FydLanQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ozdgu6RCRxN+q7o9MLE/NRmO6IJwKsu+YnlC+SOFRYWcIU5Rl9o3Sf49bqs05RXgdiY4EqQFaCrosp1kLhPoSRUcMsznPdBTK4YGz6va5ZGR87eDKSBrWG+ip+oJ8HOVEPf0fGXS79Qu0YbapLtPlcBRZLMKbQ2QlFJdzVXzuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKKGr+X8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58069C4AF61;
	Mon, 26 Aug 2024 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724682759;
	bh=YXTK2J5YB64tUBeZ1eHaaaaCG+jc9iYf70n2FydLanQ=;
	h=From:Date:Subject:To:Cc:From;
	b=nKKGr+X8SMrj1tg3epCw8JidH75RANENFFglcQJn7tmu7sa+2rTFOc8kCyS1ObmGg
	 kfn309chJ7dOkEuakaz2wseYtRxfvjCDm+Zl/8EQSB0Zul8XZuc4cN0zRXSee09kla
	 j8m1zEGJAU4zA5i7f1MJKsuEluR0ZmD5JcUoDX9ifG4LICGyXTGDEE5hfaZJg0MHsZ
	 AWRDKAGWqJ3HHuOXN+yHqVfypaQpFdV/d8EN6Yv7kAPLqTUAJ9cy0jOLkhVVkSH5ES
	 bQFOjWe2gKQ7Bjzu4+ademRVBzww5VBgMg8ZYByAaQl1o+hzU45Pb4WIPpT+X8hyZn
	 sKu0Fc2aBAh7g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 10:32:34 -0400
Subject: [PATCH v2] fs/nfsd: fix update of inode attrs in CB_GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-nfsd-fixes-v2-1-709d68447f03@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAGSzGYC/22MzQ7CIBAGX6Xh7BpY+0M9+R6mBwJLSzS0AUM0D
 e8ubTwY43H225mVRQqOIjtXKwuUXHSzL4CHiulJ+ZHAmcIMOdZc4gm8jQase1KEVliuO9kYgQ0
 rwhJoH8r/dSg8ufiYw2tvJ7Fd/2aSAA5W971SorWt4pcbBU/34xzGLftx6h9HgO6Qy6asPdK3M
 +Sc3wSScCjZAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5889; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YXTK2J5YB64tUBeZ1eHaaaaCG+jc9iYf70n2FydLanQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzJIGJiACTJdGgL+HUhWx5ffOADerWGR63X019
 HhfzhSm9GeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsySBgAKCRAADmhBGVaC
 FRqKD/9DushojczvJgk9Vmh01eDtqKHvAlb23G13VVYdy6vPviyZNx3N8JuiSbJy/oCXb+aFmbL
 AZLODCO0zetpwLUe/fzNVXHucycZQn8VVEubPYGJ0j1/TBvR1KscVS8y6gS68TiO0vfSyPUvU4E
 oS1h5aPDxajNeH8e6EZBHPbv4EEKtZVVcPsHQN/Nlk/AGUxYjMSpp+WyulAFUTgtshA5NO3HkTn
 Zacj6dsBCYVuvUa+Mg8XQ7cGlBhHckKXeehL8Toa4ih9mLLI87VrO7MFvhcvACTX2R81sVycaJn
 HASqayamQdjXzWmQSUoE5xooj88oF2iNsL+o+I26xItQsq1X7CRYamlQop52R7QfdaC3NrDwnKV
 /UKuwIKLvTWTq28r/U9x/slF2N5Z1OA+QJZSjs0AhVu6bZI+JYkLJ07FNDy7+HwhSmHq6aIZe8v
 vlpROqUE4qyMSHYSeH+vcx6wQvIV+pltx1EbsQMr7b9CYY8QPLoYlLhxalgRxYYwxO2cUsUPZJz
 cRDNvk3jJlFovmcRjYlRpLfhGFRF6UucuzwGuEhCUbOX/uG5RJtqwrtCSrLhuIfFj1NJAC4TC7W
 a4qy0JKD+tP6g09pgVYVnMSRSh0iVHzIZIg9FKGzDK9sTdn27i2SCebq0Gt2qQJAU5FupTDALhp
 A3czQtA4i/cHnxg==
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Just an update to the comments. Chuck, can you drop the old one in favor
of this one?
---
Changes in v2:
- Add better comments explaining what ATTR_DELEG means
- Link to v1: https://lore.kernel.org/r/20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org
---
 fs/attr.c           | 14 +++++++++++---
 fs/nfsd/nfs4state.c | 18 +++++++++++++-----
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/state.h     |  2 +-
 include/linux/fs.h  |  1 +
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 960a310581eb..0dbf43b6555c 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -489,9 +489,17 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	error = security_inode_setattr(idmap, dentry, attr);
 	if (error)
 		return error;
-	error = try_break_deleg(inode, delegated_inode);
-	if (error)
-		return error;
+
+	/*
+	 * If ATTR_DELEG is set, then these attributes are being set on
+	 * behalf of the holder of a write delegation. We want to avoid
+	 * breaking the delegation in this case.
+	 */
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
index 0283cf366c2a..bafc1d134b94 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -208,6 +208,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
 #define ATTR_TIMES_SET	(1 << 16)
 #define ATTR_TOUCH	(1 << 17)
+#define ATTR_DELEG	(1 << 18) /* Delegated attrs. Don't break write delegations */
 
 /*
  * Whiteout is represented by a char device.  The following constants define the

---
base-commit: a204501e1743d695ca2930ed25a2be9f8ced96d3
change-id: 20240823-nfsd-fixes-61f0c785d125

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


