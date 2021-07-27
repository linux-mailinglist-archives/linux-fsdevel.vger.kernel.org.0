Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C43D6E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhG0FeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 01:34:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:40170 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235344AbhG0FeD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Y/DbUubFB7jqdWx1m9No/2F70Z4aAsJqjDWHRW9Ebg8=; b=optXdE7qIqVAXpG76g/
        gmYV+XsYEHwpqApGYObnoupiW4dp+sZKgWlUi2j85RCoYVQB0GNsmIJKWggwmL+Z8WKJ0SWTuwsxB
        wPE7s0m1Dl70eqIOKgdNcdqJsbaC8XHuPQpj75t87i/5s8iyUqY4jUFrk4alcdPTM85uYQ7cvRw=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8FiY-005LWu-3o; Tue, 27 Jul 2021 08:33:26 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v7 03/10] memcg: enable accounting for file lock caches
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
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
Message-ID: <b009f4c7-f0ab-c0ec-8e83-918f47d677da@virtuozzo.com>
Date:   Tue, 27 Jul 2021 08:33:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627362057.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User can create file locks for each open file and force kernel
to allocate small but long-living objects per each open file.

It makes sense to account for these objects to limit the host's memory
consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/locks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 74b2a1d..1bc7ede 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -3056,10 +3056,12 @@ static int __init filelock_init(void)
 	int i;
 
 	flctx_cache = kmem_cache_create("file_lock_ctx",
-			sizeof(struct file_lock_context), 0, SLAB_PANIC, NULL);
+			sizeof(struct file_lock_context), 0,
+			SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	filelock_cache = kmem_cache_create("file_lock_cache",
-			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
+			sizeof(struct file_lock), 0,
+			SLAB_PANIC | SLAB_ACCOUNT, NULL);
 
 	for_each_possible_cpu(i) {
 		struct file_lock_list_struct *fll = per_cpu_ptr(&file_lock_list, i);
-- 
1.8.3.1

