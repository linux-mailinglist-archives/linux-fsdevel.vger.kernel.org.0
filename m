Return-Path: <linux-fsdevel+bounces-70347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE59C97F92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CDA3A49CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54953321440;
	Mon,  1 Dec 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwZBKqYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A32320A0C;
	Mon,  1 Dec 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601729; cv=none; b=hN/CxIzJ3hw/CMuGiYFN/SDyRJosIbzdVYn1zovpZ2s11aRqCTfBupcqZ93XpvDfXZFMY1v/yIJtouz8M31yVmLGH+wirSKPLqPk9mLtIaQjSF7tKhfPgr+xLzjswiyYFc73Ka81nRHHkHAcTog5VSsiLfUtPPAKzu1M6fvSDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601729; c=relaxed/simple;
	bh=PMj33NdudVvwiBGVA7gH+K9mVC7vigOAoji4v5w2vQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwdyXqMGd5Jx8H2TztT7S3FOiCq7sNhgTmJgzRHwLnWT2ywrT9nkx2RiPTPekRuRgHjZbDQ5uesVEW6vslvOxyygSnz0lcaS2r2tCeb/gtFjwxIvPYoe/HuGsWggwbELnpDorUiGeEiex10HG7opxYB77RESASv+O/ct/l00dO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwZBKqYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD0AC16AAE;
	Mon,  1 Dec 2025 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764601729;
	bh=PMj33NdudVvwiBGVA7gH+K9mVC7vigOAoji4v5w2vQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lwZBKqYRowWgp6D0wrh4REA7mBMv7LbPD5pmtvEzzkKHvbavqcHtC0dFepNN2YvaX
	 w/KLZHo4SpVCI3WAduGoGwc0KmbeIwY98ozPI6KsK5tmCnFKjTz9epRgbuM/unM+Qm
	 zPwTSZFy/mEqcuBuI7+aBY0WJLErMPdnKRQOZGCd3oQX1NacxcmXb9NBWdzAugfk5H
	 DXcM3nH+BQ00+my5CyiOYrfgcQiW1yTVZB5DMnY5aD3NrKFaFw+Y/eKZUt/uXMRE+b
	 U6KGqvxze1NoTu+ryxwZMc76/GuA2xcrdwmE/Kt5zDd0E4JSEflRhlsMKDtCWO2YZW
	 JN2b5nnEPXATA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Dec 2025 10:08:20 -0500
Subject: [PATCH 2/2] filelock: allow lease_managers to dictate what
 qualifies as a conflict
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-dir-deleg-ro-v1-2-2e32cf2df9b7@kernel.org>
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
In-Reply-To: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7914; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PMj33NdudVvwiBGVA7gH+K9mVC7vigOAoji4v5w2vQw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpLa984ZHsy+VvZEGXl1gqV2N6gPZscwKM1l8pX
 s/zWcksSgqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaS2vfAAKCRAADmhBGVaC
 FTuHD/9tDyXZGWOvfU15vvMSKlhAfQ73VqpnQ5iJbR7fCnSZeTFlGVaqU90LW+jaBFfEFUoyFvm
 YAV1ObJG9WTtx0r81wbIG2rp+TAF6f/Gj5g6BA2tU2If+JLkUAKPfzoExf1B/oIiRCnDkw+vb/h
 rl+XIvfrXwsPjEfXCLzF83pXR0pDHK0s4jG1ufL7UveumAnHwLV6fKhjX6vM0fFAKSgTQKEnbiB
 7vGRvYaRZCM89ZCc6nZ7tRQifAMbYXuY7lfun9SAgO05WqViJNKNNWTQSx45ExoKjh0W94gxV/l
 QB4C5rOIN8BleMKUUWi4jhzmg1kaV3fO63w+HMpvcqf4R87ZXJzi+PXxhyGyL5X+WnMeO8JRjLe
 SHHDzYqa7ekiQ4jmGKcMVqTO80u8v0nmVaktyJVov2P5f6OZfuQE+3HZzPy1qGyKyCMjEzQpSlg
 dSy6c8/yYM0AcO14+Pv3YWTgmFZuY06FYwvnSP26NSMddKSL7Q4akT+mkK4JSs6HgRwt9s7NEew
 1Sa+p26rn+E+06W26YqWJ4TiIr4IiaWPtPWVo1qH6g5t2pAZWqiQFeRcZNnQCMcO7sR2H10cCwA
 GrINhRWkXNBjGW5xH9aS7hKjnuzYMYJ7JcYYUoPoJR4aZ2rMU93B1dAO2zcAgW6/MUyXnhPErLG
 5YyYICWHoT4DsvQ==
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
 Documentation/filesystems/locking.rst |  1 +
 fs/locks.c                            | 90 ++++++++++++++++-------------------
 fs/nfsd/nfs4layouts.c                 | 11 ++++-
 fs/nfsd/nfs4state.c                   |  7 +++
 include/linux/filelock.h              |  1 +
 5 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 77704fde98457423beae7ff00525a7383e37132b..29d453a2201bcafa03b26b706e4c68eaf5683829 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -416,6 +416,7 @@ lm_change		yes		no			no
 lm_breaker_owns_lease:	yes     	no			no
 lm_lock_expirable	yes		no			no
 lm_expire_lock		no		no			yes
+lm_open_conflict        yes             no                      no
 ======================	=============	=================	=========
 
 buffer_head
diff --git a/fs/locks.c b/fs/locks.c
index e974f8e180fe48682a271af4f143e6bc8e9c4d3b..a58c51c2cdd0cc4496538ed54d063cd523264128 100644
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
@@ -1753,52 +1793,6 @@ int fcntl_getdeleg(struct file *filp, struct delegation *deleg)
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
@@ -1835,7 +1829,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
+	error = lease->fl_lmops->lm_open_conflict(filp, arg);
 	if (error)
 		goto out;
 
@@ -1892,7 +1886,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
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
2.52.0


