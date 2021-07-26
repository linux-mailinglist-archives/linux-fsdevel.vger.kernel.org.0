Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2A3D6719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhGZSUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 14:20:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:55296 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233301AbhGZSUk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=qAU9YX3Sw8E0MYtMB0gH0qiMpEWaFW5TOOeksZRhni0=; b=r5qH6m8kGUh6RfQ+6la
        UTgd0UadlgPXJzwQqPDr1QoRIwlu/s/2DKo1Bg10G/B6EApYn4XvO7tqB4ueAO7tuDboDHtVRuJZF
        b5vvy24kJ5ssEPgC1/8jYSQoi3qJcd2eN29cvalzkqUhVwT8vxYHuk/LRkSXFP7wVQ9O/ZuUA9E=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m85qd-005JVL-Ex; Mon, 26 Jul 2021 22:01:07 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v6 10/16] memcg: enable accounting for fasync_cache
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9bf9d9bd-03b1-2adb-17b4-5d59a86a9394@virtuozzo.com>
 <cover.1627321321.git.vvs@virtuozzo.com>
Message-ID: <40992e25-2499-1c95-be20-7ba2c8ffd90a@virtuozzo.com>
Date:   Mon, 26 Jul 2021 22:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627321321.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fasync_struct is used by almost all character device drivers to set up
the fasync queue, and for regular files by the file lease code.
This structure is quite small but long-living and it can be assigned
for any open file.

It makes sense to account for its allocations to restrict the host's
memory consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fcntl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index dfc72f1..7941559 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1049,7 +1049,8 @@ static int __init fcntl_init(void)
 			__FMODE_EXEC | __FMODE_NONOTIFY));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
-		sizeof(struct fasync_struct), 0, SLAB_PANIC, NULL);
+					 sizeof(struct fasync_struct), 0,
+					 SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	return 0;
 }
 
-- 
1.8.3.1

