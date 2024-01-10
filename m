Return-Path: <linux-fsdevel+bounces-7737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056E82A046
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0A028863D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A94B5A6;
	Wed, 10 Jan 2024 18:30:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A114D5A8;
	Wed, 10 Jan 2024 18:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE05C433C7;
	Wed, 10 Jan 2024 18:30:54 +0000 (UTC)
Date: Wed, 10 Jan 2024 13:31:54 -0500
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
Message-ID: <20240110133154.6e18feb9@gandalf.local.home>
In-Reply-To: <20240110105251.48334598@gandalf.local.home>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
	<20240110080746.50f7767d@gandalf.local.home>
	<20240110105251.48334598@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 10:52:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 10 Jan 2024 08:07:46 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Or are you saying that I don't need the ".permission" callback, because
> > eventfs does it when it creates the inodes? But for eventfs to know what
> > the permissions changes are, it uses .getattr and .setattr.  
> 
> OK, if your main argument is that we do not need .permission, I agree with
> you. But that's a trivial change and doesn't affect the complexity that
> eventfs is doing. In fact, removing the "permission" check is simply this
> patch:
> 
> --
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index fdff53d5a1f8..f2af07a857e2 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -192,18 +192,10 @@ static int eventfs_get_attr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> -static int eventfs_permission(struct mnt_idmap *idmap,
> -			      struct inode *inode, int mask)
> -{
> -	set_top_events_ownership(inode);
> -	return generic_permission(idmap, inode, mask);
> -}
> -
>  static const struct inode_operations eventfs_root_dir_inode_operations = {
>  	.lookup		= eventfs_root_lookup,
>  	.setattr	= eventfs_set_attr,
>  	.getattr	= eventfs_get_attr,
> -	.permission	= eventfs_permission,
>  };
>  
>  static const struct inode_operations eventfs_file_inode_operations = {
> --
> 
> I only did that because Linus mentioned it, and I thought it was needed.
> I'll apply this patch too, as it appears to work with this code.

Oh, eventfs files and directories don't need the .permissions because its
inodes and dentries are not created until accessed. But the "events"
directory itself has its dentry and inode created at boot up, but still
uses the eventfs_root_dir_inode_operations. So the .permissions is still
needed!

If you look at the "set_top_events_ownership()" function, it has:

	/* The top events directory doesn't get automatically updated */
	if (!ei || !ei->is_events || !(ei->attr.mode & EVENTFS_TOPLEVEL))
		return;

That is, it does nothing if the entry is not the "events" directory. It
falls back to he default "->permissions()" function for everything but the
top level "events" directory.

But this and .getattr are still needed for the events directory, because it
suffers the same issue as the other tracefs entries. That is, it's inodes
and dentries are created at boot up before it is mounted. So if the mount
has gid=1000, it will be ignored.

The .getattr is called by "stat" which ls does. So after boot up if you
just do:

 # chmod 0750 /sys/kernel/events
 # chmod 0770 /sys/kernel/tracing
 # mount -o remount,gid=1000 /sys/kernel/tracing
 # su - rostedt
 $ id
uid=1000(rostedt) gid=1000(rostedt) groups=1000(rostedt)
 $ ls /sys/kernel/tracing/events/
9p            ext4            iomap        module      raw_syscalls  thermal
alarmtimer    fib             iommu        msr         rcu           thp
avc           fib6            io_uring     napi        regmap        timer
block         filelock        ipi          neigh       regulator     tlb
bpf_test_run  filemap         irq          net         resctrl       udp
bpf_trace     ftrace          irq_matrix   netfs       rpm           virtio_gpu[
...]

The above works because "ls" does a stat() on the directory first, which
does a .getattr() call that updates the permissions of the existing "events"
directory inode.

  BUT!

If I had used my own getents() program that has:

        fd = openat(AT_FDCWD, argv[1], O_RDONLY);
        if (fd < 0)
                perror("openat");

        n = getdents64(fd, buf, BUF_SIZE);
        if (n < 0)
                perror("getdents64");

Where it calls the openat() without doing a stat fist, and after boot, had done:

 # chmod 0750 /sys/kernel/events
 # chmod 0770 /sys/kernel/tracing
 # mount -o remount,gid=1000 /sys/kernel/tracing
 # su - rostedt
 $ id
uid=1000(rostedt) gid=1000(rostedt) groups=1000(rostedt)
 $ ./getdents /sys/kernel/tracing/events
openat: Permission denied
getdents64: Bad file descriptor

It errors because he "events" inode permission hasn't been updated yet.
Now after getting the above error, if I do the "ls" and then run it again:

 $ ls /sys/kernel/tracing/events > /dev/null
 $ ./getdents /sys/kernel/tracing/events
enable
header_page
header_event
initcall
vsyscall
syscalls

it works!

so no, I can't remove that .permissions callback from eventfs.

-- Steve

