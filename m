Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9161E1B53B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDWElB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 00:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgDWElA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:41:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903BBC03C1AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 21:41:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p13so2207635qvt.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GhnxqN9CabrJDTRLrZH4BYssyupAS+5LbE1odxMWHKQ=;
        b=ymGQm9PAKUkPPMecNDR0Z7iD5NAolQZ9CFhElnv4TI/6sCmRDjJk0MfeiEe0Iti7UL
         i509QSKqeP+hwyppiLrTOkpartVsjD+nu4Hm2DUOhCGKhzl65Ar0nPiOmXCFCyeMJLoY
         FQESDpWKa3QWdsBSTt9OzSFiCOJBqWuGn5rUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GhnxqN9CabrJDTRLrZH4BYssyupAS+5LbE1odxMWHKQ=;
        b=ZrA+D9IdrBmLQmN3xPoeQo5A+Z5NO6BlEM5jrjQxKFosYi3hihPD96F83v/xmsTraA
         djTJ7RcWucXkGPlZ2NS/zj5ouqCrrREqLZztWeyuD+q716O1o39s5oeVDo9PThGFKNYU
         VZiEdyWVEE9NmlQLT43p02YLQl7CrRc5d2X/iRkSRKhxaLBIVUjSHM07JaKHDorJQyd5
         uRXumXifKr9R8Y3mdo3DADiEmzUO2sHiF4rwC5uhN/1CZC9i5iySQDjs2Ebq0CTNk9jM
         a/dW3rBuWKyFIBnEZY3zz2IDsGHieKYQn3jARAO0vXadDC+Jsab6eT7RuUaJivLXlj4p
         8ySw==
X-Gm-Message-State: AGi0PuaChFFjn5eyAIItk0M1jY4/X6XUW2Bv8cy9pXm513OUfl5Cobb2
        yMDgUTdJj/5xOPuhVg+v6v49/g==
X-Google-Smtp-Source: APiQypJuAiZWPo0bjJKUmv5REHrynKXgeGsjPCxFEpPfaWC1KSRLeDL4dCDzJRvYujqYBrXzSTJWhg==
X-Received: by 2002:a0c:ed42:: with SMTP id v2mr2379627qvq.94.1587616859609;
        Wed, 22 Apr 2020 21:40:59 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v62sm924150qkb.85.2020.04.22.21.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 21:40:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
Date:   Thu, 23 Apr 2020 00:40:50 -0400
Message-Id: <20200423044050.162093-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reading the famous slab paper [1], I noticed that the conn->lock
spinlock and conn->list hlist in fsnotify code is being initialized
during every object allocation. This seems a good fit for the
constructor within the slab to take advantage of the slab design. Move
the initializtion to that.

       spin_lock_init(&conn->lock);
       INIT_HLIST_HEAD(&conn->list);

[1] https://pdfs.semanticscholar.org/1acc/3a14da69dd240f2fbc11d00e09610263bdbd.pdf

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
I've only build-tested. I am not very familiar with this code, so I
kindly request the maintainers/reviewers to take a look and see if it
makes sense. From what I see, the ->list is always empty during
allocation. The spinlock allocation also seems unnecesary.


 fs/notify/fsnotify.c | 15 +++++++++++++--
 fs/notify/mark.c     |  2 --
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46f2255800091..55ed450da3295 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -385,6 +385,14 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 }
 EXPORT_SYMBOL_GPL(fsnotify);
 
+static void fsnotify_ctor(void *addr)
+{
+	struct fsnotify_mark_connector *conn = addr;
+
+	spin_lock_init(&conn->lock);
+	INIT_HLIST_HEAD(&conn->list);
+}
+
 static __init int fsnotify_init(void)
 {
 	int ret;
@@ -395,8 +403,11 @@ static __init int fsnotify_init(void)
 	if (ret)
 		panic("initializing fsnotify_mark_srcu");
 
-	fsnotify_mark_connector_cachep = KMEM_CACHE(fsnotify_mark_connector,
-						    SLAB_PANIC);
+	fsnotify_mark_connector_cachep =
+		kmem_cache_create("fsnotify_mark_connector",
+				  sizeof(struct fsnotify_mark_connector),
+				  __alignof__(struct fsnotify_mark_connector),
+				  SLAB_PANIC, fsnotify_ctor);
 
 	return 0;
 }
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 1d96216dffd19..d388e7f45e2ea 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -479,8 +479,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
 	if (!conn)
 		return -ENOMEM;
-	spin_lock_init(&conn->lock);
-	INIT_HLIST_HEAD(&conn->list);
 	conn->type = type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
-- 
2.26.1.301.g55bc3eb7cb9-goog
