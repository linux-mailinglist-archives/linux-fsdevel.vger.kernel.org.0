Return-Path: <linux-fsdevel+bounces-70667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A9CA3EDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6CD30EB143
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E2340DBE;
	Thu,  4 Dec 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1X3Lk6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677B23D7C4;
	Thu,  4 Dec 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856152; cv=none; b=c7pY59dxgi6qv1a8XBB3/ZeaLRODWWjzEGtsmAa3pXOk59wzXg/fdJ2v3UFPypFRK8cJ9uxN1EPxt5amVi42iuYb2Uzu1qvb5vZBKLjw+KIBG+Io2HWggwy9mdNj3dQP9vMk9oay52VVc6JeLug12SDujfq3swiGVCNC0ZWuBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856152; c=relaxed/simple;
	bh=PGNKCM4RWRgePAblEoxnyv/9Ompl/rGisrWkB5ubAmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Df+4Gi6OT+xigLXGylPm1rgIjOpD/7UO/CDHrZkzRSa+zS66KITUT2pGLyidz+z7K93K/7E+CYMaol0Mn7TVXMLWR8HslyU3nlhNAzXnLqJIfOlvuRoJ3WinolU+jbOKRSCtXgRq9i3f8MmN9X+4Sck53pxcQ6LAotE7fixpWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1X3Lk6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5708C4CEFB;
	Thu,  4 Dec 2025 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764856152;
	bh=PGNKCM4RWRgePAblEoxnyv/9Ompl/rGisrWkB5ubAmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A1X3Lk6l2gjAZR+pR/NS/vm11m4GMGpy9rUogQvatNK5neVQKSjdG0/LBgOKrH/nm
	 4dEcZJEno6PVRfDTxofbJ1mZbZBX6EqGSwE0zLvgYpLenTmGyyL8U1GJDeV+VvNsan
	 Z9PBwZyynBT1toOYpRTAVXeikEFo9MKlpxBcnqWbJ4iHmnWvRF9UDVu29PL+pIpAT2
	 Nkfpr+t7ygX2ZqtetVaAE8PG5TLobG95dP30FCQ23ZxqTpNhxt6VHSghOC9W4Mjhr0
	 hqNrrMmw0IjeOrARRvzs6yAnwaIE5vf+MNqg1Lylh7NbXSsZhQMWKzU4jeGfs/zM72
	 XTLsHHgEwqobQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 04 Dec 2025 08:48:33 -0500
Subject: [PATCH v2 2/2] filelock: allow lease_managers to dictate what
 qualifies as a conflict
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-dir-deleg-ro-v2-2-22d37f92ce2c@kernel.org>
References: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
In-Reply-To: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8943; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PGNKCM4RWRgePAblEoxnyv/9Ompl/rGisrWkB5ubAmE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMZFTudx42rp8equhKu0RbCtNAGdFvOREM0JQT
 ztclX7HqUWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTGRUwAKCRAADmhBGVaC
 FWODD/9L4ge3HADqlBPoTNGjbzKHlVuRIfbyOhnY+q7DSle3VxbxQUNYCW/yHKGayZrhEkERw8s
 jwMVhBi0jaMl4Cmtbz1a4khoO8UaJ1K5ctnDWTDznq4WCT6NtV5iJLrm1/QTiBMSTVNJWBzIF2s
 IABhZhl3Q87xgD4/iLn5yS88j30dLSorzf2q0hKAtR+AyS8kGF1cugLndmaFM2PAeaHDujv12T6
 EPPDgCDAEOjCUE6DFZix+g9+waKEyc7lH0CF1gQtQ7rke1YbxUNUNw44DmoMx8fP/QixhBsJr+8
 TeBWzzZmqVFsEPGubrQYENyZKi4yUNWO0PCYeuz1zEMA+rb7L8dcj5emlfEMwZwkpjB3OCPDSGR
 0D6Ny7exPhhEO7/yE3dNzJG0GGwkkX3+bu+3/zt6OIv+LReqCnD9SIccTE9lzPoG9Zeul+NDUHZ
 1piJlPi6j2CfwfklxmWea5Gb0/s/XUyTXm61cB69TOC2NI5sPq1MOua0ljECcWnWGl3KQBCriF+
 lqvY04NbssspiHovxxif+0FLdrbD4JvnUjbcAsNF5bWgAIWUQ8Hm2arCOcuj7kr0FsKfXVb03wz
 ciqFJGaG3Kw7YVOo3CSyRItLSha9UaNkmFVxts2V983phmgxI4qU2OE+IA7G3rFrCGR6T+iVWtM
 uCSLtQCx1uDOElg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Requesting a delegation on a file from the userland fcntl() interface
currently succeeds when there are conflicting opens present.

This is because the lease handling code ignores conflicting opens for
FL_LAYOUT and FL_DELEG leases. This was a hack put in place long ago,
because nfsd already checks for conflicts in its own way. The kernel
needs to perform this check for userland delegations the same way it is
done for leases, however.

Make this dependent on the lease_manager by adding a new
->lm_open_conflict() lease_manager operation and have
generic_add_lease() call that instead of check_conflicting_open().
Morph check_conflicting_open() into a ->lm_open_conflict() op that is
only called for userland leases/delegations. Set the
->lm_open_conflict() operations for nfsd to trivial functions that
always return 0.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/locking.rst |  1 +
 fs/locks.c                            | 90 ++++++++++++++++-------------------
 fs/nfsd/nfs4layouts.c                 | 23 ++++++++-
 fs/nfsd/nfs4state.c                   | 19 ++++++++
 include/linux/filelock.h              |  1 +
 5 files changed, 84 insertions(+), 50 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77704fde98457423beae7ff00525a7383e37132b..04c7691e50e01f7728ee597d598aea5851b9a21e 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -416,6 +416,7 @@ lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
+lm_open_conflict	yes		no			no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index be0b79286da89d6b939ac071a9174c557d7f4d81..e75c8084d937be1cb3abab0b844c3abfbca7f4ca 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -585,10 +585,50 @@ lease_setup(struct file_lease *fl, void **priv)
 	__f_setown(filp, task_pid(current), PIDTYPE_TGID, 0);
 }
 
+/**
+ * lease_open_conflict - see if the given file points to an inode that has
+ *			 an existing open that would conflict with the
+ *			 desired lease.
+ * @filp:	file to check
+ * @arg:	type of lease that we're trying to acquire
+ *
+ * Check to see if there's an existing open fd on this file that would
+ * conflict with the lease we're trying to set.
+ */
+static int
+lease_open_conflict(struct file *filp, const int arg)
+{
+	struct inode *inode = file_inode(filp);
+	int self_wcount = 0, self_rcount = 0;
+
+	if (arg == F_RDLCK)
+		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
+	else if (arg != F_WRLCK)
+		return 0;
+
+	/*
+	 * Make sure that only read/write count is from lease requestor.
+	 * Note that this will result in denying write leases when i_writecount
+	 * is negative, which is what we want.  (We shouldn't grant write leases
+	 * on files open for execution.)
+	 */
+	if (filp->f_mode & FMODE_WRITE)
+		self_wcount = 1;
+	else if (filp->f_mode & FMODE_READ)
+		self_rcount = 1;
+
+	if (atomic_read(&inode->i_writecount) != self_wcount ||
+	    atomic_read(&inode->i_readcount) != self_rcount)
+		return -EAGAIN;
+
+	return 0;
+}
+
 static const struct lease_manager_operations lease_manager_ops = {
 	.lm_break = lease_break_callback,
 	.lm_change = lease_modify,
 	.lm_setup = lease_setup,
+	.lm_open_conflict = lease_open_conflict,
 };
 
 /*
@@ -1754,52 +1794,6 @@ int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
 	return 0;
 }
 
-/**
- * check_conflicting_open - see if the given file points to an inode that has
- *			    an existing open that would conflict with the
- *			    desired lease.
- * @filp:	file to check
- * @arg:	type of lease that we're trying to acquire
- * @flags:	current lock flags
- *
- * Check to see if there's an existing open fd on this file that would
- * conflict with the lease we're trying to set.
- */
-static int
-check_conflicting_open(struct file *filp, const int arg, int flags)
-{
-	struct inode *inode = file_inode(filp);
-	int self_wcount = 0, self_rcount = 0;
-
-	if (flags & FL_LAYOUT)
-		return 0;
-	if (flags & FL_DELEG)
-		/* We leave these checks to the caller */
-		return 0;
-
-	if (arg == F_RDLCK)
-		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
-	else if (arg != F_WRLCK)
-		return 0;
-
-	/*
-	 * Make sure that only read/write count is from lease requestor.
-	 * Note that this will result in denying write leases when i_writecount
-	 * is negative, which is what we want.  (We shouldn't grant write leases
-	 * on files open for execution.)
-	 */
-	if (filp->f_mode & FMODE_WRITE)
-		self_wcount = 1;
-	else if (filp->f_mode & FMODE_READ)
-		self_rcount = 1;
-
-	if (atomic_read(&inode->i_writecount) != self_wcount ||
-	    atomic_read(&inode->i_readcount) != self_rcount)
-		return -EAGAIN;
-
-	return 0;
-}
-
 static int
 generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **priv)
 {
@@ -1836,7 +1830,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
+	error = lease->fl_lmops->lm_open_conflict(filp, arg);
 	if (error)
 		goto out;
 
@@ -1893,7 +1887,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	 * precedes these checks.
 	 */
 	smp_mb();
-	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
+	error = lease->fl_lmops->lm_open_conflict(filp, arg);
 	if (error) {
 		locks_unlink_lock_ctx(&lease->c);
 		goto out;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe298f9df774684192c89f68102b72..ad7af8cfcf1f9019f290a22214f27c3ceeee33a4 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -764,9 +764,28 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
+/**
+ *  nfsd4_layout_lm_open_conflict - see if the given file points to an inode that has
+ *				    an existing open that would conflict with the
+ *				    desired lease.
+ * @filp:	file to check
+ * @arg:	type of lease that we're trying to acquire
+ *
+ * The kernel will call into this operation to determine whether there
+ * are conflicting opens that may prevent the layout from being granted.
+ * For nfsd, that check is done at a higher level, so this trivially
+ * returns 0.
+ */
+static int
+nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
+{
+	return 0;
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
-	.lm_break	= nfsd4_layout_lm_break,
-	.lm_change	= nfsd4_layout_lm_change,
+	.lm_break		= nfsd4_layout_lm_break,
+	.lm_change		= nfsd4_layout_lm_change,
+	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
 };
 
 int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6791fc239dbdb5c30ad69912addfd16ad67eb743..c28799f7c775df114274735210d98244b478879d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5574,10 +5574,29 @@ nfsd_change_deleg_cb(struct file_lease *onlist, int arg,
 		return -EAGAIN;
 }
 
+/**
+ *  nfsd4_deleg_lm_open_conflict - see if the given file points to an inode that has
+ *				   an existing open that would conflict with the
+ *				   desired lease.
+ * @filp:	file to check
+ * @arg:	type of lease that we're trying to acquire
+ *
+ * The kernel will call into this operation to determine whether there
+ * are conflicting opens that may prevent the deleg from being granted.
+ * For nfsd, that check is done at a higher level, so this trivially
+ * returns 0.
+ */
+static int
+nfsd4_deleg_lm_open_conflict(struct file *filp, int arg)
+{
+	return 0;
+}
+
 static const struct lease_manager_operations nfsd_lease_mng_ops = {
 	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
 	.lm_break = nfsd_break_deleg_cb,
 	.lm_change = nfsd_change_deleg_cb,
+	.lm_open_conflict = nfsd4_deleg_lm_open_conflict,
 };
 
 static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4_stateowner *so, u32 seqid)
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 54b824c05299261e6bd6acc4175cb277ea35b35d..2f5e5588ee0733c200103801d0d2ba19bebbf9af 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -49,6 +49,7 @@ struct lease_manager_operations {
 	int (*lm_change)(struct file_lease *, int, struct list_head *);
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
+	int (*lm_open_conflict)(struct file *, int);
 };
 
 struct lock_manager {

-- 
2.52.0


