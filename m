Return-Path: <linux-fsdevel+bounces-9659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C237784420B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A71428F7B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A284A3C;
	Wed, 31 Jan 2024 14:41:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A484A3D
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712064; cv=none; b=e2SJshrEmiDBRer5GcGL3x+H15O2iaT9Au5odgA3M4ADmu1WSN1rBk3hWrvmEcUtb5zaJKsqZZCop16pjrEmnVCevtTiN/hj/dlOrKJ2vl5slWzphTem3FDScRjVBj9lDJvzdxz7unBXvqwFv85rY/uNeSo/Ib4nFxskhz2iv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712064; c=relaxed/simple;
	bh=7ny2WOSqnlcuU6AvSOSzsWLYBpR7AdVhJLv16qKDhKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0ES1Tnj8uHrp2zqIYZvIW0Ye/1xFOmQXovgXYKRQBZYEoyD0Hh4HyLGNUSwdNsrHOJnEK8SuT6QpQXFB6nrTwUt0lmAut5MIry73Hg7krWuglb2KHc/TmsPSe9FyZaJycR1v8z1iudOk89I2Bie6j/i+HehzQOCJdsF0OSgA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A50AC433A6;
	Wed, 31 Jan 2024 14:41:03 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:41:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Amir Goldstein
 <amir73il@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, Al Viro
 <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH DRAFT 0/4] : Port tracefs to kernfs
Message-ID: <20240131094117.7bccfe6c@gandalf.local.home>
In-Reply-To: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 14:36:37 +0100
Christian Brauner <brauner@kernel.org> wrote:

> Back in 2022 we already had a session at LSFMM where we talked about
> eventfs and we said that it should be based on kernfs and any missing
> functionality be implemented in kernfs. Instead we've gotten a
> hand-rolled version of similar functionality and 100+ mails exchanges
> over the last weeks to fix bugs in there binding people's time.

Note, tracefs was written way before that. This was only about eventfs.

> 
> All we've heard so far were either claims that it would be too difficult
> to port tracefs to kernfs or that it somehow wouldn't work but we've
> never heard why and it's never been demonstrated why.

Well, because mainly lack of documentation.

> 
> So I went and started a draft for porting all of tracefs to kernfs in
> the hopes that someone picks this up and finishes the work. I've gotten
> the core of it done and it's pretty easy to do logical copy-pasta to
> port this to eventfs as well.

tracefs yes, but I'm not so sure about eventfs.

> 
> I want to see tracefs and eventfs ported to kernfs and get rid of the
> hand-rolled implementation. I don't see the value in any additional
> talks about why eventfs is special until we've seen an implementation of
> tracefs on kernfs.
> 
> I'm pretty certain that we have capable people that can and want to
> finish the port (I frankly don't have time for this unless I drop all
> reviews.). I've started just jotting down the basics yesterday evening
> and came to the conclusion that:

I don't have the time either. But if someone else wants to, I'm fine with
that. I was supposed to be done with my eventfs work by December. It's
almost already February. It put me behind so much I worked throughout the
entire time between Christmas and New Years, including the weekends :-p, I
haven't stopped and I'm really starting to feel burnt.

All I ask is to keep the requirement in eventfs not to allocate anything
for files on creation (see below).

> 
> * It'll get rid of pointless dentry pinning in various places that is
>   currently done in the first place. Instead only a kernfs root and a
>   kernfs node need to be stashed. Dentries and inodes are added
>   on-demand.
> 
> * It'll make _all of_ tracefs capable of on-demand dentry and inode
>   creation.
> 
> * Quoting [1]:
> 
>   > The biggest savings in eventfs is the fact that it has no meta data for
>   > files. All the directories in eventfs has a fixed number of files when they
>   > are created. The creating of a directory passes in an array that has a list
>   > of names and callbacks to call when the file needs to be accessed. Note,
>   > this array is static for all events. That is, there's one array for all
>   > event files, and one array for all event systems, they are not allocated per
>   > directory.  
> 
>   This is all possible with kernfs.

Is it? Let me explain how eventfs files are created, and then you can tell
me how to do this with kernfs. Maybe it is possible.

There's only three types of directories in eventfs.

1) the "events" directory. This is the top node and is created in
   /sys/kernel/tracing/events as well as in /sys/kernel/tracing/instances/<instance>/events

2) The system directory. This is the events/<system>

3) The event directory. This is the events/<system>/<event>

Each of these directories have the exact same files for their type. For the
"events" directory at the top instance, or each created instance, it has
the same files (although they all have different state). All <system>
directories have the same files, and all the <event> directories have the
same files.

When one of these directories is created, it is passed a static array that
contains the name and a callback function for each of these files. That
means, for the three types of directories, there is only three arrays that
represent all files in eventfs.

Let's look at the events directory:

	ei = eventfs_create_dir(name, e_events, event_entries, nr_entries, file);

Where it passes the "name" of the event directory, the parent eventfs_inode
(e_events), a static array of the files within this directory
(event_entries) along with he size of that array (nr_entries), and finally
it passes the default data for all of the files (file) that is passed to
the callbacks and the callbacks can override the data to add to the
inode->i_private.

Let's look at that event_entries:

	static struct eventfs_entry event_entries[] = {
		{
			.name		= "enable",
			.callback	= event_callback,
		},
		{
			.name		= "filter",
			.callback	= event_callback,
		},
		{
			.name		= "trigger",
			.callback	= event_callback,
		},
		{
			.name		= "format",
			.callback	= event_callback,
		},
#ifdef CONFIG_PERF_EVENTS
		{
			.name		= "id",
			.callback	= event_callback,
		},
#endif
#ifdef CONFIG_HIST_TRIGGERS
		{
			.name		= "hist",
			.callback	= event_callback,
		},
#endif
#ifdef CONFIG_HIST_TRIGGERS_DEBUG
		{
			.name		= "hist_debug",
			.callback	= event_callback,
		},
#endif
#ifdef CONFIG_TRACE_EVENT_INJECT
		{
			.name		= "inject",
			.callback	= event_callback,
		},
#endif
	};

Notice the "static" in front. That means, *all* event directories use the
same array. There is zero allocation for any file within each of these
directories. The only exception for allocation is if the attrs change. Then
we need to allocate an array in the directory to handle that. But that too
is only allocated when referenced.

And there's a lot of those directories:

  # ls -d events/*/* |wc -l
2212

The dentry and inode are only created on lookup in the lookup code:

	for (int i = 0; i < ei->nr_entries; i++) {
		void *data;
		umode_t mode;
		const struct file_operations *fops;
		const struct eventfs_entry *entry = &ei->entries[i];

		if (strcmp(name, entry->name) != 0)
			continue;

		data = ei->data;
		if (entry->callback(name, &mode, &data, &fops) <= 0)
			goto enoent;

		result = lookup_file_dentry(dentry, ei, i, mode, data, fops);
		goto out;
	}

The ei represents the events directory (or a system directory or even the
"events" directory). It loops that static array looking for a matching
name (if needed, I have thought about requiring it to be sorted, to do a
binary search instead). If it finds one, it then calls the callback
function, as some event directories do not have all the files, the callback
can inform the lookup that "no, this directory doesn't get this file". For
example, the internal ftrace events (like what is used for function
tracing) doesn't have an "enable" or "filter" file as you can't enable
those events, the callback will inform the lookup about that.

	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
		if (call->class->reg && strcmp(name, "enable") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &ftrace_enable_fops;
			return 1;
		}

		if (strcmp(name, "filter") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &ftrace_event_filter_fops;
			return 1;
		}
	}
	[..]
	return 0;

 # ls events/sched/sched_switch/
enable  filter  format  hist  hist_debug  id  inject  trigge

 # ls events/ftrace/function/
format  hist  hist_debug  id  inject

My point being, that eventfs doesn't allocate any resources for the files.
Well, you could say it does allocate the ei->entries pointer that points to
the static array.

tracefs has tracefs_create_file() but evenfs does not. What is the
equivalent to that in kernfs?

  # ls -d events/*/*/* |wc -l
15819

I do not want to allocate 15 thousand kernfs_node's for this.

Perhaps kernfs has a way to do the same, or maybe it's trivial to make it
do it? I don't know.

> 
> * All ownership information (mode, uid, gid) is stashed and kept
>   kernfs_node->iattrs. So the parent kernfs_node's ownership can be used
>   to set the child's ownership information. This will allow to get rid
>   of any custom permission checking and ->getattr() and ->setattr()
>   calls.
> 
> * Private tracefs data that was stashed in inode->i_private is stashed
>   in kernfs_node->priv. That's always accessible in kernfs->open() calls
>   via kernfs_open_file->kn->priv but it could also be transferred to
>   kernfs_open_file->priv. In any case, it makes it a lot easier to
>   handle private data than tracefs does it now.
> 
> * It'll make maintenance of tracefs easier in the long run because new
>   functionality and improvements get added to kernfs including better
>   integration with namespaces (I've had patchsets for kernfs a while ago
>   to unlock additional namespaces.)
> 
> * There's no need for separate i_ops for "instances" and regular tracefs
>   directories. Simply compare the stashed kernfs_node of the "instances"
>   directory against the current kernfs_node passed to ->mkdir() or
>   ->rmdir() whether the directory creation or deletion is allowed.  
> 
> * Frankly, another big reason to do it is simply maintenance. All of the
>   maintenance burden neeeds to be shifted to the generic kernfs
>   implementation which is maintained by people familar with filesystem
>   details. I'm willing to support it too.
> 
>   No shade, but currently I don't see how eventfs can be maintained
>   without the involvement of others. Maintainability alone should be a
>   sufficient reason to move all of this to kernfs and add any missing
>   functionality.
> 
> * If we have a session about this at LSFMM and I want to see a POC of
>   tracefs and eventfs built on top of kernfs. I'm tired of talking about
>   a private implementation of functionality that already exists.
>   Otherwise, this is just wasting everyone's time and eventfs as it is
>   will not become common infrastructure.

That was never the point. I believe the point was how do we make it easier
to not have this situation happen again. I don't want eventfs to be the
standard way of doing things. I'm looking at this as more of a post-mortem
session than "let's do it this way" one.

-- Steve

> 
> * Yes, debugfs could or should be ported as well but it's almost
>   irrelevant for debugfs. It's a debugging filesystem. If you enable it
>   on a production workload then you have bigger problems to worry about
>   than wasted memory. So I don't consider that urgent. But tracefs is
>   causing us headaches right now and I'm weary of cementing a
>   hand-rolled implementation.
> 
> So really, please let's move this to kernfs, fix any things that aren't
> supported in kernfs (I haven't seen any) and get rid of all the custom
> functionality. Part of the work is moving tracefs to the new mount api
> (which should've been done anyway).
> 
> The fs/tracefs/ part already compiles. The rest I haven't finished
> converting. All the file_operations need to be moved to kernfs_ops which
> shouldn't be too difficult.

