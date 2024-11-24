Return-Path: <linux-fsdevel+bounces-35681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C382B9D761D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D0DBC3F01
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F7208960;
	Sun, 24 Nov 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOyw+igD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4226207A3B;
	Sun, 24 Nov 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455869; cv=none; b=sfJ5Kd3o4xg6ob3DZZxQSweTVR6SVeYcw5Ufg94QC1ZxdrbhoGD0ajzhsH7lYgetqyHt55nR05WzvFReJ4KxE3/k7062EbVoZX5t94nm3hc+6CCVhA9aawLG2ICbUcCnH1vFuS4cMC6qJuCek32FrZa7fRsaW2MVVWeMD48bGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455869; c=relaxed/simple;
	bh=eMs5v/Nm9a5GIOa2F0w8zTVJ777CLuzywV7nz78l/zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmhPGX5JAour5JRsPWHNq2Xh3p3yD3S+322PrIJ37+9cMUlPftQfxSZci2xKIw+D989PITP6K90iKMKEEjkKRWf+ycf0p5moESI0LBdMiV9t6DN1zJfdTQIlDD374Ub7x9o1/ylt9jG2Pm5psJBySX/cwPu+gQ6VwlQ729r20go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOyw+igD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D322BC4CECC;
	Sun, 24 Nov 2024 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455868;
	bh=eMs5v/Nm9a5GIOa2F0w8zTVJ777CLuzywV7nz78l/zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOyw+igDT4G+F4UY+8O6287DuHPZ4njyfSJPGSkTfGbx3Xo7FqHP6155RpXNa0JR3
	 GB+oki9UGuqXhtUaZD+gm6A+zdSzOXuuUrrNr+SUjSCCX8Vvqard83JM7mlxvkpEXI
	 Cog4/c26wwP9KgK5wM4hyRN/XKTp4TfZWcy2L8H0RmGvs5mHrOqfbm/YqtwgfNJhp2
	 6ZAGgyJdQqItmPMFTIy3JRH5rANyDE6Tvks4C37jza+AdUEJVl0CdaySo3TEr4ct7x
	 D7N9IlY+ZCqBdGzYtMUlMx89F54zSQ3uEAD4ZatxtzmglbDfT8tJYIHfGvyxcVhAik
	 eLa3+rSY657KA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/26] tree-wide: s/revert_creds_light()/revert_creds()/g
Date: Sun, 24 Nov 2024 14:43:52 +0100
Message-ID: <20241124-work-cred-v1-6-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17093; i=brauner@kernel.org; h=from:subject:message-id; bh=eMs5v/Nm9a5GIOa2F0w8zTVJ777CLuzywV7nz78l/zk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7687KyNN7r3ZxR7SE8kfPtSEtrf47Hhh/WZZzZ1ngl +ybJVPjOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiHsbwz2RKlX/LOeZIbskT HacLOfZqzc0sc3o3c8pRVX+t9n0TmRgZVq/7enPZYekUM499YpNUNe75Rd92Z7Nfrb3WledNejc nEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Rename all calls to revert_creds_light() back to revert_creds().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c   |  2 +-
 drivers/crypto/ccp/sev-dev.c          |  2 +-
 drivers/target/target_core_configfs.c |  2 +-
 fs/aio.c                              |  2 +-
 fs/backing-file.c                     | 10 +++++-----
 fs/binfmt_misc.c                      |  2 +-
 fs/cachefiles/internal.h              |  2 +-
 fs/coredump.c                         |  2 +-
 fs/nfs/localio.c                      |  4 ++--
 fs/nfs/nfs4idmap.c                    |  2 +-
 fs/nfsd/auth.c                        |  2 +-
 fs/nfsd/filecache.c                   |  2 +-
 fs/nfsd/nfs4recover.c                 |  2 +-
 fs/open.c                             |  2 +-
 fs/overlayfs/copy_up.c                |  2 +-
 fs/overlayfs/dir.c                    |  2 +-
 fs/overlayfs/util.c                   |  2 +-
 fs/smb/client/cifs_spnego.c           |  2 +-
 fs/smb/client/cifsacl.c               |  4 ++--
 fs/smb/server/smb_common.c            |  2 +-
 include/linux/cred.h                  |  2 +-
 io_uring/io_uring.c                   |  2 +-
 io_uring/sqpoll.c                     |  2 +-
 kernel/acct.c                         |  2 +-
 kernel/cgroup/cgroup.c                |  2 +-
 kernel/trace/trace_events_user.c      |  2 +-
 net/dns_resolver/dns_query.c          |  2 +-
 27 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 729df15600efb743091d7e1b71a306cdfa9acbf0..96a2c3011ca82148b4ba547764a1f92e252dbf5f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -944,7 +944,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	} else
 		ret = assign_fw(fw, device);
 
-	put_cred(revert_creds_light(old_cred));
+	put_cred(revert_creds(old_cred));
 	put_cred(kern_cred);
 
 out:
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ffae20fd52bc03e7123b116251c77a3ccd7c6cde..187c34b02442dd50640f88713bc5f6f88a1990f4 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -249,7 +249,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	fp = file_open_root(&root, filename, flags, mode);
 	path_put(&root);
 
-	put_cred(revert_creds_light(old_cred));
+	put_cred(revert_creds(old_cred));
 
 	return fp;
 }
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 7788e1fe2633ded4f265ff874c62dc4a21fd1b6e..ec7a5598719397da5cadfed12a05ca8eb81e46a9 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3758,7 +3758,7 @@ static int __init target_core_init_configfs(void)
 	}
 	old_cred = override_creds(get_new_cred(kern_cred));
 	target_init_dbroot();
-	put_cred(revert_creds_light(old_cred));
+	put_cred(revert_creds(old_cred));
 	put_cred(kern_cred);
 
 	return 0;
diff --git a/fs/aio.c b/fs/aio.c
index 7e0ec687f480c05358c6c40638a7e187aafd8124..5e57dcaed7f1ae1e4b38009b51a665954b31f5bd 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1642,7 +1642,7 @@ static void aio_fsync_work(struct work_struct *work)
 	const struct cred *old_cred = override_creds(get_new_cred(iocb->fsync.creds));
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
-	put_cred(revert_creds_light(old_cred));
+	put_cred(revert_creds(old_cred));
 	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }
diff --git a/fs/backing-file.c b/fs/backing-file.c
index bcf8c0b9ff42e2dd30dc239bb2580942fe6c40a7..a38737592ec77b50fa4d417a98ca272ca5f89399 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -197,7 +197,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds_light(old_cred);
+	revert_creds(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);
@@ -264,7 +264,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 			backing_aio_cleanup(aio, ret);
 	}
 out:
-	revert_creds_light(old_cred);
+	revert_creds(old_cred);
 
 	return ret;
 }
@@ -283,7 +283,7 @@ ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 
 	old_cred = override_creds(ctx->cred);
 	ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
-	revert_creds_light(old_cred);
+	revert_creds(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);
@@ -314,7 +314,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	file_start_write(out);
 	ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
 	file_end_write(out);
-	revert_creds_light(old_cred);
+	revert_creds(old_cred);
 
 	if (ctx->end_write)
 		ctx->end_write(iocb, ret);
@@ -339,7 +339,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	old_cred = override_creds(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds_light(old_cred);
+	revert_creds(old_cred);
 
 	if (ctx->accessed)
 		ctx->accessed(vma->vm_file);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 63544051404a9ff5ec8a74c754c3acfbc91f3279..5692c512b740bb8f11d5da89a2e5f388aafebc13 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -828,7 +828,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 */
 		old_cred = override_creds(get_new_cred(file->f_cred));
 		f = open_exec(e->interpreter);
-		put_cred(revert_creds_light(old_cred));
+		put_cred(revert_creds(old_cred));
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 05b1d4cfb55afefd025c5f9c08afa81f67fdb9eb..1cfeb3b3831900b7c389c55c59fc7e3b84acfca6 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -399,7 +399,7 @@ static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
 static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 					 const struct cred *saved_cred)
 {
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 }
 
 /*
diff --git a/fs/coredump.c b/fs/coredump.c
index 4eae37892da58e982b53da4596952a1b3d2e1630..0d3a65cac546db6710eb1337b0a9c4ec0ffff679 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -781,7 +781,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(core_dumped);
-	put_cred(revert_creds_light(old_cred));
+	put_cred(revert_creds(old_cred));
 fail_creds:
 	put_cred(cred);
 fail:
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 374c6e35c7b4969ef193b71510ee9a34c45bb815..cb0ba4a810324cc9a4913767ce5a9b4f52c416ac 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -381,7 +381,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	nfs_local_read_done(iocb, status);
 	nfs_local_pgio_release(iocb);
 
-	put_cred(revert_creds_light(save_cred));
+	put_cred(revert_creds(save_cred));
 }
 
 static int
@@ -554,7 +554,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	nfs_local_vfs_getattr(iocb);
 	nfs_local_pgio_release(iocb);
 
-	put_cred(revert_creds_light(save_cred));
+	put_cred(revert_creds(save_cred));
 	current->flags = old_flags;
 }
 
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 3cae4057f8ba30914a91a3d368ace8f52175644d..25b6a8920a6545d43f437f2f0330ccc35380ccc3 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -313,7 +313,7 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 
 	saved_cred = override_creds(get_new_cred(id_resolver_cache));
 	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);
diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index dafea9183b4e6413d61c0c83a1b8f26a9712d5c6..c399a5f030afbde6ad7bc9cf28f1e354d74db9a8 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -27,7 +27,7 @@ int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 	int flags = nfsexp_flags(cred, exp);
 
 	/* discard any old override before preparing the new set */
-	put_cred(revert_creds_light(get_cred(current_real_cred())));
+	put_cred(revert_creds(get_cred(current_real_cred())));
 	new = prepare_creds();
 	if (!new)
 		return -ENOMEM;
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fef2b8eb3a94736cbe8342a95f205f173f598447..3ae9d8356d7de5190b4b038b1104b6d93d07eb65 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1252,7 +1252,7 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 
 	beres = nfsd_file_do_acquire(NULL, net, cred, client,
 				     fhp, may_flags, NULL, pnf, true);
-	put_cred(revert_creds_light(save_cred));
+	put_cred(revert_creds(save_cred));
 	return beres;
 }
 
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 475c47f1c0afa2de56038bbb7cdd9fc5e583c8bd..2834091cc988b1403aa2908f69e336f2fe4e0922 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -89,7 +89,7 @@ nfs4_save_creds(const struct cred **original_creds)
 static void
 nfs4_reset_creds(const struct cred *original)
 {
-	put_cred(revert_creds_light(original));
+	put_cred(revert_creds(original));
 }
 
 static void
diff --git a/fs/open.c b/fs/open.c
index bd0a34653f0ebe210ddfeabf5ea3bc002bf2833d..0a5cd8e74fb9bb4cc484d84096c6123b21acbf16 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -523,7 +523,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 	}
 out:
 	if (old_cred)
-		put_cred(revert_creds_light(old_cred));
+		put_cred(revert_creds(old_cred));
 
 	return res;
 }
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 7805667b2e05264c011cd41ff6f77b9ae0fb30d9..439bd9a5ceecc4d2f4dc5dfda7cea14c3d9411ba 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -749,7 +749,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 {
 	if (cc->new) {
-		put_cred(revert_creds_light(cc->old));
+		put_cred(revert_creds(cc->old));
 		put_cred(cc->new);
 	}
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 151271f0586c7249cfa61cd45d249ec930adaf82..c9993ff66fc26ec45ab5a5b4679d1d2056a01df2 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -575,7 +575,7 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 	}
 
 	/*
-	 * Caller is going to match this with revert_creds_light() and drop
+	 * Caller is going to match this with revert_creds() and drop
 	 * referenec on the returned creds.
 	 * We must be called with creator creds already, otherwise we risk
 	 * leaking creds.
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2513a79a10b0bd69fa9d1c8a0f4726f3246ac39c..0819c739cc2ffce0dfefa84d3ff8f9f103eec191 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -70,7 +70,7 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 
 void ovl_revert_creds(const struct cred *old_cred)
 {
-	revert_creds_light(old_cred);
+	revert_creds(old_cred);
 }
 
 /*
diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index f22dc0be357fa03cecc524976de5c69fddeef1ca..6284d924fdb1e25e07af7e10b6286df97c0942dd 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -175,7 +175,7 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	cifs_dbg(FYI, "key description = %s\n", description);
 	saved_cred = override_creds(get_new_cred(spnego_cred));
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 
 #ifdef CONFIG_CIFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index d65e094b97cb2b1bd1c79d1959443fd8cae93f8f..5718906369a96fc80bee6a472f93bac1159f1709 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -327,7 +327,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 out_key_put:
 	key_put(sidkey);
 out_revert_creds:
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 	return rc;
 
 invalidate_key:
@@ -438,7 +438,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 out_key_put:
 	key_put(sidkey);
 out_revert_creds:
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 	kfree(sidstr);
 
 	/*
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index f09652bcca542464ed2f27fce9e912f797410612..f1d770a214c8b2c7d7dd4083ef57c7130bbce52c 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -800,7 +800,7 @@ void ksmbd_revert_fsids(struct ksmbd_work *work)
 	WARN_ON(!work->saved_cred);
 
 	cred = current_cred();
-	put_cred(revert_creds_light(work->saved_cred));
+	put_cred(revert_creds(work->saved_cred));
 	put_cred(cred);
 	work->saved_cred = NULL;
 }
diff --git a/include/linux/cred.h b/include/linux/cred.h
index a049993d22cca4e122091309f11fbc9e10d2e955..7ce1551c8aa7b7e000dffbd49ba6b27530ebc9ef 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -178,7 +178,7 @@ static inline const struct cred *override_creds(const struct cred *override_cred
 	return old;
 }
 
-static inline const struct cred *revert_creds_light(const struct cred *revert_cred)
+static inline const struct cred *revert_creds(const struct cred *revert_cred)
 {
 	const struct cred *override_cred = current->cred;
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 946df208e7741a0e2e11eff2ee0b8978bcea7c3c..ad4d8e94a8665cf5f3e9ea0fd9bc6c03a03cc48f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1715,7 +1715,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		audit_uring_exit(!ret, ret);
 
 	if (creds)
-		put_cred(revert_creds_light(creds));
+		put_cred(revert_creds(creds));
 
 	if (ret == IOU_OK) {
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 0fd424442118f38db0307fe10e0c6ee102c1f185..1ca96347433695de1eb0e3bec7c6da4299e9ceb0 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -192,7 +192,7 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 		if (to_submit && wq_has_sleeper(&ctx->sqo_sq_wait))
 			wake_up(&ctx->sqo_sq_wait);
 		if (creds)
-			put_cred(revert_creds_light(creds));
+			put_cred(revert_creds(creds));
 	}
 
 	return ret;
diff --git a/kernel/acct.c b/kernel/acct.c
index a51a3b483fd9d94da916dc4e052ef4ab1042a39f..ea8c94887b5853b10e7a7e632f7b0bc4d52ab10b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -541,7 +541,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	}
 out:
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	put_cred(revert_creds_light(orig_cred));
+	put_cred(revert_creds(orig_cred));
 }
 
 /**
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2d618b577e52e0117f77340dac79581882599578..1a94e8b154beeed45d69056917f3dd9fc6d950fa 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5220,7 +5220,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
 					of->file->f_path.dentry->d_sb,
 					threadgroup, ctx->ns);
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 	if (ret)
 		goto out_finish;
 
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 857124d81f1255e7e6b4d18009b53191a71b57fc..c54ae15f425c2c1dad3f8c776027beca2f00a0a5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1476,7 +1476,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	else
 		ret = trace_remove_event_call(&user->call);
 
-	put_cred(revert_creds_light(old_cred));
+	put_cred(revert_creds(old_cred));
 	put_cred(cred);
 
 	return ret;
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index f8749d688d6676dd83d0c4b8e83ca893f1bd4248..0b0789fe2194151102d5234aca3fc2dae9a1ed69 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -126,7 +126,7 @@ int dns_query(struct net *net,
 	 */
 	saved_cred = override_creds(get_new_cred(dns_resolver_cache));
 	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
-	put_cred(revert_creds_light(saved_cred));
+	put_cred(revert_creds(saved_cred));
 	kfree(desc);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.45.2


