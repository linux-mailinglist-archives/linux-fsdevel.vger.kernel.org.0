Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666692EB5A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbhAEW7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 17:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729979AbhAEW7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:59:45 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9CC06179F;
        Tue,  5 Jan 2021 14:58:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so885903pgj.4;
        Tue, 05 Jan 2021 14:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpu1i4q0ijAqTRSCt6SNBy+m3wFuqzhxFrW2P//1NQA=;
        b=DijFY48hNMYK6anOj/dwQEh7dVjSFg7bIP4tomaqjA34Hb3q9vOJToWJriIR4OFHEk
         KJh9f3fU4XWcl5TTFHyThszZVA2z/lpMuAksFrMV/e0+lna8pyXuBoe4xPy1Eunxo02D
         DUQP/yj8NBv8EPgJWPxEf1+wqePFZI9Q0Mmtbcg1Z4f1NvcIRsaQcWCsDvfmD7pmYq4A
         gKIxgHz2dCWhOgDoSFgmWiwDqpY/JcurWUQsmKlZesVYWNAL+orW8TTkBdzXKpMUslTR
         YHShCcxnLn3LA6s1Ob7bMD8RsLwn/5emyAlZPHE9455CHYQ+qDqCgICOdccEAPNZgTU0
         Gsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpu1i4q0ijAqTRSCt6SNBy+m3wFuqzhxFrW2P//1NQA=;
        b=L6SZmJ3qXYEf0Sp28CBUXx9VQx5hQ3CDSjgKjgT1KNbpduaC5YBlwMqOVvRK9a5WdG
         WpsrveSEnRZR7OMA3u4hcKAOLE7n4ycP5wkOJaOHgBXbZIXaHZbV/7ouaa/V+3e9gq9C
         DhG38OP/04I595h57KlqZuHjdKhgXWjaFyDVgfKoo9gPSm9fnrCK1JlDIG0L7I3W1U70
         4CStWDd0lWvSot1DjtQlFfRL3e/kAHUC+nfnnP73OfAhkIl1ycQWJorrQ8um3TSOPpWm
         v7FCMWlUhWCyKHPbSviv7UEZrCtflrIp0EAUe7fCZ2YyubE8tycgie/wGyqKCWvmvsAS
         hILw==
X-Gm-Message-State: AOAM5311iLZd4wErLRRXCco+EtyFnqeg3euA1MttLtmckVyp2dKfotvr
        Sn821pW1M1F6ExLS5S2bNu1gzmuzNCfqgF2Q
X-Google-Smtp-Source: ABdhPJw4z9EqUFEodw9IFzrIRRXt5KZzuqKFATmgY9X8Mqa/VzTgZf43k0DZQ8+rY1H8MLW/I+o15A==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr1386110pgb.332.1609887535455;
        Tue, 05 Jan 2021 14:58:55 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:58:54 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 05/11] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Tue,  5 Jan 2021 14:58:11 -0800
Message-Id: <20210105225817.1036378-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
This approach is fine with nr_deferred at the shrinker level, but the following
patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
from unregistering correctly.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h |  7 ++++---
 mm/vmscan.c              | 13 +++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..1eac79ce57d4 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -79,13 +79,14 @@ struct shrinker {
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
 /* Flags */
-#define SHRINKER_NUMA_AWARE	(1 << 0)
-#define SHRINKER_MEMCG_AWARE	(1 << 1)
+#define SHRINKER_REGISTERED	(1 << 0)
+#define SHRINKER_NUMA_AWARE	(1 << 1)
+#define SHRINKER_MEMCG_AWARE	(1 << 2)
 /*
  * It just makes sense when the shrinker is also MEMCG_AWARE for now,
  * non-MEMCG_AWARE shrinker should not have this flag set.
  */
-#define SHRINKER_NONSLAB	(1 << 2)
+#define SHRINKER_NONSLAB	(1 << 3)
 
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8da765a85569..9761c7c27412 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -494,6 +494,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
+	shrinker->flags |= SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
 }
 
@@ -513,13 +514,17 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
+	if (!(shrinker->flags & SHRINKER_REGISTERED)) {
+		up_write(&shrinker_rwsem);
+		return;
+	}
 	list_del(&shrinker->list);
+	shrinker->flags &= ~SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
-- 
2.26.2

