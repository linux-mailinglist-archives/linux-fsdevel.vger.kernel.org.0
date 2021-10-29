Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4F43FB8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhJ2LnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhJ2LnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F49C061570;
        Fri, 29 Oct 2021 04:40:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o14so15668447wra.12;
        Fri, 29 Oct 2021 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tf5MEVKIATJIzwg6BIIoE8KMovLDQE6vEgjfBVthkE0=;
        b=cC2e8YtgwuR2bWrJfzYmMGq7L+sspWczRSzEKTa0IaYsETw9L1u43mGHWLqo/7cwz5
         taH1HeRSy/QReZ/9dPercp07PFcbN2mWU8Fx2b/ULBTCcT4GNM5LVvjrfkxt6k28v4mp
         0fWXz4ZjJa1rUbYaufC110Fvxcs6kvSuEbtXF03i7sW4C1CZaML/R9MwXe0j+D6x1wh6
         oIFs9Oa5+P19mc8X4spM0sy7jKr09Onp20+EaiOHEWfnX/O3cnMQUSg0P8ZC2Kg1HmNc
         UQy9B3mhhuLEbl8hlO5kkPNlDk6HGZrriSCkFrVUi/H/FR7UCaUi/fwmfLZZ6J1nETBZ
         zWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tf5MEVKIATJIzwg6BIIoE8KMovLDQE6vEgjfBVthkE0=;
        b=hW4mAkgZtYpFNM3GGcyxD3YNvbX6le9/ZVF7kYKX2t+o7QoELEySsASko0qzWPx1FI
         mkKGwgqNoBvEmCK+2u8b8hw2O86WQ5pLZQyeiJOT2lO3/OoGuduW6Jc4s53BddvB4oCo
         K3KvR5LKRc1Az1uqU+lusokn1Hs7A8+5odBtQAqi/ASf4e6nYEZnOmVI5rISqaLWyyYp
         zLd7DEvlQPh9FbX3zJnbnghCIjIwqfzTIcWpMihGRyzwvaGieVN93ZGo1KDRE0EzbVrT
         oQdZ0MZDVEM+/UsFASdhV0eRIYPZSgAJ2VMd1nN+IIf/4jrV63pZU78Ng4DmZkpEOK8T
         ejTQ==
X-Gm-Message-State: AOAM530gZOAFBUpFGQDZT6W7n78F+mID5N/qXCXxLn7K3uBwFj4IXQwd
        z+IPw5zyA3hQHnKOR2vrBeGHtiJon2M=
X-Google-Smtp-Source: ABdhPJxotIZO9tZ0qRRMDRUCMKHBccCrdBkbq0Ro4GFGfQgEnO6jITfFldOZ7qNxsQAldA1rp7F7tg==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr13420381wry.12.1635507631330;
        Fri, 29 Oct 2021 04:40:31 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:30 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 0/7] Report more information in fanotify dirent events
Date:   Fri, 29 Oct 2021 14:40:21 +0300
Message-Id: <20211029114028.569755-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

This patch set follows up on the discussion on FAN_REPORT_TARGET_FID [1]
from 3 months ago.

With FAN_REPORT_PIDFD in 5.15 and FAN_FS_ERROR on its way to 5.16,
I figured we could get an early (re)start of the discussion on
FAN_REPORT_TARGET_FID towards 5.17.

The added information in dirent events solves problems for my use case -
It helps getting the following information in a race free manner:
1. fid of a created directory on mkdir
2. from/to path information on rename of non-dir

I realize those are two different API traits, but they are close enough
so I preferred not to clutter the REPORT flags space any further than it
already is. The single added flag FAN_REPORT_TARGET_FID adds:
1. child fid info to CREATE/DELETE/MOVED_* events
2. new parent+name info to MOVED_FROM event

Instead of going the "inotify way" and trying to join the MOVED_FROM/
MOVED_TO events using a cookie, I chose to incorporate the new
parent+name intomation only in the MOVED_FROM event.
I made this choice for several reasons:
1. Availability of the moved dentry in the hook and event data
2. First info record is the old parent+name, like FAN_REPORT_DFID_NAME
3. Unlike, MOVED_TO, MOVED_FROM was useless for applications that use
   DFID_NAME info to statat(2) the object as we suggested

I chose to reduce testing complexity and require all other FID
flags with FAN_REPORT_TARGET_FID and there is a convenience
macro FAN_REPORT_ALL_FIDS that application can use.
This restriction could be relaxed in the future if we have a good reason
to do so.

Since the POC branch 3 months ago, I dropped the 'sub_type' field of
the info header, because it did not add much value IMO.

Patches [2] and LTP test [3] are available on my github.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjYDDk00VPdWtRB1_tf+gCoPFgSQ9O0p0fGaW_JiFUUKA@mail.gmail.com/
[2] https://github.com/amir73il/linux/commits/fanotify_target_fid
[3] https://github.com/amir73il/ltp/commits/fanotify_target_fid

Amir Goldstein (7):
  fsnotify: pass dentry instead of inode data for move events
  fanotify: introduce group flag FAN_REPORT_TARGET_FID
  fanotify: use macros to get the offset to fanotify_info buffer
  fanotify: support secondary dir fh and name in fanotify_info
  fanotify: record new parent and name in MOVED_FROM event
  fanotify: report new parent and name in MOVED_FROM event
  fanotify: enable the FAN_REPORT_TARGET_FID flag

 fs/notify/fanotify/fanotify.c      | 108 ++++++++++++++++++++++-----
 fs/notify/fanotify/fanotify.h      | 113 +++++++++++++++++++++++++----
 fs/notify/fanotify/fanotify_user.c |  43 +++++++++--
 include/linux/fanotify.h           |   2 +-
 include/linux/fsnotify.h           |   7 +-
 include/uapi/linux/fanotify.h      |   5 ++
 6 files changed, 235 insertions(+), 43 deletions(-)

-- 
2.33.1

