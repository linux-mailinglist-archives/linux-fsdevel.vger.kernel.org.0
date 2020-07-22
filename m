Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C322298C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgGVM7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgGVM7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893AEC0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so1816449wru.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5rxB5kMGUf1UmZHOAfWHKgChOktZGKgG0Tz9CSZVo4E=;
        b=ZRNvQG6JlaxOacgkek/GtEAC/GUt8AKJHwkFeYmfNmvIDlnzJV6w0mgsBvYwuVW0Vg
         rjFCpFkImenupzGw6wXNb1KWLfXAiM1sOAoQmaqdpOYs5l9m1ipHT4LgihciR0BFtWDR
         hrahv5bc2sbGA1iANTT6aZimFfbId95i/hZSf1AdbG+i0OWcwRhpXOo8EUpCXFmWoCWt
         rgfyFYMCux6XhGmH/NuQ2IMWc47iDnhFSfxGSMPCGd3M/FIYi3w+qkxKXwmv5qpO3k3q
         y7YmXwlUmUs5EQxSMZXNeBqu+CrXe4p1fGkucX9cwsZt7z4+QOLMxz9uC8pCMUdcvZvl
         Vyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5rxB5kMGUf1UmZHOAfWHKgChOktZGKgG0Tz9CSZVo4E=;
        b=cSp+TEVUOck8mYIJAqEUo+cpVoodaS1O7iLuIur+f5Hj6jUbExCkhDeQFOhHqXBgrF
         kM03CXBPAWWJAG75bqkGx2sIw1av94L4LmztMh7IuuaOGEhP0tXmpojbCL61o+KbHWBq
         gk2dosZlxl34YPOX0kvWVIGryv+Vtj9dH2luzL+iYu9tzLighf4UN4x2RXOk5DaG30Ze
         g3MDW5jt5IBo9q0tEbSvJp6bZgovfdMLFg1xaJHvoyVUBhgaALXGHsaSgYLVIRfULq/L
         aUobkCVFdYtBuNVckkBm/QRF5LttIo7dcxsCGXDLP4NWJlKtAL1W7yhBKtW9HstWMZy0
         rs2Q==
X-Gm-Message-State: AOAM533L1pj7zfLmXdjBDDnN7R5gz1RiPakFrqbwQbTgbeBrP0XCfjRZ
        gIJg1lPu81sW9BwUBmu32IKyBp19
X-Google-Smtp-Source: ABdhPJx7m4QvFNkWJ6CHt1PEZPnVWlSoqWWR4W1EnvmXY/jiWObAEWfIE8ov2sARwm3fGiqY1vCYHg==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr8940263wrh.181.1595422742154;
        Wed, 22 Jul 2020 05:59:02 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:01 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] Fixes for fanotify name events
Date:   Wed, 22 Jul 2020 15:58:40 +0300
Message-Id: <20200722125849.17418-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Following your feedback [1] to fanotify name events, I wrote some LTP
tests [2] to add missing test coverage:

1) dnotify/inotify: report event to both parent and child -
   catches the dnotify bug I had in v4 after unified event patch

2) fanotify10: add groups with FAN_REPORT_NAME to the setup -
   catches the bug you noticed in fanotify_group_event_mask()

3) fanotify10: add test cases with ignored mask on watching parent -
   catches the inconsistecy with ignored masks that you noticed [*]

The patches in this series apply to your fsnotify branch and are
avaiable on my fsnotify-fixes branch [3].

Patch 1 fixes issue #2 above
Patch 2 fixes another issue found by tests
Patch 3 fixes a minor issue found by code review
Patches 4-6 simplify the code based on your suggestions
Patch 7 depends on 4-6 and fixes issue #3 above [*]

Optional patches:
Patch 8 implements your suggestion of simplified handler_event()
Patch 9 is a possible fix for kernel test robot reported performance
regression. I did not get any feedback on it, but it is trivial.

Thanks,
Amir.

[*] The tests for merging ignored mask on watching parent set the
    event FAN_OPEN in both mark mask and ignored mask and set the
    flag FAN_EVENT_ON_CHILD in mark mask, because the expected behavior
    in this case is well defined.  I have patches to fix the case of
    FAN_OPEN in ignored mask and flag FAN_EVENT_ON_CHILD in mark mask,
    but decided not to post them at this time.

[1] https://lore.kernel.org/linux-fsdevel/20200716171332.GK5022@quack2.suse.cz/
[2] https://github.com/amir73il/ltp/commits/fsnotify_parent
[3] https://github.com/amir73il/linux/commits/fsnotify-fixes

Amir Goldstein (9):
  fanotify: fix reporting event to sb/mount marks
  inotify: do not set FS_EVENT_ON_CHILD in non-dir mark mask
  audit: do not set FS_EVENT_ON_CHILD in audit marks mask
  fsnotify: create helper fsnotify_inode()
  fsnotify: simplify dir argument to handle_event()
  fsnotify: pass dir and inode arguments to fsnotify()
  fsnotify: fix merge with parent mark masks
  fsnotify: create method handle_inode_event() in fsnotify_operations
  fsnotify: pass inode to fsnotify_parent()

 fs/kernfs/file.c                 |  11 ++-
 fs/nfsd/filecache.c              |  12 ++--
 fs/notify/dnotify/dnotify.c      |  38 +++-------
 fs/notify/fanotify/fanotify.c    |  17 +++--
 fs/notify/fsnotify.c             | 118 +++++++++++++++++++++++++------
 fs/notify/inotify/inotify_user.c |  14 ++--
 include/linux/fsnotify.h         |  44 ++++++------
 include/linux/fsnotify_backend.h |  33 ++++++---
 kernel/audit_fsnotify.c          |  22 +++---
 kernel/audit_tree.c              |  10 ++-
 kernel/audit_watch.c             |  19 +++--
 kernel/trace/trace.c             |   3 +-
 12 files changed, 196 insertions(+), 145 deletions(-)

-- 
2.17.1

