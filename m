Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358691F760E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFLJeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgFLJeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0AC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so9400865ejb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KUjJIJKBLB0Ty9CDVJT6cgmycVVlpAiG22SmKIlK5m0=;
        b=D4fl5a+DQdvRi4WkuPwFNrWVOBfF2TPmHorbbzFAbEsxhGbnfZdG3MkSKJCnY+6ySs
         sDzy0aiY9p6RNW8J9Mra1LNBaiWRlA5zaOmMmg3gYKfn8XffhGX8/GcMx6DKdggzIe9N
         G//zgrGsl+80EjTve6LcN3HghiNlOlftu7g/5DKSCCL6ZAHJUHW53vO7qTMorxPp0Qe1
         V7zU6odMsaqCt3XVdCvvC2iWKA1uEMyc10NfTrZbHvIxgjvU4RIdh9djpbqLUjvK2za9
         Ud/1mWbHCEoub0ScURbgV2ZSxnJdcn3kGDcvbrvTHkdWLO0qyg0gJqFE+PyJlv/3Vsnj
         psFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KUjJIJKBLB0Ty9CDVJT6cgmycVVlpAiG22SmKIlK5m0=;
        b=Q8RNvTrVbtYiFODb5ZPMrqRfMWq3ohYTbhPl2nHVVIENdjJdaVPVszrUPTMcsKVbt7
         A83L73XlvahDPISdPTA34KDoPmOgppsPdY5keKJegHi31IeNrnFiuScXGIrlLC/WwJRC
         yCIlTJ+oK71fx7kUc1LV0pv+m48PM8aIjyyXleC4edLdOq7xE8zoVTo/hAnrZCFtYDQT
         gHhFRbLc2wmwFK4OEercQQfdwD4BH4irvmuHd46No5Cs8qJDCh9cYiaUHj8bFbRQDnuk
         nz28UpADXL366oc+wmMq9zv6WNATKCtQV2wgE7NAqKz01yuwULGET51Yv2LFhL9UjHkn
         zpAw==
X-Gm-Message-State: AOAM530mAL3w/nYqrvXWO3U7+/O+zg+8BknMLCrLoeiLgjpB8HHjubbT
        4hgH0ph+U+pUWa634S45gAT/qicR
X-Google-Smtp-Source: ABdhPJyjjrV4q9JQ2/LwGRuQLwDlbimYoCmR2TQ+0x7/eOuqCz92s+3rNIvzJ0pbXv2jjD5ahTQV+w==
X-Received: by 2002:a17:906:838a:: with SMTP id p10mr12129307ejx.243.1591954454740;
        Fri, 12 Jun 2020 02:34:14 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/20] fanotify: generalize the handling of extra event flags
Date:   Fri, 12 Jun 2020 12:33:33 +0300
Message-Id: <20200612093343.5669-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fanotify_group_event_mask() there is logic in place to make sure we
are not going to handle an event with no type and just FAN_ONDIR flag.
Generalize this logic to any FANOTIFY_EVENT_FLAGS.

There is only one more flag in this group at the moment -
FAN_EVENT_ON_CHILD. We never report it to user, but we do pass it in to
fanotify_alloc_event() when group is reporting fid as indication that
event happened on child. We will have use for this indication later on.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e68a9fad98bd..f5997186c8b8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -211,7 +211,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     int data_type)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
+				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_mark *mark;
 	int type;
@@ -265,13 +266,17 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
 	 * to user in FAN_REPORT_FID mode for all event types.
+	 *
+	 * We never report FAN_EVENT_ON_CHILD to user, but we do pass it in to
+	 * fanotify_alloc_event() when group is reporting fid as indication
+	 * that event happened on child.
 	 */
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
-		/* Do not report FAN_ONDIR without any event */
-		if (!(test_mask & ~FAN_ONDIR))
+		/* Do not report event flags without any event */
+		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
 	} else {
-		user_mask &= ~FAN_ONDIR;
+		user_mask &= ~FANOTIFY_EVENT_FLAGS;
 	}
 
 	return test_mask & user_mask;
-- 
2.17.1

