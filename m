Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0401E13AD57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 16:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgANPRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 10:17:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33783 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgANPRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:17:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so2551261wmd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fWLq+NHJYf047UcKEJJJVBWiVqpObyKPnwSeuu3SPP0=;
        b=eHPUoUdLYZ/qOfXpMHvmR8LDBczxFafPl3agS7mVMz1nwJK1DJhL8eCpRiBrLe2uZM
         v9EeyVrV4lVTSmIhoy22E0nNlL22z34hBvLyZfK80qQVZgWAwVRMHGmpkDl88ndGSjjr
         +x1fLKPXdb+3RgfJj5kwo0O8cLN4C5ddXtv/Ijb/t/MmlLvarzZf5Sl1IUdDnPOGA8NJ
         fNf26zYWeHFVNJCRbGg9pcjwp/P+O6uLR72uAmc+/VTvZgUWfVrNM7ZRnkoZr0/thRoM
         sWR7qBb+zav5BH9IZF5GgpkxMdGZhla4mgFaFNCDLxziFdKgyE23cKQ9v+nFscXkHPNF
         7Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fWLq+NHJYf047UcKEJJJVBWiVqpObyKPnwSeuu3SPP0=;
        b=X5RZqlQeY9eyI1HqwVxU9YObthUM2qUl53K1VkzEFZymiS36wADhvm3MZ/qr0TqkWR
         Z9pf7E2EIXdovmKJWBBr5VPyj/evaEGLNvQ7TQOtUM7D/rsGe/3eyJqzLm5HKsswYWUb
         89a8kVaSiJiN89Ch81o0AZ++LNOopUWIfkUOAUrs8kbdr2Yr6oRffb6BIVdgZjaxmhaS
         cpCkStp/YvQvNxgzAzD+0KgbBKolXgM/2L8BUwqDMDxK4aYLdCIhlmQ57a0W5nKXdpzN
         JnF5Ug8vmm2mnX1YeyRG12PFLgqXTh/KGM6g31iT3u6RHkUVNnZSurVuD6eZtCwWi++E
         o1tA==
X-Gm-Message-State: APjAAAXjmwMOxUKvu6FpaFbgyzADUICHujfgJsjYdQCSq5F2riX0XUNV
        mN/jjD7Y8EcpqPNWIGdGycFOTLax
X-Google-Smtp-Source: APXvYqx3yqlvZ1+XcwJOkLmD+177ZJKerm6ZJpZkknk9ZGOhTXbuq0dwYqxDF0mFAlEfGg1xSd40Ag==
X-Received: by 2002:a1c:730b:: with SMTP id d11mr28928418wmb.30.1579015028535;
        Tue, 14 Jan 2020 07:17:08 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s19sm18276993wmj.33.2020.01.14.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:17:08 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] fanotify: fix merging marks masks with FAN_ONDIR
Date:   Tue, 14 Jan 2020 17:16:55 +0200
Message-Id: <20200114151655.29473-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114151655.29473-1-amir73il@gmail.com>
References: <20200114151655.29473-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the logic of FAN_ONDIR in two ways that are similar to the logic
of FAN_EVENT_ON_CHILD, that was fixed in commit 54a307ba8d3c ("fanotify:
fix logic of events on child"):

1. The flag is meaningless in ignore mask
2. The flag refers only to events in the mask of the mark where it is set

This is what the fanotify_mark.2 man page says about FAN_ONDIR:
"Without this flag, only events for files are created."  It doesn't
say anything about setting this flag in ignore mask to stop getting
events on directories nor can I think of any setup where this capability
would be useful.

Currently, when marks masks are merged, the FAN_ONDIR flag set in one
mark affects the events that are set in another mark's mask and this
behavior causes unexpected results.  For example, a user adds a mark on a
directory with mask FAN_ATTRIB | FAN_ONDIR and a mount mark with mask
FAN_OPEN (without FAN_ONDIR).  An opendir() of that directory (which is
inside that mount) generates a FAN_OPEN event even though neither of the
marks requested to get open events on directories.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 2ae82040f26f..a98ee4340eaa 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -171,6 +171,13 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		if (!fsnotify_iter_should_report_type(iter_info, type))
 			continue;
 		mark = iter_info->marks[type];
+		/*
+		 * If the event is on dir and this mark doesn't care about
+		 * events on dir, don't send it!
+		 */
+		if (event_mask & FS_ISDIR && !(mark->mask & FS_ISDIR))
+			continue;
+
 		/*
 		 * If the event is for a child and this mark doesn't care about
 		 * events on a child, don't send it!
@@ -203,10 +210,6 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		user_mask &= ~FAN_ONDIR;
 	}
 
-	if (event_mask & FS_ISDIR &&
-	    !(marks_mask & FS_ISDIR & ~marks_ignored_mask))
-		return 0;
-
 	return test_mask & user_mask;
 }
 
-- 
2.17.1

