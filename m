Return-Path: <linux-fsdevel+bounces-9783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51666844DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 01:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761591C26476
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC781D;
	Thu,  1 Feb 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="unNbC8SJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F57F4;
	Thu,  1 Feb 2024 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747255; cv=none; b=dx4y1ay5xCEp6TLF2KgN2+/Ar+mIBSBL82yF/17MVvu2pAyLa6ZZKbva766lP5eTkwvj+Js+60k61vxlqAPsBwMI3CFkZG2TsJ4hShCJeoNrnKAsahV56UFwVWeE+spqux6i/3yDU4BrEQrVI7Xc7c20pERtRuJWSYJ+dSvfK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747255; c=relaxed/simple;
	bh=tv1CPGrK8vzaKtVGrIX5x8ne8NrhSN7QwqsIpoVlwm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbt3CPtw+MekOwwcTyd+MzlIM2eAlX70ianeNkn9XWxzqupnONY7wX+j2/zToqcI5NgiI0V4zRhFKkHaB6ojbsJCgQvnep1o6uOARg/vsYI/iheQT18UfK2SdI8/Yxtb5l4E2F/oB3/RwxbZz0d5BKVgVLYfNZz8EM/vTtTV52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=unNbC8SJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=crQTnzaqyVYUwMikpNfzwJKnCBI4oaKnH+4aiFUUIf4=; b=unNbC8SJOTWTEek3iR7B8iUYRm
	UEP1XBMlQDRwvGSe0GVGbXRt8D6sIpKpbG1cc66iTvGNKEefQz+JGAUEAoUCNwANS2y/I3Apjjh75
	3+KdBCom6Ge8SJo2EdTbaBXfefLahaUo00+IYws+ejJwhNkRydmvfSjSZHRvHhHZgmFSE7g4IXOEH
	JPdDtvyyTPT3fhLdh8SSplk8jOS6h8qqd4ZCgJgqLeepCOs69Dg05+NOiKrluWvr9lb9CiJBPGH8r
	luuhy2ccgO2sZg8SPd2mzHqv36y9r9QIKCjRdXWYSZdZ8StsYHQ8jhJniwiKZtfXzSEdc3rlLvJJM
	k9yUj7RA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVKvH-002ecg-0x;
	Thu, 01 Feb 2024 00:27:19 +0000
Date: Thu, 1 Feb 2024 00:27:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracefs: dentry lookup crapectomy
Message-ID: <20240201002719.GS2087318@ZenIV>
References: <20240131184918.945345370@goodmis.org>
 <20240131185512.799813912@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131185512.799813912@goodmis.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 31, 2024 at 01:49:22PM -0500, Steven Rostedt wrote:

> @@ -329,32 +320,29 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  
>  	ti = get_tracefs(inode);
>  	ti->flags |= TRACEFS_EVENT_INODE;
> -	d_instantiate(dentry, inode);
> +
> +	d_add(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);

Seriously?  stat(2), have it go away from dcache on memory pressure,
lather, rinse, repeat...  Won't *snotify get confused by the stream
of creations of the same thing, with not a removal in sight?

> -	return eventfs_end_creating(dentry);
> +	return dentry;
>  };
>  
>  /**
> - * create_dir - create a dir in the tracefs filesystem
> + * lookup_dir_entry - look up a dir in the tracefs filesystem
> + * @dentry: the directory to look up
>   * @ei: the eventfs_inode that represents the directory to create
> - * @parent: parent dentry for this file.
>   *
> - * This function will create a dentry for a directory represented by
> + * This function will look up a dentry for a directory represented by
>   * a eventfs_inode.
>   */
> -static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent)
> +static struct dentry *lookup_dir_entry(struct dentry *dentry,
> +	struct eventfs_inode *pei, struct eventfs_inode *ei)
>  {
>  	struct tracefs_inode *ti;
> -	struct dentry *dentry;
>  	struct inode *inode;
>  
> -	dentry = eventfs_start_creating(ei->name, parent);
> -	if (IS_ERR(dentry))
> -		return dentry;
> -
>  	inode = tracefs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> -		return eventfs_failed_creating(dentry);
> +		return ERR_PTR(-ENOMEM);
>  
>  	/* If the user updated the directory's attributes, use them */
>  	update_inode_attr(dentry, inode, &ei->attr,
> @@ -371,11 +359,14 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
>  	/* Only directories have ti->private set to an ei, not files */
>  	ti->private = ei;
>  
> +	dentry->d_fsdata = ei;
> +        ei->dentry = dentry;	// Remove me!
> +
>  	inc_nlink(inode);
> -	d_instantiate(dentry, inode);
> +	d_add(dentry, inode);
>  	inc_nlink(dentry->d_parent->d_inode);

What will happen when that thing gets evicted from dcache,
gets looked up again, and again, and...?

>  	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);

Same re snotify confusion...

> -	return eventfs_end_creating(dentry);
> +	return dentry;
>  }
>  
>  static void free_ei(struct eventfs_inode *ei)
> @@ -425,7 +416,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>  }
>  
>  /**
> - * create_file_dentry - create a dentry for a file of an eventfs_inode
> + * lookup_file_dentry - create a dentry for a file of an eventfs_inode
>   * @ei: the eventfs_inode that the file will be created under
>   * @idx: the index into the d_children[] of the @ei
>   * @parent: The parent dentry of the created file.
> @@ -438,157 +429,21 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
>   * address located at @e_dentry.
>   */
>  static struct dentry *
> -create_file_dentry(struct eventfs_inode *ei, int idx,
> -		   struct dentry *parent, const char *name, umode_t mode, void *data,
> +lookup_file_dentry(struct dentry *dentry,
> +		   struct eventfs_inode *ei, int idx,
> +		   umode_t mode, void *data,
>  		   const struct file_operations *fops)
>  {
>  	struct eventfs_attr *attr = NULL;
>  	struct dentry **e_dentry = &ei->d_children[idx];
> -	struct dentry *dentry;
> -
> -	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
>  
> -	mutex_lock(&eventfs_mutex);
> -	if (ei->is_freed) {
> -		mutex_unlock(&eventfs_mutex);
> -		return NULL;
> -	}
> -	/* If the e_dentry already has a dentry, use it */
> -	if (*e_dentry) {
> -		dget(*e_dentry);
> -		mutex_unlock(&eventfs_mutex);
> -		return *e_dentry;
> -	}
> -
> -	/* ei->entry_attrs are protected by SRCU */
>  	if (ei->entry_attrs)
>  		attr = &ei->entry_attrs[idx];
>  
> -	mutex_unlock(&eventfs_mutex);
> -
> -	dentry = create_file(name, mode, attr, parent, data, fops);
> -
> -	mutex_lock(&eventfs_mutex);
> -
> -	if (IS_ERR_OR_NULL(dentry)) {
> -		/*
> -		 * When the mutex was released, something else could have
> -		 * created the dentry for this e_dentry. In which case
> -		 * use that one.
> -		 *
> -		 * If ei->is_freed is set, the e_dentry is currently on its
> -		 * way to being freed, don't return it. If e_dentry is NULL
> -		 * it means it was already freed.
> -		 */
> -		if (ei->is_freed) {
> -			dentry = NULL;
> -		} else {
> -			dentry = *e_dentry;
> -			dget(dentry);
> -		}
> -		mutex_unlock(&eventfs_mutex);
> -		return dentry;
> -	}
> -
> -	if (!*e_dentry && !ei->is_freed) {
> -		*e_dentry = dentry;
> -		dentry->d_fsdata = ei;
> -	} else {
> -		/*
> -		 * Should never happen unless we get here due to being freed.
> -		 * Otherwise it means two dentries exist with the same name.
> -		 */
> -		WARN_ON_ONCE(!ei->is_freed);
> -		dentry = NULL;
> -	}
> -	mutex_unlock(&eventfs_mutex);
> -
> -	return dentry;
> -}
> -
> -/**
> - * eventfs_post_create_dir - post create dir routine
> - * @ei: eventfs_inode of recently created dir
> - *
> - * Map the meta-data of files within an eventfs dir to their parent dentry
> - */
> -static void eventfs_post_create_dir(struct eventfs_inode *ei)
> -{
> -	struct eventfs_inode *ei_child;
> -
> -	lockdep_assert_held(&eventfs_mutex);
> -
> -	/* srcu lock already held */
> -	/* fill parent-child relation */
> -	list_for_each_entry_srcu(ei_child, &ei->children, list,
> -				 srcu_read_lock_held(&eventfs_srcu)) {
> -		ei_child->d_parent = ei->dentry;
> -	}
> -}
> -
> -/**
> - * create_dir_dentry - Create a directory dentry for the eventfs_inode
> - * @pei: The eventfs_inode parent of ei.
> - * @ei: The eventfs_inode to create the directory for
> - * @parent: The dentry of the parent of this directory
> - *
> - * This creates and attaches a directory dentry to the eventfs_inode @ei.
> - */
> -static struct dentry *
> -create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
> -		  struct dentry *parent)
> -{
> -	struct dentry *dentry = NULL;
> -
> -	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
> -
> -	mutex_lock(&eventfs_mutex);
> -	if (pei->is_freed || ei->is_freed) {
> -		mutex_unlock(&eventfs_mutex);
> -		return NULL;
> -	}
> -	if (ei->dentry) {
> -		/* If the eventfs_inode already has a dentry, use it */
> -		dentry = ei->dentry;
> -		dget(dentry);
> -		mutex_unlock(&eventfs_mutex);
> -		return dentry;
> -	}
> -	mutex_unlock(&eventfs_mutex);
> +	dentry->d_fsdata = ei;		// NOTE: ei of _parent_
> +	lookup_file(dentry, mode, attr, data, fops);
>  
> -	dentry = create_dir(ei, parent);
> -
> -	mutex_lock(&eventfs_mutex);
> -
> -	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
> -		/*
> -		 * When the mutex was released, something else could have
> -		 * created the dentry for this e_dentry. In which case
> -		 * use that one.
> -		 *
> -		 * If ei->is_freed is set, the e_dentry is currently on its
> -		 * way to being freed.
> -		 */
> -		dentry = ei->dentry;
> -		if (dentry)
> -			dget(dentry);
> -		mutex_unlock(&eventfs_mutex);
> -		return dentry;
> -	}
> -
> -	if (!ei->dentry && !ei->is_freed) {
> -		ei->dentry = dentry;
> -		eventfs_post_create_dir(ei);
> -		dentry->d_fsdata = ei;
> -	} else {
> -		/*
> -		 * Should never happen unless we get here due to being freed.
> -		 * Otherwise it means two dentries exist with the same name.
> -		 */
> -		WARN_ON_ONCE(!ei->is_freed);
> -		dentry = NULL;
> -	}
> -	mutex_unlock(&eventfs_mutex);
> +	*e_dentry = dentry;	// Remove me
>  
>  	return dentry;
>  }
> @@ -607,79 +462,55 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  					  struct dentry *dentry,
>  					  unsigned int flags)
>  {
> -	const struct file_operations *fops;
> -	const struct eventfs_entry *entry;
>  	struct eventfs_inode *ei_child;
>  	struct tracefs_inode *ti;
>  	struct eventfs_inode *ei;
> -	struct dentry *ei_dentry = NULL;
> -	struct dentry *ret = NULL;
> -	struct dentry *d;
>  	const char *name = dentry->d_name.name;
> -	umode_t mode;
> -	void *data;
> -	int idx;
> -	int i;
> -	int r;
> +	struct dentry *result = NULL;
>  
>  	ti = get_tracefs(dir);
>  	if (!(ti->flags & TRACEFS_EVENT_INODE))

	Can that ever happen?  I mean, why set ->i_op to something that
has this for ->lookup() on a directory without TRACEFS_EVENT_INODE in
its inode?  It's not as if you ever removed that flag...

> -		return NULL;
> -
> -	/* Grab srcu to prevent the ei from going away */
> -	idx = srcu_read_lock(&eventfs_srcu);
> +		return ERR_PTR(-EIO);
>  
> -	/*
> -	 * Grab the eventfs_mutex to consistent value from ti->private.
> -	 * This s
> -	 */
>  	mutex_lock(&eventfs_mutex);
> -	ei = READ_ONCE(ti->private);
> -	if (ei && !ei->is_freed)
> -		ei_dentry = READ_ONCE(ei->dentry);
> -	mutex_unlock(&eventfs_mutex);
> -
> -	if (!ei || !ei_dentry)
> -		goto out;
>  
> -	data = ei->data;
> +	ei = ti->private;
> +	if (!ei || ei->is_freed)
> +		goto enoent;
>  
> -	list_for_each_entry_srcu(ei_child, &ei->children, list,
> -				 srcu_read_lock_held(&eventfs_srcu)) {
> +	list_for_each_entry(ei_child, &ei->children, list) {
>  		if (strcmp(ei_child->name, name) != 0)
>  			continue;
> -		ret = simple_lookup(dir, dentry, flags);
> -		if (IS_ERR(ret))
> -			goto out;
> -		d = create_dir_dentry(ei, ei_child, ei_dentry);
> -		dput(d);
> +		if (ei_child->is_freed)
> +			goto enoent;

Out of curiosity - can that happen now?  You've got exclusion with
eventfs_remove_rec(), so you shouldn't be able to catch the moment
between setting ->is_freed and removal from the list...

> +		lookup_dir_entry(dentry, ei, ei_child);
>  		goto out;
>  	}
>  
> -	for (i = 0; i < ei->nr_entries; i++) {
> -		entry = &ei->entries[i];
> -		if (strcmp(name, entry->name) == 0) {
> -			void *cdata = data;
> -			mutex_lock(&eventfs_mutex);
> -			/* If ei->is_freed, then the event itself may be too */
> -			if (!ei->is_freed)
> -				r = entry->callback(name, &mode, &cdata, &fops);
> -			else
> -				r = -1;
> -			mutex_unlock(&eventfs_mutex);
> -			if (r <= 0)
> -				continue;
> -			ret = simple_lookup(dir, dentry, flags);
> -			if (IS_ERR(ret))
> -				goto out;
> -			d = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
> -			dput(d);
> -			break;
> -		}
> +	for (int i = 0; i < ei->nr_entries; i++) {
> +		void *data;
> +		umode_t mode;
> +		const struct file_operations *fops;
> +		const struct eventfs_entry *entry = &ei->entries[i];
> +
> +		if (strcmp(name, entry->name) != 0)
> +			continue;
> +
> +		data = ei->data;
> +		if (entry->callback(name, &mode, &data, &fops) <= 0)
> +			goto enoent;
> +
> +		lookup_file_dentry(dentry, ei, i, mode, data, fops);
> +		goto out;
>  	}
> +
> + enoent:
> +	/* Don't cache negative lookups, just return an error */
> +	result = ERR_PTR(-ENOENT);

Huh?  Just return NULL and be done with that - you'll get an
unhashed negative dentry and let the caller turn that into
-ENOENT...

>   out:
> -	srcu_read_unlock(&eventfs_srcu, idx);
> -	return ret;
> +	mutex_unlock(&eventfs_mutex);
> +	return result;
>  }
>  
>  /*

