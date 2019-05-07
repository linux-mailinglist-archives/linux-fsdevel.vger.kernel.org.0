Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0B16C48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEGUd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 16:33:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51988 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGUd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 16:33:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO6mh-0008FZ-M0; Tue, 07 May 2019 20:33:55 +0000
Date:   Tue, 7 May 2019 21:33:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc dcache-related stuff
Message-ID: <20190507203355.GK23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Most of that pile is putting name length into struct name_snapshot
and making use of it.  Beginning of that series ("ovl_lookup_real_one():
don't bother with strlen()") ought to have been split in two (separate
switch of name_snapshot to struct qstr from overlayfs reaping the trivial
benefits of that), but I wanted to avoid a rebase - by the time I'd spotted
that it was (a) in -next and (b) close to 5.1-final ;-/

The following changes since commit ce285c267a003acbf607f3540ff71287f82e5282:

  autofs: fix use-after-free in lockless ->d_manage() (2019-04-09 19:18:19 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to 795d673af1afae8146ac3070a2d77cfae5287c43:

  audit_compare_dname_path(): switch to const struct qstr * (2019-04-28 20:33:43 -0400)

----------------------------------------------------------------
Al Viro (10):
      unexport d_alloc_pseudo()
      nsfs: unobfuscate
      sysv: bury the broken "quietly truncate the long filenames" logics
      ovl_lookup_real_one(): don't bother with strlen()
      switch fsnotify_move() to passing const struct qstr * for old_name
      fsnotify(): switch to passing const struct qstr * for file_name
      fsnotify: switch send_to_group() and ->handle_event to const struct qstr *
      inotify_handle_event(): don't bother with strlen()
      audit_update_watch(): switch to const struct qstr *
      audit_compare_dname_path(): switch to const struct qstr *

 Documentation/filesystems/porting    |  5 +++++
 fs/dcache.c                          | 18 +++++++++---------
 fs/debugfs/inode.c                   |  2 +-
 fs/internal.h                        |  1 +
 fs/kernfs/file.c                     |  6 ++++--
 fs/namei.c                           |  4 ++--
 fs/notify/dnotify/dnotify.c          |  2 +-
 fs/notify/fanotify/fanotify.c        |  2 +-
 fs/notify/fsnotify.c                 |  8 ++++----
 fs/notify/inotify/inotify.h          |  2 +-
 fs/notify/inotify/inotify_fsnotify.c |  6 +++---
 fs/nsfs.c                            | 23 ++++++++++-------------
 fs/overlayfs/export.c                |  2 +-
 fs/sysv/namei.c                      | 15 ---------------
 fs/sysv/super.c                      |  3 ---
 fs/sysv/sysv.h                       |  3 ---
 include/linux/dcache.h               |  3 +--
 include/linux/fsnotify.h             | 10 +++++-----
 include/linux/fsnotify_backend.h     |  6 +++---
 kernel/audit.h                       |  2 +-
 kernel/audit_fsnotify.c              |  2 +-
 kernel/audit_tree.c                  |  2 +-
 kernel/audit_watch.c                 |  4 ++--
 kernel/auditfilter.c                 |  6 +++---
 kernel/auditsc.c                     |  4 ++--
 25 files changed, 62 insertions(+), 79 deletions(-)
