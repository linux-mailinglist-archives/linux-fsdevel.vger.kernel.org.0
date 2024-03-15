Return-Path: <linux-fsdevel+bounces-14511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0187D23C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C151C20B82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8444C3DE;
	Fri, 15 Mar 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw/sJ1Iw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71055FBAE;
	Fri, 15 Mar 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521660; cv=none; b=ogFrxk3gx10Oa2z4uo2KbyjyBn73YNrxnJRQqre3vlZwpLzQF+QKpFp3a3iqq+VQPTAIxDXW1+lRler3rKULnWNtX1Zws2wbVlYeTow5dpPRTSvAIhfho7ShsZvvdoPDzu+HhNvzJErsWNQY7x8mcIBzs6jgoIB5T3griWTehtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521660; c=relaxed/simple;
	bh=HqSajQkHgNfbJ2Z8x7T3Rdj/LkayLnr5zzZhTW9vu30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJrz1xiwAEnICNAzdVeaV2qcBdGYtn89wIYBjBhdFcbuWNomw5orr9WZ0MP2Majd0DtDiGTbKS9TKUsSRanERR2WVe5viOsQ/sFZ1h7iKRclPM9Y+3y7uHCkQriFimuhHrIPX7Y2fJZdXUIfj9M+lzFToK7321ADftqbyIK4N4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw/sJ1Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A32C43394;
	Fri, 15 Mar 2024 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521660;
	bh=HqSajQkHgNfbJ2Z8x7T3Rdj/LkayLnr5zzZhTW9vu30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aw/sJ1IwefqKWawHzfrH/1WUpi/69CvZgmL2U0hJ7IsoJviGRY+iLZmVI3HTdHOYc
	 Kf6mfyhTCQkuwK91mJ5heipQR+LtkfltMmkEVd6ayaXuxTlLnQLde92wiLZYkFMYJO
	 lKQ7vjqEcyThCrZLWKJLmB9Gph5bR5fBp+ybSzM5ePoC8Nc3UFU4BQM4JGqwagVRIP
	 017L5h4miRCjpRdM8sCNPmicWGmKabzsP+PlywSZzciHEnKuk/hmq7mNl6wMPfbI9x
	 el0vlSZ3CN4FxSorWi3kU72bjpQqjUOsVsqCdSpCsYeF+PkJKXh21rh0kmCnKGhx59
	 tDzE6m31nz+Uw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:14 -0400
Subject: [PATCH RFC 23/24] nfs: optionally request a delegation on GETATTR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-23-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6739; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HqSajQkHgNfbJ2Z8x7T3Rdj/LkayLnr5zzZhTW9vu30=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzvFjVT4jXwJdhnMv42oNu0gHhdRkwCaXeCy
 BE5PQkA5DmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87wAKCRAADmhBGVaC
 Fa6HEADKSei76E9Guc9KUDVOm1qUI7V0l7prDFGS2AkZrmx2axqtOUlPABnSWhKDVlSGtMvrrp1
 GyhF58ODp0WXw1+XtWzbWzt6YYxJBJKjixjPnCYQzba8NY9Abr6lVD8rgkLD2dblTmitOqJzToA
 GzfKMW+9jSOWl9x/+QKBqB9cV6YJQbYN+iHLGZR1z/kquhYk38RASDbihV167/IsbMJyOBgUi98
 kX1gG/uwsT88Ir9webAnGT/lzDHIB9VxmOp++twBDIEaVCx1sVk9p8Xl+14Pu+oG7j/pz5ksLkv
 54AmD8cDltnbpmfrm5tA8RUg5wnGge/LFnAtUSZoqXYrPQJW2f3s0o7U2HCz74aImGkK8j681Hv
 r/SczzwcVYVuJb1j3kPwa8/W/ODmajDxA8X7KSbJH1wPp1wOfz1jdxFWHQ/8DXxx1PrlHCzZ8NP
 OJ5veH9r/utlO0qhliLkIy3OI5LLn53/GpByjKnXHEQCr8xxgRsPXc/uzzLsU0Ij6RzvmbDbJpg
 aI5rkT9Xkf1Jnwaxryyh73T1t/7b/8cf4XD9SykoaYdkP59TkfLgYwDdntlTmeMpvq8Q2JOq/vo
 SOSUmXirsZTFUaZUVW6OBA8EjFSNOTPE/EYGjQ0kaD8vIjPPo2IMMXERbK2clBXsoMjbpkf8OK8
 QoQSuL9P4g83Fig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We expect directory delegations to most helpful when their children have
frequently revalidated dentries. The way we usually revalidate them is
to check that the dentry's d_time field matches the change attribute on
the parent. Most dentry revalidations that have to issue an RPC end up
as a GETATTR on the wire for the parent, if the parent hasn't changed,
then the dentry is fine.

Add a new NFS_INO_GDD_GETATTR flag to the nfsi->flags field. Whenever we
validate a dentry vs. its parent, set that flag on the parent.  Then,
when we next do a GETATTR vs. the parent, test and clear the flag and do
a GDD_GETATTR if it was set. If the the GET_DIR_DELEGATION succeeds, set
the delegation in the inode.

Finally, a lot of servers don't support GET_DIR_DELEGATION, so add a
NFS_CAP_* bit to track whether the server supports it, and enable it by
default on v4.1+, and retry without a delegation if we get back an
ENOTSUPP.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c       |  1 +
 fs/nfs/dir.c              |  8 ++++++++
 fs/nfs/nfs4proc.c         | 45 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/nfs_fs.h    |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 88dbec4739d3..14c14bd03465 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -356,6 +356,7 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 	delegation->inode = NULL;
 	rcu_assign_pointer(nfsi->delegation, NULL);
 	spin_unlock(&delegation->lock);
+	clear_bit(NFS_INO_GDD_GETATTR, &nfsi->flags);
 	return delegation;
 }
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 061648c73116..930fe7e14914 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1504,12 +1504,20 @@ static int nfs_dentry_verify_change(struct inode *dir, struct dentry *dentry)
 static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 			      int rcu_walk)
 {
+	struct nfs_inode *nfsi = NFS_I(dir);
+
 	if (IS_ROOT(dentry))
 		return 1;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
 		return 0;
 	if (!nfs_dentry_verify_change(dir, dentry))
 		return 0;
+	/*
+	 * The dentry matches the directory's change attribute, so
+	 * we're likely revalidating here. Flag the dir so that we
+	 * ask for a delegation on the next getattr.
+	 */
+	set_bit(NFS_INO_GDD_GETATTR, &nfsi->flags);
 	/* Revalidate nfsi->cache_change_attribute before we declare a match */
 	if (nfs_mapping_need_revalidate_inode(dir)) {
 		if (rcu_walk)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d518388bd0d6..3dbe9a18c9be 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4318,6 +4318,21 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	return status;
 }
 
+static bool should_request_dir_deleg(struct inode *inode)
+{
+	if (!inode)
+		return false;
+	if (!S_ISDIR(inode->i_mode))
+		return false;
+	if (!nfs_server_capable(inode, NFS_CAP_GET_DIR_DELEG))
+		return false;
+	if (!test_and_clear_bit(NFS_INO_GDD_GETATTR, &(NFS_I(inode)->flags)))
+		return false;
+	if (nfs4_have_delegation(inode, FMODE_READ))
+		return false;
+	return true;
+}
+
 static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct inode *inode)
 {
@@ -4331,11 +4346,12 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.server = server,
 	};
 	struct rpc_message msg = {
-		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_GETATTR],
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
 	unsigned short task_flags = 0;
+	bool gdd;
+	int status;
 
 	if (nfs4_has_session(server->nfs_client))
 		task_flags = RPC_TASK_MOVEABLE;
@@ -4344,11 +4360,32 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
 		task_flags |= RPC_TASK_TIMEOUT;
 
+retry:
+	gdd = should_request_dir_deleg(inode);
+	if (gdd)
+		msg.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_GDD_GETATTR];
+	else
+		msg.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_GETATTR];
+
 	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label), inode, 0);
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
-	return nfs4_do_call_sync(server->client, server, &msg,
-			&args.seq_args, &res.seq_res, task_flags);
+	status = nfs4_do_call_sync(server->client, server, &msg,
+				   &args.seq_args, &res.seq_res, task_flags);
+	switch (status) {
+	case 0:
+		if (gdd && res.nf_status == GDD4_OK)
+			status = nfs_inode_set_delegation(inode, current_cred(), FMODE_READ,
+							  &res.deleg, 0);
+		break;
+	case -ENOTSUPP:
+		/* If the server doesn't support GET_DIR_DELEGATION, retry without it */
+		if (gdd) {
+			server->caps &= ~NFS_CAP_GET_DIR_DELEG;
+			goto retry;
+		}
+	}
+	return status;
 }
 
 int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
@@ -10552,6 +10589,7 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 	.minor_version = 1,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_GET_DIR_DELEG
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
@@ -10578,6 +10616,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 	.minor_version = 2,
 	.init_caps = NFS_CAP_READDIRPLUS
 		| NFS_CAP_ATOMIC_OPEN
+		| NFS_CAP_GET_DIR_DELEG
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f5ce7b101146..5140e4dac98a 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -318,6 +318,7 @@ struct nfs4_copy_state {
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
 #define NFS_INO_ODIRECT		(12)		/* I/O setting is O_DIRECT */
+#define NFS_INO_GDD_GETATTR	(13)		/* Ask for dir deleg on next GETATTR */
 
 static inline struct nfs_inode *NFS_I(const struct inode *inode)
 {
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..0ab744cf52d7 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -278,6 +278,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_GET_DIR_DELEG	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)

-- 
2.44.0


