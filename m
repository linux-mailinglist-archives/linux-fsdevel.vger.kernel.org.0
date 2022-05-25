Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B253533CBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 14:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiEYMdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 08:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiEYMdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 08:33:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2DC6D86D
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 05:33:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 535F6219A1;
        Wed, 25 May 2022 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653482031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=2aGWhh2nOcvHBMR3TnbGx6qyc+8f+sY3IV0bb0i0ezY=;
        b=Kyh3PA7JHyJKug9u3C7E8pC7mg+A9gmK2hiyFxPZAy04n7x1tmkjvUKeLm/fcNPlLtdaFY
        jbxgqBmbN/QP3c5sF0otPzfr/txV5xBa4hhMejZhAKDneZXY4BpSBRM/CqGZky7DHgZ8sK
        xLtajKTG3wajXmbjXaR+Ta34+EbSJ28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653482031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=2aGWhh2nOcvHBMR3TnbGx6qyc+8f+sY3IV0bb0i0ezY=;
        b=2k5cWcyIfS7CHKVjYbdyWBdrSHQ9fZLbVSNF3b9PSWpDoIaPkXqt5VnBLyKD5eCHgnMLx7
        4ByeMG5JPiAD1QDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 444DB2C141;
        Wed, 25 May 2022 12:33:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E0562A0632; Wed, 25 May 2022 14:33:50 +0200 (CEST)
Date:   Wed, 25 May 2022 14:33:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 5.19-rc1
Message-ID: <20220525123350.nogcycin4qjnk5jp@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.19-rc1

The biggest part of this pull is support for fsnotify inode marks that
don't pin inodes in memory but rather get evicted together with the inode
(they are useful if userspace needs to exclude receipt of events from
potentially large subtrees using fanotify ignore marks). There is also
a fix for more consistent handling of events sent to parent and a fix of
sparse(1) complaints.

Top of the tree is dccd855771b3. The full shortlog is:

Amir Goldstein (18):
      inotify: show inotify mask flags in proc fdinfo
      inotify: move control flags from mask to mark flags
      fsnotify: fix wrong lockdep annotations
      fsnotify: pass flags argument to fsnotify_alloc_group()
      fsnotify: make allow_dups a property of the group
      fsnotify: create helpers for group mark_mutex lock
      inotify: use fsnotify group lock helpers
      audit: use fsnotify group lock helpers
      nfsd: use fsnotify group lock helpers
      dnotify: use fsnotify group lock helpers
      fsnotify: allow adding an inode mark without pinning inode
      fanotify: create helper fanotify_mark_user_flags()
      fanotify: factor out helper fanotify_mark_update_flags()
      fanotify: implement "evictable" inode marks
      fanotify: use fsnotify group lock helpers
      fanotify: enable "evictable" inode marks
      fsnotify: introduce mark type iterator
      fsnotify: consistent behavior for parent not watching children

Vasily Averin (1):
      fanotify: fix incorrect fmode_t casts

The diffstat is

 fs/nfsd/filecache.c                  |  14 +++--
 fs/notify/dnotify/dnotify.c          |  13 ++--
 fs/notify/fanotify/fanotify.c        |  24 ++------
 fs/notify/fanotify/fanotify.h        |  12 ++++
 fs/notify/fanotify/fanotify_user.c   | 104 +++++++++++++++++++++-----------
 fs/notify/fdinfo.c                   |  21 ++-----
 fs/notify/fsnotify.c                 |  89 ++++++++++++++--------------
 fs/notify/group.c                    |  32 ++++++----
 fs/notify/inotify/inotify.h          |  19 ++++++
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 fs/notify/inotify/inotify_user.c     |  47 +++++++++------
 fs/notify/mark.c                     | 112 +++++++++++++++++++++++------------
 include/linux/fanotify.h             |   1 +
 include/linux/fsnotify_backend.h     |  98 +++++++++++++++++++++++-------
 include/uapi/linux/fanotify.h        |   1 +
 kernel/audit_fsnotify.c              |   5 +-
 kernel/audit_tree.c                  |  34 +++++------
 kernel/audit_watch.c                 |   2 +-
 18 files changed, 396 insertions(+), 234 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
