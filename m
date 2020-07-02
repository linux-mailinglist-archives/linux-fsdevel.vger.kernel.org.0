Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C302123E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 14:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGBM6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgGBM57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:57:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FDDC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 05:57:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so26655483wmi.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yXXckzLydABlQh4tgVLE20pdM39pITPPsei+cSWp9g0=;
        b=LGPVu99Pl/IJd2soNS3tPsRuCppKZyQfR3FxmUFpZo5kHUtqsfMxMlqsvw43De1Wn3
         9s8XMNzXbxA6g21/Jsvggz06wP8qMno0g8qvPrw78GZ9zV0aMSUJY/p6Hq0IIG3q0CGf
         zTE0N+/8qMB8PJ/SNIUICYnFsttZAwGcYa9gEri5YwXjaGRbhr6neGmD2Lvbpvr5iaSH
         v0PGi2UbHNST5sHB7gTzPgHmx9sDR8jX7w5+GVJzA9oYF81m1wljRItcrChqQ164c4tY
         pDw+zN44zZTUVApQZd19jlAutP1fd/1hkAea5yGxwiyiLRQdSzh0MKyM1IdGGwgzwyxS
         DH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yXXckzLydABlQh4tgVLE20pdM39pITPPsei+cSWp9g0=;
        b=SHnKYGaS7SBKJV5yHYDZVuT6MC7wkvqvUVxxmJNhQqy1MElFZKoUUXouj887lEtcWM
         T6dLYxJk+fIv++4dwX6RuCEmA42PDT40B92SLc6MwoQDYQFTJYH64nnqC9pGpLungoFd
         52IWNthv+18guJTAAtNCXU3W8HfAtRmDrjfjAn0/zLbhmdfEaOpEwMmLow/orEn9OIYW
         LLYJQYJOE9d1+B9tOh/83a1Yy0Q1VHotIFLsYxuIUDoLPenOuSYbz3Tk6Fyu4B90OWxo
         sDGfP5UOrA1mBvH22p5tce1tLFRKsI2boj3EYu+Rn1R6UNEz28paXoSYcY20WJiYOloN
         jbng==
X-Gm-Message-State: AOAM531Oe21pr/+ftXpVhA8tLdeRsJb6HcpIsMFQWBU4eOz2t4RWdWg6
        rECbMNIxmPrfX02jYDP+rN03MERw
X-Google-Smtp-Source: ABdhPJxyW1om8XdiIxDnfHd5RcJMrPT9lm91tKAZJNAmiG6UrnsX1Bvm/R/K9JhGBhY1cm3/nXZKgQ==
X-Received: by 2002:a1c:2805:: with SMTP id o5mr11677942wmo.25.1593694677492;
        Thu, 02 Jul 2020 05:57:57 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id g16sm11847335wrh.91.2020.07.02.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:57:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/10] fanotify: report both events on parent and child with single callback
Date:   Thu,  2 Jul 2020 15:57:36 +0300
Message-Id: <20200702125744.10535-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702125744.10535-1-amir73il@gmail.com>
References: <20200702125744.10535-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify usually calls fanotify_handle_event() once for watching parent
and once for watching child, even though both events are exactly the
same and will most likely get merged before user reads them.

Add support for handling both event flavors with a single callback
instead of two callbacks when marks iterator contains both inode and
child entries.

fanotify will queue a single event in that case and the unneeded merge
will be avoided.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c3986fbb6801..7f40b8f57934 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -246,8 +246,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		/*
 		 * If the event is for a child and this mark doesn't care about
 		 * events on a child, don't send it!
+		 * The special object type "child" always cares about events on
+		 * a child, because it refers to the child inode itself.
 		 */
 		if (event_mask & FS_EVENT_ON_CHILD &&
+		    type != FSNOTIFY_OBJ_TYPE_CHILD &&
 		    (type != FSNOTIFY_OBJ_TYPE_INODE ||
 		     !(mark->mask & FS_EVENT_ON_CHILD)))
 			continue;
-- 
2.17.1

