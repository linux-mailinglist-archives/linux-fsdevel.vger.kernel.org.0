Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAADB19BB48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 07:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDBFYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 01:24:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39762 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBFYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:24:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJsKs-008Qfb-6k; Thu, 02 Apr 2020 05:24:14 +0000
Date:   Thu, 2 Apr 2020 06:24:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pathwalk sanitizing
Message-ID: <20200402052414.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Massive pathwalk rewrite and cleanups.  Several iterations had
been posted; hopefully the damn thing is getting readable and understandable
now.  Pretty much all parts of pathname resolutions are affected...

The branch is identical to what has sat in -next, except for commit message in
"lift all calls of step_into() out of follow_dotdot/follow_dotdot_rcu",
crediting Qian Cai for reporting the bug; only commit message changed there.
 I'd folded the fix back in Mar 25, and it had been present in -next since then
(see #work.dotdot).  I asked Qian Cai whether he wanted his tested-by on that
thing, got no reply...
	Anyway, all diffs in that branch are identical to the ones in
#work.dotdot, which is what has sat in linux-next for the last week.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dotdot1

for you to fetch changes up to 99a4a90c8e9337e364136393286544e3753673c3:

  lookup_open(): don't bother with fallbacks to lookup+create (2020-04-02 01:09:31 -0400)

----------------------------------------------------------------
Al Viro (69):
      do_add_mount(): lift lock_mount/unlock_mount into callers
      fix automount/automount race properly
      follow_automount(): get rid of dead^Wstillborn code
      follow_automount() doesn't need the entire nameidata
      make build_open_flags() treat O_CREAT | O_EXCL as implying O_NOFOLLOW
      handle_mounts(): start building a sane wrapper for follow_managed()
      atomic_open(): saner calling conventions (return dentry on success)
      lookup_open(): saner calling conventions (return dentry on success)
      do_last(): collapse the call of path_to_nameidata()
      handle_mounts(): pass dentry in, turn path into a pure out argument
      lookup_fast(): consolidate the RCU success case
      teach handle_mounts() to handle RCU mode
      lookup_fast(): take mount traversal into callers
      step_into() callers: dismiss the symlink earlier
      new step_into() flag: WALK_NOFOLLOW
      fold handle_mounts() into step_into()
      LOOKUP_MOUNTPOINT: fold path_mountpointat() into path_lookupat()
      expand the only remaining call of path_lookup_conditional()
      merging pick_link() with get_link(), part 1
      merging pick_link() with get_link(), part 2
      merging pick_link() with get_link(), part 3
      merging pick_link() with get_link(), part 4
      merging pick_link() with get_link(), part 5
      merging pick_link() with get_link(), part 6
      finally fold get_link() into pick_link()
      sanitize handling of nd->last_type, kill LAST_BIND
      namei: invert the meaning of WALK_FOLLOW
      pick_link(): check for WALK_TRAILING, not LOOKUP_PARENT
      link_path_walk(): simplify stack handling
      namei: have link_path_walk() maintain LOOKUP_PARENT
      massage __follow_mount_rcu() a bit
      new helper: traverse_mounts()
      atomic_open(): return the right dentry in FMODE_OPENED case
      atomic_open(): lift the call of may_open() into do_last()
      do_last(): merge the may_open() calls
      do_last(): don't bother with keeping got_write in FMODE_OPENED case
      do_last(): rejoing the common path earlier in FMODE_{OPENED,CREATED} case
      do_last(): simplify the liveness analysis past finish_open_created
      do_last(): rejoin the common path even earlier in FMODE_{OPENED,CREATED} case
      split the lookup-related parts of do_last() into a separate helper
      path_connected(): pass mount and dentry separately
      path_parent_directory(): leave changing path->dentry to callers
      expand path_parent_directory() in its callers
      follow_dotdot{,_rcu}(): lift switching nd->path to parent out of loop
      follow_dotdot{,_rcu}(): lift LOOKUP_BENEATH checks out of loop
      move handle_dots(), follow_dotdot() and follow_dotdot_rcu() past step_into()
      handle_dots(), follow_dotdot{,_rcu}(): preparation to switch to step_into()
      follow_dotdot{,_rcu}(): switch to use of step_into()
      lift all calls of step_into() out of follow_dotdot/follow_dotdot_rcu
      follow_dotdot{,_rcu}(): massage loops
      follow_dotdot_rcu(): be lazy about changing nd->path
      follow_dotdot(): be lazy about changing nd->path
      helper for mount rootwards traversal
      non-RCU analogue of the previous commit
      fs/namei.c: kill follow_mount()
      pick_link(): pass it struct path already with normal refcounting rules
      fold path_to_nameidata() into its only remaining caller
      pick_link(): more straightforward handling of allocation failures
      pick_link(): take reserving space on stack into a new helper
      reserve_stack(): switch to __nd_alloc_stack()
      __nd_alloc_stack(): make it return bool
      link_path_walk(): sample parent's i_uid and i_mode for the last component
      take post-lookup part of do_last() out of loop
      open_last_lookups(): consolidate fsnotify_create() calls
      open_last_lookups(): don't abuse complete_walk() when all we want is unlazy
      open_last_lookups(): lift O_EXCL|O_CREAT handling into do_open()
      open_last_lookups(): move complete_walk() into do_open()
      atomic_open(): no need to pass struct open_flags anymore
      lookup_open(): don't bother with fallbacks to lookup+create

 Documentation/filesystems/path-lookup.rst |    7 +-
 fs/autofs/dev-ioctl.c                     |    6 +-
 fs/internal.h                             |    1 -
 fs/namei.c                                | 1488 ++++++++++++-----------------
 fs/namespace.c                            |   96 +-
 fs/open.c                                 |    4 +-
 include/linux/namei.h                     |    4 +-
 7 files changed, 687 insertions(+), 919 deletions(-)
