Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB82EB599
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbhAEW71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 17:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbhAEW70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:59:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68091C061796;
        Tue,  5 Jan 2021 14:58:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b5so571077pjl.0;
        Tue, 05 Jan 2021 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mj1bmEJCVqZDq37aTsMsDn48932Q6fF96CwsNmqPO6Y=;
        b=l6guGeiSaE0IEqfjMtbVN8hAc5PaSHcmwc2Y6oOyoPTiVmnmk9Wx6MU+/PVi/no+ZU
         +apFzZVxFT610tTpUoGUX5vgHyQl3fREP+WpyNVSMyACT9L+ZVHYHj+CLnqppGGTpYR4
         2wP8iUH0o6tL+ZEDMbLzPQZ5+Kpwd/i91VANPhLDiFfJ06vHmA0IX4GCc8sBFZvapm4L
         fhf49mYPMhO+MWVmOkOxbB8+qDAAtFvZwTDZkZMMGlGB6l+GyFlkGbUfPdpAxZ+ykl3i
         RAwSsDwleMbC+c2ggvzF0c15zYCuLcfCxuUyci/TunRZerjCYvx1QMtuliHKucC4CLUO
         ioGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mj1bmEJCVqZDq37aTsMsDn48932Q6fF96CwsNmqPO6Y=;
        b=NRFqA23HJOqSdVPiEmnMFcScaiBd4KSiplcAE9bWRNp1mt7nHlRCtG5RpXZWcTlxVn
         0WRAZ7nx3P5gnmxW278IgaRZ2P/73k/UWvvRUP5xM29nsOZ4EZvtykkkTag5jqKQpuli
         cyUsFLoOcFw/pkFsRqChjgYsYy5PpO5xbKDHfWeq+6fbc6aLv6TWNBl1Ow/VjcitTgC5
         k3YDjKQfrahi3qCV8tVWD1WBkbi+WUni356EnOZQIakpGUJnW80DhHinRltZ4+CQItSL
         AnaULbVFekZVokoTFsr/1cvK0JCdy4HFHjifRDQ9bDeezCCGZIVUgnvdeFYr53ayAT9d
         1roA==
X-Gm-Message-State: AOAM531WfNN+bJ5XEon/fpkn8YD1ahuLGPYWB8YolHx6rRqvcRvb2D+X
        W1ojImUxqqjwNXUeI6StMbM=
X-Google-Smtp-Source: ABdhPJx3sjraPJbb4sb5z508wNnRUCdbSzdgaBWAdmfFb6aWqcHCf9wNz7r8PfSC5ak1vdWUIP+JhQ==
X-Received: by 2002:a17:902:bcc6:b029:db:e257:9050 with SMTP id o6-20020a170902bcc6b02900dbe2579050mr1692327pls.22.1609887526027;
        Tue, 05 Jan 2021 14:58:46 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:58:45 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 01/11] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Tue,  5 Jan 2021 14:58:07 -0800
Message-Id: <20210105225817.1036378-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
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
index 257cba79a96d..cb24ef952efc 100644
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

