Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC3A31D33F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBQAOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhBQAOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA2CC06174A;
        Tue, 16 Feb 2021 16:13:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e9so428155pjj.0;
        Tue, 16 Feb 2021 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDIXLxy24LDduOjAgxeksw9hKjupmB+52EkzQu0ub3U=;
        b=tftXLk6zX3Xb/cf8+6zK9ZM6tMvifXEmb/deF6t5Rus0pTCpIfksjhYqeeJ5a95yH4
         m+4rfrfqtzyTY+ma3SBO1W0w10WAh0xhmztzyrGuj81FocIeHOoPCWe1C/2E73IntBP3
         B8RaDuy91wqWcfILUAtMKgwI//V/lZGukHWyelk/KGOAOlpqyWRSFO9/49IWWJ8nr7W4
         lY1PmhOdYjBe/TsWuhs5utEtqdUa0/l/ZIbNUrXUn7Hu0FpUY3n1dR6O98ddRIW0Pb5W
         hHcKIkAJqPYiKFMK9GQ6CMqml5wfDLhfyWtKLavN9KNhuTQH51cUMKqDliHUIb6Wm5nG
         Ukew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDIXLxy24LDduOjAgxeksw9hKjupmB+52EkzQu0ub3U=;
        b=dE3HrphHl+/V+B8YGdGu1ORoXf8rKVMdRhYeHV2wrKLZ9SvwGtbtoHyRGRQRJuVdnk
         jBD/LCOKKp/K7vl43vNguljbhsdUrVXUrdpu2R1IuIet9KzSCytQe9rQBnHA7zAP8BNK
         Pz/gS0wgQ8AFjRfqAfNSwGLJsKjiG/vp1E3fUjj8ls/b9Cb368RlsdYL3jkiWkzvejfz
         +4G4xoIz1PMFelMTCKe9Vw1/Ojs3PEYBS9CZFLIJ6WR72/wB/D1dZCdN253bZno3+yGJ
         kS4pL4c86f2vAk28JLyYLyDYn65+N7rt5SAdhuMD+AuRLTVcVz49PGucN5youXg05Ewo
         Q9BA==
X-Gm-Message-State: AOAM531wXqTzY4YFpSYbXFC6t8GiUSx4yILPgRXTkUHYbsVczyIi1q6L
        5mHCSSeuOEkm9NQ548qYA3w=
X-Google-Smtp-Source: ABdhPJzwkFumlTnfhOiwYgAsXEbk8Y/K1i2XUu3wOErxAZ5+RVdNcGG132WhjXrBD4iR4KyPU84LLw==
X-Received: by 2002:a17:90b:4a0b:: with SMTP id kk11mr6563422pjb.95.1613520811146;
        Tue, 16 Feb 2021 16:13:31 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:30 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 01/13] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Tue, 16 Feb 2021 16:13:10 -0800
Message-Id: <20210217001322.2226796-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The tracepoint's nid should show what node the shrink happens on, the start tracepoint
uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
shrinker is not NUMA aware, so the tracing log may show the shrink happens on one
node but end up on the other node.  It seems confusing.  And the following patch
will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
the code.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
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

