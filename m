Return-Path: <linux-fsdevel+bounces-10290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40CB8499DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C08B2A78D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C722C1B8;
	Mon,  5 Feb 2024 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFLjbt/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E802C18E;
	Mon,  5 Feb 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135001; cv=none; b=QxCignmvUmsyVBzAypnnvpshyrugZRhq5+qGQWbqCnvCHapJ09jYA9Vq2PRKvG2MkGMBEuK1VlKJN5j3dhGl1ZVSzNCnrMU0pfjszpjr+jsyzu1brcQaDWLCgWs5v7q3oiNi1vF9ES+YQThyj+iMa4lVYDtloolb3R2w8Yq18+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135001; c=relaxed/simple;
	bh=rhLn0KVRJ18boZjsfYPOuNLIVNG/FOTLR0EenwS0/J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gr6q4wmSqYED4XyiiOER9gtbKnZ/SK1zriS4zDHf0hve1G/SZRmBqjS8WFB9RqHoP2T7cB1s0VMB8vmDAiRAPStbrenqV0+jvDVvdizFHMwahPDNapxoYCphAYgZ3/h6Gv4Sk/4mbrFZqFXiFoTnlp+Pw5CR4rviA2l1vUtpZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFLjbt/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5F2C433F1;
	Mon,  5 Feb 2024 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707135001;
	bh=rhLn0KVRJ18boZjsfYPOuNLIVNG/FOTLR0EenwS0/J0=;
	h=From:Date:Subject:To:Cc:From;
	b=EFLjbt/3kQVsaNx7aYDg6+YbCdUYmQel1yPn3ZiYmBFK0G6TRd9qqiYHNCtKCYCPe
	 6tcf5oLyFyTIzI65P5uLOuQYJYpVxFaI3qBgAPKSa46XSNnrZc84kGmlVcCdphdUr1
	 SEd/SARcdrXQ3+kpk7Xq7aUFPwDby3hnTmCfZmnppfG6VMCBqr3EbOj+R+K4ponR9h
	 WImyAGcW698FdU1ZK9f//vXT8bh8eG16vmbJ3bEgCsi3WnSlgNz6hgDB6aPiGhvBPk
	 +YjcKf355JEhgZSiXOC1kM70gEL4q+Q18ouC4l2JzkO9ysmi8OxkeWPCdGwJip2xwY
	 AkkTgvPqhR3Lg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 05 Feb 2024 07:09:31 -0500
Subject: [PATCH] filelock: don't do security checks on nfsd setlease calls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPrPwGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIKGbVGVkZGJhYWyga2CcapZsbmpgZm5gqgRUX1CUmpZZATYrOra2FgC
 +MPxdWwAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Zdenek Pytela <zpytela@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7870; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rhLn0KVRJ18boZjsfYPOuNLIVNG/FOTLR0EenwS0/J0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlwNASW7Z2b4lT4W5V3fZaQ7gstoWwscL/2Oapl
 NLuBngXaduJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZcDQEgAKCRAADmhBGVaC
 FRalD/4y8GxrCyO4fl0X3p17gLzPFUyHuj6kfrt1C/3zu1PUyqodEXWf3cI7yYosdoMQLvrc5yj
 9VdmeuRzAxydNQZffWPDAiIM/O3Z8OG+1B9zZbQccFLQB/hh2YUXtQd++DWf3aDtprNu77siSVv
 8MUdZXc+9rO/60NXZNXpR8zyufSt6+MDQAlOTjeSMfjzEsdLeXqJ5Hll0AE1n/ncy1ioDnFPfUJ
 ur4PGNZ6ifS0Qzgdhucz3+x7T2sM4bEifdFZWuVeJrv6TT1+j9VWyxx+lAL3/zh7wJUQdDlYAAe
 tmStu2SircP2WnZbD6pAs01PEqxXrJKyiRehal2BunTrAxcwCZleEvtxt/iB4DQj0DwV+5V9V30
 RqEz1fzR8lWdqmTyi3ilz5BiOt+XCAI0FobxGjcP/4fhL7dyZVa6QUqrcG0sLQ2x9muQZzZ6sZQ
 QJtzTPQR7p5hCDpbpiRqvAXfjj3q6Msg/n3lhtowT5anKKXANb+BNOL+cLCDxdL0/c1eD94M7Cw
 4JqpNa4hJWCmpRtqQBgseKi+tkOptcrL4KPGzlIoTAXW6itEIzPU9pr56qP2Jb0vVl9wo0Bvf3K
 7BgHiLMoOYp5T3WUjOR0u0ErHw6B7TyKb+SJKEZnKppeRGjblMlVYBvY85AVLiZxuFuLx8iN2M+
 yoadsJcfsRsuz1g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Zdenek reported seeing some AVC denials due to nfsd trying to set
delegations:

    type=AVC msg=audit(09.11.2023 09:03:46.411:496) : avc:  denied  { lease } for  pid=5127 comm=rpc.nfsd capability=lease  scontext=system_u:system_r:nfsd_t:s0 tcontext=system_u:system_r:nfsd_t:s0 tclass=capability permissive=0

When setting delegations on behalf of nfsd, we don't want to do all of
the normal capabilty and LSM checks. nfsd is a kernel thread and runs
with CAP_LEASE set, so the uid checks end up being a no-op in most cases
anyway.

Some nfsd functions can end up running in normal process context when
tearing down the server. At that point, the CAP_LEASE check can fail and
cause the client to not tear down delegations when expected.

Also, the way the per-fs ->setlease handlers work today is a little
convoluted. The non-trivial ones are wrappers around generic_setlease,
so when they fail due to permission problems they usually they end up
doing a little extra work only to determine that they can't set the
lease anyway. It would be more efficient to do those checks earlier.

Transplant the permission checking from generic_setlease to
vfs_setlease, which will make the permission checking happen earlier on
filesystems that have a ->setlease operation. Add a new kernel_setlease
function that bypasses these checks, and switch nfsd to use that instead
of vfs_setlease.

There is one behavioral change here: prior this patch the
setlease_notifier would fire even if the lease attempt was going to fail
the security checks later. With this change, it doesn't fire until the
caller has passed them. I think this is a desirable change overall. nfsd
is the only user of the setlease_notifier and it doesn't benefit from
being notified about failed attempts.

Cc: Ondrej Mosnáček <omosnacek@gmail.com>
Reported-by: Zdenek Pytela <zpytela@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2248830
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This patch is based on top of a merge of Christian's vfs.file branch
(which has the file_lock/lease split). There is a small merge confict
with Chuck's nfsd-next patch, but it should be fairly simple to resolve.
---
 fs/locks.c               | 43 +++++++++++++++++++++++++------------------
 fs/nfsd/nfs4layouts.c    |  5 ++---
 fs/nfsd/nfs4state.c      |  8 ++++----
 include/linux/filelock.h |  7 +++++++
 4 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 33c7f4a8c729..26d52ef5314a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1925,18 +1925,6 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	struct inode *inode = file_inode(filp);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
-	int error;
-
-	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
-		return -EACCES;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-	error = security_file_lock(filp, arg);
-	if (error)
-		return error;
-
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
@@ -1987,6 +1975,19 @@ void lease_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(lease_unregister_notifier);
 
+
+int
+kernel_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
+{
+	if (lease)
+		setlease_notifier(arg, *lease);
+	if (filp->f_op->setlease)
+		return filp->f_op->setlease(filp, arg, lease, priv);
+	else
+		return generic_setlease(filp, arg, lease, priv);
+}
+EXPORT_SYMBOL_GPL(kernel_setlease);
+
 /**
  * vfs_setlease        -       sets a lease on an open file
  * @filp:	file pointer
@@ -2007,12 +2008,18 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
 int
 vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 {
-	if (lease)
-		setlease_notifier(arg, *lease);
-	if (filp->f_op->setlease)
-		return filp->f_op->setlease(filp, arg, lease, priv);
-	else
-		return generic_setlease(filp, arg, lease, priv);
+	struct inode *inode = file_inode(filp);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
+	int error;
+
+	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
+		return -EACCES;
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+	error = security_file_lock(filp, arg);
+	if (error)
+		return error;
+	return kernel_setlease(filp, arg, lease, priv);
 }
 EXPORT_SYMBOL_GPL(vfs_setlease);
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 4fa21b74a981..4c0d00bdfbb1 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -170,7 +170,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	spin_unlock(&fp->fi_lock);
 
 	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
-		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
+		kernel_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
 	nfsd_file_put(ls->ls_file);
 
 	if (ls->ls_recalled)
@@ -199,8 +199,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = ls->ls_file->nf_file;
 
-	status = vfs_setlease(fl->c.flc_file, fl->c.flc_type, &fl,
-			      NULL);
+	status = kernel_setlease(fl->c.flc_file, fl->c.flc_type, &fl, NULL);
 	if (status) {
 		locks_free_lease(fl);
 		return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b2c8efb5f793..6d52ecba8e9c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1249,7 +1249,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
-	vfs_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
 
@@ -5532,8 +5532,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = vfs_setlease(fp->fi_deleg_file->nf_file,
-			      fl->c.flc_type, &fl, NULL);
+	status = kernel_setlease(fp->fi_deleg_file->nf_file,
+				      fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
 	if (status)
@@ -5571,7 +5571,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	return dp;
 out_unlock:
-	vfs_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 4a5ad26962c1..cd6c1c291de9 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -208,6 +208,7 @@ struct file_lease *locks_alloc_lease(void);
 int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
 int generic_setlease(struct file *, int, struct file_lease **, void **priv);
+int kernel_setlease(struct file *, int, struct file_lease **, void **);
 int vfs_setlease(struct file *, int, struct file_lease **, void **);
 int lease_modify(struct file_lease *, int, struct list_head *);
 
@@ -357,6 +358,12 @@ static inline int generic_setlease(struct file *filp, int arg,
 	return -EINVAL;
 }
 
+static inline int kernel_setlease(struct file *filp, int arg,
+			       struct file_lease **lease, void **priv)
+{
+	return -EINVAL;
+}
+
 static inline int vfs_setlease(struct file *filp, int arg,
 			       struct file_lease **lease, void **priv)
 {

---
base-commit: 1499e59af376949b062cdc039257f811f6c1697f
change-id: 20240202-bz2248830-03e6c7506705

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


