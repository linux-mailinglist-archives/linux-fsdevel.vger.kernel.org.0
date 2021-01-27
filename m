Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EACF306802
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhA0XfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhA0Xee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:34:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00719C0613D6;
        Wed, 27 Jan 2021 15:33:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so2468976pfg.11;
        Wed, 27 Jan 2021 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYLQLgfEaFjCvTsN4FkoUtw26E88jjRQPD7HteqNuNs=;
        b=fVhQu50/1FFP1iQUMRi/V3eB1Md5hlpC59mDgdwc9B945ZzyL9Z4ZZZkf2RbkBzriH
         1mLmt6p+kp5wXoHXyAlA4agAYM2SuSZkBu0q6LOtkmwh/GEKP7+r1l+E3TFwvSjtfLQf
         MyUSx9MdvFruk85ZiEFPx9QlW2ZPAsN9sl1N4NZjFsn+hiwQtXEN6Jp5v9knQHzuYuwA
         GiJ3hpyCPKIDmCyyBsVdx6PgCFwFUiViqmBlKNCQ9ManwCS3v9/43PpzNEebADTHta67
         xdsDyPHcryNmlwXrYLQF73QMBh2X5umHlGhDE4Qg9mlH6tNnfi4oVK7eoWSm+Y5jWX1G
         VN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYLQLgfEaFjCvTsN4FkoUtw26E88jjRQPD7HteqNuNs=;
        b=o4Jwd+YlA23obiYxjGxX9Tb5OR5j1+UgkoPTfepdUrHZFSANmhV3pqjRR2aVOpbAor
         24VuqdwU6IXCcByqm1wMJJtab+mC9KDH6V+CF4zzKrfYLw5U87Ek4OFNei4cpVSKrqf5
         ZiocobCcn2YInnBNQu0uZBRuL95zfDXF4f6+jeyxHWUmm0llv/CEXGibBXj8liugHxRa
         ezv3yOpjY9ytp1JMOrpVTu9tqT4voYXxk1g+VYCFdoxKcmpx7C89Gn/02wTpRycGG6gN
         YRWif8HJiJW0Q8/doYqaVmhAleHy/3Wwo4+zSkIyJ6mf/1eOhSzxSbus8dGK+0jC1Z4B
         aDHA==
X-Gm-Message-State: AOAM532Zpx6AvwbS76Pb+xA998nkA7e/dltaRvW5EvkZ4m3BtMZDwQiv
        CLnhQJ07Tn/wuWyzNqxpk1ImMJs4U4ZY3w==
X-Google-Smtp-Source: ABdhPJz5IsrFDmE2tZbDrvhPA00PE+Jp+IUlNVHV9LIeCdCOqtE8kXCvzP0WOvGajeFJqqCnB7g3cw==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr13701298pgm.135.1611790433585;
        Wed, 27 Jan 2021 15:33:53 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:33:52 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 01/11] mm: vmscan: use nid from shrink_control for tracepoint
Date:   Wed, 27 Jan 2021 15:33:35 -0800
Message-Id: <20210127233345.339910-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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

