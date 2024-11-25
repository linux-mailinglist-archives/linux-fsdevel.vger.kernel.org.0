Return-Path: <linux-fsdevel+bounces-35799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58229D876E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964E728A01E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F571B218D;
	Mon, 25 Nov 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHl4YY3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A41B0F2E;
	Mon, 25 Nov 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543828; cv=none; b=r/rk7QKf4ESK1oT25SQVn25IfMhXW1ihOS4V5L5o2XMsoAw7T0lA3mlLIFL2JTMANQb4nYszhPrlAuxmJ6BOyhz3F3X9orGP2O20++7nP47glGk3VzmzZK2I5ImuUCbP7zDx/uCsj3m2FEgl0Hc3cxuqJcP5fahfTipDNEzBK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543828; c=relaxed/simple;
	bh=gC0jRr7SJocuxeu8i3/i44uK6+CHFY73c8gGSEAwCj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCprbJpG2IT6QFXFPLuyVqz/DYmNrpJ1p7H+8ghx4OG2IulqXOe2Y27qwiEYkLiZL+rMgO7BOBlpIDuxCXD+Qtd/CbPBHh8xSBgrNImKswJ+yldtUWRbdV6Ykb6agJ0Kll41wyRtd/X1WfKu97nT2oujSyErF0SYGe0iuwU17kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHl4YY3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D16C4CED2;
	Mon, 25 Nov 2024 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543828;
	bh=gC0jRr7SJocuxeu8i3/i44uK6+CHFY73c8gGSEAwCj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SHl4YY3Z+QXIKiagn6NwKLE6FHUdqFGEEBAnhfqvH/yUfKukHgf32Mmn/f3Y928Wx
	 Osrhl8K8G4rQJZpXyUjIFfyV2A1NQph0wjhuxkuGzNgVx2feBQzM7xi2Mhfbi/1k1c
	 3+RKYeTKO6fjhZ8hiCKxlaNgaMYsc5cMHMN4SFKBkkiND0apwJBeXAyH7NbhMP+FYZ
	 TvdlLs+rhkUyKS4SxAwKX72uYfRH0xzw63FVsIgXpzyP/qluthFsfc2yaJQScEJ/sP
	 qebQWHlUOCAA7Yk72N5DY1K50ifCD6+puP4FRVuP0qQTWDy5g2Yx06nxC8wppspNb8
	 Zv7DmdrXJpetA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:09:59 +0100
Subject: [PATCH v2 03/29] tree-wide:
 s/revert_creds()/put_cred(revert_creds_light())/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-3-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13577; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gC0jRr7SJocuxeu8i3/i44uK6+CHFY73c8gGSEAwCj8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHrMn560sF9WkX293KK4dSlf7rsyfXnuEx3pfG9HR
 cJ7Xd6ojlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImoTWNkmCElVWcgmPB6jf/3
 Obu7ZidrL/Uof5u+rfdwIcfiHT9v72f4Z/hSSGqHZ8G+4MOOLTEzPrDUPl3kx1bsc/nh3Ly+J7e
 EOAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Convert all calls to revert_creds() over to explicitly dropping
reference counts in preparation for converting revert_creds() to
revert_creds_light() semantics.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c   | 2 +-
 drivers/crypto/ccp/sev-dev.c          | 2 +-
 drivers/target/target_core_configfs.c | 2 +-
 fs/aio.c                              | 2 +-
 fs/binfmt_misc.c                      | 2 +-
 fs/cachefiles/internal.h              | 2 +-
 fs/coredump.c                         | 2 +-
 fs/nfs/localio.c                      | 4 ++--
 fs/nfs/nfs4idmap.c                    | 2 +-
 fs/nfsd/auth.c                        | 2 +-
 fs/nfsd/filecache.c                   | 2 +-
 fs/nfsd/nfs4recover.c                 | 2 +-
 fs/open.c                             | 2 +-
 fs/overlayfs/copy_up.c                | 2 +-
 fs/smb/client/cifs_spnego.c           | 2 +-
 fs/smb/client/cifsacl.c               | 4 ++--
 fs/smb/server/smb_common.c            | 2 +-
 io_uring/io_uring.c                   | 2 +-
 io_uring/sqpoll.c                     | 2 +-
 kernel/acct.c                         | 2 +-
 kernel/cgroup/cgroup.c                | 2 +-
 kernel/trace/trace_events_user.c      | 2 +-
 net/dns_resolver/dns_query.c          | 2 +-
 23 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 74039d6b2b71b91d0d1d57b71f74501abaf646e2..8e3323a618e4436746258ce289a524f98c3ff60a 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -944,7 +944,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	} else
 		ret = assign_fw(fw, device);
 
-	revert_creds(old_cred);
+	put_cred(revert_creds_light(old_cred));
 	put_cred(kern_cred);
 
 out:
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2ad6e41af085a400e88b3207c9b55345f57526e1..9111a51d53e0e74e6d66bffe5b4e1bf1bf9157d0 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -249,7 +249,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	fp = file_open_root(&root, filename, flags, mode);
 	path_put(&root);
 
-	revert_creds(old_cred);
+	put_cred(revert_creds_light(old_cred));
 
 	return fp;
 }
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index be98d16b2c57c933ffe2c2477b881144f2283630..564bc71d2d0923b9fdd575d520fd22206259b40a 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3758,7 +3758,7 @@ static int __init target_core_init_configfs(void)
 	}
 	old_cred = override_creds_light(get_new_cred(kern_cred));
 	target_init_dbroot();
-	revert_creds(old_cred);
+	put_cred(revert_creds_light(old_cred));
 	put_cred(kern_cred);
 
 	return 0;
diff --git a/fs/aio.c b/fs/aio.c
index a52fe2e999e73b00af9a19f1c01f0e384f667871..6b987c48b6712abe2601b23f6aa9fac74c09161c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1642,7 +1642,7 @@ static void aio_fsync_work(struct work_struct *work)
 	const struct cred *old_cred = override_creds_light(get_new_cred(iocb->fsync.creds));
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
-	revert_creds(old_cred);
+	put_cred(revert_creds_light(old_cred));
 	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index f8355eee3d19ef6d20565ec1938e8691ba084d83..84a96abfd090230334f935f666a145571c78b3a8 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -828,7 +828,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 */
 		old_cred = override_creds_light(get_new_cred(file->f_cred));
 		f = open_exec(e->interpreter);
-		revert_creds(old_cred);
+		put_cred(revert_creds_light(old_cred));
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b156cc2e0e63b28b521923b578cb3547dece5e66..809305dd531760d47e781064c1fc6e328849fc6b 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -399,7 +399,7 @@ static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
 static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 					 const struct cred *saved_cred)
 {
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 }
 
 /*
diff --git a/fs/coredump.c b/fs/coredump.c
index b6aae41b80d22bfed78eed6f3e45bdeb5d2daf06..ff119aaa5c313306b1183270a5d95904ed5951f4 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -781,7 +781,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(core_dumped);
-	revert_creds(old_cred);
+	put_cred(revert_creds_light(old_cred));
 fail_creds:
 	put_cred(cred);
 fail:
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 018e8159c5679757f9fbf257ad3ef60e89d3ee09..77ff066aa938158cd8fcf691ebfbda6385f70449 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -381,7 +381,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	nfs_local_read_done(iocb, status);
 	nfs_local_pgio_release(iocb);
 
-	revert_creds(save_cred);
+	put_cred(revert_creds_light(save_cred));
 }
 
 static int
@@ -554,7 +554,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	nfs_local_vfs_getattr(iocb);
 	nfs_local_pgio_release(iocb);
 
-	revert_creds(save_cred);
+	put_cred(revert_creds_light(save_cred));
 	current->flags = old_flags;
 }
 
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index b9442f70271d8397fb36dcb62570f6d304fe5c71..629979b20e98cbc37e148289570574d9ba2e7675 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -313,7 +313,7 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 
 	saved_cred = override_creds_light(get_new_cred(id_resolver_cache));
 	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);
diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index 614a5ec4824b4ab9f6faa132c565688c94261704..dda14811d092689e5aa44bdd29f25403e4e3a780 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -27,7 +27,7 @@ int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 	int flags = nfsexp_flags(cred, exp);
 
 	/* discard any old override before preparing the new set */
-	revert_creds(get_cred(current_real_cred()));
+	put_cred(revert_creds_light(get_cred(current_real_cred())));
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2e6783f63712454509c526969a622040985da577..fef2b8eb3a94736cbe8342a95f205f173f598447 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1252,7 +1252,7 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 
 	beres = nfsd_file_do_acquire(NULL, net, cred, client,
 				     fhp, may_flags, NULL, pnf, true);
-	revert_creds(save_cred);
+	put_cred(revert_creds_light(save_cred));
 	return beres;
 }
 
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index f55ed06611aaaffa6dc8723b96b9876a3a3db0f7..61c8f4ab10777952088d1312f2e3d606dbc4f801 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -89,7 +89,7 @@ nfs4_save_creds(const struct cred **original_creds)
 static void
 nfs4_reset_creds(const struct cred *original)
 {
-	revert_creds(original);
+	put_cred(revert_creds_light(original));
 }
 
 static void
diff --git a/fs/open.c b/fs/open.c
index 2459cd061f47f46756b7d0a7bf2f563b631ec1d5..23c414c10883927129a925a33680affc6f3a0a78 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -523,7 +523,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	}
 out:
 	if (old_cred)
-		revert_creds(old_cred);
+		put_cred(revert_creds_light(old_cred));
 
 	return res;
 }
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 527b041213c8166d60d6a273675c2e2bc18dec36..0f19bdbc78a45f35df2829ccc8cc65deef244ffd 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -749,7 +749,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 {
 	if (cc->new) {
-		revert_creds(cc->old);
+		put_cred(revert_creds_light(cc->old));
 		put_cred(cc->new);
 	}
 }
diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index da89c334dff3d77ac02b37ae9668d40e04241942..dd270184e7104b597652893292e6586a78bf55c1 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -159,7 +159,7 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	cifs_dbg(FYI, "key description = %s\n", description);
 	saved_cred = override_creds_light(get_new_cred(spnego_cred));
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 
 #ifdef CONFIG_CIFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 136fd84cba004e0e89996e29abcac154dce8674b..1da3177fb6dc5a40a4ea79edc5525af11adf699a 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -327,7 +327,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 out_key_put:
 	key_put(sidkey);
 out_revert_creds:
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 	return rc;
 
 invalidate_key:
@@ -438,7 +438,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 out_key_put:
 	key_put(sidkey);
 out_revert_creds:
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 	kfree(sidstr);
 
 	/*
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index c2a59956e3a51b7727a7e358f3842d92d70f085d..b13abbf67827fcad9c35606344cca055c09ba9c3 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -800,7 +800,7 @@ void ksmbd_revert_fsids(struct ksmbd_work *work)
 	WARN_ON(!work->saved_cred);
 
 	cred = current_cred();
-	revert_creds(work->saved_cred);
+	put_cred(revert_creds_light(work->saved_cred));
 	put_cred(cred);
 	work->saved_cred = NULL;
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7ef3b67ebbde7b04d9428631ee72e7f45245feb4..a6a50e86791e79745ace095af68c4b658e4a2cdc 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1715,7 +1715,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		audit_uring_exit(!ret, ret);
 
 	if (creds)
-		revert_creds(creds);
+		put_cred(revert_creds_light(creds));
 
 	if (ret == IOU_OK) {
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 58a76d5818959a9d7eeef52a8bacd29eba3f3d26..42ca6e07e0f7b0fe54a9f09857f87fecb5aa7085 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -192,7 +192,7 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 		if (to_submit && wq_has_sleeper(&ctx->sqo_sq_wait))
 			wake_up(&ctx->sqo_sq_wait);
 		if (creds)
-			revert_creds(creds);
+			put_cred(revert_creds_light(creds));
 	}
 
 	return ret;
diff --git a/kernel/acct.c b/kernel/acct.c
index 8f18eb02dd416b884222b66f0f386379c46b30ea..4e28aa9e1ef278cd7fb3160a27b549155ceaffc3 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -541,7 +541,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	}
 out:
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	revert_creds(orig_cred);
+	put_cred(revert_creds_light(orig_cred));
 }
 
 /**
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 97329b4fe5027dcc5d80f6b074f4c494c4794df7..68b816955c9c7e0141a073f54b14949b4c37aae6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5220,7 +5220,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
 					of->file->f_path.dentry->d_sb,
 					threadgroup, ctx->ns);
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 	if (ret)
 		goto out_finish;
 
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4dd7c45d227e9459e694535cee3f853c09826cff..2fdadb2e8547ec86f48d84c81c95434c811cb3cd 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1476,7 +1476,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	else
 		ret = trace_remove_event_call(&user->call);
 
-	revert_creds(old_cred);
+	put_cred(revert_creds_light(old_cred));
 	put_cred(cred);
 
 	return ret;
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index a54f5f841cea1edd7f449d4e3e79e37b8ed865f4..297059b7e2a367f5e745aac4557cda5996689a00 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -126,7 +126,7 @@ int dns_query(struct net *net,
 	 */
 	saved_cred = override_creds_light(get_new_cred(dns_resolver_cache));
 	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
-	revert_creds(saved_cred);
+	put_cred(revert_creds_light(saved_cred));
 	kfree(desc);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.45.2


