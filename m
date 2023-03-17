Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569646BE888
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCQLtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCQLtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EED4EED;
        Fri, 17 Mar 2023 04:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7656B82560;
        Fri, 17 Mar 2023 11:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7B9C433D2;
        Fri, 17 Mar 2023 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679053736;
        bh=Ep7xq0TiU+qHaUMEFrkyCD2+t3tCkcfkRWs301HgOUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9saBPfdCtC+vAwmfznGdZB2UTqdSQzF263AJzR5mcpKX2ygzQA9bJ0Od2Q9KrrFG
         0vWoPa2+wsEwNvcGMSYYOmV4zKj0uapfmT7udrufWWgmjAH1SgneGQuO3s+yzqqeCb
         7HWVNseINxfc9xAm/DlR+pa3mSuP6DU6rDdOgkwf2rhNiM5AwL24XItAK5yhBdIWX1
         lD3q/+yLOxnjrUatpIrRYGMTlVvujX34ejxxo6K/lOf/wpCQVnf5s03xfC8DfCBGJl
         cFaZnZ5zillNOYl9Vau9q17yVFSvIzhG/r50v/UJbAsA4R7OqQpKtmhi0pLVq+RwtC
         6Itb2xlX4MURg==
Date:   Fri, 17 Mar 2023 13:48:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 6/6] mm/slab: document kfree() as allowed for
 kmem_cache_alloc() objects
Message-ID: <ZBRTln2uTN1vj4i9@kernel.org>
References: <20230317104307.29328-1-vbabka@suse.cz>
 <20230317104307.29328-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317104307.29328-7-vbabka@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:43:07AM +0100, Vlastimil Babka wrote:
> This will make it easier to free objects in situations when they can
> come from either kmalloc() or kmem_cache_alloc(), and also allow
> kfree_rcu() for freeing objects from kmem_cache_alloc().
> 
> For the SLAB and SLUB allocators this was always possible so with SLOB
> gone, we can document it as supported.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  Documentation/core-api/memory-allocation.rst | 17 +++++++++++++----
>  include/linux/rcupdate.h                     |  6 ++++--
>  mm/slab_common.c                             |  5 +----
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index 5954ddf6ee13..1c58d883b273 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -170,7 +170,16 @@ should be used if a part of the cache might be copied to the userspace.
>  After the cache is created kmem_cache_alloc() and its convenience
>  wrappers can allocate memory from that cache.
>  
> -When the allocated memory is no longer needed it must be freed. You can
> -use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
> -`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
> -don't forget to destroy the cache with kmem_cache_destroy().
> +When the allocated memory is no longer needed it must be freed.
> +
> +Objects allocated by `kmalloc` can be freed by `kfree` or `kvfree`. Objects
> +allocated by `kmem_cache_alloc` can be freed with `kmem_cache_free`, `kfree`
> +or `kvfree`, where the latter two might be more convenient thanks to not
> +needing the kmem_cache pointer.
> +
> +The same rules apply to _bulk and _rcu flavors of freeing functions.
> +
> +Memory allocated by `vmalloc` can be freed with `vfree` or `kvfree`.
> +Memory allocated by `kvmalloc` can be freed with `kvfree`.
> +Caches created by `kmem_cache_create` should be freed with
> +`kmem_cache_destroy` only after freeing all the allocated objects first.
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 094321c17e48..dcd2cf1e8326 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -976,8 +976,10 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * either fall back to use of call_rcu() or rearrange the structure to
>   * position the rcu_head structure into the first 4096 bytes.
>   *
> - * Note that the allowable offset might decrease in the future, for example,
> - * to allow something like kmem_cache_free_rcu().
> + * The object to be freed can be allocated either by kmalloc() or
> + * kmem_cache_alloc().
> + *
> + * Note that the allowable offset might decrease in the future.
>   *
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1522693295f5..607249785c07 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -989,12 +989,9 @@ EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  
>  /**
>   * kfree - free previously allocated memory
> - * @object: pointer returned by kmalloc.
> + * @object: pointer returned by kmalloc() or kmem_cache_alloc()
>   *
>   * If @object is NULL, no operation is performed.
> - *
> - * Don't free memory not originally allocated by kmalloc()
> - * or you will run into trouble.
>   */
>  void kfree(const void *object)
>  {
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
