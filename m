Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D493D44648D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 15:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhKEODJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 10:03:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37568 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhKEODI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:03:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1ECF4218A9;
        Fri,  5 Nov 2021 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636120828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=wcjcW+vvyuhkJBVL6P1iHu1jSuSi78bu7N8c/IX90sI=;
        b=fnCoGQ3UkXazRcK3l+AVn/Cdx0LTXPH00kHmIoPnJ9eojzinEZU3on4qApH4zWHkD1Oa02
        G8F3YknnMPpJrGy/wvuSKQ2J2YsLi8weafx1NfYf4wqk2I2ROzmJCU2yuJ8gjII7FBaELp
        Yfp6aEOtZX3gXDuDPfBLRKOBTIMyUqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636120828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=wcjcW+vvyuhkJBVL6P1iHu1jSuSi78bu7N8c/IX90sI=;
        b=olMy28z4rkkTHiXgV0b3dDgoKq9WzBgpcLzvMQcZkqZfT0rEKbajj+yfWbkts8CdS5jVfW
        HNHnCCbk6dIoEODA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 0DA082C160;
        Fri,  5 Nov 2021 14:00:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D90D51E0BDF; Fri,  5 Nov 2021 15:00:27 +0100 (CET)
Date:   Fri, 5 Nov 2021 15:00:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 5.16-rc1
Message-ID: <20211105140027.GB5691@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.16-rc1

to get support for reporting filesystem errors through fanotify so that
system health monitoring daemons can watch for these and act instead of
scraping system logs.

Top of the tree is 15c72660fe9a. The full shortlog is:

Amir Goldstein (3):
      fsnotify: pass data_type to fsnotify_name()
      fsnotify: pass dentry instead of inode data
      fsnotify: clarify contract for create event hooks

Gabriel Krisman Bertazi (29):
      fsnotify: Don't insert unmergeable events in hashtable
      fanotify: Fold event size calculation to its own function
      fanotify: Split fsid check from other fid mode checks
      inotify: Don't force FS_IN_IGNORED
      fsnotify: Add helper to detect overflow_event
      fsnotify: Add wrapper around fsnotify_add_event
      fsnotify: Retrieve super block from the data field
      fsnotify: Protect fsnotify_handle_inode_event from no-inode events
      fsnotify: Pass group argument to free_event
      fanotify: Support null inode event in fanotify_dfid_inode
      fanotify: Allow file handle encoding for unhashed events
      fanotify: Encode empty file handle when no inode is provided
      fanotify: Require fid_mode for any non-fd event
      fsnotify: Support FS_ERROR event type
      fanotify: Reserve UAPI bits for FAN_FS_ERROR
      fanotify: Pre-allocate pool of error events
      fanotify: Support enqueueing of error events
      fanotify: Support merging of error events
      fanotify: Wrap object_fh inline space in a creator macro
      fanotify: Add helpers to decide whether to report FID/DFID
      fanotify: WARN_ON against too large file handles
      fanotify: Report fid info for file related file system errors
      fanotify: Emit generic error info for error event
      fanotify: Allow users to request FAN_FS_ERROR events
      ext4: Send notifications on error
      samples: Add fs error monitoring example
      docs: Document the FAN_FS_ERROR event
      samples: Make fs-monitor depend on libc and headers
      docs: Fix formatting of literal sections in fanotify docs

Jan Kara (1):
      samples: Fix warning in fsnotify sample

Zhang Mingyu (1):
      samples: remove duplicate include in fs-monitor.c

The diffstat is

 .../admin-guide/filesystem-monitoring.rst          |  78 ++++++++++
 Documentation/admin-guide/index.rst                |   1 +
 fs/ext4/super.c                                    |   8 ++
 fs/nfsd/filecache.c                                |   3 +
 fs/notify/fanotify/fanotify.c                      | 117 +++++++++++++--
 fs/notify/fanotify/fanotify.h                      |  54 ++++++-
 fs/notify/fanotify/fanotify_user.c                 | 157 ++++++++++++++++-----
 fs/notify/fsnotify.c                               |  10 +-
 fs/notify/group.c                                  |   2 +-
 fs/notify/inotify/inotify_fsnotify.c               |   5 +-
 fs/notify/inotify/inotify_user.c                   |   6 +-
 fs/notify/notification.c                           |  14 +-
 include/linux/fanotify.h                           |   9 +-
 include/linux/fsnotify.h                           |  58 +++++---
 include/linux/fsnotify_backend.h                   |  96 +++++++++++--
 include/uapi/linux/fanotify.h                      |   8 ++
 kernel/audit_fsnotify.c                            |   3 +-
 kernel/audit_watch.c                               |   3 +-
 samples/Kconfig                                    |   9 ++
 samples/Makefile                                   |   1 +
 samples/fanotify/Makefile                          |   5 +
 samples/fanotify/fs-monitor.c                      | 142 +++++++++++++++++++
 22 files changed, 690 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
