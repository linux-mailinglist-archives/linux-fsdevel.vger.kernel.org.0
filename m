Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D182298CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbgGVM7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgGVM7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C80C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so4337329wmm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7rlIMvMfReNuqNoJRnArogxvKRNNgJ+jKsezYqIUo8=;
        b=dE+a14kkCuX52hMUMTAjrqUtAz54EAIdOqDfiVC28zGJgvlg64XtIDvCEa4Tr2kvr0
         kDG5wj6yYuERArKYXG4gmmJ5agqv+qrrX9vqPlHdZ4SVJsVCFpU84jDppFXqaxItHIdx
         rY/nXMpudbeRwcgjRZUYaRb9pMvuJ8JmWb5IgZegxtcOToBc8g2lN6aAyuuLZf1GSrMe
         91wG5QcSPDNlD0zK74U1rHracn8tIUeaDrnT77RPEOsohy6v8xcoy+jDqvZKhWOFMFZC
         NoP1+IphknfnD7bmLvmpkWrq7AKXyz86G7WsaJGYChnxWeGEAHmO6Tyw+pvFkx4+Gi/W
         vLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7rlIMvMfReNuqNoJRnArogxvKRNNgJ+jKsezYqIUo8=;
        b=Nle2jKz74bkysGtiKyWnDIWc4RrqF2Mo1PZxklpTTkU/sWiZNAodpSCxS4svpMRG4J
         eQJxgobqDNGqAdLLlIkdZ1Cj/GKtXNtAV+ovd8IG5xB96+VV/iZ1gjEcnfPW0JOaj9mY
         RTkVBg9vrRaAwwYtms3H5QKz0B6lszb2HzqJr/bpEzCfRa7fo+Y/5Js4C8JnSlXSM0RW
         KDBOPNbt9+vyC/dJ2qsuRrUmP1vubv7vNUWhkNVbKkPNjWLVgi59aV+LtJv/JsQOMF7A
         4+TD1/Zw1DUQ0J71ulTFmcWScubakdpldIXiGp86fvs+WJKeZcZn6UaATl/MRieRoAtk
         vovg==
X-Gm-Message-State: AOAM533DITfnCang1hEsGvmHJWuJKqwJ49tbT78GvyR3WH/z2gaucO/3
        0B1mroQ6ozWo2njTRe20h6I=
X-Google-Smtp-Source: ABdhPJx8KN6idgyOFySHA2uA6TN51CuSDU8fXGCkVwqa8cfjTamgfFP4Aya6PzfJJIzKr++io7pQKw==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr9036827wmr.133.1595422743486;
        Wed, 22 Jul 2020 05:59:03 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:02 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] fanotify: fix reporting event to sb/mount marks
Date:   Wed, 22 Jul 2020 15:58:41 +0300
Message-Id: <20200722125849.17418-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When reporting event with parent/name info, we should not skip sb/mount
marks mask if event has FAN_EVENT_ON_CHILD in the mask.

This check is a leftover from the time when the event on child was
reported in a separate callback than the event on parent and we did
not want to get duplicate events for sb/mount mark.

Fixes: eca4784cbb18 ("fsnotify: send event to parent and child with single callback")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a24f08a9c50f..36ea0cd6387e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -265,13 +265,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 			continue;
 
 		/*
-		 * If the event is for a child and this mark doesn't care about
-		 * events on a child, don't send it!
-		 * The special object type "child" always cares about events on
-		 * a child, because it refers to the child inode itself.
+		 * If the event is for a child and this mark is on a parent not
+		 * watching children, don't send it!
 		 */
 		if (event_mask & FS_EVENT_ON_CHILD &&
-		    type != FSNOTIFY_OBJ_TYPE_CHILD &&
+		    type == FSNOTIFY_OBJ_TYPE_INODE &&
 		    !(mark->mask & FS_EVENT_ON_CHILD))
 			continue;
 
-- 
2.17.1

