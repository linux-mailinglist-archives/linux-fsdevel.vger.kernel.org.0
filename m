Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683E030C59C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhBBQ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbhBBQYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:24:11 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908ABC061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a9so12471111ejr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t8gF/7MnhThY2j1XM7SKo96HwlDRa32gOOq7/bZKJk=;
        b=Yvv5v4eG2LkMQCadSipNvPIGaWt32iEufCPauNGvLPSIkjlew/+iCWnBSKm9BDL7pY
         Na4uGGGjBoZ7+VZWp11Kgmll8Hmiqx80ZRc2sRB+BuoGwBhKDtMFuM1vnqjD84+9hxJZ
         JmlH04RqCKpzXcF8yb4rKRMK/Fmmhx+lwidhWTgQ1fwIw439WjT0nFgHD3E+azIAkbDM
         uYJD7xEbsxUrUCBZP7w4NKOBmyv5FcRUZEsVk5NMLsB9Exv09gHnCNZg/QFQwzjY12TN
         Emx5UA04WXpEjVZ81tyWDVDnEKHEZEsxp7aP5iuqObPBZXQoLD3M037vyu+R9t2GDv8Y
         M6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t8gF/7MnhThY2j1XM7SKo96HwlDRa32gOOq7/bZKJk=;
        b=b0Sv4CUT0G0eNGhtOYlZaKae+6LUrZC/Xz/PFQoKsYZbvde4lrfY+poSuWN2GE2c8U
         xpzeqLWvniDpwtkwKEcaIfTvmu0MoVSbvFu/dLIpOUULYZ5t1ohFOG/kahKBf2ZKXHn/
         aSAIJIsJ/cnG5pnoNPdk7Ltmt9HKiVzPGcffXigpCcyeAdGYb2Od9hkyw+25ljR9+TdB
         pOa0kV4N/ZO80EfhUULZlYNN0cBhkzyNMBHiKsnbXtkG2J+3VAygkgLZVeuz1fIlnHNa
         lgjbyI0OBQy5UkKeMy9ulU54xK+Rp3ShO2t34LzknIjdZZ3fIEV0SFHxe2r3BwSzfHn/
         EI+w==
X-Gm-Message-State: AOAM5326O4GfF8ZOPwmFX4Lw4KPvbDeXTlV2bXcXYAMtByXLYxYAXgZ7
        LjhcTj2w1t+cG5Wdn+h7yh4z9c9v558=
X-Google-Smtp-Source: ABdhPJyCeA5ys0yDLUgfuCeGulGujR1MdxLBswTW7DwdiVLy3yWpG+bivqPOmCirpNMtgNhMhIgrVA==
X-Received: by 2002:a17:906:c05a:: with SMTP id bm26mr24145314ejb.288.1612282820373;
        Tue, 02 Feb 2021 08:20:20 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:19 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] fanotify: limit number of event merge attempts
Date:   Tue,  2 Feb 2021 18:20:08 +0200
Message-Id: <20210202162010.305971-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Event merges are expensive when event queue size is large.
Limit the linear search to 128 merge tests.
In combination with 128 hash lists, there is a potential to
merge with up to 16K events in the hashed queue.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 12df6957e4d8..6d3807012851 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -129,11 +129,15 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 	return false;
 }
 
+/* Limit event merges to limit CPU overhead per event */
+#define FANOTIFY_MAX_MERGE_EVENTS 128
+
 /* and the list better be locked by something too! */
 static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 {
 	struct fsnotify_event *test_event;
 	struct fanotify_event *new;
+	int i = 0;
 
 	pr_debug("%s: list=%p event=%p\n", __func__, list, event);
 	new = FANOTIFY_E(event);
@@ -147,6 +151,8 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 		return 0;
 
 	list_for_each_entry_reverse(test_event, list, list) {
+		if (++i > FANOTIFY_MAX_MERGE_EVENTS)
+			break;
 		if (fanotify_should_merge(test_event, event)) {
 			FANOTIFY_E(test_event)->mask |= new->mask;
 			return 1;
-- 
2.25.1

