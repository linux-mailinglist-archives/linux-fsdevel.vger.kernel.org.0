Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1162FF8A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbhAUXTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhAUXHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD673C061351;
        Thu, 21 Jan 2021 15:06:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s15so2151244plr.9;
        Thu, 21 Jan 2021 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYLQLgfEaFjCvTsN4FkoUtw26E88jjRQPD7HteqNuNs=;
        b=kARRAAcbOP7tKGGRgTCOE/cJLV13xKkJ0c1oFnpmAWeKv4vTgF50jpdPoiCWc7zED3
         zFxIGFutxuUjX9mt3NGojgqhHPOpHdHTl+8A5G/i2ZjzdWLjzkF2RXIlhXgxe0kPT0vm
         osAWYJr9Nwjk62Gb14cKOHUZ6fSXXOT6PcEEIVcPBMy5f3sLgzrb3stfaCJEoyY1fZEA
         b1uoBb3o806Y1lxQHNio/zJAR2s8Md+JmVE0GKhEcHYe4M3InL8xCJSkxSQwOx3slhq7
         tCITEPddUPDCwk5CsL7cpHXIJy7/avU4ue2hGXkL7+rr1m8DMPUC4o/ClZCmKyHfiw4W
         7DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYLQLgfEaFjCvTsN4FkoUtw26E88jjRQPD7HteqNuNs=;
        b=QOl1YoykmaWpzqgAVZm0qOSnT5ui2tquAWworswJ4bmoBXT7EhHJL9o8r41v5hx2z0
         0053BmC/+nL0WzffqprxDKwCTDgejII2Orf0XxZ3MuYj5ADsNcZxQYiC84663rgKmkK7
         hHhOO7AXQHO6NWZj9ls5/Wja+hKNpmpy7LaX4d2MTuAPX4oQFV7eayeeF7J8zGaBm9AF
         QesWNSBlI6Iw6qG1ZoFivuXyyA+9VzdnxwAkSBTq1jugxmPbWLtAMLbrkMgSE6fnk4+X
         VisGNPM3hFZZrGuvkQhjk1b22/eZGDu/BuJvsTskzkrt6iEB0yjhU9knlBsOaeaQkJdm
         lmcw==
X-Gm-Message-State: AOAM531j5gMlDjv0BQRCkTxRrvgJO0ZYS5WEzrTAqpoxw3bR/cIqBsnv
        JVzF333zYn2Q5TPJ0QHgT9I=
X-Google-Smtp-Source: ABdhPJyPQ/XS2KHGDobMo3FlC/5WrlmbHKGpggWZGVDAIeXc9VXIJvWPYdtc7vUBL0TqXt5+JT6KNg==
X-Received: by 2002:a17:902:d2ca:b029:de:7845:c0b2 with SMTP id n10-20020a170902d2cab02900de7845c0b2mr2000876plc.11.1611270398396;
        Thu, 21 Jan 2021 15:06:38 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:37 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 01/11] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Thu, 21 Jan 2021 15:06:11 -0800
Message-Id: <20210121230621.654304-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
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

