Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54815A267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgBLHuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:50:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgBLHuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1nVf4vn0jnrm81iZchVFMrYKYcdKsraT+ctD9FAeWIM=; b=oBuvATo3aKkkhrPnQLe1L0Tftm
        uv8E37LrW9Pl5sTQe1Wy9e7orifQHoglTYXc1w2y2d2PZRXnn1ZRJno6yb8bAtFrS23Nv1z6MlQu+
        PCXcY/HGH3ZEKI9ys82yZFU16SWh4aUL+Ltr1XtAayHALsQDDUZpKB73BVDpjiAUQ0ZjerBY2w1Mo
        GR883VVdazQIFtoLPO8K5Bt64FAprxdqtw/wnu61fukHeF6YTmqaBbWqypLvggygw/EE0w4FECYp+
        jYyLb0AkhqNUG0BO1EBsLvgUlCt/bsPoP/urbcQTA0wEZt6TMno2z4hGVRIfBRX2p0wcXE652oa1s
        FygXWy1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mmc-0002Q8-Rr; Wed, 12 Feb 2020 07:50:06 +0000
Date:   Tue, 11 Feb 2020 23:50:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/25] mm: Align THP mappings for non-DAX
Message-ID: <20200212075006.GJ7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-26-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b52e007f0856..b8d9e0d76062 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -577,13 +577,10 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  	unsigned long ret;
>  	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
>  
> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> -		goto out;
> -
>  	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
>  	if (ret)
>  		return ret;
> -out:
> +
>  	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
>  }
>  EXPORT_SYMBOL_GPL(thp_get_unmapped_area);

There is no point in splitting thp_get_unmapped_area and
__thp_get_unmapped_area with this applied (and arguably even before
that).  But we still have ext2 and ext4 that use thp_get_unmapped_area but
only support huge page mappings for DAX, do we need to handle those somehow?
