Return-Path: <linux-fsdevel+bounces-4636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B249801690
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E22C1C20C73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C483F8D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZGyKVaws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722CF128
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:15 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d279bcce64so29649017b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468734; x=1702073534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGaKZfQ8xEUtcj2BvoUGwcXV31Q0VFKb7VLEms82qyQ=;
        b=ZGyKVaws3S0GoOwsOzviq3RAPMFOGknLTSLTqBg3I6yBiytMNnautYq3Z6FGyhKx0W
         aezaykvutmCXEoCso83D7mJMR0Mrqg43s98XjrXttGG0O+0/ArUdg+S+jFhISMjcVOK/
         45E9AnBb3L1SzohKM6zuFxFuXy0WQKaeyjqYDEDDMuYHQ/2MEEjFa5o4PnwcWstFMKkx
         x3G08Y06VyNzmeo7/gwwIleESZwvuCUW2CJ6DSkXpyljgCJSYCPFhiYBvy4+iRlbNW8P
         DY9PrPVBP7YxP2j8XuWBbOkwzFOaYfXSV6+W6GVI62X8ZT6AsXrUAGyqAcvx2XXh8lgf
         RJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468734; x=1702073534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGaKZfQ8xEUtcj2BvoUGwcXV31Q0VFKb7VLEms82qyQ=;
        b=XjFVEJW+MwXom00rRw+TwOQcdxnxJEkKutK/qvjFIj7zM5hcq+DgJRql82iJAIlIxC
         Cip/nNo6ZdTyYjJ1VuhY+XkI8N3s4h5Bd9oYM60q6stHQcGZxwPJKV2K2rjHKXwPw4x2
         vbp3zrqy7bNb+LQSCX8NlnnovLmETu2fuyMKts4sQcMw8ryrgAL93t+2WdZ/hdmf9gem
         cirj3qbWVQWIoKTNV/doPfxe9ZImdE0PrbYu3UFqXl7t6zH+Dv05C9TrsHdPNMThrFAG
         onQgmr3JSgUIF6yVKnfa0mo66XvxK0hMHcNY1/o0SCZNQHEAEMx5cCKuHy1JpTStz04y
         4frg==
X-Gm-Message-State: AOJu0Yz3029tYaUkwaErY3akIwlYYkpeIzKqIAlPgaYVTnMEGeprX3gb
	jUEevjQGDyk46i/EJzlOlrDUJQ==
X-Google-Smtp-Source: AGHT+IERfmiIIYpmihLJrdT1pqpTfZYUTDg0+VM8i/Q4h5RqR5xJgNcKO+1ZfO9c3q0JsRg6HDBCGg==
X-Received: by 2002:a05:690c:3387:b0:5a8:874:bb3a with SMTP id fl7-20020a05690c338700b005a80874bb3amr279105ywb.31.1701468734628;
        Fri, 01 Dec 2023 14:12:14 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w72-20020a81494b000000b005d70c0a85casm151282ywa.53.2023.12.01.14.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 15/46] btrfs: handle nokey names.
Date: Fri,  1 Dec 2023 17:11:12 -0500
Message-ID: <5729e533bb7e014a124cc48d793dec30507455b7.1701468306.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

For encrypted or unencrypted names, we calculate the offset for the dir
item by hashing the name for the dir item. However, this doesn't work
for a long nokey name, where we do not have the complete ciphertext.
Instead, fscrypt stores the filesystem-provided hash in the nokey name,
and we can extract it from the fscrypt_name structure in such a case.

Additionally, for nokey names, if we find the nokey name on disk we can
update the fscrypt_name with the disk name, so add that to searching for
diritems.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dir-item.c | 37 +++++++++++++++++++++++++++++++++++--
 fs/btrfs/fscrypt.c  | 27 +++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h  | 11 +++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index a64cfddff7f0..897fb5477369 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -231,6 +231,28 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return di;
 }
 
+/*
+ * If appropriate, populate the disk name for a fscrypt_name looked up without
+ * a key.
+ *
+ * @path:	The path to the extent buffer in which the name was found.
+ * @di:		The dir item corresponding.
+ * @fname:	The fscrypt_name to perhaps populate.
+ *
+ * Returns: 0 if the name is already populated or the dir item doesn't exist
+ * or the name was successfully populated, else an error code.
+ */
+static int ensure_disk_name_from_dir_item(struct btrfs_path *path,
+					  struct btrfs_dir_item *di,
+					  struct fscrypt_name *name)
+{
+	if (name->disk_name.name || !di)
+		return 0;
+
+	return btrfs_fscrypt_get_disk_name(path->nodes[0], di,
+					   &name->disk_name);
+}
+
 /*
  * Lookup for a directory item by fscrypt_name.
  *
@@ -257,8 +279,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name->disk_name.name, name->disk_name.len);
-	/* XXX get the right hash for no-key names */
+
+	if (!name->disk_name.name)
+		key.offset = name->hash | ((u64)name->minor_hash << 32);
+	else
+		key.offset = btrfs_name_hash(name->disk_name.name,
+					     name->disk_name.len);
 
 	ret = btrfs_search_slot(trans, root, &key, path, mod, -mod);
 	if (ret == 0)
@@ -266,6 +292,8 @@ struct btrfs_dir_item *btrfs_lookup_dir_item_fname(struct btrfs_trans_handle *tr
 
 	if (ret == -ENOENT || (di && IS_ERR(di) && PTR_ERR(di) == -ENOENT))
 		return NULL;
+	if (ret == 0)
+		ret = ensure_disk_name_from_dir_item(path, di, name);
 	if (ret < 0)
 		di = ERR_PTR(ret);
 
@@ -382,7 +410,12 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_for_each_slot(root, &key, &key, path, ret) {
 		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
+
 		di = btrfs_match_dir_item_fname(root->fs_info, path, name);
+		if (di)
+			ret = ensure_disk_name_from_dir_item(path, di, name);
+		if (ret)
+			break;
 		if (di)
 			return di;
 	}
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 6a4e4f63a660..9103da28af7e 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -14,6 +14,33 @@
 #include "transaction.h"
 #include "xattr.h"
 
+/*
+ * From a given location in a leaf, read a name into a qstr (usually a
+ * fscrypt_name's disk_name), allocating the required buffer. Used for
+ * nokey names.
+ */
+int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
+				struct btrfs_dir_item *dir_item,
+				struct fscrypt_str *name)
+{
+	unsigned long de_name_len = btrfs_dir_name_len(leaf, dir_item);
+	unsigned long de_name = (unsigned long)(dir_item + 1);
+	/*
+	 * For no-key names, we use this opportunity to find the disk
+	 * name, so future searches don't need to deal with nokey names
+	 * and we know what the encrypted size is.
+	 */
+	name->name = kmalloc(de_name_len, GFP_NOFS);
+
+	if (!name->name)
+		return -ENOMEM;
+
+	read_extent_buffer(leaf, name->name, de_name, de_name_len);
+
+	name->len = de_name_len;
+	return 0;
+}
+
 /*
  * This function is extremely similar to fscrypt_match_name() but uses an
  * extent_buffer.
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 1647bbbcd609..c08fd52c99b4 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -9,11 +9,22 @@
 #include "fs.h"
 
 #ifdef CONFIG_FS_ENCRYPTION
+int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
+				struct btrfs_dir_item *di,
+				struct fscrypt_str *qstr);
+
 bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 			      struct extent_buffer *leaf,
 			      unsigned long de_name, u32 de_name_len);
 
 #else
+static inline int btrfs_fscrypt_get_disk_name(struct extent_buffer *leaf,
+					      struct btrfs_dir_item *di,
+					      struct fscrypt_str *qstr)
+{
+	return 0;
+}
+
 static inline bool btrfs_fscrypt_match_name(struct fscrypt_name *fname,
 					    struct extent_buffer *leaf,
 					    unsigned long de_name,
-- 
2.41.0


