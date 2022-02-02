Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15064A716B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiBBNVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 08:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiBBNVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:21:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301AFC061714;
        Wed,  2 Feb 2022 05:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SoV3r288QEP7ETkrQHVuY/ATfMTUxF59iaqhIfRcPGI=; b=ztkj1INHInsEJO4Rj/LvLtqjJC
        BGKnqUhJTuEHZ9Wvl8RnXhlzz6qvfPDYGU0zn7wWf10qAcVvSG5wGC0fzResM/camXh3ACVJg6e3I
        pM2wuNr4T5AJ29eZ7Gsyidl00hEdOWBYi0I8int7unA3XnKiLnenY6Xwx5u82lPVtbm6YFb5Ckqvo
        U/bGQvXQShtSJrSv4QwgBdnp6WldT7nFgN0iO81GrnoQw/zQfPz/ZUoNQ58aWMbCVZoEe5zznzjXj
        9Jcuj0ncF5JmWTuZXWXtPgSmZytzL9dasExtfA7wSJCqBl+1wenvCLk/ob5BAG13Xqz4wXM5TaC3n
        Gy1M/iXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFFZi-00FLFj-Aj; Wed, 02 Feb 2022 13:21:30 +0000
Date:   Wed, 2 Feb 2022 05:21:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 1/7] mce: fix set_mce_nospec to always unmap the whole
 page
Message-ID: <YfqFWjFcdJSwjRaU@infradead.org>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-2-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128213150.1333552-2-jane.chu@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline int set_mce_nospec(unsigned long pfn)
>  {
>  	unsigned long decoy_addr;
>  	int rc;
> @@ -117,10 +113,7 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
>  	 */
>  	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
>  
> -	if (unmap)
> -		rc = set_memory_np(decoy_addr, 1);
> -	else
> -		rc = set_memory_uc(decoy_addr, 1);
> +	rc = set_memory_np(decoy_addr, 1);
>  	if (rc)
>  		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
>  	return rc;
> @@ -130,7 +123,7 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
>  /* Restore full speculative operation to the pfn. */
>  static inline int clear_mce_nospec(unsigned long pfn)
>  {
> -	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
> +	return _set_memory_present((unsigned long) pfn_to_kaddr(pfn), 1);
>  }

Wouldn't it make more sense to move these helpers out of line rather
than exporting _set_memory_present?

>  /*
> - * _set_memory_prot is an internal helper for callers that have been passed
> + * __set_memory_prot is an internal helper for callers that have been passed

This looks unrelated to the patch.
