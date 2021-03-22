Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C13440DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 13:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCVM0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 08:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhCVMZn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:25:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 218AC6198B;
        Mon, 22 Mar 2021 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415942;
        bh=cdHrv9OyjJ5nKhMY5NIPkvBN+yh8ZI803sgsg5wwt40=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cHW7sD+AReIuZ0kbWfmwJbf3Cy+5XmCLOtWTGiIAmvWiH2SQ/AKticgZVSlwz68xN
         HbeauYuYm4aC2Dwt+eIW33i6p0zn4qAyEsexeSwLAL4EZ08/LiFa8bEhfB6W8ZbfYq
         Bame1p2JMEk9TPc/vweA945JSmAjbKa7+BFHXyv9Pz92kCDz3BZi57UAX3UFBJqe2a
         B2arQiOSJt/3ixdUbo9wFJrelHKKthJ48iS2hrRi0TdSJENvD5MbH1tf+kiIgib8Op
         wVTXl6hTRu/7Z2yhsH393XfabulU5HKRbg9Ksvw22ldlM1rMoKL2hFvAI5SvY7YP1O
         /5iCp+7CpVHdw==
Message-ID: <88d125046426ec27c2cac4816a10c6e3fe515ecc.camel@kernel.org>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Date:   Mon, 22 Mar 2021 08:25:40 -0400
In-Reply-To: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-03-20 at 04:31 +0000, Al Viro wrote:
> 	Patch series (#work.cifs in vfs.git) tries to clean the things
> up in and around build_path_from_dentry().  Part of that is constifying
> the pointers around that stuff, then it lifts the allocations into
> callers and finally switches build_path_from_dentry() to using
> dentry_path_raw() instead of open-coding it.  Handling of ->d_name
> and friends is subtle enough, and it would be better to have fewer
> places besides fs/d_path.c that need to mess with those...
> 
> 	Help with review and testing would be very much appreciated -
> there's a plenty of mount options/server combinations ;-/
> 
> 	For those who prefer to look at it in git, it lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.cifs;
> individual patches go in followups.
> 
> Shortlog:
> Al Viro (7):
>       cifs: don't cargo-cult strndup()
>       cifs: constify get_normalized_path() properly
>       cifs: constify path argument of ->make_node()
>       cifs: constify pathname arguments in a bunch of helpers
>       cifs: make build_path_from_dentry() return const char *
>       cifs: allocate buffer in the caller of build_path_from_dentry()
>       cifs: switch build_path_from_dentry() to using dentry_path_raw()
> 
> 1) a bunch of kstrdup() calls got cargo-culted as kstrndup().
> This is unidiomatic *and* pointless - it's not any "safer"
> that way (pass it a non-NUL-terminated array, and strlen()
> will barf same as kstrdup()) and it's actually a pessimization.
> Converted to plain kstrdup() calls.
> 
> 2) constifying pathnames: get_normalized_path() gets a
> constant string and, on success, returns either that string
> or its modified copy.  It is declared with the wrong prototype -
> int get_normalized_path(const char *path, char **npath)
> so the caller might get a non-const alias of the original const
> string.  Fortunately, none of the callers actually use that
> alias to modify the string, so it's not an active bug - just
> the wrong typization.
> 
> 3) constifying pathnames: ->make_node().  Unlike the rest of
> methods that take pathname as an argument, it has that argument
> declared as char *, not const char *.  Pure misannotation,
> since all instances never modify that actual string (or pass it 
> to anything that might do the same).
> 
> 4) constifying pathnames: a bunch of helpers.  Several functions
> have pathname argument declared as char *, when const char *
> would be fine - they neither modify the string nor pass it to
> anything that might.
> 
> 5) constifying pathnames: build_path_from_dentry().
> That's the main source of pathnames; all callers are actually
> treating the string it returns as constant one.  Declare it
> to return const char * and adjust the callers.
> 
> 6) take buffer allocation out of build_path_from_dentry().
> Trying to do exact-sized allocation is pointless - allocated
> object are short-lived anyway (the caller is always the one
> to free the string it gets from build_path_from_dentry()).
> As the matter of fact, we are in the same situation as with
> pathname arguments of syscalls - short-lived allocations
> limited to 4Kb and freed before the caller returns to userland.
> So we can just do allocations from names_cachep and do that
> in the caller; that way we don't need to bother with GFP_ATOMIC
> allocations.  Moreover, having the caller do allocations will
> permit us to switch build_path_from_dentry() to use of dentry_path_raw()
> (in the next commit).
> 
> 7) build_path_from_dentry() essentially open-codes dentry_path_raw();
> the difference is that it wants to put the result in the beginning
> of the buffer (which we don't need anymore, since the caller knows
> what to free anyway) _and_ we might want '\\' for component separator
> instead of the normal '/'.  It's easier to use dentry_path_raw()
> and (optionally) post-process the result, replacing all '/' with
> '\\'.  Note that the last part needs profiling - I would expect it
> to be noise (we have just formed the string and it's all in hot cache),
> but that needs to be verified.
> 
> Diffstat:
>  fs/cifs/cifs_dfs_ref.c |  14 +++--
>  fs/cifs/cifsglob.h     |   2 +-
>  fs/cifs/cifsproto.h    |  19 +++++--
>  fs/cifs/connect.c      |   9 +--
>  fs/cifs/dfs_cache.c    |  41 +++++++-------
>  fs/cifs/dir.c          | 148 ++++++++++++++++++-------------------------------
>  fs/cifs/file.c         |  79 +++++++++++++-------------
>  fs/cifs/fs_context.c   |   2 +-
>  fs/cifs/inode.c        | 110 ++++++++++++++++++------------------
>  fs/cifs/ioctl.c        |  13 +++--
>  fs/cifs/link.c         |  46 +++++++++------
>  fs/cifs/misc.c         |   2 +-
>  fs/cifs/readdir.c      |  15 ++---
>  fs/cifs/smb1ops.c      |   6 +-
>  fs/cifs/smb2ops.c      |  19 ++++---
>  fs/cifs/unc.c          |   4 +-
>  fs/cifs/xattr.c        |  40 +++++++------
>  17 files changed, 278 insertions(+), 291 deletions(-)


This all looks reasonable.

FWIW, we switched ceph to use a similar buffer allocation scheme for
built paths a couple of years ago. I left the allocation in the caller
there, and we just return the offset of the start of the string to the
caller (which we only use to free the buffer later). It works but it's a
bit klunky.

Acked-by: Jeff Layton <jlayton@kernel.org>

