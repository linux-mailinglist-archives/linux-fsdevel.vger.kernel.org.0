Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34489221EA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGPImj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGPImi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19592C061755;
        Thu, 16 Jul 2020 01:42:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so10636105wmo.1;
        Thu, 16 Jul 2020 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LZsXAxBNaqwxcZlSI96i4cu0PkQFg6f9qhTijuh9QsU=;
        b=E4JFCCxL64p56fUbBfP6MqH9jJ3ANoLudbfYznnRL5YXdC7DYaStsMCqmJkeZtLcMp
         FHpIrQM10hH5Be54opvfnElGrTXPzlLVs78+XEIPevxEUsKhh0F4dfx1A7k6wuBsLjkl
         ktC0xDQqo3Ye9+DtrQgEjq0hVtwFsyhozb2kaUaoMWfwzFcs8d82yFjsyPjCPMsHBs25
         RWrPvHEjq/Y5+CPWsOBrXKyhcpMnQFviW8Y0zL5VC1MRaafhwdugL7QoFV/pf0vQhdzr
         Zgr5w30yz6TvU7WrqyhiNBz5ZnFgTONILl02nOn0DnV8ZfQ/l00ZwkEbMOGGBrBNfIka
         a48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LZsXAxBNaqwxcZlSI96i4cu0PkQFg6f9qhTijuh9QsU=;
        b=ifSc3Spqq2IUEoTJtm0g8Y6JkLHzdkr76s/0XE0dagVxO2mfeVd41N4RRn+n9lQQ5c
         B9vfixZ8N7B4G8dUTYa2b/8KZZ0QW25VeAJ3rBLh6omQQUFqRwypmNyrDNy4a5ahp4eK
         pKe3CnEk9Q3N2hdPbCm47eMPBj1EoQzdYdyFtmmTWu/R/vzDkXASImGeearENQtf6vCI
         E+E2/wJz6P/L3c2m1VlMVDlMi6DRMHPIsSSLDrBpvjttDGNzHaTADzRxk0CYBLhJmqsF
         jJd/xmEDZu9AtgcGfXH5m6OkkzthjoQiZ3q4nftwbXo4sKV1r/lSSPD+iPcFmp/GqoHv
         ij+Q==
X-Gm-Message-State: AOAM531GsKbqRaE4LfmOAFZ8ouQuDYTUOVYpNALIC0HbLQdU9edVDxbQ
        x8TyK1pFpLhBx+i6BT/CRUs=
X-Google-Smtp-Source: ABdhPJzl5fYPqMCJfDfO/Md0eeZ9x2cb4E2NmiMWExtDbiJFIi9a/mbowY+/TxoGJHWIXgC+1DggXw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr3263761wmk.175.1594888956770;
        Thu, 16 Jul 2020 01:42:36 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:35 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v5 00/22] fanotify events with name info
Date:   Thu, 16 Jul 2020 11:42:08 +0300
Message-Id: <20200716084230.30611-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

This patch set implements the FAN_REPORT_NAME and FAN_REPORT_DIR_FID
group flags.

I previously posted v3 of prep patch series [1] and v4 of follow up
series [2].  Since then you pick up several prep patches, so this
posting includes the rest of the prep patches along with the followup
patches with most of your comments addressed.

Regarding the use of flag FS_EVENT_ON_CHILD and the TYPE_CHILD mark
iterator, I did not change that because I was not sure about it and it
is an internal implementation detail that we can change later.
But the discussion about it made me realize that dnotify event handler
wasn't properly adapted, so I added a patch to fix it.

The patches are available on github [3] based on your fsnotify branch.
man-pages [4] LTP tests [5] and a demo [6] are also available.

Thanks,
Amir.

Changes since v4 (and since prep series v3):
- Some prep patches already picked up - the rest are included here
- Parcel variable event info according to your suggestions
- Separate unrelated change from FAN_MOVE_SELF patch
- Add adaptation of dnotify to unified event on parent/child
- Re-structure fsnotify_parent() based on your review comments

[1] https://lore.kernel.org/linux-fsdevel/20200708111156.24659-21-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20200702125744.10535-1-amir73il@gmail.com/
[3] https://github.com/amir73il/man-pages/commits/fanotify_name_fid-v5
[4] https://github.com/amir73il/linux/commits/fanotify_name_fid
[5] https://github.com/amir73il/ltp/commits/fanotify_name_fid
[6] https://github.com/amir73il/inotify-tools/commits/fanotify_name


*** BLURB HERE ***

Amir Goldstein (22):
  fanotify: generalize the handling of extra event flags
  fanotify: generalize merge logic of events on dir
  fanotify: distinguish between fid encode error and null fid
  fanotify: generalize test for FAN_REPORT_FID
  fanotify: mask out special event flags from ignored mask
  fanotify: prepare for implicit event flags in mark mask
  fanotify: use FAN_EVENT_ON_CHILD as implicit flag on sb/mount/non-dir
    marks
  fsnotify: add object type "child" to object type iterator
  fanotify: use struct fanotify_info to parcel the variable size buffer
  fanotify: no external fh buffer in fanotify_name_event
  dnotify: report both events on parent and child with single callback
  inotify: report both events on parent and child with single callback
  fanotify: report both events on parent and child with single callback
  fsnotify: send event to parent and child with single callback
  fsnotify: send event with parent/name info to sb/mount/non-dir marks
  fsnotify: remove check that source dentry is positive
  fsnotify: send MOVE_SELF event with parent/name info
  fanotify: add basic support for FAN_REPORT_DIR_FID
  fanotify: report events with parent dir fid to sb/mount/non-dir marks
  fanotify: add support for FAN_REPORT_NAME
  fanotify: report parent fid + name + child fid
  fanotify: report parent fid + child fid

 fs/kernfs/file.c                     |  10 +-
 fs/notify/dnotify/dnotify.c          |  42 +++--
 fs/notify/fanotify/fanotify.c        | 273 ++++++++++++++++++++-------
 fs/notify/fanotify/fanotify.h        | 103 ++++++++--
 fs/notify/fanotify/fanotify_user.c   | 192 ++++++++++++++-----
 fs/notify/fsnotify.c                 | 132 +++++++++----
 fs/notify/inotify/inotify_fsnotify.c |  44 ++++-
 include/linux/fanotify.h             |   6 +-
 include/linux/fsnotify.h             |  15 +-
 include/linux/fsnotify_backend.h     |  35 +++-
 include/uapi/linux/fanotify.h        |  15 +-
 11 files changed, 662 insertions(+), 205 deletions(-)

-- 
2.17.1

