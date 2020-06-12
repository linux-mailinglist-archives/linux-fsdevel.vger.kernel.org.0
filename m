Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546661F7605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFLJeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452FC03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so9418426ejr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PDi0Ki4x1VLC5+bGSDsRj6E69AKPY0HOF5IWf6+UD1E=;
        b=BoVoQ28VE0BWJIMo66QDOCDmC/gylIV1XjP5mCpewohM+A7lTGNIzGUSj5UNJBLrCr
         A0cyhra67Pn+IWIOz60mv5rSqF2vnU3qhSpbflnPsWMBnIBJB7UCe4AtooFXVw/iKAei
         ZF+0XGf5s0uOzmHyLvFtU7bYfWtXKhuDhqjR5wDDxB5St3HoCasZOYGQ8uTaLXxJyYdx
         wLMRYVnNsm3GCrSKpSEAaWrBDgf5xwe+UlnQXfdhuYSZbPSnP4TG7S9uV1qkB2pFCvfC
         aSLQ9Od9jx3wZ4u27YZ6aJKipYuXpJLWUpx7l5V7wq0ZttQWWN6sWPDZm/VSNbR/215c
         Ti/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PDi0Ki4x1VLC5+bGSDsRj6E69AKPY0HOF5IWf6+UD1E=;
        b=RsLQRA+5xjjWdMkPb1FaI4OVTaP6wsYzRC67aySCo4RQN6uD7B7+RQEUWcZ5macmbm
         9T9pg1H/rFLPo0aDS31UWZzXOH1gj7CsB5Z8SrDXORAx+9EFHo3UmgIWZhYVhlmiaILC
         vgkVQ0gy2/a+xKqFz1n0UvrMkV0JMMjeY8FDthHyPVYRY6MfGso2H5nHHbLKsOCYHWxO
         yjZTitL11uTYNjAB4mkFpPLcoXMHeNT7U4eQTxEz+Pp6Xy6dT26+sTou8qVewVC2cM2T
         mOkEjxET5izYuogSiMPNmJn7KmqwjlSEUv2/gZoyBRN9ift5hEbfEgrsx3Ohgm6Ez5vX
         9xLg==
X-Gm-Message-State: AOAM530As8kNxxtDc+By6heXbwvL0+SsX4V9LCxjmA5Mq+7zPYB2hIM2
        0GQvtCefnKRKKRQWVVSzprsJWYMt
X-Google-Smtp-Source: ABdhPJwjH8SVszX7eMrkIThxEDp5gbUmaCRKFO8vXni913WnM432M5QMftmyb9o7C7c2Cg77z0H//w==
X-Received: by 2002:a17:906:6453:: with SMTP id l19mr11853778ejn.262.1591954442094;
        Fri, 12 Jun 2020 02:34:02 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:01 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/20] Prep work for fanotify named events
Date:   Fri, 12 Jun 2020 12:33:23 +0300
Message-Id: <20200612093343.5669-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

As you know, the fanotify named events series grew quite large due to
a lot of prep work I needed to do and some minor bugs and optimizations
I encoutered along the way, including Mel's optimization patch that
needed massive conclict resolving with my series.

Most of this series is harmless re-factoring, including some changes
that were suggested by you in the last posting of fanotify named events.
There are some minor bug fixes that change behavior, hopefully for
the better, like the patch to kernfs. But anyway, there should be no
issue with merging any of those patches independently from the rest of
the work.

Most of this series should be fairly easy to review, with the exception
of last two patches that change the way we store a variable size event
struct.

It would be great if you can provide me feedback as early as possible
about the design choices intoduces herein, such as the "implicit event
flags" infrastructure that is needed for requesting events on child for
sb/mount marks.

I was hoping that we could get those changes out of the way and into
linux-next as early as possible after rc1 to get wider testing coverage,
before we move on to reviewing the new feature.

The full work is available on my github [1] including LTP tests [2]
and man page [3]. More on these when I post the patches.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_name_fid
[2] https://github.com/amir73il/ltp/commits/fanotify_name_fid
[3] https://github.com/amir73il/man-pages/commits/fanotify_name_fid

Amir Goldstein (19):
  fsnotify: fold fsnotify() call into fsnotify_parent()
  fsnotify: return non const from fsnotify_data_inode()
  nfsd: use fsnotify_data_inode() to get the unlinked inode
  kernfs: do not call fsnotify() with name without a parent
  inotify: do not use objectid when comparing events
  fanotify: create overflow event type
  fanotify: break up fanotify_alloc_event()
  fsnotify: pass dir argument to handle_event() callback
  fanotify: generalize the handling of extra event flags
  fanotify: generalize merge logic of events on dir
  fanotify: distinguish between fid encode error and null fid
  fanotify: generalize test for FAN_REPORT_FID
  fanotify: mask out special event flags from ignored mask
  fanotify: prepare for implicit event flags in mark mask
  fanotify: use FAN_EVENT_ON_CHILD as implicit flag on sb/mount/non-dir
    marks
  fanotify: remove event FAN_DIR_MODIFY
  fsnotify: add object type "child" to object type iterator
  fanotify: move event name into fanotify_fh
  fanotify: no external fh buffer in fanotify_name_event

Mel Gorman (1):
  fsnotify: Rearrange fast path to minimise overhead when there is no
    watcher

 fs/kernfs/file.c                     |   2 +-
 fs/nfsd/filecache.c                  |   8 +-
 fs/notify/dnotify/dnotify.c          |   8 +-
 fs/notify/fanotify/fanotify.c        | 319 +++++++++++++++------------
 fs/notify/fanotify/fanotify.h        |  81 +++++--
 fs/notify/fanotify/fanotify_user.c   | 108 +++++----
 fs/notify/fsnotify.c                 |  82 ++++---
 fs/notify/inotify/inotify.h          |   6 +-
 fs/notify/inotify/inotify_fsnotify.c |  11 +-
 fs/notify/inotify/inotify_user.c     |   4 +-
 include/linux/fanotify.h             |   6 +-
 include/linux/fsnotify.h             |  44 ++--
 include/linux/fsnotify_backend.h     |  35 ++-
 include/uapi/linux/fanotify.h        |   1 -
 kernel/audit_fsnotify.c              |  10 +-
 kernel/audit_tree.c                  |   6 +-
 kernel/audit_watch.c                 |   6 +-
 17 files changed, 438 insertions(+), 299 deletions(-)

-- 
2.17.1

