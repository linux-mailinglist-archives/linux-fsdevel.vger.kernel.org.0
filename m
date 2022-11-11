Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550C6261A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiKKSqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 13:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKSqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:46:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14309B68
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 10:46:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97178B82754
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 18:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182A4C433C1;
        Fri, 11 Nov 2022 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668192392;
        bh=BWoClJuMRTz5F2BYA3GUto9l7BZPhP48Ytn0dkd0pVM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=stJ9lGQx8sYLlOV7ijNj/c7NuVFA7wMfkCT9+/l7kg3/B5oDQHntsEs1v8LdALnz2
         RlRuJISNaoW/cH3IYQCJsEzwObhXMnFoH4kGgoElLOSR3HitdUL+A+zpm9JTB28YfR
         jZkTpF4viQP5ibddSQM1FDQ0MpQ+lI1RLTWOvjpR0E1+ZzlixyT01FcJj01B2j0FVh
         dbYYfg1FsoXKdSKcpMkH8dg+8N+ETSu57P8BwWymbuM1iQIrweLmkebWkXImnxn2yX
         sWRQ7FRVbjP6ovIP9nztx6F6KHJiNeE9RjDl6AXI4IF9l1xEvWUboCiQlVwakVjeeR
         nQkws5keKzY8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF2C55C08D8; Fri, 11 Nov 2022 10:46:30 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:46:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Vasily Averin <vvs@openvz.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Forshee <sforshee@kernel.org>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] xattr: use rbtree for simple_xattrs
Message-ID: <20221111184630.GZ725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221111115336.1845383-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111115336.1845383-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:53:36PM +0100, Christian Brauner wrote:
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
> if it's not a crazy number. There's no need to bring in the big guns
> like rhashtables or rw semaphores for this. An rbtree with a rwlock, or
> limited rcu semanics and seqlock is enough.
> 
> It scales within the constraints we are working in. By far the most
> common operation is getting an xattr. Setting xattrs should be a
> moderately rare operation. And listxattr() often only happens when
> copying xattrs between files or with the filey. Holding a lock across
> listxattr() is unproblematic because it doesn't list the values of
> xattrs. It can only be used to list the names of all xattrs set on a
> file. And the number of xattr names that can be listed with listxattr()
> is limited to XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is
> passed then vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr
> names are found it will return -EFBIG. In short, the maximum amount of
> memory that can be retrieved via listxattr() is limited.
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
> Bonus of this port to rbtree+rwlock is that we shrink the memory
> consumption for users of the simple xattr infrastructure.
> 
> Also add proper kernel documentation to all the functions.
> A big thanks to Paul for his comments.
> 
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> Notes:
>     In the v1 and v2 of this patch we used an rbtree which was protected by an
>     rcu+seqlock combination. During the discussion it became clear that there's
>     some valid concern how safe it is to combine rcu with rbtrees. While most of
>     the issues are highly unlikely to matter in practice the code here can be
>     reached by unprivileged users rather directly so we should not be adventurous.
>     Instead of the rcu+seqlock combination simply use an rwlock. This will scale
>     sufficiently as well and had been one of the implementations I considered and
>     wrote a little while ago. Thanks to Paul for some deeper insights into issues
>     associated with rcu and rbtrees!
>     
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
>     /* v3 */
>     Port the whole thing to use a simple rwlock instead of rcu+seqlock.
>     
>     "Paul E. McKenney" <paulmck@kernel.org>:
>     - Fix simple_xattr_add() by searching the correct slot in the rbtree first.
>     
>     Roman Gushchin <roman.gushchin@linux.dev>:
>     - Avoid calling strcmp() multiple times.
> 
>  fs/xattr.c            | 317 +++++++++++++++++++++++++++++++++---------
>  include/linux/xattr.h |  38 ++---
>  mm/shmem.c            |   2 +-
>  3 files changed, 260 insertions(+), 97 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 61107b6bbed2..402d9d43fde0 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -992,8 +992,29 @@ const char *xattr_full_name(const struct xattr_handler *handler,
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
> + * simple_xattr_alloc - allocate new xattr object
> + * @value: value of the xattr object
> + * @size: size of @value
> + *
> + * Allocate a new xattr object and initialize respective members. The caller is
> + * responsible for handling the name of the xattr.
> + *
> + * Return: On success a new xattr object is returned. On failure NULL is
> + * returned.
>   */
>  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  {
> @@ -1014,20 +1035,69 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	return new_xattr;
>  }
>  
> -/*
> - * xattr GET operation for in-memory/pseudo filesystems
> +/**
> + * rbtree_simple_xattr_cmp - compare xattr name with current rbtree xattr entry
> + * @key: xattr name
> + * @node: current node
> + *
> + * Compare the xattr name with the xattr name attached to @node in the rbtree.
> + *
> + * Return: Negative value if continuing left, positive if continuing right, 0
> + * if the xattr attached to @node matches @key.
> + */
> +static int rbtree_simple_xattr_cmp(const void *key, const struct rb_node *node)
> +{
> +	const char *xattr_name = key;
> +	const struct simple_xattr *xattr;
> +
> +	xattr = rb_entry(node, struct simple_xattr, rb_node);
> +	return strcmp(xattr->name, xattr_name);
> +}
> +
> +/**
> + * rbtree_simple_xattr_node_cmp - compare two xattr rbtree nodes
> + * @new_node: new node
> + * @node: current node
> + *
> + * Compare the xattr attached to @new_node with the xattr attached to @node.
> + *
> + * Return: Negative value if continuing left, positive if continuing right, 0
> + * if the xattr attached to @new_node matches the xattr attached to @node.
> + */
> +static int rbtree_simple_xattr_node_cmp(struct rb_node *new_node,
> +					const struct rb_node *node)
> +{
> +	struct simple_xattr *xattr;
> +	xattr = rb_entry(new_node, struct simple_xattr, rb_node);
> +	return rbtree_simple_xattr_cmp(xattr->name, node);
> +}
> +
> +/**
> + * simple_xattr_get - get an xattr object
> + * @xattrs: the header of the xattr object
> + * @name: the name of the xattr to retrieve
> + * @buffer: the buffer to store the value into
> + * @size: the size of @buffer
> + *
> + * Try to find and retrieve the xattr object associated with @name.
> + * If @buffer is provided store the value of @xattr in @buffer
> + * otherwise just return the length. The size of @buffer is limited
> + * to XATTR_SIZE_MAX which currently is 65536.
> + *
> + * Return: On success the length of the xattr value is returned. On error a
> + * negative error code is returned.
>   */
>  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  		     void *buffer, size_t size)
>  {
> -	struct simple_xattr *xattr;
> +	struct simple_xattr *xattr = NULL;
> +	struct rb_node *rbp;
>  	int ret = -ENODATA;
>  
> -	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> -		if (strcmp(name, xattr->name))
> -			continue;
> -
> +	read_lock(&xattrs->lock);
> +	rbp = rb_find(name, &xattrs->rb_root, rbtree_simple_xattr_cmp);
> +	if (rbp) {
> +		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
>  		ret = xattr->size;
>  		if (buffer) {
>  			if (size < xattr->size)
> @@ -1035,34 +1105,44 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
>  			else
>  				memcpy(buffer, xattr->value, xattr->size);
>  		}
> -		break;
>  	}
> -	spin_unlock(&xattrs->lock);
> +	read_unlock(&xattrs->lock);
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
> + * If it does it will be replaced with the new xattr object. If it doesn't we
> + * fail. If XATTR_CREATE is specified and a matching xattr does already exist
> + * we fail. If it doesn't we create a new xattr. If @flags is zero we simply
> + * insert the new xattr replacing any existing one.
> + *
> + * If @value is empty and a matching xattr object is found we delete it if
> + * XATTR_REPLACE is specified in @flags or @flags is zero.
>   *
> - * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise fails
> - * with -EEXIST.  If %XATTR_REPLACE is set, the xattr should exist;
> - * otherwise, fails with -ENODATA.
> + * If @value is empty and no matching xattr object for @name is found we do
> + * nothing if XATTR_CREATE is specified in @flags or @flags is zero. For
> + * XATTR_REPLACE we fail as mentioned above.
>   *
> - * Returns 0 on success, -errno on failure.
> + * Return: On success zero and on error a negative error code is returned.
>   */
>  int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  		     const void *value, size_t size, int flags,
>  		     ssize_t *removed_size)
>  {
> -	struct simple_xattr *xattr;
> -	struct simple_xattr *new_xattr = NULL;
> -	int err = 0;
> +	struct simple_xattr *xattr = NULL, *new_xattr = NULL;
> +	struct rb_node *parent = NULL, **rbp;
> +	int err = 0, ret;
>  
>  	if (removed_size)
>  		*removed_size = -1;
> @@ -1075,42 +1155,68 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
>  
>  		new_xattr->name = kstrdup(name, GFP_KERNEL);
>  		if (!new_xattr->name) {
> -			kvfree(new_xattr);
> +			free_simple_xattr(new_xattr);
>  			return -ENOMEM;
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
> -		xattr = NULL;
> +	write_lock(&xattrs->lock);
> +	rbp = &xattrs->rb_root.rb_node;
> +	while (*rbp) {
> +		parent = *rbp;
> +		ret = rbtree_simple_xattr_cmp(name, *rbp);
> +		if (ret < 0)
> +			rbp = &(*rbp)->rb_left;
> +		else if (ret > 0)
> +			rbp = &(*rbp)->rb_right;
> +		else
> +			xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
> +		if (xattr)
> +			break;
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
> +			rb_replace_node(&xattr->rb_node, &new_xattr->rb_node,
> +					&xattrs->rb_root);
> +		else
> +			rb_erase(&xattr->rb_node, &xattrs->rb_root);
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
> +			rb_link_node(&new_xattr->rb_node, parent, rbp);
> +			rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
> +		}
> +
> +		/*
> +		 * If XATTR_CREATE or no flags are specified and neither an
> +		 * old or new xattr exist then we don't need to do anything.
> +		 */
>  	}
> +
> +out_unlock:
> +	write_unlock(&xattrs->lock);
> +	if (err)
> +		free_simple_xattr(new_xattr);
> +	else
> +		free_simple_xattr(xattr);
>  	return err;
>  
>  }
> @@ -1134,14 +1240,31 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
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
> + * List all xattrs associated with @inode. If @buffer is NULL we returned
> + * the required size of the buffer. If @buffer is provided we store the
> + * xattrs value into it provided it is big enough.
> + *
> + * Note, the number of xattr names that can be listed with listxattr(2) is
> + * limited to XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is passed
> + * then vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr names
> + * are found it will return -E2BIG.
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
> @@ -1162,8 +1285,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  	}
>  #endif
>  
> -	spin_lock(&xattrs->lock);
> -	list_for_each_entry(xattr, &xattrs->head, list) {
> +	read_lock(&xattrs->lock);
> +	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
> +		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> +
>  		/* skip "trusted." attributes for unprivileged callers */
>  		if (!trusted && xattr_is_trusted(xattr->name))
>  			continue;
> @@ -1172,18 +1297,76 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  		if (err)
>  			break;
>  	}
> -	spin_unlock(&xattrs->lock);
> +	read_unlock(&xattrs->lock);
>  
>  	return err ? err : size - remaining_size;
>  }
>  
> -/*
> - * Adds an extended attribute to the list
> +/**
> + * rbtree_simple_xattr_less - compare two xattr rbtree nodes
> + * @new_node: new node
> + * @node: current node
> + *
> + * Compare the xattr attached to @new_node with the xattr attached to @node.
> + * Note that this function technically tolerates duplicate entries.
> + *
> + * Return: True if insertion point in the rbtree is found.
>   */
> -void simple_xattr_list_add(struct simple_xattrs *xattrs,
> -			   struct simple_xattr *new_xattr)
> +static bool rbtree_simple_xattr_less(struct rb_node *new_node,
> +				     const struct rb_node *node)
>  {
> -	spin_lock(&xattrs->lock);
> -	list_add(&new_xattr->list, &xattrs->head);
> -	spin_unlock(&xattrs->lock);
> +	return rbtree_simple_xattr_node_cmp(new_node, node) < 0;
> +}
> +
> +/**
> + * simple_xattr_add - add xattr objects
> + * @xattrs: the header of the xattr object
> + * @new_xattr: the xattr object to add
> + *
> + * Add an xattr object to @xattrs. This assumes no replacement or removal
> + * of matching xattrs is wanted. Should only be called during inode
> + * initialization when a few distinct initial xattrs are supposed to be set.
> + */
> +void simple_xattr_add(struct simple_xattrs *xattrs,
> +		      struct simple_xattr *new_xattr)
> +{
> +	write_lock(&xattrs->lock);
> +	rb_add(&new_xattr->rb_node, &xattrs->rb_root, rbtree_simple_xattr_less);
> +	write_unlock(&xattrs->lock);
> +}
> +
> +/**
> + * simple_xattrs_init - initialize new xattr header
> + * @xattrs: header to initialize
> + *
> + * Initialize relevant fields of a an xattr header.
> + */
> +void simple_xattrs_init(struct simple_xattrs *xattrs)
> +{
> +	xattrs->rb_root = RB_ROOT;
> +	rwlock_init(&xattrs->lock);
> +}
> +
> +/**
> + * simple_xattrs_free - free xattrs
> + * @xattrs: xattr header whose xattrs to destroy
> + *
> + * Destroy all xattrs in @xattr. When this is called no one can hold a
> + * reference to any of the xattrs anymore.
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
> index 4c379d23ec6e..b559c6bbcad0 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -80,48 +80,28 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
>  }
>  
>  struct simple_xattrs {
> -	struct list_head head;
> -	spinlock_t lock;
> +	struct rb_root rb_root;
> +	rwlock_t lock;
>  };
>  
>  struct simple_xattr {
> -	struct list_head list;
> +	struct rb_node rb_node;
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
