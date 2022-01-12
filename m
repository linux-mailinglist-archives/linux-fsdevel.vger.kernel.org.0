Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F368C48C011
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 09:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351683AbiALIi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 03:38:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349372AbiALIi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:38:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 818922113A;
        Wed, 12 Jan 2022 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641976706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ZcpXZlVVw1VmINj0qZtbIUoPA4cnwWrysa2aI3mZlH4=;
        b=DGA1jsBDcTmS5M6CgLd1Z+5SgQcWLalC5LTVEUK9h0oeTI0ncXLkjjlgI4CxDsZwdVbxjO
        1fK/MZIgkIA3msQdgcCfc4DSbOrY9MBgeqhTLebxY64wdwWq1QIBKkSt/O1O0xYk9wI69m
        xOBT5oiDc/fxbQwxH9X63XV3NShd/4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641976706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=ZcpXZlVVw1VmINj0qZtbIUoPA4cnwWrysa2aI3mZlH4=;
        b=B4llIWBsXWqTxb6vtDJ1pHTOnsGfS+9IVx7ZrYpbSVM159+4ojX6Xt7gaXfmGmJ+QMQjcO
        5SQ+YRltFg6/VHCw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7521BA3B81;
        Wed, 12 Jan 2022 08:38:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DDF9AA05DA; Wed, 12 Jan 2022 09:38:25 +0100 (CET)
Date:   Wed, 12 Jan 2022 09:38:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 5.17-rc1
Message-ID: <20220112083825.td2ds6qej74tm77c@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc1

to get support for new FAN_RENAME fanotify event and support for reporting
child info in directory fanotify events (FAN_REPORT_TARGET_FID).

Top of the tree is 8cc3b1ccd930. The full shortlog is:

Amir Goldstein (11):
      fsnotify: clarify object type argument
      fsnotify: separate mark iterator type from object type enum
      fanotify: introduce group flag FAN_REPORT_TARGET_FID
      fsnotify: generate FS_RENAME event with rich information
      fanotify: use macros to get the offset to fanotify_info buffer
      fanotify: use helpers to parcel fanotify_info buffer
      fanotify: support secondary dir fh and name in fanotify_info
      fanotify: record old and new parent and name in FAN_RENAME event
      fanotify: record either old name new name or both for FAN_RENAME
      fanotify: report old and/or new parent+name in FAN_RENAME event
      fanotify: wire up FAN_RENAME event

The diffstat is

 fs/notify/dnotify/dnotify.c        |   2 +-
 fs/notify/fanotify/fanotify.c      | 213 ++++++++++++++++++++++++++++---------
 fs/notify/fanotify/fanotify.h      | 142 +++++++++++++++++++++++--
 fs/notify/fanotify/fanotify_user.c |  82 +++++++++++---
 fs/notify/fsnotify.c               |  53 ++++++---
 fs/notify/group.c                  |   2 +-
 fs/notify/mark.c                   |  31 +++---
 include/linux/dnotify.h            |   2 +-
 include/linux/fanotify.h           |   5 +-
 include/linux/fsnotify.h           |   9 +-
 include/linux/fsnotify_backend.h   |  74 +++++++------
 include/uapi/linux/fanotify.h      |  12 +++
 12 files changed, 483 insertions(+), 144 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
