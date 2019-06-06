Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B5378DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfFFPy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 11:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729191AbfFFPyH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:54:07 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4507D2089E;
        Thu,  6 Jun 2019 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559836445;
        bh=Dd+C+GM6X3huqjSUxkeiGhMzM/WfY0qzHGZKXHi579A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLzbEEmh+VBgQktRkgvFKtL1mxXp3B+nTHNks+VsAyAxk8QwypNeJxxdOCXKvZQ7z
         mn6jwFmLdib0F8CTsDjgoo31wRnLNwaCb+S5sLVasN3A4Imtw9n9MgM8TA2Faz/WFW
         OKapHxPfm5daxr3Al0Gbw+w7t58tFKnB+s1jFTW0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 05/16] fs-verity: add Kconfig and the helper functions for hashing
Date:   Thu,  6 Jun 2019 08:51:54 -0700
Message-Id: <20190606155205.2872-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
References: <20190606155205.2872-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add the beginnings of the fs/verity/ support layer, including the
Kconfig option and various helper functions for hashing.  To start, only
SHA-256 is supported, but other hash algorithms can easily be added.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/Kconfig                   |   2 +
 fs/Makefile                  |   1 +
 fs/verity/Kconfig            |  38 +++++
 fs/verity/Makefile           |   4 +
 fs/verity/fsverity_private.h |  91 ++++++++++++
 fs/verity/hash_algs.c        | 274 +++++++++++++++++++++++++++++++++++
 fs/verity/init.c             |  41 ++++++
 7 files changed, 451 insertions(+)
 create mode 100644 fs/verity/Kconfig
 create mode 100644 fs/verity/Makefile
 create mode 100644 fs/verity/fsverity_private.h
 create mode 100644 fs/verity/hash_algs.c
 create mode 100644 fs/verity/init.c

diff --git a/fs/Kconfig b/fs/Kconfig
index f1046cf6ad85..4b66dafbdc7b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -113,6 +113,8 @@ config MANDATORY_FILE_LOCKING
 
 source "fs/crypto/Kconfig"
 
+source "fs/verity/Kconfig"
+
 source "fs/notify/Kconfig"
 
 source "fs/quota/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..fe7f2c07f482 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_AIO)               += aio.o
 obj-$(CONFIG_IO_URING)		+= io_uring.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
+obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
 obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
new file mode 100644
index 000000000000..c2bca0b01ecf
--- /dev/null
+++ b/fs/verity/Kconfig
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config FS_VERITY
+	bool "FS Verity (read-only file-based authenticity protection)"
+	select CRYPTO
+	# SHA-256 is selected as it's intended to be the default hash algorithm.
+	# To avoid bloat, other wanted algorithms must be selected explicitly.
+	select CRYPTO_SHA256
+	help
+	  This option enables fs-verity.  fs-verity is the dm-verity
+	  mechanism implemented at the file level.  On supported
+	  filesystems (currently EXT4 and F2FS), userspace can use an
+	  ioctl to enable verity for a file, which causes the filesystem
+	  to build a Merkle tree for the file.  The filesystem will then
+	  transparently verify any data read from the file against the
+	  Merkle tree.  The file is also made read-only.
+
+	  This serves as an integrity check, but the availability of the
+	  Merkle tree root hash also allows efficiently supporting
+	  various use cases where normally the whole file would need to
+	  be hashed at once, such as: (a) auditing (logging the file's
+	  hash), or (b) authenticity verification (comparing the hash
+	  against a known good value, e.g. from a digital signature).
+
+	  fs-verity is especially useful on large files where not all
+	  the contents may actually be needed.  Also, fs-verity verifies
+	  data each time it is paged back in, which provides better
+	  protection against malicious disks vs. an ahead-of-time hash.
+
+	  If unsure, say N.
+
+config FS_VERITY_DEBUG
+	bool "FS Verity debugging"
+	depends on FS_VERITY
+	help
+	  Enable debugging messages related to fs-verity by default.
+
+	  Say N unless you are an fs-verity developer.
diff --git a/fs/verity/Makefile b/fs/verity/Makefile
new file mode 100644
index 000000000000..398f3f85fa18
--- /dev/null
+++ b/fs/verity/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FS_VERITY) += hash_algs.o \
+			   init.o
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
new file mode 100644
index 000000000000..c879189bfd61
--- /dev/null
+++ b/fs/verity/fsverity_private.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * fs-verity: read-only file-based authenticity protection
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef _FSVERITY_PRIVATE_H
+#define _FSVERITY_PRIVATE_H
+
+#ifdef CONFIG_FS_VERITY_DEBUG
+#define DEBUG
+#endif
+
+#define pr_fmt(fmt) "fs-verity: " fmt
+
+#include <crypto/sha.h>
+#include <linux/fs.h>
+#include <uapi/linux/fsverity.h>
+
+struct ahash_request;
+
+/*
+ * Maximum depth of the Merkle tree.  Up to 64 levels are theoretically possible
+ * with a very small block size, but we'd like to limit stack usage during
+ * verification, and in practice this is plenty.  E.g., with SHA-256 and 4K
+ * blocks, a file with size UINT64_MAX bytes needs just 8 levels.
+ */
+#define FS_VERITY_MAX_LEVELS		16
+
+/*
+ * Largest digest size among all hash algorithms supported by fs-verity.
+ * Currently assumed to be <= size of fsverity_descriptor::root_hash.
+ */
+#define FS_VERITY_MAX_DIGEST_SIZE	SHA256_DIGEST_SIZE
+
+/* A hash algorithm supported by fs-verity */
+struct fsverity_hash_alg {
+	struct crypto_ahash *tfm; /* hash tfm, allocated on demand */
+	const char *name;	  /* crypto API name, e.g. sha256 */
+	unsigned int digest_size; /* digest size in bytes, e.g. 32 for SHA-256 */
+	unsigned int block_size;  /* block size in bytes, e.g. 64 for SHA-256 */
+};
+
+/* Merkle tree parameters: hash algorithm, initial hash state, and topology */
+struct merkle_tree_params {
+	const struct fsverity_hash_alg *hash_alg; /* the hash algorithm */
+	const u8 *hashstate;		/* initial hash state or NULL */
+	unsigned int digest_size;	/* same as hash_alg->digest_size */
+	unsigned int block_size;	/* size of data and tree blocks */
+	unsigned int hashes_per_block;	/* number of hashes per tree block */
+	unsigned int log_blocksize;	/* log2(block_size) */
+	unsigned int log_arity;		/* log2(hashes_per_block) */
+	unsigned int num_levels;	/* number of levels in Merkle tree */
+	u64 data_size;			/* data size in bytes */
+	u64 tree_size;			/* Merkle tree size in bytes */
+
+	/*
+	 * Starting block index for each tree level, ordered from leaf level (0)
+	 * to root level ('num_levels - 1')
+	 */
+	u64 level_start[FS_VERITY_MAX_LEVELS];
+};
+
+/* hash_algs.c */
+
+extern struct fsverity_hash_alg fsverity_hash_algs[];
+
+const struct fsverity_hash_alg *fsverity_get_hash_alg(const struct inode *inode,
+						      unsigned int num);
+const u8 *fsverity_prepare_hash_state(const struct fsverity_hash_alg *alg,
+				      const u8 *salt, size_t salt_size);
+int fsverity_hash_page(const struct merkle_tree_params *params,
+		       const struct inode *inode,
+		       struct ahash_request *req, struct page *page, u8 *out);
+int fsverity_hash_buffer(const struct fsverity_hash_alg *alg,
+			 const void *data, size_t size, u8 *out);
+void __init fsverity_check_hash_algs(void);
+
+/* init.c */
+
+extern void __printf(3, 4) __cold
+fsverity_msg(const struct inode *inode, const char *level,
+	     const char *fmt, ...);
+
+#define fsverity_warn(inode, fmt, ...)		\
+	fsverity_msg((inode), KERN_WARNING, fmt, ##__VA_ARGS__)
+#define fsverity_err(inode, fmt, ...)		\
+	fsverity_msg((inode), KERN_ERR, fmt, ##__VA_ARGS__)
+
+#endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
new file mode 100644
index 000000000000..46df17094fc2
--- /dev/null
+++ b/fs/verity/hash_algs.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/verity/hash_algs.c: fs-verity hash algorithms
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include "fsverity_private.h"
+
+#include <crypto/hash.h>
+#include <linux/scatterlist.h>
+
+/* The hash algorithms supported by fs-verity */
+struct fsverity_hash_alg fsverity_hash_algs[] = {
+	[FS_VERITY_HASH_ALG_SHA256] = {
+		.name = "sha256",
+		.digest_size = SHA256_DIGEST_SIZE,
+		.block_size = SHA256_BLOCK_SIZE,
+	},
+};
+
+/**
+ * fsverity_get_hash_alg() - validate and prepare a hash algorithm
+ * @inode: optional inode for logging purposes
+ * @num: the hash algorithm number
+ *
+ * Get the struct fsverity_hash_alg for the given hash algorithm number, and
+ * ensure it has a hash transform ready to go.  The hash transforms are
+ * allocated on-demand so that we don't waste resources unnecessarily, and
+ * because the crypto modules may be initialized later than fs/verity/.
+ *
+ * Return: pointer to the hash alg on success, else an ERR_PTR()
+ */
+const struct fsverity_hash_alg *fsverity_get_hash_alg(const struct inode *inode,
+						      unsigned int num)
+{
+	struct fsverity_hash_alg *alg;
+	struct crypto_ahash *tfm;
+	int err;
+
+	if (num >= ARRAY_SIZE(fsverity_hash_algs) ||
+	    !fsverity_hash_algs[num].name) {
+		fsverity_warn(inode, "Unknown hash algorithm number: %u", num);
+		return ERR_PTR(-EINVAL);
+	}
+	alg = &fsverity_hash_algs[num];
+
+	/* pairs with cmpxchg() below */
+	tfm = READ_ONCE(alg->tfm);
+	if (likely(tfm != NULL))
+		return alg;
+	/*
+	 * Using the shash API would make things a bit simpler, but the ahash
+	 * API is preferable as it allows the use of crypto accelerators.
+	 */
+	tfm = crypto_alloc_ahash(alg->name, 0, 0);
+	if (IS_ERR(tfm)) {
+		if (PTR_ERR(tfm) == -ENOENT)
+			fsverity_warn(inode,
+				      "Missing crypto API support for hash algorithm \"%s\"",
+				      alg->name);
+		else
+			fsverity_err(inode,
+				     "Error allocating hash algorithm \"%s\": %ld",
+				     alg->name, PTR_ERR(tfm));
+		return ERR_CAST(tfm);
+	}
+
+	err = -EINVAL;
+	if (WARN_ON(alg->digest_size != crypto_ahash_digestsize(tfm)))
+		goto err_free_tfm;
+	if (WARN_ON(alg->block_size != crypto_ahash_blocksize(tfm)))
+		goto err_free_tfm;
+
+	pr_info("%s using implementation \"%s\"\n",
+		alg->name, crypto_ahash_driver_name(tfm));
+
+	/* pairs with READ_ONCE() above */
+	if (cmpxchg(&alg->tfm, NULL, tfm) != NULL)
+		crypto_free_ahash(tfm);
+
+	return alg;
+
+err_free_tfm:
+	crypto_free_ahash(tfm);
+	return ERR_PTR(err);
+}
+
+/**
+ * fsverity_prepare_hash_state() - precompute the initial hash state
+ * @alg: hash algorithm
+ * @salt: a salt which is to be prepended to all data to be hashed
+ * @salt_size: salt size in bytes, possibly 0
+ *
+ * Return: NULL if the salt is empty, otherwise the kmalloc()'ed precomputed
+ *	   initial hash state on success or an ERR_PTR() on failure.
+ */
+const u8 *fsverity_prepare_hash_state(const struct fsverity_hash_alg *alg,
+				      const u8 *salt, size_t salt_size)
+{
+	u8 *hashstate = NULL;
+	struct ahash_request *req = NULL;
+	u8 *padded_salt = NULL;
+	size_t padded_salt_size;
+	struct scatterlist sg;
+	DECLARE_CRYPTO_WAIT(wait);
+	int err;
+
+	if (salt_size == 0)
+		return NULL;
+
+	hashstate = kmalloc(crypto_ahash_statesize(alg->tfm), GFP_KERNEL);
+	if (!hashstate)
+		return ERR_PTR(-ENOMEM);
+
+	req = ahash_request_alloc(alg->tfm, GFP_KERNEL);
+	if (!req) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+
+	/*
+	 * Zero-pad the salt to the next multiple of the input size of the hash
+	 * algorithm's compression function, e.g. 64 bytes for SHA-256 or 128
+	 * bytes for SHA-512.  This ensures that the hash algorithm won't have
+	 * any bytes buffered internally after processing the salt, thus making
+	 * salted hashing just as fast as unsalted hashing.
+	 */
+	padded_salt_size = round_up(salt_size, alg->block_size);
+	padded_salt = kzalloc(padded_salt_size, GFP_KERNEL);
+	if (!padded_salt) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+	memcpy(padded_salt, salt, salt_size);
+
+	sg_init_one(&sg, padded_salt, padded_salt_size);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP |
+					CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	ahash_request_set_crypt(req, &sg, NULL, padded_salt_size);
+
+	err = crypto_wait_req(crypto_ahash_init(req), &wait);
+	if (err)
+		goto err_free;
+
+	err = crypto_wait_req(crypto_ahash_update(req), &wait);
+	if (err)
+		goto err_free;
+
+	err = crypto_ahash_export(req, hashstate);
+	if (err)
+		goto err_free;
+out:
+	kfree(padded_salt);
+	ahash_request_free(req);
+	return hashstate;
+
+err_free:
+	kfree(hashstate);
+	hashstate = ERR_PTR(err);
+	goto out;
+}
+
+/**
+ * fsverity_hash_page() - hash a single data or hash page
+ * @params: the Merkle tree's parameters
+ * @inode: inode for which the hashing is being done
+ * @req: preallocated hash request
+ * @page: the page to hash
+ * @out: output digest, size 'params->digest_size' bytes
+ *
+ * Hash a single data or hash block, assuming block_size == PAGE_SIZE.
+ * The hash is salted if a salt is specified in the Merkle tree parameters.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_hash_page(const struct merkle_tree_params *params,
+		       const struct inode *inode,
+		       struct ahash_request *req, struct page *page, u8 *out)
+{
+	struct scatterlist sg;
+	DECLARE_CRYPTO_WAIT(wait);
+	int err;
+
+	if (WARN_ON(params->block_size != PAGE_SIZE))
+		return -EINVAL;
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, page, PAGE_SIZE, 0);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP |
+					CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	ahash_request_set_crypt(req, &sg, out, PAGE_SIZE);
+
+	if (params->hashstate) {
+		err = crypto_ahash_import(req, params->hashstate);
+		if (err) {
+			fsverity_err(inode,
+				     "Error %d importing hash state", err);
+			return err;
+		}
+		err = crypto_ahash_finup(req);
+	} else {
+		err = crypto_ahash_digest(req);
+	}
+
+	err = crypto_wait_req(err, &wait);
+	if (err)
+		fsverity_err(inode, "Error %d computing page hash", err);
+	return err;
+}
+
+/**
+ * fsverity_hash_buffer() - hash some data
+ * @alg: the hash algorithm to use
+ * @data: the data to hash
+ * @size: size of data to hash
+ * @out: output digest, size 'alg->digest_size' bytes
+ *
+ * Hash some data which is located in physically contiguous memory (i.e. memory
+ * allocated by kmalloc(), not by vmalloc()).  No salt is used.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_hash_buffer(const struct fsverity_hash_alg *alg,
+			 const void *data, size_t size, u8 *out)
+{
+	struct ahash_request *req;
+	struct scatterlist sg;
+	DECLARE_CRYPTO_WAIT(wait);
+	int err;
+
+	req = ahash_request_alloc(alg->tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	sg_init_one(&sg, data, size);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP |
+					CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	ahash_request_set_crypt(req, &sg, out, size);
+
+	err = crypto_wait_req(crypto_ahash_digest(req), &wait);
+
+	ahash_request_free(req);
+	return err;
+}
+
+void __init fsverity_check_hash_algs(void)
+{
+	size_t i;
+
+	/*
+	 * Sanity check the hash algorithms (could be a build-time check, but
+	 * they're in an array)
+	 */
+	for (i = 0; i < ARRAY_SIZE(fsverity_hash_algs); i++) {
+		const struct fsverity_hash_alg *alg = &fsverity_hash_algs[i];
+
+		if (!alg->name)
+			continue;
+
+		BUG_ON(alg->digest_size > FS_VERITY_MAX_DIGEST_SIZE);
+
+		/*
+		 * For efficiency, the implementation currently assumes the
+		 * digest and block sizes are powers of 2.  This limitation can
+		 * be lifted if the code is updated to handle other values.
+		 */
+		BUG_ON(!is_power_of_2(alg->digest_size));
+		BUG_ON(!is_power_of_2(alg->block_size));
+	}
+}
diff --git a/fs/verity/init.c b/fs/verity/init.c
new file mode 100644
index 000000000000..40076bbe452a
--- /dev/null
+++ b/fs/verity/init.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/verity/init.c: fs-verity module initialization and logging
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include "fsverity_private.h"
+
+#include <linux/ratelimit.h>
+
+void fsverity_msg(const struct inode *inode, const char *level,
+		  const char *fmt, ...)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	struct va_format vaf;
+	va_list args;
+
+	if (!__ratelimit(&rs))
+		return;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	if (inode)
+		printk("%sfs-verity (%s, inode %lu): %pV\n",
+		       level, inode->i_sb->s_id, inode->i_ino, &vaf);
+	else
+		printk("%sfs-verity: %pV\n", level, &vaf);
+	va_end(args);
+}
+
+static int __init fsverity_init(void)
+{
+	fsverity_check_hash_algs();
+
+	pr_debug("Initialized fs-verity\n");
+	return 0;
+}
+late_initcall(fsverity_init)
-- 
2.21.0

