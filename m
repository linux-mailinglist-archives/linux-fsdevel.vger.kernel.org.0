Return-Path: <linux-fsdevel+bounces-35676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8399D760C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBB4BC2A8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A8204F62;
	Sun, 24 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX5iixpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3842040A7;
	Sun, 24 Nov 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455858; cv=none; b=iegNmTXErE9ZV73k/70BhwnbxdK1LegIZs9D1qgjYggSZBjbTWhYGKOKtly3j4/yw4ZuHuVCYDiFgv+VdUXeYGSPCTzb/C6VT4W73Ry7MMewQe8wtXG1NAyvpGcL56HghYB4v3uP1Y3xvwpv9dn8IVcr9OXKowAgbCoK+UHhE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455858; c=relaxed/simple;
	bh=vSV0hLsIUoJrtYtJtCa6k/8o6hPHqRU5dFHPUwMtLG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulq22C0z+b8W48PoPQjnFSScI9CCFSZWCYJwPicfAuoynVk7BrUPyxpfvqXVA7uJh0v9kIvPfYIhJRPI1BR4+FF3jGvGF0A0Esq9dzGbd39JEd4w7ihlj4OzmpswfkNdmcbU4gEPHCDNrijlTchOzFA1hqO+DsEgTECRWy//pNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX5iixpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8523C4CED1;
	Sun, 24 Nov 2024 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455858;
	bh=vSV0hLsIUoJrtYtJtCa6k/8o6hPHqRU5dFHPUwMtLG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RX5iixpBRq9+IrpBtYOVuQgEKONo0YJHH50fIJBuR+faCpO+lbiTPkHjRb6jYFRsS
	 92gQPuA0d9KPoUyhmLhSxpmKODDHHJ8SD9CBs1begQb5qTlWDjS+iGOaWOWRXGVAGC
	 7joiDVLqjHwuuzkVu+xuCfEg+oSBrTULuZlVwLokd+JKTCyXsgKQrGdnpb8VvryCJ2
	 RaT1ACX/om7T5FuM7MPcvDg9x32KrTQOW8nib39cI7SqDQXr/whO1X01PkMRQaYI5h
	 zwlWIVeDp3XYi0J/xcZ7gEH7gqh2HBUsJ+PgK4mQENS8r145lfhNcQs6rifdzVxoKi
	 1u89ftyFLRFiQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/26] tree-wide: s/override_creds()/override_creds_light(get_new_cred())/g
Date: Sun, 24 Nov 2024 14:43:47 +0100
Message-ID: <20241124-work-cred-v1-1-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14871; i=brauner@kernel.org; h=from:subject:message-id; bh=vSV0hLsIUoJrtYtJtCa6k/8o6hPHqRU5dFHPUwMtLG4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76864+7N32rv6TS+rplZuaPSYlmgpMcVP7cSc4nsrU j6wPGUK6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI6CyG/8m/Z5euExBitpvc /PBTw/szE18nv73jZtj/atbm8K+MmvEM/32OLHdsD/7E6CsVI7b+Iw/HJZFFah1sHJ0rjz3lr+t YyQgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

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
 fs/nfsd/nfs4recover.c                 | 2 +-
 fs/nfsd/nfsfh.c                       | 2 +-
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
index 324a9a3c087aa2e2c4e0b53b30a2f11f61195aa3..74039d6b2b71b91d0d1d57b71f74501abaf646e2 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -912,7 +912,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds(kern_cred);
+	old_cred = override_creds_light(get_new_cred(kern_cred));
 
 	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index af018afd9cd7fc68c5f9004e2d0a2ee162d8c4b9..2ad6e41af085a400e88b3207c9b55345f57526e1 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -244,7 +244,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
 	cred->fsuid = GLOBAL_ROOT_UID;
-	old_cred = override_creds(cred);
+	old_cred = override_creds_light(get_new_cred(cred));
 
 	fp = file_open_root(&root, filename, flags, mode);
 	path_put(&root);
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index c40217f44b1bc53d149e8d5ea12c0e5297373800..be98d16b2c57c933ffe2c2477b881144f2283630 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3756,7 +3756,7 @@ static int __init target_core_init_configfs(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds(kern_cred);
+	old_cred = override_creds_light(get_new_cred(kern_cred));
 	target_init_dbroot();
 	revert_creds(old_cred);
 	put_cred(kern_cred);
diff --git a/fs/aio.c b/fs/aio.c
index 50671640b5883f5d20f652e23c4ea3fe04c989f2..a52fe2e999e73b00af9a19f1c01f0e384f667871 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1639,7 +1639,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
-	const struct cred *old_cred = override_creds(iocb->fsync.creds);
+	const struct cred *old_cred = override_creds_light(get_new_cred(iocb->fsync.creds));
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
 	revert_creds(old_cred);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 31660d8cc2c610bd42f00f1de7ed6c39618cc5db..f8355eee3d19ef6d20565ec1938e8691ba084d83 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -826,7 +826,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 * didn't matter much as only a privileged process could open
 		 * the register file.
 		 */
-		old_cred = override_creds(file->f_cred);
+		old_cred = override_creds_light(get_new_cred(file->f_cred));
 		f = open_exec(e->interpreter);
 		revert_creds(old_cred);
 		if (IS_ERR(f)) {
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7b99bd98de75b8d95e09da1ca7cd1bb3378fcc62..b156cc2e0e63b28b521923b578cb3547dece5e66 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -393,7 +393,7 @@ extern int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
 static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
 					   const struct cred **_saved_cred)
 {
-	*_saved_cred = override_creds(cache->cache_cred);
+	*_saved_cred = override_creds_light(get_new_cred(cache->cache_cred));
 }
 
 static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
diff --git a/fs/coredump.c b/fs/coredump.c
index d48edb37bc35c0896d97a2f6a6cc259d8812f936..b6aae41b80d22bfed78eed6f3e45bdeb5d2daf06 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -576,7 +576,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
-	old_cred = override_creds(cred);
+	old_cred = override_creds_light(get_new_cred(cred));
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
 
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 8f0ce82a677e1589092a30240d6e60a289d64a58..018e8159c5679757f9fbf257ad3ef60e89d3ee09 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -371,7 +371,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	struct iov_iter iter;
 	ssize_t status;
 
-	save_cred = override_creds(filp->f_cred);
+	save_cred = override_creds_light(get_new_cred(filp->f_cred));
 
 	nfs_local_iter_init(&iter, iocb, READ);
 
@@ -541,7 +541,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	ssize_t status;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds(filp->f_cred);
+	save_cred = override_creds_light(get_new_cred(filp->f_cred));
 
 	nfs_local_iter_init(&iter, iocb, WRITE);
 
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 25a7c771cfd89f3e6d494f26a78212d3d619c135..b9442f70271d8397fb36dcb62570f6d304fe5c71 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -311,7 +311,7 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 	const struct user_key_payload *payload;
 	ssize_t ret;
 
-	saved_cred = override_creds(id_resolver_cache);
+	saved_cred = override_creds_light(get_new_cred(id_resolver_cache));
 	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
 	revert_creds(saved_cred);
 
diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index 93e33d1ee8917fc5d462f56b5c65380f7555e638..614a5ec4824b4ab9f6faa132c565688c94261704 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -79,7 +79,7 @@ int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 	else
 		new->cap_effective = cap_raise_nfsd_set(new->cap_effective,
 							new->cap_permitted);
-	put_cred(override_creds(new));
+	put_cred(override_creds_light(get_new_cred(new)));
 	put_cred(new);
 	return 0;
 
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b7d61eb8afe9e10d94b614ae50c2790fe6816732..f55ed06611aaaffa6dc8723b96b9876a3a3db0f7 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -81,7 +81,7 @@ nfs4_save_creds(const struct cred **original_creds)
 
 	new->fsuid = GLOBAL_ROOT_UID;
 	new->fsgid = GLOBAL_ROOT_GID;
-	*original_creds = override_creds(new);
+	*original_creds = override_creds_light(get_new_cred(new));
 	put_cred(new);
 	return 0;
 }
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 40ad58a6a0361e48a48262a2c61abbcfd908a3bb..8e323cc8e2c5b26ec660ceedeb95be4ef0ac809e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -221,7 +221,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 		new->cap_effective =
 			cap_raise_nfsd_set(new->cap_effective,
 					   new->cap_permitted);
-		put_cred(override_creds(new));
+		put_cred(override_creds_light(get_new_cred(new)));
 		put_cred(new);
 	} else {
 		error = nfsd_setuser_and_check_port(rqstp, cred, exp);
diff --git a/fs/open.c b/fs/open.c
index e6911101fe71d665d5f1a6346e5f82212bb8ed65..2459cd061f47f46756b7d0a7bf2f563b631ec1d5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -448,7 +448,7 @@ static const struct cred *access_override_creds(void)
 	 */
 	override_cred->non_rcu = 1;
 
-	old_cred = override_creds(override_cred);
+	old_cred = override_creds_light(get_new_cred(override_cred));
 
 	/* override_cred() gets its own ref */
 	put_cred(override_cred);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 3601ddfeddc2ec70764756905d528570ad1020e1..527b041213c8166d60d6a273675c2e2bc18dec36 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -741,7 +741,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 		return err;
 
 	if (cc->new)
-		cc->old = override_creds(cc->new);
+		cc->old = override_creds_light(get_new_cred(cc->new));
 
 	return 0;
 }
diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 28f568b5fc2771b7a11d0e83d0ac1cb9baf20636..721d8b1254b6491f0b4cb5318fd60d81e13b1599 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -173,7 +173,7 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	}
 
 	cifs_dbg(FYI, "key description = %s\n", description);
-	saved_cred = override_creds(spnego_cred);
+	saved_cred = override_creds_light(get_new_cred(spnego_cred));
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
 	revert_creds(saved_cred);
 
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ba79aa2107cc9f5b5fa628e9b9998d04e78c8bc1..b1ea4ea3de4b15013ac74cfce988515613543532 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -292,7 +292,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 		return -EINVAL;
 
 	rc = 0;
-	saved_cred = override_creds(root_cred);
+	saved_cred = override_creds_light(get_new_cred(root_cred));
 	sidkey = request_key(&cifs_idmap_key_type, desc, "");
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
@@ -398,7 +398,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	if (!sidstr)
 		return -ENOMEM;
 
-	saved_cred = override_creds(root_cred);
+	saved_cred = override_creds_light(get_new_cred(root_cred));
 	sidkey = request_key(&cifs_idmap_key_type, sidstr, "");
 	if (IS_ERR(sidkey)) {
 		cifs_dbg(FYI, "%s: Can't map SID %s to a %cid\n",
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 75b4eb856d32f7ddc856ad5cf04906638cede0b5..c2a59956e3a51b7727a7e358f3842d92d70f085d 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -780,7 +780,7 @@ int __ksmbd_override_fsids(struct ksmbd_work *work,
 		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
 
 	WARN_ON(work->saved_cred);
-	work->saved_cred = override_creds(cred);
+	work->saved_cred = override_creds_light(get_new_cred(cred));
 	if (!work->saved_cred) {
 		abort_creds(cred);
 		return -EINVAL;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8012933998837ddcef45c14f1dfe543947a9eaec..7ef3b67ebbde7b04d9428631ee72e7f45245feb4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1704,7 +1704,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		return -EBADF;
 
 	if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
-		creds = override_creds(req->creds);
+		creds = override_creds_light(get_new_cred(req->creds));
 
 	if (!def->audit_skip)
 		audit_uring_entry(req->opcode);
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 6df5e649c413e39e36db6cde2a8c6745e533bea9..58a76d5818959a9d7eeef52a8bacd29eba3f3d26 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -174,7 +174,7 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 		const struct cred *creds = NULL;
 
 		if (ctx->sq_creds != current_cred())
-			creds = override_creds(ctx->sq_creds);
+			creds = override_creds_light(get_new_cred(ctx->sq_creds));
 
 		mutex_lock(&ctx->uring_lock);
 		if (!wq_list_empty(&ctx->iopoll_list))
diff --git a/kernel/acct.c b/kernel/acct.c
index 179848ad33e978a557ce695a0d6020aa169177c6..8f18eb02dd416b884222b66f0f386379c46b30ea 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -501,7 +501,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	flim = rlimit(RLIMIT_FSIZE);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(file->f_cred);
+	orig_cred = override_creds_light(get_new_cred(file->f_cred));
 
 	/*
 	 * First check to see if there is enough free_space to continue
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d9061bd55436b502e065b477a903ed682d722c2e..97329b4fe5027dcc5d80f6b074f4c494c4794df7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5216,7 +5216,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 * permissions using the credentials from file open to protect against
 	 * inherited fd attacks.
 	 */
-	saved_cred = override_creds(of->file->f_cred);
+	saved_cred = override_creds_light(get_new_cred(of->file->f_cred));
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
 					of->file->f_path.dentry->d_sb,
 					threadgroup, ctx->ns);
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 17bcad8f79de70a29fb58f84ce12ffb929515794..4dd7c45d227e9459e694535cee3f853c09826cff 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1469,7 +1469,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 */
 	cred->fsuid = GLOBAL_ROOT_UID;
 
-	old_cred = override_creds(cred);
+	old_cred = override_creds_light(get_new_cred(cred));
 
 	if (visible)
 		ret = trace_add_event_call(&user->call);
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 82b084cc1cc6349bb532d5ada555b0bcbb1cdbea..a54f5f841cea1edd7f449d4e3e79e37b8ed865f4 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -124,7 +124,7 @@ int dns_query(struct net *net,
 	/* make the upcall, using special credentials to prevent the use of
 	 * add_key() to preinstall malicious redirections
 	 */
-	saved_cred = override_creds(dns_resolver_cache);
+	saved_cred = override_creds_light(get_new_cred(dns_resolver_cache));
 	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
 	revert_creds(saved_cred);
 	kfree(desc);

-- 
2.45.2


