Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B700D42E910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhJOGfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhJOGf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:35:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8DC061570;
        Thu, 14 Oct 2021 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ibEI1mmKq4vxjW0ktDbC03rpOftLIInrNed7E6F6lw=; b=PD18RHTKLYmxrJL3JNrRViKr/T
        v3oL7kaWHzpcXQfxYCP9JEFl+hit6oTueUu4j/03KIdsY++jtpDzji9wuJGVithaJJgjIvo9Mc88W
        J3A10QBCXUM0cdx9ZCRB0ttdwY/qb6WIMxjvWIrMV/6mVH8aKk1p+oHcHpJf7ZHpCtOY2hiRZidn0
        fLxIjLufeU6/Qli2KoDOD1gTuF2Svj2TeSyntzVRJ2XOcLeETc2C4Ix+vEDuH2YR4g15bPog4CgF/
        VTrdaeJfzIy1Wy1af3Gx4BWxGuCBe5XAdjGThbDtxYW+stQCDEDqj6WoNups26Yjg418hcsAsh9UU
        Mhsc8+vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbGmQ-005Xpw-68; Fri, 15 Oct 2021 06:33:22 +0000
Date:   Thu, 14 Oct 2021 23:33:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v7 3/8] mm: factor helpers for memory_failure_dev_pagemap
Message-ID: <YWkgsrAuEybhouZy@infradead.org>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-4-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:54PM +0800, Shiyang Ruan wrote:
> memory_failure_dev_pagemap code is a bit complex before introduce RMAP
> feature for fsdax.  So it is needed to factor some helper functions to
> simplify these code.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  mm/memory-failure.c | 140 ++++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 64 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 54879c339024..8ff9b52823c0 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1430,6 +1430,79 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>  	return 0;
>  }
>  
> +static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
> +		struct address_space *mapping, pgoff_t index, int flags)
> +{
> +	struct to_kill *tk;
> +	unsigned long size = 0;
> +
> +	list_for_each_entry(tk, to_kill, nd)
> +		if (tk->size_shift)
> +			size = max(size, 1UL << tk->size_shift);
> +	if (size) {

Nit: an empty line here would be nice for readability.

> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> +		/*
> +		 * TODO: Handle HMM pages which may need coordination
> +		 * with device-side memory.
> +		 */
> +		return -EBUSY;

We've got rid of the HMM terminology for device private memory, so
I'd reword this update the comment to follow that while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
