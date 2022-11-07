Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939F861F475
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiKGNgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 08:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiKGNgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:36:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2A140F0
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 05:36:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B679261068
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 13:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B938BC433C1;
        Mon,  7 Nov 2022 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667828168;
        bh=r8aRyGC1GY4H2AOyA2zj23how4sVzXF28bu45bRI4aw=;
        h=From:To:Cc:Subject:Date:From;
        b=Lu0Pe47jAj44/gPxHWwKHiuMpAp6G0cdwWVKC9iaWE6zk6bexczdvbmViyWYvht4O
         ENiadkELCgiB2+4o7L6xRwklnzJGhwwCvlqYyN3qhZHQcXeZEjDEQZSvS3jF6DVdMw
         xw5ep+dY5M0vMionKMS+9uXCu/ldZ8cEqHVJT4DZ3OMiyxV01CzX7yra476HiyaU85
         FzggqBNio1Oc2A3XyXC8YKO329uvtQN8q+nZTD0mvBFoNIj+cH6YGFEk2fSDPt4V44
         LciJClvievhInffxJOsM4jC677tpKfzLRGkiYXJxnzZjOuNk6B8h6WuRVb+sJ1R7TE
         YxMUejAHJOUvw==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Vasily Averin <vvs@openvz.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Forshee <sforshee@kernel.org>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] xattr: use rbtree for simple_xattrs
Date:   Mon,  7 Nov 2022 14:35:40 +0100
Message-Id: <20221107133540.1503822-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19117; i=brauner@kernel.org; h=from:subject; bh=r8aRyGC1GY4H2AOyA2zj23how4sVzXF28bu45bRI4aw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRncq5QlAl3qhOJXGL0TOjmOz+J//975pYqdNg/D97DU12Y Mrepo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCImJgz/DLP0X7RJ+iWXzg5+Yno91H mmUvR6qX1CARfsPsccXrjfneG/a6nghPcFM4IEdim+YkiN0Fx4qf2yD5PQop6dXvMyY+YyAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A while ago Vasily reported that it is possible to set a large number of
xattrs on inodes of filesystems that make use of the simple xattr
infrastructure. This includes all kernfs-based filesystems that support
xattrs (e.g., cgroupfs) and tmpfs. Both cgroupfs and tmpfs can be
mounted by unprivileged users in unprivileged containers and root in an
unprivileged container can set an unrestricted number of security.*
xattrs and privileged users can also set unlimited trusted.* xattrs. As
there are apparently users that have a fairly large number of xattrs we
should scale a bit better. Other xattrs such as user.* are restricted
for kernfs-based instances to a fairly limited number.

Using a simple linked list protected by a spinlock used for set, get,
and list operations doesn't scale well if users use a lot of xattrs even
if it's not a crazy number. And There's no need to bring in the big guns
like rhashtables or rw semaphors for this. An rbtree with a seqlock and
limited rcu semantics is enough.

It scales within the constraints we are working in. By far the most
common operations is getting an xattr. The get operation is optimized to
be lock free as long as there are no writers. The list operation takes
the read lock and protects against concurrent writers while allowing
lockless get operations. Locking out other listxattr callers isn't a
huge deal since listing xattrs is mostly relevant when copying a file or
copying all xattrs between files.

Additionally, listxattr() doesn't list the values of xattrs it can only
be used to list the names of all xattrs set on a file. And the number of
xattr names that can be listed with listxattr() is limited to
XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is passed then
vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr names are
found it will return -EFBIG. In short, the maximum amount of memory that
can be retrieved via listxattr() is limited.

Of course, the API is broken as documented on xattr(7) already. In the
future we might want to address this but for now this is the world we
live in and have lived for a long time. But it does indeed mean that
once an application goes over XATTR_LIST_MAX limit of xattrs set on an
inode it isn't possible to copy the file and include its xattrs in the
copy unless the caller knows all xattrs or limits the copy of the xattrs
to important ones it knows by name (At least for tmpfs, and kernfs-based
filesystems. Other filesystems might provide ways of achieving this.).

Also add proper kernel documentation to all the functions.
A big thanks to Paul for his comments.

Cc: Vasily Averin <vvs@openvz.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    In addition to this patch I would like to propose that we restrict the number
    of xattrs for the simple xattr infrastructure via XATTR_MAX_LIST bytes. In
    other words, we restrict the number of xattrs for simple xattr filesystems to
    the number of xattrs names that can be retrieved via listxattr(). That should
    be about 2000 to 3000 xattrs per inode which is more than enough. We should
    risk this and see if we get any regression reports from userswith this
    approach.
    
    This should be as simple as adding a max_list member to struct simple_xattrs
    and initialize it with XATTR_MAX_LIST. Set operations would then check against
    this field whether the new xattr they are trying to set will fit and return
    -EFBIG otherwise. I think that might be a good approach to get rid of the in
    principle unbounded number of xattrs that can be set via the simple xattr
    infrastructure. I think this is a regression risk worth taking.

 fs/xattr.c            | 331 +++++++++++++++++++++++++++++++++---------
 include/linux/xattr.h |  42 ++----
 mm/shmem.c            |   2 +-
 3 files changed, 273 insertions(+), 102 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..be7c3829a544 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -992,8 +992,65 @@ const char *xattr_full_name(const struct xattr_handler *handler,
 }
 EXPORT_SYMBOL(xattr_full_name);
 
-/*
- * Allocate new xattr and copy in the value; but leave the name to callers.
+/**
+ * free_simple_xattr - free an xattr object
+ * @xattr: the xattr object
+ *
+ * Free the xattr object. Can handle @xattr being NULL.
+ */
+static inline void free_simple_xattr(struct simple_xattr *xattr)
+{
+	if (xattr)
+		kfree(xattr->name);
+	kvfree(xattr);
+}
+
+/**
+ * free_simple_xattr_rcu_cb - callback for freeing xattr object through rcu
+ * @cb: the rcu callback head
+ */
+static void free_simple_xattr_rcu_cb(struct callback_head *cb_head)
+{
+	struct simple_xattr *xattr =
+		container_of(cb_head, struct simple_xattr, rcu);
+	free_simple_xattr(xattr);
+}
+
+/**
+ * free_simple_xattr_rcu - free an xattr object with rcu semantics
+ * @xattr: the xattr object
+ */
+static void free_simple_xattr_rcu(struct simple_xattr *xattr)
+{
+	call_rcu(&xattr->rcu, free_simple_xattr_rcu_cb);
+}
+
+/**
+ * put_simple_xattr_rcu - decrement refcount for xattr object
+ * @xattr: the xattr object
+ *
+ * Decrement the reference count of an xattr object and free it using rcu
+ * semantics if we're the holder of the last reference. Can handle @xattr being
+ * NULL.
+ */
+static inline void put_simple_xattr_rcu(struct simple_xattr *xattr)
+{
+	if (xattr && refcount_dec_and_test(&xattr->ref))
+		free_simple_xattr_rcu(xattr);
+}
+
+/**
+ * simple_xattr_alloc - allocate new xattr object
+ * @value: value of the xattr object
+ * @size: size of @value
+ *
+ * Allocate a new xattr object and initialize respective members. The caller is
+ * responsible for handling the name of the xattr.
+ *
+ * The initial reference count belongs to the rbtree.
+ *
+ * Return: On success a new xattr object is returned. On failure NULL is
+ * returned.
  */
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 {
@@ -1011,57 +1068,99 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 
 	new_xattr->size = size;
 	memcpy(new_xattr->value, value, size);
+	refcount_set(&new_xattr->ref, 1);
 	return new_xattr;
 }
 
-/*
- * xattr GET operation for in-memory/pseudo filesystems
+/**
+ * simple_xattr_get - get an xattr object
+ * @xattrs: the header of the xattr object
+ * @name: the name of the xattr to retrieve
+ * @buffer: the buffer to store the value into
+ * @size: the size of @buffer
+ *
+ * Try to find and retrieve the xattr object associated with @name. If the
+ * object is found and still in the rbtree bump the reference count.
+ *
+ * If @buffer is provided store the value of @xattr in @buffer.
+ *
+ * Return: On success zero and on error a negative error code is returned.
  */
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size)
 {
-	struct simple_xattr *xattr;
-	int ret = -ENODATA;
-
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
-		if (strcmp(name, xattr->name))
-			continue;
-
-		ret = xattr->size;
-		if (buffer) {
-			if (size < xattr->size)
-				ret = -ERANGE;
-			else
-				memcpy(buffer, xattr->value, xattr->size);
+	struct simple_xattr *xattr = NULL;
+	struct rb_node *rbp;
+	int ret, seq = 0;
+
+	rcu_read_lock();
+	do {
+		read_seqbegin_or_lock(&xattrs->lock, &seq);
+		rbp = rcu_dereference(xattrs->rb_root.rb_node);
+		while (rbp) {
+			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+			if (strcmp(xattr->name, name) < 0) {
+				rbp = rcu_dereference(rbp->rb_left);
+			} else if (strcmp(xattr->name, name) > 0) {
+				rbp = rcu_dereference(rbp->rb_right);
+			} else {
+				if (!likely(refcount_inc_not_zero(&xattr->ref)))
+					xattr = NULL;
+				break;
+			}
+			xattr = NULL;
 		}
-		break;
+	} while (need_seqretry(&xattrs->lock, seq));
+	done_seqretry(&xattrs->lock, seq);
+	rcu_read_unlock();
+
+	if (!xattr)
+		return -ENODATA;
+
+	ret = xattr->size;
+	if (buffer) {
+		if (size < xattr->size)
+			ret = -ERANGE;
+		else
+			memcpy(buffer, xattr->value, xattr->size);
 	}
-	spin_unlock(&xattrs->lock);
+
+	put_simple_xattr_rcu(xattr);
 	return ret;
 }
 
 /**
- * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
- * @xattrs: target simple_xattr list
- * @name: name of the extended attribute
- * @value: value of the xattr. If %NULL, will remove the attribute.
- * @size: size of the new xattr
- * @flags: %XATTR_{CREATE|REPLACE}
- * @removed_size: returns size of the removed xattr, -1 if none removed
+ * simple_xattr_set - set an xattr object
+ * @xattrs: the header of the xattr object
+ * @name: the name of the xattr to retrieve
+ * @value: the value to store along the xattr
+ * @size: the size of @value
+ * @flags: the flags determining how to set the xattr
+ * @removed_size: the size of the removed xattr
+ *
+ * Set a new xattr object.
+ * If @value is passed a new xattr object will be allocated. If XATTR_REPLACE
+ * is specified in @flags a matching xattr object for @name must already exist.
+ * If it does it will be replace with the new xattr object. If it doesn't we
+ * fail. If XATTR_CREATE is specified and a matching xattr does already exist
+ * we fail. If it doesn't we create a new xattr. If @flags is zero we simply
+ * insert the new xattr replacing any existing one.
  *
- * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise fails
- * with -EEXIST.  If %XATTR_REPLACE is set, the xattr should exist;
- * otherwise, fails with -ENODATA.
+ * If @value is empty and a matching xattr object is found we delete it if
+ * XATTR_REPLACE is specified in @flags or @flags is zero.
  *
- * Returns 0 on success, -errno on failure.
+ * If @value is empty and no matching xattr object for @name is found we do
+ * nothing if XATTR_CREATE is specified in @flags or @flags is zero. For
+ * XATTR_REPLACE we fail as mentioned above.
+ *
+ * Return: On success zero and on error a negative error code is returned.
  */
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		     const void *value, size_t size, int flags,
 		     ssize_t *removed_size)
 {
-	struct simple_xattr *xattr;
-	struct simple_xattr *new_xattr = NULL;
+	struct simple_xattr *xattr = NULL, *new_xattr = NULL;
+	struct rb_node *parent = NULL, **rbp;
 	int err = 0;
 
 	if (removed_size)
@@ -1080,37 +1179,64 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		}
 	}
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
-		if (!strcmp(name, xattr->name)) {
-			if (flags & XATTR_CREATE) {
-				xattr = new_xattr;
-				err = -EEXIST;
-			} else if (new_xattr) {
-				list_replace(&xattr->list, &new_xattr->list);
-				if (removed_size)
-					*removed_size = xattr->size;
-			} else {
-				list_del(&xattr->list);
-				if (removed_size)
-					*removed_size = xattr->size;
-			}
-			goto out;
-		}
-	}
-	if (flags & XATTR_REPLACE) {
-		xattr = new_xattr;
-		err = -ENODATA;
-	} else {
-		list_add(&new_xattr->list, &xattrs->head);
+	write_seqlock(&xattrs->lock);
+	rbp = &xattrs->rb_root.rb_node;
+	while (*rbp) {
+		parent = *rbp;
+		xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
+		if (strcmp(xattr->name, name) < 0)
+			rbp = &(*rbp)->rb_left;
+		else if (strcmp(xattr->name, name) > 0)
+			rbp = &(*rbp)->rb_right;
+		else
+			break;
 		xattr = NULL;
 	}
-out:
-	spin_unlock(&xattrs->lock);
+
 	if (xattr) {
-		kfree(xattr->name);
-		kvfree(xattr);
+		/* Fail if XATTR_CREATE is requested and the xattr exists. */
+		if (flags & XATTR_CREATE) {
+			err = -EEXIST;
+			goto out_unlock;
+		}
+
+		if (new_xattr)
+			rb_replace_node_rcu(&xattr->rb_node,
+					    &new_xattr->rb_node,
+					    &xattrs->rb_root);
+		else
+			rb_erase(&xattr->rb_node, &xattrs->rb_root);
+		if (!err && removed_size)
+			*removed_size = xattr->size;
+	} else {
+		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
+		if (flags & XATTR_REPLACE) {
+			err = -ENODATA;
+			goto out_unlock;
+		}
+
+		/*
+		 * If XATTR_CREATE or no flags are specified together with a
+		 * new value simply insert it.
+		 */
+		if (new_xattr) {
+			rb_link_node_rcu(&new_xattr->rb_node, parent, rbp);
+			rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
+		}
+
+		/*
+		 * If XATTR_CREATE or no flags are specified and neither an old
+		 * or new xattr were found/exist then we don't need to do
+		 * anything.
+		 */
 	}
+
+out_unlock:
+	write_sequnlock(&xattrs->lock);
+	if (err)
+		free_simple_xattr(new_xattr);
+	else
+		put_simple_xattr_rcu(xattr);
 	return err;
 
 }
@@ -1134,14 +1260,30 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
 	return 0;
 }
 
-/*
- * xattr LIST operation for in-memory/pseudo filesystems
+/**
+ * simple_xattr_list - list all xattr objects
+ * @inode: inode from which to get the xattrs
+ * @xattrs: the header of the xattr object
+ * @buffer: the buffer to store all xattrs into
+ * @size: the size of @buffer
+ *
+ * List all xattrs associated with @inode. If @buffer is NULL we returned the
+ * required size of the buffer. If @buffer is provided we store the xattrs
+ * value into it provided it is big enough.
+ *
+ * This is lockles and we don't bump the reference count. So if callers race
+ * with deletion they may see xattrs about to be removed. This is a race
+ * userspace has to handle since forever anyway.
+ *
+ * Return: On success the required size or the size of the copied xattrs is
+ * returned. On error a negative error code is returned.
  */
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size)
 {
 	bool trusted = capable(CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
+	struct rb_node *rbp;
 	ssize_t remaining_size = size;
 	int err = 0;
 
@@ -1162,8 +1304,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	}
 #endif
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	read_seqlock_excl(&xattrs->lock);
+	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
+		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+
 		/* skip "trusted." attributes for unprivileged callers */
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
@@ -1172,18 +1316,61 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (err)
 			break;
 	}
-	spin_unlock(&xattrs->lock);
+	read_sequnlock_excl(&xattrs->lock);
 
 	return err ? err : size - remaining_size;
 }
 
-/*
- * Adds an extended attribute to the list
+/**
+ * simple_xattr_add - add xattr objects
+ * @xattrs: the header of the xattr object
+ * @new_xattr: the xattr object to add
+ *
+ * Add an xattr object to @xattrs. This assumes no replacement or removal of
+ * matching xattrs is wanted.
  */
-void simple_xattr_list_add(struct simple_xattrs *xattrs,
-			   struct simple_xattr *new_xattr)
+void simple_xattr_add(struct simple_xattrs *xattrs,
+		      struct simple_xattr *new_xattr)
 {
-	spin_lock(&xattrs->lock);
-	list_add(&new_xattr->list, &xattrs->head);
-	spin_unlock(&xattrs->lock);
+	write_seqlock(&xattrs->lock);
+	rb_link_node_rcu(&new_xattr->rb_node, xattrs->rb_root.rb_node,
+			 &xattrs->rb_root.rb_node);
+	rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
+	write_sequnlock(&xattrs->lock);
+}
+
+/**
+ * simple_xattr_init - initialize new xattr header
+ * @xattrs: header to initialize
+ *
+ * Initialize relevant fields of a an xattr header.
+ */
+void simple_xattrs_init(struct simple_xattrs *xattrs)
+{
+	seqlock_init(&xattrs->lock);
+	xattrs->rb_root = RB_ROOT;
+}
+
+/**
+ * simple_xattrs_free - free xattrs
+ * @xattrs: xattr header whose xattrs to destroy
+ *
+ * Destroy all xattrs in @xattr. When this is called no one can hold a
+ * reference to any of the xattrs anymore.
+ */
+void simple_xattrs_free(struct simple_xattrs *xattrs)
+{
+	struct rb_node *rbp;
+
+	rbp = rb_first(&xattrs->rb_root);
+	while (rbp) {
+		struct simple_xattr *xattr;
+		struct rb_node *rbp_next;
+
+		rbp_next = rb_next(rbp);
+		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
+		rb_erase(&xattr->rb_node, &xattrs->rb_root);
+		free_simple_xattr(xattr);
+		rbp = rbp_next;
+	}
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 4c379d23ec6e..9dc4a8c65a16 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -80,48 +80,32 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
 }
 
 struct simple_xattrs {
-	struct list_head head;
-	spinlock_t lock;
+	struct rb_root rb_root;
+	seqlock_t lock;
 };
 
 struct simple_xattr {
-	struct list_head list;
+	union {
+		struct rb_node rb_node;
+		struct rcu_head rcu;
+	};
+	refcount_t ref;
 	char *name;
 	size_t size;
 	char value[];
 };
 
-/*
- * initialize the simple_xattrs structure
- */
-static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
-{
-	INIT_LIST_HEAD(&xattrs->head);
-	spin_lock_init(&xattrs->lock);
-}
-
-/*
- * free all the xattrs
- */
-static inline void simple_xattrs_free(struct simple_xattrs *xattrs)
-{
-	struct simple_xattr *xattr, *node;
-
-	list_for_each_entry_safe(xattr, node, &xattrs->head, list) {
-		kfree(xattr->name);
-		kvfree(xattr);
-	}
-}
-
+void simple_xattrs_init(struct simple_xattrs *xattrs);
+void simple_xattrs_free(struct simple_xattrs *xattrs);
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size);
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		     const void *value, size_t size, int flags,
 		     ssize_t *removed_size);
-ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs, char *buffer,
-			  size_t size);
-void simple_xattr_list_add(struct simple_xattrs *xattrs,
-			   struct simple_xattr *new_xattr);
+ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
+			  char *buffer, size_t size);
+void simple_xattr_add(struct simple_xattrs *xattrs,
+		      struct simple_xattr *new_xattr);
 
 #endif	/* _LINUX_XATTR_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index 8280a5cb48df..2872e6607b2c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3255,7 +3255,7 @@ static int shmem_initxattrs(struct inode *inode,
 		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
 		       xattr->name, len);
 
-		simple_xattr_list_add(&info->xattrs, new_xattr);
+		simple_xattr_add(&info->xattrs, new_xattr);
 	}
 
 	return 0;

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.34.1

