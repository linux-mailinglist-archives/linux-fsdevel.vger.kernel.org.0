Return-Path: <linux-fsdevel+bounces-9791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF4F844F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3558928D50A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2822080;
	Thu,  1 Feb 2024 02:26:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C017BD1;
	Thu,  1 Feb 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754389; cv=none; b=KpgO8RgDivlaRBnNPG6kJgrM+SuThLi+E0N//AZUwDbxM+iu5zcOBQFUfJ45FMp0ORksE7s9C9CCsI3AvjAEqtvZdWhP9tnLqZyriTj2tckyB1YrXisnzWCGrxTmPe3zue3OKPPdnxnZHOTJqmncD0cAKc9qNL4RZnlc0LDDdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754389; c=relaxed/simple;
	bh=C76rDHye3e75u7mr6wn5Qnyl+rZcvHVi8SCeAnXSbXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXLDMx1sqk72EC95q5beVaLMNUsiVnc3TrveIjZOvWE8wguPVSVhA8PyivJ+rWdWY16gsjMfqfjk1qkN2Gw8ETXO1DppA4sRsHYeWK3Q4Td1dP5mAKrtd8evvczjcGjWFDHkRJ5TUiNQYPz8vuoom2KNpIpYRrwiU3OLnEHU5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD08C433F1;
	Thu,  1 Feb 2024 02:26:27 +0000 (UTC)
Date: Wed, 31 Jan 2024 21:26:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/7] tracefs: dentry lookup crapectomy
Message-ID: <20240131212642.2e384250@gandalf.local.home>
In-Reply-To: <20240201002719.GS2087318@ZenIV>
References: <20240131184918.945345370@goodmis.org>
	<20240131185512.799813912@goodmis.org>
	<20240201002719.GS2087318@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 00:27:19 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Jan 31, 2024 at 01:49:22PM -0500, Steven Rostedt wrote:
> 
> > @@ -329,32 +320,29 @@ static struct dentry *create_file(const char *name, umode_t mode,
> >  
> >  	ti = get_tracefs(inode);
> >  	ti->flags |= TRACEFS_EVENT_INODE;
> > -	d_instantiate(dentry, inode);
> > +
> > +	d_add(dentry, inode);
> >  	fsnotify_create(dentry->d_parent->d_inode, dentry);  
> 
> Seriously?  stat(2), have it go away from dcache on memory pressure,
> lather, rinse, repeat...  Won't *snotify get confused by the stream
> of creations of the same thing, with not a removal in sight?
> 

That looks to be cut and paste from the old create in tracefs. I don't know
of a real use case for that. I think we could possibly delete it without
anyone noticing.


> > -	return eventfs_end_creating(dentry);
> > +	return dentry;
> >  };
> >  


> > @@ -371,11 +359,14 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
> >  	/* Only directories have ti->private set to an ei, not files */
> >  	ti->private = ei;
> >  
> > +	dentry->d_fsdata = ei;
> > +        ei->dentry = dentry;	// Remove me!
> > +
> >  	inc_nlink(inode);
> > -	d_instantiate(dentry, inode);
> > +	d_add(dentry, inode);
> >  	inc_nlink(dentry->d_parent->d_inode);  
> 
> What will happen when that thing gets evicted from dcache,
> gets looked up again, and again, and...?
> 
> >  	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);  
> 
> Same re snotify confusion...

Yeah, again, I think it's useless. Doing that is more useless than taring
the tracefs directory ;-)

> 
> > -	return eventfs_end_creating(dentry);
> > +	return dentry;
> >  }
> >  
> >  static void free_ei(struct eventfs_inode *ei)
> > @@ -425,7 +416,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
> >  }
> >  


> > @@ -607,79 +462,55 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
> >  					  struct dentry *dentry,
> >  					  unsigned int flags)
> >  {
> > -	const struct file_operations *fops;
> > -	const struct eventfs_entry *entry;
> >  	struct eventfs_inode *ei_child;
> >  	struct tracefs_inode *ti;
> >  	struct eventfs_inode *ei;
> > -	struct dentry *ei_dentry = NULL;
> > -	struct dentry *ret = NULL;
> > -	struct dentry *d;
> >  	const char *name = dentry->d_name.name;
> > -	umode_t mode;
> > -	void *data;
> > -	int idx;
> > -	int i;
> > -	int r;
> > +	struct dentry *result = NULL;
> >  
> >  	ti = get_tracefs(dir);
> >  	if (!(ti->flags & TRACEFS_EVENT_INODE))  
> 
> 	Can that ever happen?  I mean, why set ->i_op to something that
> has this for ->lookup() on a directory without TRACEFS_EVENT_INODE in
> its inode?  It's not as if you ever removed that flag...

That's been there mostly as paranoia. Should probably be switched to:

	if (WARN_ON_ONCE(!(ti->flags & TRACEFS_EVENT_INODE)))


> 
> > -		return NULL;
> > -
> > -	/* Grab srcu to prevent the ei from going away */
> > -	idx = srcu_read_lock(&eventfs_srcu);
> > +		return ERR_PTR(-EIO);
> >  
> > -	/*
> > -	 * Grab the eventfs_mutex to consistent value from ti->private.
> > -	 * This s
> > -	 */
> >  	mutex_lock(&eventfs_mutex);
> > -	ei = READ_ONCE(ti->private);
> > -	if (ei && !ei->is_freed)
> > -		ei_dentry = READ_ONCE(ei->dentry);
> > -	mutex_unlock(&eventfs_mutex);
> > -
> > -	if (!ei || !ei_dentry)
> > -		goto out;
> >  
> > -	data = ei->data;
> > +	ei = ti->private;
> > +	if (!ei || ei->is_freed)
> > +		goto enoent;
> >  
> > -	list_for_each_entry_srcu(ei_child, &ei->children, list,
> > -				 srcu_read_lock_held(&eventfs_srcu)) {
> > +	list_for_each_entry(ei_child, &ei->children, list) {
> >  		if (strcmp(ei_child->name, name) != 0)
> >  			continue;
> > -		ret = simple_lookup(dir, dentry, flags);
> > -		if (IS_ERR(ret))
> > -			goto out;
> > -		d = create_dir_dentry(ei, ei_child, ei_dentry);
> > -		dput(d);
> > +		if (ei_child->is_freed)
> > +			goto enoent;  
> 
> Out of curiosity - can that happen now?  You've got exclusion with
> eventfs_remove_rec(), so you shouldn't be able to catch the moment
> between setting ->is_freed and removal from the list...

Yeah, that's from when we just used SRCU. If anything, it too should just
add a WARN_ON_ONCE() to it.

> 
> > +		lookup_dir_entry(dentry, ei, ei_child);
> >  		goto out;
> >  	}
> >  
> > -	for (i = 0; i < ei->nr_entries; i++) {
> > -		entry = &ei->entries[i];
> > -		if (strcmp(name, entry->name) == 0) {
> > -			void *cdata = data;
> > -			mutex_lock(&eventfs_mutex);
> > -			/* If ei->is_freed, then the event itself may be too */
> > -			if (!ei->is_freed)
> > -				r = entry->callback(name, &mode, &cdata, &fops);
> > -			else
> > -				r = -1;
> > -			mutex_unlock(&eventfs_mutex);
> > -			if (r <= 0)
> > -				continue;
> > -			ret = simple_lookup(dir, dentry, flags);
> > -			if (IS_ERR(ret))
> > -				goto out;
> > -			d = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
> > -			dput(d);
> > -			break;
> > -		}
> > +	for (int i = 0; i < ei->nr_entries; i++) {
> > +		void *data;
> > +		umode_t mode;
> > +		const struct file_operations *fops;
> > +		const struct eventfs_entry *entry = &ei->entries[i];
> > +
> > +		if (strcmp(name, entry->name) != 0)
> > +			continue;
> > +
> > +		data = ei->data;
> > +		if (entry->callback(name, &mode, &data, &fops) <= 0)
> > +			goto enoent;
> > +
> > +		lookup_file_dentry(dentry, ei, i, mode, data, fops);
> > +		goto out;
> >  	}
> > +
> > + enoent:
> > +	/* Don't cache negative lookups, just return an error */
> > +	result = ERR_PTR(-ENOENT);  
> 
> Huh?  Just return NULL and be done with that - you'll get an
> unhashed negative dentry and let the caller turn that into
> -ENOENT...

We had a problem here with just returning NULL. It leaves the negative
dentry around and doesn't get refreshed.

I did this:

 # cd /sys/kernel/tracing
 # ls events/kprobes/sched/
ls: cannot access 'events/kprobes/sched/': No such file or directory
 # echo 'p:sched schedule' >> kprobe_events
 # ls events/kprobes/sched/
ls: cannot access 'events/kprobes/sched/': No such file or directory

When it should have been:

 # ls events/kprobes/sched/
enable  filter  format  hist  hist_debug  id  inject  trigger

Leaving the negative dentry there will have it fail when the directory
exists the next time.

-- Steve



> 
> >   out:
> > -	srcu_read_unlock(&eventfs_srcu, idx);
> > -	return ret;
> > +	mutex_unlock(&eventfs_mutex);
> > +	return result;
> >  }
> >  
> >  /*  


