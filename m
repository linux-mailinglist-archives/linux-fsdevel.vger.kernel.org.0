Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC58456ACD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhKSHUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhKSHUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC4C061574;
        Thu, 18 Nov 2021 23:17:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r8so16390206wra.7;
        Thu, 18 Nov 2021 23:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoYweWyRQrlnGOvNgUpDHZM1X4zrfzTh4Zs90v9oNY8=;
        b=i2p/z9ll7ABx77lkW+Q+ZIBW+TeQORB6qptf/LDhOn6yaXxf45gtheIGWLG0xKOFeD
         +5XDZfhNsOhhGTgnC0dg3FWbW/mSyCdj/syJ7inbr6Prv84cIVM2n6jMRqRG7jihGZ+Y
         pW8tdyz18a3waf+rjZxmMZN6z0H2OXLvbGSfVk5BAfNs+xE/MXE1FR2gWUVNf14V00m8
         RWaIRfMHiW/BJtQvb/zSUUNnV8keieUyCf8yfSaXjsUjccIk6PcRIlNCzAl6kSUhCK4+
         8uWCB9ueUFqp7YB+pOU1yg9jMSxCO+5EBL/9k+aIJNIP2YEy2eRGwiwplAgfcyZj314C
         yO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WoYweWyRQrlnGOvNgUpDHZM1X4zrfzTh4Zs90v9oNY8=;
        b=Tf3QGyXEMN/mxZ1mJqDsFayhPZk2O2LhrZt3+7aI5M0S+u0dgFc6tFAEgeZ9UUsBmI
         VxdxOWr7zhS6i83PZ5EBqQ303yTNwiJ3EwtrMKKAfDrupiKbKbT2Ph9YkJz9hwRkCX3v
         za8Dz4tAWPjGBC4p18/tIDxesr6bSgsH9/JdZAcZ7OgiDeGjydgHwgZ4luNosHMW0h0t
         R+9f+aHaSV2KxeKz5TZ13vYY0s0qV/nM0Vzatzp0guoFYRwYu+9SVAd/I2DTglkbEKAX
         qwXAHl1kSI7agZNMzVXElLzVAeIrqy09E2DyqPhpgdf3OAJQlz1S68fgwGLx7PBuSdCi
         HJcw==
X-Gm-Message-State: AOAM531+nqkcuJskJHupTJHkPUL0HG+N0yv3mG1WWQt3BivTKBLpF122
        oA2FvIio+Tu2r5pi7shGKZKqZTeZffs=
X-Google-Smtp-Source: ABdhPJxZvK/h4bVj4SRgPikUdxyITV+trRdWHKIUTI7gP6bpfMk1wEytp7Mk/TMI0mfgXONkFsIHrQ==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr4694603wrw.434.1637306261984;
        Thu, 18 Nov 2021 23:17:41 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:41 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/9] Extend fanotify dirent events
Date:   Fri, 19 Nov 2021 09:17:29 +0200
Message-Id: <20211119071738.1348957-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

This is the 2nd version of FAN_REPORT_TARGET_FID patches [1].

In the first version, extra info records about new and old parent+name
were added to FAN_MOVED_FROM event.  This version uses a new event
FAN_RENAME instead, to report those extra info records.
The new FAN_RENAME event was designed as a replacement for the
"inotify way" of joining the MOVED_FROM/MOVED_TO events using a cookie.

FAN_RENAME event differs from MOVED_FROM/MOVED_TO events in several ways:
1) The information about old/new names is provided in a single event
2) When added to the ignored mask of a directory, FAN_RENAME is not
   reported for renames to and from that directory

The group flag FAN_REPORT_TARGET_FID adds an extra info record of
the child fid to all the dirent events, including FAN_REANME.
It is independent of the FAN_RENAME changes and implemented in the
first patch, so it can be picked regardless of the FAN_RENAME patches.

Patches [2] and LTP test [3] are available on my github.
A man page draft will be provided later on.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20211029114028.569755-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fan_rename
[3] https://github.com/amir73il/ltp/commits/fan_rename

Amir Goldstein (9):
  fanotify: introduce group flag FAN_REPORT_TARGET_FID
  fsnotify: generate FS_RENAME event with rich information
  fanotify: use macros to get the offset to fanotify_info buffer
  fanotify: use helpers to parcel fanotify_info buffer
  fanotify: support secondary dir fh and name in fanotify_info
  fanotify: record old and new parent and name in FAN_RENAME event
  fanotify: record either old name new name or both for FAN_RENAME
  fanotify: report old and/or new parent+name in FAN_RENAME event
  fanotify: wire up FAN_RENAME event

 fs/notify/dnotify/dnotify.c        |   2 +-
 fs/notify/fanotify/fanotify.c      | 209 +++++++++++++++++++++++------
 fs/notify/fanotify/fanotify.h      | 142 ++++++++++++++++++--
 fs/notify/fanotify/fanotify_user.c |  75 +++++++++--
 fs/notify/fsnotify.c               |  14 ++
 include/linux/dnotify.h            |   2 +-
 include/linux/fanotify.h           |   5 +-
 include/linux/fsnotify.h           |   9 +-
 include/linux/fsnotify_backend.h   |   6 +-
 include/uapi/linux/fanotify.h      |  12 ++
 10 files changed, 405 insertions(+), 71 deletions(-)

-- 
2.33.1

