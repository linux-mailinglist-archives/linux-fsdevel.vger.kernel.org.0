Return-Path: <linux-fsdevel+bounces-35680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31709D72C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89367164589
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3A207A19;
	Sun, 24 Nov 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyDMGhK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5D207A04;
	Sun, 24 Nov 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455866; cv=none; b=BE8Vyy5NX82bJ0dU3sWYkaG8ctYgVF1iBXPhNCj2kGdQVXQv1n5ixU0rpjeKkMWHpPKI9muUkk2I1ZsamkJdaDtuvwjibWSSD50+0sYOuD0PqLy6O2fBoxuSDdnfTlOERnWO2J4ndQGzgiglqAX0sarKBSm64vnJq30KGs7AJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455866; c=relaxed/simple;
	bh=WWfyP6fjtkWePcltxVWGntOdT2OeTGPjZ86iLbr6p1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0fSpfi106jFNRgflkWQTImkBC18HoAe1F73jcxmAAUXWlcMkk3lqbJ/CSuDawb65CRKu4BxgQK93zhO1p2QP6ECBe33IzBUGkK1Fo2VxWrUTsTJnx0+OOc9lMZwzOg6G+TK1juhykJZOhHdR1HoSLf5X6zzxjtztHMif67kqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyDMGhK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02D3C4CECC;
	Sun, 24 Nov 2024 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455866;
	bh=WWfyP6fjtkWePcltxVWGntOdT2OeTGPjZ86iLbr6p1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyDMGhK2FEnKOtVdf5P9aG++pwfuSRub1Wv6v7G1p1HnImJrLKUssUnxKcDgRjHni
	 B6PzdPEe/7Kbljhd8+pruBfvWMjkql9vZwrp/qHIwTv/I1k3pWJ5OqZuMiOWBwzEgt
	 oMp1d5vyAS0+0ZMHUv4Rxf0BohCR1pY8Zs1SHlvk1ulzgenEZfH3po/JE6DBz2/6Pu
	 hdRQXwJwKzQ0KiGWFwPTy7eq5vdwa7T3bRqfXo+VstNTv9Q7Eu0I4eR0dQW/Za4A+O
	 W8Yp8ys2u+3gvc6F9CUj06mjWKEtrNLNxw/befvP2vUTL50rvp352eiJGLaSNKDEmt
	 8L6EIB7wuEEfQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/26] tree-wide: s/override_creds_light()/override_creds()/g
Date: Sun, 24 Nov 2024 14:43:51 +0100
Message-ID: <20241124-work-cred-v1-5-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19026; i=brauner@kernel.org; h=from:subject:message-id; bh=WWfyP6fjtkWePcltxVWGntOdT2OeTGPjZ86iLbr6p1o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7687s2VJuwrjAUTP4u3i1W+6h/IN/Oe4llQfb7H9W/ O07a7xTRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES+MjP8jxTXdOWK/Hu7sPyL 0OY6WWXOiMirPMe7Vdyq6spffD/4lOGfedlUtfp+lb9LcnUuVR31YDALeaO/QEwpf/1Km/tvBE4 xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Rename all calls to override_creds_light() back to overrid_creds().

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
 fs/nfsd/nfs4recover.c                 |  2 +-
 fs/nfsd/nfsfh.c                       |  2 +-
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
index 8e3323a618e4436746258ce289a524f98c3ff60a..729df15600efb743091d7e1b71a306cdfa9acbf0 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -912,7 +912,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds_light(get_new_cred(kern_cred));
+	old_cred = override_creds(get_new_cred(kern_cred));
 
 	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9111a51d53e0e74e6d66bffe5b4e1bf1bf9157d0..ffae20fd52bc03e7123b116251c77a3ccd7c6cde 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -244,7 +244,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
 	cred->fsuid = GLOBAL_ROOT_UID;
-	old_cred = override_creds_light(get_new_cred(cred));
+	old_cred = override_creds(get_new_cred(cred));
 
 	fp = file_open_root(&root, filename, flags, mode);
 	path_put(&root);
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 564bc71d2d0923b9fdd575d520fd22206259b40a..7788e1fe2633ded4f265ff874c62dc4a21fd1b6e 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3756,7 +3756,7 @@ static int __init target_core_init_configfs(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds_light(get_new_cred(kern_cred));
+	old_cred = override_creds(get_new_cred(kern_cred));
 	target_init_dbroot();
 	put_cred(revert_creds_light(old_cred));
 	put_cred(kern_cred);
diff --git a/fs/aio.c b/fs/aio.c
index 6b987c48b6712abe2601b23f6aa9fac74c09161c..7e0ec687f480c05358c6c40638a7e187aafd8124 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1639,7 +1639,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
-	const struct cred *old_cred = override_creds_light(get_new_cred(iocb->fsync.creds));
+	const struct cred *old_cred = override_creds(get_new_cred(iocb->fsync.creds));
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
 	put_cred(revert_creds_light(old_cred));
diff --git a/fs/backing-file.c b/fs/backing-file.c
index 526ddb4d6f764e8d3b0566ec51c5efa90faff0ee..bcf8c0b9ff42e2dd30dc239bb2580942fe6c40a7 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -176,7 +176,7 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 	    !(file->f_mode & FMODE_CAN_ODIRECT))
 		return -EINVAL;
 
-	old_cred = override_creds_light(ctx->cred);
+	old_cred = override_creds(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -233,7 +233,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	 */
 	flags &= ~IOCB_DIO_CALLER_COMP;
 
-	old_cred = override_creds_light(ctx->cred);
+	old_cred = override_creds(ctx->cred);
 	if (is_sync_kiocb(iocb)) {
 		rwf_t rwf = iocb_to_rw_flags(flags);
 
@@ -281,7 +281,7 @@ ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds_light(ctx->cred);
+	old_cred = override_creds(ctx->cred);
 	ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
 	revert_creds_light(old_cred);
 
@@ -310,7 +310,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds_light(ctx->cred);
+	old_cred = override_creds(ctx->cred);
 	file_start_write(out);
 	ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
 	file_end_write(out);
@@ -337,7 +337,7 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	old_cred = override_creds_light(ctx->cred);
+	old_cred = override_creds(ctx->cred);
 	ret = call_mmap(vma->vm_file, vma);
 	revert_creds_light(old_cred);
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 84a96abfd090230334f935f666a145571c78b3a8..63544051404a9ff5ec8a74c754c3acfbc91f3279 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -826,7 +826,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 * didn't matter much as only a privileged process could open
 		 * the register file.
 		 */
-		old_cred = override_creds_light(get_new_cred(file->f_cred));
+		old_cred = override_creds(get_new_cred(file->f_cred));
 		f = open_exec(e->interpreter);
 		put_cred(revert_creds_light(old_cred));
 		if (IS_ERR(f)) {
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 809305dd531760d47e781064c1fc6e328849fc6b..05b1d4cfb55afefd025c5f9c08afa81f67fdb9eb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -393,7 +393,7 @@ extern int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
 static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
 					   const struct cred **_saved_cred)
 {
-	*_saved_cred = override_creds_light(get_new_cred(cache->cache_cred));
+	*_saved_cred = override_creds(get_new_cred(cache->cache_cred));
 }
 
 static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
diff --git a/fs/coredump.c b/fs/coredump.c
index ff119aaa5c313306b1183270a5d95904ed5951f4..4eae37892da58e982b53da4596952a1b3d2e1630 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -576,7 +576,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
-	old_cred = override_creds_light(get_new_cred(cred));
+	old_cred = override_creds(get_new_cred(cred));
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
 
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 77ff066aa938158cd8fcf691ebfbda6385f70449..374c6e35c7b4969ef193b71510ee9a34c45bb815 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -371,7 +371,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	struct iov_iter iter;
 	ssize_t status;
 
-	save_cred = override_creds_light(get_new_cred(filp->f_cred));
+	save_cred = override_creds(get_new_cred(filp->f_cred));
 
 	nfs_local_iter_init(&iter, iocb, READ);
 
@@ -541,7 +541,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	ssize_t status;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds_light(get_new_cred(filp->f_cred));
+	save_cred = override_creds(get_new_cred(filp->f_cred));
 
 	nfs_local_iter_init(&iter, iocb, WRITE);
 
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 629979b20e98cbc37e148289570574d9ba2e7675..3cae4057f8ba30914a91a3d368ace8f52175644d 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -311,7 +311,7 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 	const struct user_key_payload *payload;
 	ssize_t ret;
 
-	saved_cred = override_creds_light(get_new_cred(id_resolver_cache));
+	saved_cred = override_creds(get_new_cred(id_resolver_cache));
 	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
 	put_cred(revert_creds_light(saved_cred));
 
diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index dda14811d092689e5aa44bdd29f25403e4e3a780..dafea9183b4e6413d61c0c83a1b8f26a9712d5c6 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -79,7 +79,7 @@ int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 	else
 		new->cap_effective = cap_raise_nfsd_set(new->cap_effective,
 							new->cap_permitted);
-	put_cred(override_creds_light(get_new_cred(new)));
+	put_cred(override_creds(get_new_cred(new)));
 	put_cred(new);
 	return 0;
 
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 61c8f4ab10777952088d1312f2e3d606dbc4f801..475c47f1c0afa2de56038bbb7cdd9fc5e583c8bd 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -81,7 +81,7 @@ nfs4_save_creds(const struct cred **original_creds)
 
 	new->fsuid = GLOBAL_ROOT_UID;
 	new->fsgid = GLOBAL_ROOT_GID;
-	*original_creds = override_creds_light(get_new_cred(new));
+	*original_creds = override_creds(get_new_cred(new));
 	put_cred(new);
 	return 0;
 }
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8e323cc8e2c5b26ec660ceedeb95be4ef0ac809e..60b0275d5529d49ac87e8b89e4eb650ecd624f71 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -221,7 +221,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		new->cap_effective =
 			cap_raise_nfsd_set(new->cap_effective,
 					   new->cap_permitted);
-		put_cred(override_creds_light(get_new_cred(new)));
+		put_cred(override_creds(get_new_cred(new)));
 		put_cred(new);
 	} else {
 		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
diff --git a/fs/open.c b/fs/open.c
index 23c414c10883927129a925a33680affc6f3a0a78..bd0a34653f0ebe210ddfeabf5ea3bc002bf2833d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -448,7 +448,7 @@ static const struct cred *access_override_creds(void)
 	 */
 	override_cred->non_rcu = 1;
 
-	old_cred = override_creds_light(get_new_cred(override_cred));
+	old_cred = override_creds(get_new_cred(override_cred));
 
 	/* override_cred() gets its own ref */
 	put_cred(override_cred);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 0f19bdbc78a45f35df2829ccc8cc65deef244ffd..7805667b2e05264c011cd41ff6f77b9ae0fb30d9 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -741,7 +741,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 		return err;
 
 	if (cc->new)
-		cc->old = override_creds_light(get_new_cred(cc->new));
+		cc->old = override_creds(get_new_cred(cc->new));
 
 	return 0;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 08e683917d121b1fe8f0f0b4d4ba4f0f3c72f47d..151271f0586c7249cfa61cd45d249ec930adaf82 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -580,7 +580,7 @@ static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 	 * We must be called with creator creds already, otherwise we risk
 	 * leaking creds.
 	 */
-	old_cred = override_creds_light(override_cred);
+	old_cred = override_creds(override_cred);
 	WARN_ON_ONCE(old_cred != ovl_creds(dentry->d_sb));
 
 	return override_cred;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 9aa7493b1e10365cbcc97fceab26d614a319727f..2513a79a10b0bd69fa9d1c8a0f4726f3246ac39c 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -65,7 +65,7 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = OVL_FS(sb);
 
-	return override_creds_light(ofs->creator_cred);
+	return override_creds(ofs->creator_cred);
 }
 
 void ovl_revert_creds(const struct cred *old_cred)
diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index f2353bccc9f5e4637772a89dd0b0f42861fd21f3..f22dc0be357fa03cecc524976de5c69fddeef1ca 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -173,7 +173,7 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	}
 
 	cifs_dbg(FYI, "key description = %s\n", description);
-	saved_cred = override_creds_light(get_new_cred(spnego_cred));
+	saved_cred = override_creds(get_new_cred(spnego_cred));
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
 	put_cred(revert_creds_light(saved_cred));
 
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 81d8d9802a56d4bb5d3d0480396f0c78c4c3fb80..d65e094b97cb2b1bd1c79d1959443fd8cae93f8f 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -292,7 +292,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 		return -EINVAL;
 
 	rc = 0;
-	saved_cred = override_creds_light(get_new_cred(root_cred));
+	saved_cred = override_creds(get_new_cred(root_cred));
 	sidkey = request_key(&cifs_idmap_key_type, desc, "");
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
@@ -398,7 +398,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	if (!sidstr)
 		return -ENOMEM;
 
-	saved_cred = override_creds_light(get_new_cred(root_cred));
+	saved_cred = override_creds(get_new_cred(root_cred));
 	sidkey = request_key(&cifs_idmap_key_type, sidstr, "");
 	if (IS_ERR(sidkey)) {
 		cifs_dbg(FYI, "%s: Can't map SID %s to a %cid\n",
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index b13abbf67827fcad9c35606344cca055c09ba9c3..f09652bcca542464ed2f27fce9e912f797410612 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -780,7 +780,7 @@ int __ksmbd_override_fsids(struct ksmbd_work *work,
 		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
 
 	WARN_ON(work->saved_cred);
-	work->saved_cred = override_creds_light(get_new_cred(cred));
+	work->saved_cred = override_creds(get_new_cred(cred));
 	if (!work->saved_cred) {
 		abort_creds(cred);
 		return -EINVAL;
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 439d7a1840e7ccbc94d814728698a4b383bc39b3..a049993d22cca4e122091309f11fbc9e10d2e955 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -170,7 +170,7 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 					  cred->cap_inheritable));
 }
 
-static inline const struct cred *override_creds_light(const struct cred *override_cred)
+static inline const struct cred *override_creds(const struct cred *override_cred)
 {
 	const struct cred *old = current->cred;
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a6a50e86791e79745ace095af68c4b658e4a2cdc..946df208e7741a0e2e11eff2ee0b8978bcea7c3c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1704,7 +1704,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		return -EBADF;
 
 	if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
-		creds = override_creds_light(get_new_cred(req->creds));
+		creds = override_creds(get_new_cred(req->creds));
 
 	if (!def->audit_skip)
 		audit_uring_entry(req->opcode);
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 42ca6e07e0f7b0fe54a9f09857f87fecb5aa7085..0fd424442118f38db0307fe10e0c6ee102c1f185 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -174,7 +174,7 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 		const struct cred *creds = NULL;
 
 		if (ctx->sq_creds != current_cred())
-			creds = override_creds_light(get_new_cred(ctx->sq_creds));
+			creds = override_creds(get_new_cred(ctx->sq_creds));
 
 		mutex_lock(&ctx->uring_lock);
 		if (!wq_list_empty(&ctx->iopoll_list))
diff --git a/kernel/acct.c b/kernel/acct.c
index 4e28aa9e1ef278cd7fb3160a27b549155ceaffc3..a51a3b483fd9d94da916dc4e052ef4ab1042a39f 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -501,7 +501,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	flim = rlimit(RLIMIT_FSIZE);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds_light(get_new_cred(file->f_cred));
+	orig_cred = override_creds(get_new_cred(file->f_cred));
 
 	/*
 	 * First check to see if there is enough free_space to continue
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 68b816955c9c7e0141a073f54b14949b4c37aae6..2d618b577e52e0117f77340dac79581882599578 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5216,7 +5216,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 * permissions using the credentials from file open to protect against
 	 * inherited fd attacks.
 	 */
-	saved_cred = override_creds_light(get_new_cred(of->file->f_cred));
+	saved_cred = override_creds(get_new_cred(of->file->f_cred));
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
 					of->file->f_path.dentry->d_sb,
 					threadgroup, ctx->ns);
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2fdadb2e8547ec86f48d84c81c95434c811cb3cd..857124d81f1255e7e6b4d18009b53191a71b57fc 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1469,7 +1469,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 */
 	cred->fsuid = GLOBAL_ROOT_UID;
 
-	old_cred = override_creds_light(get_new_cred(cred));
+	old_cred = override_creds(get_new_cred(cred));
 
 	if (visible)
 		ret = trace_add_event_call(&user->call);
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 297059b7e2a367f5e745aac4557cda5996689a00..f8749d688d6676dd83d0c4b8e83ca893f1bd4248 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -124,7 +124,7 @@ int dns_query(struct net *net,
 	/* make the upcall, using special credentials to prevent the use of
 	 * add_key() to preinstall malicious redirections
 	 */
-	saved_cred = override_creds_light(get_new_cred(dns_resolver_cache));
+	saved_cred = override_creds(get_new_cred(dns_resolver_cache));
 	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
 	put_cred(revert_creds_light(saved_cred));
 	kfree(desc);

-- 
2.45.2


