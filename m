Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D505732D1CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 12:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhCDLaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 06:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240148AbhCDLaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:30:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F4C061574;
        Thu,  4 Mar 2021 03:29:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o2so8795166wme.5;
        Thu, 04 Mar 2021 03:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXj+J+opo6bTXx46F8tWrn1QfcSvSSbLWVP6KkmF29I=;
        b=DQFl1nHt/ucYGKlmXHOIxLo2dfBVM8gglnObwxMF6jqFKe4IV7GIZy4rD6NZNy+Isw
         3y5fo1B7p4NBEzGKgknnGd8CQtlVD8/eWus4dB/HWqrXhPYToxFaw+Dr9Qk7f6FK+/Zn
         Jkq2KVAL3HlobisS9cPXYBj8I1mtxTwAk1raS3KpPt6G+XMkRm8xzHC7Q3OcBHu6gyRq
         2lps9ZN4jts6U3yXohUCe88Lcqe3PQLBV0VPM69Z3LxhdqzPPknRoU2RHov/9DMhAnlJ
         6aMoWKrefhSrbGbMn93hgnAKdJkgjmTHd5JkzZixuSLsd1pUPfFpUQAXhjHXf0xtT0CO
         FgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXj+J+opo6bTXx46F8tWrn1QfcSvSSbLWVP6KkmF29I=;
        b=ZBLERXZk8vj9DXwncgEn/yMq9LgKfT+s5lBxQfk9HnTElFTD+K5bk4Ky9QllON+M9a
         CG5+3bSu+mYWF1Tu+qWTL8hvRCPQClvZdBsFFpEajeYgURZ0uARpjoZWDi5OsgF55gh4
         IDhdGF3A1v35VgPEkSFGSH95r7cxS4dXTiiItw97RkND34b0COhATa6MClmrjALPlYkM
         MBdEaY5bw2FVDaGvCAUJ/lcbB1YZk3FT4KJAiVRjgfIopXvzJMqgEGiTdkoByHJaJRIQ
         Fvrms97Q6rpgNpHNT1pHG0NF0BFP/tdLvg26m10rleQ/dxYD/eDaYiDnhGARSYSxv+2N
         uQjQ==
X-Gm-Message-State: AOAM530fpX+xCccIlJriIsjDwIYkL0iBpp+4PjJQwrOAlZrsjYL80Ny6
        oK6MQj4xZRnbu5/rlSZ8TjQ=
X-Google-Smtp-Source: ABdhPJxTXaQhS5ALia4wB+XNh9aexeJdLllkQvAd90g5CABkgfr+yuf/KDOiOa4qH04tQs8QWS2PiQ==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr3444924wmj.47.1614857364945;
        Thu, 04 Mar 2021 03:29:24 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id 3sm25196554wry.72.2021.03.04.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 03:29:24 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/2] unprivileged fanotify listener
Date:   Thu,  4 Mar 2021 13:29:19 +0200
Message-Id: <20210304112921.3996419-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

These patches try to implement a minimal set and least controversial
functionality that we can allow for unprivileged users as a starting
point.

The patches were tested on top of v5.12-rc1 and the fanotify_merge
patches using the unprivileged listener LTP tests written by Matthew
and another LTP tests I wrote to test the sysfs tunable limits [1].

Thanks,
Amir.

Changes since v1:
- Dropped marks per group limit in favor of max per user
- Rename sysfs files from 'listener' to 'group' terminology
- Dropped internal group flag FANOTIFY_UNPRIV
- Limit unprivileged listener to FAN_REPORT_FID family
- Report event->pid depending on reader capabilities

[1] https://github.com/amir73il/ltp/commits/fanotify_unpriv

Amir Goldstein (2):
  fanotify: configurable limits via sysfs
  fanotify: support limited functionality for unprivileged users

 fs/notify/fanotify/fanotify.c      |  16 ++-
 fs/notify/fanotify/fanotify_user.c | 152 ++++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |   3 +-
 fs/notify/group.c                  |   1 -
 fs/notify/mark.c                   |   4 -
 include/linux/fanotify.h           |  36 ++++++-
 include/linux/fsnotify_backend.h   |   6 +-
 include/linux/sched/user.h         |   3 -
 include/linux/user_namespace.h     |   4 +
 kernel/sysctl.c                    |  12 ++-
 kernel/ucount.c                    |   4 +
 11 files changed, 194 insertions(+), 47 deletions(-)

-- 
2.30.0

