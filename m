Return-Path: <linux-fsdevel+bounces-7513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4168826590
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 19:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98532818EE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCF14004;
	Sun,  7 Jan 2024 18:29:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65ED13FED;
	Sun,  7 Jan 2024 18:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA808C433C7;
	Sun,  7 Jan 2024 18:29:13 +0000 (UTC)
Date: Sun, 7 Jan 2024 13:29:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240107132912.71b109d8@rorschach.local.home>
In-Reply-To: <20240107-getrickst-angeeignet-049cea8cad13@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jan 2024 13:42:39 +0100
Christian Brauner <brauner@kernel.org> wrote:
> 
> So, I tried to do an exploratory patch even though I promised myself not
> to do it. But hey...
> 
> Some notes:
> 
> * Permission handling for idmapped mounts is done completely in the
>   VFS. That's the case for all filesytems that don't have a custom
>   ->permission() handler. So there's nothing to do for us here.  
> 
> * Idmapped mount handling for ->getattr() is done completely by the VFS
>   if the filesystem doesn't have a custom ->getattr() handler. So we're
>   done here.
> 
> * Tracefs doesn't support attribute changes via ->setattr() (chown(),
>   chmod etc.). So there's nothing to here.
> 
> * Eventfs does support attribute changes via ->setattr(). But it relies
>   on simple_setattr() which is already idmapped mount aware. So there's
>   nothing for us to do.
> 
> * Ownership is inherited from the parent inode (tracefs) or optionally
>   from stashed ownership information (eventfs). That means the idmapping
>   is irrelevant here. It's similar to the "inherit gid from parent
>   directory" logic we have in some circumstances. TL;DR nothing to do
>   here as well.

The reason ownership is inherited from the parent is because the inodes
are created at boot up before user space starts.

eventfs inodes are created on demand after user space so it needs to
either check the "default" ownership and permissions, or if the user
changed a specific file/directory, it must save it and use that again
if the inode/dentry are reclaimed and then referenced again and
recreated.

> 
> * Tracefs supports the creation of instances from userspace via mkdir.
>   For example,
> 
> 	mkdir /sys/kernel/tracing/instances/foo
> 
>   And here the idmapping is relevant so we need to make the helpers
>   aware of the idmapping.
> 
>   I just went and plumbed this through to most helpers.
> 
> There's some subtlety in eventfs. Afaict, the directories and files for
> the individual events are created on-demand during lookup or readdir.
> 
> The ownership of these events is again inherited from the parent inode
> or recovered from stored state. In both cases the actual idmapping is
> irrelevant.
> 
> The callchain here is:
> 
> eventfs_root_lookup("xfs", "events")
> -> create_{dir,file}_dentry("xfs", "events")
>    -> create_{dir,file}("xfs", "events")
>       -> eventfs_start_creating("xfs", "events")
>          -> lookup_one_len("xfs", "events")  
> 
> And the subtlety is that lookup_one_len() does permission checking on
> the parent inode (IOW, if you want a dentry for "blech" under "events"
> it'll do a permission check on events->d_inode) for exec permissions
> and then goes on to give you a new dentry.
> 
> Usually this call would have to be changed to lookup_one() and the
> idmapping be handed down to it. But I think that's irrelevant here.
> 
> Lookup generally doesn't need to be aware of idmappings at all. The
> permission checking is done purely in the vfs via may_lookup() and the
> idmapping is irrelevant because we always initialize inodes with the
> filesystem level ownership (see the idmappings.rst) documentation if
> you're interested in excessive details (otherwise you get inode aliases
> which you really don't want).
> 
> For tracefs it would not matter for lookup per se but only because
> tracefs seemingly creates inodes/dentries during lookup (and readdir()).

tracefs creates the inodes/dentries at boot up, it's eventfs that does
it on demand during lookup.

For inodes/dentries:

 /sys/kernel/tracing/* is all created at boot up, except for "events".
 /sys/kernel/tracing/events/* is created on demand.

> 
> But imho the permission checking done in current eventfs_root_lookup()
> via lookup_one_len() is meaningless in any way; possibly even
> (conceptually) wrong.
> 
> Because, the actual permission checking for the creation of the eventfs
> entries isn't really done during lookup or readdir, it's done when mkdir
> is called:
> 
>         mkdir /sys/kernel/tracing/instances/foo

No. that creates a entire new tracefs instance, which happens to
include another eventfs directory.

The eventsfs directory is in "/sys/kernel/tracing/events" and
 "/sys/kernel/tracing/instances/*/events"

eventfs has 10s of thousands of files and directories which is why I
changed it to be on-demand inode/dentry creation and also reclaiming
when no longer accessed.

 # ls /sys/kernel/tracing/events/

will create the inodes and dentries, and a memory stress program will
free those created inodes and dentries.

> 
> Here, all possible entries beneath foo including "events" and further
> below are recorded and stored. So once mkdir returns it basically means
> that it succeeded with the creation of all the necessary directories and
> files. For all purposes the foo/events/ directory and below have all the
> entries that matter. They have been created. It's comparable to them not
> being in the {d,i}cache, I guess.

No. Only the meta data is created for the eventfs directory with a
mkdir instances/foo. The inodes and dentries are not there.

> 
> When one goes and looksup stuff under foo/events/ or readdir the entries
> in that directory:
> 
> fd = open("foo/events")
> readdir(fd, ...)
> 
> then they are licensed to list an entry in that directory. So all that
> needs to be done is to actually list those files in that directory. And
> since they already exist (they were created during mkdir) we just need
> to splice in inodes and dentries for them. But for that we shouldn't
> check permissions on the directory again. Because we've done that
> already correctly when the VFS called may_lookup().

No they do not exist.

> 
> IOW, the inode_permission() in lookup_one_len() that eventfs does is
> redundant and just wrong.

I don't think so.

> 
> Luckily, I don't think we need to even change anything because all
> directories that eventfs creates always grant exec permissions to the
> other group so lookup_one_len() will trivially succeed. IIUC.
> 
> Drafted-by-with-no-guarantees-whatsoever-that-this-wont-burn-the-house-down: Christian Brauner <brauner@kernel.org>

Checkout this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git eventfs-show-files

It creates a file "/sys/kernel/tracing/show_events_dentries" That shows
when inodes and dentries are created and freed.

I use this to make sure that reclaim actually does reclaim them. Linus
did not like this file, but it has become very useful to make sure
things are working properly as there is no other way to know if the
inodes and dentries are reclaimed or not. I may see if he'll let me add
it with a debug config option.

-- Steve

