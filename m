Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF5274E3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 03:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgIWBJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 21:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgIWBJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:09:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FADC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:32 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g1so17806015qtc.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 18:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5NzLmrfIvFl4vmHDsUrqH66sakxn3yn+5FHfj9CLrSk=;
        b=r+SN94ExEtQMPsSJHIerdOB77MAXWzmZwyFneNmoAk49k6roAYOafIpq6/bVGJgknf
         xDip3oHkpH42R6dI4QewUZcaBwPMVq6ODAPkayZv/4kxo++i/JjDTb3jmigDwMuponz+
         gQ9QBOprkNqmFdjMbG30Ik+3nu+B4dlxFOozhLEhJ3zcb+ZEZZvMqS+YJqw3NXZh5XV1
         0heENiRe5ihlsoHmsFVz0rx4o9ZBU50Y8OfhTNND68hRdv8PQG6Xc8x4mjB7eVbYcjUM
         VtMkXdZn29qoBgfIzG9ScD8gQ4rFVM+uiAHi8/TfBcqqF7Bd0GlNAEsmqAT+bUm9nkRm
         sIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5NzLmrfIvFl4vmHDsUrqH66sakxn3yn+5FHfj9CLrSk=;
        b=hIWJhCffdyO1YH+1Iel+8xBCn4Oiq0wEpJffQHt6EUa6WGwrOtLx3PrKr2flF7bP3m
         WPbRNaF1GEm+gVhKBkumbi+r1YYRPX0M45vgq+sRoI+68K4j0dtYbVoFTafOPaktB6n4
         O7mne7jN79DMU/zBlVDGY3mkyUze792ceB1r7F8Nz6ROVwVS688Ei0GZyopYuPnNfnBH
         h18sAkaoarnC1dWudKZm7UUdMdEW8dv9PrV6nIkt4dfrkjwROJSAicpwDA/ErH8H9V3x
         S1qeievFt5FuuJu0MPvVljhl5flLu70awO3//fl5g9o0OmDaDh9MeOYmD0957Hp5iH/r
         KgjA==
X-Gm-Message-State: AOAM533pDJjYlWyDG3s2pEeUZHdqZwmFtIVGLY3tQH6W3rBcyFha2rMc
        h/JDfVqYTb6THdm2iE663jyOeo54qJg=
X-Google-Smtp-Source: ABdhPJxv1Hdlfj8ugCdnaEAvvXDxMVYKo8a2NyX+Ru6k+x2fIYfIZAKDUuzPfngdOaYjfUIXgJFf9ofvshM=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a0c:b29e:: with SMTP id r30mr9102695qve.38.1600823371337;
 Tue, 22 Sep 2020 18:09:31 -0700 (PDT)
Date:   Wed, 23 Sep 2020 01:01:51 +0000
In-Reply-To: <20200923010151.69506-1-drosen@google.com>
Message-Id: <20200923010151.69506-6-drosen@google.com>
Mime-Version: 1.0
References: <20200923010151.69506-1-drosen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 5/5] f2fs: Handle casefolding with Encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expand f2fs's casefolding support to include encrypted directories.  To
index casefolded+encrypted directories, we use the SipHash of the
casefolded name, keyed by a key derived from the directory's fscrypt
master key.  This ensures that the dirhash doesn't leak information
about the plaintext filenames.

Encryption keys are unavailable during roll-forward recovery, so we
can't compute the dirhash when recovering a new dentry in an encrypted +
casefolded directory.  To avoid having to force a checkpoint when a new
file is fsync'ed, store the dirhash on-disk appended to i_name.

This patch incorporates work by Eric Biggers <ebiggers@google.com>
and Jaegeuk Kim <jaegeuk@kernel.org>.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/dir.c      | 57 +++++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/f2fs.h     |  8 ++++---
 fs/f2fs/hash.c     | 11 ++++++++-
 fs/f2fs/recovery.c | 12 +++++++++-
 fs/f2fs/super.c    |  6 -----
 5 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 0766e6250a88..07004eb6edf8 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
+#include <asm/unaligned.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/sched/signal.h>
@@ -218,9 +219,28 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 {
 	const struct super_block *sb = dir->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
 	int res;
 
+	if (IS_ENCRYPTED(dir)) {
+		const struct fscrypt_str encrypted_name =
+			FSTR_INIT((u8 *)de_name, de_name_len);
+
+		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
+			return false;
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return false;
+		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (res < 0)
+			goto out;
+		entry.name = decrypted_name.name;
+		entry.len = decrypted_name.len;
+	}
+
 	res = utf8_strncasecmp_folded(um, name, &entry);
 	if (res < 0) {
 		/*
@@ -228,9 +248,12 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
 		 * fall back to treating them as opaque byte sequences.
 		 */
 		if (sb_has_strict_encoding(sb) || name->len != entry.len)
-			return false;
-		return !memcmp(name->name, entry.name, name->len);
+			res = 1;
+		else
+			res = memcmp(name->name, entry.name, name->len);
 	}
+out:
+	kfree(decrypted_name.name);
 	return res == 0;
 }
 #endif /* CONFIG_UNICODE */
@@ -455,17 +478,39 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	f2fs_put_page(page, 1);
 }
 
-static void init_dent_inode(const struct f2fs_filename *fname,
+static void init_dent_inode(struct inode *dir, struct inode *inode,
+			    const struct f2fs_filename *fname,
 			    struct page *ipage)
 {
 	struct f2fs_inode *ri;
 
+	if (!fname) /* tmpfile case? */
+		return;
+
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
 	/* copy name info. to this inode page */
 	ri = F2FS_INODE(ipage);
 	ri->i_namelen = cpu_to_le32(fname->disk_name.len);
 	memcpy(ri->i_name, fname->disk_name.name, fname->disk_name.len);
+	if (IS_ENCRYPTED(dir)) {
+		file_set_enc_name(inode);
+		/*
+		 * Roll-forward recovery doesn't have encryption keys available,
+		 * so it can't compute the dirhash for encrypted+casefolded
+		 * filenames.  Append it to i_name if possible.  Else, disable
+		 * roll-forward recovery of the dentry (i.e., make fsync'ing the
+		 * file force a checkpoint) by setting LOST_PINO.
+		 */
+		if (IS_CASEFOLDED(dir)) {
+			if (fname->disk_name.len + sizeof(f2fs_hash_t) <=
+			    F2FS_NAME_LEN)
+				put_unaligned(fname->hash, (f2fs_hash_t *)
+					&ri->i_name[fname->disk_name.len]);
+			else
+				file_lost_pino(inode);
+		}
+	}
 	set_page_dirty(ipage);
 }
 
@@ -548,11 +593,7 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			return page;
 	}
 
-	if (fname) {
-		init_dent_inode(fname, page);
-		if (IS_ENCRYPTED(dir))
-			file_set_enc_name(inode);
-	}
+	init_dent_inode(dir, inode, fname, page);
 
 	/*
 	 * This file should be checkpointed during fsync.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index af1d469e8c1e..9d58fd5dae13 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -533,9 +533,11 @@ struct f2fs_filename {
 #ifdef CONFIG_UNICODE
 	/*
 	 * For casefolded directories: the casefolded name, but it's left NULL
-	 * if the original name is not valid Unicode or if the filesystem is
-	 * doing an internal operation where usr_fname is also NULL.  In these
-	 * cases we fall back to treating the name as an opaque byte sequence.
+	 * if the original name is not valid Unicode, if the directory is both
+	 * casefolded and encrypted and its encryption key is unavailable, or if
+	 * the filesystem is doing an internal operation where usr_fname is also
+	 * NULL.  In all these cases we fall back to treating the name as an
+	 * opaque byte sequence.
 	 */
 	struct fscrypt_str cf_name;
 #endif
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index de841aaf3c43..e3beac546c63 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -111,7 +111,9 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname)
 		 * If the casefolded name is provided, hash it instead of the
 		 * on-disk name.  If the casefolded name is *not* provided, that
 		 * should only be because the name wasn't valid Unicode, so fall
-		 * back to treating the name as an opaque byte sequence.
+		 * back to treating the name as an opaque byte sequence.  Note
+		 * that to handle encrypted directories, the fallback must use
+		 * usr_fname (plaintext) rather than disk_name (ciphertext).
 		 */
 		WARN_ON_ONCE(!fname->usr_fname->name);
 		if (fname->cf_name.name) {
@@ -121,6 +123,13 @@ void f2fs_hash_filename(const struct inode *dir, struct f2fs_filename *fname)
 			name = fname->usr_fname->name;
 			len = fname->usr_fname->len;
 		}
+		if (IS_ENCRYPTED(dir)) {
+			struct qstr tmp = QSTR_INIT(name, len);
+
+			fname->hash =
+				cpu_to_le32(fscrypt_fname_siphash(dir, &tmp));
+			return;
+		}
 	}
 #endif
 	fname->hash = cpu_to_le32(TEA_hash_name(name, len));
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4f12ade6410a..0947d36af1a8 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
+#include <asm/unaligned.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include "f2fs.h"
@@ -128,7 +129,16 @@ static int init_recovered_filename(const struct inode *dir,
 	}
 
 	/* Compute the hash of the filename */
-	if (IS_CASEFOLDED(dir)) {
+	if (IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir)) {
+		/*
+		 * In this case the hash isn't computable without the key, so it
+		 * was saved on-disk.
+		 */
+		if (fname->disk_name.len + sizeof(f2fs_hash_t) > F2FS_NAME_LEN)
+			return -EINVAL;
+		fname->hash = get_unaligned((f2fs_hash_t *)
+				&raw_inode->i_name[fname->disk_name.len]);
+	} else if (IS_CASEFOLDED(dir)) {
 		err = f2fs_init_casefolded_name(dir, fname);
 		if (err)
 			return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 63c744c6aeff..c2e441b256a7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3382,12 +3382,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
 
-		if (f2fs_sb_has_encrypt(sbi)) {
-			f2fs_err(sbi,
-				"Can't mount with encoding and encryption");
-			return -EINVAL;
-		}
-
 		if (f2fs_sb_read_encoding(sbi->raw_super, &encoding_info,
 					  &encoding_flags)) {
 			f2fs_err(sbi,
-- 
2.28.0.681.g6f77f65b4e-goog

