Return-Path: <linux-fsdevel+bounces-69097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A1C6F167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5A24F8D36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48065364047;
	Wed, 19 Nov 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4I/utKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E4361DDB;
	Wed, 19 Nov 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559766; cv=none; b=W3fS8fjb4fXyYPB7RM3JY3IBQ52sgQxvYVb064CzFfSPgqq7Sr1wcZTiIjdnP3cfUIG9jxCYDMWS9JOjhBpBCqiE3imHzja+OcefmkQ/Lci31B18tE+GB0MIBGLUbe1i7QGVjBeTnkSXyOJ90YDcON+xt/I0K/omfIPNkiCBZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559766; c=relaxed/simple;
	bh=XmLiut+Qzx6ykbbfVHIfDiwFQuxqxqG6Krfa30IzFN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6pe+6NOE9nuFq5ao2OWfBd7LCNdKaMkvXaVJiNneAvXMw9A0EFeCxU4npzVMEyHcpkfWUvVW+0lFg1RmHbrD9Van+5ZqLT4LlczogUStyU3+LYWmCG/yuAdahDWEaE2lShA5fCIhyxumdyVy+LJvPK1DNsI0WWNJbKAN42fRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4I/utKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA292C2BCB9;
	Wed, 19 Nov 2025 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559765;
	bh=XmLiut+Qzx6ykbbfVHIfDiwFQuxqxqG6Krfa30IzFN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J4I/utKiYFzTSTByu2q3ZH5vKDMBbwD2BzgJch6vrnelw6B/K23rJtq+yOhic7G/X
	 sJOB9Fz17xKEmOH/iaueQHPCJaSt+8wwy+YyKUjPyYkiSx/lxSIsQBXnAKnqmuKYAe
	 n3m74ZzHIP66dfSEPjbwHfFWp9aJN6D212lw5BqdBdrDpV0K6bXIdTqSSZ4vdexZY+
	 dKWMAQ3Naxy2t17CIfn/glkj3msA0uECAWwpUcJUjTTJlgqDeE5ujgEbp7sW4DRE3F
	 p1TxcPfUpTV0K3uglUBO/s1+2VKEJe0kjOGUWC4gd+231Kxflm8deaPcph/jxyJnSs
	 +RMtMPPm5Jusg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Nov 2025 08:42:20 -0500
Subject: [PATCH v8 3/3] filelock: allow lease_managers to dictate what
 qualifies as a conflict
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-dir-deleg-ro-v8-3-81b6cf5485c6@kernel.org>
References: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
In-Reply-To: <20251119-dir-deleg-ro-v8-0-81b6cf5485c6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7247; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XmLiut+Qzx6ykbbfVHIfDiwFQuxqxqG6Krfa30IzFN4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHclPQggM3sdTM54h5jYcqsmAkQ6qIw7sZEwVF
 mO4Ub7/NbWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3JTwAKCRAADmhBGVaC
 FZyXEADRUkJmbtI7QG0gD6bJL4wFOsX4H4mocZz+bx3YkpHDd9IfKJR54ePwf1DNFVTLfzHDq04
 QbOdw8g824GdkgQTx48CUgYtwh/w4GfXQKnFmFIW/ljBtbwAZce6iwlz3Kcw7y3ysY1M7dqBTBk
 szEhWxWAhWhObUB0ujrEOk2w119WVyQU9I7RXpxDhbgmUYAfgDNakBhNwbo0gR0G9A/RLLuL7a4
 95Rpa4T67udY9CPsAriDKbMBsfWun5zZB9EN2miBdw3lf2Kr7J2KZtv5jWNXVwWf1NMwPW3bnRA
 NF/Q+ZfPOYCdJQFxm0DsgGxLsKcYJfWmQg9l36efa6nLmDApVfwC95K4oYd3ZjZbd7TyZVoA37/
 8e2SAA8nw3KbSTpvWjbuCqUEtRoYvTj1P3jqf5z5/0ZMzy4p8GXQ9wd5qnqfHmnOdypEVwwe0w3
 nQpG5vBoctqI7kkCxOMNVjjnDtjUcZlQjrLhZf4bBqCs0iei/9q3om/3aqIwwVmcfvIwIjERWqd
 sfYugGW8bwz3+pUYqlGPEI3F3hiXD/bOyc93EDctpfmHLkj/9lSREmGN9UobVAq2pBI8ARG2POC
 lEiJ+IUzd+W4rP2a0WD/MbsVOZSl1erv27Udzxq7Ij20I7JkW0qwURzQaaRh2AJzDqr6ybwwcd4
 PfsUfhIrCPddWuA==
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 90 ++++++++++++++++++++++--------------------------
 fs/nfsd/nfs4layouts.c    | 11 ++++--
 fs/nfsd/nfs4state.c      |  7 ++++
 include/linux/filelock.h |  1 +
 4 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index d4e6af6ac625204b337e94fd1e4f6df2eee5cf50..62fbfce0407b77423e1591290cf57c4e2c5faeb4 100644
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
@@ -1762,52 +1802,6 @@ int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
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
@@ -1844,7 +1838,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
+	error = lease->fl_lmops->lm_open_conflict(filp, arg);
 	if (error)
 		goto out;
 
@@ -1901,7 +1895,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	 * precedes these checks.
 	 */
 	smp_mb();
-	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
+	error = lease->fl_lmops->lm_open_conflict(filp, arg);
 	if (error) {
 		locks_unlink_lock_ctx(&lease->c);
 		goto out;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe298f9df774684192c89f68102b72..ca7ec7a022bd5c12fad60ff9e51145d9cca55527 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -764,9 +764,16 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
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
index 8f8c9385101e15b64883eabec71775f26b14f890..669fabb095407e61525e5b71268cf1f06fc09877 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5543,10 +5543,17 @@ nfsd_change_deleg_cb(struct file_lease *onlist, int arg,
 		return -EAGAIN;
 }
 
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
2.51.1


