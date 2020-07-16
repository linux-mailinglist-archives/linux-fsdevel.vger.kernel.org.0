Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8D221EB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgGPIm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgGPIm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02213C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so10665009wmh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E55Apwgwfx/i5D8M/LsB/9auaV2S5aV6GN5wmekte2M=;
        b=A81p28HGPxqZ9+xpPNls7IMgz6IuSA6tlFo7YHgRjKzKfhSmGoWfN/lj1TZhti/h00
         DHuItFeC5IictpPULbaz7nwA5I341Mh27oew8ifHPQ9/Ak/N7Q/xYLebGbFsU9w6hD8r
         ukS9mazYt4jyf7LaW3lAIOr2WrHNyc9NGKx+MCHaUXl6dfFsmQQMXHyddSj8Db0lk8f9
         Bp15TGCFc6DfJuaimh/e3ptgQCpXt0FeMdPDOJt7YnjWP7wd3NgefGu9rgPdAOTE0GEJ
         3t3LXnK3+OOAZ31QKz9fNSl4N11OhDEk8UQ6Eic40OpEMI2Cw8WLuNW9j5Gvg5wdfl1L
         39AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E55Apwgwfx/i5D8M/LsB/9auaV2S5aV6GN5wmekte2M=;
        b=s8Zi5XvN2ndJGMQrgo7+yoFvQmMqMjc1SRIim3uDTKTAVdctTGlXVUy7JWuGbaszSF
         8y9FWUJtVaJB8R+8TnE52/ENlDsFPeerhPzDcOhG7pE9aDKVaQLynAvkaFjenJwc4Y8d
         Kmppc8pvKjPytERkPctMHruFzgNAzBJ1iqFkBdyC1Or6o62MDun7Hl3ZpOIuhgj1TeDC
         XNW+h5ytav+jdhhPpmjwrrq41O3fT+NRgyv2ZZFjnA9ndbJfxaY+qzjkaQO90rbhW4qM
         1m8Md/v8km2qlLNtf9iWR2yEGaTSFyIR8E9vMhyFyS97q3uc7fI6nFkgD7aVPJnY8DN/
         QBsg==
X-Gm-Message-State: AOAM5333zLvtWthCVFC8JWSsOwMv6E7+31SwaVcRkMStEValuFkzIucQ
        RzEiI4UHnwnSgnKzky2ISEs=
X-Google-Smtp-Source: ABdhPJyPwRSrADb2NMEhDfU/aI3N3jJCM8n0Dy2IuGBSzwaSgP8zosDuKI0ACnsNjcuaGB0zvkXr3A==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr3469800wmo.72.1594888974768;
        Thu, 16 Jul 2020 01:42:54 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:54 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 13/22] fanotify: report both events on parent and child with single callback
Date:   Thu, 16 Jul 2020 11:42:21 +0300
Message-Id: <20200716084230.30611-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
index c107974d6830..1ec760960c93 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -263,8 +263,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
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

