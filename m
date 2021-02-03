Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25D030E0C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhBCRVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBCRVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:21:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CF0C061788;
        Wed,  3 Feb 2021 09:21:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lw17so3688749pjb.0;
        Wed, 03 Feb 2021 09:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8sqXu20RyBiU7ffjtxKZyn1hplKw3RF/btW7z5M9C0=;
        b=uiAqYe9zRIwao70xWEqsolcMy5qOp5XT1CkCzEkGSrfTkNeETfjPePiwhrqoiX/Hn2
         UOavcXyTgrdZfH48yY//YhXa5yEuXE7fd/4uUxVCzoNS0hSbSnum4Dc9CZYu2ujgEGWM
         xTqof9l1yC280ftthAa9tYTgOGkpQMYHbonO4fPIOIGQqzJ3mPgWlghGQTnP3SfVfDv1
         BXEz9UDM8syq0QsG5aDoiYTyq8fdeA0/N46yfQhGd2QfTnRYuXNLCSFsxJkjMFeXEiHg
         qkdln4MmVoJveVwH3Ah+EtrY6o7JQqjzSr7tM/mKUG+Y4WMFPUiXmFCJiiPXPmasVw3u
         oeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8sqXu20RyBiU7ffjtxKZyn1hplKw3RF/btW7z5M9C0=;
        b=WvUV+xYNuWrVYHU+ZNTvirwLjtCxgbG2Xn2f+hP5Td1BtzPZPjps9cr6C5Uv+HWpjI
         qt+1gOHqnIYkilOwpQ2kb6QIpLAhV2B/4rLYJQR+1O/GuE8y3nJYt16YcUSxijQDqo6z
         MxwckLg7kQIsyeX1QDdF7VJHNokVr9ZKg4K+0aAaJPuk6OIBoeGuvpp2d2ASKbVd/We8
         cSPkRDW0CepHcVvFpzNbYiTrNPK5ZNbPDDIDG70yU6K0k7LXcnKsszD0TclUvs4hdjqf
         0r2ylYd+UWMF4V4Uo9GtYjZdhzcdEKf+9ZcxUt4JitCcENwasw/8WaSBkq5LpvHQMb+M
         xq0A==
X-Gm-Message-State: AOAM533eKK3drZN2Bxf5hzH046GJewjkfbLahyw9LCTJYMaz4+6FOtby
        RISCY0nAEdN76TdeqniiAhU=
X-Google-Smtp-Source: ABdhPJzNg/Qk4hSC89YhvrVOZOzMTxGazWcO34MDK2tdtuW03bSsS4K8i6kUaDz/ixoBfWCHZvDIoA==
X-Received: by 2002:a17:902:ab83:b029:e1:6021:dd19 with SMTP id f3-20020a170902ab83b02900e16021dd19mr4092689plr.40.1612372860288;
        Wed, 03 Feb 2021 09:21:00 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:20:58 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 01/11] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Wed,  3 Feb 2021 09:20:32 -0800
Message-Id: <20210203172042.800474-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The tracepoint's nid should show what node the shrink happens on, the start tracepoint
uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
shrinker is not NUMA aware, so the traceing log may show the shrink happens on one
node but end up on the other node.  It seems confusing.  And the following patch
will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
the code.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b1b574ad199d..b512dd5e3a1c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -535,7 +535,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	else
 		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
 }
 
-- 
2.26.2

