Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6D342A7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCTEd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:33:29 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58334 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCTEdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:33:20 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTGT-007Z9g-2U; Sat, 20 Mar 2021 04:31:05 +0000
Date:   Sat, 20 Mar 2021 04:31:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
Message-ID: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Patch series (#work.cifs in vfs.git) tries to clean the things
up in and around build_path_from_dentry().  Part of that is constifying
the pointers around that stuff, then it lifts the allocations into
callers and finally switches build_path_from_dentry() to using
dentry_path_raw() instead of open-coding it.  Handling of ->d_name
and friends is subtle enough, and it would be better to have fewer
places besides fs/d_path.c that need to mess with those...

	Help with review and testing would be very much appreciated -
there's a plenty of mount options/server combinations ;-/

	For those who prefer to look at it in git, it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.cifs;
individual patches go in followups.

Shortlog:
Al Viro (7):
      cifs: don't cargo-cult strndup()
      cifs: constify get_normalized_path() properly
      cifs: constify path argument of ->make_node()
      cifs: constify pathname arguments in a bunch of helpers
      cifs: make build_path_from_dentry() return const char *
      cifs: allocate buffer in the caller of build_path_from_dentry()
      cifs: switch build_path_from_dentry() to using dentry_path_raw()

1) a bunch of kstrdup() calls got cargo-culted as kstrndup().
This is unidiomatic *and* pointless - it's not any "safer"
that way (pass it a non-NUL-terminated array, and strlen()
will barf same as kstrdup()) and it's actually a pessimization.
Converted to plain kstrdup() calls.

2) constifying pathnames: get_normalized_path() gets a
constant string and, on success, returns either that string
or its modified copy.  It is declared with the wrong prototype -
int get_normalized_path(const char *path, char **npath)
so the caller might get a non-const alias of the original const
string.  Fortunately, none of the callers actually use that
alias to modify the string, so it's not an active bug - just
the wrong typization.

3) constifying pathnames: ->make_node().  Unlike the rest of
methods that take pathname as an argument, it has that argument
declared as char *, not const char *.  Pure misannotation,
since all instances never modify that actual string (or pass it 
to anything that might do the same).

4) constifying pathnames: a bunch of helpers.  Several functions
have pathname argument declared as char *, when const char *
would be fine - they neither modify the string nor pass it to
anything that might.

5) constifying pathnames: build_path_from_dentry().
That's the main source of pathnames; all callers are actually
treating the string it returns as constant one.  Declare it
to return const char * and adjust the callers.

6) take buffer allocation out of build_path_from_dentry().
Trying to do exact-sized allocation is pointless - allocated
object are short-lived anyway (the caller is always the one
to free the string it gets from build_path_from_dentry()).
As the matter of fact, we are in the same situation as with
pathname arguments of syscalls - short-lived allocations
limited to 4Kb and freed before the caller returns to userland.
So we can just do allocations from names_cachep and do that
in the caller; that way we don't need to bother with GFP_ATOMIC
allocations.  Moreover, having the caller do allocations will
permit us to switch build_path_from_dentry() to use of dentry_path_raw()
(in the next commit).

7) build_path_from_dentry() essentially open-codes dentry_path_raw();
the difference is that it wants to put the result in the beginning
of the buffer (which we don't need anymore, since the caller knows
what to free anyway) _and_ we might want '\\' for component separator
instead of the normal '/'.  It's easier to use dentry_path_raw()
and (optionally) post-process the result, replacing all '/' with
'\\'.  Note that the last part needs profiling - I would expect it
to be noise (we have just formed the string and it's all in hot cache),
but that needs to be verified.

Diffstat:
 fs/cifs/cifs_dfs_ref.c |  14 +++--
 fs/cifs/cifsglob.h     |   2 +-
 fs/cifs/cifsproto.h    |  19 +++++--
 fs/cifs/connect.c      |   9 +--
 fs/cifs/dfs_cache.c    |  41 +++++++-------
 fs/cifs/dir.c          | 148 ++++++++++++++++++-------------------------------
 fs/cifs/file.c         |  79 +++++++++++++-------------
 fs/cifs/fs_context.c   |   2 +-
 fs/cifs/inode.c        | 110 ++++++++++++++++++------------------
 fs/cifs/ioctl.c        |  13 +++--
 fs/cifs/link.c         |  46 +++++++++------
 fs/cifs/misc.c         |   2 +-
 fs/cifs/readdir.c      |  15 ++---
 fs/cifs/smb1ops.c      |   6 +-
 fs/cifs/smb2ops.c      |  19 ++++---
 fs/cifs/unc.c          |   4 +-
 fs/cifs/xattr.c        |  40 +++++++------
 17 files changed, 278 insertions(+), 291 deletions(-)
