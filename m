Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C66430CCC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 21:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbhBBUH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 15:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237195AbhBBUGy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:06:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE32E64DDC;
        Tue,  2 Feb 2021 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612296373;
        bh=UUCbeiKruohgPLn70yuv5yyi43xYXqhUx5aEilibtwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mMPFuutry6yvrlRsX/cFk7nH6IhMcJEMn6CHKOk1bu/3K+vi8oRsOD2Un9VPFWZsO
         QqyfnUPoy0t+3JNCALRZJXK/mMzOJd5LtkWbN/RaA3xgbMgbxGkch1znJquQiCK9VK
         +YvgSnZtX8t9t9jG4aCkMCjWS/C0/OkE48M6pIak=
Date:   Tue, 2 Feb 2021 12:06:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: fs: Invalidate BH LRU during page migration
Message-Id: <20210202120612.2678f10bbc48734225c690bb@linux-foundation.org>
In-Reply-To: <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
References: <cover.1612248395.git.cgoldswo@codeaurora.org>
        <695193a165bf538f35de84334b4da2cc3544abe0.1612248395.git.cgoldswo@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  1 Feb 2021 22:55:47 -0800 Chris Goldsworthy <cgoldswo@codeaurora.org> wrote:

> Pages containing buffer_heads that are in the buffer_head LRU cache
> will be pinned and thus cannot be migrated.  Correspondingly,
> invalidate the BH LRU before a migration starts and stop any
> buffer_head from being cached in the LRU, until migration has
> finished.

It's 16 pages max, system-wide.  That isn't much.

Please include here a full description of why this is a problem and how
serious it is and of the user-visible impact.

> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1289,6 +1289,8 @@ static inline void check_irqs_on(void)
>  #endif
>  }
>  
> +bool bh_migration_done = true;
> +
>  /*
>   * Install a buffer_head into this cpu's LRU.  If not already in the LRU, it is
>   * inserted at the front, and the buffer_head at the back if any is evicted.
> @@ -1303,6 +1305,9 @@ static void bh_lru_install(struct buffer_head *bh)
>  	check_irqs_on();
>  	bh_lru_lock();
>  
> +	if (!bh_migration_done)
> +		goto out;
> +
>  	b = this_cpu_ptr(&bh_lrus);
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		swap(evictee, b->bhs[i]);

Seems a bit hacky, but I guess it'll work.

I expect the code won't compile with CONFIG_BLOCK=n &&
CONFIG_MIGRATION=y.  Due to bh_migration_done being unimplemented.

I suggest you add an interface function (buffer_block_lrus()?) and
arrange for an empty inlined stub version when CONFIG_BLOCK=n.

>
> ..
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -64,6 +64,19 @@
>   */
>  void migrate_prep(void)
>  {
> +	bh_migration_done = false;
> +
> +	/*
> +	 * This barrier ensures that callers of bh_lru_install() between
> +	 * the barrier and the call to invalidate_bh_lrus() read
> +	 *  bh_migration_done() as false.
> +	 */
> +	/*
> +	 * TODO: Remove me? lru_add_drain_all() already has an smp_mb(),
> +	 * but it would be good to ensure that the barrier isn't forgotten.
> +	 */
> +	smp_mb();

This stuff can be taken care of over in buffer_block_lrus() in
fs/buffer.c.

> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -36,6 +36,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/page_idle.h>
>  #include <linux/local_lock.h>
> +#include <linux/buffer_head.h>
>  
>  #include "internal.h"
>  
> @@ -759,6 +760,8 @@ void lru_add_drain_all(void)
>  	if (WARN_ON(!mm_percpu_wq))
>  		return;
>  
> +	invalidate_bh_lrus();
> +

Add a comment explaining why we're doing this?  Mention that bn_lru
buffers can pin pages, preventing migration.


