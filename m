Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54892FACC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 10:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKMJUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 04:20:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37005 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMJUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:20:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id d5so1724515ljl.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oIUwVCoXTRy2Xzc2WTbShQwLgC231DhggYOStvhTE1g=;
        b=lSx2xskyZOQ4nh+qgQles1LugvACmjIDL4+NSPQoZ0lftWJM0Yz7BGSwn8J/e65eHj
         fNkcUkR4tIE3elCZ/uAQNqDd19xusilTspuDXzLr/uFrfkTD+EoNbwLyS/618zlav+Xi
         iRxLIGgp0zqdPG0k9Y4xmbnddDGRDNExZLiP1cTsNuGbR0uWoWaCCTUsK++TihJky9LA
         wZcBtOqotrhrj4DPLxCP5PCq1uCAvjdD9SEjZe1Du88F4WH1ZyY6x2Woi0fxeVZtfdkh
         dlb9Oaxx8wgfRDE6HWE7X3FQO0cH40SZ5W0ZB4BJPinujmePJtoVoKnRXASYIfQhqNIm
         maeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oIUwVCoXTRy2Xzc2WTbShQwLgC231DhggYOStvhTE1g=;
        b=mJrpO2+BZfJ+Z0VgZfnZ/HB9fEerK/fz1bEAT45YDbzPLFWdbw8Fo8qiWXJs4lkiyl
         FUGdccidrEJMKpBCtsaiLN7B+IdfCVhPRwz6jRDpqS+5dt/HMAyYMIDTjTGq4jz/bTIA
         gp6IdkdnsRQNG9L/exhAxDBdCb4ryzwt4c6RRsZysuWkVWAjjIH3aZDRb45erSbc/7Rq
         LIM6LVQjLkYuhUVT8dJCJA19XoJyb5QdlYv9zez2hDFR+NjKCgFPa02yfKqucrZIjdA1
         9iEvOgRL2I3Evhf5GplXpwaSpGwTEWNsgnKt34YslyyI425f//je0OeoAn4G6jsutlYr
         acAw==
X-Gm-Message-State: APjAAAXhCq2Fk5tbFq/1ZiVSNI4pa0rf9VilYeNBTo1nFq0CHv8rHvED
        +d1mmfFghH7+Blh+HFHN2gE3Bg==
X-Google-Smtp-Source: APXvYqwiY91CbJbr6hD5Oc184++qYLiuxmCMCk29oRW9+ONz55GoBRsdrtel1P2KeRp8x+CEsBTkBA==
X-Received: by 2002:a2e:9d8d:: with SMTP id c13mr1589644ljj.71.1573636838399;
        Wed, 13 Nov 2019 01:20:38 -0800 (PST)
Received: from [10.94.250.119] ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id 3sm683657lfq.55.2019.11.13.01.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 01:20:37 -0800 (PST)
Subject: Re: [PATCH RT 1/2 v2] dm-snapshot: fix crash with the realtime kernel
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <msnitzer@redhat.com>
Cc:     Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de
References: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <ab6fa08d-256a-1f8c-24dd-e5c23b3328bf@arrikto.com>
Date:   Wed, 13 Nov 2019 11:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/19 6:09 PM, Mikulas Patocka wrote:
> Snapshot doesn't work with realtime kernels since the commit f79ae415b64c.
> hlist_bl is implemented as a raw spinlock and the code takes two non-raw
> spinlocks while holding hlist_bl (non-raw spinlocks are blocking mutexes
> in the realtime kernel).
> 
> We can't change hlist_bl to use non-raw spinlocks, this triggers warnings 
> in dentry lookup code, because the dentry lookup code uses hlist_bl while 
> holding a seqlock.
> 
> This patch fixes the problem by using non-raw spinlock 
> exception_table_lock instead of the hlist_bl lock.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: f79ae415b64c ("dm snapshot: Make exception tables scalable")
> 

Reviewed-by: Nikos Tsironis <ntsironis@arrikto.com>

> ---
>  drivers/md/dm-snap.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> Index: linux-2.6/drivers/md/dm-snap.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-snap.c	2019-11-12 16:44:36.000000000 +0100
> +++ linux-2.6/drivers/md/dm-snap.c	2019-11-12 17:01:46.000000000 +0100
> @@ -141,6 +141,10 @@ struct dm_snapshot {
>  	 * for them to be committed.
>  	 */
>  	struct bio_list bios_queued_during_merge;
> +
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +	spinlock_t exception_table_lock;
> +#endif
>  };
>  
>  /*
> @@ -625,30 +629,46 @@ static uint32_t exception_hash(struct dm
>  
>  /* Lock to protect access to the completed and pending exception hash tables. */
>  struct dm_exception_table_lock {
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  	struct hlist_bl_head *complete_slot;
>  	struct hlist_bl_head *pending_slot;
> +#else
> +	spinlock_t *lock;
> +#endif
>  };
>  
>  static void dm_exception_table_lock_init(struct dm_snapshot *s, chunk_t chunk,
>  					 struct dm_exception_table_lock *lock)
>  {
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  	struct dm_exception_table *complete = &s->complete;
>  	struct dm_exception_table *pending = &s->pending;
>  
>  	lock->complete_slot = &complete->table[exception_hash(complete, chunk)];
>  	lock->pending_slot = &pending->table[exception_hash(pending, chunk)];
> +#else
> +	lock->lock = &s->exception_table_lock;
> +#endif
>  }
>  
>  static void dm_exception_table_lock(struct dm_exception_table_lock *lock)
>  {
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  	hlist_bl_lock(lock->complete_slot);
>  	hlist_bl_lock(lock->pending_slot);
> +#else
> +	spin_lock(lock->lock);
> +#endif
>  }
>  
>  static void dm_exception_table_unlock(struct dm_exception_table_lock *lock)
>  {
> +#ifndef CONFIG_PREEMPT_RT_BASE
>  	hlist_bl_unlock(lock->pending_slot);
>  	hlist_bl_unlock(lock->complete_slot);
> +#else
> +	spin_unlock(lock->lock);
> +#endif
>  }
>  
>  static int dm_exception_table_init(struct dm_exception_table *et,
> @@ -1318,6 +1338,9 @@ static int snapshot_ctr(struct dm_target
>  	s->first_merging_chunk = 0;
>  	s->num_merging_chunks = 0;
>  	bio_list_init(&s->bios_queued_during_merge);
> +#ifdef CONFIG_PREEMPT_RT_BASE
> +	spin_lock_init(&s->exception_table_lock);
> +#endif
>  
>  	/* Allocate hash table for COW data */
>  	if (init_hash_tables(s)) {
> 
