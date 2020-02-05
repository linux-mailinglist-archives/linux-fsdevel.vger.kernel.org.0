Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4515382A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBEScG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:32:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEScF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=atoIN1OFKCU2b5DgZt33HXnRgjJrT50beNxSLnGsZbo=; b=kliQ8fsEHZFoN0v/LbvxMWn4Vs
        BpKxAJxnm+S8GyqNylyBM76FILz9NUGyuot4wcQv0YoeA2z2oqL98udL9f+uk6mTgdACSA+CBOS8+
        WsX7/jADCrNOPWoWhnRhyuOLoaxEqNdy4EQM+H4h93QtZmx+ThPHzag0tGkZYaAUv4R2/DfrwhWI5
        mRIK24RxU4+CxSNPrO6vD0qg2Xgvp0ZImW+zwdgNH65ISRT8YVG/LdIVQkzC0BSrNR8w9vLVSidw6
        Gu/Abtu9bJbd8QXqxZ1jM+MT/lD2pjLcP4JTtK8tf2UdoHXmIKjCd7BFVGVmIGg4MSOJTCIcAr3cC
        ijJFvNuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izPT3-0001K6-LJ; Wed, 05 Feb 2020 18:32:05 +0000
Date:   Wed, 5 Feb 2020 10:32:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org, dm-devel@redhat.com
Subject: Re: [PATCH 2/5] s390,dax: Add dax zero_page_range operation to
 dcssblk driver
Message-ID: <20200205183205.GB26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 63502ca537eb..f6709200bcd0 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -62,6 +62,7 @@ static const struct dax_operations dcssblk_dax_ops = {
>  	.dax_supported = generic_fsdax_supported,
>  	.copy_from_iter = dcssblk_dax_copy_from_iter,
>  	.copy_to_iter = dcssblk_dax_copy_to_iter,
> +	.zero_page_range = dcssblk_dax_zero_page_range,
>  };
>  
>  struct dcssblk_dev_info {
> @@ -941,6 +942,12 @@ dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  	return __dcssblk_direct_access(dev_info, pgoff, nr_pages, kaddr, pfn);
>  }
>  
> +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
> +				       unsigned offset, size_t len)
> +{
> +	return generic_dax_zero_page_range(dax_dev, pgoff, offset, len);
> +}

Wouldn't this need a forward declaration?  Then again given that dcssblk
is the only caller of generic_dax_zero_page_range we might as well merge
the two.  If you want to keep the generic one it could be wired up to
dcssblk_dax_ops directly, though.
