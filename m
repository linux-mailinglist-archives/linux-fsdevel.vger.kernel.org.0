Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D032330C5A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhBBQ1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhBBQXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60FC06178A
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so30873146ejc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCS/5pEqEmAlfvrCy06boAeghoXPeeM+Ofzfq7OPRb8=;
        b=tdgWBDoxjrUijXCsvuoxxPT2SVYRl2m1uOSuPk8VnC+pUphADmiAV87pepNDa17/b6
         yNWlQg/sMPVRQosxzV9NEe3WZD/r7RK2uXlbVTNIr/Z/iJz9s8URiz/KJ4Mw4jIMhfNK
         9DOBGZDg/9axPg8fiowb2pHTukOaVs8NM21j+ZE026WlZAlV/2AD4sNaF3puzG8kMMJQ
         7KfzJfbWFNR8ur7y6L+MU/Ut1zVVDf/cinKYZ92rZk4n59tLipG6KICg40kUItUCD/1s
         3EL9TTyNE0Kb++FWm0JJOTJMv0XytqkWQj9avJM97UYDkwt8P8MNlG0GCXvZViJot1ba
         L4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCS/5pEqEmAlfvrCy06boAeghoXPeeM+Ofzfq7OPRb8=;
        b=r6redgmNsnaeFd1YQz9oNR4TkHtZCehth3ihxjGfgzK7BADLPAMy4nBwWS7f8qDgE7
         fDn4xqaET85siBu6bij+aqfqK09VmHHkomnei7WpC81weozPCCB2svtN3AnWMCvedXPj
         SKt+SvLpVSuGm89nxHvz2W4EeCx7eQSSTX5rh6vJQNLOO11J0WKSqsxZrPsTspNkBKLT
         LaLSUIU0MeQ5nw0zwb+syDGahQj/8UuB/kVNG62v1u5BKRSvHdFPK/qlep6TR77qwFfI
         vzaf8VuTQxGYA3TXEGXkrrbrghuo7g3WSGOZBYv8dsKnpxgOwH4ox+tfgdaTAr8GAa35
         b7uw==
X-Gm-Message-State: AOAM530yl6zfGtXURoghAjmnW21dtUULcha37xUCjHFO4NJDmlZCkK1T
        zad98rMYPQhKGCyJ94o9QrJMpE/RhTg=
X-Google-Smtp-Source: ABdhPJzc70myAq1KaE5+AG/CniC13xJwXpbi8ifrqNkrVuL3ZiSOeYvKFOdRTedjYKo+08oOeGt37Q==
X-Received: by 2002:a17:906:3e96:: with SMTP id a22mr22994227ejj.144.1612282813332;
        Tue, 02 Feb 2021 08:20:13 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:12 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/7] Performance improvement for fanotify merge
Date:   Tue,  2 Feb 2021 18:20:03 +0200
Message-Id: <20210202162010.305971-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

fanotify_merge() has been observed [1] to consume a lot of CPU.
This is not surprising considering that it is implemented as a linear
search on a practically unbounded size list.

The following series improves the linear search for an event to merge
in three different ways:
1. Hash events into as much as to 128 lists
2. Limit linear search to 128 last list elements
3. Use a better key - instead of victim inode ptr, use a hash of all
   the compared fields

The end result can be observed in the test run times below.
The test is an extension of your queue overflow LTP test [2].
The timing results use are from the 2nd run of -i 2, where files
are already existing in the test fs.

With an unlimited queue, queueing of 16385 events on unique objects
is ~3 times faster than before the change.

In fact, the run time of queueing 16385 events (~600ms) is almost the
same as the run time of rejecting 16385 events (~550ms) due to full
queue, which suggest a very low overhead for merging events.

The test runs two passes to test event merge, the "create" pass and
the "open" pass.

Before the change (v5.11-rc2) 100% of the events of the "open" pass
are merged (16385 files and 16385 events).

After the change, only %50 of the events of the "open" pass are
merged (16385 files and 25462 events).

This is because 16384 is the maximum number of events that we can
merge when hash table is fully balanced.
When reducing the number of unique objects to 8192, all events
on the "open" pass are merged.

Thanks,
Amir.

v5.11-rc2, run #2 of ./fanotify05 -i 2:

fanotify05.c:109: TINFO: Test #0: Limited queue
fanotify05.c:98: TINFO: Created 16385 files in 1653ms
fanotify05.c:98: TINFO: Opened 16385 files in 543ms
fanotify05.c:77: TINFO: Got event #0 filename=fname_0
fanotify05.c:176: TPASS: Got an overflow event: pid=0 fd=-1
fanotify05.c:182: TINFO: Got 16385 events

fanotify05.c:109: TINFO: Test #1: Unlimited queue
fanotify05.c:98: TINFO: Created 16385 files in 1683ms
fanotify05.c:98: TINFO: Opened 16385 files in 1647ms
fanotify05.c:77: TINFO: Got event #0 filename=fname_0
fanotify05.c:138: TPASS: Overflow event not generated!
fanotify05.c:182: TINFO: Got 16385 events

fanotify_merge branch, run #2 of ./fanotify05 -i 2:

fanotify05.c:109: TINFO: Test #0: Limited queue
fanotify05.c:98: TINFO: Created 16385 files in 616ms
fanotify05.c:98: TINFO: Opened 16385 files in 549ms
fanotify05.c:77: TINFO: Got event #0 filename=fname_0
fanotify05.c:176: TPASS: Got an overflow event: pid=0 fd=-1
fanotify05.c:182: TINFO: Got 16385 events

fanotify05.c:109: TINFO: Test #1: Unlimited queue
fanotify05.c:98: TINFO: Created 16385 files in 614ms
fanotify05.c:98: TINFO: Opened 16385 files in 599ms
fanotify05.c:77: TINFO: Got event #0 filename=fname_0
fanotify05.c:138: TPASS: Overflow event not generated!
fanotify05.c:182: TINFO: Got 25462 events

[1] https://lore.kernel.org/linux-fsdevel/20200714025417.A25EB95C0339@us180.sjc.aristanetworks.com/
[2] https://github.com/amir73il/ltp/commits/fanotify_merge

Amir Goldstein (7):
  fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
  fsnotify: support hashed notification queue
  fsnotify: read events from hashed notification queue by order of
    insertion
  fanotify: enable hashed notification queue for FAN_CLASS_NOTIF groups
  fanotify: limit number of event merge attempts
  fanotify: mix event info into merge key hash
  fsnotify: print some debug stats on hashed queue overflow

 fs/notify/fanotify/fanotify.c      |  40 ++++++-
 fs/notify/fanotify/fanotify.h      |  24 +++-
 fs/notify/fanotify/fanotify_user.c |  55 ++++++---
 fs/notify/group.c                  |  37 ++++--
 fs/notify/inotify/inotify_user.c   |  22 ++--
 fs/notify/notification.c           | 175 +++++++++++++++++++++++++----
 include/linux/fsnotify_backend.h   | 105 +++++++++++++++--
 7 files changed, 383 insertions(+), 75 deletions(-)

-- 
2.25.1

