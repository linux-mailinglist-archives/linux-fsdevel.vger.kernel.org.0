Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300EE23EA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404001AbfETR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 13:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392931AbfETR2v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 13:28:51 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B717F21743;
        Mon, 20 May 2019 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558373329;
        bh=3Hac7JSncuRylFl1XE2rUVFqFsp8CGlGji73/DhMvKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYxLZnwbyukeBJAZArDFvZmD7Cu/RmrglTlkZAwtzvbLdvLnxTqnQxXCPjq1LB2Ny
         rzMQGbXbA/LIPTK6hZgY6+/v/+1eAzu+Ye2WKnIAnSvfdRzx2YNuQ60wEJw5fQDD9F
         29HqA9RiuvuBYOn+psSPJ+jyRAzxGhwSNm3v8HDo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>, linux-api@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, keyrings@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v6 07/16] fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl
Date:   Mon, 20 May 2019 10:25:43 -0700
Message-Id: <20190520172552.217253-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520172552.217253-1-ebiggers@kernel.org>
References: <20190520172552.217253-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a new fscrypt ioctl, FS_IOC_REMOVE_ENCRYPTION_KEY.  This ioctl
removes an encryption key that was added by FS_IOC_ADD_ENCRYPTION_KEY.
It wipes the secret key itself, then "locks" the encrypted files and
directories that had been unlocked using that key -- implemented by
evicting the relevant dentries and inodes from the VFS caches.

The problem this solves is that many fscrypt users want the ability to
remove encryption keys, causing the corresponding encrypted directories
to appear "locked" (presented in ciphertext form) again.  Moreover,
users want removing an encryption key to *really* remove it, in the
sense that the removed keys cannot be recovered even if kernel memory is
compromised, e.g. by the exploit of a kernel security vulnerability or
by a physical attack.  This is desirable after a user logs out of the
system, for example.  In many cases users even already assume this to be
the case and are surprised to hear when it's not.

It is not sufficient to simply unlink the master key from the keyring
(or to revoke or invalidate it), since the actual encryption transform
objects are still pinned in memory by their inodes.  Therefore, to
really remove a key we must also evict the relevant inodes.

Currently one workaround is to run 'sync && echo 2 >
/proc/sys/vm/drop_caches'.  But, that evicts all unused inodes in the
system rather than just the inodes associated with the key being
removed, causing severe performance problems.  Moreover, it requires
root privileges, so regular users can't "lock" their encrypted files.

Another workaround, used in Chromium OS kernels, is to add a new
VFS-level ioctl FS_IOC_DROP_CACHE which is a more restricted version of
drop_caches that operates on a single super_block.  It does:

        shrink_dcache_sb(sb);
        invalidate_inodes(sb, false);

But it's still a hack.  Yet, the major users of filesystem encryption
want this feature badly enough that they are actually using these hacks.

To properly solve the problem, start maintaining a list of the inodes
which have been "unlocked" using each master key.  Originally this
wasn't possible because the kernel didn't keep track of in-use master
keys at all.  But, with the ->s_master_keys keyring it is now possible.

Then, add an ioctl FS_IOC_REMOVE_ENCRYPTION_KEY.  It finds the specified
master key in ->s_master_keys, then wipes the secret key itself, which
prevents any additional inodes from being unlocked with the key.  Then,
it syncs the filesystem and evicts the inodes in the key's list.  The
normal inode eviction code will free and wipe the per-file keys (in
->i_crypt_info).  Note that freeing ->i_crypt_info without evicting the
inodes was also considered, but would have been racy.

Some inodes may still be in use when a master key is removed, and we
can't simply revoke random file descriptors, mmap's, etc.  Thus, the
ioctl simply skips in-use inodes, and returns -EBUSY to indicate that
some inodes weren't evicted.  The master key *secret* is still removed,
but the fscrypt_master_key struct remains to keep track of the remaining
inodes.  Userspace can then retry the ioctl to evict the remaining
inodes.  Alternatively, if userspace adds the key again, the refreshed
secret will be associated with the existing list of inodes so they
remain correctly tracked for future key removals.

The ioctl doesn't wipe pagecache pages.  Thus, we tolerate that after a
kernel compromise some portions of plaintext file contents may still be
recoverable from memory.  This can be solved be enabling page poisoning
system-wide, which security conscious users may choose to do.  But it's
very difficult to solve otherwise, e.g. note that plaintext file
contents may have been read in other places than pagecache pages.

Like FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY is
initially restricted to privileged users only.  This is sufficient for
some use cases, but not all.  A later patch will relax this restriction,
but it will require introducing key hashes, among other changes.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h  |  53 +++++++-
 fs/crypto/keyring.c          | 247 ++++++++++++++++++++++++++++++++++-
 fs/crypto/keysetup.c         | 103 ++++++++++++++-
 include/linux/fscrypt.h      |  13 ++
 include/uapi/linux/fscrypt.h |   7 +
 5 files changed, 418 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index b4c4312085554..cc1862c9baa1d 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -78,6 +78,19 @@ struct fscrypt_info {
 	/* Back-pointer to the inode */
 	struct inode *ci_inode;
 
+	/*
+	 * The master key with which this inode was unlocked (decrypted).  This
+	 * will be NULL if the master key was found in a process-subscribed
+	 * keyring rather than in the filesystem-level keyring.
+	 */
+	struct key *ci_master_key;
+
+	/*
+	 * Link in list of inodes that were unlocked with the master key.
+	 * Only used when ->ci_master_key is set.
+	 */
+	struct list_head ci_master_key_link;
+
 	/*
 	 * If non-NULL, then encryption is done using the master key directly
 	 * and ci_ctfm will equal ci_direct_key->dk_ctfm.
@@ -186,14 +199,52 @@ struct fscrypt_master_key_secret {
  */
 struct fscrypt_master_key {
 
-	/* The secret key material */
+	/*
+	 * The secret key material.  After FS_IOC_REMOVE_ENCRYPTION_KEY is
+	 * executed, this is wiped and no new inodes can be unlocked with this
+	 * key; however, there may still be inodes in ->mk_decrypted_inodes
+	 * which could not be evicted.  As long as some inodes still remain,
+	 * FS_IOC_REMOVE_ENCRYPTION_KEY can be retried, or
+	 * FS_IOC_ADD_ENCRYPTION_KEY can add the secret again.
+	 *
+	 * Locking: protected by key->sem.
+	 */
 	struct fscrypt_master_key_secret	mk_secret;
 
 	/* Arbitrary key descriptor which was assigned by userspace */
 	struct fscrypt_key_specifier		mk_spec;
 
+	/*
+	 * Length of ->mk_decrypted_inodes, plus one if mk_secret is present.
+	 * Once this goes to 0, the master key is removed from ->s_master_keys.
+	 * The 'struct fscrypt_master_key' will continue to live as long as the
+	 * 'struct key' whose payload it is, but we won't let this reference
+	 * count rise again.
+	 */
+	refcount_t		mk_refcount;
+
+	/*
+	 * List of inodes that were unlocked using this key.  This allows the
+	 * inodes to be evicted efficiently if the key is removed.
+	 */
+	struct list_head	mk_decrypted_inodes;
+	spinlock_t		mk_decrypted_inodes_lock;
+
 } __randomize_layout;
 
+static inline bool
+is_master_key_secret_present(const struct fscrypt_master_key_secret *secret)
+{
+	/*
+	 * The READ_ONCE() is only necessary for fscrypt_drop_inode() and
+	 * fscrypt_key_describe().  These run in atomic context, so they can't
+	 * take key->sem and thus 'secret' can change concurrently which would
+	 * be a data race.  But they only need to know whether the secret *was*
+	 * present at the time of check, so READ_ONCE() suffices.
+	 */
+	return READ_ONCE(secret->size) != 0;
+}
+
 extern struct key *
 fscrypt_find_master_key(struct super_block *sb,
 			const struct fscrypt_key_specifier *mk_spec);
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 481916013c713..701da63f01073 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -10,6 +10,7 @@
  * filesystem-level keyring, including the ioctls:
  *
  * - FS_IOC_ADD_ENCRYPTION_KEY: add a key
+ * - FS_IOC_REMOVE_ENCRYPTION_KEY: remove a key
  */
 
 #include <linux/key-type.h>
@@ -66,6 +67,13 @@ static void fscrypt_key_destroy(struct key *key)
 static void fscrypt_key_describe(const struct key *key, struct seq_file *m)
 {
 	seq_puts(m, key->description);
+
+	if (key_is_positive(key)) {
+		const struct fscrypt_master_key *mk = key->payload.data[0];
+
+		if (!is_master_key_secret_present(&mk->mk_secret))
+			seq_puts(m, ": secret removed");
+	}
 }
 
 /*
@@ -192,6 +200,10 @@ static int add_new_master_key(struct fscrypt_master_key_secret *secret,
 
 	move_master_key_secret(&mk->mk_secret, secret);
 
+	refcount_set(&mk->mk_refcount, 1); /* secret is present */
+	INIT_LIST_HEAD(&mk->mk_decrypted_inodes);
+	spin_lock_init(&mk->mk_decrypted_inodes_lock);
+
 	format_mk_description(description, mk_spec);
 	key = key_alloc(&key_type_fscrypt, description,
 			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
@@ -213,6 +225,22 @@ static int add_new_master_key(struct fscrypt_master_key_secret *secret,
 	return err;
 }
 
+#define KEY_DEAD	1
+
+static int add_existing_master_key(struct fscrypt_master_key *mk,
+				   struct fscrypt_master_key_secret *secret,
+				   const struct fscrypt_key_specifier *mk_spec)
+{
+	if (is_master_key_secret_present(&mk->mk_secret))
+		return 0;
+
+	if (!refcount_inc_not_zero(&mk->mk_refcount))
+		return KEY_DEAD;
+
+	move_master_key_secret(&mk->mk_secret, secret);
+	return 0;
+}
+
 static int add_master_key(struct super_block *sb,
 			  struct fscrypt_master_key_secret *secret,
 			  const struct fscrypt_key_specifier *mk_spec)
@@ -222,6 +250,7 @@ static int add_master_key(struct super_block *sb,
 	int err;
 
 	mutex_lock(&fscrypt_add_key_mutex); /* serialize find + link */
+retry:
 	key = fscrypt_find_master_key(sb, mk_spec);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
@@ -233,8 +262,21 @@ static int add_master_key(struct super_block *sb,
 			goto out_unlock;
 		err = add_new_master_key(secret, mk_spec, sb->s_master_keys);
 	} else {
+		/*
+		 * Found the key in ->s_master_keys.  Re-add the secret if
+		 * needed.
+		 */
+		down_write(&key->sem);
+		err = add_existing_master_key(key->payload.data[0], secret,
+					      mk_spec);
+		up_write(&key->sem);
+		if (err == KEY_DEAD) {
+			/* Key being removed or needs to be removed */
+			key_invalidate(key);
+			key_put(key);
+			goto retry;
+		}
 		key_put(key);
-		err = 0;
 	}
 out_unlock:
 	mutex_unlock(&fscrypt_add_key_mutex);
@@ -283,6 +325,209 @@ int fscrypt_ioctl_add_key(struct file *filp, void __user *_uarg)
 }
 EXPORT_SYMBOL_GPL(fscrypt_ioctl_add_key);
 
+static void shrink_dcache_inode(struct inode *inode)
+{
+	struct dentry *dentry;
+
+	if (S_ISDIR(inode->i_mode)) {
+		dentry = d_find_any_alias(inode);
+		if (dentry) {
+			shrink_dcache_parent(dentry);
+			dput(dentry);
+		}
+	}
+	d_prune_aliases(inode);
+}
+
+static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
+{
+	struct fscrypt_info *ci;
+	struct inode *inode;
+	struct inode *toput_inode = NULL;
+
+	spin_lock(&mk->mk_decrypted_inodes_lock);
+
+	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
+		inode = ci->ci_inode;
+		spin_lock(&inode->i_lock);
+		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(&mk->mk_decrypted_inodes_lock);
+
+		shrink_dcache_inode(inode);
+		iput(toput_inode);
+		toput_inode = inode;
+
+		spin_lock(&mk->mk_decrypted_inodes_lock);
+	}
+
+	spin_unlock(&mk->mk_decrypted_inodes_lock);
+	iput(toput_inode);
+}
+
+static int check_for_busy_inodes(struct super_block *sb,
+				 struct fscrypt_master_key *mk)
+{
+	struct list_head *pos;
+	size_t busy_count = 0;
+	unsigned long ino;
+	struct dentry *dentry;
+	char _path[256];
+	char *path = NULL;
+
+	spin_lock(&mk->mk_decrypted_inodes_lock);
+
+	list_for_each(pos, &mk->mk_decrypted_inodes)
+		busy_count++;
+
+	if (busy_count == 0) {
+		spin_unlock(&mk->mk_decrypted_inodes_lock);
+		return 0;
+	}
+
+	{
+		/* select an example file to show for debugging purposes */
+		struct inode *inode =
+			list_first_entry(&mk->mk_decrypted_inodes,
+					 struct fscrypt_info,
+					 ci_master_key_link)->ci_inode;
+		ino = inode->i_ino;
+		dentry = d_find_alias(inode);
+	}
+	spin_unlock(&mk->mk_decrypted_inodes_lock);
+
+	if (dentry) {
+		path = dentry_path(dentry, _path, sizeof(_path));
+		dput(dentry);
+	}
+	if (IS_ERR_OR_NULL(path))
+		path = "(unknown)";
+
+	fscrypt_warn(sb,
+		     "%zu inodes still busy after removing key with description %*phN, including ino %lu (%s)",
+		     busy_count, master_key_spec_len(&mk->mk_spec),
+		     (u8 *)&mk->mk_spec.u, ino, path);
+	return -EBUSY;
+}
+
+static int try_to_lock_encrypted_files(struct super_block *sb,
+				       struct fscrypt_master_key *mk)
+{
+	int err1;
+	int err2;
+
+	/*
+	 * An inode can't be evicted while it is dirty or has dirty pages.
+	 * Thus, we first have to clean the inodes in ->mk_decrypted_inodes.
+	 *
+	 * Just do it the easy way: call sync_filesystem().  It's overkill, but
+	 * it works, and it's more important to minimize the amount of caches we
+	 * drop than the amount of data we sync.  Also, unprivileged users can
+	 * already call sync_filesystem() via sys_syncfs() or sys_sync().
+	 */
+	down_read(&sb->s_umount);
+	err1 = sync_filesystem(sb);
+	up_read(&sb->s_umount);
+	/* If a sync error occurs, still try to evict as much as possible. */
+
+	/*
+	 * Inodes are pinned by their dentries, so we have to evict their
+	 * dentries.  shrink_dcache_sb() would suffice, but would be overkill
+	 * and inappropriate for use by unprivileged users.  So instead go
+	 * through the inodes' alias lists and try to evict each dentry.
+	 */
+	evict_dentries_for_decrypted_inodes(mk);
+
+	/*
+	 * evict_dentries_for_decrypted_inodes() already iput() each inode in
+	 * the list; any inodes for which that dropped the last reference will
+	 * have been evicted due to fscrypt_drop_inode() detecting the key
+	 * removal and telling the VFS to evict the inode.  So to finish, we
+	 * just need to check whether any inodes couldn't be evicted.
+	 */
+	err2 = check_for_busy_inodes(sb, mk);
+
+	return err1 ?: err2;
+}
+
+/*
+ * Try to remove an fscrypt master encryption key.  If other users have also
+ * added the key, we'll remove the current user's usage of the key, then return
+ * -EUSERS.  Otherwise we'll continue on and try to actually remove the key.
+ *
+ * First we wipe the actual master key secret from memory, so that no more
+ * inodes can be unlocked with it.  Then, we try to evict all cached inodes that
+ * had been unlocked using the key.  Since this can fail for in-use inodes, this
+ * is expected to be used in cooperation with userspace ensuring that none of
+ * the files are still open.
+ *
+ * If, nevertheless, some inodes could not be evicted, we return -EBUSY
+ * (although we still evicted as many inodes as possible) and keep the 'struct
+ * key' and the 'struct fscrypt_master_key' around to keep track of the list of
+ * remaining inodes.  Userspace can then retry the ioctl later to retry evicting
+ * the remaining inodes, or alternatively can add the secret key again.
+ *
+ * Note that even though we wipe the encryption *keys* from memory, decrypted
+ * data can likely still be found in memory, e.g. in pagecache pages that have
+ * been freed.  Wiping such data is currently out of scope, short of users who
+ * may choose to enable page and slab poisoning systemwide.
+ */
+int fscrypt_ioctl_remove_key(struct file *filp, const void __user *uarg)
+{
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct fscrypt_remove_key_arg arg;
+	struct key *key;
+	struct fscrypt_master_key *mk;
+	int err;
+	bool dead;
+
+	if (copy_from_user(&arg, uarg, sizeof(arg)))
+		return -EFAULT;
+
+	if (!valid_key_spec(&arg.key_spec))
+		return -EINVAL;
+
+	if (memchr_inv(arg.__reserved, 0, sizeof(arg.__reserved)))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Find the key being removed. */
+	key = fscrypt_find_master_key(sb, &arg.key_spec);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+	mk = key->payload.data[0];
+
+	down_write(&key->sem);
+
+	/* Wipe the secret. */
+	dead = false;
+	if (is_master_key_secret_present(&mk->mk_secret)) {
+		wipe_master_key_secret(&mk->mk_secret);
+		dead = refcount_dec_and_test(&mk->mk_refcount);
+	}
+	up_write(&key->sem);
+	if (dead) {
+		/*
+		 * We wiped the secret and no inodes reference the key anymore,
+		 * so it's free to remove.
+		 */
+		key_invalidate(key);
+		err = 0;
+	} else {
+		/* Some inodes still reference this key; try to evict them. */
+		err = try_to_lock_encrypted_files(sb, mk);
+	}
+	key_put(key);
+	return err;
+}
+EXPORT_SYMBOL_GPL(fscrypt_ioctl_remove_key);
+
 int __init fscrypt_init_keyring(void)
 {
 	return register_key_type(&key_type_fscrypt);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 13425513fa5c1..55cb146a8a617 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -209,8 +209,16 @@ int fscrypt_set_derived_key(struct fscrypt_info *ci, const u8 *derived_key)
 
 /*
  * Find the master key, then set up the inode's actual encryption key.
+ *
+ * If the master key is found in the filesystem-level keyring, then the
+ * corresponding 'struct key' is returned in *master_key_ret with
+ * ->sem read-locked.  This is needed to ensure that only one task links the
+ * fscrypt_info into ->mk_decrypted_inodes (as multiple tasks may race to create
+ * an fscrypt_info for the same inode), and to synchronize the master key being
+ * removed with a new inode starting to use it.
  */
-static int setup_file_encryption_key(struct fscrypt_info *ci)
+static int setup_file_encryption_key(struct fscrypt_info *ci,
+				     struct key **master_key_ret)
 {
 	struct key *key;
 	struct fscrypt_master_key *mk = NULL;
@@ -230,6 +238,13 @@ static int setup_file_encryption_key(struct fscrypt_info *ci)
 	}
 
 	mk = key->payload.data[0];
+	down_read(&key->sem);
+
+	/* Has the secret been removed (via FS_IOC_REMOVE_ENCRYPTION_KEY)? */
+	if (!is_master_key_secret_present(&mk->mk_secret)) {
+		err = -ENOKEY;
+		goto out_release_key;
+	}
 
 	if (mk->mk_secret.size < ci->ci_mode->keysize) {
 		fscrypt_warn(NULL,
@@ -241,14 +256,22 @@ static int setup_file_encryption_key(struct fscrypt_info *ci)
 	}
 
 	err = fscrypt_setup_v1_file_key(ci, mk->mk_secret.raw);
+	if (err)
+		goto out_release_key;
+
+	*master_key_ret = key;
+	return 0;
 
 out_release_key:
+	up_read(&key->sem);
 	key_put(key);
 	return err;
 }
 
 static void put_crypt_info(struct fscrypt_info *ci)
 {
+	struct key *key;
+
 	if (!ci)
 		return;
 
@@ -258,6 +281,26 @@ static void put_crypt_info(struct fscrypt_info *ci)
 		crypto_free_skcipher(ci->ci_ctfm);
 		crypto_free_cipher(ci->ci_essiv_tfm);
 	}
+
+	key = ci->ci_master_key;
+	if (key) {
+		struct fscrypt_master_key *mk = key->payload.data[0];
+
+		/*
+		 * Remove this inode from the list of inodes that were unlocked
+		 * with the master key.
+		 *
+		 * In addition, if we're removing the last inode from a key that
+		 * already had its secret removed, invalidate the key so that it
+		 * gets removed from ->s_master_keys.
+		 */
+		spin_lock(&mk->mk_decrypted_inodes_lock);
+		list_del(&ci->ci_master_key_link);
+		spin_unlock(&mk->mk_decrypted_inodes_lock);
+		if (refcount_dec_and_test(&mk->mk_refcount))
+			key_invalidate(key);
+		key_put(key);
+	}
 	kmem_cache_free(fscrypt_info_cachep, ci);
 }
 
@@ -266,6 +309,7 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	struct fscrypt_info *crypt_info;
 	struct fscrypt_context ctx;
 	struct fscrypt_mode *mode;
+	struct key *master_key = NULL;
 	int res;
 
 	if (fscrypt_has_encryption_key(inode))
@@ -318,13 +362,30 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	WARN_ON(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
 	crypt_info->ci_mode = mode;
 
-	res = setup_file_encryption_key(crypt_info);
+	res = setup_file_encryption_key(crypt_info, &master_key);
 	if (res)
 		goto out;
 
-	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL)
+	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) == NULL) {
+		if (master_key) {
+			struct fscrypt_master_key *mk =
+				master_key->payload.data[0];
+
+			refcount_inc(&mk->mk_refcount);
+			crypt_info->ci_master_key = key_get(master_key);
+			spin_lock(&mk->mk_decrypted_inodes_lock);
+			list_add(&crypt_info->ci_master_key_link,
+				 &mk->mk_decrypted_inodes);
+			spin_unlock(&mk->mk_decrypted_inodes_lock);
+		}
 		crypt_info = NULL;
+	}
+	res = 0;
 out:
+	if (master_key) {
+		up_read(&master_key->sem);
+		key_put(master_key);
+	}
 	if (res == -ENOKEY)
 		res = 0;
 	put_crypt_info(crypt_info);
@@ -359,3 +420,39 @@ void fscrypt_free_inode(struct inode *inode)
 	}
 }
 EXPORT_SYMBOL(fscrypt_free_inode);
+
+/**
+ * fscrypt_drop_inode - check whether the inode's master key has been removed
+ *
+ * Filesystems supporting fscrypt must call this from their ->drop_inode()
+ * method so that encrypted inodes are evicted as soon as they're no longer in
+ * use and their master key has been removed.
+ *
+ * Return: 1 if fscrypt wants the inode to be evicted now, otherwise 0
+ */
+int fscrypt_drop_inode(struct inode *inode)
+{
+	const struct fscrypt_info *ci = READ_ONCE(inode->i_crypt_info);
+	const struct fscrypt_master_key *mk;
+
+	/*
+	 * If ci is NULL, then the inode doesn't have an encryption key set up
+	 * so it's irrelevant.  If ci_master_key is NULL, then the master key
+	 * was provided via the legacy mechanism of the process-subscribed
+	 * keyrings, so we don't know whether it's been removed or not.
+	 */
+	if (!ci || !ci->ci_master_key)
+		return 0;
+	mk = ci->ci_master_key->payload.data[0];
+
+	/*
+	 * Note: since we aren't holding key->sem, the result here can
+	 * immediately become outdated.  But there's no correctness problem with
+	 * unnecessarily evicting.  Nor is there a correctness problem with not
+	 * evicting while iput() is racing with the key being removed, since
+	 * then the thread removing the key will either evict the inode itself
+	 * or will correctly detect that it wasn't evicted due to the race.
+	 */
+	return !is_master_key_secret_present(&mk->mk_secret);
+}
+EXPORT_SYMBOL(fscrypt_drop_inode);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index d58b6e52b1649..dcbc9636cb8b1 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -129,11 +129,13 @@ extern int fscrypt_inherit_context(struct inode *, struct inode *,
 /* keyring.c */
 extern void fscrypt_sb_free(struct super_block *sb);
 extern int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
+extern int fscrypt_ioctl_remove_key(struct file *filp, const void __user *arg);
 
 /* keysetup.c */
 extern int fscrypt_get_encryption_info(struct inode *);
 extern void fscrypt_put_encryption_info(struct inode *);
 extern void fscrypt_free_inode(struct inode *);
+extern int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
 extern int fscrypt_setup_filename(struct inode *, const struct qstr *,
@@ -351,6 +353,12 @@ static inline int fscrypt_ioctl_add_key(struct file *filp, void __user *arg)
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_ioctl_remove_key(struct file *filp,
+					   const void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
 /* keysetup.c */
 static inline int fscrypt_get_encryption_info(struct inode *inode)
 {
@@ -366,6 +374,11 @@ static inline void fscrypt_free_inode(struct inode *inode)
 {
 }
 
+static inline int fscrypt_drop_inode(struct inode *inode)
+{
+	return 0;
+}
+
  /* fname.c */
 static inline int fscrypt_setup_filename(struct inode *dir,
 					 const struct qstr *iname,
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 7bed24632bda7..3302a407131e6 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -65,10 +65,17 @@ struct fscrypt_add_key_arg {
 	__u8 raw[];
 };
 
+/* Struct passed to FS_IOC_REMOVE_ENCRYPTION_KEY */
+struct fscrypt_remove_key_arg {
+	struct fscrypt_key_specifier key_spec;
+	__u32 __reserved[6];
+};
+
 #define FS_IOC_SET_ENCRYPTION_POLICY	  _IOR('f', 19, struct fscrypt_policy)
 #define FS_IOC_GET_ENCRYPTION_PWSALT	  _IOW('f', 20, __u8[16])
 #define FS_IOC_GET_ENCRYPTION_POLICY	  _IOW('f', 21, struct fscrypt_policy)
 #define FS_IOC_ADD_ENCRYPTION_KEY	 _IOWR('f', 23, struct fscrypt_add_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY	  _IOW('f', 24, struct fscrypt_remove_key_arg)
 
 /**********************************************************************/
 
-- 
2.21.0.1020.gf2820cf01a-goog

