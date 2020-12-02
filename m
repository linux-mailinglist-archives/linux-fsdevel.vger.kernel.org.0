Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54C2CC517
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbgLBS2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389417AbgLBS2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:28:34 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3350C061A47;
        Wed,  2 Dec 2020 10:27:53 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 4so1598608plk.5;
        Wed, 02 Dec 2020 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkEYq1AbhtqAqcYcbg4MnCPD7vjrV9yb9ptbuyDsX7s=;
        b=e9dwHcNdu7EFBl/w9TTMJ9je2f+u7YOLF0oqHhpkacwkv0z6eoHdHbR5bBVysiUy7S
         k/eyxfXWwsW8tq1Rw7LSGswb7sz3iEbgs4Dzuc64wQHTZsT5dB7+wYk5p245+y054Pbx
         s1Uz0/gZ2OnYVxsYq95GVM5/9ZonmhfVYVWtvTU8zc6L3SL4ARxblDsZ79r1pneesFaJ
         ARnO7Jep0MtbYcsov1Aen2ynYSROnCY6OJZc5n91JATpvPaQ+xxFGwsJh1LARsxG27GM
         JMNYmZ5fMAkOQ8hNjZj0QT0gJTCH+CctT9rZ446s538NXr1uKWBwZ8QONdKGJxqjrGVq
         siYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkEYq1AbhtqAqcYcbg4MnCPD7vjrV9yb9ptbuyDsX7s=;
        b=Ek5MNFK6VbPwtAXtQusVO0mFBoeEKwO8VxwmcuwGjZvBscNe2wFVaefzNN4in2hBOO
         So1Y3BU4ElpSYngtIEwn6GyCga+5MaLwxmWclVaT4hrigokNqjPQ5B6NXwQhgHp99wjg
         6bCi7jKO1i/ufRGVhNkGUdCl+HHyVYj0093JTCoNH2Ck2kNxMmdLt0oP7zlQ7RYcHDQS
         2l1yi3Id/IlapdCvdxYTZp54CDBsDBKPXlvh4IIwUCa09GzOC8JgttRSydUJkII4sOjH
         cz5VMtl2QUty8YfLhPMvwWc9SvRJwTURhU0XkzVqCctkE8/8DUSWjyucgDvxeUa3FGuE
         pHHw==
X-Gm-Message-State: AOAM530ps1jcUmgqqYiD2HvYnG6xsP8Z/j9rhhg+ItdB3tq041BYQOh5
        YXsPQh3OghuyVYjSlfbatUM=
X-Google-Smtp-Source: ABdhPJzPNtHrC4FduKm4RHeTLfsFp82wDr46oGUu8j76eW7YY+ermZiSR0NsIBwV4iSHp3D3Ek/b0Q==
X-Received: by 2002:a17:902:7297:b029:da:861e:eae1 with SMTP id d23-20020a1709027297b02900da861eeae1mr3726068pll.8.1606933673363;
        Wed, 02 Dec 2020 10:27:53 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:52 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Wed,  2 Dec 2020 10:27:20 -0800
Message-Id: <20201202182725.265020-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
This approach is fine with nr_deferred atthe shrinker level, but the following
patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
from unregistering correctly.

Introduce a new "state" field to indicate if shrinker is registered or not.
We could use the highest bit of flags, but it may be a little bit complicated to
extract that bit and the flags is accessed frequently by vmscan (every time shrinker
is called).  So add a new field in "struct shrinker", we may waster a little bit
memory, but it should be very few since there should be not too many registered
shrinkers on a normal system.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h |  4 ++++
 mm/vmscan.c              | 13 +++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..0bb5be88e41d 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -35,6 +35,9 @@ struct shrink_control {
 
 #define SHRINK_STOP (~0UL)
 #define SHRINK_EMPTY (~0UL - 1)
+
+#define SHRINKER_REGISTERED	0x1
+
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
@@ -66,6 +69,7 @@ struct shrinker {
 	long batch;	/* reclaim batch size, 0 = default */
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
+	unsigned state;
 
 	/* These are for internal use */
 	struct list_head list;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 457ce04eebf2..0d628299e55c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -378,6 +378,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
+	shrinker->state |= SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
 }
 
@@ -397,13 +398,17 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
+	if (!shrinker->state) {
+		up_write(&shrinker_rwsem);
+		return;
+	}
 	list_del(&shrinker->list);
+	shrinker->state &= ~SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
-- 
2.26.2

