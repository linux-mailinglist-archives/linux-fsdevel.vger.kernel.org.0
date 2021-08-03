Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691EB3DF448
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbhHCSEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhHCSEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:04:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506BC061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 11:04:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so26254284wrr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ub6Fnv4wFmTYxigM80s/7bt/bC9UNW4TyXVoZdg15A=;
        b=byIf7nmKIGje6wxQtK2JPEvq8tZlO1Py9EIsmMkpOkiLpAw0Q3f9FOL2XGgv5vv5q4
         WtXvG5Uya+fkc7Xr50fcXt2ao48PTrWA8eH+Awpa+1JPOuuGuT6/C7I/EWIRHMjs0VdB
         v+gRFssGAR1TGJ2YWZ2FvSzGvdw+SFuRL6wRMEJR76KgimfC+rSwfT9yKc1bgL25KqZJ
         838H5Q0Y1I7wlVdnvNAqPY5hxYJdT5AZhB3NKvFMMTpWaUn9D8R+NTqJ5tskNubbHDXm
         UdWVEfQxGw9npi7R+EAYwpb94MndzcDL0KN+TPvYe6g7BpDo9jZ7Ug80fAiq9Kca4E8c
         GyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ub6Fnv4wFmTYxigM80s/7bt/bC9UNW4TyXVoZdg15A=;
        b=VHJUP9kByF3GZlPE5FnajOtlnjy0YRHmuOhPxQFisGOBdzQ8Z0KEKAAvLp+iiMAgUR
         ey2AduJJgeAnddvxQfPMUvNVOC4eknJ2ucPPUurFFX07/FLKBnxHH8/7cK+XLDVYUJGc
         rfoKNtLOJwQjacT+3GcyP9zuGEZ73gxcueWtTpcZa93YcrnEMkk/UUAFsUqe3lSrTEjQ
         yi2L8yiJHdYiE7iZuT5KraokxaODmrtZOIaNxgtNu5oGl8cHW7nlkogjyjSHMVWxwk8w
         qqBHhZDxjfBifB87JTCwYHxMgv+u0whDdpCmmulSYao9u2jjTgFN2vsYzujhGYfWZW5m
         hONQ==
X-Gm-Message-State: AOAM533ib4puwTZ8eL/DtR70KCuzDvzKcXufomToww01UvrqgA7Qwne/
        zrQP0p8YdmWD5OdW6JYSK5g=
X-Google-Smtp-Source: ABdhPJw8g1P3n1QfN2f3ndCyQFilFO4dhuNjCCvbv8q+jnnngiiFqG859GgqgY8geM3STHg8uAcqvw==
X-Received: by 2002:adf:f149:: with SMTP id y9mr25085279wro.413.1628013839305;
        Tue, 03 Aug 2021 11:03:59 -0700 (PDT)
Received: from localhost.localdomain ([185.110.110.213])
        by smtp.gmail.com with ESMTPSA id b14sm15515555wrm.43.2021.08.03.11.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:03:58 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4] Performance optimization for no fsnotify marks
Date:   Tue,  3 Aug 2021 21:03:40 +0300
Message-Id: <20210803180344.2398374-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

This idea was suggested on year ago [1], but I never got to test
its performance benefits.

Following the performance improvement report from kernel robot [2],
please consider these changes.

I have other optimization patches for no ignored mask etc, but the
"no marks" case is the most low hanging improvement.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgYpufPyhivOQyEhUQ0g+atKLwAAuefkSwaWXYAyMgw5Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxisyDjVpWX1M6O4ugxBbcX+LWWf4NQJ+LQY1-3-9tN+BA@mail.gmail.com/

Amir Goldstein (4):
  fsnotify: replace igrab() with ihold() on attach connector
  fsnotify: count s_fsnotify_inode_refs for attached connectors
  fsnotify: count all objects with attached connectors
  fsnotify: optimize the case of no marks of any type

 fs/notify/fsnotify.c     |  6 ++--
 fs/notify/mark.c         | 73 +++++++++++++++++++++++++++++++++-------
 include/linux/fs.h       |  4 +--
 include/linux/fsnotify.h |  9 +++++
 4 files changed, 75 insertions(+), 17 deletions(-)

-- 
2.25.1

