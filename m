Return-Path: <linux-fsdevel+bounces-75722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG0+CHUOemmS2AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:26:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE904A2184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E454530528A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E6352FA3;
	Wed, 28 Jan 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSHGxRiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9232352FAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606654; cv=none; b=VHbM0/wPy/0AyDOnj51JDylvlNmwYMxuQOrG/xAgAYZD1Epy8X91OxyjnLZbkNmi7xpBOuCEYZ8jGiZWpqGHYUSK2KkLxI+D9wJiAzn5eKLXf0tuYEf4ubRpahvIqSXjlZ0l8RPDCcpPTNNmq8KrxzkJnX2EO1lWmmVECgQ6uCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606654; c=relaxed/simple;
	bh=EQ6xjIKKxZ/+kfnV28PEIV4QC0DLWFLQkkQrvKLGotA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA8gDl4Lkje/hRMy5DoU8CzD4+Fvbqu9Lfs33brJmRHROxM3pm6pyGDjwiwDk0q6BdFYqb73bQdWqfx58VsaWj+OqvRbG/8eonB5y/U4IzLR9g2dLAGKoeK+BUecOJCTIslVjmN2Jsn8jxuMLsclAIZKGkgZe4wOgdSMxd4cgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSHGxRiR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b885e8c6727so181082166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769606651; x=1770211451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/LolTXFODfbuJ+5F5mGXiGbzlqsn3yLlZ2LXubqGdM=;
        b=YSHGxRiRiwxWQiH8gT7Hyml7OKzK3vY4vXxgtinmIVnVCOxot4rAWJfkmPjbrFyltk
         ZUTIA/kPi41Gv0Fz/be4hal4W3nCd2CMWzT61v3VQDfMLuQe9PlmEl8Kbpm8iqUTymHS
         tqIyIhxHFZwP3Y1fwmwgMJCoQxjtzVajBoDBdynZspM/yb0MeoE3EpAsvKoa3AOStnEj
         Kg6Ihk2vgcFrXAx+A7dQKSxTumFDxg0X3IRF6uzyqBMwWEBWYHM8TVqZ29xgP+mjCmlk
         KLoBVgvwnDwNkK3GvB2c9yoGGfKee9V4E20mjXTEExPcnTBy/5Z3fIZdDjaV0Y3zbshR
         nLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606651; x=1770211451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/LolTXFODfbuJ+5F5mGXiGbzlqsn3yLlZ2LXubqGdM=;
        b=kMID9o8m5WeFwvZsZ+RSKkFCSJvrUqj7k6tJXXYEpJqXNPOEbhH46A3C39YTLCYipX
         pRj1QdplGLXUWOPPN2pQlN6owAOSv37zKAjGEK9B8ZyBiSH65Zzsjpwq419Xomrbgy+b
         6OBQ1aptU5wvTurxEL3VUeqYiPdVRDySt1OptPgFrKeyJLjCjvYERXfc0JyJ+ql+akKq
         WXNKA1dncbXTnIRolh2xfeh9iUydDzSZlPhzGjJZRFdKQXDfdeqqXKjIfxOxxDQPG0dM
         SfMui9LydgEz6ilv7Vyvnnmtbz2EKTWnWYvGesEfafqqfzy2Xx7zcBOtzy/9d3oDaIe4
         9Dng==
X-Forwarded-Encrypted: i=1; AJvYcCXB8etCR09qsYix8iD3cynrhCtusPjyi0lufqrYDNMb/E0N6QTtaerF4/nyeeqE7Ybo6SMqKOkZ5fH4tRIt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dBIi0+QtHOazojoIxTiUhNKbYHpEQRP5S6s0vO1T+jLKkS7I
	yWumwTuIEYEV6Cbk3GXuFLZni306v3OCiHHEdQ+Hf8mCkEhEONTUTSro
X-Gm-Gg: AZuq6aLp+F6GX7Eon8SFSLNfboBNqwdOxuyLCgsZP5GYxa3pT0RNtuZTFH6Pr8euM6X
	nXnh52oLILYtx3+N9RV+9janAVEQ0Ws5Gm4fQYF2AxLbTQR/x7JLVM9AhD0w1TlFswLChSJI66S
	5CXTcEX/JXugQ8vPnqJFbysfmACDVR2zQf1K9EMYwFHd0Ra38TmYmmD8ZqQN5YGwV19Am8iwIAW
	JMwPaYMuFMJz/dKs3x2zqS1bO/dcceWRviD1nMf9AiEPivGJkv83ez7f5QCwacazpZ+9qg0Ttgp
	t4GhDZ5rZccvnawQAltlYO8VktWvQbIZTFjpmK+9dxIOdX54Kc39mzvqZznCQEhDLKS7R5DbJzr
	FYpJg/xt2OUHq2/77S6cnkoa8Co2JrEbDHsEETlTIlXEeaPJT+rs6toox2+J02Cy4CGolb/vjEQ
	9vwBJ8GHtIs5UDHWsQ7T1DVbnAqX6ctCTzYk1q28N1VlTNOsWRDFFkq2eXbleE8zFPvOvaqyqz3
	LCTEY2ifO/MImftBdlFm4vjLmU=
X-Received: by 2002:a17:907:7243:b0:b87:19ae:eb36 with SMTP id a640c23a62f3a-b8dac848d61mr381339366b.7.1769606650262;
        Wed, 28 Jan 2026 05:24:10 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-c84e-f30e-bdab-df5a.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c84e:f30e:bdab:df5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c0126sm129880466b.47.2026.01.28.05.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:24:09 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: Qing Wang <wangqing7171@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 2/3] fs: add helpers name_is_dot{,dot,_dotdot}
Date: Wed, 28 Jan 2026 14:24:05 +0100
Message-ID: <20260128132406.23768-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128132406.23768-1-amir73il@gmail.com>
References: <20260128132406.23768-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75722-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE904A2184
X-Rspamd-Action: no action

Rename the helper is_dot_dotdot() into the name_ namespace
and add complementary helpers to check for dot and dotdot
names individually.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/crypto/fname.c      |  2 +-
 fs/ecryptfs/crypto.c   |  2 +-
 fs/exportfs/expfs.c    |  3 ++-
 fs/f2fs/dir.c          |  2 +-
 fs/f2fs/hash.c         |  2 +-
 fs/namei.c             |  2 +-
 fs/overlayfs/readdir.c |  3 ++-
 fs/smb/server/vfs.c    |  2 +-
 include/linux/fs.h     | 14 ++++++++++++--
 9 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index a9a4432d12ba1..629eb0d72e860 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -76,7 +76,7 @@ struct fscrypt_nokey_name {
 
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
-	return is_dot_dotdot(str->name, str->len);
+	return name_is_dot_dotdot(str->name, str->len);
 }
 
 /**
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 260f8a4938b01..3c89f06c74532 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1904,7 +1904,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 
 	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) &&
 	    !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)) {
-		if (is_dot_dotdot(name, name_size)) {
+		if (name_is_dot_dotdot(name, name_size)) {
 			rc = ecryptfs_copy_filename(plaintext_name,
 						    plaintext_name_size,
 						    name, name_size);
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index d3e55de4a2a2a..6c9be60a3e48d 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -253,7 +253,8 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
 		container_of(ctx, struct getdents_callback, ctx);
 
 	buf->sequence++;
-	if (buf->ino == ino && len <= NAME_MAX && !is_dot_dotdot(name, len)) {
+	if (buf->ino == ino && len <= NAME_MAX &&
+	    !name_is_dot_dotdot(name, len)) {
 		memcpy(buf->name, name, len);
 		buf->name[len] = '\0';
 		buf->found = 1;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 48f4f98afb013..29412e6e078d0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -67,7 +67,7 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 	int len;
 
 	if (IS_CASEFOLDED(dir) &&
-	    !is_dot_dotdot(fname->usr_fname->name, fname->usr_fname->len)) {
+	    !name_is_dot_dotdot(fname->usr_fname->name, fname->usr_fname->len)) {
 		buf = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
 					    GFP_NOFS, false, F2FS_SB(sb));
 		if (!buf)
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index 049ce50cec9b0..14082fe5e6b29 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -100,7 +100,7 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname)
 
 	WARN_ON_ONCE(!name);
 
-	if (is_dot_dotdot(name, len)) {
+	if (name_is_dot_dotdot(name, len)) {
 		fname->hash = 0;
 		return;
 	}
diff --git a/fs/namei.c b/fs/namei.c
index b3fe9d4a7037e..63bbcea75bbd3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3050,7 +3050,7 @@ int lookup_noperm_common(struct qstr *qname, struct dentry *base)
 	if (!len)
 		return -EACCES;
 
-	if (is_dot_dotdot(name, len))
+	if (name_is_dot_dotdot(name, len))
 		return -EACCES;
 
 	while (len--) {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 724ec9d93fc82..9f6b36f3d4cf8 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -76,7 +76,8 @@ static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, int len,
 	char *cf_name;
 	int cf_len;
 
-	if (!IS_ENABLED(CONFIG_UNICODE) || !rdd->map || is_dot_dotdot(str, len))
+	if (!IS_ENABLED(CONFIG_UNICODE) || !rdd->map ||
+	    name_is_dot_dotdot(str, len))
 		return 0;
 
 	cf_name = kmalloc(NAME_MAX, GFP_KERNEL);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index b8e648b8300f6..b38eb8e0b3eb7 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1052,7 +1052,7 @@ static bool __dir_empty(struct dir_context *ctx, const char *name, int namlen,
 	struct ksmbd_readdir_data *buf;
 
 	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
-	if (!is_dot_dotdot(name, namlen))
+	if (!name_is_dot_dotdot(name, namlen))
 		buf->dirent_count++;
 
 	return !buf->dirent_count;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b1310648bb585..43f9baef4dd36 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2846,12 +2846,22 @@ u64 vfsmount_to_propagation_flags(struct vfsmount *mnt);
 
 extern char *file_path(struct file *, char *, int);
 
+static inline bool name_is_dot(const char *name, size_t len)
+{
+	return unlikely(len == 1 && name[0] == '.');
+}
+
+static inline bool name_is_dotdot(const char *name, size_t len)
+{
+	return unlikely(len == 2 && name[0] == '.' && name[1] == '.');
+}
+
 /**
- * is_dot_dotdot - returns true only if @name is "." or ".."
+ * name_is_dot_dotdot - returns true only if @name is "." or ".."
  * @name: file name to check
  * @len: length of file name, in bytes
  */
-static inline bool is_dot_dotdot(const char *name, size_t len)
+static inline bool name_is_dot_dotdot(const char *name, size_t len)
 {
 	return len && unlikely(name[0] == '.') &&
 		(len == 1 || (len == 2 && name[1] == '.'));
-- 
2.52.0


