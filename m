Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA28345AF44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhKWWnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236001AbhKWWnM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:43:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBEF660C49;
        Tue, 23 Nov 2021 22:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637707203;
        bh=TPkdIIvK3hEApsrrBTQ54izWI2KU2MSsYLSgl81j84A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BURKP9F27CGb8J8d1Jn8pHGKCBiQFHCh/OkhU3opkn5+Upho52FaWc9Bjf3B0Rkmk
         Jg1lyp3oNqWs/ZLFEUEYW75h5sbh0qo09rD/8ooc1l0Q1KqRCfqugVoLoqBM+sSlsM
         59eKBtH7GdntlhPVjlkuRPfjWUTGx1vODvcKAE/8zO7NATG4YEq7YqVDPyUXy34Z8/
         y6tTvZCsxRK6Yy+GUKUuSVvSdO6GA24vYfdQQam4Lndl2BnG7ux4TOtoRJjZK1188L
         +fy7BpA9O7u4uV9MBf3qYADkpTRU/LQPzf7CRrOYloXhIW5whZ5lcDB++IZ0MyDUTX
         9pxX0uORKDeBg==
Date:   Tue, 23 Nov 2021 14:40:03 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
Message-ID: <20211123224003.GK266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:32:56AM +0100, Christoph Hellwig wrote:
> The file relative offset must have the same alignment as the storage
> offset, so use that and get rid of the call to iomap_sector.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5364549d67a48..d7a923d152240 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1123,7 +1123,6 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
> -	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>  	long rc, id;
>  	void *kaddr;
> @@ -1131,8 +1130,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  	unsigned offset = offset_in_page(pos);
>  	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>  
> -	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
> -	    (size == PAGE_SIZE))
> +	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
>  		page_aligned = true;
>  
>  	id = dax_read_lock();
> -- 
> 2.30.2
> 
