Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FF52EBC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAFKQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 05:16:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:55872 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbhAFKQu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:16:50 -0500
Received: from [192.168.15.143]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kx5qI-00Fcnd-ME; Wed, 06 Jan 2021 13:15:02 +0300
Subject: Re: [v3 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105225817.1036378-1-shy828301@gmail.com>
 <20210105225817.1036378-5-shy828301@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <955422c5-0703-e9fb-f309-6ed6b5fc0e0a@virtuozzo.com>
Date:   Wed, 6 Jan 2021 13:15:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105225817.1036378-5-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.01.2021 01:58, Yang Shi wrote:
> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> bit map.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ddb9f972f856..8da765a85569 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
>  #ifdef CONFIG_MEMCG
> -
> -static int memcg_shrinker_map_size;
> +static int shrinker_nr_max;
>  
>  static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
>  {
> @@ -248,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  		return 0;
>  
>  	down_read(&shrinker_rwsem);
> -	size = memcg_shrinker_map_size;
> +	size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
>  	for_each_node(nid) {
>  		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
>  		if (!map) {
> @@ -269,7 +268,7 @@ static int memcg_expand_shrinker_maps(int new_id)
>  	struct mem_cgroup *memcg;
>  
>  	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> -	old_size = memcg_shrinker_map_size;
> +	old_size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
>  	if (size <= old_size)
>  		return 0;

These bunch of DIV_ROUND_UP() looks too complex. Since now all the shrinker maps allocation
logic in the only file, can't we simplify this to look better? I mean something like below
to merge in your patch:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b951c289ef3a..27b6371a1656 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -247,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_read(&shrinker_rwsem);
-	size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
+	size = shrinker_nr_max / BITS_PER_BYTE;
 	for_each_node(nid) {
 		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
 		if (!map) {
@@ -264,13 +264,11 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 
 static int memcg_expand_shrinker_maps(int new_id)
 {
-	int size, old_size, ret = 0;
+	int size, old_size, new_nr_max, ret = 0;
 	struct mem_cgroup *memcg;
 
 	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
-	if (size <= old_size)
-		return 0;
+	new_nr_max = size * BITS_PER_BYTE;
 
 	if (!root_mem_cgroup)
 		goto out;
@@ -287,6 +285,9 @@ static int memcg_expand_shrinker_maps(int new_id)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 out:
+	if (ret == 0)
+		shrinker_nr_max = new_nr_max;
+
 	return ret;
 }
 
@@ -334,8 +335,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 			idr_remove(&shrinker_idr, id);
 			goto unlock;
 		}
-
-		shrinker_nr_max = id + 1;
 	}
 	shrinker->id = id;
 	ret = 0;
