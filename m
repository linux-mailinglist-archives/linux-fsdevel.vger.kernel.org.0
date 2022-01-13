Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2748D905
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiAMNcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 08:32:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiAMNcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:32:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB499218E2;
        Thu, 13 Jan 2022 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642080735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coXO123D8kHY82TozlDE/TedXBQ//Bv+wiDunrMH7W4=;
        b=HUg0+y2hUGnKSUklhNidjyI6lMGamBNM1plssFsXXlpWH2yqTGhMQbBRPY/vcrL8HLqFUH
        SdWcJX8GmXcE5Ov8PubBS22RYXggtMlayqbHejR05ZgUIsrxJk2OjzT7idHLUWUyb7LQtk
        TjMzRy6Mog79uW/M/0PrNUBriluqLxI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62CAD1330C;
        Thu, 13 Jan 2022 13:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tguPF98p4GH2YAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 13 Jan 2022 13:32:15 +0000
Date:   Thu, 13 Jan 2022 14:32:14 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when
 needed
Message-ID: <20220113133213.GA28468@blackbody.suse.cz>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com>
 <20220106110051.GA470@blackbody.suse.cz>
 <CAMZfGtXZA+rLMUw5yLSW=eUncT0BjH++Dpi1EzKwXvV9zwqF1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXZA+rLMUw5yLSW=eUncT0BjH++Dpi1EzKwXvV9zwqF1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:22:36PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
>   root(-1) -> A(0) -> B(1) -> C(2)
> 
> CPU0:                                   CPU1:
> memcg_list_lru_alloc(C)
>                                         memcg_drain_all_list_lrus(C)
>                                         memcg_drain_all_list_lrus(B)
>                                         // Now C and B are offline. The
>                                         // kmemcg_id becomes the following if
>                                         // we do not the kmemcg_id of its
>                                         // descendants in
>                                         // memcg_drain_all_list_lrus().
>                                         //
>                                         // root(-1) -> A(0) -> B(0) -> C(1)
> 
>   for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
>       // allocate struct list_lru_per_memcg for memcg C
>       table[i].mlru = memcg_init_list_lru_one(gfp);
>   }
> 
>   spin_lock_irqsave(&lru->lock, flags);
>   while (i--) {
>       // here index = 1
>       int index = table[i].memcg->kmemcg_id;
> 
>       struct list_lru_per_memcg *mlru = table[i].mlru;
>       if (index < 0 || rcu_dereference_protected(mlrus->mlru[index], true))
>           kfree(mlru);
>       else
>           // mlrus->mlru[index] will be assigned a new value regardless
>           // memcg C is already offline.
>           rcu_assign_pointer(mlrus->mlru[index], mlru);
>   }
>   spin_unlock_irqrestore(&lru->lock, flags);
> 

> So changing ->kmemcg_id of all its descendants can prevent
> memcg_list_lru_alloc() from allocating list lrus for the offlined
> cgroup after memcg_list_lru_free() calling.

Thanks for the illustrative example. I can see how this can be a problem
in a general call of memcg_list_lru_alloc(C).

However, the code, as I understand it, resolves the memcg to which lru
allocation should be associated via get_mem_cgroup_from_objcg() and
memcg_reparent_list_lrus(C) comes after memcg_reparent_objcgs(C, B),
i.e. the allocation would target B (or even A if after
memcg_reparent_objcgs(B, A))?

It seems to me like "wasting" the existing objcg reparenting mechanism.
Or what do you think could be a problem relying on it?

Thanks,
Michal
