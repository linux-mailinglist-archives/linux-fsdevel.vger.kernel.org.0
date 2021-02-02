Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CA30C591
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhBBQ0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 11:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbhBBQXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A7C06178C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Feb 2021 08:20:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so30807070ejf.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Feb 2021 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3R3CUFM/VPugeyGg+ebmB4rdsafEG1X2X1CcoNEosvQ=;
        b=CerDZV9ZZO0XB/Cgd/eYoUKmz7X2MgxPyzfXX2hXtAv+UNb94uCWAXPF8bskhDql/k
         3vK0enigB/Sz9UFObwYF2VOVqZA7PXVFrKZYbfh+EIHlkETuLYQeTJUTWT5QThPmZt/5
         nmpwjjpQGzLWDMZcFmSXNLK3bmAS+4RvtFoVUTdvOhKn8rcV4tpy6h0iCa25zvPFp/OH
         vIeUVuixHzGx1rqrDqpBFHNSpqwMCdTMNIGGDnUjLtId+j1QcrFYlcEpfNPO135TfY/2
         i/t9PtmQobQMCrnp7W7UiVRZF1yfyPSkOBzcZ1yuir1qDmwLIznASMEvFbxw8sA1FVj8
         rUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3R3CUFM/VPugeyGg+ebmB4rdsafEG1X2X1CcoNEosvQ=;
        b=a8unn612deKjm4qiB3OUbOXw/hVApSDOrH5FIVpB3V7RZL1xIzm7K+wmIxt+BEZ9mh
         RlqGuk/7TmarFc8MJcrsC+o0cuVVn5Xp2ZkwrpeIBfxCNHAStxuvmpSR8kOSQUI0kVoI
         bsAxIbZac1dkxHFNnEvfLsXdyD3S10jxb+uSa33TIZc0/GPxopvtzJXYmL0529ypAdgp
         4WuKnNVk54hkOpkpcjsbQuu9VRkArclHBNr8eUfe4Z01LwUTwxEwaC3dk9N7/nGH//W0
         n7fadsEAxgublZpI6mWHrJIcxUN4pIPkQByADSyVVXspCcSWDHDS0qlARWKssMjh+Lp4
         6gtw==
X-Gm-Message-State: AOAM5330fOvGJg4ooZiKSJdRvcJWRUVbnJIMgwcerh3ZJklqYMSbiQLe
        UVHcZlQ7l1cwta3MI9YSE4JzQDNw+/k=
X-Google-Smtp-Source: ABdhPJyUQp/+J5mGXZlqHHKCeChMujNyK0cJuCk9KILJMgLCP4r4JMe/z3f3hulDNp+LU1RzqXnNwQ==
X-Received: by 2002:a17:906:55c5:: with SMTP id z5mr1249509ejp.275.1612282818784;
        Tue, 02 Feb 2021 08:20:18 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id f3sm562450edt.24.2021.02.02.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:20:18 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] fanotify: enable hashed notification queue for FAN_CLASS_NOTIF groups
Date:   Tue,  2 Feb 2021 18:20:07 +0200
Message-Id: <20210202162010.305971-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To improve performace of merging events when there is a large queue of
events, enable hashed notification queue for FAN_CLASS_NOTIF groups.

Use 128 hash buckets to reduce the avg. event list size by 128.
With the default queue size, that leads to avg. max list size of 128.

When fanotify permission event is canceled, event can be removed
from the middle of the queue and that can break the read order of
events in a hashed queue.  For now, we do not support hashed queue
with any classes that supports permission events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index dee12d927f8d..641c20ad96e4 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -29,6 +29,11 @@
 #define FANOTIFY_DEFAULT_MAX_EVENTS	16384
 #define FANOTIFY_DEFAULT_MAX_MARKS	8192
 #define FANOTIFY_DEFAULT_MAX_LISTENERS	128
+/*
+ * 128 hash buckets for fast events merge.
+ * With the default queue size, that leads to avg. list size of 128.
+ */
+#define FANOTIFY_NOTIF_Q_HASH_BITS	7
 
 /*
  * All flags that may be specified in parameter event_f_flags of fanotify_init.
@@ -941,6 +946,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	struct user_struct *user;
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
+	unsigned int q_hash_bits = 0;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -989,8 +995,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (flags & FAN_NONBLOCK)
 		f_flags |= O_NONBLOCK;
 
+	/*
+	 * When fanotify permission event is canceled, event can be removed
+	 * from the middle of the queue and that can break the read order of
+	 * events in a hashed queue.  For now, we do not support hashed queue
+	 * with any classes that supports permission events.
+	 */
+	if (class == FAN_CLASS_NOTIF)
+		q_hash_bits = FANOTIFY_NOTIF_Q_HASH_BITS;
+
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
-	group = fsnotify_alloc_user_group(0, &fanotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(q_hash_bits, &fanotify_fsnotify_ops);
 	if (IS_ERR(group)) {
 		free_uid(user);
 		return PTR_ERR(group);
-- 
2.25.1

