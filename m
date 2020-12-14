Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3952DA386
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502500AbgLNWjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502413AbgLNWiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:38:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B974C0617A6;
        Mon, 14 Dec 2020 14:37:50 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so13749464pga.7;
        Mon, 14 Dec 2020 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buF0Bc96au1TIy8Azp9h1XTsIalRZi79CS3NEeVVksI=;
        b=OaUcYrYVf/eeMpxa1NLV/j1JCTA3035IB9EUkfK3Pj1tDDE9eF3GHvc1LmiNegkWnH
         vZKB9fyYio5aTMn3q269OXiEB6rOIRy9cFsX3Ve5v8g9/cHgo8OSh9K+KhokHrHtNS4T
         HuR8/EwA3E9eyzcqZAOrmJ9iT0iZvl2SgPhk/fK3FuvkiJjvH7kamIhCNcF5cyrJD1Os
         GQN68PXwvsxq5aQR44ulyWqZ6s84fCyZmdJ0k/wxHnooGLkH69L6I/se5zmYCtglPmbm
         HxGN/G/Oq7BpsavM8km/yznT8JI7JISm7VYSEpRfFRfKj4peKfG6mKuY/gDBvNMcZ0/u
         g2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buF0Bc96au1TIy8Azp9h1XTsIalRZi79CS3NEeVVksI=;
        b=tJYQ4kOTu79yJcGcLrRbqH4IWyTRBFo3PZc/kR8r2r73jaIv40UQ2THO6HCb6h18ch
         e8bTliPZ+5rCSYIl6fJ9BKMTmHsijyMK8e10kKBOREiCQX0Sq1aAFRFZWqO1pneEvN8Y
         I5OoCB94hMrqz3PrhmgWXwCMhC0wkvpgfjyDvNQkXhfDAecSfLjJYwoF9KaPEv4H+V0F
         pdaQccIPKwhSpmuzl6urPTeFWLlwl5O9B+AD6TSk/sEeR03Nl3GZEy68Jjva/B+xHprc
         2KN06LYEg4d3yymtGLvPvo49moxOL+VuW5zhQKDdjvquNgNeZ/95CjI+IwBaDpvynDWO
         8pDw==
X-Gm-Message-State: AOAM5311nzS4YI+MLGmrx7lfa5iZIiGvhaJ9OPe4vjuOMMxIr0m36lC2
        Pmg/1kFcAAgYq3SuEW5PTWY=
X-Google-Smtp-Source: ABdhPJwzng310WgdKPBA4Pp2tm1EIsAo8wEKWhFrdn5P24aXLStOtFuZeSLbkUX67IKRJTf9pkPdCQ==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr25614645pgm.218.1607985469792;
        Mon, 14 Dec 2020 14:37:49 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:48 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/9] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Mon, 14 Dec 2020 14:37:17 -0800
Message-Id: <20201214223722.232537-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
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

Introduce a new flag to indicate if shrinker is registered or not.

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
index 9b31b9c419ec..16c9d2aeeb26 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -378,6 +378,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
+	shrinker->flags |= SHRINKER_REGISTERED;
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

