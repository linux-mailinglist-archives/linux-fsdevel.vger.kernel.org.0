Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295712CBC6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgLBMH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgLBMH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:07:59 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E15C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:18 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id u19so3589977edx.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ejMN+8nc9uRqXepJKfsN6bAVPzr7TBjjq21cetSRdE=;
        b=VXIVgSABEIwiSOlLrE7otJYcec5s0K/eWg7qq1S1nMioZZ+pTnhMxta2YZs0zonEIj
         nbFE69U/0kB2XSFuDZialpCmiSokhKXfGJ+9xS/SZFY24gbX6sjQirpqGrxDQ6PN6qGx
         T3fJWWvth7RealnXXSXxHkA4Np7AraeSgn4JNLqpV+37w/Ch2Q12q9TBkOeSl2Az12i+
         btKX35IpgXHVX52dnV54lFGfoa2L7/FGr9pcDsPlta6+v85Virs4vO5TObyZ8DCBPyqz
         uCLuz9GzKMttUU1xeBJcCNdGHYOMx5xHaL6/0Pm0JDkTCIxJpinw9uAeiK6jBsmaQYMv
         Ovzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ejMN+8nc9uRqXepJKfsN6bAVPzr7TBjjq21cetSRdE=;
        b=dTG7h6tNrIuLKBKyj02kFTmQVVbzpNi4z7Qm2T90AmpMwOjGxMDvmMusyaGUzIUh1v
         cvXlskLB0hVmBgmoXVA+/YKqEO8Ael/lBAloqP9xzajF+4fk9kuJ2obnDApN1gYcRImr
         KwGMQXrjtpfI/5yDHfLREB3TZgtdCpwuu+Hj+ZNY5Td+qeVHOQUcz5i/zR3OhOA+7kPK
         Cr9ODlxxjikIswTjnSO7ZDzjCFYZrlcLCeib9eHoQti6h/q76gVb5KKwMhSclbHHORtR
         LicDwOWIRQjRQOOOP4BKni0knOCyjYoE4xWIyDEGijUYVrzobQ3hK9AZuV8K3zXFstqJ
         FwTw==
X-Gm-Message-State: AOAM530CIHC7dUq7vvxnTHx66PWO4FsUl1+I+IeOmFY+dleXOCHXDs2C
        ZmMMUc12P5PP0uD3KUA15ZrXX8b3WE8=
X-Google-Smtp-Source: ABdhPJyPf3biQkLwm4YhO5KNHyhMBKgWEXRm6Rc4TnfQW0xmlYQ47a7gbcJR8cfQpJ0PsGys1ydExA==
X-Received: by 2002:a05:6402:36a:: with SMTP id s10mr2195105edw.216.1606910837340;
        Wed, 02 Dec 2020 04:07:17 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:16 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] fsnotify fixes and cleanups
Date:   Wed,  2 Dec 2020 14:07:06 +0200
Message-Id: <20201202120713.702387-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

I was working on some non urgent cleanups and stumbled on a bug,
so flushing my patch queue as is.

Patches 1-2 are cleanups needed for the bug fix in patch 3.
This [1] LTP test demonstrates the bug.

Patches 4-5 are pretty simple cleanups that you may or may not like
to apply without the work that they build up to (I started this as
prep work for subtree marks iterator).

Patches 6-7 are optimizations related to ignored mask which we
discussed in the past.  I have written them a while back and had put
them aside because I have no means to run performance tests that will
demonstrate the benefit, which is probably not huge.

Since you suggested those optimizations (at least the first one),
I decided to post and let you choose what to do with them.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fsnotify-fixes

Amir Goldstein (7):
  fsnotify: generalize handle_inode_event()
  inotify: convert to handle_inode_event() interface
  fsnotify: fix events reported to watching parent and child
  fsnotify: clarify object type argument
  fsnotify: separate mark iterator type from object type enum
  fsnotify: optimize FS_MODIFY events with no ignored masks
  fsnotify: optimize merging of marks with no ignored masks

 fs/nfsd/filecache.c                  |   2 +-
 fs/notify/dnotify/dnotify.c          |   2 +-
 fs/notify/fanotify/fanotify.c        |  16 +--
 fs/notify/fanotify/fanotify_user.c   |  44 +++++---
 fs/notify/fsnotify.c                 | 147 +++++++++++++++++----------
 fs/notify/group.c                    |   2 +-
 fs/notify/inotify/inotify.h          |   9 +-
 fs/notify/inotify/inotify_fsnotify.c |  47 ++-------
 fs/notify/inotify/inotify_user.c     |   7 +-
 fs/notify/mark.c                     |  30 +++---
 include/linux/fsnotify_backend.h     |  92 +++++++++++------
 kernel/audit_fsnotify.c              |   2 +-
 kernel/audit_tree.c                  |   2 +-
 kernel/audit_watch.c                 |   2 +-
 14 files changed, 233 insertions(+), 171 deletions(-)

-- 
2.25.1

