Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7357C2185B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgGHLMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgGHLMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1CC08E6DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so2525439wmh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8UVubkuXhicUmFZ2Y1+zmG91pHnTICwuP72MUM8XTwU=;
        b=eYXJgcO/Jn/oZHiz59nYYCBwYMcXg7EF2Gw7rPkn/ukoezL6yCgFB2r+ABufiPoBjr
         Rk9fD0nYMQ9zCMlue3XM/ZPmXcjgOXj1dQ1W0iHZaRW7Uow9L3vShIFkBptnA0NtLXL4
         fnTWmb851znmmAvjObpqF1wY8H4dWJmPALaHaPfJiTBENHRDrKw6WCzgpKkQVNsXOK8K
         6uvnT8PNS1jGqZzwwFILNo81Z783MNw+34+wBBK0MRamkMITuiFcoVyfV1x2B1Z6YYvr
         iPFWXfApg0my2rbNQTR2G+dArfIYyTK37mAxpRd7xHFX7HNepxoNfP02FNe6Rge8lsn5
         hkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8UVubkuXhicUmFZ2Y1+zmG91pHnTICwuP72MUM8XTwU=;
        b=kX4XwQBF7KH3AtihObEbPL/VVfCYN4c39+42e7XM1d4gouQwlv4dxoC9GNxaRmSQKY
         RlkyrNT7b26kgvlZesGK753vb66mE2fQgmv1fDykSpVv+pp0oVb1UmmXOQufooQY5dwd
         3XmTEWsKRQ3AdxeTpIFGsS93Ihf2kVQ6adfvcdhSaCngjmLqqxMkDM6ODRNSy4ubrIvj
         uNYp+2YEVUcAS9X6G/hHFhqEHDzbj/i/CXi5rwWUp+GW26v773BfT4Q3K+O3Pr7/hZ5B
         UO5eunqQ7DfW81i1E7xWut+Ms4ay2H7pTblEX+zRUCMPvl2Nqo/t/hFmaEcpPx9SL0px
         XyUw==
X-Gm-Message-State: AOAM531Qx+hmUW9AsDgeYjKKaOqd0DKR4+KUEB07uGCAnufuN8lD9YXo
        KV7Fw4Kmg9UU3FAWwbTHUt/fp5Lm
X-Google-Smtp-Source: ABdhPJzkXrOeVhZ0betd6yHRQKa8G3BYgrLMMvqpN23LOiMYGSaNRZJzVO/f8T/Fn1D6UgM4rUKDJg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr8914262wml.33.1594206733779;
        Wed, 08 Jul 2020 04:12:13 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/20] inotify: do not use objectid when comparing events
Date:   Wed,  8 Jul 2020 14:11:41 +0300
Message-Id: <20200708111156.24659-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inotify's event->wd is the object identifier.
Compare that instead of the common fsnotidy event objectid, so
we can get rid of the objectid field later.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 2ebc89047153..9b481460a2dc 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -39,7 +39,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	if (old->mask & FS_IN_IGNORED)
 		return false;
 	if ((old->mask == new->mask) &&
-	    (old_fsn->objectid == new_fsn->objectid) &&
+	    (old->wd == new->wd) &&
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
@@ -116,7 +116,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 		mask &= ~IN_ISDIR;
 
 	fsn_event = &event->fse;
-	fsnotify_init_event(fsn_event, (unsigned long)inode);
+	fsnotify_init_event(fsn_event, 0);
 	event->mask = mask;
 	event->wd = i_mark->wd;
 	event->sync_cookie = cookie;
-- 
2.17.1

