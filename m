Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4006C337D3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhCKTJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhCKTJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB2C061574;
        Thu, 11 Mar 2021 11:09:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y13so212692pfr.0;
        Thu, 11 Mar 2021 11:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ad6rFdrjF9qkUCg0uueBGRPkzrqRpMOaGc3NS4qxCRQ=;
        b=vKEaDb0pRFGw1ac2fSVbByJ/bryyv9m8N66XhwfI1mxAIXCGvTtnVNSRknaDGOpu3r
         mF3ky3Se8SjadopZ5vbnZFBEAtxE+6nQMUWUQsIiqZYLtnIoCW76v532jRs1CJv6MJW0
         UXSaDvB/qYPV0hTsi4Ofsshg6au5Kmv82jo+dQ9t7h1iXScyhgymtcd1OkWkMN1oO7SX
         fzGehcR1dmA2UtgSb0aaSuzWHC9mBk6khdIF8MdEBsDZVrYgl43eE3Y1jm2kG4jfVMzH
         /1raUVFgjAKf1VVMxt/sL6d7NmzzBfCWRM/JIwTbu05KOem0EBBq+foWfz4PzbZ1OoV6
         z09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ad6rFdrjF9qkUCg0uueBGRPkzrqRpMOaGc3NS4qxCRQ=;
        b=SHWtG776AkCzUYl9xDmtVGGULwrJjua9p6ZAHee8lM7rjYsmBKKJeUpOPZl8Z3xjcp
         6Zy/03Idt98cDs5DzaRF0j4Ic8L5aN9sCv3BNaBd60x8EK74l9WvYwulWIm4adS2B+Pl
         r5aa/JRDWKR2ucT8orbZvQWqgk4iiRfMy+l2oinu3GeZsUUPZwM6YIsnWM6yQC1ZEK9j
         MBbkFh/jQ/CR8A48Al1xGPinYvjafqzl0Or6LqyKkgQa3JeDlCPWf6PxOu7R+CzKdIMe
         u3bOV16mw/SeyJFpCYIO4PbJODj1p+/IV1b1t+pIC9rdVUnsbZoZ5WgQz6L6kc8ruSsK
         vS7Q==
X-Gm-Message-State: AOAM530CM3CXLOLiBwv//Ogs64HZAZsTwnO/V3m3P0+vDYvCdu979YLA
        GKgEDK57AdzIx8Q2MYhgZLI=
X-Google-Smtp-Source: ABdhPJzkCuz0y/v1wgMPEFCdMw3j4bSNGMz2Ido7wOOTliNLwGqxRrstshQGOD0XEXWudM+Ej+Xhfg==
X-Received: by 2002:a63:d601:: with SMTP id q1mr8342915pgg.417.1615489741567;
        Thu, 11 Mar 2021 11:09:01 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:00 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 01/13] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Thu, 11 Mar 2021 11:08:33 -0800
Message-Id: <20210311190845.9708-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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
index 407051ebe869..bdc32c803c66 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -536,7 +536,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	else
 		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
 }
 
-- 
2.26.2

