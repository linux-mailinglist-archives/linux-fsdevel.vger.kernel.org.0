Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B076D62619F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiKKSpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 13:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKSpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:45:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DE128
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 10:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D6B6620AE
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 18:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7BCC433C1;
        Fri, 11 Nov 2022 18:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668192310;
        bh=D+ST/RCT0/iCE9ggRgU7lSV7p1UJqZXYg6hlms7o4Yc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p3nDccWfMFsiZZT8p0E9/JBDzou1hhqzcueBy31ugpszVLkapoSRb8dw+NphR5O1q
         QH5IF3SM1P8FBYRG8s6auGSl8FLzG23XgwKFtI0LaHSCm8y6L1p9jLuW/Jd8RIZvA7
         1vOSJ4ozl0uSdDUofCXU5mbcESac02eYKsaD03/eU0XItqLzYeYnQKvyT9651vVFPe
         K+64fJuaZzBNEemYnFT37ciEmEEANRma+mxkEEn5g5CmAgwfbfm8faA/YBY+DxZ0RL
         KqPurGeKv3F8Yb4UpfU8aMfIkD0us73/z5xBFf0QN6ZFilIXl5kdPgE8ntIxWyf6F7
         3zWcI/aML/3ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7610C5C08D8; Fri, 11 Nov 2022 10:45:09 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:45:09 -0800
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
Message-ID: <20221111184509.GY725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221108114112.1579299-1-brauner@kernel.org>
 <20221108185904.GE3907045@paulmck-ThinkPad-P17-Gen-1>
 <20221109095152.r7eqtq3t6oxkjp2n@wittgenstein>
 <20221111081335.GV725751@paulmck-ThinkPad-P17-Gen-1>
 <20221111105123.7oy6ruedd26dt4g3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111105123.7oy6ruedd26dt4g3@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:51:23AM +0100, Christian Brauner wrote:
> On Fri, Nov 11, 2022 at 12:13:35AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 09, 2022 at 10:51:52AM +0100, Christian Brauner wrote:
> > > On Tue, Nov 08, 2022 at 10:59:04AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Nov 08, 2022 at 12:41:12PM +0100, Christian Brauner wrote:
> > > > > A while ago Vasily reported that it is possible to set a large number of
> > > > > xattrs on inodes of filesystems that make use of the simple xattr
> > > > > infrastructure. This includes all kernfs-based filesystems that support
> > > > > xattrs (e.g., cgroupfs) and tmpfs. Both cgroupfs and tmpfs can be
> > > > > mounted by unprivileged users in unprivileged containers and root in an
> > > > > unprivileged container can set an unrestricted number of security.*
> > > > > xattrs and privileged users can also set unlimited trusted.* xattrs. As
> > > > > there are apparently users that have a fairly large number of xattrs we
> > > > > should scale a bit better. Other xattrs such as user.* are restricted
> > > > > for kernfs-based instances to a fairly limited number.
> > > > > 
> > > > > Using a simple linked list protected by a spinlock used for set, get,
> > > > > and list operations doesn't scale well if users use a lot of xattrs even
> > > > > if it's not a crazy number. And There's no need to bring in the big guns
> > > > > like rhashtables or rw semaphors for this. An rbtree with a seqlock and
> > > > > limited rcu semantics is enough.
> > > > > 
> > > > > It scales within the constraints we are working in. By far the most
> > > > > common operations is getting an xattr. The get operation is optimized to
> > > > > be lock free as long as there are no writers. The list operation takes
> > > > > the read lock and protects against concurrent writers while allowing
> > > > > lockless get operations. Locking out other listxattr callers isn't a
> > > > > huge deal since listing xattrs is mostly relevant when copying a file or
> > > > > copying all xattrs between files.
> > > > > 
> > > > > Additionally, listxattr() doesn't list the values of xattrs it can only
> > > > > be used to list the names of all xattrs set on a file. And the number of
> > > > > xattr names that can be listed with listxattr() is limited to
> > > > > XATTR_LIST_MAX aka 65536 bytes. If a larger buffer is passed then
> > > > > vfs_listxattr() caps it to XATTR_LIST_MAX and if more xattr names are
> > > > > found it will return -EFBIG. In short, the maximum amount of memory that
> > > > > can be retrieved via listxattr() is limited.
> > > > > 
> > > > > Of course, the API is broken as documented on xattr(7) already. In the
> > > > > future we might want to address this but for now this is the world we
> > > > > live in and have lived for a long time. But it does indeed mean that
> > > > > once an application goes over XATTR_LIST_MAX limit of xattrs set on an
> > > > > inode it isn't possible to copy the file and include its xattrs in the
> > > > > copy unless the caller knows all xattrs or limits the copy of the xattrs
> > > > > to important ones it knows by name (At least for tmpfs, and kernfs-based
> > > > > filesystems. Other filesystems might provide ways of achieving this.).
> > > > > 
> > > > > Also add proper kernel documentation to all the functions.
> > > > > A big thanks to Paul for his comments.
> > > > > 
> > > > > Cc: Vasily Averin <vvs@openvz.org>
> > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > > 
> > > > Looks mostly plausible from an RCU viewpoint, but there are a few
> > > > questions/comments inline below.
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     In addition to this patch I would like to propose that we restrict the number
> > > > >     of xattrs for the simple xattr infrastructure via XATTR_MAX_LIST bytes. In
> > > > >     other words, we restrict the number of xattrs for simple xattr filesystems to
> > > > >     the number of xattrs names that can be retrieved via listxattr(). That should
> > > > >     be about 2000 to 3000 xattrs per inode which is more than enough. We should
> > > > >     risk this and see if we get any regression reports from userswith this
> > > > >     approach.
> > > > >     
> > > > >     This should be as simple as adding a max_list member to struct simple_xattrs
> > > > >     and initialize it with XATTR_MAX_LIST. Set operations would then check against
> > > > >     this field whether the new xattr they are trying to set will fit and return
> > > > >     -EFBIG otherwise. I think that might be a good approach to get rid of the in
> > > > >     principle unbounded number of xattrs that can be set via the simple xattr
> > > > >     infrastructure. I think this is a regression risk worth taking.
> > > > >     
> > > > >     /* v2 */
> > > > >     Christian Brauner <brauner@kernel.org>:
> > > > >     - Fix kernel doc.
> > > > >     - Remove accidental leftover union from previous iteration.
> > > > > 
> > > > >  fs/xattr.c            | 330 +++++++++++++++++++++++++++++++++---------
> > > > >  include/linux/xattr.h |  40 ++---
> > > > >  mm/shmem.c            |   2 +-
> > > > >  3 files changed, 270 insertions(+), 102 deletions(-)
> > > > > 
> > > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > > index 61107b6bbed2..f18454161d54 100644
> > > > > --- a/fs/xattr.c
> > > > > +++ b/fs/xattr.c
> > > > > @@ -992,8 +992,63 @@ const char *xattr_full_name(const struct xattr_handler *handler,
> > > > >  }
> > > > >  EXPORT_SYMBOL(xattr_full_name);
> > > > >  
> > > > > -/*
> > > > > - * Allocate new xattr and copy in the value; but leave the name to callers.
> > > > > +/**
> > > > > + * free_simple_xattr - free an xattr object
> > > > > + * @xattr: the xattr object
> > > > > + *
> > > > > + * Free the xattr object. Can handle @xattr being NULL.
> > > > > + */
> > > > > +static inline void free_simple_xattr(struct simple_xattr *xattr)
> > > > > +{
> > > > > +	if (xattr)
> > > > > +		kfree(xattr->name);
> > > > > +	kvfree(xattr);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * free_simple_xattr_rcu_cb - callback for freeing xattr object through rcu
> > > > > + * @cb: the rcu callback head
> > > > > + */
> > > > > +static void free_simple_xattr_rcu_cb(struct callback_head *cb)
> > > > > +{
> > > > > +	free_simple_xattr(container_of(cb, struct simple_xattr, rcu));
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * free_simple_xattr_rcu - free an xattr object with rcu semantics
> > > > > + * @xattr: the xattr object
> > > > > + */
> > > > > +static void free_simple_xattr_rcu(struct simple_xattr *xattr)
> > > > > +{
> > > > > +	call_rcu(&xattr->rcu, free_simple_xattr_rcu_cb);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * put_simple_xattr_rcu - decrement refcount for xattr object
> > > > > + * @xattr: the xattr object
> > > > > + *
> > > > > + * Decrement the reference count of an xattr object and free it using rcu
> > > > > + * semantics if we're the holder of the last reference. Can handle @xattr being
> > > > > + * NULL.
> > > > > + */
> > > > > +static inline void put_simple_xattr_rcu(struct simple_xattr *xattr)
> > > > > +{
> > > > > +	if (xattr && refcount_dec_and_test(&xattr->ref))
> > > > > +		free_simple_xattr_rcu(xattr);
> > > > > +}
> > > > 
> > > > Looks like the standard combined reference counter and RCU combination,
> > > > goog!
> > > > 
> > > > > +
> > > > > +/**
> > > > > + * simple_xattr_alloc - allocate new xattr object
> > > > > + * @value: value of the xattr object
> > > > > + * @size: size of @value
> > > > > + *
> > > > > + * Allocate a new xattr object and initialize respective members. The caller is
> > > > > + * responsible for handling the name of the xattr.
> > > > > + *
> > > > > + * The initial reference count belongs to the rbtree.
> > > > > + *
> > > > > + * Return: On success a new xattr object is returned. On failure NULL is
> > > > > + * returned.
> > > > >   */
> > > > >  struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
> > > > >  {
> > > > > @@ -1011,57 +1066,99 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
> > > > >  
> > > > >  	new_xattr->size = size;
> > > > >  	memcpy(new_xattr->value, value, size);
> > > > > +	refcount_set(&new_xattr->ref, 1);
> > > > 
> > > > Yes, one is usually needed for the link in the tree.
> > > > 
> > > > >  	return new_xattr;
> > > > >  }
> > > > >  
> > > > > -/*
> > > > > - * xattr GET operation for in-memory/pseudo filesystems
> > > > > +/**
> > > > > + * simple_xattr_get - get an xattr object
> > > > > + * @xattrs: the header of the xattr object
> > > > > + * @name: the name of the xattr to retrieve
> > > > > + * @buffer: the buffer to store the value into
> > > > > + * @size: the size of @buffer
> > > > > + *
> > > > > + * Try to find and retrieve the xattr object associated with @name. If the
> > > > > + * object is found and still in the rbtree bump the reference count.
> > > > > + *
> > > > > + * If @buffer is provided store the value of @xattr in @buffer.
> > > > > + *
> > > > > + * Return: On success zero and on error a negative error code is returned.
> > > > >   */
> > > > >  int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
> > > > >  		     void *buffer, size_t size)
> > > > >  {
> > > > > -	struct simple_xattr *xattr;
> > > > > -	int ret = -ENODATA;
> > > > > -
> > > > > -	spin_lock(&xattrs->lock);
> > > > > -	list_for_each_entry(xattr, &xattrs->head, list) {
> > > > > -		if (strcmp(name, xattr->name))
> > > > > -			continue;
> > > > > -
> > > > > -		ret = xattr->size;
> > > > > -		if (buffer) {
> > > > > -			if (size < xattr->size)
> > > > > -				ret = -ERANGE;
> > > > > -			else
> > > > > -				memcpy(buffer, xattr->value, xattr->size);
> > > > > +	struct simple_xattr *xattr = NULL;
> > > > > +	struct rb_node *rbp;
> > > > > +	int ret, seq = 0;
> > > > > +
> > > > > +	rcu_read_lock();
> > > > > +	do {
> > > > > +		read_seqbegin_or_lock(&xattrs->lock, &seq);
> > > > 
> > > > It might be necessary to try a few times before grabbing the lock, but
> > > > perhaps we should actually hit the problem before increasing complexity.
> > > > 
> > > > > +		rbp = rcu_dereference(xattrs->rb_root.rb_node);
> > > > > +		while (rbp) {
> > > > > +			xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> > > > > +			if (strcmp(xattr->name, name) < 0) {
> > > > > +				rbp = rcu_dereference(rbp->rb_left);
> > > > > +			} else if (strcmp(xattr->name, name) > 0) {
> > > > > +				rbp = rcu_dereference(rbp->rb_right);
> > > > > +			} else {
> > > > > +				if (!likely(refcount_inc_not_zero(&xattr->ref)))
> > > > > +					xattr = NULL;
> > > > > +				break;
> > > > > +			}
> > > > > +			xattr = NULL;
> > > > >  		}
> > > > 
> > > > Maybe this is too specialized, but should this be in the rbtree code,
> > > > perhaps rb_find_first_rcu(), but with an appropriate cmp() function?
> > > > The refcount_inc_not_zero() clearly needs to be in the caller.
> > > > 
> > > > If this is the only instance of this sort of code, it is likely not
> > > > really worthwhile.  But if we have several of these open coded, it would
> > > > be good to consolidate that code.
> > > 
> > > There's more than one instance of this pattern for sure.
> > 
> > OK, might be time to consolidate, then.  ;-)
> > 
> > > > > -		break;
> > > > > +	} while (need_seqretry(&xattrs->lock, seq));
> > > > > +	done_seqretry(&xattrs->lock, seq);
> > > > > +	rcu_read_unlock();
> > > > > +
> > > > > +	if (!xattr)
> > > > > +		return -ENODATA;
> > > > > +
> > > > > +	ret = xattr->size;
> > > > > +	if (buffer) {
> > > > > +		if (size < xattr->size)
> > > > > +			ret = -ERANGE;
> > > > > +		else
> > > > > +			memcpy(buffer, xattr->value, xattr->size);
> > > > 
> > > > If all we are doing is copying to an in-kernel buffer, why not dispense
> > > > with xattr->ref and do the memcpy() under rcu_read_lock() protection?
> > > > This would avoid some overhead from reference-count cache misses.
> > > > 
> > > > Of course, if that memcpy() can page fault or some such, then what
> > > > you have is necessary.  But this is all in-kernel, right?  And if not,
> > > > shouldn't the pointers be decorated with __user or some such?
> > > 
> > > This is just a regular in-kernel memcpy(). Good idea dispensing with the
> > > refcount completely.
> > 
> > Sounds good!
> > 
> > > > >  	}
> > > > > -	spin_unlock(&xattrs->lock);
> > > > > +
> > > > > +	put_simple_xattr_rcu(xattr);
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > >  /**
> > > > > - * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
> > > > > - * @xattrs: target simple_xattr list
> > > > > - * @name: name of the extended attribute
> > > > > - * @value: value of the xattr. If %NULL, will remove the attribute.
> > > > > - * @size: size of the new xattr
> > > > > - * @flags: %XATTR_{CREATE|REPLACE}
> > > > > - * @removed_size: returns size of the removed xattr, -1 if none removed
> > > > > + * simple_xattr_set - set an xattr object
> > > > > + * @xattrs: the header of the xattr object
> > > > > + * @name: the name of the xattr to retrieve
> > > > > + * @value: the value to store along the xattr
> > > > > + * @size: the size of @value
> > > > > + * @flags: the flags determining how to set the xattr
> > > > > + * @removed_size: the size of the removed xattr
> > > > > + *
> > > > > + * Set a new xattr object.
> > > > > + * If @value is passed a new xattr object will be allocated. If XATTR_REPLACE
> > > > > + * is specified in @flags a matching xattr object for @name must already exist.
> > > > > + * If it does it will be replace with the new xattr object. If it doesn't we
> > > > > + * fail. If XATTR_CREATE is specified and a matching xattr does already exist
> > > > > + * we fail. If it doesn't we create a new xattr. If @flags is zero we simply
> > > > > + * insert the new xattr replacing any existing one.
> > > > >   *
> > > > > - * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise fails
> > > > > - * with -EEXIST.  If %XATTR_REPLACE is set, the xattr should exist;
> > > > > - * otherwise, fails with -ENODATA.
> > > > > + * If @value is empty and a matching xattr object is found we delete it if
> > > > > + * XATTR_REPLACE is specified in @flags or @flags is zero.
> > > > >   *
> > > > > - * Returns 0 on success, -errno on failure.
> > > > > + * If @value is empty and no matching xattr object for @name is found we do
> > > > > + * nothing if XATTR_CREATE is specified in @flags or @flags is zero. For
> > > > > + * XATTR_REPLACE we fail as mentioned above.
> > > > > + *
> > > > > + * Return: On success zero and on error a negative error code is returned.
> > > > >   */
> > > > >  int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> > > > >  		     const void *value, size_t size, int flags,
> > > > >  		     ssize_t *removed_size)
> > > > >  {
> > > > > -	struct simple_xattr *xattr;
> > > > > -	struct simple_xattr *new_xattr = NULL;
> > > > > +	struct simple_xattr *xattr = NULL, *new_xattr = NULL;
> > > > > +	struct rb_node *parent = NULL, **rbp;
> > > > >  	int err = 0;
> > > > >  
> > > > >  	if (removed_size)
> > > > > @@ -1080,37 +1177,64 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
> > > > >  		}
> > > > >  	}
> > > > >  
> > > > > -	spin_lock(&xattrs->lock);
> > > > > -	list_for_each_entry(xattr, &xattrs->head, list) {
> > > > > -		if (!strcmp(name, xattr->name)) {
> > > > > -			if (flags & XATTR_CREATE) {
> > > > > -				xattr = new_xattr;
> > > > > -				err = -EEXIST;
> > > > > -			} else if (new_xattr) {
> > > > > -				list_replace(&xattr->list, &new_xattr->list);
> > > > > -				if (removed_size)
> > > > > -					*removed_size = xattr->size;
> > > > > -			} else {
> > > > > -				list_del(&xattr->list);
> > > > > -				if (removed_size)
> > > > > -					*removed_size = xattr->size;
> > > > > -			}
> > > > > -			goto out;
> > > > > -		}
> > > > > -	}
> > > > > -	if (flags & XATTR_REPLACE) {
> > > > > -		xattr = new_xattr;
> > > > > -		err = -ENODATA;
> > > > > -	} else {
> > > > > -		list_add(&new_xattr->list, &xattrs->head);
> > > > > +	write_seqlock(&xattrs->lock);
> > > > > +	rbp = &xattrs->rb_root.rb_node;
> > > > > +	while (*rbp) {
> > > > > +		parent = *rbp;
> > > > > +		xattr = rb_entry(*rbp, struct simple_xattr, rb_node);
> > > > > +		if (strcmp(xattr->name, name) < 0)
> > > > > +			rbp = &(*rbp)->rb_left;
> > > > > +		else if (strcmp(xattr->name, name) > 0)
> > > > > +			rbp = &(*rbp)->rb_right;
> > > > > +		else
> > > > > +			break;
> > > > >  		xattr = NULL;
> > > > >  	}
> > > > > -out:
> > > > > -	spin_unlock(&xattrs->lock);
> > > > > +
> > > > >  	if (xattr) {
> > > > > -		kfree(xattr->name);
> > > > > -		kvfree(xattr);
> > > > > +		/* Fail if XATTR_CREATE is requested and the xattr exists. */
> > > > > +		if (flags & XATTR_CREATE) {
> > > > > +			err = -EEXIST;
> > > > > +			goto out_unlock;
> > > > > +		}
> > > > > +
> > > > > +		if (new_xattr)
> > > > > +			rb_replace_node_rcu(&xattr->rb_node,
> > > > > +					    &new_xattr->rb_node,
> > > > > +					    &xattrs->rb_root);
> > > > > +		else
> > > > > +			rb_erase(&xattr->rb_node, &xattrs->rb_root);
> > > > 
> > > > Is rb_erase() RCU-reader-safe?  It is not immediately obvious to me that it
> > > > is.  I would expect an rcu_assign_pointer() or three in there somewhere.
> > > 
> > > This question send me down an interesting rabbit hole which is
> > > (unironically) excellent. Afaiu, yes rb_erase() isn't rcu safe. And our
> > > rbtree implementation in general isn't rcu safe in the face of
> > > rebalances (I think you linked to a paper that illustrates how one would
> > > need to go about doing this though.). So all users deal with that using
> > > the seq+rcu-rbtree pattern. I trust you'll correct me if I'm wrong: The
> > > assumption of current users seems to be that searching the rbtree under
> > > the rcu lock - i.e., without having taken the read seqlock - is safe
> > > against oops or iow against corrupt pointers if a writer changes the
> > > rbtree during the walk. The seqlock is supposed to prevent garbage/stale
> > > results. At least all users of this pattern seem to rely on the fact
> > > that a rcu only walk cannot oops. Is that assumption safe?
> > 
> > Kind of, maybe?
> > 
> > To be fully safe, you need to check the seqlock during the actual tree
> > traversal.  Otherwise, an unfortunate series of rebalances or rotations
> > or whatever could potentially run a given reader forever in circles.
> > Though the odds of this actually continuing for any length of time are
> > of course extremely low.
> > 
> > And unmarked accesses to shared variables having conflicting concurrent
> > accesses is playing with fire, though one hopes that stores of pointers
> > would end up wsing single machine instructions.  In theory, there are
> > a number of ways that compiler optimizations could cause trouble.
> 
> Since this is code reachable from unprivileged userspace I'd rather not
> play with fire here at all. Even if all of this might turn out to be
> just a theoretical possibility.
> 
> I think rcu+seq+rbtree would've made for an interesting, sufficiently
> scalable solution with still limited complexity. It's not really too
> hard to understand and isn't bloated. But given that we have some valid
> concerns we should de-fancy-fy and use an rwlock_t. Roman alrady
> mentioned this and I had this is an implementation before this one
> (together with rhashtable as I've mentioned). I'll send out the patches
> shortly. I'm just finishing tests.

Fair enough!

> > > Another point that popped up discussing this was that there's an
> > > unlikely attack scenario that David (Howells) made me aware of. While
> > > walking the rbtree under rcu only without the read seqlock it is
> > > theoretically possible for the rbtree to keep being expanded and cause
> > > the rcu walk to "never finish". Though I'm unsure whether that's really
> > > a practically possible attack.
> > 
> > Perhaps David's scenario is similar to my eternal rebalance?
> 
> Yeah, it certainly was.
> 
> > 
> > > Very interested to hear your thoughts here!
> > 
> > I would of course feel better if there were fewer vulnerabilities.
> 
> I agree so we should change the implementation as mentioned above.
> 
> > 
> > > > > +		if (!err && removed_size)
> > > > > +			*removed_size = xattr->size;
> > > > > +	} else {
> > > > > +		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
> > > > > +		if (flags & XATTR_REPLACE) {
> > > > > +			err = -ENODATA;
> > > > > +			goto out_unlock;
> > > > > +		}
> > > > > +
> > > > > +		/*
> > > > > +		 * If XATTR_CREATE or no flags are specified together with a
> > > > > +		 * new value simply insert it.
> > > > > +		 */
> > > > > +		if (new_xattr) {
> > > > > +			rb_link_node_rcu(&new_xattr->rb_node, parent, rbp);
> > > > > +			rb_insert_color(&new_xattr->rb_node, &xattrs->rb_root);
> > > > > +		}
> > > > > +
> > > > > +		/*
> > > > > +		 * If XATTR_CREATE or no flags are specified and neither an old
> > > > > +		 * or new xattr were found/exist then we don't need to do
> > > > > +		 * anything.
> > > > > +		 */
> > > > 
> > > > As before, some of this looks like it should be in the rbtree implementation.
> > > > On the other hand, and add-or-replace function like this might be rare.  And
> > > > there are only two other occurrences, both of which look quite specialize.
> > > 
> > > If you think the current rcu search pattern is sufficiently safe even
> > > against rb_erase() then we might want to give the two callers/users at
> > > least rb_find_first_rcu() directly in rbtree.h which you suggested
> > > further above.
> > 
> > If we are going to have RCU-protected rbtrees, it might be good for the
> > rbtree code to know that it is supposed to handle RCU traversals.  ;-)
> 
> I honestly think this would make for a pretty nifty bachelor thesis
> project. :)

Makes sense to me!  You have a student in mind?

							Thanx, Paul
