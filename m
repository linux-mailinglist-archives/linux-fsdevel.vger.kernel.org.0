Return-Path: <linux-fsdevel+bounces-60418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7467AB46A54
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BDE7B0B96
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0596277C90;
	Sat,  6 Sep 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mn0KM+kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF7236454
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149665; cv=none; b=T/HdxdxHKdv5FLs9qLRrQ4PZ/v2N8j2PIVlv4SAjzNAYfWH+Ks9TXU8HuXUOx4T7AzxpGRQgan3xb1jHbXzZrm3q2yNxQeghNpZjWcbolE6A/O1pgQYvIoLpBPufSmx7O8spNC3k2YFwXuGeZyXcXOq9xBKomVHxtm0D9YLkC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149665; c=relaxed/simple;
	bh=TnOhTFWRa+SyMJn432ftQOBlMYgduwiSf4R4sDv22sg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fWVLU5I91y3GAjqJB5bfTyJfbq/WQOVKd2qd6ZzSofLJMrEFDMAc/N/Y+O1w9vgCA/f1Aq1/1dugKXQ5nj8epUNhsela2uIHnc+GV8HJ5clCr/LvvIoEq08bhMHRZa/7eFVNmKlxHb5cw2q3bwLoBiNLwt+oUDxYoft8ejCECZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mn0KM+kh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=x4FHbyOL+7DYSoB2Ck9M5hjiIX7UYqhGd4BZW4g54As=; b=mn0KM+khRrVDnDrdtEytUHt+Po
	BCEztmWn6lMDCYYbWOQgJXvyxFEMPupbEXM1OJ7v6tconkOmeAIQx1QaOeOeMM1+zplbFpybR4ljM
	iTsuCd6q49R3nm6L6lWff+M2aPvxBZgBs6ZKHw6hN4a5ZQs7Gfh8HhDV1traswI50PqEgItil2glf
	hPq+BoxoJy8S3qs5HnGdE1XrUjAUx1DS7MqkuTuj0pwfbs2MxW8DT8Q4ksnLEkjoK6HooUD7Is4oU
	LGedJc33csAq6fbtFYsmlMpOvTv/aF3x1txUD06YEvZPYO3+OcITNarjZEKAU9FYjpyO8QF6fokqb
	ikgDlisQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuotW-00000000M7Z-0TSJ;
	Sat, 06 Sep 2025 09:07:38 +0000
Date: Sat, 6 Sep 2025 10:07:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>
Subject: [PATCHES] file->f_path safety and struct path constifications
Message-ID: <20250906090738.GA31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	struct path is embedded into several objects, starting with
struct file.  In a lot of places we rely upon e.g. file->f_path of an
opened file remaining unchanging; things like "ask for write access to
file->f_path.mnt when opening for write, release that on final fput()"
would break badly if ->f_path.mnt could change between those.  It's not
the only place like that; both VFS and filesystems expect that to hold.
Anything that would want to play silly buggers with that would have to be
_very_ careful and would be rather brittle, at that.  It's not impossible
to get away with, but any such place is a source of headache for proofs
of correctness, as well as a likely cause of bugs in the future.

	Unfortunately, verifying that turns into several hours of manual
audit that has to be repeated once in a while and I'm sick and tired of
doing that.  Let the compiler deal with that crap.  The same goes for
struct unix_sock ->path, etc.

Note that in the mainline we have _very_ few places that store to ->f_path.
	1) init_file() zeroes it out
	2) file_init_path() copies the caller-supplied struct path into it
(common helper of alloc_file() family of primitives; struct file is freshly
allocated, we are setting it up)
	3) atomic_open()/finish_open()/finish_no_open() arrange for setting
->f_path between them.  Again, that's before it gets opened.
	4) vfs_tmpfile() - ditto.
	5) do_dentry_open() clears it on early failure exits
	6) vfs_open() sets it to caller-supplied struct path - that's opening
the file by path (dentry_open() and its ilk are using that one).  Again,
prior to file getting opened.
	7) acct_on() (acct(2) helper) is flipping ->f_path.mnt of its internally
opened and internally used file to cloned mount.  It does get away with that,
but it's neither pretty nor robust.

	All except the last one are in core VFS and not dealing with
already opened files.  Killing (7) is doable - it's not hard to get rid
of that weird shit in acct_on().  After that no stores happen to opened
files and all those stores are local to fs/file_table.c, fs/open.c and
fs/namei.c (the latter - in the open-related parts).

	After that the obvious next step would be to turn f_path into
type-punning union of struct path __f_path and const struct path
f_path, and switch the places that should do stores (see above) to
using ->__f_path.  It's valid C99 - no UB there.  struct file no longer
can be a modifiable lvalue, but we never did wholesale copying for those
and there's no reason to start; what's more, we never embed struct file
into any other objects.

	It's not quite that simple, though - things like
	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask);
would have the compiler complain; it needs to be told that vfs_statx_path()
is not going to modify the struct path it's been given.  IOW, we need to
switch a bunch of struct path * arguments to const struct path * before we
can go for the final part.  Turns out that there's not a lot of such
missing annotations.

So this stuff sits in two branches:

#work.path switches the struct path * arguments that are never used to modify
the struct path in question to const struct path *.  Not all of those
functions are used for ->f_path, but there's not a lot of them and new call
sites might appear, so let's deal with all that bunch.

#work.f_path starts with getting rid of the shit in acct_on(), then merges
#work.path and #work.mount in (I don't want to pull constification patches
out of #work.mount), then does the conversion of f_path to anon union.

Branches are in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.path and
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.f_path resp.;
individual patches in followups.

Please, review.  If nobody objects, I'm putting that into #for-next early
next week...

