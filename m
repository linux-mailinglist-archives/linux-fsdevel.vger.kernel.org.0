Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCB361611
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 01:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhDOXWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhDOXWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 19:22:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3BFC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 16:22:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b26so11965535pfr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TCW1/ONXHa7WGN4lgho3PeX/tDvamKqJMxf6Tjrp4yc=;
        b=Sm+yE7EEDfprcsH5vV69Bnhnqysr6JAP1Aky66+ghCetkGZvztgXnqbUZNZ5+So54f
         Y7GKqTj2nk2YxBSrPy6cz59rB2Xukde723+Cxminb+GBaKiq3vi+oOxLcLws5XUVbkgY
         PqXZPbPDcf8DJDzgB7HJRq8mikQT/uOn0pdO3bXkEl1njs+/SQ86AELyUn0d4LdGL3N4
         H+gK9qN/JEvzy45cvE2fWMKoUP5/lsB3DJAI96T8w4tTvyIla93sljA5BsksVnBwjsBt
         6ixOjKieMb2oIxOX4hqtPAwIEZVv+n7d3XBIE+6tsb83gtcN/f/msDJWcyC8SSqIvNJr
         xDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TCW1/ONXHa7WGN4lgho3PeX/tDvamKqJMxf6Tjrp4yc=;
        b=U3tNc8ttPGMri530iNGZT3ZaiNi5z98aH0WO1QpP63mhaAbVaunAp6D3u62JblOVV2
         4gepBbxzagXyg9BHl7Pff9yW2Lpa+YyexQobUUrAzkrsri7P+CCvmz3xQPXT0fewDTlh
         M323IXrATVShYxXfXe9YUuYlRKozH1+Deju4rY2Sdts3aVdo3vCkiKm6gs18hMTUlfSk
         jQNdcGxgg9PcTFmtP5ewAIhdlB0raqSwhJ3a8aOVtSpYC8tMb0emtBRE11rcl65GaW6F
         BHGyn0XtuvC7L49KD76eQ1W8PwlmStlR01c6llhi4Nq7EtIs09o7qMsbrxiNpWqMxSmZ
         YaBA==
X-Gm-Message-State: AOAM532eRPS5B8ktCsCKeJvVMY42XwIFx5oufVwjx7/CuTcG1Lz02gss
        6Ttr7Nk+kIg4TuGSmXwSU7ysOw==
X-Google-Smtp-Source: ABdhPJwDxhn0/aSL0gpvbJ4vdiINft6HtMduIyvWgc3WW96xMMUikWcZ2eh5d4Zaf0nrbslu9EYKnA==
X-Received: by 2002:a63:5265:: with SMTP id s37mr4763061pgl.253.1618528926672;
        Thu, 15 Apr 2021 16:22:06 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3d18:8baf:8ab:7dd5])
        by smtp.gmail.com with ESMTPSA id x2sm2983246pfu.77.2021.04.15.16.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:22:06 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:21:53 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] fanotify: Adding pidfd support to the fanotify API
Message-ID: <cover.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Jan/Amir/Christian,

This is the RFC patch series for adding pidfd support to the fanotify
API.

tl;dr rather than returning a pid within struct
fanotify_event_metadata, a pidfd is returned instead when fanotify has
been explicitly told to do so via the new FAN_REPORT_PIDFD flag.

The main driver behind returning a pidfd within an event instead of a
pid is that it permits userspace applications to better detect if
they've possibly lost a TOCTOU race. A common paradigm among userspace
applications that make use of the fanotify API is to crawl /proc/<pid>
upon receiving an event. Userspace applications do this in order to
further ascertain contextual meta-information about the process that
was responsible for generating the filesystem event. On high pressure
systems, where pid recycling isn't uncommon, it's no longer considered
as a reliable approach to directly sift through /proc/<pid> and have
userspace applications use the information contained within
/proc/<pid> as it could, and does, lead to program execution
inaccuracies.

Now when a pidfd is returned in an event, a userspace application can:

    a) Obtain the pid responsible for generating the filesystem event
       from the pidfds fdinfo.

    b) Detect whether the userspace application lost the procfs access
       race by sending a 0 signal on the pidfd and checking the return
       value. A -ESRCH is indicative of the userspace application
       losing the race, meaning that the pid has been recycled.

Matthew Bobrowski (2):
  pidfd_create(): remove static qualifier and declare pidfd_create() in
    linux/pid.h
  fanotify: Add pidfd support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
 include/linux/fanotify.h           |  2 +-
 include/linux/pid.h                |  1 +
 include/uapi/linux/fanotify.h      |  2 ++
 kernel/pid.c                       |  2 +-
 5 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.31.1.368.gbe11c130af-goog

/M
