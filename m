Return-Path: <linux-fsdevel+bounces-7706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D9829AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DD91C218B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615F487A1;
	Wed, 10 Jan 2024 13:06:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4ED48788;
	Wed, 10 Jan 2024 13:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA7C433C7;
	Wed, 10 Jan 2024 13:06:46 +0000 (UTC)
Date: Wed, 10 Jan 2024 08:07:46 -0500
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
Message-ID: <20240110080746.50f7767d@gandalf.local.home>
In-Reply-To: <20240110-murren-extra-cd1241aae470@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
	<20240108102331.7de98cab@gandalf.local.home>
	<20240110-murren-extra-cd1241aae470@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 12:45:36 +0100
Christian Brauner <brauner@kernel.org> wrote:

> So say you do:
> 
> mkdir /sys/kernel/tracing/instances/foo
> 
> After this has returned we know everything we need to know about the new
> tracefs instance including the ownership and the mode of all inodes in
> /sys/kernel/tracing/instances/foo/events/* and below precisely because
> ownership is always inherited from the parent dentry and recorded in the
> metadata struct eventfs_inode.
> 
> So say someone does:
> 
> open("/sys/kernel/tracing/instances/foo/events/xfs");
> 
> and say this is the first time that someone accesses that events/
> directory.
> 
> When the open pathwalk is done, the vfs will determine via
> 
> [1] may_lookup(inode_of(events))
> 
> whether you are able to list entries such as "xfs" in that directory.
> The vfs checks inode_permission(MAY_EXEC) on "events" and if that holds
> it ends up calling i_op->eventfs_root_lookup(events).
> 
> At this point tracefs/eventfs adds the inodes for all entries in that
> "events" directory including "xfs" based on the metadata it recorded
> during the mkdir. Since now someone is actually interested in them. And
> it initializes the inodes with ownership and everything and adds the
> dentries that belong into that directory.
> 
> Nothing here depends on the permissions of the caller. The only
> permission that mattered was done in the VFS in [1]. If the caller has
> permissions to enter a directory they can lookup and list its contents.
> And its contents where determined/fixed etc when mkdir was called.
> 
> So we just need to add the required objects into the caches (inode,
> dentry) whose addition we intentionally defered until someone actually
> needed them.
> 
> So, eventfs_root_lookup() now initializes the inodes with the ownership
> from the stored metadata or from the parent dentry and splices in inodes
> and dentries. No permission checking is needed for this because it is
> always a recheck of what the vfs did in [1].
> 
> We now return to the vfs and path walk continues to the final component
> that you actually want to open which is that "xfs" directory in this
> example. We check the permissions on that inode via may_open("xfs") and
> we open that directory returning an fd to userspace ultimately.
> 
> (I'm going by memory since I need to step out the door.)

So, let's say we do:

 chgrp -R rostedt /sys/kernel/tracing/

But I don't want rostedt to have access to xfs

 chgrp -R root /sys/kernel/tracing/events/xfs

Both actions will create the inodes and dentries of all files and
directories (because of "-R"). But once that is done, the ref counts go to
zero. They stay around until reclaim. But then I open Chrome ;-) and it
reclaims all the dentries and inodes, so we are back to here we were on
boot.

Now as rostedt I do:

 ls /sys/kernel/tracing/events/xfs

The VFS layer doesn't know if I have permission to that or not, because all
the inodes and dentries have been freed. It has to call back to eventfs to
find out. Which the eventfs_root_lookup() and eventfs_iterate_shared() will
recreated the inodes with the proper permission.

Or are you saying that I don't need the ".permission" callback, because
eventfs does it when it creates the inodes? But for eventfs to know what
the permissions changes are, it uses .getattr and .setattr.

-- Steve

