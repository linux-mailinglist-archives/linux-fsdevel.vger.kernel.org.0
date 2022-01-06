Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD6948635B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 12:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbiAFLA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 06:00:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51152 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiAFLAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:00:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F04321106;
        Thu,  6 Jan 2022 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641466853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEvBu7dHeD6Gxq79SWvMNCBIMerIX/L+M1nvgZS7GIA=;
        b=c9tjKvCDKtEOwp/kJiBfMqCa2Hx8pjG8zls8M2T3zZUkvtbMScBxARnqXHD8qHriSx68g6
        Fzb9hhw1w49D5ywmlk5xCq7JwW/Hi54rHTHaoCaBtESyOKlx6dj/yhu++1VWpbefA8QVzz
        2z+FuFvRmU7Jv+/GSo8XqEphvhVWcng=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B46BA13C3E;
        Thu,  6 Jan 2022 11:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cdVkK+TL1mHWEAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 06 Jan 2022 11:00:52 +0000
Date:   Thu, 6 Jan 2022 12:00:51 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when
 needed
Message-ID: <20220106110051.GA470@blackbody.suse.cz>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-11-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:43PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
(Thanks for pointing me here.)

> -void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
> +void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
>  {
> +	struct cgroup_subsys_state *css;
>  	struct list_lru *lru;
> +	int src_idx = src->kmemcg_id;
> +
> +	/*
> +	 * Change kmemcg_id of this cgroup and all its descendants to the
> +	 * parent's id, and then move all entries from this cgroup's list_lrus
> +	 * to ones of the parent.
> +	 *
> +	 * After we have finished, all list_lrus corresponding to this cgroup
> +	 * are guaranteed to remain empty. So we can safely free this cgroup's
> +	 * list lrus in memcg_list_lru_free().
> +	 *
> +	 * Changing ->kmemcg_id to the parent can prevent memcg_list_lru_alloc()
> +	 * from allocating list lrus for this cgroup after memcg_list_lru_free()
> +	 * call.
> +	 */
> +	rcu_read_lock();
> +	css_for_each_descendant_pre(css, &src->css) {
> +		struct mem_cgroup *memcg;
> +
> +		memcg = mem_cgroup_from_css(css);
> +		memcg->kmemcg_id = dst->kmemcg_id;
> +	}
> +	rcu_read_unlock();

Do you envision using this function anywhere else beside offlining?
If not, you shouldn't need traversing whole subtree because normally
parents are offlined only after children (see cgroup_subsys_state.online_cnt).

>  
>  	mutex_lock(&list_lrus_mutex);
>  	list_for_each_entry(lru, &memcg_list_lrus, list)
> -		memcg_drain_list_lru(lru, src_idx, dst_memcg);
> +		memcg_drain_list_lru(lru, src_idx, dst);
>  	mutex_unlock(&list_lrus_mutex);

If you do, then here you only drain list_lru of the subtree root but not
the descendants anymore.

So I do get that mem_cgroup.kmemcg_id refernces the "effective"
kmemcg_id after offlining, so that proper list_lrus are used afterwards.

I wonder -- is this necessary when objcgs are reparented too? IOW would
anyone query the offlined child's kmemcg_id?
(Maybe it's worth explaining better in the commit message, I think even
current approach is OK (better safe than sorry).)


Thanks,
Michal
