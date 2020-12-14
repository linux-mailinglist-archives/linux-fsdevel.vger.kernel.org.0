Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041DC2DA381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502207AbgLNWi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441091AbgLNWiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:38:23 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7833C061793;
        Mon, 14 Dec 2020 14:37:42 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v1so7254570pjr.2;
        Mon, 14 Dec 2020 14:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JK0RA9az0H36swxW1b9xoMtxd77STDT0bYjsifkqcRo=;
        b=F/5xiYvM5I0EZ1qGc6HKxC5DbVx8mFwcf3JfwHFHN3kcB1Qk1grQjgn8+kQBdPQSM1
         alxCOT2x5/FoazJu6JQkdG4GitO3MZsQEYSYtsjaQ1/F2TyZ2E92jXroDuFdytjhvKmO
         dUMJHFDGxiZ2cM0lQ8CMcNHXBU+sBDQMm1b8ZrivVoAmViSUsIHutgMvOtj9kgkl7msA
         r6T7n+glgZi4S5CqtQQj/F+wqQ5y/4lc6pyB3xHEAzlcLA6PXgtMgM8YYxEhmnF6oWq1
         NSaUa2RVk8XMOmsEyNxFja/5Ndj8gKg6XpSZHHj7mV5zYjfZg4HN/c8FLUq3S1DFx9Fl
         I8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JK0RA9az0H36swxW1b9xoMtxd77STDT0bYjsifkqcRo=;
        b=CPhq/pbxDSREFJw6hIZ81c0LSZliDYEvECvjfuy7WyLgCLr30yNMTFjRXxHrnQ2h0U
         IwQ8qwgyYQWl1ZGk4XWtMncRiKd5MKGUgE+VL0ud1jMxzeh3C2uZOnKLXvQl7Z7cosEb
         qHzOoLEPd7/ydJCBW5FbYkxrJ1vho/sQr+Y89Hp+AHp5i74pDhljbAGVVNX6tU9b1X9H
         PS1ExzKGPOaSC4vMsCcR8Y20nW9x8cD8eox84JJXMGVDn5uMRCgQ7D+YwAO0MpMODQp8
         mj2JPALPqIZWKfJaxaPgfkg8i8KtoEL8bHAhQgcepWyNA0pS57yjUKxlFZ1PWEGbhZiR
         hdMw==
X-Gm-Message-State: AOAM530mwtIOoZBM068cX9OL3nzRbFXlYj5zG16wvwdlhccQ89Ql6Eqe
        xocKR1f+xWSn8/YgjR4ZgTl1ehPZUpWXDg==
X-Google-Smtp-Source: ABdhPJyD+/0faNVKRhmAJZsCjeKks1k242JFR+RcoNYxKcHgo8xWCG5eLgy8LarRv/qmPAu9krxmMw==
X-Received: by 2002:a17:90a:5581:: with SMTP id c1mr6843745pji.86.1607985462413;
        Mon, 14 Dec 2020 14:37:42 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:41 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/9] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Mon, 14 Dec 2020 14:37:14 -0800
Message-Id: <20201214223722.232537-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
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
index 7b4e31eac2cf..48c06c48b97e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -537,7 +537,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	else
 		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
 }
 
-- 
2.26.2

