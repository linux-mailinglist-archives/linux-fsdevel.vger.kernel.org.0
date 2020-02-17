Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA91612F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgBQNPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44878 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgBQNPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so19647092wrx.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=opyi01Gy2VvVvfzLBUO4P8c3KpDkIjDxhze7gbYoZZk=;
        b=bXGOYfFfVCbbbvA6vPF2Y3+jC8tVup78YtA8mhbNUhhNoYQzC9h5M/zu8X5cJ2ksi+
         ApvMFR4QzgXtMhzVdE9JDaaDjP4B5V1StCEQweafizyMDH1WWe5gWOEMYhtKIeb0MGDc
         UpEgTc1oiWXoWPm+5WTPaZWq9sONOIhL6PvzXCuQez7FAI93qP1lBG1MnldwtDoBywu2
         7u5RqGGJm9+ZhQxmN6Ajs8Hfkei4mgHOh5y0nUV2FwbzWV/skgEKFdAoYInolRbv+y0I
         h55KC4XPiDL0TCPA8OlvkGzuLBftsEsiKhVOvGBFjL8n0/uXKNRSuZMqPuI31Xx3jcJU
         qZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=opyi01Gy2VvVvfzLBUO4P8c3KpDkIjDxhze7gbYoZZk=;
        b=sJeSzrF/9f9WvGzRo4h2YDyFBoYcoXmkdvxZAhqT2U8JcgQq1zDMQa77UC5oAWg0bm
         Ztvfmshq6PJB9+VHHnlUAepGaPLRPFodRidWN8dq76PDM6zOh1+3gQWJJjfg5K7QFZwb
         +tSCVoC415nkwLz/iJuQb4+99k/5sGP9Skvxg/ALUcsMA8yyuBMu8XN/kweZuzOUTYVG
         u7G5dsqhQzru3ULJuswYu3mWbVgYGM5bFX0Hk8VLLDo8E4N96WxJ6wWXtHqEOmdIs75p
         Vxfs9XGe/Hf5UFTJ+eaSqDEQxe5mihuGkAbVtOgltaCOoxXyoQsaTVd8/roZZrYllIGj
         mquA==
X-Gm-Message-State: APjAAAX2wsO1uGwAgzC+mbdJiX5Af/ewp57IEsecAd/LgZEtlPZAY1pp
        VPD0AR60bsWQYl58+tY2UZs=
X-Google-Smtp-Source: APXvYqw17owg2YplLG7C1XrOfVfJn4akUufp940rCgY1G+Icq8UhxwQoxI9gKDSDy7zowQV8QEhiVA==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr21439910wrw.31.1581945317976;
        Mon, 17 Feb 2020 05:15:17 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:17 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/16] fanotify: fix merging marks masks with FAN_ONDIR
Date:   Mon, 17 Feb 2020 15:14:48 +0200
Message-Id: <20200217131455.31107-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
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
index dab7e9895e02..36903542aa57 100644
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

