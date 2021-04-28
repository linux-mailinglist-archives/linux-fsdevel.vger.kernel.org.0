Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9536D723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 14:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhD1MUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 08:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhD1MUm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:20:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D633EB156;
        Wed, 28 Apr 2021 12:19:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A23671E150F; Wed, 28 Apr 2021 14:19:56 +0200 (CEST)
Date:   Wed, 28 Apr 2021 14:19:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 5.13-rc1
Message-ID: <20210428121956.GB25222@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.13-rc1

to get support for limited fanotify functionality for unpriviledged users,
faster merging of fanotify events, and a few smaller fsnotify improvements.

Top of the tree is 59cda49ecf6c. The full shortlog is:

Amir Goldstein (9):
      fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
      fanotify: reduce event objectid to 29-bit hash
      fanotify: mix event info and pid into merge key hash
      fsnotify: use hash table for faster events merge
      fanotify: limit number of event merge attempts
      fanotify: configurable limits via sysfs
      fanotify: support limited functionality for unprivileged users
      fs: introduce a wrapper uuid_to_fsid()
      shmem: allow reporting fanotify events with file handles on tmpfs

Christian Brauner (1):
      fanotify_user: use upper_32_bits() to verify mask

The diffstat is

 fs/ext2/super.c                      |   5 +-
 fs/ext4/super.c                      |   5 +-
 fs/notify/fanotify/fanotify.c        | 166 ++++++++++++++++++--------
 fs/notify/fanotify/fanotify.h        |  46 +++++++-
 fs/notify/fanotify/fanotify_user.c   | 219 +++++++++++++++++++++++++++++------
 fs/notify/fdinfo.c                   |   3 +-
 fs/notify/group.c                    |   1 -
 fs/notify/inotify/inotify_fsnotify.c |   9 +-
 fs/notify/inotify/inotify_user.c     |   7 +-
 fs/notify/mark.c                     |   4 -
 fs/notify/notification.c             |  64 +++++-----
 fs/zonefs/super.c                    |   5 +-
 include/linux/fanotify.h             |  36 +++++-
 include/linux/fsnotify_backend.h     |  29 ++---
 include/linux/sched/user.h           |   3 -
 include/linux/statfs.h               |   8 ++
 include/linux/user_namespace.h       |   4 +
 kernel/sysctl.c                      |  12 +-
 kernel/ucount.c                      |   4 +
 mm/shmem.c                           |   3 +
 20 files changed, 472 insertions(+), 161 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
