Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED27923C924
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgHEJ2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 05:28:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEJ2O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:28:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1A64AC83;
        Wed,  5 Aug 2020 09:28:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 38E011E12CB; Wed,  5 Aug 2020 11:28:11 +0200 (CEST)
Date:   Wed, 5 Aug 2020 11:28:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [GIT PULL] Fsnotify changes for 5.9-rc1
Message-ID: <20200805092811.GE4117@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.9-rc1

This pull contains:
 * fanotify fix for softlockups when there are many queued events
 * performance improvement to reduce fsnotify overhead when not used
 * Amir's implementation of fanotify events with names

With Amir's patches you can now efficiently monitor whole filesystem and
say mirror changes to another machine.

Top of the tree is 8aed8cebdd97. The full shortlog is:

Amir Goldstein (34):
      fsnotify: fold fsnotify() call into fsnotify_parent()
      fsnotify: return non const from fsnotify_data_inode()
      nfsd: use fsnotify_data_inode() to get the unlinked inode
      kernfs: do not call fsnotify() with name without a parent
      inotify: do not use objectid when comparing events
      fanotify: create overflow event type
      fanotify: break up fanotify_alloc_event()
      fsnotify: pass dir argument to handle_event() callback
      fanotify: remove event FAN_DIR_MODIFY
      fanotify: generalize the handling of extra event flags
      fanotify: generalize merge logic of events on dir
      fanotify: distinguish between fid encode error and null fid
      fanotify: generalize test for FAN_REPORT_FID
      fanotify: mask out special event flags from ignored mask
      fanotify: prepare for implicit event flags in mark mask
      fanotify: use FAN_EVENT_ON_CHILD as implicit flag on sb/mount/non-dir marks
      fsnotify: add object type "child" to object type iterator
      fanotify: use struct fanotify_info to parcel the variable size buffer
      fanotify: no external fh buffer in fanotify_name_event
      dnotify: report both events on parent and child with single callback
      inotify: report both events on parent and child with single callback
      fsnotify: send event to parent and child with single callback
      fsnotify: create helper fsnotify_inode()
      fsnotify: pass dir and inode arguments to fsnotify()
      inotify: do not set FS_EVENT_ON_CHILD in non-dir mark mask
      audit: do not set FS_EVENT_ON_CHILD in audit marks mask
      fsnotify: send event with parent/name info to sb/mount/non-dir marks
      fsnotify: remove check that source dentry is positive
      fanotify: add basic support for FAN_REPORT_DIR_FID
      fanotify: report events with parent dir fid to sb/mount/non-dir marks
      fanotify: add support for FAN_REPORT_NAME
      fanotify: report parent fid + name + child fid
      fanotify: report parent fid + child fid
      fsnotify: create method handle_inode_event() in fsnotify_operations

Jan Kara (2):
      fanotify: Avoid softlockups when reading many events
      fanotify: compare fsid when merging name event

Mel Gorman (1):
      fsnotify: Rearrange fast path to minimise overhead when there is no watcher

The diffstat is

 fs/kernfs/file.c                     |  13 +-
 fs/nfsd/filecache.c                  |  10 +-
 fs/notify/dnotify/dnotify.c          |  16 +-
 fs/notify/fanotify/fanotify.c        | 443 +++++++++++++++++++++++------------
 fs/notify/fanotify/fanotify.h        | 118 ++++++++--
 fs/notify/fanotify/fanotify_user.c   | 218 ++++++++++++-----
 fs/notify/fsnotify.c                 | 244 ++++++++++++++-----
 fs/notify/inotify/inotify.h          |   6 +-
 fs/notify/inotify/inotify_fsnotify.c |  51 +++-
 fs/notify/inotify/inotify_user.c     |  18 +-
 include/linux/fanotify.h             |   6 +-
 include/linux/fsnotify.h             |  84 ++++---
 include/linux/fsnotify_backend.h     |  93 ++++++--
 include/uapi/linux/fanotify.h        |  16 +-
 kernel/audit_fsnotify.c              |  22 +-
 kernel/audit_tree.c                  |  10 +-
 kernel/audit_watch.c                 |  19 +-
 kernel/trace/trace.c                 |   3 +-
 18 files changed, 966 insertions(+), 424 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
