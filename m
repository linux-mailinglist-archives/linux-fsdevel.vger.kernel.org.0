Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DC79BE44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjIKUyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbjIKOvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:51:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99139118;
        Mon, 11 Sep 2023 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BYTvO99Kil1KW06kfnqUMbbJxU5pUNAb2i452Crbhic=; b=QkWEKD7SJOHvVds23lvHCq0Nxu
        qH7U28dwtKWFvjImk+g24I922J07YviQZvixY6As7trTkypaZCrcONMA8FRO3InNGUkmVMpQMW3f1
        tmSICfYb7rDIQvil6C+hQT2YS4cUjmeH5p2mIjN4uORr8g9NBcXRX+Wongzzdicdw+jRMdxFn8bW5
        QoShQ2gd4ntBzqfZITbcSaI+0gTAlVUyMs4dBAUNgamtcYhAuLhBAs+m1uO1H4F3JDnREjQl7b4vM
        j+WxKLJKDtuZr5V2Amtnb10JZ4HgZyR+Ad4opZl9yya1MgqeqDGJ8sn3+K2kZqbVYssJPk9RdKQKS
        APv6FQcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfiG6-001VxM-HT; Mon, 11 Sep 2023 14:51:26 +0000
Date:   Mon, 11 Sep 2023 15:51:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] xarray: Document necessary flag in alloc-functions
Message-ID: <ZP8pbgeBQMKyLjcI@casper.infradead.org>
References: <20230911144837.13540-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911144837.13540-1-pstanner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:48:37PM +0200, Philipp Stanner wrote:
> Calling functions that wrap __xa_alloc() or __xa_alloc_cyclic() without
> the xarray previously having been initialized with the flag
> XA_FLAGS_ALLOC being set in xa_init_flags() results in undefined
> behavior.
> 
> Document the necessity of setting this flag in all docstrings of
> functions that wrap said two functions.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> I used the time available until we can get this merged to create a
> version-3, improving a few things.

Umm, too late, v2 went upstream last week during the merge window.

Do you still want to change the wording?

> Changes since v2:
> - Phrase the comment differently: say "requires [...] an xarray [...]"
>   instead of "must be operated on".
> - Improve the commit message and use the canonical format: a) describe
>   the problem, b) name the solution in imperative form.
> 
> Regards,
> P.
> ---
>  include/linux/xarray.h | 18 ++++++++++++++++++
>  lib/xarray.c           |  6 ++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 741703b45f61..746a17b64aa6 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -856,6 +856,9 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
>   * stores the index into the @id pointer, then stores the entry at
>   * that index.  A concurrent lookup will not see an uninitialised @id.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Any context.  Takes and releases the xa_lock.  May sleep if
>   * the @gfp flags permit.
>   * Return: 0 on success, -ENOMEM if memory could not be allocated or
> @@ -886,6 +889,9 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
>   * stores the index into the @id pointer, then stores the entry at
>   * that index.  A concurrent lookup will not see an uninitialised @id.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Any context.  Takes and releases the xa_lock while
>   * disabling softirqs.  May sleep if the @gfp flags permit.
>   * Return: 0 on success, -ENOMEM if memory could not be allocated or
> @@ -916,6 +922,9 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
>   * stores the index into the @id pointer, then stores the entry at
>   * that index.  A concurrent lookup will not see an uninitialised @id.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Process context.  Takes and releases the xa_lock while
>   * disabling interrupts.  May sleep if the @gfp flags permit.
>   * Return: 0 on success, -ENOMEM if memory could not be allocated or
> @@ -949,6 +958,9 @@ static inline int __must_check xa_alloc_irq(struct xarray *xa, u32 *id,
>   * The search for an empty entry will start at @next and will wrap
>   * around if necessary.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Any context.  Takes and releases the xa_lock.  May sleep if
>   * the @gfp flags permit.
>   * Return: 0 if the allocation succeeded without wrapping.  1 if the
> @@ -983,6 +995,9 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
>   * The search for an empty entry will start at @next and will wrap
>   * around if necessary.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Any context.  Takes and releases the xa_lock while
>   * disabling softirqs.  May sleep if the @gfp flags permit.
>   * Return: 0 if the allocation succeeded without wrapping.  1 if the
> @@ -1017,6 +1032,9 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
>   * The search for an empty entry will start at @next and will wrap
>   * around if necessary.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Process context.  Takes and releases the xa_lock while
>   * disabling interrupts.  May sleep if the @gfp flags permit.
>   * Return: 0 if the allocation succeeded without wrapping.  1 if the
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 2071a3718f4e..2b07c332d26b 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
>   * stores the index into the @id pointer, then stores the entry at
>   * that index.  A concurrent lookup will not see an uninitialised @id.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Any context.  Expects xa_lock to be held on entry.  May
>   * release and reacquire xa_lock if @gfp flags permit.
>   * Return: 0 on success, -ENOMEM if memory could not be allocated or
> @@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
>   * The search for an empty entry will start at @next and will wrap
>   * around if necessary.
>   *
> + * Requires the xarray to be initialized with flag XA_FLAGS_ALLOC set
> + * in xa_init_flags().
> + *
>   * Context: Any context.  Expects xa_lock to be held on entry.  May
>   * release and reacquire xa_lock if @gfp flags permit.
>   * Return: 0 if the allocation succeeded without wrapping.  1 if the
> -- 
> 2.41.0
> 
