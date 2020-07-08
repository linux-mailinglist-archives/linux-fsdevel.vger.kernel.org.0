Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F232185C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGHLMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgGHLMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17443C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so48446450wru.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqU2Uiw1+L19r7fgkV1X/uqPYD/gZMcb2AA/s1T80Ks=;
        b=CBcExC4njMa+jk5v6B1H9fbmoNGeDQHDinRetk3mgPDTUwaEvyi7ujjlpspdBA8aG2
         JyyA/rq/mwBKVTSowb3CyUy2IlPBtdPX6Hsg0iJKafU420CrEZdo2CEMkF+DNsvw5yA9
         RHaeCahVd64554oOukU9BwnAtWk2yMSf+vUHNNHA2WFsDpSAxbJhN0aQpm7V4wc6bUnd
         bH/0cKKPhkj46x3DFn6gxzA3UDGlaByyaV57lKDmJb2d1S1AMY/DoVt9fqPEf+eRg6BT
         yPl7hDpVzYeI7tnWj0RM3Q8SzxxQBhnCtCtoLB3wN8Vs9BsSr1wj8CGFI4NpA2x+itVD
         Z94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqU2Uiw1+L19r7fgkV1X/uqPYD/gZMcb2AA/s1T80Ks=;
        b=TF/D4Zb81Wd0zj9Oc0v84VvwazMBUstSBuBzREJ2uW2AN9tX4jQboDmUJQ/bIatBEc
         wlcJgF3uTOJkFBBCOCY+lO/E83TQu4IzJ7lhlff1Ll/LK0eyeO0MVIbZX7DA9pXr1EeO
         emeXdGhd2iJjVbpAtm3MpVInIog3nPDYKIiEjKLuAyWC99MZgYQ1kfsume1Elo8GvZ+j
         6uKKfb9uBucuX6KJmNVGcclFFqkcrHQhy7js+2ixTci9app52rUNXXfTE8/DEcrRdQOZ
         ZaP0fzEiQWvNFfPjP+4pyPl5mxQz4gyI7hqC+gH6dwjvVRIK/3vFTXZb4pWWp1AT8zuZ
         j+1w==
X-Gm-Message-State: AOAM530o02R0B/qWImn2vMEUr3HXCseV0QPkujgMcZt7wJcIZTkpZhzl
        wKGpX7Jtt6nEu+ykaAgI0I0=
X-Google-Smtp-Source: ABdhPJwpbB5k9H/WTBx8lr/DpPHU4XKM09qCXtrvoA9FQlT4OLUFohAmQD1Ldi3jrxSjky2UZbupPw==
X-Received: by 2002:adf:9561:: with SMTP id 88mr27377717wrs.240.1594206755851;
        Wed, 08 Jul 2020 04:12:35 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:35 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/20] Prep work for fanotify events with name info
Date:   Wed,  8 Jul 2020 14:11:56 +0300
Message-Id: <20200708111156.24659-21-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

Following patches address your review comments on v2 [1].
Branch is avalable at [2] and test branch of complete work of the moment
is available at [3].

Thanks,
Amir.

Changes sinve v2:
- Re-parcel variable size buffer using struct fanotify_info
- Move space reservation of _inline_fh_buf to struct fanotify_fid_event
- Add Acks on kernfs patch

[1] https://lore.kernel.org/linux-fsdevel/20200612093343.5669-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fanotify_prep-v3
[3] https://github.com/amir73il/linux/commits/fanotify_name_fid

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
  fanotify: use struct fanotify_info to parcel the variable size buffer
  fanotify: no external fh buffer in fanotify_name_event

Mel Gorman (1):
  fsnotify: Rearrange fast path to minimise overhead when there is no
    watcher

 fs/kernfs/file.c                     |   2 +-
 fs/nfsd/filecache.c                  |   8 +-
 fs/notify/dnotify/dnotify.c          |   8 +-
 fs/notify/fanotify/fanotify.c        | 354 ++++++++++++++++-----------
 fs/notify/fanotify/fanotify.h        | 110 +++++++--
 fs/notify/fanotify/fanotify_user.c   | 110 +++++----
 fs/notify/fsnotify.c                 |  82 ++++---
 fs/notify/inotify/inotify.h          |   6 +-
 fs/notify/inotify/inotify_fsnotify.c |  11 +-
 fs/notify/inotify/inotify_user.c     |   4 +-
 include/linux/fanotify.h             |   6 +-
 include/linux/fsnotify.h             |  43 ++--
 include/linux/fsnotify_backend.h     |  34 ++-
 include/uapi/linux/fanotify.h        |   1 -
 kernel/audit_fsnotify.c              |  10 +-
 kernel/audit_tree.c                  |   6 +-
 kernel/audit_watch.c                 |   6 +-
 17 files changed, 500 insertions(+), 301 deletions(-)

-- 
2.17.1

