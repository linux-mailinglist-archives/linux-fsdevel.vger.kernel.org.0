Return-Path: <linux-fsdevel+bounces-7555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF98273FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AED92850B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B9752F99;
	Mon,  8 Jan 2024 15:40:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518085380B;
	Mon,  8 Jan 2024 15:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE0C433C7;
	Mon,  8 Jan 2024 15:40:51 +0000 (UTC)
Date: Mon, 8 Jan 2024 10:41:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <keescook@chromium.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as
 default ownership
Message-ID: <20240108104147.49baa4cb@gandalf.local.home>
In-Reply-To: <20240108-natur-geophysik-f4c6fdaf6901@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
	<20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
	<20240105095954.67de63c2@gandalf.local.home>
	<20240107-getrickst-angeeignet-049cea8cad13@brauner>
	<20240107132912.71b109d8@rorschach.local.home>
	<20240107133228.05b0f485@rorschach.local.home>
	<20240108-natur-geophysik-f4c6fdaf6901@brauner>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 12:32:46 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Sun, Jan 07, 2024 at 01:32:28PM -0500, Steven Rostedt wrote:
> > On Sun, 7 Jan 2024 13:29:12 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > > 
> > > > IOW, the inode_permission() in lookup_one_len() that eventfs does is
> > > > redundant and just wrong.    
> > > 
> > > I don't think so.  
> > 
> > Just to make it clear. eventfs has nothing to do with mkdir instance/foo.
> > It exists without that. Although one rationale to do eventfs was so  
> 
> Every instance/foo/ tracefs instances also contains an events directory
> and thus a eventfs portion. Eventfs is just a subtree of tracefs. It's
> not a separate filesystem. Both eventfs and tracefs are on the same
> single, system wide superblock.
> 
> > that the instance directories wouldn't recreate the same 10thousands
> > event inodes and dentries for every mkdir done.  
> 
> I know but that's irrelevant to what I'm trying to tell you.
> 
> A mkdir /sys/kernel/tracing/instances/foo creates a new tracefs
> instance. With or without the on-demand dentry and inode creation for
> the eventfs portion that tracefs "instance" has now been created in its
> entirety including all the required information for someone to later
> come along and perform a lookup on /sys/kernel/tracing/instances/foo/events.
> 
> All you've done is to defer the addition of the dentries and inodes when
> someone does actually look at the events directory of the tracefs
> instance.
> 
> Whether you choose to splice in the dentries and inodes for the eventfs
> portion during lookup and readdir or if you had chosen to not do the
> on-demand thing at all and the entries were created at the same time as
> the mkdir call are equivalent from the perspective of permission
> checking.
> 
> If you have the required permissions to look at the events directory
> then there's no reason why listing the directory entries in there should
> fail. This can't even happen right now.

Ah, I think I know where the confusion lies. The tracing information in
kernel/trace/*.c doesn't keep track of permission. It relies totally on
fs/tracefs/* to do so. If someone does 'chmod' or 'chown' or mounts with
'gid=xxx' then it's up to tracefs to maintain that information and not the
tracing subsystem. The tracing subsystem only gives the "default"
permissions (before boot finishes).

The difference between normal file systems and pseudo file systems like
debugfs and tracefs, is that normal file systems keep the permission
information stored on the external device. That is, when the inodes and
dentries are created, the information is retrieved from the stored file
system.

I think this may actually be a failure of debugfs (and tracefs as it was
based on debugfs), in that the inodes and dentries are created at the same
time the "files" backing them are. Which is normally at boot up and before
the file system is mounted.

That is, inodes and dentries are actually coupled with the data they
represent. It's not a cache for a back store like a hard drive partition.

To create a file in debugfs you do:

struct dentry *debugfs_create_file(const char *name, umode_t mode,
				   struct dentry *parent, void *data,
				   const struct file_operations *fops)

That is, you pass a the name, the mode, the parent dentry, data, and the
fops and that will create an inode and dentry (which is returned).

This happens at boot up before user space is running and before debugfs is
even mounted.

Because debugfs is mostly for debugging, people don't care about how it's
mounted. It is usually restricted to root only access. Especially since
there's a lot of sensitive information that shouldn't be exposed to
non-privileged users.

The reason tracefs came about is that people asked me to be able to have
access to tracing without needing to even enable debugfs. They also want to
easily make it accessible to non root users and talking with Kees Cook, he
recommended using ACL. But because it inherited a lot from debugfs, I
started doing these tricks like walking the dentry tree to make it work a
bit better. Because the dentries and inodes were created before mount, I
had to play these tricks.

But as Linus pointed out, that was the wrong way to do that. The right way
was to use .getattr and .permission callbacks to figure out what the
permissions to the files are.

This has nothing to do with the creation of the files, it's about who has
access to the files that the inodes point to.

This sounds like another topic to bring up at LSFMM ;-)  "Can we
standardize pseudo file systems like debugfs and tracefs to act more like
real file systems, and have inodes and dentries act as cache and not be so
coupled to the data?"

-- Steve

