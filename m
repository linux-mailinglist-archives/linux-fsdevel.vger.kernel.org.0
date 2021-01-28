Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4871307A8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhA1QT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 11:19:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:50626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhA1QTx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:19:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 317F2AD24;
        Thu, 28 Jan 2021 16:19:09 +0000 (UTC)
Subject: Re: [v5 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127233345.339910-1-shy828301@gmail.com>
 <20210127233345.339910-4-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <73c724ba-a1ef-a862-4c31-153d92826f8d@suse.cz>
Date:   Thu, 28 Jan 2021 17:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127233345.339910-4-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/21 12:33 AM, Yang Shi wrote:
> Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
> exclusively, the read side can be protected by holding read lock, so it sounds
> superfluous to have a dedicated mutex.
> 
> Kirill Tkhai suggested use write lock since:
> 
>   * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
>   * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
>     in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
>     is not actually protected.
>   * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
>     alloc_shrinker_info()->free_shrinker_info() may free memory right after
>     shrink_slab_memcg() dereferenced it. You may say
>     shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
>     but this is not the thing we want to remember in the future, since this
>     spreads modularity.
> 
> And a test with heavy paging workload didn't show write lock makes things worse.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
