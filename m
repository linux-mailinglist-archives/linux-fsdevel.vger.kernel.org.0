Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1700E3FEA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhIBHdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:33:17 -0400
Received: from verein.lst.de ([213.95.11.211]:50267 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233360AbhIBHdQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:33:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 116426736F; Thu,  2 Sep 2021 09:32:16 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:32:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v8 4/7] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Message-ID: <20210902073215.GC13867@lst.de>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com> <20210829122517.1648171-5-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829122517.1648171-5-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 08:25:14PM +0800, Shiyang Ruan wrote:
> Punch hole on a reflinked file needs dax_iomap_cow_copy() too.
> Otherwise, data in not aligned area will be not correct.  So, add the
> srcmap to dax_iomap_zero() and replace memset() as dax_iomap_cow_copy().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/dax.c               | 26 ++++++++++++++++----------
>  fs/iomap/buffered-io.c |  4 ++--
>  include/linux/dax.h    |  3 ++-
>  3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index f4acb79cb811..b294900e574e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1209,7 +1209,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>  
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(loff_t pos, u64 length, const struct iomap *iomap,
> +		const struct iomap *srcmap)

We can in fact pass the iomap_iter here as well.  (probably as a prep
patch).

>  	if (page_aligned)
>  		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> -	else
> +	else {
>  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);

I'd clean this up a bit by doing:

	id = dax_read_lock();	
	if (page_aligned) {
		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
		goto out;
	}

	// non aligned case here without extra indentation or checks
