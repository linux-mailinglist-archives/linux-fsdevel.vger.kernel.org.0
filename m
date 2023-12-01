Return-Path: <linux-fsdevel+bounces-4662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FD801668
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19DC281C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90C3F8CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iUxucSfU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F010D
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:50 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso1003523276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468769; x=1702073569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKlRH2ypxEsgnl3Oxcw1hajqFTRK349usgZrBtFH+kI=;
        b=iUxucSfU9i2hov/990KJHFShpQ+0pUpf8htHjLEPq6m0V+ssSX1r5G3PpT6fvX/IVf
         cj1+3wDvmVLQwo0SJaFXXjiCgieG9AcuUapYfLbhcWFj1jUgXavSRa63O/TFcatVHdds
         VSrQSbgAZZyhVffb5zDCOGAj6lTSHw1ai6l9ezEtrlHxfLek2JUB9fGp40ZzgIvOWIt+
         wx+RutUcWtCgbygyrJk+tMUApMs01SbP2Iv1b7cn2KL3PJ12xWznxZtVbYdfPvoy7Tzs
         BOnUbuMcbQQa9+UKJ7x9rGi5TE97blnwEaykZZa6csN2OyPoz1GOf4pJ77fQPiL5uhXo
         UaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468769; x=1702073569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKlRH2ypxEsgnl3Oxcw1hajqFTRK349usgZrBtFH+kI=;
        b=m/9THd9yMsbr7f5a9YTUZBJecA2u1yjPi8xBrWe/PaEjinIJ8k/5OBaKOllhxmYzxN
         FwKeW6VwrpPytXZOJ950LWz/BCbIriEC8l28z5ovJ6FeMAYpLZzMsctmO5i1HzYwT3Of
         KRs7NrYjE2RUZBqpN8PdT2FaKC6NRq3/NoOtQkR0nFi/z20NH1CG9h/qoZFvW4dJ8aAF
         HgYrX9b00EaS8R24mUQofOeXewLX6id9QsgKZ5QXJnbXerxuJ/3KI3zqFITe/8Rp58ua
         4jrdFwpRKbcBlsju2Q0xPUBUuzKjZO8mmlcgovYXZBja15UtyrG6P426Zk+hrcyXJYTU
         1xVA==
X-Gm-Message-State: AOJu0Yxqr1/Kk7yogyXkUkvdw2gfOHxk3RuIswDW8Npa27yY58tdBHbD
	aIu85b34IhddwelR7LsznqQTjzwENyLaLv+uKrIRdw2p
X-Google-Smtp-Source: AGHT+IFa78UTB3MkuGoDEKdy6FU/NSfdtRCrhlnDeB+gknUqL92NWjcGklFcXclqxw7I+TphLq8SIw==
X-Received: by 2002:a05:6902:1008:b0:db7:dacf:6fd4 with SMTP id w8-20020a056902100800b00db7dacf6fd4mr183217ybt.92.1701468769440;
        Fri, 01 Dec 2023 14:12:49 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l14-20020a25ad4e000000b00d9cb47932a0sm635243ybe.25.2023.12.01.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 42/46] btrfs: make btrfs_ref_to_path handle encrypted filenames
Date: Fri,  1 Dec 2023 17:11:39 -0500
Message-ID: <82bed4f199c177455b1a0bdf6b246a8a6047ed33.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use this helper for inode-resolve and path resolution in send, so
update this helper to properly decrypt any encrypted names it finds.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/fscrypt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h | 11 +++++++++++
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f58fe7c745c2..9ed854b9f3fc 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -20,6 +20,7 @@
 #include "extent-tree.h"
 #include "relocation.h"
 #include "tree-checker.h"
+#include "fscrypt.h"
 
 /* Just arbitrary numbers so we can be sure one of these happened. */
 #define BACKREF_FOUND_SHARED     6
@@ -2117,6 +2118,42 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 	return ret;
 }
 
+static int copy_resolved_iref_to_buf(struct btrfs_root *fs_root,
+				     struct extent_buffer *eb,
+				     char *dest, u64 parent,
+				     unsigned long name_off, u32 name_len,
+				     s64 *bytes_left)
+{
+	struct btrfs_fs_info *fs_info = fs_root->fs_info;
+	struct fscrypt_str fname = FSTR_INIT(NULL, 0);
+	int ret;
+
+	/* No encryption, just copy the name in. */
+	if (!btrfs_fs_incompat(fs_info, ENCRYPT)) {
+		*bytes_left -= name_len;
+		if (*bytes_left >= 0)
+			read_extent_buffer(eb, dest + *bytes_left,
+					   name_off, name_len);
+		return 0;
+	}
+
+	ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fname);
+	if (ret)
+		return ret;
+
+	ret = btrfs_decrypt_name(fs_root, eb, name_off, name_len, parent,
+				 &fname);
+	if (ret)
+		goto out;
+
+	*bytes_left -= fname.len;
+	if (*bytes_left >= 0)
+		memcpy(dest + *bytes_left, fname.name, fname.len);
+out:
+	fscrypt_fname_free_buffer(&fname);
+	return ret;
+}
+
 /*
  * this iterates to turn a name (from iref/extref) into a full filesystem path.
  * Elements of the path are separated by '/' and the path is guaranteed to be
@@ -2148,10 +2185,10 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 		dest[bytes_left] = '\0';
 
 	while (1) {
-		bytes_left -= name_len;
-		if (bytes_left >= 0)
-			read_extent_buffer(eb, dest + bytes_left,
-					   name_off, name_len);
+		ret = copy_resolved_iref_to_buf(fs_root, eb, dest, parent,
+						name_off, name_len, &bytes_left);
+		if (ret)
+			break;
 		if (eb != eb_in) {
 			if (!path->skip_locking)
 				btrfs_tree_read_unlock(eb);
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 2fbceec62dc7..6211fa17bf79 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -355,6 +355,52 @@ int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
 	return map_length;
 }
 
+int btrfs_decrypt_name(struct btrfs_root *root, struct extent_buffer *eb,
+		       unsigned long name_off, u32 name_len,
+		       u64 parent_ino, struct fscrypt_str *name)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *dir;
+	struct fscrypt_str iname = FSTR_INIT(NULL, 0);
+	int ret;
+
+	ASSERT(name_len <= BTRFS_NAME_LEN);
+
+	ret = fscrypt_fname_alloc_buffer(name_len, &iname);
+	if (ret)
+		return ret;
+
+	dir = btrfs_iget(fs_info->sb, parent_ino, root);
+	if (IS_ERR(dir)) {
+		ret = PTR_ERR(dir);
+		goto out;
+	}
+
+	/*
+	 * Directory isn't encrypted, the name isn't encrypted, we can just copy
+	 * it into the buffer.
+	 */
+	if (!IS_ENCRYPTED(dir)) {
+		read_extent_buffer(eb, name->name, name_off, name_len);
+		name->len = name_len;
+		goto out_inode;
+	}
+
+	read_extent_buffer(eb, iname.name, name_off, name_len);
+
+	ret = fscrypt_prepare_readdir(dir);
+	if (ret)
+		goto out_inode;
+
+	ASSERT(dir->i_crypt_info);
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, name);
+out_inode:
+	iput(dir);
+out:
+	fscrypt_fname_free_buffer(&iname);
+	return ret;
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
 	.has_per_extent_encryption = 1,
 	.get_context = btrfs_fscrypt_get_context,
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index c4a327be0eeb..aba01bacc165 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -36,6 +36,9 @@ bool btrfs_mergeable_encrypted_bio(struct bio *bio, struct inode *inode,
 				   struct fscrypt_extent_info *fi,
 				   u64 logical_offset);
 int btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length);
+int btrfs_decrypt_name(struct btrfs_root *root, struct extent_buffer *eb,
+		       unsigned long name_off, u32 name_len,
+		       u64 parent_ino, struct fscrypt_str *name);
 
 #else
 static inline int btrfs_fscrypt_save_extent_info(struct btrfs_inode *inode,
@@ -94,6 +97,14 @@ static inline u64 btrfs_fscrypt_bio_length(struct bio *bio, u64 map_length)
 {
 	return map_length;
 }
+
+static inline int btrfs_decrypt_name(struct btrfs_root *root,
+				     struct extent_buffer *eb,
+				     unsigned long name_off, u32 name_len,
+				     u64 parent_ino, struct fscrypt_str *name)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 extern const struct fscrypt_operations btrfs_fscrypt_ops;
-- 
2.41.0


