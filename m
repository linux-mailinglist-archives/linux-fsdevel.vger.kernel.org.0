Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5D221EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgGPImt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgGPIml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0EC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so6158242wrm.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sd8X1Bqt/nvK6QEcN6uojROEKKEljO7OuTjR5GFnFy4=;
        b=HTR7LqSavH9O7suL0NSSEAX5iYznt++cOmZqdQeVA1QFks7tVGaAU8gKC5DOJwkW90
         v1vHRpRujSJ8GN2JP3AldpvCtwUr36faXZwdOjw82VVSwc0JIi81jL/arhuf/vert+zD
         UzJ5U++RteYc22xLEMZ+8P1tphIsSCYLV2cNWBmZgBdedhMhGt1/l5y5u7WYzfU/u+7k
         59IpRFrSjzWlB+I+vq86v0fcyqKYYRA4T9EhEHuYYrEJYYc4hQgQhvUE6y6VCzrgAa0i
         Cl21h2479Sjeu/9Z6PKKESALQ7IVC0rzLqQbiQDi82gTH/DPZuuh9n54pn04RvlaoiMX
         mVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sd8X1Bqt/nvK6QEcN6uojROEKKEljO7OuTjR5GFnFy4=;
        b=ixd0uzzl//7yaTQhI9MAjZPhHUunhc7SS/KGeiGL48kab1g6PQg2+EiAXRapzRNszg
         I2ofTWz/xO8uHJur2QBMoHlcrbllwNkM4OtKxW/oOQlfo1daL4ObmK/iud/9PFisrcPj
         yPKEN+u3M220IjWjptzCHVtXo6KtkSlrcWxmqURAXjyWaZ/B3iDbkMqZwAQwGM1mAHFp
         MUHNrqPLWguV/0tpQHN2tFlIhUdWM1nARGTrqFiZfvCKtzXk/vZBq0o9Cz0GNiupkZSl
         6W/4eUyr6xJTQGe0KE6KlgerpT0lrNGPdJt+RK3oArUNdD7orhX65KitGJtrg5UqTzrq
         61Wg==
X-Gm-Message-State: AOAM531s7WWu5kMNDLFy7ru76dAIplLnvFGhvD1rei6qprpscyXM7448
        Sf6Yp9gcvWa7tbHwhup4IK7EAUbv
X-Google-Smtp-Source: ABdhPJyG4MlsxGMebAlG3SAi1JQgoDHv+DlhEnVsw2+eabjl+MdGKvRSijQ6h+IVJGZE+C/btNMtmA==
X-Received: by 2002:adf:9283:: with SMTP id 3mr3834894wrn.231.1594888959582;
        Thu, 16 Jul 2020 01:42:39 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 02/22] fanotify: generalize merge logic of events on dir
Date:   Thu, 16 Jul 2020 11:42:10 +0300
Message-Id: <20200716084230.30611-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
index 110835a9bf99..84c86a45874c 100644
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

