Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0D3D671D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhGZSVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 14:21:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:55274 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232799AbhGZSUe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Y/DbUubFB7jqdWx1m9No/2F70Z4aAsJqjDWHRW9Ebg8=; b=DDjhoUsvboC2HFxAKC8
        3cmTNlEc9kXKbUGILhLybHNEaTqPXt/wphVg1ENIW87NzsTSKfme1I5perjZNgHRuFLfPG3MpxdT6
        0/33g69EP952EiKmN1O1Ou9Xdea/Nhe4rHbaCOR/VxPbDCMMVbmeSxG39o3BcO8lLjhyQWdmlzw=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m85qW-005JUu-TB; Mon, 26 Jul 2021 22:01:01 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v6 09/16] memcg: enable accounting for file lock caches
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
Message-ID: <22c439e5-d66c-97ad-1d04-f5579527b11a@virtuozzo.com>
Date:   Mon, 26 Jul 2021 22:01:00 +0300
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

