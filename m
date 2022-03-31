Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE6F4EDC46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiCaPDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCaPDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:03:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B621206EEE;
        Thu, 31 Mar 2022 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I1ivG9NRVVOIvA3ZPKM+gIMrRc3A4IUWwLKDETjpzMc=; b=nmphzON5aRX1gVVs+kcWI+9gnm
        FxFJVvwZF+8lpX53dCZiA59vjQ/4MhaTldkSSN+oz2JfvAGRoPR0urkBcSQ/OKGcuOk5aNGoRclp2
        rp4OKUjZEEiESuwJq/ehxBoXmD45sbaVaaDkmit/NFXHr/qRz+t0eoeUFGHiX735Ocq3Wz2nf2eEi
        T/o73agCDMnNsjFCeyYv6Ba9dLnIIwe9LopsnNHiY/EzL73yI9PnIPN9xzWWi4TKetKV+5pWsm+3Q
        n4z9iJqNQ4YcHFhwDYTGngZIHpkF+qPBoWTJ9iQSHuBGzN+WKkfk85jnTbZX4mSrcvT64LHJ/GTfQ
        rdv4BqLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZwIz-002LNx-Nu; Thu, 31 Mar 2022 15:01:45 +0000
Date:   Thu, 31 Mar 2022 16:01:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
Message-ID: <YkXCWW7ru9Gxyy6G@casper.infradead.org>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
 <20220228122126.37293-13-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228122126.37293-13-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 08:21:22PM +0800, Muchun Song wrote:
> @@ -586,27 +508,48 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
>  		}
>  	}
>  
> +	xas_lock_irqsave(&xas, flags);
>  	while (i--) {
> +		int index = READ_ONCE(table[i].memcg->kmemcg_id);
>  		struct list_lru_per_memcg *mlru = table[i].mlru;
>  
> +		xas_set(&xas, index);
> +retry:
> +		if (unlikely(index < 0 || xas_error(&xas) || xas_load(&xas))) {
>  			kfree(mlru);
> +		} else {
> +			xas_store(&xas, mlru);
> +			if (xas_error(&xas) == -ENOMEM) {
> +				xas_unlock_irqrestore(&xas, flags);
> +				if (xas_nomem(&xas, gfp))
> +					xas_set_err(&xas, 0);
> +				xas_lock_irqsave(&xas, flags);
> +				/*
> +				 * The xas lock has been released, this memcg
> +				 * can be reparented before us. So reload
> +				 * memcg id. More details see the comments
> +				 * in memcg_reparent_list_lrus().
> +				 */
> +				index = READ_ONCE(table[i].memcg->kmemcg_id);
> +				if (index < 0)
> +					xas_set_err(&xas, 0);
> +				else if (!xas_error(&xas) && index != xas.xa_index)
> +					xas_set(&xas, index);
> +				goto retry;
> +			}
> +		}
>  	}
> +	/* xas_nomem() is used to free memory instead of memory allocation. */
> +	if (xas.xa_alloc)
> +		xas_nomem(&xas, gfp);
> +	xas_unlock_irqrestore(&xas, flags);
>  	kfree(table);
>  
> +	return xas_error(&xas);
>  }

This is really unidiomatic.  And so much more complicated than it needs
to be.

	while (i--) {
		do {
			int index = READ_ONCE(table[i].memcg->kmemcg_id);
			struct list_lru_per_memcg *mlru = table[i].mlru;

			xas_set(&xas, index);
			xas_lock_irqsave(&xas, flags);
			if (index < 0 || xas_load(&xas))
				xas_set_err(&xas, -EBUSY);
			xas_store(&xas, mlru);
			if (!xas_error(&xas))
				break;
			xas_unlock_irqrestore(&xas, flags);
		} while (xas_nomem(&xas, gfp));

		if (xas_error(&xas))
			kfree(mlru);
	}

	kfree(table);
	return xas_error(&xas);

(you might want to mask out the EBUSY error here)

