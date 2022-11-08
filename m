Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC3621C98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 19:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKHS7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 13:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKHS7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26305E9CD
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 10:59:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73BFFB81C16
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 18:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CD0C433C1;
        Tue,  8 Nov 2022 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667933947;
        bh=ISrozv2ivsaDd9bq42vli2S5CAPuEPEkbuijg3ajdLg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X6eysJ1xFi90dv+/ZMSrpQxQ7p1nGl3Kwb4FjF7ay4OuZswgzCi1z/RM/uz8cj5NS
         MSXyEcrOoOCVEO24Ew4eteW9CpTTijSryL5Oy0fMMla05y5rB+/sEmO091IkOwRPe0
         VHd2YkOBQ2MGFj08GxAlTLUvqEtMe9NQomez1zN+4b2BPkvm69LpzkIjnGSasVlNNf
         EMncCpckTWP/671tY8UV5u5hBy3ShTUYuNW/DokjfsLVfd8F7ry7gfk4PZ+SKyoAEB
         p5t72wJH2SIg04vB77xxBMqfCUIK9A7K2+vTmeZVajlTFskSw7ivDp5eXdd9eWAbuu
         9ufayBJXwxgRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 888C25C1E87; Tue,  8 Nov 2022 10:59:04 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:59:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        Vasily Averin <vvs@openvz.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Forshee <sforshee@kernel.org>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] xattr: use rbtree for simple_xattrs
Message-ID: <20221108185904.GE3907045@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221108114112.1579299-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108114112.1579299-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 08, 2022 at 12:41:12PM +0100, Christian Brauner wrote:
> A while ago Vasily reported that it is possible to set a large number of
> xattrs on inodes of filesystems that make use of the simple xattr
> infrastructure. This includes all kernfs-based filesystems that support
> xattrs (e.g., cgroupfs) and tmpfs. Both cgroupfs and tmpfs can be
> mounted by unprivileged users in unprivileged containers and root in an
> unprivileged container can set an unrestricted number of security.*
> xattrs and privileged users can also set unlimited trusted.* xattrs. As
> there are apparently users that have a fairly large number of xattrs we
> should scale a bit better. Other xattrs such as user.* are restricted
> for kernfs-based instances to a fairly limited number.
> 
> Using a simple linked list protected by a spinlock used for set, get,
> and list operations doesn't scale well if users use a lot of xattrs even
> if it's not a crazy number. And There's no need to bring in the big guns
> like rhashtables or rw semaphors for this. An rbtree with a seqlock and
> limited rcu semantics is enough.
> 
> It scales within the constraints we are working in. By far the most
> common operations is getting an xattr. The get operation is optimized to
> be lock free as long as there are no writers. The list operation takes
> the read lock and protects against concurrent writers while allowing
> lockless get operations. Locking out other listxattr callers isn't a
> huge deal since listing xattrs is mostly relevant when copying a file or
> copying all xattrs between files.
> 
> Additionally, listxattr() doesn't list the values of xattrs it can only
> be used to list the names of all xattrs set on a file. And the number of
> xattr names that can be listed with listxattr() is limited to
> XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is passed then
> vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr names are
> found it will return -EFBIG. In short, the maximum amount of memory that
> can be retrieved via listxattr() is limited.
> 
> Of course, the API is broken as documented on xattr(7) already. In the
> future we might want to address this but for now this is the world we
> live in and have lived for a long time. But it does indeed mean that
> once an application goes over XATTR_LIST_MAX limit of xattrs set on an
> inode it isn't possible to copy the file and include its xattrs in the
> copy unless the caller knows all xattrs or limits the copy of the xattrs
> to important ones it knows by name (At least for tmpfs, and kernfs-based
> filesystems. Other filesystems might provide ways of achieving this.).
> 
> Also add proper kernel documentation to all the functions.
> A big thanks to Paul for his comments.
> 
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Looks mostly plausible from an RCU viewpoint, but there are a few
questions/comments inline below.

							Thanx, Paul

> ---
> 
> Notes:
>     In addition to this patch I would like to propose that we restrict the number
>     of xattrs for the simple xattr infrastructure via XATTR_MAX_LIST bytes. In
>     other words, we restrict the number of xattrs for simple xattr filesystems to
>     the number of xattrs names that can be retrieved via listxattr(). That should
>     be about 2000 to 3000 xattrs per inode which is more than enough. We should
>     risk this and see if we get any regression reports from userswith this
>     approach.
>     
>     This should be as simple as adding a max_list member to struct simple_xattrs
>     and initialize it with XATTR_MAX_LIST. Set operations would then check against
>     this field whether the new xattr they are trying to set will fit and return
>     -EFBIG otherwise. I think that might be a good approach to get rid of the in
>     principle unbounded number of xattrs that can be set via the simple xattr
>     infrastructure. I think this is a regression risk worth taking.
>     
>     /* v2 */
>     Christian Brauner <brauner@kernel.org>:
>     - Fix kernel doc.
>     - Remove accidental leftover union from previous iteration.
> 
>  fs/xattr.c            | 330 +++++++++++++++++++++++++++++++++---------
>  include/linux/xattr.h |  40 ++---
>  mm/shmem.c            |   2 +-
>  3 files changed, 270 insertions(+), 102 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 61107b6bbed2..f18454161d54 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -992,8 +992,63 @@ const char *xattr_full_name(const struct xattr_handler *handler,
>  }
>  EXPORT_SYMBOL(xattr_full_name);
>  
> -/*
> - * Allocate new xattr and copy in the value; but leave the name to callers.
> +/**
> + * free_simple_xattr - free an xattr object
> + * @xattr: the xattr object
> + *
> + * Free the xattr object. Can handle @xattr being NULL.
> + */
> +static inline void free_simple_xattr(struct simple_xattr *xattr)
> +{
> +	if (xattr)
> +		kfree(xattr->name);
> +	kvfree(xattr);
> +}
> +
> +/**
> + * free_simple_xattr_rcu_cb - callback for freeing xattr object through rcu
> + * @cb: the rcu callback head
> + */
> +static void free_simple_xattr_rcu_cb(struct callback_head *cb)
> +{
> +	free_simple_xattr(container_of(cb, struct simple_xattr, rcu));
> +}
> +
> +/**
> + * free_simple_xattr_rcu - free an xattr object with rcu semantics
> + * @xattr: the xattr object
> + */
> +static void free_simple_xattr_rcu(struct simple_xattr *xattr)
> +{
> +	call_rcu(&xattr->rcu, free_simple_xattr_rcu_cb);
> +}
> +
> +/**
> + * put_simple_xattr_rcu - decrement refcount for xattr object
> + * @xattr: the xattr object
> + *
> + * Decrement the reference count of an xattr object and free it using rcu
> + * semantics if we're the holder of the last reference. Can handle @xattr being
> + * NULL.
> + */
> +static inline void put_simple_xattr_rcu(struct simple_xattr *xattr)
> +{
> +	if (xattr && refcount_dec_and_test(&xattr->ref))
> +		free_simple_xattr_rcu(xattr);
> +}

Looks like the standard combined reference counter and RCU combination,
goog!

> +
> +/**
> + * simple_xattr_alloc - allocate new xattr object
> + * @value: value of the xattr object
> + * @size: size of @value
> + *
> + * Allocate a new xattr object and initialize respective members. The caller is
> + * responsible for handling the name of the xattr.
> + *
> + * The initial reference count belongs to the rbtree.
> + *
> + * Return: On success a new xattr object is returned. On failure NULL is
> + * returned.
>   */
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  {
> @@ -1011,57 +1066,99 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  
>  	new_xattr->size = size;
>  	memcpy(new_xattr->value, value, size);
> +	refcount_set(&new_xattr->ref, 1);

Yes, one is usually needed for the link in the tree.

>  	return new_xattr;
>  }
>  
> -/*
> - * xattr GET operation for in-memory/pseudo filesystems
> +/**
> + * simple_xattr_get - get an xattr object
> + * @xattrs: the header of the xattr object
> + * @name: the name of the xattr to retrieve
> + * @buffer: the buffer to store the value into
> + * @size: the size of @buffer
> + *
> + * Try to find and retrieve the xattr object associated with @name. If the
> + * object is found and still in the rbtree bump the reference count.
> + *
> + * If @buffer is provided store the value of @xattr in @buffer.
> + *
> + * Return: On success zero and on error a negative error code is returned.
>   */
>  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size)
>  {
> -	struct simple_xattr *xattr;
> -	int ret = -ENODATA;
> -
> -	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> -		if (strcmp(name, xattr->name))
> -			continue;
> -
> -		ret = xattr->size;
> -		if (buffer) {
> -			if (size < xattr->size)
> -				ret = -ERANGE;
> -			else
> -				memcpy(buffer, xattr->value, xattr->size);
> +	struct simple_xattr *xattr = NULL;
> +	struct rb_node *rbp;
> +	int ret, seq = 0;
> +
> +	rcu_read_lock();
> +	do {
> +		read_seqbegin_or_lock(&xattrs->lock, &seq);

It might be necessary to try a few times before grabbing the lock, but
perhaps we should actually hit the problem before increasing complexity.

> +		rbp = rcu_dereference(xattrs->rb_root.rb_node);
> +		while (rbp) {
> +			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +			if (strcmp(xattr->name, name) < 0) {
> +				rbp = rcu_dereference(rbp->rb_left);
> +			} else if (strcmp(xattr->name, name) > 0) {
> +				rbp = rcu_dereference(rbp->rb_right);
> +			} else {
> +				if (!likely(refcount_inc_not_zero(&xattr->ref)))
> +					xattr = NULL;
> +				break;
> +			}
> +			xattr = NULL;
>  		}

Maybe this is too specialized, but should this be in the rbtree code,
perhaps rb_find_first_rcu(), but with an appropriate cmp() function?
The refcount_inc_not_zero() clearly needs to be in the caller.

If this is the only instance of this sort of code, it is likely not
really worthwhile.  But if we have several of these open coded, it would
be good to consolidate that code.

> -		break;
> +	} while (need_seqretry(&xattrs->lock, seq));
> +	done_seqretry(&xattrs->lock, seq);
> +	rcu_read_unlock();
> +
> +	if (!xattr)
> +		return -ENODATA;
> +
> +	ret = xattr->size;
> +	if (buffer) {
> +		if (size < xattr->size)
> +			ret = -ERANGE;
> +		else
> +			memcpy(buffer, xattr->value, xattr->size);

If all we are doing is copying to an in-kernel buffer, why not dispense
with xattr->ref and do the memcpy() under rcu_read_lock() protection?
This would avoid some overhead from reference-count cache misses.

Of course, if that memcpy() can page fault or some such, then what
you have is necessary.  But this is all in-kernel, right?  And if not,
shouldn't the pointers be decorated with __user or some such?

>  	}
> -	spin_unlock(&xattrs->lock);
> +
> +	put_simple_xattr_rcu(xattr);
>  	return ret;
>  }
>  
>  /**
> - * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
> - * @xattrs: target simple_xattr list
> - * @name: name of the extended attribute
> - * @value: value of the xattr. If %NULL, will remove the attribute.
> - * @size: size of the new xattr
> - * @flags: %XATTR_{CREATE|REPLACE}
> - * @removed_size: returns size of the removed xattr, -1 if none removed
> + * simple_xattr_set - set an xattr object
> + * @xattrs: the header of the xattr object
> + * @name: the name of the xattr to retrieve
> + * @value: the value to store along the xattr
> + * @size: the size of @value
> + * @flags: the flags determining how to set the xattr
> + * @removed_size: the size of the removed xattr
> + *
> + * Set a new xattr object.
> + * If @value is passed a new xattr object will be allocated. If XATTR_REPLACE
> + * is specified in @flags a matching xattr object for @name must already exist.
> + * If it does it will be replace with the new xattr object. If it doesn't we
> + * fail. If XATTR_CREATE is specified and a matching xattr does already exist
> + * we fail. If it doesn't we create a new xattr. If @flags is zero we simply
> + * insert the new xattr replacing any existing one.
>   *
> - * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise fails
> - * with -EEXIST.  If %XATTR_REPLACE is set, the xattr should exist;
> - * otherwise, fails with -ENODATA.
> + * If @value is empty and a matching xattr object is found we delete it if
> + * XATTR_REPLACE is specified in @flags or @flags is zero.
>   *
> - * Returns 0 on success, -errno on failure.
> + * If @value is empty and no matching xattr object for @name is found we do
> + * nothing if XATTR_CREATE is specified in @flags or @flags is zero. For
> + * XATTR_REPLACE we fail as mentioned above.
> + *
> + * Return: On success zero and on error a negative error code is returned.
>   */
>  int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		     const void *value, size_t size, int flags,
>  		     ssize_t *removed_size)
>  {
> -	struct simple_xattr *xattr;
> -	struct simple_xattr *new_xattr = NULL;
> +	struct simple_xattr *xattr = NULL, *new_xattr = NULL;
> +	struct rb_node *parent = NULL, **rbp;
>  	int err = 0;
>  
>  	if (removed_size)
> @@ -1080,37 +1177,64 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		}
>  	}
>  
> -	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> -		if (!strcmp(name, xattr->name)) {
> -			if (flags & XATTR_CREATE) {
> -				xattr = new_xattr;
> -				err = -EEXIST;
> -			} else if (new_xattr) {
> -				list_replace(&xattr->list, &new_xattr->list);
> -				if (removed_size)
> -					*removed_size = xattr->size;
> -			} else {
> -				list_del(&xattr->list);
> -				if (removed_size)
> -					*removed_size = xattr->size;
> -			}
> -			goto out;
> -		}
> -	}
> -	if (flags & XATTR_REPLACE) {
> -		xattr = new_xattr;
> -		err = -ENODATA;
> -	} else {
> -		list_add(&new_xattr->list, &xattrs->head);
> +	write_seqlock(&xattrs->lock);
> +	rbp = &xattrs->rb_root.rb_node;
> +	while (*rbp) {
> +		parent = *rbp;
> +		xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
> +		if (strcmp(xattr->name, name) < 0)
> +			rbp = &(*rbp)->rb_left;
> +		else if (strcmp(xattr->name, name) > 0)
> +			rbp = &(*rbp)->rb_right;
> +		else
> +			break;
>  		xattr = NULL;
>  	}
> -out:
> -	spin_unlock(&xattrs->lock);
> +
>  	if (xattr) {
> -		kfree(xattr->name);
> -		kvfree(xattr);
> +		/* Fail if XATTR_CREATE is requested and the xattr exists. */
> +		if (flags & XATTR_CREATE) {
> +			err = -EEXIST;
> +			goto out_unlock;
> +		}
> +
> +		if (new_xattr)
> +			rb_replace_node_rcu(&xattr->rb_node,
> +					    &new_xattr->rb_node,
> +					    &xattrs->rb_root);
> +		else
> +			rb_erase(&xattr->rb_node, &xattrs->rb_root);

Is rb_erase() RCU-reader-safe?  It is not immediately obvious to me that it
is.  I would expect an rcu_assign_pointer() or three in there somewhere.

> +		if (!err && removed_size)
> +			*removed_size = xattr->size;
> +	} else {
> +		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> +		if (flags & XATTR_REPLACE) {
> +			err = -ENODATA;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * If XATTR_CREATE or no flags are specified together with a
> +		 * new value simply insert it.
> +		 */
> +		if (new_xattr) {
> +			rb_link_node_rcu(&new_xattr->rb_node, parent, rbp);
> +			rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
> +		}
> +
> +		/*
> +		 * If XATTR_CREATE or no flags are specified and neither an old
> +		 * or new xattr were found/exist then we don't need to do
> +		 * anything.
> +		 */

As before, some of this looks like it should be in the rbtree implementation.
On the other hand, and add-or-replace function like this might be rare.  And
there are only two other occurrences, both of which look quite specialize.

So probably no consolidation just yet, anyway.

>  	}
> +
> +out_unlock:
> +	write_sequnlock(&xattrs->lock);
> +	if (err)
> +		free_simple_xattr(new_xattr);
> +	else
> +		put_simple_xattr_rcu(xattr);
>  	return err;
>  
>  }
> @@ -1134,14 +1258,31 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
>  	return 0;
>  }
>  
> -/*
> - * xattr LIST operation for in-memory/pseudo filesystems
> +/**
> + * simple_xattr_list - list all xattr objects
> + * @inode: inode from which to get the xattrs
> + * @xattrs: the header of the xattr object
> + * @buffer: the buffer to store all xattrs into
> + * @size: the size of @buffer
> + *
> + * List all xattrs associated with @inode. If @buffer is NULL we returned the
> + * required size of the buffer. If @buffer is provided we store the xattrs
> + * value into it provided it is big enough.
> + *
> + * Note, the number of xattr names that can be listed with listxattr(2) is
> + * limited to XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is passed then
> + * vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr names are found
> + * it will return -E2BIG.
> + *
> + * Return: On success the required size or the size of the copied xattrs is
> + * returned. On error a negative error code is returned.
>   */
>  ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  			  char *buffer, size_t size)
>  {
>  	bool trusted = capable(CAP_SYS_ADMIN);
>  	struct simple_xattr *xattr;
> +	struct rb_node *rbp;
>  	ssize_t remaining_size = size;
>  	int err = 0;
>  
> @@ -1162,8 +1303,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  	}
>  #endif
>  
> -	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> +	read_seqlock_excl(&xattrs->lock);

This excludes writers, which allows the non-RCU-safe code to work correctly.

So this should be OK.

> +	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
> +		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +
>  		/* skip "trusted." attributes for unprivileged callers */
>  		if (!trusted && xattr_is_trusted(xattr->name))
>  			continue;
> @@ -1172,18 +1315,61 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  		if (err)
>  			break;
>  	}
> -	spin_unlock(&xattrs->lock);
> +	read_sequnlock_excl(&xattrs->lock);
>  
>  	return err ? err : size - remaining_size;
>  }
>  
> -/*
> - * Adds an extended attribute to the list
> +/**
> + * simple_xattr_add - add xattr objects
> + * @xattrs: the header of the xattr object
> + * @new_xattr: the xattr object to add
> + *
> + * Add an xattr object to @xattrs. This assumes no replacement or removal of
> + * matching xattrs is wanted.
>   */
> -void simple_xattr_list_add(struct simple_xattrs *xattrs,
> -			   struct simple_xattr *new_xattr)
> +void simple_xattr_add(struct simple_xattrs *xattrs,
> +		      struct simple_xattr *new_xattr)
>  {
> -	spin_lock(&xattrs->lock);
> -	list_add(&new_xattr->list, &xattrs->head);
> -	spin_unlock(&xattrs->lock);
> +	write_seqlock(&xattrs->lock);
> +	rb_link_node_rcu(&new_xattr->rb_node, xattrs->rb_root.rb_node,
> +			 &xattrs->rb_root.rb_node);
> +	rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
> +	write_sequnlock(&xattrs->lock);
> +}

I freely confess that I am not immediately seeing how this one fits in.
Presumably its caller has already found the right place in the tree?
Except that the caller isn't holding xattrs->lock.

> +
> +/**
> + * simple_xattr_init - initialize new xattr header
> + * @xattrs: header to initialize
> + *
> + * Initialize relevant fields of a an xattr header.
> + */
> +void simple_xattrs_init(struct simple_xattrs *xattrs)
> +{
> +	seqlock_init(&xattrs->lock);
> +	xattrs->rb_root = RB_ROOT;
> +}
> +
> +/**
> + * simple_xattrs_free - free xattrs
> + * @xattrs: xattr header whose xattrs to destroy
> + *
> + * Destroy all xattrs in @xattr. When this is called no one can hold a
> + * reference to any of the xattrs anymore.

As in anyone who might hold a reference is long gone, correct?

							Thanx, Paul

> + */
> +void simple_xattrs_free(struct simple_xattrs *xattrs)
> +{
> +	struct rb_node *rbp;
> +
> +	rbp = rb_first(&xattrs->rb_root);
> +	while (rbp) {
> +		struct simple_xattr *xattr;
> +		struct rb_node *rbp_next;
> +
> +		rbp_next = rb_next(rbp);
> +		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +		rb_erase(&xattr->rb_node, &xattrs->rb_root);
> +		free_simple_xattr(xattr);
> +		rbp = rbp_next;
> +	}
>  }
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 4c379d23ec6e..8c01e622ad92 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -80,48 +80,30 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
>  }
>  
>  struct simple_xattrs {
> -	struct list_head head;
> -	spinlock_t lock;
> +	struct rb_root rb_root;
> +	seqlock_t lock;
>  };
>  
>  struct simple_xattr {
> -	struct list_head list;
> +	struct rb_node rb_node;
> +	struct rcu_head rcu;
> +	refcount_t ref;
>  	char *name;
>  	size_t size;
>  	char value[];
>  };
>  
> -/*
> - * initialize the simple_xattrs structure
> - */
> -static inline void simple_xattrs_init(struct simple_xattrs *xattrs)
> -{
> -	INIT_LIST_HEAD(&xattrs->head);
> -	spin_lock_init(&xattrs->lock);
> -}
> -
> -/*
> - * free all the xattrs
> - */
> -static inline void simple_xattrs_free(struct simple_xattrs *xattrs)
> -{
> -	struct simple_xattr *xattr, *node;
> -
> -	list_for_each_entry_safe(xattr, node, &xattrs->head, list) {
> -		kfree(xattr->name);
> -		kvfree(xattr);
> -	}
> -}
> -
> +void simple_xattrs_init(struct simple_xattrs *xattrs);
> +void simple_xattrs_free(struct simple_xattrs *xattrs);
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
>  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size);
>  int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		     const void *value, size_t size, int flags,
>  		     ssize_t *removed_size);
> -ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs, char *buffer,
> -			  size_t size);
> -void simple_xattr_list_add(struct simple_xattrs *xattrs,
> -			   struct simple_xattr *new_xattr);
> +ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
> +			  char *buffer, size_t size);
> +void simple_xattr_add(struct simple_xattrs *xattrs,
> +		      struct simple_xattr *new_xattr);
>  
>  #endif	/* _LINUX_XATTR_H */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8280a5cb48df..2872e6607b2c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3255,7 +3255,7 @@ static int shmem_initxattrs(struct inode *inode,
>  		memcpy(new_xattr->name + XATTR_SECURITY_PREFIX_LEN,
>  		       xattr->name, len);
>  
> -		simple_xattr_list_add(&info->xattrs, new_xattr);
> +		simple_xattr_add(&info->xattrs, new_xattr);
>  	}
>  
>  	return 0;
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> -- 
> 2.34.1
> 
