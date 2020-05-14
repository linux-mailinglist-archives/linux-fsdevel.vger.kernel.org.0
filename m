Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1571D2B4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENJYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 05:24:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53706 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENJYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 05:24:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id k12so29370563wmj.3;
        Thu, 14 May 2020 02:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lt+FtTKfoUfoObL8aO8qizMpOeHO6DXwfi/WUhXbZpo=;
        b=TDE/+mc//3huoZxErwxMkPG4JL7z1CCINXwhqFrG40D1DMIIagu6YD6/HtWATjOCYh
         fTwh/zKnCfYeVbMh17jV3xogYBcj5SQfngCa7mLdHD9TLuEq0xsx9Gz5u8ID/n+LaqbQ
         mOs+H6TzpacHI/hunZN0cO2j7PB1RUy3yL5frlPB//98kx3gifNTHBMTMTwoPe/PbPf2
         GlcYNEElf+VeexiERzngeDgML+5YL3ig1RfUX169SCAED6K0h45+VupFSf6qfdVNxMF+
         +NVmz5qCcjEXo4ggwsrTrnndJ9WMiL97bl+J2gnaRtCIhrOkax/ltNcGN2spDmqhvO1F
         NsXQ==
X-Gm-Message-State: AOAM532womOcd8EJPsqT6002I0gNVkrxLUzh1PGDcfqWFQalXWYhmZF5
        SGU4F4YOReHXx1Ecsra1nc4=
X-Google-Smtp-Source: ABdhPJwj4zsE+WHyqOjCTKqoQw+cfolRDPRW8TwjDcUNm+ZmFYAL4HppbVk3eqAXPyDjhioFlz7HVA==
X-Received: by 2002:a1c:31d6:: with SMTP id x205mr14521619wmx.105.1589448281664;
        Thu, 14 May 2020 02:24:41 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id z132sm38877763wmc.29.2020.05.14.02.24.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:24:41 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 2/3] btrfs: add authentication support
Date:   Thu, 14 May 2020 11:24:14 +0200
Message-Id: <20200514092415.5389-3-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200514092415.5389-1-jth@kernel.org>
References: <20200514092415.5389-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
potential attacker could just generate the corresponding cryptographic
hash for forged file-system operations and the changes would go unnoticed.

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
mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk

Add the key to the kernel's keyring as keyid 'btrfs:foo'
keyctl add logon btrfs:foo 0123456 @u

Mount the fs using the 'btrfs:foo' key
mount -o auth_key=btrfs:foo,auth_hash_name="hmac(sha256)" /dev/disk /mnt/point

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
 fs/btrfs/Kconfig                |  2 +
 fs/btrfs/ctree.c                | 22 +++++++++-
 fs/btrfs/ctree.h                |  5 ++-
 fs/btrfs/disk-io.c              | 71 +++++++++++++++++++++++++++++++--
 fs/btrfs/ioctl.c                |  7 +++-
 fs/btrfs/super.c                | 51 ++++++++++++++++++++++-
 include/uapi/linux/btrfs_tree.h |  1 +
 7 files changed, 150 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 575636f6491e..b7e9ce25b622 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -8,6 +8,8 @@ config BTRFS_FS
 	select CRYPTO_XXHASH
 	select CRYPTO_SHA256
 	select CRYPTO_BLAKE2B
+	select CRYPTO_HMAC
+	select KEYS
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select LZO_COMPRESS
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 746dec22f250..2907bd054dd6 100644
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
@@ -56,12 +57,29 @@ const char *btrfs_super_csum_name(u16 csum_type)
 	return btrfs_csums[csum_type].name;
 }
 
+static const char *btrfs_auth_csum_driver(struct btrfs_fs_info *fs_info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(btrfs_csums); i++) {
+		if (!strncmp(fs_info->auth_hash_name, btrfs_csums[i].name,
+			     strlen(btrfs_csums[i].name)))
+			return btrfs_csums[i].driver[0] ?
+				btrfs_csums[i].driver : btrfs_csums[i].name;
+	}
+
+	return NULL;
+}
+
 /*
  * Return driver name if defined, otherwise the name that's also a valid driver
  * name
  */
-const char *btrfs_super_csum_driver(u16 csum_type)
+const char *btrfs_super_csum_driver(struct btrfs_fs_info *info, u16 csum_type)
 {
+	if (btrfs_test_opt(info, AUTH_KEY))
+		return btrfs_auth_csum_driver(info);
+
 	/* csum type is validated at mount time */
 	return btrfs_csums[csum_type].driver[0] ?
 		btrfs_csums[csum_type].driver :
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a1fa1526c43..b9e4cf5b9fd3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -931,6 +931,8 @@ struct btrfs_fs_info {
 	struct rb_root swapfile_pins;
 
 	struct crypto_shash *csum_shash;
+	char *auth_key_name;
+	char *auth_hash_name;
 
 	/*
 	 * Number of send operations in progress.
@@ -1239,6 +1241,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_AUTH_KEY		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
@@ -2186,7 +2189,7 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
-const char *btrfs_super_csum_driver(u16 csum_type);
+const char *btrfs_super_csum_driver(struct btrfs_fs_info *info, u16 csum_type);
 size_t __const btrfs_get_num_csums(void);
 
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 714b57553ed6..6ed5d1191cdf 100644
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
@@ -100,8 +101,10 @@ void __cold btrfs_end_io_wq_exit(void)
 
 static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->csum_shash)
+	if (fs_info->csum_shash) {
 		crypto_free_shash(fs_info->csum_shash);
+		fs_info->csum_shash = NULL;
+	}
 }
 
 /*
@@ -339,6 +342,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 	case BTRFS_CSUM_TYPE_XXHASH:
 	case BTRFS_CSUM_TYPE_SHA256:
 	case BTRFS_CSUM_TYPE_BLAKE2:
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
 		return true;
 	default:
 		return false;
@@ -1509,6 +1513,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	percpu_counter_destroy(&fs_info->dio_bytes);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
 	btrfs_free_csum_hash(fs_info);
+	kfree(fs_info->auth_key_name);
+	kfree(fs_info->auth_hash_name);
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
@@ -2178,10 +2184,16 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 {
 	struct crypto_shash *csum_shash;
-	const char *csum_driver = btrfs_super_csum_driver(csum_type);
+	const char *csum_driver;
+	struct key *key;
+	const struct user_key_payload *ukp;
+	int err = -EINVAL;
 
-	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
+	csum_driver = btrfs_super_csum_driver(fs_info, csum_type);
+	if (!csum_driver)
+		return err;
 
+	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
 	if (IS_ERR(csum_shash)) {
 		btrfs_err(fs_info, "error allocating %s hash for checksum",
 			  csum_driver);
@@ -2190,7 +2202,57 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 
 	fs_info->csum_shash = csum_shash;
 
-	return 0;
+	/*
+	 * If we're not doing authentication, we're done by now. If we use
+	 * authentication and the auth_hash_name was bogus crypt_alloc_shash
+	 * would have dropped out by now. Validation that both auth_hash_name
+	 * and auth_key_name have been supplied is done in
+	 * btrfs_parse_early_options(), so we should be good to go from here on
+	 * and start authenticating the file-system.
+	 */
+	if (!btrfs_test_opt(fs_info, AUTH_KEY))
+		return 0;
+
+	if (strncmp(fs_info->auth_key_name, "btrfs:", 6)) {
+		btrfs_err(fs_info,
+			  "authentication key must start with 'btrfs:'");
+		goto out_free_hash;
+	}
+
+	key = request_key(&key_type_logon, fs_info->auth_key_name, NULL);
+	if (IS_ERR(key)) {
+		err = PTR_ERR(key);
+		goto out_free_hash;
+	}
+
+	down_read(&key->sem);
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp) {
+		btrfs_err(fs_info, "error getting payload for key %s",
+			  fs_info->auth_key_name);
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
+	if (err) {
+		btrfs_free_csum_hash(fs_info);
+	}
+
+	up_read(&key->sem);
+	key_put(key);
+
+	return err;
+
+out_free_hash:
+	btrfs_free_csum_hash(fs_info);
+	return err;
 }
 
 static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
@@ -3371,6 +3433,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
 fail_alloc:
+	btrfs_free_csum_hash(fs_info);
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 
 	iput(fs_info->btree_inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..59bbb2c860d5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -242,7 +242,12 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	else
 		binode_flags &= ~BTRFS_INODE_DIRSYNC;
 	if (fsflags & FS_NOCOW_FL) {
-		if (S_ISREG(inode->i_mode)) {
+		if (btrfs_test_opt(fs_info, AUTH_KEY)) {
+			btrfs_err(fs_info,
+				  "Cannot set nodatacow or nodatasum on authenticated file-system");
+			ret = -EPERM;
+			goto out_unlock;
+		} else if (S_ISREG(inode->i_mode)) {
 			/*
 			 * It's safe to turn csums off here, no extents exist.
 			 * Otherwise we want the flag to reflect the real COW
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 07cec0d16348..88164b916c28 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -342,6 +342,8 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
+	Opt_auth_key,
+	Opt_auth_hash_name,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -410,6 +412,8 @@ static const match_table_t tokens = {
 	{Opt_notreelog, "notreelog"},
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_auth_key, "auth_key=%s"},
+	{Opt_auth_hash_name, "auth_hash_name=%s"},
 
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
@@ -488,6 +492,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			 */
 			break;
 		case Opt_nodatasum:
+			if (btrfs_test_opt(info, AUTH_KEY)) {
+				btrfs_info(info,
+					   "nodatasum not supported on an authnticated file-system");
+				break;
+			}
 			btrfs_set_and_info(info, NODATASUM,
 					   "setting nodatasum");
 			break;
@@ -503,6 +512,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_clear_opt(info->mount_opt, NODATASUM);
 			break;
 		case Opt_nodatacow:
+			if (btrfs_test_opt(info, AUTH_KEY)) {
+				btrfs_info(info,
+					   "nodatacow not supported on an authnticated file-system");
+				break;
+			}
 			if (!btrfs_test_opt(info, NODATACOW)) {
 				if (!btrfs_test_opt(info, COMPRESS) ||
 				    !btrfs_test_opt(info, FORCE_COMPRESS)) {
@@ -950,7 +964,8 @@ static int btrfs_parse_early_options(struct btrfs_fs_info *info,
 			continue;
 
 		token = match_token(p, tokens, args);
-		if (token == Opt_device) {
+		switch (token) {
+		case Opt_device:
 			device_name = match_strdup(&args[0]);
 			if (!device_name) {
 				error = -ENOMEM;
@@ -963,9 +978,40 @@ static int btrfs_parse_early_options(struct btrfs_fs_info *info,
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
+			break;
+		case Opt_auth_hash_name:
+			info->auth_hash_name = match_strdup(&args[0]);
+			if (!info->auth_hash_name) {
+				error = -ENOMEM;
+				goto out;
+			}
+			break;
+		default:
+			break;
 		}
 	}
 
+	/*
+	 * Check that both auth_key_name and auth_hash_name are either present
+	 * or absent and error out if only one of them is set.
+	 */
+	if (info->auth_key_name && info->auth_hash_name) {
+		btrfs_info(info, "doing authentication");
+		btrfs_set_opt(info->mount_opt, AUTH_KEY);
+	} else if ((info->auth_key_name && !info->auth_hash_name) ||
+		   (!info->auth_key_name && info->auth_hash_name)) {
+		btrfs_err(info,
+			  "auth_key and auth_hash_name must be supplied together");
+		error = -EINVAL;
+	}
+
 out:
 	kfree(orig);
 	return error;
@@ -1405,6 +1451,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, AUTH_KEY))
+		seq_printf(seq, ",auth_key=%s", info->auth_key_name);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	seq_puts(seq, ",subvol=");
@@ -2526,4 +2574,5 @@ MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32c");
 MODULE_SOFTDEP("pre: xxhash64");
 MODULE_SOFTDEP("pre: sha256");
+MODULE_SOFTDEP("pre: hmac");
 MODULE_SOFTDEP("pre: blake2b-256");
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index a3f3975df0de..dfc22b995f60 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -305,6 +305,7 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_XXHASH	= 1,
 	BTRFS_CSUM_TYPE_SHA256	= 2,
 	BTRFS_CSUM_TYPE_BLAKE2	= 3,
+	BTRFS_CSUM_TYPE_HMAC_SHA256 = 4,
 };
 
 /*
-- 
2.26.1

