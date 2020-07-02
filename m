Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13EF2123DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGBM6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbgGBM5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:57:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C334C08C5C1;
        Thu,  2 Jul 2020 05:57:55 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so25189047wrw.1;
        Thu, 02 Jul 2020 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vZWa1OkafsMVoikBYT73kEpsHbnGbrk/usRmQjvvTGw=;
        b=UvZuwxVhaN5i0Kc+zOwV5WxiC7YMUR4BvNIff6umw5e1ji1rQSatvVivYgeHhHXwMt
         BJwr1YnSe/E3MqM2hA4sACOvZHPr0/rc6kZMUiaUv6s4+L/2bZwvLwuKJ2JUO+Eef4fW
         WyfQ8H/ZKWFD1vDOtlYYhFlLzS+b4uB4EzkNfHQfKi/3v7oGbxLaVvBzvFV2s0GxctL+
         2TCVgfgcTRHhY7NgpTlx4/9jCOIBz2KVEmpI3OSSbiOpyxkE1fNetaqwYDNLC2l/B7tu
         DZ7gQ/ttgcDb5hc2PjKWyI0j30A7ZJ+JxuItH2UYNcyqfALt0Cn47iAOkylcLaHiqtba
         bYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vZWa1OkafsMVoikBYT73kEpsHbnGbrk/usRmQjvvTGw=;
        b=lxinjEA8OYJCINreKV2t2SwNWiuZSM85eOAlng8KjxQ9ILbL5TZUfmfbyOtmuftRz1
         POiSm+C6E3t67g3quTfZPNN7xtDrD3qNej97rOJvKj4CJ2dGXmJRwp40gdyhNajlN2tt
         9I4dEDy8/vQbTO7QJAww8oz/i4kXXsaszkTDOt2cKH7NDOOeL0IXVl5+owkIu48s8Cs+
         /Bi0w3YkkoTUWAJuMhflRS07H4UdU3wyK3ZS/SehawFKqBXPOq5CCYjslEIgx5lq23vj
         QDVbFkYK+7wzTPpQ2EQopC/IlM/rG2JLR/xnM/Wi4rQHMpNfIB7vU+LcjXBvA9vFeDsz
         o7+g==
X-Gm-Message-State: AOAM531cT4g2JnHycV9U1HC1bGuMJYR+OiaSJNXGJFt9y9o9oqzzZqZC
        nK2XlFnH6sZ4TrLka2vr8xfVQXby
X-Google-Smtp-Source: ABdhPJzMD26D1wYq6fwZj5CZ/02ae4CYtc/X4mljpJLQjEdoijaRu9jJ1kwiTogXvUOV1ya1KZq0Xw==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr31191931wru.79.1593694674331;
        Thu, 02 Jul 2020 05:57:54 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:57:53 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 00/10] fanotify events with name info
Date:   Thu,  2 Jul 2020 15:57:34 +0300
Message-Id: <20200702125744.10535-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

This patch set implements the FAN_REPORT_NAME and FAN_REPORT_DIR_FID
group flags.  It depends on the prep patch series I posted earlier [1].

Previously on this patch series...

In v2 [2] I implemented both the event FAN_DIR_MODIFY and the group flag
FAN_REPORT_NAME.  We decided to merge only the FAN_DIR_MODIFY part for
v5.7-rc1 and leave the rest for later after we complete the discussion
or user API for FAN_REPORT_NAME.

As the discussions continued on v3 [3], we came to a conclusion that the
FAN_DIR_MODIFY event is redundant and we disabled it before the release
of v5.7.

This time around, the patches are presented after the man page for the
user API has been written [4] and after we covered all the open API
questions in long discussions among us without leaving any open ends.

The patches are available on github branch fanotify_name_fid [5] based
on v5.7-rc3 + Mel's revert patch.  LTP tests [6] and a demo [7] are also
available.

Thanks,
Amir.

Changes since v3:
- All user API aspects clearly defined in man page
- Support flag FAN_REPORT_DIR_FID in addition to FAN_REPORT_NAME
- Support most combinations of new flags with FAN_REPORT_FID
- Supersede the functionality of removed FAN_DIR_MODIFY event
- Report name for more event types including FAN_MOVE_SELF
- Stronger integration with fsnotify_parent() to eliminate duplicate
  events with and without name

[1] https://lore.kernel.org/linux-fsdevel/20200612093343.5669-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20200217131455.31107-1-amir73il@gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20200505162014.10352-1-amir73il@gmail.com/
[4] https://github.com/amir73il/man-pages/commits/fanotify_name_fid
[5] https://github.com/amir73il/linux/commits/fanotify_name_fid
[6] https://github.com/amir73il/ltp/commits/fanotify_name_fid
[7] https://github.com/amir73il/inotify-tools/commits/fanotify_name

Amir Goldstein (10):
  inotify: report both events on parent and child with single callback
  fanotify: report both events on parent and child with single callback
  fsnotify: send event to parent and child with single callback
  fsnotify: send event with parent/name info to sb/mount/non-dir marks
  fsnotify: send MOVE_SELF event with parent/name info
  fanotify: add basic support for FAN_REPORT_DIR_FID
  fanotify: report events with parent dir fid to sb/mount/non-dir marks
  fanotify: add support for FAN_REPORT_NAME
  fanotify: report parent fid + name + child fid
  fanotify: report parent fid + child fid

 fs/kernfs/file.c                     |  10 ++-
 fs/notify/fanotify/fanotify.c        |  96 +++++++++++++++++++++--
 fs/notify/fanotify/fanotify.h        |   2 +
 fs/notify/fanotify/fanotify_user.c   | 111 +++++++++++++++++++++++----
 fs/notify/fsnotify.c                 | 103 ++++++++++++++++++-------
 fs/notify/inotify/inotify_fsnotify.c |  37 ++++++---
 include/linux/fanotify.h             |   2 +-
 include/linux/fsnotify.h             |  15 ++--
 include/linux/fsnotify_backend.h     |  32 +++++++-
 include/uapi/linux/fanotify.h        |  15 +++-
 10 files changed, 345 insertions(+), 78 deletions(-)

-- 
2.17.1

