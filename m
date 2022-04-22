Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1F50B6BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447201AbiDVMHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447282AbiDVMHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E0656753
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so10163217edw.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ne5dF26Vjz0px8PSvDW6klBVWrs/Rw8cdlJlGZkLrgo=;
        b=n58mt7KdKoggHPAYtMDvV4hLksv4jH/XdD4nO+nx05yjdkzOt8/KDi7eg2s3NbDX8B
         F7j+mQhObfE5DAH4mp41psthmc7WHm6kkjaeI5fdCQkKAPcJSlrmFHqcx0udMUNpEFlw
         4EXafDYu6S+ze2mtvj8hyZYvHfHGN36XL/U/nbrXokhWLF1njQHIDGUq0hiDU1s6zkyJ
         Wv1Bvrh85/YC06WflM8AKtFAWJl1Jn3HFvhPyhPytlCeaMoI620052Rlf48yc6in27RA
         rzTIp0LLs40kMA30Y5il86fY+KkiKMVy+zdhrMYRPU5WWD0AOHfblaVi7KmA4GRG+9li
         Z6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ne5dF26Vjz0px8PSvDW6klBVWrs/Rw8cdlJlGZkLrgo=;
        b=2nM8IwokJP3MYYfThb5rLMcgHeqXBhrKoerH8f+X/B5ExcLmnfknWQsnNqRSHCaB7b
         8eYrI5FGjwPS96b1DY4p430pSlQx/o/11cmsV1u+S+T20GKfE6ZvWoeXZL0wM9e26S4G
         /pzLMWkMR/QAfsPMXqevw6oyYYBNfZQSx4BCs1UXwy9X/qbH6oBJBlT+i0RAEivuPxLL
         i/NxuSiFpmRJjhFwikPYPW+8X38Uw47yOD7usydaNXxmzXCLe5yVndE8Wm3hnemhepBZ
         VYohK2MR8qTPC3vZsm5dPzFzRYUWKU1c4nlPtQBvRBlYGuqX1JRvd3teU1HkZJtsxlrg
         Ofgw==
X-Gm-Message-State: AOAM532Bf+TGrn+RHn9UXzcNkAzUXkQPmj6JKTnft0iAQfMRew8NsSe7
        RfgCKjgO7x2QWxIdt2WGeYjpP/Sy9Y8=
X-Google-Smtp-Source: ABdhPJzSVBGa/W3sdXYpJhqYzm/zDUxlgjXxHBDxJosjADO6B/6kIjqiIIqU+gl03qu0wYfAshA02A==
X-Received: by 2002:a05:6402:1104:b0:41d:5f4a:7f5a with SMTP id u4-20020a056402110400b0041d5f4a7f5amr4557131edv.207.1650629009838;
        Fri, 22 Apr 2022 05:03:29 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 00/16] Evictable fanotify marks
Date:   Fri, 22 Apr 2022 15:03:11 +0300
Message-Id: <20220422120327.3459282-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Following v4 patch set addresses your review comments on v3 [3].

I allowed myself to take the clean you requested for
fanotify_mark_update_flags() and recalc argument a bit further.
I hope you will like the result.

Thanks,
Amir.

Changes since v3 [3]:
- Drop FSNOTIFY_GROUP_FLAG() macro
- Make ALLOW_DUPS a group flag
- Return recalc by value from fanotify_mark_update_flags()
- Rename some flags arguments to fan_flags
- Update outdated comments and commit message
- Rebased and tested on v5.18-rc3

Changes since v2 [2]:
- Simplify group lock helpers (Jan)
- Move FSNOTIFY_GROUP_NOFS flag to group object (Jan)
- Split patch of fanotify_mark_user_flags() (Jan)
- Fix bug in case of EEXIST
- Drop ioctl for debugging
- Rebased and tested on v5.18-rc1

Changes since v1 [1]:
- Fixes for direct reclaim deadlock
- Add ioctl for direct reclaim test
- Rebrand as FAN_MARK_EVICTABLE
- Remove FAN_MARK_CREATE and allow clearing FAN_MARK_EVICTABLE
- Replace connector proxy_iref with HAS_IREF flag
- Take iref in fsnotify_reclac_mark() rather than on add mark to list
- Remove fsnotify_add_mark() allow_dups/flags argument
- Remove pr_debug() prints

[1] https://lore.kernel.org/r/20220307155741.1352405-1-amir73il@gmail.com/
[2] https://lore.kernel.org/r/20220329074904.2980320-1-amir73il@gmail.com/
[3] https://lore.kernel.org/r/20220413090935.3127107-1-amir73il@gmail.com/

Amir Goldstein (16):
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

 fs/nfsd/filecache.c                  |  14 ++--
 fs/notify/dnotify/dnotify.c          |  13 +--
 fs/notify/fanotify/fanotify.h        |  12 +++
 fs/notify/fanotify/fanotify_user.c   | 100 +++++++++++++++--------
 fs/notify/fdinfo.c                   |  21 ++---
 fs/notify/fsnotify.c                 |   4 +-
 fs/notify/group.c                    |  32 +++++---
 fs/notify/inotify/inotify.h          |  19 +++++
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 fs/notify/inotify/inotify_user.c     |  47 ++++++-----
 fs/notify/mark.c                     | 115 ++++++++++++++++++---------
 include/linux/fanotify.h             |   1 +
 include/linux/fsnotify_backend.h     |  67 ++++++++++++----
 include/uapi/linux/fanotify.h        |   1 +
 kernel/audit_fsnotify.c              |   5 +-
 kernel/audit_tree.c                  |  34 ++++----
 kernel/audit_watch.c                 |   2 +-
 17 files changed, 324 insertions(+), 165 deletions(-)

-- 
2.35.1

