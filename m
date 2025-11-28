Return-Path: <linux-fsdevel+bounces-70157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3660C92A34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EEF3AC645
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBC2DCF74;
	Fri, 28 Nov 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQWbl6Wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8B2DC339;
	Fri, 28 Nov 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348683; cv=none; b=gJolCEoqNTeL1Wx0I/aDEsLK8mzI/iGFux2BCMNxdvT8PqtPz3DvohnbptHTEkogArWjduREE8edXPgRp4BMD1e6jsBXpOOdm81mZoMTN/OqW0YwesfawNMhnJNOwE6eMH6kF6qIAa1GoqCOK6/WqYkpPGKeBGRyN3aoWy8djGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348683; c=relaxed/simple;
	bh=mrooYwl8gy0JNi5bA0iPthDZmAr+2ccvtgX7oJU6FvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQAWU9phBFFdyZxYr1R088vgl+Euf5WW22d9KQSiNVugi4qrpberth84ehOofA6KgBv/Z/g0QLDGUQDInkhj1TPhj38k4fykOyuRBn2VzeVoky5EYIkL7+KXNaLBED0y3e6g25aAhbFezFWmjheFJBgTOPuyAzqStVOE5YaR7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQWbl6Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAC3C4CEF1;
	Fri, 28 Nov 2025 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348682;
	bh=mrooYwl8gy0JNi5bA0iPthDZmAr+2ccvtgX7oJU6FvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQWbl6WjTIh9PA9gYb73oaz8Dvphf2KMnJP9I5biyZO1mbGU9fj8T5eveudlNafIp
	 3sSWZK4jgMIbQfYaC6v65qiBgaWp+pLBI22DZqPNZTvGFmCI7LTVrsg4QO9LwVzHxO
	 cL8qX8lI3v7eqHK6F/KHkZJ3/zdRKGdX0X9sPFsyLHQEQJBnEayY4RUZxICiTOXfzP
	 4mrmUuhZYWRv4UsE/9P89Gv4w6F+4U//0W3zEg5mXKQJ4PDJWmmw8z9pn8uST3TXZ4
	 N/o/9vj2RoRI2vXge2SyyaBrNMj3lpPFVJ9jdgnwdUe4fyg5cNT6rTkWyVNzlpEsJT
	 S5L5saLyjJAcg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/17 for v6.19] cred guards
Date: Fri, 28 Nov 2025 17:48:19 +0100
Message-ID: <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12799; i=brauner@kernel.org; h=from:subject:message-id; bh=mrooYwl8gy0JNi5bA0iPthDZmAr+2ccvtgX7oJU6FvE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnpk/Yjv3tKN8tuWTsg880/nnuP53E86QdY1fVvrK ybPfxBxuaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAij+8x/E857tO0tHNdhd6M HWET46eVsJ/zXXOtvtn03Uq1AJXK8n2MDMvVPnexqRhVp8ZWeTZyL1K0MNZO9BHeUj55ZdTkP6x RTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains substantial credential infrastructure improvements adding
euard-based credential management that simplifies code and eliminates
manual reference counting in many subsystems.

Features

- Kernel Credential Guards

  Add with_kernel_creds() and scoped_with_kernel_creds() guards that allow
  using the kernel credentials without allocating and copying them. This
  was requested by Linus after seeing repeated prepare_kernel_creds() calls
  that duplicate the kernel credentials only to drop them again later.

  The new guards completely avoid the allocation and never expose the
  temporary variable to hold the kernel credentials anywhere in callers.

- Generic Credential Guards

  Add scoped_with_creds() guards for the common
  override_creds()/revert_creds() pattern. This builds on earlier work
  that made override_creds()/revert_creds() completely reference count
  free.

- Prepare Credential Guards

  Add prepare credential guards for the more complex pattern of
  preparing a new set of credentials and overriding the current
  credentials with them:
  (1) prepare_creds()
  (2) modify new creds
  (3) override_creds()
  (4) revert_creds()
  (5) put_cred()

Cleanups

- Make init_cred static since it should not be directly accessed.

- Add kernel_cred() helper to properly access the kernel credentials.

- Fix scoped_class() macro that was introduced two cycles ago.

- coredump: split out do_coredump() from vfs_coredump() for cleaner
  credential handling.

- coredump: move revert_cred() before coredump_cleanup().

- coredump: mark struct mm_struct as const.

- coredump: pass struct linux_binfmt as const.

- sev-dev: use guard for path.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc fs/backing-file.c
index 2a86bb6fcd13,ea137be16331..000000000000
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@@ -227,40 -267,14 +267,8 @@@ ssize_t backing_file_write_iter(struct 
  	    !(file->f_mode & FMODE_CAN_ODIRECT))
  		return -EINVAL;
  
- 	old_cred = override_creds(ctx->cred);
- 	if (is_sync_kiocb(iocb)) {
- 		rwf_t rwf = iocb_to_rw_flags(flags);
- 
- 		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
- 		if (ctx->end_write)
- 			ctx->end_write(iocb, ret);
- 	} else {
- 		struct backing_aio *aio;
- 
- 		ret = backing_aio_init_wq(iocb);
- 		if (ret)
- 			goto out;
- 
- 		ret = -ENOMEM;
- 		aio = kmem_cache_zalloc(backing_aio_cachep, GFP_KERNEL);
- 		if (!aio)
- 			goto out;
- 
- 		aio->orig_iocb = iocb;
- 		aio->end_write = ctx->end_write;
- 		kiocb_clone(&aio->iocb, iocb, get_file(file));
- 		aio->iocb.ki_flags = flags;
- 		aio->iocb.ki_complete = backing_aio_queue_completion;
- 		refcount_set(&aio->ref, 2);
- 		ret = vfs_iocb_iter_write(file, &aio->iocb, iter);
- 		backing_aio_put(aio);
- 		if (ret != -EIOCBQUEUED)
- 			backing_aio_cleanup(aio, ret);
- 	}
- out:
- 	revert_creds(old_cred);
 -	/*
 -	 * Stacked filesystems don't support deferred completions, don't copy
 -	 * this property in case it is set by the issuer.
 -	 */
 -	flags &= ~IOCB_DIO_CALLER_COMP;
--
- 	return ret;
+ 	scoped_with_creds(ctx->cred)
+ 		return do_backing_file_write_iter(file, iter, iocb, flags, ctx->end_write);
  }
  EXPORT_SYMBOL_GPL(backing_file_write_iter);
  
diff --cc fs/nfs/localio.c
index 656976b4f42c,0c89a9d1e089..000000000000
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@@ -620,37 -595,30 +620,34 @@@ static void nfs_local_call_read(struct 
  	struct nfs_local_kiocb *iocb =
  		container_of(work, struct nfs_local_kiocb, work);
  	struct file *filp = iocb->kiocb.ki_filp;
- 	const struct cred *save_cred;
 +	bool force_done = false;
  	ssize_t status;
 +	int n_iters;
  
- 	save_cred = override_creds(filp->f_cred);
- 
- 	n_iters = atomic_read(&iocb->n_iters);
- 	for (int i = 0; i < n_iters ; i++) {
- 		if (iocb->iter_is_dio_aligned[i]) {
- 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
- 			/* Only use AIO completion if DIO-aligned segment is last */
- 			if (i == iocb->end_iter_index) {
- 				iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
- 				iocb->aio_complete_work = nfs_local_read_aio_complete_work;
- 			}
- 		} else
- 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
- 
- 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
- 		if (status != -EIOCBQUEUED) {
- 			if (unlikely(status >= 0 && status < iocb->iters[i].count))
- 				force_done = true; /* Partial read */
- 			if (nfs_local_pgio_done(iocb, status, force_done)) {
- 				nfs_local_read_iocb_done(iocb);
- 				break;
+ 	scoped_with_creds(filp->f_cred) {
 -		for (int i = 0; i < iocb->n_iters ; i++) {
++		n_iters = atomic_read(&iocb->n_iters);
++		for (int i = 0; i < n_iters ; i++) {
+ 			if (iocb->iter_is_dio_aligned[i]) {
+ 				iocb->kiocb.ki_flags |= IOCB_DIRECT;
 -				iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
 -				iocb->aio_complete_work = nfs_local_read_aio_complete_work;
 -			}
++				/* Only use AIO completion if DIO-aligned segment is last */
++				if (i == iocb->end_iter_index) {
++					iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
++					iocb->aio_complete_work = nfs_local_read_aio_complete_work;
++				}
++			} else
++				iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
+ 
 -			iocb->kiocb.ki_pos = iocb->offset[i];
+ 			status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
+ 			if (status != -EIOCBQUEUED) {
 -				nfs_local_pgio_done(iocb->hdr, status);
 -				if (iocb->hdr->task.tk_status)
++				if (unlikely(status >= 0 && status < iocb->iters[i].count))
++					force_done = true; /* Partial read */
++				if (nfs_local_pgio_done(iocb, status, force_done)) {
++					nfs_local_read_iocb_done(iocb);
+ 					break;
++				}
  			}
  		}
  	}
--
- 	revert_creds(save_cred);
 -	if (status != -EIOCBQUEUED) {
 -		nfs_local_read_done(iocb, status);
 -		nfs_local_pgio_release(iocb);
 -	}
  }
  
  static int
@@@ -826,41 -839,20 +823,40 @@@ static void nfs_local_call_write(struc
  		container_of(work, struct nfs_local_kiocb, work);
  	struct file *filp = iocb->kiocb.ki_filp;
  	unsigned long old_flags = current->flags;
- 	const struct cred *save_cred;
 +	bool force_done = false;
  	ssize_t status;
 +	int n_iters;
  
  	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
- 	save_cred = override_creds(filp->f_cred);
  
 -	scoped_with_creds(filp->f_cred)
 -		status = do_nfs_local_call_write(iocb, filp);
 -
 -	current->flags = old_flags;
++	scoped_with_creds(filp->f_cred) {
 +	file_start_write(filp);
- 	n_iters = atomic_read(&iocb->n_iters);
- 	for (int i = 0; i < n_iters ; i++) {
- 		if (iocb->iter_is_dio_aligned[i]) {
- 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
- 			/* Only use AIO completion if DIO-aligned segment is last */
- 			if (i == iocb->end_iter_index) {
- 				iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
- 				iocb->aio_complete_work = nfs_local_write_aio_complete_work;
- 			}
- 		} else
- 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
- 
- 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
- 		if (status != -EIOCBQUEUED) {
- 			if (unlikely(status >= 0 && status < iocb->iters[i].count))
- 				force_done = true; /* Partial write */
- 			if (nfs_local_pgio_done(iocb, status, force_done)) {
- 				nfs_local_write_iocb_done(iocb);
- 				break;
++		n_iters = atomic_read(&iocb->n_iters);
++		for (int i = 0; i < n_iters ; i++) {
++			if (iocb->iter_is_dio_aligned[i]) {
++				iocb->kiocb.ki_flags |= IOCB_DIRECT;
++				/* Only use AIO completion if DIO-aligned segment is last */
++				if (i == iocb->end_iter_index) {
++					iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
++					iocb->aio_complete_work = nfs_local_write_aio_complete_work;
++				}
++			} else
++				iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
+ 
 -	if (status != -EIOCBQUEUED) {
 -		nfs_local_write_done(iocb, status);
 -		nfs_local_vfs_getattr(iocb);
 -		nfs_local_pgio_release(iocb);
++			status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
++			if (status != -EIOCBQUEUED) {
++				if (unlikely(status >= 0 && status < iocb->iters[i].count))
++					force_done = true; /* Partial write */
++				if (nfs_local_pgio_done(iocb, status, force_done)) {
++					nfs_local_write_iocb_done(iocb);
++					break;
++				}
 +			}
 +		}
++		file_end_write(filp);
  	}
- 	file_end_write(filp);
 +
- 	revert_creds(save_cred);
 +	current->flags = old_flags;
  }
  
  static int

Merge conflicts with other trees
================================

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.19-rc1.cred

for you to fetch changes up to c8e00cdc7425d5c60fd1ce6e7f71e5fb1b236991:

  Merge patch series "credential guards: credential preparation" (2025-11-05 23:11:52 +0100)

Please consider pulling these changes from the signed kernel-6.19-rc1.cred tag.

Thanks!
Christian

----------------------------------------------------------------
kernel-6.19-rc1.cred

----------------------------------------------------------------
Christian Brauner (39):
      cleanup: fix scoped_class()
      cred: add kernel_cred() helper
      cred: make init_cred static
      cred: add scoped_with_kernel_creds()
      firmware: don't copy kernel creds
      nbd: don't copy kernel creds
      target: don't copy kernel creds
      unix: don't copy creds
      Merge patch series "creds: add {scoped_}with_kernel_creds()"
      cred: add scoped_with_creds() guards
      aio: use credential guards
      backing-file: use credential guards for reads
      backing-file: use credential guards for writes
      backing-file: use credential guards for splice read
      backing-file: use credential guards for splice write
      backing-file: use credential guards for mmap
      binfmt_misc: use credential guards
      erofs: use credential guards
      nfs: use credential guards in nfs_local_call_read()
      nfs: use credential guards in nfs_local_call_write()
      nfs: use credential guards in nfs_idmap_get_key()
      smb: use credential guards in cifs_get_spnego_key()
      act: use credential guards in acct_write_process()
      cgroup: use credential guards in cgroup_attach_permissions()
      net/dns_resolver: use credential guards in dns_query()
      Merge patch series "credentials guards: the easy cases"
      cred: add prepare credential guard
      sev-dev: use guard for path
      sev-dev: use prepare credential guard
      sev-dev: use override credential guards
      coredump: move revert_cred() before coredump_cleanup()
      coredump: pass struct linux_binfmt as const
      coredump: mark struct mm_struct as const
      coredump: split out do_coredump() from vfs_coredump()
      coredump: use prepare credential guard
      coredump: use override credential guard
      trace: use prepare credential guard
      trace: use override credential guard
      Merge patch series "credential guards: credential preparation"

 drivers/base/firmware_loader/main.c   |  59 ++++++--------
 drivers/block/nbd.c                   |  54 +++++--------
 drivers/crypto/ccp/sev-dev.c          |  17 ++--
 drivers/target/target_core_configfs.c |  14 +---
 fs/aio.c                              |   6 +-
 fs/backing-file.c                     | 147 +++++++++++++++++-----------------
 fs/binfmt_misc.c                      |   7 +-
 fs/coredump.c                         | 142 ++++++++++++++++----------------
 fs/erofs/fileio.c                     |   6 +-
 fs/nfs/localio.c                      |  59 +++++++-------
 fs/nfs/nfs4idmap.c                    |   7 +-
 fs/smb/client/cifs_spnego.c           |   6 +-
 include/linux/cleanup.h               |  15 ++--
 include/linux/cred.h                  |  22 +++++
 include/linux/init_task.h             |   1 -
 include/linux/sched/coredump.h        |   2 +-
 init/init_task.c                      |  27 +++++++
 kernel/acct.c                         |  29 +++----
 kernel/cgroup/cgroup.c                |  10 +--
 kernel/cred.c                         |  27 -------
 kernel/trace/trace_events_user.c      |  22 ++---
 net/dns_resolver/dns_query.c          |   6 +-
 net/unix/af_unix.c                    |  17 +---
 security/keys/process_keys.c          |   2 +-
 24 files changed, 330 insertions(+), 374 deletions(-)

