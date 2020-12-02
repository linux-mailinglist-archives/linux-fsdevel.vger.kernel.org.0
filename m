Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3713D2CC512
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgLBS23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgLBS23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:28:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A03C0617A7;
        Wed,  2 Dec 2020 10:27:49 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x4so1587783pln.8;
        Wed, 02 Dec 2020 10:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvp2Z7uKK5PPjiIE9UzxqFK/LcqQo3ZGRbQdLWMTrqs=;
        b=vQtKypllp/ZZ0qsyFl+L1bdVT8aToTf0+8odd+XSapcKWxc5LUWAr4l3jkmZ4vhQOW
         KN7rORAMQob3HKpAq9Bo/WslPYsUTtUae9QaKYOJffWRQqfbndIMK3TpSU35pwR5iTD4
         TsnDUEvpS8m5tQkWYi2rdtAsknL5ro5v4cAqgmX72mN/HT819mvMJnK8e0mh6JNV6Maj
         2NsjjVMtDssxfgCYKk3P2Eqp9uvihVqFSXIBowtndIoItqCBuTdOMlxlD1s57LlUvnCI
         qRKvscIQ16bRuTecy7wqTbfkB45/nvW14IB3Y5Iv2MzVJdc7BX/EYEctNRmDkqjzVpMx
         +8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvp2Z7uKK5PPjiIE9UzxqFK/LcqQo3ZGRbQdLWMTrqs=;
        b=YghJIf3mmjVUWMxHyOIAClbMA6j3kkdAqgXkoUCu+3smnke1hOutoYV/+Q7qVff70I
         hHyYqaBaW1O3ZBAYjdTAhacOYHNIaHp4pNblbRL4LWpD/UiZJeG74HIuueLOsDIDhk7W
         ezoVESVf3gkKY0YSmc+0voryzJL7kDfmqEZObzgupuV2FFuI8NC7o84c91CPBATp602K
         lc9JaHQy/qBVY/qbQHAr5fqMsdTd4Dmx3jmQpF+7HjevjC4BPCzUT3AdThRBWhAt4XFe
         Ht93ACP0ypMrbX3LMngfujxh/0XA2Q7nOj2+3O+RNVqnIVm6zSdYaO0WGO0h0mG+IwK6
         IkUg==
X-Gm-Message-State: AOAM5336W+4oXnzopxL/Pm+dZg1mJnmaMPDgjI0eHhHrLi2A+ZOLNUuz
        QFviuvc6AIsR44jMBWJsSXU=
X-Google-Smtp-Source: ABdhPJwbRBqa8Oz+BOZml8FzyUoa1O4bjuenGRS20w3xqULuzoR4981HLWGbv0U06BXH5Qa8LXKx0g==
X-Received: by 2002:a17:90a:19d5:: with SMTP id 21mr1047317pjj.187.1606933668614;
        Wed, 02 Dec 2020 10:27:48 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:47 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Wed,  2 Dec 2020 10:27:18 -0800
Message-Id: <20201202182725.265020-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
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
index 7d6186a07daf..457ce04eebf2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -533,7 +533,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	new_nr = atomic_long_add_return(next_deferred,
 					&shrinker->nr_deferred[nid]);
 
-	trace_mm_shrink_slab_end(shrinker, nid, freed, nr, new_nr, total_scan);
+	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
 }
 
-- 
2.26.2

