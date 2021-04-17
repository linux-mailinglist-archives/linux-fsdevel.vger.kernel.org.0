Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56317362C4A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhDQAKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:10:54 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34544 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhDQAKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:10:54 -0400
Received: by mail-pl1-f173.google.com with SMTP id t22so14482045ply.1;
        Fri, 16 Apr 2021 17:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HdgLgf4++L+hPBdBpKCHERQ4SDuSpyDo8YojGbWccSs=;
        b=Tkn8tIaHPeX66UId9jeCrYLexGUUirWJ7ApmW0hNuHWH+/2olXJWr+0JF+caNozxau
         0ZntKyGqFv1av7TfPaqAJWGRr6un1/Keh287O/zbIyaxHt3+Tb4fQdoho2h7sFwVzj4N
         78GHRkG5X/0C8CYAlZsYXGwpgmQVZ4Bp9+Pv8t1IvY2g12GKtGIQCgnHywNhUZeAisKc
         7YAm6L1SFRpvpVbnsfx4Pv/+aZL7XQOVgWuJdrzYvlxRZ+R/bxvjTZkiMQ84qmUR8JXf
         h8pA2LXY2fDk8jAdHbyFGWSsotUnws1Lye+OfnYjqVpiYqWR/AQ2gJ4xiRUam85N4klu
         Dvbg==
X-Gm-Message-State: AOAM531nsKARq96b4YuU/EyF0RMcL0Jr7OIJFuPAV/VJ/CoG2FkYBfuY
        bXimVGaqSHb9Jsg6SlIp4r0CxuZPYZEbSQ==
X-Google-Smtp-Source: ABdhPJyrdUDhh1VEpWEgWuRgLwDGj1MJHhyfDvyurM0Vgp9DKQVEEbax9LoLWPokxRbK2wssHToVYw==
X-Received: by 2002:a17:90a:c501:: with SMTP id k1mr12119541pjt.101.1618618228656;
        Fri, 16 Apr 2021 17:10:28 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d5sm6215781pgj.36.2021.04.16.17.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:10:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 161F7403DC; Sat, 17 Apr 2021 00:10:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 0/6] vfs: provide automatic kernel freeze / resume
Date:   Sat, 17 Apr 2021 00:10:20 +0000
Message-Id: <20210417001026.23858-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This picks up where I left off in 2017, I was inclined to respin this
up again due to a new issue Lukas reported which is easy to reproduce.
I posted a stop-gap patch for that issue [0] and a test case, however,
*this* is the work we want upstream to fix these sorts of issues.

As discussed long ago though at LSFMM, we have much work to do. However,
we can take small strides to get us closer. This is trying to take one
step. It addresses most of the comments and feedback from the last
series I posted, however it doesn't address the biggest two issues:

 o provide clean and clear semantics between userspace ioctls /
   automatic fs freeze, and freeze bdev. This also involves moving the
   counter stuff from bdev to the superblock. This is pending work.
 o The loopback hack which breaks the reverse ordering isn't addressed,
   perhaps just flagging it suffices for now?
 o The long term desirable DAG *is* plausable and I have an initial
   kernel graph implementation which I could use, but that may take
   longer to merge.

What this series *does* address based on the last series is:

  o Rebased onto linux-next tag next-20210415
  o Fixed RCU complaints. The issue was that I was adding new fs levels, and
    this increated undesirably also the amount of rw semaphores, but we were
    just using the new levels to distinguish *who* was triggering the suspend,
    it was either inside the kernel and automatic, or triggered by userspace.
  o thaw_super_locked() was added but that unlocks the sb sb->s_umount,
    our exclusive reverse iterate supers however will want to hold that
    semaphore, so we provide a helper which lets the caller do the unlocking
    for you, and make thaw_super_locked() a user of that.
  o WQ_FREEZABLE is now dealt with
  o I have folded the fs freezer removal stuff into the patch which adds
    the automatic fs frezer / thaw work from the kernel as otherwise separting
    this would create intermediate steps which would produce kernels which
    can stall on suspend / resume.

[0] https://lkml.kernel.org/r/20210416235850.23690-1-mcgrof@kernel.org
[1] https://lkml.kernel.org/r/20171129232356.28296-1-mcgrof@kernel.org              

Luis Chamberlain (6):
  fs: provide unlocked helper for freeze_super()
  fs: add frozen sb state helpers
  fs: add a helper for thaw_super_locked() which does not unlock
  fs: distinguish between user initiated freeze and kernel initiated
    freeze
  fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
  fs: add automatic kernel fs freeze / thaw and remove kthread freezing

 fs/btrfs/disk-io.c     |   4 +-
 fs/btrfs/scrub.c       |   2 +-
 fs/cifs/cifsfs.c       |  10 +-
 fs/cifs/dfs_cache.c    |   2 +-
 fs/ext4/ext4_jbd2.c    |   2 +-
 fs/ext4/super.c        |   2 -
 fs/f2fs/gc.c           |   7 +-
 fs/f2fs/segment.c      |   6 +-
 fs/gfs2/glock.c        |   6 +-
 fs/gfs2/main.c         |   4 +-
 fs/jfs/jfs_logmgr.c    |  11 +-
 fs/jfs/jfs_txnmgr.c    |  31 ++--
 fs/nilfs2/segment.c    |  48 +++---
 fs/super.c             | 321 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_log.c       |   3 +-
 fs/xfs/xfs_mru_cache.c |   2 +-
 fs/xfs/xfs_pwork.c     |   2 +-
 fs/xfs/xfs_super.c     |  14 +-
 fs/xfs/xfs_trans.c     |   3 +-
 fs/xfs/xfs_trans_ail.c |   7 +-
 include/linux/fs.h     |  64 +++++++-
 kernel/power/process.c |  15 +-
 22 files changed, 405 insertions(+), 161 deletions(-)

-- 
2.29.2

