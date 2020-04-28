Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1701BBBC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD1LAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:00:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgD1LAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:00:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id j1so24131532wrt.1;
        Tue, 28 Apr 2020 04:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bl/Ne+5Gqe8yhHPh1alfj1EjXcq0E6CANCgbVBqoJ1o=;
        b=R0gwgdizpe6yVje32CYR2TZGEHetUiEyBt32Awhh2NFzMeJKZeaUuZoWia1IyqVFQZ
         qEvkqCDK1Ng5bbMpgeNAqCMLFqd/wtd5mJRTy7qFoSxzw3z60+O6QVtT/U1YdTC04ez+
         FnljhUjAyq346oCT9NVWovIbNEEuvk05r6tRlSs5wcjrNyUlof0Fmyk4TwQO9BRTOJMZ
         MTzh8P5l9uXXhaZ3YFunScZSFGaA6NfWzbjymnsgjtE94s/7TW0St1EmFUNVg1B6z3N+
         zpfa6yAwN7/LcIywZYJnAtLvD/iHEyxM9eALaiGWEFgGpSr9z/E3hG2XWnH2Q4UXKwWv
         EkCQ==
X-Gm-Message-State: AGi0Pub/y9EhC1hqv6bfgcMMS8+ZKn0nHm0VS51+5oEEqDpjISUnWgzw
        shvO2xPZl9434FOpKA/5MpA=
X-Google-Smtp-Source: APiQypJ3q+Ht7T8q+P+HT10fSalHDM7K+VpYXfe9OSOxE06QGnS15WfIgSqHYlECIDzRJAN7wJnokg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr25677150wro.361.1588071617019;
        Tue, 28 Apr 2020 04:00:17 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id c83sm2997739wmd.23.2020.04.28.04.00.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:00:16 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/2] btrfs: add authentication support
Date:   Tue, 28 Apr 2020 12:58:58 +0200
Message-Id: <20200428105859.4719-2-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200428105859.4719-1-jth@kernel.org>
References: <20200428105859.4719-1-jth@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add authentication support for a BTRFS file-system.

This works, because in BTRFS every meta-data block as well as every
data-block has a own checksum. For meta-data the checksum is in the
meta-data node itself. For data blocks, the checksums are stored in the
checksum tree.

When replacing the checksum algorithm with a keyed hash, like HMAC(SHA256),
a key is needed to mount a verified file-system. This key also needs to be
used at file-system creation time.

We have to used a keyed hash scheme, in contrast to doing a normal
cryptographic hash, to guarantee integrity of the file system, as a
potential attacker could just replay file-system operations and the
changes would go unnoticed.

Having a keyed hash only on the topmost Node of a tree or even just in the
super-block and using cryptographic hashes on the normal meta-data nodes
and checksum tree entries doesn't work either, as the BTRFS B-Tree's Nodes
do not include the checksums of their respective child nodes, but only the
block pointers and offsets where to find them on disk.

Also note, we do not need a incompat R/O flag for this, because if an old
kernel tries to mount an authenticated file-system it will fail the
initial checksum type verification and thus refuses to mount.

The key has to be supplied by the kernel's keyring and the method of
getting the key securely into the kernel is not subject of this patch.

Example usage:
Create a file-system with authentication key 0123456
mkfs.btrfs --csum hmac-sha256 --auth-key 0123456 /dev/disk

Add the key to the kernel's keyring as keyid 'btrfs:foo'
keyctl add logon btrfs:foo 0123456 @u

Mount the fs using the 'btrfs:foo' key
mount -t btrfs -o auth_key=btrfs:foo /dev/disk /mnt/point

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.c                |  3 ++-
 fs/btrfs/ctree.h                |  2 ++
 fs/btrfs/disk-io.c              | 53 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/super.c                | 24 ++++++++++++++++---
 include/uapi/linux/btrfs_tree.h |  1 +
 5 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6c28efe5b14a..76418b5b00a6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -31,7 +31,7 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 
 static const struct btrfs_csums {
 	u16		size;
-	const char	name[10];
+	const char	name[12];
 	const char	driver[12];
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
@@ -39,6 +39,7 @@ static const struct btrfs_csums {
 	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
 	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
 				     .driver = "blake2b-256" },
+	[BTRFS_CSUM_TYPE_HMAC_SHA256] = { .size = 32, .name = "hmac(sha256)" }
 };
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c79e0b0eac54..b692b3dc4593 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -719,6 +719,7 @@ struct btrfs_fs_info {
 	struct rb_root swapfile_pins;
 
 	struct crypto_shash *csum_shash;
+	char *auth_key_name;
 
 	/*
 	 * Number of send operations in progress.
@@ -1027,6 +1028,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_AUTH_KEY		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d10c7be10f3b..fe403fb62178 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -17,6 +17,7 @@
 #include <linux/error-injection.h>
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
+#include <keys/user-type.h>
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
 #include "ctree.h"
@@ -339,6 +340,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 	case BTRFS_CSUM_TYPE_XXHASH:
 	case BTRFS_CSUM_TYPE_SHA256:
 	case BTRFS_CSUM_TYPE_BLAKE2:
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
 		return true;
 	default:
 		return false;
@@ -2187,6 +2189,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 {
 	struct crypto_shash *csum_shash;
 	const char *csum_driver = btrfs_super_csum_driver(csum_type);
+	struct key *key;
+	const struct user_key_payload *ukp;
+	int err = 0;
 
 	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
 
@@ -2198,7 +2203,53 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 
 	fs_info->csum_shash = csum_shash;
 
-	return 0;
+	/*
+	 * if we're not doing authentication, we're done by now. Still we have
+	 * to validate the possible combinations of BTRFS_MOUNT_AUTH_KEY and
+	 * keyed hashes.
+	 */
+	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256 &&
+	    !btrfs_test_opt(fs_info, AUTH_KEY)) {
+		crypto_free_shash(fs_info->csum_shash);
+		return -EINVAL;
+	} else if (btrfs_test_opt(fs_info, AUTH_KEY)
+		   && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) {
+		crypto_free_shash(fs_info->csum_shash);
+		return -EINVAL;
+	} else if (!btrfs_test_opt(fs_info, AUTH_KEY)) {
+		/*
+		 * This is the normal case, if noone want's authentication and
+		 * doesn't have a keyed hash, we're done.
+		 */
+		return 0;
+	}
+
+	key = request_key(&key_type_logon, fs_info->auth_key_name, NULL);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	down_read(&key->sem);
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp) {
+		btrfs_err(fs_info, "");
+		err = -EKEYREVOKED;
+		goto out;
+	}
+
+	err = crypto_shash_setkey(fs_info->csum_shash, ukp->data, ukp->datalen);
+	if (err)
+		btrfs_err(fs_info, "error setting key %s for verification",
+			  fs_info->auth_key_name);
+
+out:
+	if (err)
+		crypto_free_shash(fs_info->csum_shash);
+
+	up_read(&key->sem);
+	key_put(key);
+
+	return err;
 }
 
 static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7932d8d07cff..2645a9cee8d1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -333,6 +333,7 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
+	Opt_auth_key,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -401,6 +402,7 @@ static const match_table_t tokens = {
 	{Opt_notreelog, "notreelog"},
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_auth_key, "auth_key=%s"},
 
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
@@ -910,7 +912,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(const char *options, fmode_t flags,
+static int btrfs_parse_device_options(struct btrfs_fs_info *info,
+				      const char *options, fmode_t flags,
 				      void *holder)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -939,7 +942,8 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 			continue;
 
 		token = match_token(p, tokens, args);
-		if (token == Opt_device) {
+		switch (token) {
+		case Opt_device:
 			device_name = match_strdup(&args[0]);
 			if (!device_name) {
 				error = -ENOMEM;
@@ -952,6 +956,18 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 				error = PTR_ERR(device);
 				goto out;
 			}
+			break;
+		case Opt_auth_key:
+			info->auth_key_name = match_strdup(&args[0]);
+			if (!info->auth_key_name) {
+				error = -ENOMEM;
+				goto out;
+			}
+			btrfs_info(info, "doing authentication");
+			btrfs_set_opt(info->mount_opt, AUTH_KEY);
+			break;
+		default:
+			break;
 		}
 	}
 
@@ -1394,6 +1410,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, AUTH_KEY))
+		seq_printf(seq, ",auth_key=%s", info->auth_key_name);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	seq_puts(seq, ",subvol=");
@@ -1542,7 +1560,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode, fs_type);
+	error = btrfs_parse_device_options(fs_info, data, mode, fs_type);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index a02318e4d2a9..bfaf127b37fd 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -344,6 +344,7 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_XXHASH	= 1,
 	BTRFS_CSUM_TYPE_SHA256	= 2,
 	BTRFS_CSUM_TYPE_BLAKE2	= 3,
+	BTRFS_CSUM_TYPE_HMAC_SHA256 = 32,
 };
 
 /*
-- 
2.16.4

