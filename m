Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4F2185B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgGHLMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44685C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so2478588wmh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TryVjoesZDaVZR8q3LIFPNDgn22PlUX35vntd9eriU=;
        b=etfGwhhk6BPIw2VO8J50ouWvq+RkEI7se+8/OcEr+zTvQOky3yDMyolLBi9emLvr8M
         JysVajr+CmFWcAMSe8wsppn7Nyc0qITLs8xk0vuuJsSdR46D2gt1EN0bBDcXbt1ZsnEq
         93f3IBhbUntPUSC2Xim4Q2P5VZxXuchEnp2mYtj2TSV8Ob8LR1k0ZLEBERfqvXY8GHMW
         bwRe4hQmb62p1bbwPU6eF5VbSs3ZMC/CuRjNMXTNYR90eXW0YsI8gpUHVl7jbXxy/H9F
         rEe5ysiGxYvxGa73CArlTRsBAXVMuJPU5Ii9LCqRAWWZ+YuOkYuYj6wr4K3bum2rZALH
         Ghuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TryVjoesZDaVZR8q3LIFPNDgn22PlUX35vntd9eriU=;
        b=UBWtYqtWUSLuK3A/LUm5x0ZZeBNcJH3Wmzi+McGBnjOrXFB21XnWaXeMBf/Kj4XzGX
         LzFCWqk3uSiMzIaRWxSnzkgLiDYo4MWpEEFWqY9KjIRCHiLV98s/04zvg0XGLIw1xjph
         BQ7ESIpCtkPQxBBOUyIhnFeTqB7mexxBNcqYXNeNZr8AwOiK4j80CQuCQYXi2hfy0E35
         /UgLcdRD0d7lPbzwigkFPRK6D7JPAHmgIL2WrVHzQXNNanSI88Cq5Dj21Rb48388HaJv
         yge2iznZP3I88PYL/O/cM+Ntf4H2H7JqFWK2iK6qUPIZ1cBntmWhtXbXs3N1aNtH900y
         zZ/g==
X-Gm-Message-State: AOAM530c/N6gmO+FDPke0a0Il2TqgL8++MdGfJ3KOeFHay/zSdQyrBRX
        JjWwpgKiIXtp0ldOWrC4SRA=
X-Google-Smtp-Source: ABdhPJxl/IpODdPMLazYxT47nQrfGwYwXMsW1hDn2UNbiRyyd/QB+67KJP57QyB9JY4ZVy7UQrStvw==
X-Received: by 2002:a1c:2982:: with SMTP id p124mr9231214wmp.26.1594206742034;
        Wed, 08 Jul 2020 04:12:22 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/20] fanotify: generalize merge logic of events on dir
Date:   Wed,  8 Jul 2020 14:11:46 +0300
Message-Id: <20200708111156.24659-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An event on directory should never be merged with an event on
non-directory regardless of the event struct type.

This change has no visible effect, because currently, with struct
fanotify_path_event, the relevant events will not be merged because
event path of dir will be different than event path of non-dir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index d853acc62b83..94316639cafb 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -83,22 +83,22 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 	    old->type != new->type || old->pid != new->pid)
 		return false;
 
+	/*
+	 * We want to merge many dirent events in the same dir (i.e.
+	 * creates/unlinks/renames), but we do not want to merge dirent
+	 * events referring to subdirs with dirent events referring to
+	 * non subdirs, otherwise, user won't be able to tell from a
+	 * mask FAN_CREATE|FAN_DELETE|FAN_ONDIR if it describes mkdir+
+	 * unlink pair or rmdir+create pair of events.
+	 */
+	if ((old->mask & FS_ISDIR) != (new->mask & FS_ISDIR))
+		return false;
+
 	switch (old->type) {
 	case FANOTIFY_EVENT_TYPE_PATH:
 		return fanotify_path_equal(fanotify_event_path(old),
 					   fanotify_event_path(new));
 	case FANOTIFY_EVENT_TYPE_FID:
-		/*
-		 * We want to merge many dirent events in the same dir (i.e.
-		 * creates/unlinks/renames), but we do not want to merge dirent
-		 * events referring to subdirs with dirent events referring to
-		 * non subdirs, otherwise, user won't be able to tell from a
-		 * mask FAN_CREATE|FAN_DELETE|FAN_ONDIR if it describes mkdir+
-		 * unlink pair or rmdir+create pair of events.
-		 */
-		if ((old->mask & FS_ISDIR) != (new->mask & FS_ISDIR))
-			return false;
-
 		return fanotify_fid_event_equal(FANOTIFY_FE(old),
 						FANOTIFY_FE(new));
 	case FANOTIFY_EVENT_TYPE_FID_NAME:
-- 
2.17.1

