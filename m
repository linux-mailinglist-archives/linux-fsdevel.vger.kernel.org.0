Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D510932D123
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbhCDKtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbhCDKtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA586C061764
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 02:48:35 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n4so9169837wmq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Mar 2021 02:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6inpK8e5gQdagMOstM4UZ+mo4MahSWvBmPFx6TwDxW4=;
        b=bW5RDsO32JReORhfQvJR6jAnM4epHERwx7GH3on64lCRwS1tUHrKv4sSYg8jzsA2nN
         K42ItI/bhig0iVlses8VkKLUA9oHA3HeaMmaol9Y3F6OtJWjDyXCgPMvVJhi1xH/wscO
         kkWcytwdfsWHqpH2ATrn78vV5ydgPfR4W4O3/zakE2UD6wO8QOMBxkf7oKs/0weyfcrV
         0Z34IB3ZqToHn2127VzN6LfSeECYLdfediP8QiLpgI1Lgw2cJnhzgiZ01+KNStAORzhx
         g0i8FSEemATT4HUBIDSdH09xoTXlJfjhRbEM78mAr74e/UF1nqeziwGG8aorvqHfme+T
         WCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6inpK8e5gQdagMOstM4UZ+mo4MahSWvBmPFx6TwDxW4=;
        b=a0aVAVA3R90mGcbx06Su+v2pkdg1khgi8Rpe5yuf/+2gAa5JJqhe02PDaPEslHkNcc
         +p7OEohF+q4B8x5Es7p1N4kJKF+p1u09QRDg2nCNYVznEeGyr3av3TyG89JltUddvblx
         hTrIVt7bQhUytSADdfPlF76Kucg1zlhqORBNnWSsAw9CG3GSmAcmfwaTF94OdjNJfGQc
         LY+eQiUZvX0kgtKzOT+SE9Y6YfFuIdzHxBfY+H6A1f9rU4JqAo7PhZJazapaFvnHtLCW
         dzoOT7jYQpCewXGClDcFy3vmw/g4q8AFqw3WEINyh0S0pgig79flgK2cGb9LiD1yDa//
         Nr2w==
X-Gm-Message-State: AOAM533rGMtsof6zqBSdDBMdoYx/osZ1o/g7VXLKxHdOg3t+tUEYNjtg
        uENcGLZU6nCUsjRtb1mRnmI=
X-Google-Smtp-Source: ABdhPJzP0G5ClnOf55mlstos//LUep4FvocPfhVzOGQVEHZXyM5LG+caKT+bJOKTg8H9krQe9PyYHA==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr3280969wmg.37.1614854914615;
        Thu, 04 Mar 2021 02:48:34 -0800 (PST)
Received: from localhost.localdomain ([141.226.13.117])
        by smtp.gmail.com with ESMTPSA id d7sm6736635wrs.42.2021.03.04.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 02:48:34 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/5] fanotify: limit number of event merge attempts
Date:   Thu,  4 Mar 2021 12:48:26 +0200
Message-Id: <20210304104826.3993892-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304104826.3993892-1-amir73il@gmail.com>
References: <20210304104826.3993892-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Event merges are expensive when event queue size is large, so limit the
linear search to 128 merge tests.

In combination with 128 size hash table, there is a potential to merge
with up to 16K events in the hashed queue.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1795facc5439..e9384de29f6c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -148,6 +148,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 	return false;
 }
 
+/* Limit event merges to limit CPU overhead per event */
+#define FANOTIFY_MAX_MERGE_EVENTS 128
+
 /* and the list better be locked by something too! */
 static int fanotify_merge(struct fsnotify_group *group,
 			  struct fsnotify_event *event)
@@ -155,6 +158,7 @@ static int fanotify_merge(struct fsnotify_group *group,
 	struct fanotify_event *old, *new = FANOTIFY_E(event);
 	unsigned int bucket = fanotify_event_hash_bucket(group, new);
 	struct hlist_head *hlist = &group->fanotify_data.merge_hash[bucket];
+	int i = 0;
 
 	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
 		 group, event, bucket);
@@ -168,6 +172,8 @@ static int fanotify_merge(struct fsnotify_group *group,
 		return 0;
 
 	hlist_for_each_entry(old, hlist, merge_list) {
+		if (++i > FANOTIFY_MAX_MERGE_EVENTS)
+			break;
 		if (fanotify_should_merge(old, new)) {
 			old->mask |= new->mask;
 			return 1;
-- 
2.30.0

