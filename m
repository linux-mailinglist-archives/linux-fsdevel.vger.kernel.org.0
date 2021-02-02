Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2B30C594
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhBBQ0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhBBQYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:24:43 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77166C061A29
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so30873922ejc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0A8vqp9jXB2g8rtmCu8Zf+I79MTtT3WrIJpZaghTng=;
        b=lKU27lsxzFlWOVzQP4xZXeTuLEnohik1rt7UqHbOEta1LC6JgJQwxMq3BiHf7Y+hHe
         /vylLA3TB23rHbHPgHk/FhlmK/hZ1gccER7C988O51UMWYSJQ4DgPQC4ARe2Ff5NcsDt
         gQ8bIcIYZmDtSTeoQHLh1de2wKmqtSA4s/HzADKF1TGa+hUwghe8ASErbpo9Vgko221p
         Dg7P1d97OXIw0aHv90DgYXmMlk5Rrir6vG2uAmMXt4ibeA6j9C5EjIh5lZugQZ6LFa+K
         izNURsARK6NP3pgg7Ev4sGeKurTAr/01uZGmmyAKV5Ava14nbSqg8/ooNohneJJShRKH
         vhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0A8vqp9jXB2g8rtmCu8Zf+I79MTtT3WrIJpZaghTng=;
        b=cBwSy6fNb69uy2lorkZnMDNjPR5SuJ7mtDjp/bvJ1sMD2G6wunvTBwHU+mLc1u4DCq
         ZAj3HROSVkUVMh2F1iny245eVNPtk87gZPTdmDiWqkopXMGzfMJ51lnu2lDWPtLWZwgS
         mpTShUmLetm66WPRnTTdr+Am86+8M/4+QeuMzGNQ01DfSXnvv0dR0Ce6P1MdNfh1w54D
         07JEYGOLxsQ/NHc27dXUxBMZSHHlyvFQrh+48ENUQxE6orTkt7LyKP7mO70mW5v62zN7
         6rBaQahOY6V6tbpozvljmXiHXKQAlAGrPCKnikTPfpqTWJ/syoQ0N0OfMWFUL4Tl8kn8
         Ft/A==
X-Gm-Message-State: AOAM533uYN3DBk3bZMTrPVE2RO5rOwuFkVQCZk2gtFRzS60kTUtAnqhy
        K80kl6xH+Jid8HQzEVDNY3Y=
X-Google-Smtp-Source: ABdhPJzxG2oBvTGkS5YBRbnHQj51R3tsCWIwc2hx2LW/QmKzC0ZGDAPYAv6l7/4Nci+PDGtSvHvtJg==
X-Received: by 2002:a17:906:1355:: with SMTP id x21mr835619ejb.53.1612282823239;
        Tue, 02 Feb 2021 08:20:23 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:22 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] fsnotify: print some debug stats on hashed queue overflow
Date:   Tue,  2 Feb 2021 18:20:10 +0200
Message-Id: <20210202162010.305971-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can consider exporting those stats also via sysfs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/notification.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index d98f4c8bfb0e..998f8753d358 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -72,9 +72,12 @@ static void fsnotify_queue_check(struct fsnotify_group *group)
 {
 #ifdef FSNOTIFY_HASHED_QUEUE
 	struct list_head *list;
+	unsigned int bitmap[8];
 	int i, nbuckets = 0;
 	bool first_empty, last_empty;
 
+	BUILD_BUG_ON((1 << FSNOTIFY_HASHED_QUEUE_MAX_BITS) > 32 * 8);
+
 	assert_spin_locked(&group->notification_lock);
 
 	pr_debug("%s: group=%p events: num=%u max=%u buckets: first=%u last=%u max=%u\n",
@@ -87,10 +90,14 @@ static void fsnotify_queue_check(struct fsnotify_group *group)
 	first_empty = WARN_ON_ONCE(list_empty(&group->notification_list[group->first_bucket]));
 	last_empty = WARN_ON_ONCE(list_empty(&group->notification_list[group->last_bucket]));
 
+	for (i = 0; i < 8; i++)
+		bitmap[i] = 0;
+
 	list = &group->notification_list[0];
 	for (i = 0; i <= group->max_bucket; i++, list++) {
 		if (list_empty(list))
 			continue;
+		bitmap[i / 32] |= 1 << (i % 32);
 		if (nbuckets++)
 			continue;
 		if (first_empty)
@@ -99,7 +106,9 @@ static void fsnotify_queue_check(struct fsnotify_group *group)
 			group->last_bucket = i;
 	}
 
-	pr_debug("%s: %u non-empty buckets\n", __func__, nbuckets);
+	pr_debug("%s: %u non-empty buckets %x %x %x %x %x %x %x %x\n", __func__, nbuckets,
+		 bitmap[0], bitmap[1], bitmap[2], bitmap[3],
+		 bitmap[4], bitmap[5], bitmap[6], bitmap[7]);
 
 	/* All buckets are empty, but non-zero num_events? */
 	if (WARN_ON_ONCE(!nbuckets && group->num_events))
@@ -175,6 +184,8 @@ int fsnotify_add_event(struct fsnotify_group *group,
 			spin_unlock(&group->notification_lock);
 			return ret;
 		}
+		/* Run debug sanity checks on full queue */
+		fsnotify_queue_check(group);
 		event = group->overflow_event;
 		goto queue;
 	}
-- 
2.25.1

