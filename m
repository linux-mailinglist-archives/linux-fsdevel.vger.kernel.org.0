Return-Path: <linux-fsdevel+bounces-40264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107C9A214F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D723A6F94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79BB1DF271;
	Tue, 28 Jan 2025 23:29:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A9194A7C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738106979; cv=none; b=ZOAQoGiHeEJ2ufEOtWoJ6UoNnDX9UHDop63W+swO+pIFBxbK49h1psVOTEzYbMY94wQZGRnl4PiTT913R4p8O8BfZjhbLwcd4SMWfLuCEHM9z2Ad9xVNJc2CWckKumD4bKZy/ChbXoSYLa/7Xnxu4RSY27tFqqsGxweqzcXLf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738106979; c=relaxed/simple;
	bh=ll0jNhp00l+TKZe+mwgKVKUa7FztF0/4Q9eqyrnEZxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5HirVdesDKTJeGQeFwGYH1bad5oO9S61Ap+iZey3Ye5J2eUqdMjG5miuCTsWgfRBywjVXbr6ADZ0ge4WS/gCulvQc3rjzqEajxcVkPvsZzLj0Nprg4LAy2tm0v/wmSFNGbfkStB8rwAdDx07vjVHni83RplEpJLzWN/aFPbis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C671C4CED3;
	Tue, 28 Jan 2025 23:29:37 +0000 (UTC)
Date: Tue, 28 Jan 2025 18:29:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig
 <hch@infradead.org>, David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, Al
 Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, James
 Bottomley <James.Bottomley@hansenpartnership.com>, Krister Johansen
 <kjlx@templeofstupid.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] samples/kernfs: Add a pseudo-filesystem to
 demonstrate kernfs usage
Message-ID: <20250128182957.55153dfc@gandalf.local.home>
In-Reply-To: <Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
References: <20250121153646.37895-1-me@davidreaver.com>
	<Z5h0Xf-6s_7AH8tf@infradead.org>
	<20250128102744.1b94a789@gandalf.local.home>
	<CAHk-=wjEK-Ymmw8KYA_tENpDr_RstYxbXH=akjiUwxhkUzNx0Q@mail.gmail.com>
	<20250128174257.1e20c80f@gandalf.local.home>
	<Z5lfg4jjRJ2H0WTm@slm.duckdns.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:51:47 -1000
Tejun Heo <tj@kernel.org> wrote:

> Just for context, kernfs is factored out from sysfs. One of the factors
> which drove the design was memory overhead. On large systems (IIRC
> especially with iSCSI), there can be a huge number of sysfs nodes and
> allocating a dentry and inode pair for each file made some machines run out
> of memory during boot, so sysfs implemented memory-backed filesystem store
> which then made its interface to its users to depart from the VFS layer.
> This requirement holds for cgroup too - there are systems with a *lot* of
> cgroups and the associated interface files and we don't want to pin a dentry
> and inode for all of them.
> 

Right. And going back to ramfs, it too has a dentry and inode for every
file that is created. Thus, if you have a lot of files, you'll have a lot
of memory dedicated to their dentry and inodes that will never be freed.
The ramfs_create() and ramfs_mkdir() both call ramfs_mknod() which does a
d_instantiate() and a dget() on the dentry so they are persistent until
they are deleted or a reboot happens.

What I did for eventfs, and what I believe kernfs does, is to create a
small descriptor to represent the control data and reference them like what
you would have on disk. That is, the control elements (like an trace event
descriptor) is really what is on "disk". When someone does an "ls" to the
pseudo file system, there needs to be a way for the VFS layer to query the
control structures like how a normal file system would query that data
stored on disk, and then let the VFS layer create the dentry and inodes
when referenced, and more importantly, free them when they are no longer
referenced and there's memory pressure.

I believe kernfs does the same thing. And my point is, it would be nice to
have an abstract layer that represent control descriptors that may be
around for the entirety of the boot (like trace events are) without needing
to pin a dentry and inode for each one of theses files. Currently, that
abstract layer is kernfs.

-- Steve

