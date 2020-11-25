Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430DF2C450E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgKYQZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbgKYQZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5CC061A51
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:25:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so2523100wmd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUxbRrS9MFqXGOvk/ieUK3bhzkS/VSko486/NfxYD1w=;
        b=gwqmqFySnTT8wFc9pyNO08a05EtFio6skO3VOfMb8mdBj6W1qBPu6+VRr2k1XCh6kl
         Q/nUJzrA1+98qaJuJmEx9Yj8Xp0Qz4KncxaIhz/aDBFojKu7G5YnfJs/2YEnSNGH2lKf
         sVR6MQzcank3A6sMNUPe9nWSpOoUBv2+cAY+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUxbRrS9MFqXGOvk/ieUK3bhzkS/VSko486/NfxYD1w=;
        b=FOVrqnpOGhpaZEYsqpJBntQ0YyO10xuGYnByOgPgbJ8ZuKzgAX6/8kuEjZ8zK3e8o5
         UPOOYqhhU+s3rYo+gfs200NiGzIjRHwyVeH6FvORv9Qn/F9VUYmYbwN46u51aeHMRD3G
         oFsYzc7ZoE9LEYtGlDZRqXF4PKXhCcoHXAvSJpU0zSlIruj14C22VCveC9o5aE6h+siX
         YFaqKz44RLzDVqhbp5X7PstQ1g1doEC8p0lh1Bds4bqxVHp8QDARcuKDLiywB0MMSLdR
         yaSa4twt8vQedmd1w8+HDbgMnRLZMSocHQAlF5ffsR/z3KIeubkcQk6noph8m6GExq6X
         KFdg==
X-Gm-Message-State: AOAM531kOhl8lW81cBgOKHcyHrjJzkZimwEe4Wpyz7uCca1iIzw4EgxU
        EN6SVjPwBdPNcetgHVX936Kvc8XKtiRwbQ==
X-Google-Smtp-Source: ABdhPJwU55boKQUargCwj7uABbDFGkLI6m5Shju4RIwPqnobg7pzset1RPYMkQXjIR0a2azRJHembg==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr3649998wmb.101.1606321538289;
        Wed, 25 Nov 2020 08:25:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a21sm4855187wmb.38.2020.11.25.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:37 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v4 0/3] mmu_notifier vs fs_reclaim lockdep annotations
Date:   Wed, 25 Nov 2020 17:25:28 +0100
Message-Id: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Just resending with the polish applied, no functional changes at all.

Previous versions.

v3: https://lore.kernel.org/dri-devel/20201120095445.1195585-1-daniel.vetter@ffwll.ch/
v2: https://lore.kernel.org/dri-devel/20200610194101.1668038-1-daniel.vetter@ffwll.ch/

Changes since v3:
- more acks/r-b
- typos in the kerneldoc fixed

Changes since v2:
- Now hopefully the bug that bombed xfs fixed.
- With unit-tests (that's the part I really wanted and never got to)
- might_alloc() helper thrown in for good.

I think if we have an ack/review from fs-devel this should be good to
land. Last version that landed in -mm (v2) broke xfs pretty badly.

Unfortuantely I don't have a working email from Qian anymore, who reported
the xfs issue. Maybe Dave Chinner instead?

Cheers, Daniel

Daniel Vetter (3):
  mm: Track mmu notifiers in fs_reclaim_acquire/release
  mm: Extract might_alloc() debug check
  locking/selftests: Add testcases for fs_reclaim

 include/linux/sched/mm.h | 16 ++++++++++++++
 lib/locking-selftest.c   | 47 ++++++++++++++++++++++++++++++++++++++++
 mm/mmu_notifier.c        |  7 ------
 mm/page_alloc.c          | 31 ++++++++++++++++----------
 mm/slab.h                |  5 +----
 mm/slob.c                |  6 ++---
 6 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.29.2

