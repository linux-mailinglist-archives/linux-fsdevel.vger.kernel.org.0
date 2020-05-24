Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC71DFD87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgEXHYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgEXHYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 03:24:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48DC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 00:24:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n24so17484129ejd.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JO4uU65ZOkWM7aYMwy1rabi0l1Bb0mKSWzHjLOZcE/0=;
        b=QPomLnJHAOoa4UdCCI3k5puY3aiAsA/39LyTyr4w/1z8HMVxhd3wWMdAWRd0Tm645h
         PvCrP+nhA5qugQ9nOK6EHS2aU5de4zyJmVJT+xmaUbUH9CBQUGmbyY280wqHIX3aVU9l
         6xjt1M/lEDqHpWBD//H/++WMZISskfr7uN0q3NSyBRanhGGSVHYYnw9ogyQpR45Ny3PB
         J8L1cwbiwaHG2XBJGAJKjo7iMFNoN2lx3osVrrpMjanJL69ygd5+y1vneFhTK9oHCwHG
         QadOOLZA3H8EDrO8cFYWFHET/jBv0XJIv5v6kUSdr/cePZGpDkIn1ahnbA5gGsZt3GLO
         h11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JO4uU65ZOkWM7aYMwy1rabi0l1Bb0mKSWzHjLOZcE/0=;
        b=GQsYC80efSyMG4ej3WOkkZdvU+wUUdh05fuzFhWvmKT6RyNIhQ9IOMR5yv6nQpW8Qx
         5DxFtG6T8cIASo891BkK7RIK8PbJjSPvL4pINNTW9/4PvaCVYTO0Qv/2pe87ZgvoXiQc
         1sqXTap1jQ2H6RgA5cYBF3RvX/JNvqOUIc1aFbAg4EvxLb14aU0gJJN3DgoRkwKjISe5
         uU6UX6UY/PcZXU1comKVZ2Y6/npWJyK+yBb5c3VLStUSkL9AvUZBeuiyliUJW/gj2xnw
         PRcSe0vlWDuZL0qw2zRKBF2UWRPMRxg8hmQtmd1W4eCyCVVAdkPgJ1zW1mi60vpfJ84b
         sUfA==
X-Gm-Message-State: AOAM531tH9wAgncSv7PlOJabyetHqB4hepvCt+hzNijBNKdbnHm4HBQL
        Rt4kANqjs+H/gTB8O/1+B/c=
X-Google-Smtp-Source: ABdhPJxBLf8SSKsBN+n+k9fc7a27wWlauaxRSUB+JHjF2q6eCsro5hyGmupuFL2gSCUitwKPNck+Pw==
X-Received: by 2002:a17:906:914a:: with SMTP id y10mr13943094ejw.355.1590305088060;
        Sun, 24 May 2020 00:24:48 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id rn17sm12515540ejb.115.2020.05.24.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 00:24:47 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: fix ignore mask logic for events on child and on dir
Date:   Sun, 24 May 2020 10:24:41 +0300
Message-Id: <20200524072441.18258-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The comments in fanotify_group_event_mask() say:

  "If the event is on dir/child and this mark doesn't care about
   events on dir/child, don't send it!"

Specifically, mount and filesystem marks do not care about events
on child, but they can still specify an ignore mask for those events.
For example, a group that has:
- A mount mark with mask 0 and ignore_mask FAN_OPEN
- An inode mark on a directory with mask FAN_OPEN | FAN_OPEN_EXEC
  with flag FAN_EVENT_ON_CHILD

A child file open for exec would be reported to group with the FAN_OPEN
event despite the fact that FAN_OPEN is in ignore mask of mount mark,
because the mark iteration loop skips over non-inode marks for events
on child when calculating the ignore mask.

Move ignore mask calculation to the top of the iteration loop block
before excluding marks for events on dir/child.

Reported-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/20200521162443.GA26052@quack2.suse.cz/
Fixes: 55bf882c7f13 "fanotify: fix merging marks masks with FAN_ONDIR"
Fixes: b469e7e47c8a "fanotify: fix handling of events on child..."
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

As you suspected we had a bug in ignore mask logic.
The actual test case is quite asoteric, but it's worth fixing the logic
anyway.

Judging by LTP tests fanotify10 and fanotify12, we were pretty paranoid
about adding the compound event FAN_OPEN | FAN_OPEN_EXEC, so Matthew
wrote a lot of tests even for ignore mask, but we still missed this
corner case.

It was, however, trivial to add a test case for this issue [1].
I couldn't figure out if a similar bug exists with FAN_ONDIR, because
the FAN_OPEN_EXEC event is not applicable and it is quite hard to figure
out if fsnotify_change() is ever called with a combination of ia_valid
flags that ends up with a compound event on dir.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fsnotify-fixes

 fs/notify/fanotify/fanotify.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 95480d3dcff7..e22fd8f8c281 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -232,6 +232,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		if (!fsnotify_iter_should_report_type(iter_info, type))
 			continue;
 		mark = iter_info->marks[type];
+
+		/* Apply ignore mask regardless of ISDIR and ON_CHILD flags */
+		marks_ignored_mask |= mark->ignored_mask;
+
 		/*
 		 * If the event is on dir and this mark doesn't care about
 		 * events on dir, don't send it!
@@ -249,7 +253,6 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			continue;
 
 		marks_mask |= mark->mask;
-		marks_ignored_mask |= mark->ignored_mask;
 	}
 
 	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
-- 
2.17.1

