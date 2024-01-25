Return-Path: <linux-fsdevel+bounces-8930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B429183C736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52C31C23270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491C745F9;
	Thu, 25 Jan 2024 15:48:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CC67318D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197705; cv=none; b=Yd/Ye2SM220wJC8Xo101pPC5K13JRzIIsR0raUkNB0CAzAowhbb7FgH5rkpifZpahUDum+k3We74hkyOpWF7/n5tsvE3JLYkb6fsLNMZ5mVzhcO0pyTdUYKHr/oubQT/dXM5AFkEMadJKIskEOdYlxyYMdr6BS0qWfY37BqVXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197705; c=relaxed/simple;
	bh=edmlbCnwdjXNTai0q8Q/CsCnPecIQM8AGjwjx97GrFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=L62h/t1I0e9nVYBXvJrIdFzN8qG2Ij+E31S2hc9afAeQFZUEAmbEjvXBGM5beg6dQn5HqI6X+o9MJs/G8mrCGz9mLD6Ez3bWOQF808d36c2b6yKxchR3RCOly803l8sTclqb3ZPmcWdAUMzip1bbatyNhe9ppRKX09YiN39sMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88709C433C7;
	Thu, 25 Jan 2024 15:48:22 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:48:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more like
 normal file systems
Message-ID: <20240125104822.04a5ad44@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


The tracefs file system was designed from the debugfs file system. The
rationale for separating tracefs from debugfs was to allow systems to
enable tracing but still keep debugfs disabled.

The debugfs API centers around dentry, e.g:


struct dentry *debugfs_create_file(const char *name, umode_t mode,
				   struct dentry *parent, void *data,
				   const struct file_operations *fops);

struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);

Where if you need to create a file in debugfs, you call the above
debugfs_create_file() code and it returns a dentry handle, that can be used
to delete that file later. If parent is NULL, it adds the file at the root
of the debugfs file system (/sys/kernel/debug), otherwise you could create
a directory within that file system with the debugfs_create_dir().

Behind the scenes, that dentry also has a created inode structure
representing it. This all happens regardless if debugfs is mounted or not!

As every trace event in the system is represented by a directory and
several files in tracefs's events directory, it created quite a lot of
dentries and inodes.

  # find /sys/kernel/tracing/ | wc -l
18352

And if you create an instance it will duplicate all the events in the
instance directory:

  # mkdir /sys/kernel/tracing/instances/foo
  # find /sys/kernel/tracing/ | wc -l
36617

And that goes for every new instance you make!

  # mkdir /sys/kernel/tracing/instances/bar
  # find /sys/kernel/tracing/ | wc -l
54882

As having inodes and dentries created for all these files and directories
even when they are not used, wastes a lot of memory.

Two years ago at LSF/MM I presented changing how the events directory works
via a new "eventfs" file system. It would still be part of tracefs, but it
would dynamically create the inodes and dentries on the fly.

As I was new to how VFS works, and really didn't understand it as well as I
would have liked, I just got something working and finally submitted it.
But because of my inexperience, Linus had some strong issues against the
code. Part of this was because I was touching dentries when he said I
shouldn't be. But that is because the code was designed from debugfs, which
dentry is the central part of that code.

When Linus said to me:

"And dammit, it shouldn't be necessary. When the tree is mounted, there
 should be no existing dentries."

(I'd share the link, but it was on the security list so there's no public
link for this conversation)

Linus's comment made me realize how debugfs was doing it wrong!

He was right, when a file system is mounted, it should not have any
dentries nor inodes. That's because dentry and inodes are basically "cache"
of the underlining file system. They should only be created when they are
referenced.

The debugfs and tracefs (and possibly other pseudo file systems) should not
be using dentry as a descriptor for the object. It should just create a
generic object that can save the fops, mode, parent, and data, and have the
dentries and inodes created when referenced just like any other file system
would.

Now that I have finished the eventfs file system, I would like to present a
proposal to make a more generic interface that the rest of tracefs and even
debugfs could use that wouldn't rely on dentry as the main handle.

-- Steve

