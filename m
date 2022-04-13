Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5C4FF307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiDMJME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiDMJMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08CB19289
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so1631909wrr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Brpdpz3ywJYMy/0wgM7rg8C3Rfqyr9Zfmt63qLuxz7s=;
        b=BeRC0ke8jgooLugui5z6ufCnowCq0c4Ux5Sz7aBxdsWwBt7LR/LYjl/2fQs5Oqh2Nj
         RZsxXZz2c8zrSlX8Gj9Fe0QcPcZVVoPjIltLuUHNov2lsyctR9hGgk0wxit9UMoQMxJu
         fodcaF6cUhuhxV/6ixslnmN0ZvBsZt/nHnIssj+LrrxU9jbgzSOhHTl4OMdjrPau4KCo
         M53fpJHMB9tgKXx3WDI06fQR+CsQCPSqgA0jalEnQz3nJJz7S3S0OTgaXaszzkZn8roc
         lSDkPQhF/nneP0q+iiLChmF1a4OzN6JYCH6XF5hYsqJnXG+2xcrsUxrAarROqq6bzFEu
         S6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Brpdpz3ywJYMy/0wgM7rg8C3Rfqyr9Zfmt63qLuxz7s=;
        b=lmSnEaNdgLymFfwrJhk9POgEAmQ736OiTVy1eqvM6kk64w0AlK24ZfKmmgmDzY01Cd
         MTyrod3NmoGmvY1DgJEm8sNTzlelajenM7hmoj9eFaU88U1eHM2cKljHis/W36xAKMHP
         eVn2ykx3gJljK4SCyjxG+NLYo/4Z6idGU8KuVvMQ1YeCR32nHKXFULMWGpoACicp1/D7
         kAIAEKJbrZC9d1BXEd6udHlwE3pNCTme2s/THIWf7FSkjJjm5fZZTQa0278RYZLZZVTm
         znJzgi4YAzLKZK0nR6ZHTnK+4pZfJDcxNFGNuWDUqvG8Db3BbvnwoVnMBOy6c3oxj3hV
         3E1A==
X-Gm-Message-State: AOAM533mdthhwtD5xu0dkp9mdGBYANdrLaILV0zGfsDTWDxBCAuPaEUN
        n8aFcDX2XxpQObudipoHQ6M=
X-Google-Smtp-Source: ABdhPJz3WOfGSBht1lHvg3Prk9LIbVjXX2/aeQO2fPkZHRhkJ5TBQslmBEsm7RBT50MZt30fUxupuA==
X-Received: by 2002:a5d:6650:0:b0:207:ac24:a825 with SMTP id f16-20020a5d6650000000b00207ac24a825mr7135579wrw.97.1649840978194;
        Wed, 13 Apr 2022 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/16] Evictable fanotify marks
Date:   Wed, 13 Apr 2022 12:09:19 +0300
Message-Id: <20220413090935.3127107-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Following v3 patch set addresses your review comments on v2 [2].

Please see LTP test [3] and man page draft [4] for evictable marks.

Thanks,
Amir.

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
[3] https://github.com/amir73il/ltp/commits/fan_evictable
[4] https://github.com/amir73il/man-pages/commits/fan_evictable

Amir Goldstein (16):
  inotify: show inotify mask flags in proc fdinfo
  inotify: move control flags from mask to mark flags
  fsnotify: fix wrong lockdep annotations
  fsnotify: pass flags argument to fsnotify_add_mark() via mark
  fsnotify: pass flags argument to fsnotify_alloc_group()
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
 fs/notify/fanotify/fanotify_user.c   |  95 +++++++++++++++-------
 fs/notify/fdinfo.c                   |  21 ++---
 fs/notify/fsnotify.c                 |   4 +-
 fs/notify/group.c                    |  32 +++++---
 fs/notify/inotify/inotify.h          |  19 +++++
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 fs/notify/inotify/inotify_user.c     |  49 ++++++-----
 fs/notify/mark.c                     | 117 ++++++++++++++++++---------
 include/linux/fanotify.h             |   1 +
 include/linux/fsnotify_backend.h     |  75 ++++++++++++-----
 include/uapi/linux/fanotify.h        |   1 +
 kernel/audit_fsnotify.c              |   6 +-
 kernel/audit_tree.c                  |  34 ++++----
 kernel/audit_watch.c                 |   2 +-
 17 files changed, 330 insertions(+), 167 deletions(-)

-- 
2.35.1

