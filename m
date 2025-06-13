Return-Path: <linux-fsdevel+bounces-51556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44CAD840C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2EC3A11ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACD2D0281;
	Fri, 13 Jun 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QJmw1VTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA571EA7E1;
	Fri, 13 Jun 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799915; cv=none; b=WHHPu6ypY2KCoadTBSxaFb1uSegOaM/4T2NnO5/Z2ZKpmzc0qRYRdyxvkIvfnDaqWUWUpLWtBx6fAcgE4yVRWQgeW/+wRIIQqVKEhQiz5I6rWerfgDMUQ8sNYNzEEhuGHEv0Lmfjw4+vgSo6nOx+5a0QkBTqOXfULJX0yWENEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799915; c=relaxed/simple;
	bh=GzKxWjCbzXGZFRM6egvc1eGv4hbD3GAhqg6vYhCfqrI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hp0tqgZldX809F/X7ydLwY4Zchykmz0cgqCyELuJsj6oOElbpUq6bsPVnXMXQWAWFWwlUSmfEoaArFJE7ieWotGfTnQzlSAfi3uOUztxinvKSYTTQgQMPe39+eNsmOKxxTkWrNdLuoJgAyQqR9FZhzyo1/jckJkQSNUW22foAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QJmw1VTm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gm+0SjHSOubanfeMozJ3pIfD9ZwZMHSPBLOLvRFPKUs=; b=QJmw1VTmQcUZsKhqf9iFIfC3ae
	B/TDdLoztcFAqxc0doGRjCoHJo4Kjb1gypf+BAS0BZWL/FLrQ/CGAC0uvqxHuzoKf3uIo3mAOA0cs
	jrWNf0UpkBVAYVHrkmA0d0m0j1B5EgmMVfJOjKNftPT/oUPH5J0rMY+rmJOndW2sc4AfFyXQYXm79
	KKjyHv3N2luqc6WRtpAYIWR0L9+EOD+/1AJ3ww0C4QBwoYz6KD1c1qHJxJrD0irsdcYBJzNRE9/8n
	PA3J+CjYkHncibQU/CuTRrnYsuQ9+BeQ1DZQjMTONcCxODEa7yLpq27txJKX/Tt8W4WvlF+qo95PN
	oUyPQeEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPytB-00000007pAr-11Tq;
	Fri, 13 Jun 2025 07:31:49 +0000
Date: Fri, 13 Jun 2025 08:31:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCHES][RFC][CFT] rpc_pipefs cleanups
Message-ID: <20250613073149.GI1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Another series pulled out of tree-in-dcache pile; it massages
rpc_pipefs to use saner primitives.  Lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.rpc_pipe
6.16-rc1-based, 17 commits, -314 lines of code...

Individual patches in followups.

Folks, please test and review.  In various forms this has sat in my tree
for more than a year and I'd rather get that logjam dealt with.

Overview:

	Prep/infrastructure (#1 is shared with #work.simple_recursive_removal)

1) simple_recursive_removal(): saner interaction with fsnotify
	fsnotify events are triggered before the callback, unlike in real
unlink(2)/rmdir(2) syscalls.  Obviously matters only in case when callback
is non-empty, which excludes most of the current users in the kernel.

2) new helper: simple_start_creating()
	Set the things up for kernel-initiated creation of object in a
tree-in-dcache filesystem.  With respect to locking it's an equivalent of
filename_create() - we either get a negative dentry with locked parent,
or ERR_PTR() and no locks taken.
	tracefs and debugfs had that open-coded as part of their object
creation machinery; switched to calling new helper.

      rpc_pipefs proper:

3) rpc_pipe: clean failure exits in fill_super
	->kill_sb() will be called immediately after a failure
return anyway, so we don't need to bother with notifier chain and
rpc_gssd_dummy_depopulate().  What's more, rpc_gssd_dummy_populate()
failure exits do not need to bother with __rpc_depopulate() - anything
added to the tree will be taken out by ->kill_sb().

4) rpc_{rmdir_,}depopulate(): use simple_recursive_removal() instead
	no need to give an exact list of objects to be remove when it's
simply every child of the victim directory.

5) rpc_unlink(): use simple_recursive_removal()
	Previous commit was dealing with directories; this one is for
named pipes (i.e. the thing rpc_pipefs is used for).  Note that the
callback of simple_recursive_removal() is called with the parent locked;
the victim isn't locked by the caller.

6) rpc_populate(): lift cleanup into callers
	rpc_populate() is called either from fill_super (where we
don't need to remove any files on failure - rpc_kill_sb() will take
them all out anyway) or from rpc_mkdir_populate(), where we need to
remove the directory we'd been trying to populate along with whatever
we'd put into it before we failed.  Simpler to combine that into
simple_recursive_removal() there.

7) rpc_unlink(): saner calling conventions
	* pass it pipe instead of pipe->dentry
	* zero pipe->dentry afterwards
	* it always returns 0; why bother?
	
8) rpc_mkpipe_dentry(): saner calling conventions
	Instead of returning a dentry or ERR_PTR(-E...), return 0 and
store dentry into pipe->dentry on success and return -E... on failure.
Callers are happier that way...

9) rpc_pipe: don't overdo directory locking
	Don't try to hold directories locked more than VFS requires;
lock just before getting a child to be made positive (using
simple_start_creating()) and unlock as soon as the child is created.
There's no benefit in keeping the parent locked while populating the
child - it won't stop dcache lookups anyway.

10) rpc_pipe: saner primitive for creating subdirectories
	All users of __rpc_mkdir() have the same form - start_creating(),
followed, in case of success, by __rpc_mkdir() and unlocking parent.
Combine that into a single helper, expanding __rpc_mkdir() into it, along
with the call of __rpc_create_common() in it.
	Don't mess with d_drop() + d_add() - just d_instantiate()
and be done with that.	The reason __rpc_create_common() goes for that
dance is that dentry it gets might or might not be hashed; here we know
it's hashed.

11) rpc_pipe: saner primitive for creating regular files
	rpc_new_file(); similar to rpc_new_dir(), except that here we
pass file_operations as well.  Callers don't care about dentry, just
return 0 or -E...

12) rpc_mkpipe_dentry(): switch to start_creating()
	... and make sure we set the rpc_pipe-private part of inode up
before attaching it to dentry.

13) rpc_gssd_dummy_populate(): don't bother with rpc_populate()
	Just have it create gssd (in root), clntXX in gssd, then info
and gssd in clntXX - all with explicit
rpc_new_dir()/rpc_new_file()/rpc_mkpipe_dentry().

14) rpc_pipe: expand the calls of rpc_mkdir_populate()
	... and get rid of convoluted callbacks.

15) rpc_new_dir(): the last argument is always NULL
	All callers except the one in rpc_populate() pass explicit NULL
there; rpc_populate() passes its last argument ('private') instead,
but in the only call of rpc_populate() that creates any subdirectories
(when creating fixed subdirectories of root) private itself is NULL.

16) rpc_create_client_dir(): don't bother with rpc_populate()
	not for a single file...

17) rpc_create_client_dir(): return 0 or -E...
	Callers couldn't care less which dentry did we get - anything
valid is treated as success.

