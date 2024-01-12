Return-Path: <linux-fsdevel+bounces-7873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4382C128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E51284F12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339A6D1BF;
	Fri, 12 Jan 2024 13:53:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52906BB40;
	Fri, 12 Jan 2024 13:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31075C433F1;
	Fri, 12 Jan 2024 13:53:46 +0000 (UTC)
Date: Fri, 12 Jan 2024 08:53:44 -0500
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
Message-ID: <20240112085344.30540d10@rorschach.local.home>
In-Reply-To: <20240112-normierung-knipsen-dccb7cac7efc@brauner>
References: <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
	<20240110080746.50f7767d@gandalf.local.home>
	<20240111-unzahl-gefegt-433acb8a841d@brauner>
	<20240111165319.4bb2af76@gandalf.local.home>
	<20240112-normierung-knipsen-dccb7cac7efc@brauner>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 09:27:24 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Thu, Jan 11, 2024 at 04:53:19PM -0500, Steven Rostedt wrote:
> > On Thu, 11 Jan 2024 22:01:32 +0100
> > Christian Brauner <brauner@kernel.org> wrote:
> >   
> > > What I'm pointing out in the current logic is that the caller is
> > > taxed twice:
> > > 
> > > (1) Once when the VFS has done inode_permission(MAY_EXEC, "xfs")
> > > (2) And again when you call lookup_one_len() in eventfs_start_creating()
> > >     _because_ the permission check in lookup_one_len() is the exact
> > >     same permission check again that the vfs has done
> > >     inode_permission(MAY_EXEC, "xfs").  
> > 
> > As I described in: https://lore.kernel.org/all/20240110133154.6e18feb9@gandalf.local.home/
> > 
> > The eventfs files below "events" doesn't need the .permissions callback at
> > all. It's only there because the "events" inode uses it.
> > 
> > The .permissions call for eventfs has:  
> 
> It doesn't matter whether there's a ->permission handler. If you don't
> add one explicitly the VFS will simply call generic_permission():
> 
> inode_permission()
> -> do_inode_permission()  
>    {
>         if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
>                 if (likely(inode->i_op->permission))
>                         return inode->i_op->permission(idmap, inode, mask);
>                
>                 /* This gets set once for the inode lifetime */
>                 spin_lock(&inode->i_lock);
>                 inode->i_opflags |= IOP_FASTPERM;
>                 spin_unlock(&inode->i_lock);
>         }
>         return generic_permission(idmap, inode, mask);
>    }

Yes I know that, because that's where I knew what to call in the non
"events" dir case.

> 
> > Anyway, the issue is with "events" directory and remounting, because like
> > the tracefs system, the inode and dentry for "evnets" is created at boot
> > up, before the mount happens. The VFS layer is going to check the
> > permissions of its inode and dentry, which will be incorrect if the mount
> > was mounted with a "gid" option.  
> 
> The gid option has nothing to do with this and it is just handled fine
> if you remove the second permission checking in (2).

I guess I'm confused to what you are having an issue with. Is it just
that the permission check gets called twice?

> 
> You need to remove the inode_permission() code from
> eventfs_start_creating(). It is just an internal lookup and the fact
> that you have it in there allows userspace to break readdir on the
> eventfs portions of tracefs as I've shown in the parts of the mail that
> you cut off.

That's because I didn't see how it was related to the way I fixed the
mount=gid issue. Are you only concerned because of the check in
eventfs_start_creating()?

Yes, you posted code that would make things act funny for some code
that I see no real world use case for. Yeah, it may not act "properly"
but I'm not sure that's bad.

Here, I'll paste it back:

> // We managed to open the directory so we have permission to list
> // directory entries in "xfs".
> fd = open("/sys/kernel/tracing/events/xfs");
> 
> // Remove ownership so we can't open the directory anymore
> chown("/sys/kernel/tracing/events/xfs", 0, 0);
> 
> // Or just remove exec bit for the group and restrict to owner
> chmod("/sys/kernel/tracing/events/xfs", 700);
> 
> // Drop caches to force an eventfs_root_lookup() on everything
> write("/proc/sys/vm/drop_caches", "3", 1);

This requires opening the directory, then having it's permissions
change, and then immediately dropping the caches.

> 
> // Returns 0 even though directory has a lot of entries and we should be
> // able to list them
> getdents64(fd, ...);

And do we care?

Since tracing exposes internal kernel information, perhaps this is a
feature and not a bug. If someone who had access to the tracing system
and you wanted to stop them, if they had a directory open that they no
longer have access to, you don't want them to see what's left in the
directory.

In other words, I like the idea that the getends64(fd, ...) will fail!

If there's a file underneath that wasn't change, and the admin thought
that just keeping the top directory permissions off is good enough,
then that attacker having that directory open before the directory had
it's file permissions change is a way to still have access to the files
below it.

> 
> And the failure is in the inode_permission(MAY_EXEC, "xfs") call in
> lookup_one_len() in eventfs_start_creating() which now fails.

And I think is a good thing!

Again, tracefs is special. It gives you access and possibly control to
the kernel behavior. I like the fact that as soon as someone loses
permission to a directory, they immediately lose it.

-- Steve

