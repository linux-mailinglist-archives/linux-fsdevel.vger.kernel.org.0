Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454AF31D347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhBQAOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhBQAOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4C7C061788;
        Tue, 16 Feb 2021 16:13:40 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fa16so362376pjb.1;
        Tue, 16 Feb 2021 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVcqSZcHu5IZi/C+WStQFCtrAWEjFBSbWmkdZnY1Mak=;
        b=jHIijN1unicXjyzPENrx3Ud1wLIwQPgTtH6laop63DTNjZ0dgJ28S5yZfj0x+h8cCM
         r+07GDQ1I7eTsdhnJD0/xw5YuUfEb+SeZwEWsp9ZGiiaw4COS45rwbqZ/HtjfNr+W928
         Y4KHY3P2DsDcBRmJBwxHe2Bw3O5LHH2irQgkGVY/bKHwleetw3Sod4IYA9hDHuxWEgJv
         d4HSCLHb7GmM2kZ0BhoxN/ffzrrYxfiMY3aw5rD7qhY1+DjsY8sAyi36yBZn4xegKrRK
         ZcHtI8Y7vZb7jFeUBxeghGXHHL2Q88NiP5CHahtEtnzPPTnuGIvkEBT7aAA0jRDRjH4W
         +ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVcqSZcHu5IZi/C+WStQFCtrAWEjFBSbWmkdZnY1Mak=;
        b=Vr8mLGuyQ+rYzhrIco1Y1OeGl31IPLSVGKmoAZkkmZzqWUWIaMka8o3aL/1OhimJOK
         I72xCQcjKWwweaSsHXZ0LaYRomeu/idv1BTioO4fNFtumQRx4rREasnAlieg8/0XvOdM
         URZ5I48l49WnJSxyU+Fs7hW8h5iHOXJqn/1lXl7U6t9FsKOJdvY14dcRSijnyp2l07MQ
         1Dg3mjxCTbhsqvr4nzrLRaaC0BDajUzbuwWEHjymmGvRgwH1hTn3W1dIkJhEDYvCTM4Y
         pSBxFjB2LixjpIng3NQ0h7yj2EKrdQGfI8A1SpuogK8kSKvhhczhCX5V1p+EQGHB5Fbz
         zkRg==
X-Gm-Message-State: AOAM533Bkc5Px1MSqFm8QdR3DTX3pO5D36v485XT2fZ0h2T8UwrSv1Ec
        0WqjeXJ4VHoS5O4luuyA+xat0OemuWEj+g==
X-Google-Smtp-Source: ABdhPJwLfmniYH7zm8PmbGDXGY5EKEOj2yTUgjfmbch/RcW4W/iuVWi4pfuPHYaFIhnOSnFSKjOCkg==
X-Received: by 2002:a17:902:20e:b029:e1:916c:a4d6 with SMTP id 14-20020a170902020eb02900e1916ca4d6mr18104plc.57.1613520819500;
        Tue, 16 Feb 2021 16:13:39 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:38 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
Date:   Tue, 16 Feb 2021 16:13:14 -0800
Message-Id: <20210217001322.2226796-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
We don't have to define a dedicated callback for call_rcu() anymore.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e753c2516fa..c2a309acd86b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
 	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
 }
 
-static void free_shrinker_map_rcu(struct rcu_head *head)
-{
-	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
-}
-
 static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 				   int size, int old_size)
 {
@@ -219,7 +214,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset((void *)new->map + old_size, 0, size - old_size);
 
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
-		call_rcu(&old->rcu, free_shrinker_map_rcu);
+		kvfree_rcu(old);
 	}
 
 	return 0;
-- 
2.26.2

