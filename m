Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE4621CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKHTIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 14:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKHTI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:08:29 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577632BED
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 11:08:24 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:08:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667934503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jrNcnmSHRaepNQk4f9Hus1lcUkbwxzoF5pZ+GTkFig=;
        b=QHja3sHH6wyadoknUmiOrn0F5j02iPSzQaFVnqDRVxlDJF1DWERT0tSpu6Tm3xfl1S7yvs
        lCBdQ4J3/cBhwKHJ4Dd5BAsbSMOFduwPxkzDXPa8f7cJvnLIptpFDQx91zq7QXD7rpUXM9
        ZYj7HWuFE162Ot9OqzqO8kpBel26jJM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        Vasily Averin <vvs@openvz.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Forshee <sforshee@kernel.org>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] xattr: use rbtree for simple_xattrs
Message-ID: <Y2qpIkwWUDOnWugn@P9FQF9L96D.lan>
References: <20221108114112.1579299-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108114112.1579299-1-brauner@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
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

Hi Christian!

This looks fancy, maybe even too fancy :)
I learned from reading your code.

Is there any specific usecase when we care that much about xattr
performance?

I've nothing against the lockless approach, but an rb-tree protected
by a rwlock/semaphore would be probably much simpler and still a great
improvement over the status quo.

Some small nits below.

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

Better to use REFCOUNT_INIT() here to save an atomic operation.

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
> +		rbp = rcu_dereference(xattrs->rb_root.rb_node);
> +		while (rbp) {
> +			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +			if (strcmp(xattr->name, name) < 0) {
> +				rbp = rcu_dereference(rbp->rb_left);
> +			} else if (strcmp(xattr->name, name) > 0) {
> +				rbp = rcu_dereference(rbp->rb_right);

strcmp() is potentially called twice with same arguments.

> +			} else {
> +				if (!likely(refcount_inc_not_zero(&xattr->ref)))
> +					xattr = NULL;
> +				break;
> +			}
> +			xattr = NULL;
>  		}
> -		break;

If there are many xattrs attached and there is a writer who constantly
changes something, won't readers loop here for a potentially very long time?

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

No reason to call strcmp() twice.

Thanks!
