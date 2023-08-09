Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693487751F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHIEeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIEeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:34:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151A198D
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 21:33:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ccc462deca6so6855074276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691555639; x=1692160439;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKmWNaTQHWbW/f06pFcnEOfwhbTzT9a9ji8bFsf1bck=;
        b=tisuCV0B7ipG83St9qBA5XGO5RJ5cDSm15eriMOM13gYSGm+trwDTq6Et7srBx5Qac
         W9gkD1UY2kBQrTJHTbPQoS8Oz1veJFvqonVrcltvyBatz2qmfN6jjSZmkBG8sdEZN2D8
         hj0c1iSVkxaWskybtQEQipRS8+Tu3cgS5PX8gBTHNyTnmUkfnE15RzvSxwVkGYYupjJQ
         YHopNDtlvGjLLk4UFZJ34DfM1rbLyMGwrZN1vIld2YeF4m+eq3xTz6PhTZB6XxqQZvQO
         EIrZBGQYP0oTCkxcI4TeilpLP9YGlBTEhJcxWzm0Oj1FM3iXxVHDHp9Jq2GzcVVzeOGl
         2nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555639; x=1692160439;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKmWNaTQHWbW/f06pFcnEOfwhbTzT9a9ji8bFsf1bck=;
        b=abi7N+66tAKQwlo9wnWuEW6Lg60tx75plhFRX9myfxEHV/+Rs7nXhYpQsghEtPH9D7
         yq/KAp5uzy/DdknirtQMZJg9FFS7Uivmz677pi1plKiNBSpxhpOU4jElX4D/CTAxxlUU
         NILjN7m6a18lqUSJmfRn3VVqBJl0xVuYteQ5utkFbtr000qs9HoBBy20A3RxK1Svp2XO
         ClaKcyXSs9jH9SJJwE68FMjYhGIWYMDD+qXNkp4PXKtw68UTo99HZM+PSJC7udZxrkhb
         6+8F8JXBUxQHOukwgIoFqwkztrEjf6K9USNbcd97eD3Eih16/v7/rVqKD/w+ZSD/O+e5
         Xh/w==
X-Gm-Message-State: AOJu0Ywm9bQEoyhPlaKElMdCDETNlCc508sK4OjQEaxMIYz00+DZ396U
        bzigSYypzPPvZBacuxAERFgWDA==
X-Google-Smtp-Source: AGHT+IHfObTLHvN18MX9PxQb0aEQKcQX/w+V4oLEKKEHeUObobIaXthO2HgX/Yf7Qiyo4bn7+JcVQw==
X-Received: by 2002:a05:6902:20a:b0:d07:1bdb:7780 with SMTP id j10-20020a056902020a00b00d071bdb7780mr1815999ybs.60.1691555638942;
        Tue, 08 Aug 2023 21:33:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c2-20020a258802000000b00d0c698ed6b6sm3079740ybl.41.2023.08.08.21.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 21:33:58 -0700 (PDT)
Date:   Tue, 8 Aug 2023 21:33:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs 3/5] tmpfs,xattr: enable limited user extended
 attributes
In-Reply-To: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
Message-ID: <2e63b26e-df46-5baa-c7d6-f9a8dd3282c5@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable "user." extended attributes on tmpfs, limiting them by tracking
the space they occupy, and deducting that space from the limited ispace
(unless tmpfs mounted with nr_inodes=0 to leave that ispace unlimited).

tmpfs inodes and simple xattrs are both unswappable, and have to be in
lowmem on a 32-bit highmem kernel: so the ispace limit is appropriate
for xattrs, without any need for a further mount option.

Add simple_xattr_space() to give approximate but deterministic estimate
of the space taken up by each xattr: with simple_xattrs_free() outputting
the space freed if required (but kernfs and even some tmpfs usages do not
require that, so don't waste time on strlen'ing if not needed).

Security and trusted xattrs were already supported: for consistency and
simplicity, account them from the same pool; though there's a small risk
that a tmpfs with enough space before would now be considered too small.

When extended attributes are used, "df -i" does show more IUsed and less
IFree than can be explained by the inodes: document that (manpage later).

xfstests tests/generic which were not run on tmpfs before but now pass:
020 037 062 070 077 097 103 117 337 377 454 486 523 533 611 618 728
with no new failures.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 Documentation/filesystems/tmpfs.rst |  7 ++-
 fs/Kconfig                          |  4 +-
 fs/kernfs/dir.c                     |  2 +-
 fs/xattr.c                          | 28 ++++++++++-
 include/linux/xattr.h               |  3 +-
 mm/shmem.c                          | 78 +++++++++++++++++++++++++++----
 6 files changed, 106 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 67422ee10e03..56a26c843dbe 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -21,8 +21,8 @@ explained further below, some of which can be reconfigured dynamically on the
 fly using a remount ('mount -o remount ...') of the filesystem. A tmpfs
 filesystem can be resized but it cannot be resized to a size below its current
 usage. tmpfs also supports POSIX ACLs, and extended attributes for the
-trusted.* and security.* namespaces. ramfs does not use swap and you cannot
-modify any parameter for a ramfs filesystem. The size limit of a ramfs
+trusted.*, security.* and user.* namespaces. ramfs does not use swap and you
+cannot modify any parameter for a ramfs filesystem. The size limit of a ramfs
 filesystem is how much memory you have available, and so care must be taken if
 used so to not run out of memory.
 
@@ -97,6 +97,9 @@ mount with such options, since it allows any user with write access to
 use up all the memory on the machine; but enhances the scalability of
 that instance in a system with many CPUs making intensive use of it.
 
+If nr_inodes is not 0, that limited space for inodes is also used up by
+extended attributes: "df -i"'s IUsed and IUse% increase, IFree decreases.
+
 tmpfs blocks may be swapped out, when there is a shortage of memory.
 tmpfs has a mount option to disable its use of swap:
 
diff --git a/fs/Kconfig b/fs/Kconfig
index 8218a71933f9..7da21f563192 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -205,8 +205,8 @@ config TMPFS_XATTR
 	  Extended attributes are name:value pairs associated with inodes by
 	  the kernel or by users (see the attr(5) manual page for details).
 
-	  Currently this enables support for the trusted.* and
-	  security.* namespaces.
+	  This enables support for the trusted.*, security.* and user.*
+	  namespaces.
 
 	  You need this for POSIX ACL support on tmpfs.
 
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5a1a4af9d3d2..660995856a04 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -556,7 +556,7 @@ void kernfs_put(struct kernfs_node *kn)
 	kfree_const(kn->name);
 
 	if (kn->iattr) {
-		simple_xattrs_free(&kn->iattr->xattrs);
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
 	spin_lock(&kernfs_idr_lock);
diff --git a/fs/xattr.c b/fs/xattr.c
index ba37a8f5cfd1..2d607542281b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1039,6 +1039,26 @@ const char *xattr_full_name(const struct xattr_handler *handler,
 }
 EXPORT_SYMBOL(xattr_full_name);
 
+/**
+ * simple_xattr_space - estimate the memory used by a simple xattr
+ * @name: the full name of the xattr
+ * @size: the size of its value
+ *
+ * This takes no account of how much larger the two slab objects actually are:
+ * that would depend on the slab implementation, when what is required is a
+ * deterministic number, which grows with name length and size and quantity.
+ *
+ * Return: The approximate number of bytes of memory used by such an xattr.
+ */
+size_t simple_xattr_space(const char *name, size_t size)
+{
+	/*
+	 * Use "40" instead of sizeof(struct simple_xattr), to return the
+	 * same result on 32-bit and 64-bit, and even if simple_xattr grows.
+	 */
+	return 40 + size + strlen(name);
+}
+
 /**
  * simple_xattr_free - free an xattr object
  * @xattr: the xattr object
@@ -1363,14 +1383,17 @@ void simple_xattrs_init(struct simple_xattrs *xattrs)
 /**
  * simple_xattrs_free - free xattrs
  * @xattrs: xattr header whose xattrs to destroy
+ * @freed_space: approximate number of bytes of memory freed from @xattrs
  *
  * Destroy all xattrs in @xattr. When this is called no one can hold a
  * reference to any of the xattrs anymore.
  */
-void simple_xattrs_free(struct simple_xattrs *xattrs)
+void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space)
 {
 	struct rb_node *rbp;
 
+	if (freed_space)
+		*freed_space = 0;
 	rbp = rb_first(&xattrs->rb_root);
 	while (rbp) {
 		struct simple_xattr *xattr;
@@ -1379,6 +1402,9 @@ void simple_xattrs_free(struct simple_xattrs *xattrs)
 		rbp_next = rb_next(rbp);
 		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
 		rb_erase(&xattr->rb_node, &xattrs->rb_root);
+		if (freed_space)
+			*freed_space += simple_xattr_space(xattr->name,
+							   xattr->size);
 		simple_xattr_free(xattr);
 		rbp = rbp_next;
 	}
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index e37fe667ae04..d20051865800 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -114,7 +114,8 @@ struct simple_xattr {
 };
 
 void simple_xattrs_init(struct simple_xattrs *xattrs);
-void simple_xattrs_free(struct simple_xattrs *xattrs);
+void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space);
+size_t simple_xattr_space(const char *name, size_t size);
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 void simple_xattr_free(struct simple_xattr *xattr);
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
diff --git a/mm/shmem.c b/mm/shmem.c
index c39471384168..7420b510a9f3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -393,12 +393,12 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 	return 0;
 }
 
-static void shmem_free_inode(struct super_block *sb)
+static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	if (sbinfo->max_inodes) {
 		raw_spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_ispace += BOGO_INODE_SIZE;
+		sbinfo->free_ispace += BOGO_INODE_SIZE + freed_ispace;
 		raw_spin_unlock(&sbinfo->stat_lock);
 	}
 }
@@ -1232,6 +1232,7 @@ static void shmem_evict_inode(struct inode *inode)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	size_t freed;
 
 	if (shmem_mapping(inode->i_mapping)) {
 		shmem_unacct_size(info->flags, inode->i_size);
@@ -1258,9 +1259,9 @@ static void shmem_evict_inode(struct inode *inode)
 		}
 	}
 
-	simple_xattrs_free(&info->xattrs);
+	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
+	shmem_free_inode(inode->i_sb, freed);
 	WARN_ON(inode->i_blocks);
-	shmem_free_inode(inode->i_sb);
 	clear_inode(inode);
 #ifdef CONFIG_TMPFS_QUOTA
 	dquot_free_inode(inode);
@@ -2440,7 +2441,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	inode = new_inode(sb);
 
 	if (!inode) {
-		shmem_free_inode(sb);
+		shmem_free_inode(sb, 0);
 		return ERR_PTR(-ENOSPC);
 	}
 
@@ -3281,7 +3282,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	ret = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
 	if (ret) {
 		if (inode->i_nlink)
-			shmem_free_inode(inode->i_sb);
+			shmem_free_inode(inode->i_sb, 0);
 		goto out;
 	}
 
@@ -3301,7 +3302,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
-		shmem_free_inode(inode->i_sb);
+		shmem_free_inode(inode->i_sb, 0);
 
 	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
 
@@ -3554,21 +3555,40 @@ static int shmem_initxattrs(struct inode *inode,
 			    void *fs_info)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	const struct xattr *xattr;
 	struct simple_xattr *new_xattr;
+	size_t ispace = 0;
 	size_t len;
 
+	if (sbinfo->max_inodes) {
+		for (xattr = xattr_array; xattr->name != NULL; xattr++) {
+			ispace += simple_xattr_space(xattr->name,
+				xattr->value_len + XATTR_SECURITY_PREFIX_LEN);
+		}
+		if (ispace) {
+			raw_spin_lock(&sbinfo->stat_lock);
+			if (sbinfo->free_ispace < ispace)
+				ispace = 0;
+			else
+				sbinfo->free_ispace -= ispace;
+			raw_spin_unlock(&sbinfo->stat_lock);
+			if (!ispace)
+				return -ENOSPC;
+		}
+	}
+
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		new_xattr = simple_xattr_alloc(xattr->value, xattr->value_len);
 		if (!new_xattr)
-			return -ENOMEM;
+			break;
 
 		len = strlen(xattr->name) + 1;
 		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
 					  GFP_KERNEL);
 		if (!new_xattr->name) {
 			kvfree(new_xattr);
-			return -ENOMEM;
+			break;
 		}
 
 		memcpy(new_xattr->name, XATTR_SECURITY_PREFIX,
@@ -3579,6 +3599,16 @@ static int shmem_initxattrs(struct inode *inode,
 		simple_xattr_add(&info->xattrs, new_xattr);
 	}
 
+	if (xattr->name != NULL) {
+		if (ispace) {
+			raw_spin_lock(&sbinfo->stat_lock);
+			sbinfo->free_ispace += ispace;
+			raw_spin_unlock(&sbinfo->stat_lock);
+		}
+		simple_xattrs_free(&info->xattrs, NULL);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -3599,16 +3629,39 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 				   size_t size, int flags)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct simple_xattr *old_xattr;
+	size_t ispace = 0;
 
 	name = xattr_full_name(handler, name);
+	if (value && sbinfo->max_inodes) {
+		ispace = simple_xattr_space(name, size);
+		raw_spin_lock(&sbinfo->stat_lock);
+		if (sbinfo->free_ispace < ispace)
+			ispace = 0;
+		else
+			sbinfo->free_ispace -= ispace;
+		raw_spin_unlock(&sbinfo->stat_lock);
+		if (!ispace)
+			return -ENOSPC;
+	}
+
 	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
 	if (!IS_ERR(old_xattr)) {
+		ispace = 0;
+		if (old_xattr && sbinfo->max_inodes)
+			ispace = simple_xattr_space(old_xattr->name,
+						    old_xattr->size);
 		simple_xattr_free(old_xattr);
 		old_xattr = NULL;
 		inode->i_ctime = current_time(inode);
 		inode_inc_iversion(inode);
 	}
+	if (ispace) {
+		raw_spin_lock(&sbinfo->stat_lock);
+		sbinfo->free_ispace += ispace;
+		raw_spin_unlock(&sbinfo->stat_lock);
+	}
 	return PTR_ERR(old_xattr);
 }
 
@@ -3624,9 +3677,16 @@ static const struct xattr_handler shmem_trusted_xattr_handler = {
 	.set = shmem_xattr_handler_set,
 };
 
+static const struct xattr_handler shmem_user_xattr_handler = {
+	.prefix = XATTR_USER_PREFIX,
+	.get = shmem_xattr_handler_get,
+	.set = shmem_xattr_handler_set,
+};
+
 static const struct xattr_handler *shmem_xattr_handlers[] = {
 	&shmem_security_xattr_handler,
 	&shmem_trusted_xattr_handler,
+	&shmem_user_xattr_handler,
 	NULL
 };
 
-- 
2.35.3

