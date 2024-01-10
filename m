Return-Path: <linux-fsdevel+bounces-7700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108F8299CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 12:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26EFB24959
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F4495DC;
	Wed, 10 Jan 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLwF6iOZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D1481D8;
	Wed, 10 Jan 2024 11:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78416C433F1;
	Wed, 10 Jan 2024 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704887142;
	bh=S/z7kOMa1mLCKAIZYScj7foQYgH8MuVqxG2x+pBnoP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLwF6iOZda2QsR+0ay907aPfJdRVX5QxwmYrafJ9+0PYIJ1FI3C//dkfazc7/vPNL
	 Noh34eSo4ExG0Ouhx3UQK5+bmE905x2keBJknkaNG54jVzNc5l106Qg6zLFaYrgF++
	 szmT9ABw7aZvTLb5mJoUeHleB6h+KLznfB7Acev2waoOOsSU7hQOyKhBiHURFLffgj
	 dDIr2TKVfFLd3STepoJcISvHe2RtsswH0t8UGLSvdtaAoR+Tw82x32qpH+kzaaTfYu
	 Y4RUXBluJQuOO5mqa3JuJ76ZSmlNNyHJbiurKkngvZZpLRFctghK5Q8HeG+0jDbqsf
	 I0sEuutS3nsLg==
Date: Wed, 10 Jan 2024 12:45:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default
 ownership
Message-ID: <20240110-murren-extra-cd1241aae470@brauner>
References: <20240103203246.115732ec@gandalf.local.home>
 <20240105-wegstecken-sachkenntnis-6289842d6d01@brauner>
 <20240105095954.67de63c2@gandalf.local.home>
 <20240107-getrickst-angeeignet-049cea8cad13@brauner>
 <20240107132912.71b109d8@rorschach.local.home>
 <20240108-ortsrand-ziehen-4e9a9a58e708@brauner>
 <20240108102331.7de98cab@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108102331.7de98cab@gandalf.local.home>

On Mon, Jan 08, 2024 at 10:23:31AM -0500, Steven Rostedt wrote:
> On Mon, 8 Jan 2024 12:04:54 +0100
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > > > IOW, the inode_permission() in lookup_one_len() that eventfs does is
> > > > redundant and just wrong.  
> > > 
> > > I don't think so.  
> > 
> > I'm very well aware that the dentries and inode aren't created during
> > mkdir but the completely directory layout is determined. You're just
> > splicing in dentries and inodes during lookup and readdir.
> > 
> > If mkdir /sys/kernel/tracing/instances/foo has succeeded and you later
> > do a lookup/readdir on
> > 
> > ls -al /sys/kernel/tracing/instances/foo/events
> > 
> > Why should the creation of the dentries and inodes ever fail due to a
> > permission failure?
> 
> They shouldn't.
> 
> > The vfs did already verify that you had the required
> > permissions to list entries in that directory. Why should filling up
> > /sys/kernel/tracing/instances/foo/events ever fail then? It shouldn't
> > That tracefs instance would be half-functional. And again, right now
> > that inode_permission() check cannot even fail.
> 
> And it shouldn't. But without dentries and inodes, how does VFS know what
> is allowed to open the files?

So say you do:

mkdir /sys/kernel/tracing/instances/foo

After this has returned we know everything we need to know about the new
tracefs instance including the ownership and the mode of all inodes in
/sys/kernel/tracing/instances/foo/events/* and below precisely because
ownership is always inherited from the parent dentry and recorded in the
metadata struct eventfs_inode.

So say someone does:

open("/sys/kernel/tracing/instances/foo/events/xfs");

and say this is the first time that someone accesses that events/
directory.

When the open pathwalk is done, the vfs will determine via

[1] may_lookup(inode_of(events))

whether you are able to list entries such as "xfs" in that directory.
The vfs checks inode_permission(MAY_EXEC) on "events" and if that holds
it ends up calling i_op->eventfs_root_lookup(events).

At this point tracefs/eventfs adds the inodes for all entries in that
"events" directory including "xfs" based on the metadata it recorded
during the mkdir. Since now someone is actually interested in them. And
it initializes the inodes with ownership and everything and adds the
dentries that belong into that directory.

Nothing here depends on the permissions of the caller. The only
permission that mattered was done in the VFS in [1]. If the caller has
permissions to enter a directory they can lookup and list its contents.
And its contents where determined/fixed etc when mkdir was called.

So we just need to add the required objects into the caches (inode,
dentry) whose addition we intentionally defered until someone actually
needed them.

So, eventfs_root_lookup() now initializes the inodes with the ownership
from the stored metadata or from the parent dentry and splices in inodes
and dentries. No permission checking is needed for this because it is
always a recheck of what the vfs did in [1].

We now return to the vfs and path walk continues to the final component
that you actually want to open which is that "xfs" directory in this
example. We check the permissions on that inode via may_open("xfs") and
we open that directory returning an fd to userspace ultimately.

(I'm going by memory since I need to step out the door.)

