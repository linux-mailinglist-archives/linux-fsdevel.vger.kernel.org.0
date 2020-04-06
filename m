Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DAA19F4F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgDFLoe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 07:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbgDFLod (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:44:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D67BAEA6;
        Mon,  6 Apr 2020 11:44:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D9F61E1244; Mon,  6 Apr 2020 13:44:31 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:44:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify patches for v5.7-rc1
Message-ID: <20200406114431.GF1143@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.7-rc1

This pull contains patches implementing fanotify FAN_DIR_MODIFY event. This
event reports name in a directory under which change happened and together
with directory filehandle and fstatat() allows reliable and efficient
implementation of directory synchronization.

Top of the tree is 6def1a1d2d58. The full shortlog is:

Amir Goldstein (12):
      fsnotify: tidy up FS_ and FAN_ constants
      fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
      fsnotify: funnel all dirent events through fsnotify_name()
      fsnotify: use helpers to access data by data_type
      fsnotify: simplify arguments passing to fsnotify_parent()
      fsnotify: replace inode pointer with an object id
      fanotify: merge duplicate events on parent and child
      fanotify: fix merging marks masks with FAN_ONDIR
      fanotify: send FAN_DIR_MODIFY event flavor with dir inode and name
      fanotify: prepare to report both parent and child fid's
      fanotify: record name info for FAN_DIR_MODIFY event
      fanotify: report name info for FAN_DIR_MODIFY event

Jan Kara (4):
      fanotify: Simplify create_fd()
      fanotify: Store fanotify handles differently
      fanotify: divorce fanotify_path_event and fanotify_fid_event
      fanotify: Drop fanotify_event_has_fid()

Nathan Chancellor (1):
      fanotify: Fix the checks in fanotify_fsid_equal

The diffstat is

 fs/notify/fanotify/fanotify.c        | 302 ++++++++++++++++++++++++++---------
 fs/notify/fanotify/fanotify.h        | 189 +++++++++++++++-------
 fs/notify/fanotify/fanotify_user.c   | 220 ++++++++++++++++---------
 fs/notify/fsnotify.c                 |  22 +--
 fs/notify/inotify/inotify_fsnotify.c |  12 +-
 fs/notify/inotify/inotify_user.c     |   2 +-
 include/linux/fanotify.h             |   3 +-
 include/linux/fsnotify.h             | 138 +++++++---------
 include/linux/fsnotify_backend.h     |  70 +++++---
 include/uapi/linux/fanotify.h        |  13 +-
 kernel/audit_fsnotify.c              |  13 +-
 kernel/audit_watch.c                 |  16 +-
 12 files changed, 637 insertions(+), 363 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
