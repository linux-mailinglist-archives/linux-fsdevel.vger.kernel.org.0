Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86143667E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhDUJZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:25:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238103AbhDUJZO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:25:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97209ABC2;
        Wed, 21 Apr 2021 09:24:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6D29C1F2B69; Wed, 21 Apr 2021 11:24:40 +0200 (CEST)
Date:   Wed, 21 Apr 2021 11:24:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        jack@suse.cz, willy@infradead.org, virtio-fs@redhat.com,
        slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210421092440.GM8706@quack2.suse.cz>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419213636.1514816-2-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-04-21 17:36:34, Vivek Goyal wrote:
> Dan mentioned that he is not very fond of passing around a boolean true/false
> to specify if only next waiter should be woken up or all waiters should be
> woken up. He instead prefers that we introduce an enum and make it very
> explicity at the callsite itself. Easier to read code.
> 
> This patch should not introduce any change of behavior.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b3d27fdc6775..00978d0838b1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -144,6 +144,16 @@ struct wait_exceptional_entry_queue {
>  	struct exceptional_entry_key key;
>  };
>  
> +/**
> + * enum dax_entry_wake_mode: waitqueue wakeup toggle
> + * @WAKE_NEXT: entry was not mutated
> + * @WAKE_ALL: entry was invalidated, or resized

Let's document the constants in terms of what they do, not when they are
expected to be called. So something like:

@WAKE_NEXT: wake only the first waiter in the waitqueue
@WAKE_ALL: wake all waiters in the waitqueue

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> + */
> +enum dax_entry_wake_mode {
> +	WAKE_NEXT,
> +	WAKE_ALL,
> +};
> +
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>  		void *entry, struct exceptional_entry_key *key)
>  {
> @@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
>   * The important information it's conveying is whether the entry at
>   * this index used to be a PMD entry.
>   */
> -static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> +static void dax_wake_entry(struct xa_state *xas, void *entry,
> +			   enum dax_entry_wake_mode mode)
>  {
>  	struct exceptional_entry_key key;
>  	wait_queue_head_t *wq;
> @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
>  	 * must be in the waitqueue and the following check will see them.
>  	 */
>  	if (waitqueue_active(wq))
> -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
>  }
>  
>  /*
> @@ -268,7 +279,7 @@ static void put_unlocked_entry(struct xa_state *xas, void *entry)
>  {
>  	/* If we were the only waiter woken, wake the next one */
>  	if (entry && !dax_is_conflict(entry))
> -		dax_wake_entry(xas, entry, false);
> +		dax_wake_entry(xas, entry, WAKE_NEXT);
>  }
>  
>  /*
> @@ -286,7 +297,7 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
>  	old = xas_store(xas, entry);
>  	xas_unlock_irq(xas);
>  	BUG_ON(!dax_is_locked(old));
> -	dax_wake_entry(xas, entry, false);
> +	dax_wake_entry(xas, entry, WAKE_NEXT);
>  }
>  
>  /*
> @@ -524,7 +535,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
>  
>  		dax_disassociate_entry(entry, mapping, false);
>  		xas_store(xas, NULL);	/* undo the PMD join */
> -		dax_wake_entry(xas, entry, true);
> +		dax_wake_entry(xas, entry, WAKE_ALL);
>  		mapping->nrexceptional--;
>  		entry = NULL;
>  		xas_set(xas, index);
> @@ -937,7 +948,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>  	xas_lock_irq(xas);
>  	xas_store(xas, entry);
>  	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
> -	dax_wake_entry(xas, entry, false);
> +	dax_wake_entry(xas, entry, WAKE_NEXT);
>  
>  	trace_dax_writeback_one(mapping->host, index, count);
>  	return ret;
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
