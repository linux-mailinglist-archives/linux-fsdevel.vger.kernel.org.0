Return-Path: <linux-fsdevel+bounces-9648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9898440B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2231C2A5E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8DC80BEF;
	Wed, 31 Jan 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R12DiuRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0280BE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708219; cv=none; b=nn5JG7FK69A2NLefA+3vPfEL+etOXPWgj8dCn29fexuMkSPeelFWIi4MI8pAtfv6rYr0W6lloh6ICBkajJOOivHGRo3bMJLf020RyaNZM/jVNKAQ9vsCxNIvLINxb38zfg7u0zDZOog6rOBwLiaztk82x7B69/Hh9NyfekV/HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708219; c=relaxed/simple;
	bh=sM4Z5/1kK7oFj99UnAH/d8SuEqsD0qqiEHgeK0ptMJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cOZt5t3R3zNT1B38Pe9DgQwnJbctXTzu3PpFI6rUA5YxXU+bl/vTEi43DnR13L9jokd3pNMka87UvWUF/C4wD9K+PLKF/47c8ZLMisWUojSQO1L6zWyGWt44x18cYkO3VKdi19ccLNH/CDo7WuqhFX3NB3o4NNxlNTNSzAtF7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R12DiuRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8935C433C7;
	Wed, 31 Jan 2024 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708218;
	bh=sM4Z5/1kK7oFj99UnAH/d8SuEqsD0qqiEHgeK0ptMJg=;
	h=From:Subject:Date:To:Cc:From;
	b=R12DiuRs/5rSHkXtDBIFZtVxI0ky1q6x3kiYin+tH8LTSl3XtMEMgERlC0fTkixsn
	 YKrfDJfCuon8Kuc9iyG9I5Ky6ESPJ7KTZOv/uwPmplFJcDhECoZJcs5ZtbNWu6ypb/
	 Qmw50KIJdUv7lUK8ViBVGOXWgn/x2tTLnTCzlmARaQBXLFwA3tlB7A+pph1jTzpJ7m
	 9yml3+xtU64EtEu/sCUuZN7XIHY7beMtNs4v7F/3+FH+iztyaodKdS+UkRPBce8ID9
	 Kc54ZaC2ADIMDz+oNJ0hBxrMM9iIr3mRKS6LFaijBNh0kUBhQJVkc9cT4cHCaHGVqe
	 Z8zBp+LcZnGpw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH DRAFT 0/4] : Port tracefs to kernfs
Date: Wed, 31 Jan 2024 14:36:37 +0100
Message-Id: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVMumUC/x3MwQrCQAyE4VcpObvQbMWDryIesttZG8RVkiJC6
 bsbPQ3fYf6NHKZwOg8bGd7q+uwBPgxUF+k3JJ3DlMd8HHnitJpUNE93WI+ZWp7RTpDCTHF6GZp
 +/sHLNVzEkYpJr8sv8xBfYbTvX4c837d5AAAA
To: Steven Rostedt <rostedt@goodmis.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=6323; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sM4Z5/1kK7oFj99UnAH/d8SuEqsD0qqiEHgeK0ptMJg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8vk+b6bjsq3dMQcD3dnMeWakLfa9HKC/yFri/NTjn
 wtNUvl6OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSfJqRYZ3c7bqj142rJ9xN
 DaiMnPt502fF916L9Ld/OmTskxW0g4fhn+Ger2IBn+7pswU+E1AQsg4MEt9ruvPy9cuz3BhZMhg
 vMwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Back in 2022 we already had a session at LSFMM where we talked about
eventfs and we said that it should be based on kernfs and any missing
functionality be implemented in kernfs. Instead we've gotten a
hand-rolled version of similar functionality and 100+ mails exchanges
over the last weeks to fix bugs in there binding people's time.

All we've heard so far were either claims that it would be too difficult
to port tracefs to kernfs or that it somehow wouldn't work but we've
never heard why and it's never been demonstrated why.

So I went and started a draft for porting all of tracefs to kernfs in
the hopes that someone picks this up and finishes the work. I've gotten
the core of it done and it's pretty easy to do logical copy-pasta to
port this to eventfs as well.

I want to see tracefs and eventfs ported to kernfs and get rid of the
hand-rolled implementation. I don't see the value in any additional
talks about why eventfs is special until we've seen an implementation of
tracefs on kernfs.

I'm pretty certain that we have capable people that can and want to
finish the port (I frankly don't have time for this unless I drop all
reviews.). I've started just jotting down the basics yesterday evening
and came to the conclusion that:

* It'll get rid of pointless dentry pinning in various places that is
  currently done in the first place. Instead only a kernfs root and a
  kernfs node need to be stashed. Dentries and inodes are added
  on-demand.

* It'll make _all of_ tracefs capable of on-demand dentry and inode
  creation.

* Quoting [1]:

  > The biggest savings in eventfs is the fact that it has no meta data for
  > files. All the directories in eventfs has a fixed number of files when they
  > are created. The creating of a directory passes in an array that has a list
  > of names and callbacks to call when the file needs to be accessed. Note,
  > this array is static for all events. That is, there's one array for all
  > event files, and one array for all event systems, they are not allocated per
  > directory.

  This is all possible with kernfs.

* All ownership information (mode, uid, gid) is stashed and kept
  kernfs_node->iattrs. So the parent kernfs_node's ownership can be used
  to set the child's ownership information. This will allow to get rid
  of any custom permission checking and ->getattr() and ->setattr()
  calls.

* Private tracefs data that was stashed in inode->i_private is stashed
  in kernfs_node->priv. That's always accessible in kernfs->open() calls
  via kernfs_open_file->kn->priv but it could also be transferred to
  kernfs_open_file->priv. In any case, it makes it a lot easier to
  handle private data than tracefs does it now.

* It'll make maintenance of tracefs easier in the long run because new
  functionality and improvements get added to kernfs including better
  integration with namespaces (I've had patchsets for kernfs a while ago
  to unlock additional namespaces.)

* There's no need for separate i_ops for "instances" and regular tracefs
  directories. Simply compare the stashed kernfs_node of the "instances"
  directory against the current kernfs_node passed to ->mkdir() or
  ->rmdir() whether the directory creation or deletion is allowed.

* Frankly, another big reason to do it is simply maintenance. All of the
  maintenance burden neeeds to be shifted to the generic kernfs
  implementation which is maintained by people familar with filesystem
  details. I'm willing to support it too.

  No shade, but currently I don't see how eventfs can be maintained
  without the involvement of others. Maintainability alone should be a
  sufficient reason to move all of this to kernfs and add any missing
  functionality.

* If we have a session about this at LSFMM and I want to see a POC of
  tracefs and eventfs built on top of kernfs. I'm tired of talking about
  a private implementation of functionality that already exists.
  Otherwise, this is just wasting everyone's time and eventfs as it is
  will not become common infrastructure.

* Yes, debugfs could or should be ported as well but it's almost
  irrelevant for debugfs. It's a debugging filesystem. If you enable it
  on a production workload then you have bigger problems to worry about
  than wasted memory. So I don't consider that urgent. But tracefs is
  causing us headaches right now and I'm weary of cementing a
  hand-rolled implementation.

So really, please let's move this to kernfs, fix any things that aren't
supported in kernfs (I haven't seen any) and get rid of all the custom
functionality. Part of the work is moving tracefs to the new mount api
(which should've been done anyway).

The fs/tracefs/ part already compiles. The rest I haven't finished
converting. All the file_operations need to be moved to kernfs_ops which
shouldn't be too difficult.

To: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
To: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org,
Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>

Link: https://lore.kernel.org/r/20240129105726.2c2f77f0@gandalf.local.home [1]
Link: https://lore.kernel.org/r/20240129105726.2c2f77f0@gandalf.local.home
---
Christian Brauner (4):
      [DRAFT]: tracefs: port to kernfs
      [DRAFT]: trace: stash kernfs_node instead of dentries
      [DRAFT]: hwlat: port struct file_operations thread_mode_fops to struct kernfs_ops
      [DRAFT]: trace: illustrate how to convert basic open functions

 fs/kernfs/mount.c                 |  10 +
 fs/tracefs/inode.c                | 649 +++++++++++++-------------------------
 include/linux/kernfs.h            |   3 +
 include/linux/tracefs.h           |  18 +-
 kernel/trace/trace.c              |  22 +-
 kernel/trace/trace.h              |   4 +-
 kernel/trace/trace_events_synth.c |   4 +-
 kernel/trace/trace_events_user.c  |   2 +-
 kernel/trace/trace_hwlat.c        |  45 +--
 9 files changed, 270 insertions(+), 487 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240131-tracefs-kernfs-3f2def6eab11


