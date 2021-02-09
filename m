Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130A31558B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhBIR71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhBIRrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:47:47 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C3C061786;
        Tue,  9 Feb 2021 09:47:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 18so10224197pfz.3;
        Tue, 09 Feb 2021 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aag6FmxopGJJBcIK0DInGICi96zOp3/PA6Y0cDLmFTU=;
        b=dLY9oFzxKgCzVXOsBpGLct8FvBj5Y9PyAp5mpJbD4YGXcrynLeTNufVZKj3H+LOfto
         z1r7RqIfCfzzl6MqyuqdeQlmLJaLyMPqU4rtp7rtUSXeETOoLp/ty8292Gmth69PxCUy
         nxERgg9VrahdeOJdbD5dXXlfxkfdg6RGbvkmkpPmfED26//MvpWPhbuqSUsg8uIn7O0M
         bRT8S5xJNkI5lLx6ArZ0E+Cif/roOzZShm0WVMP3RfmjbfPdJgoTT8G8M9c5aAhrDIGY
         kVGh4LdR3b9ojq8HLKHXd2YlKfrZkVwXvi3lJcD1NZfbsyPChLkyRkcTdZaTViZzeBx9
         KZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aag6FmxopGJJBcIK0DInGICi96zOp3/PA6Y0cDLmFTU=;
        b=phmj0Hbke7OSXukjB8cHsTD6D0fi9TEMoPBMZ13TpDbXaEOF7YFIMWUK7+Rg4bfTfm
         mpJuE1pecC5/6q4fhXyMsptnpnYovmTNj4aA+K3f6vYcJs06kyuXgW2RWecLPJErvgIk
         7R/IEF9s6fhqXo5y5MjZgTz65i8Oo/FDosBqmHBaONk0PtoISOZbrCCPU5m2hCHKcFiP
         19hbZk1MOAEyJX1Vn/sTbPGh/EF+iLfpBe5hiFKqpv9yKyr4OGr3OX9H7ii2pbguSZOR
         JjsN7yFwNT4izb+lKag2R4h9RFMcGWAgR9jBBEOHSjKwk7G6yS+ky77HD3u/x5qZRYe0
         7vuQ==
X-Gm-Message-State: AOAM531i8FsK9b6505XCjCc3tltMWfTZX9qEP15vUCy+CT90qNSvK1Hw
        mJBQZPMA76LM8bbdu2lGbpg=
X-Google-Smtp-Source: ABdhPJwv6VYuTil89X6G9OgCmNWSOdJhaHkhGxouDpYGR9ltvOy9KIVDT3TN3w/r7cCiZDmCsTqUjA==
X-Received: by 2002:a63:1965:: with SMTP id 37mr23377015pgz.349.1612892824322;
        Tue, 09 Feb 2021 09:47:04 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:03 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 01/12] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Tue,  9 Feb 2021 09:46:35 -0800
Message-Id: <20210209174646.1310591-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
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
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
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

