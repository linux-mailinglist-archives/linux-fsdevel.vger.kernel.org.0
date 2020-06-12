Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD51F7610
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgFLJeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgFLJeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A1C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c35so5960940edf.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFAMFVDTjUDpNLa6LXGHmWbMVMd08UGun1Bph1jmaAw=;
        b=T7wl2PaaZUuW2RALJ7swOmqmOlSmNv58VNv2jdhTT1XKF5ib7hABnHpvPuRwqjmwnW
         EA0PzPjnh2kXe7EYLa7zIleTiAQug+gxOnYisWX36L0rxIVpDa0oTIkrcsdM2awl9+j4
         AZ/R3oE9N+ClTX+xmHNC9etAXJbJs/F0IXAWwDvnK7Mxvinkxyi5JucVBDmTNvpA8VLG
         QEGoodL7sjjzmQBuENE984b8ud5CmEqrDjLtdD7JsgOIi4fumiqp5tEpvYjP8nywbVK0
         OVheGysYYtn/hbTqQPmnZKSjMMoY0MLQt13nck++qy4wBAx/jTas3FhzE5MKp8islKQM
         2rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFAMFVDTjUDpNLa6LXGHmWbMVMd08UGun1Bph1jmaAw=;
        b=Rm/rRIGXGDcmxu49VeDUd4tuV/31OXtuKWsjr8cWfPkw+yz0O5ZveM6UYUyrKFcAk6
         RKjwdkM4NoZ1DIn937bTO4W70MAo7uMYZeLzI0P6bd3ihFAvdA2qEoS+ilTuVAWMHuHf
         ZQcF4i2cB7+1lLVy9rKDMgC5mEnlfEft4AfErEMDYZ7Rhn4wC1ozEEy226SEh8nNJua3
         2lHW0R1yA1pTc8wXKcvlrJwMsnnwPx+UNrO4k1O3/uOD7+K99uENtyQGe8oxv4mFSYaO
         pvvh7wMYQBlufxMOvOXWN8A3EVy8ShH1dXw0sh/0U8Ztf6h4cuZoBIniE8pVxqtknX6k
         JVsQ==
X-Gm-Message-State: AOAM53057/1O1I8fcFvaIBw20YkR16GKZiALg+/x0pT1m5pzqJ9OcL1C
        s+iWxVfEru61M1tr7VSdvipDRu79
X-Google-Smtp-Source: ABdhPJxmmiGvWYvPL9PjZEcR4x5HstN1i2TOkZJ6DB+l8HVtsmYwOvaMui4UwisBZkz4EPXd1kFeFA==
X-Received: by 2002:aa7:d7cc:: with SMTP id e12mr10474819eds.70.1591954456000;
        Fri, 12 Jun 2020 02:34:16 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/20] fanotify: generalize merge logic of events on dir
Date:   Fri, 12 Jun 2020 12:33:34 +0300
Message-Id: <20200612093343.5669-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
index f5997186c8b8..63865c5373e5 100644
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

