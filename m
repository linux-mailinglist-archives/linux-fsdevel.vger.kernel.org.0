Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1327B18BAA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCSPK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCSPKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so3454207wrc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w1xX2G0MUM7HeNuAW4oTRGSKIxL6yWzRoF5wXGlP9us=;
        b=PuyJbTySMjtO3HwYvywOrD4yFhJhGNP+qkaFZUT1IcMiyXyJ9r/elK9SemD0ISIVZA
         oXCUcNHUC/JzbnQpySA662oS1bvi8VVTNT+V0RFiRbmoJHznGfwApAEutoCdEuOelZ0Q
         yMsB6JxlmcJatRGwLNlHHPn8Y0biIFQq70qFuryvMSxli8654bj8efzk9AWQd+TFydjG
         PedN6DDnP1OiR0653yNTUubyTbWfhTvG6f8udkoN7P+zSlcGFgy3v28rNFTd46VQv3BU
         z5JjguYYnGkj1qqMdDeTehjp1w0Lzpp8CuzZDTpUUxJrMeh2vaIkN8tuTrSs74KRZhPl
         7mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w1xX2G0MUM7HeNuAW4oTRGSKIxL6yWzRoF5wXGlP9us=;
        b=NI4jLc8kbBxjZK0oFjSrTTl7whC2+SeFTX+Z5hzFgHnHe3GJHRYGpv/Qgs9K20chKx
         jlcOkFQUJ/8329xVmX02BMwkbNfWUViSLC9MAh1O0Vg8jl6EgrlpD5rhLJ30v0pmfWQH
         SBOuh/ZkCbZfOizbBSj6/L4CICl0V0/MVy+FXRR8n+RnveEoFnjGGBrYW2IFWQxQzPyB
         TQdZ1DybhSrip6rGf0pB8Lj5NVcDcyasxFcOd5p5iNP2DUN3xsOk8Yo0fzeCYoAFf2j3
         Uap0B+DX27GpvI/Or6KRbfC9mN1E3Q340hJ+vuRizPPD9UpnJy13/4rhQwVwasc3WMW4
         PCgA==
X-Gm-Message-State: ANhLgQ1pchHEDbaYKBucZtV/mSAePpr5s6UDlQZCQefaTZuVd7ijscUk
        qTvee8Qrr5fEppuAkqXM2GM=
X-Google-Smtp-Source: ADFU+vt+yhEeifFVTmVk8zAmNAyrQbIMruNuu7Zn0qbqJUZ3VB5i985osin2LnC4Mqf1JZt2Nwa8Zw==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr4806771wrt.402.1584630652802;
        Thu, 19 Mar 2020 08:10:52 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:52 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/14] fanotify: fix merging marks masks with FAN_ONDIR
Date:   Thu, 19 Mar 2020 17:10:17 +0200
Message-Id: <20200319151022.31456-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
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
index 97d34b958761..960f4f4d9e8f 100644
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

