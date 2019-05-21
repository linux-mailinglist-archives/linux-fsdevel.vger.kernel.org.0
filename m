Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA3256CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfEURgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 13:36:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45298 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEURgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 13:36:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHXm37046297;
        Tue, 21 May 2019 17:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=b7edMFrQ3NqOzy/by6yyi74dZMSbcYLO9I66oOhpcuY=;
 b=JqRri5zizpHhE68R0De70Dmh2C5xa9nJFcnupTVTPyh12mbNzc4VZrgtzFkH4bh0dsSL
 r5jrNQzTbWxa5p2bJum53XYtp35HSu1I4gvYsc+EgP+bFEyPV+jbLnDSg0F2Rymrznjh
 6laTTC3JQYueewlNDY46SsNPmpTpEp5HHOZwfyqoabpa5yMo0uvKwE0uNDxXQnjbuQt0
 TXsHCyGoMZp1jEQNlovwZn3BLfVbmdZr7rUJPzNUqq0z1vHHMWykv05HLLPOeEOXdEvf
 ZFZWzACaNVsAP6xN9B1DWqU9N6S/bElQw7mbGHAlCWvwDtp3ZEW297M95c7vFTh5ch7W hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2sj7jdq7td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:35:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHZeUY025239;
        Tue, 21 May 2019 17:35:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sks1jk2c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:35:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LHZfdP003627;
        Tue, 21 May 2019 17:35:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 17:35:41 +0000
Date:   Tue, 21 May 2019 10:35:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 10/18] dax: replace mmap entry in case of CoW
Message-ID: <20190521173540.GE5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-11-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-11-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210107
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:26:41PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> We replace the existing entry to the newly allocated one
> in case of CoW. Also, we mark the entry as PAGECACHE_TAG_TOWRITE
> so writeback marks this entry as writeprotected. This
> helps us snapshots so new write pagefaults after snapshots
> trigger a CoW.
> 
> btrfs does not support hugepages so we don't handle PMD.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/dax.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 718b1632a39d..07e8ff20161d 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -700,6 +700,9 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>  	return 0;
>  }
>  
> +#define DAX_IF_DIRTY		(1ULL << 0)
> +#define DAX_IF_COW		(1ULL << 1)
> +
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -709,14 +712,17 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>   */
>  static void *dax_insert_entry(struct xa_state *xas,
>  		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +		void *entry, pfn_t pfn, unsigned long flags,
> +		unsigned long insert_flags)

I think unsigned int would have sufficed here.

>  {
>  	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = insert_flags & DAX_IF_DIRTY;
> +	bool cow = insert_flags & DAX_IF_COW;
>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> -	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -728,12 +734,12 @@ static void *dax_insert_entry(struct xa_state *xas,
>  
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
> +	if (cow || (dax_entry_size(entry) != dax_entry_size(new_entry))) {
>  		dax_disassociate_entry(entry, mapping, false);
>  		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
>  	}
>  
> -	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		/*
>  		 * Only swap our new entry into the page cache if the current
>  		 * entry is a zero page or an empty entry.  If a normal PTE or
> @@ -753,6 +759,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>  
> +	if (cow)
> +		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
>  	xas_unlock_irq(xas);
>  	return entry;
>  }
> @@ -1032,7 +1041,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	vm_fault_t ret;
>  
>  	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_ZERO_PAGE, false);
> +			DAX_ZERO_PAGE, 0);
>  
>  	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>  	trace_dax_load_hole(inode, vmf, ret);
> @@ -1296,6 +1305,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	vm_fault_t ret = 0;
>  	void *entry;
>  	pfn_t pfn;
> +	unsigned long insert_flags = 0;
>  
>  	trace_dax_pte_fault(inode, vmf, ret);
>  	/*
> @@ -1357,6 +1367,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			error = copy_user_dax(iomap.bdev, iomap.dax_dev,
>  					sector, PAGE_SIZE, vmf->cow_page, vaddr);
>  			break;
> +		case IOMAP_DAX_COW:
> +			/* Should not be setting this - fallthrough */
>  		default:
>  			WARN_ON_ONCE(1);
>  			error = -EIO;
> @@ -1377,6 +1389,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  	switch (iomap.type) {
>  	case IOMAP_DAX_COW:
> +		insert_flags |= DAX_IF_COW;
> +		/* fallthrough */
>  	case IOMAP_MAPPED:
>  		if (iomap.flags & IOMAP_F_NEW) {
>  			count_vm_event(PGMAJFAULT);
> @@ -1396,8 +1410,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			} else
>  				memset(addr, 0, PAGE_SIZE);
>  		}
> +		if (write && !sync)
> +			insert_flags |= DAX_IF_DIRTY;
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> -						 0, write && !sync);
> +						 0, insert_flags);
>  
>  		/*
>  		 * If we are doing synchronous page fault and inode needs fsync,
> @@ -1478,7 +1494,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  
>  	pfn = page_to_pfn_t(zero_page);
>  	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_PMD | DAX_ZERO_PAGE, false);
> +			DAX_PMD | DAX_ZERO_PAGE, 0);
>  
>  	if (arch_needs_pgtable_deposit()) {
>  		pgtable = pte_alloc_one(vma->vm_mm);
> @@ -1528,6 +1544,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	loff_t pos;
>  	int error;
>  	pfn_t pfn;
> +	unsigned long insert_flags = 0;
>  
>  	/*
>  	 * Check whether offset isn't beyond end of file now. Caller is
> @@ -1612,8 +1629,11 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		if (error < 0)
>  			goto finish_iomap;
>  
> +		if (write && !sync)
> +			insert_flags |= DAX_IF_DIRTY;
> +
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> -						DAX_PMD, write && !sync);
> +						DAX_PMD, insert_flags);

Otherwise, this seems reasonable enough to me.  What do the DAX
developers think?

FWIW I'm not thrilled by the fact that Goldwyn isn't wiring up the
(rather similar looking) PMD code paths, but I grok that btrfs doesn't
support hugepages so he has no way to test that the code path actually
works so I'm ok with letting that go (until XFS joins the party) so long
as the pmd code path changes aren't too dissimilar to the pte code
paths.  Is that true?

--D

>  
>  		/*
>  		 * If we are doing synchronous page fault and inode needs fsync,
> -- 
> 2.16.4
> 
