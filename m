Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA3256F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEURqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 13:46:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfEURqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 13:46:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHhbwt040845;
        Tue, 21 May 2019 17:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mxyCaD1FttKGOJyZPE9UrjXbiBQbnIlw4IFO99JAVQY=;
 b=Rp/6Kf7/FUUfYIjjzflRnRnBUYF7tumD8zC+WpNNYXpc33gh3P/J/tLAIJAiiuaBY914
 G+ME2CuRFUGetVn+/S8CjX1BL0icjqfP873PSlfHLOnEtzecV0QvI3OespaYKARU1Os/
 zomhLubKZIvLuYgOYJYeY5jBMNl1luFrWAe4PPtv1GMM7nHF1fXcsH1G0prG6wZl+obe
 dIUgqsdkE7R7BuHzSa90E6XZd+ehBCWFg7vyZbN+X7Fo4XHAf3D1HLmQV0NPo2H+JF08
 vEE0eMoRnX8aFh5SRAEC5JVxCxa8igTJVaLDxpkr3Tf1FkEipNv3iMEPGyhRfgFWP+wn qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2sj9ftf473-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:46:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHjepT049866;
        Tue, 21 May 2019 17:46:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sks1jk7hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:46:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LHkRka024111;
        Tue, 21 May 2019 17:46:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 17:46:26 +0000
Date:   Tue, 21 May 2019 10:46:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 08/18] dax: memcpy page in case of IOMAP_DAX_COW for mmap
 faults
Message-ID: <20190521174625.GF5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-9-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-9-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210109
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210109
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:26:39PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Change dax_iomap_pfn to return the address as well in order to
> use it for performing a memcpy in case the type is IOMAP_DAX_COW.
> We don't handle PMD because btrfs does not support hugepages.
> 
> Question:
> The sequence of bdev_dax_pgoff() and dax_direct_access() is
> used multiple times to calculate address and pfn's. Would it make
> sense to call it while calculating address as well to reduce code?
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/dax.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 610bfa861a28..718b1632a39d 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -984,7 +984,7 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
>  }
>  
>  static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> -			 pfn_t *pfnp)
> +			 pfn_t *pfnp, void **addr)
>  {
>  	const sector_t sector = dax_iomap_sector(iomap, pos);
>  	pgoff_t pgoff;
> @@ -996,7 +996,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
>  		return rc;
>  	id = dax_read_lock();
>  	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> -				   NULL, pfnp);
> +				   addr, pfnp);
>  	if (length < 0) {
>  		rc = length;
>  		goto out;
> @@ -1286,6 +1286,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
>  	struct inode *inode = mapping->host;
>  	unsigned long vaddr = vmf->address;
> +	void *addr;
>  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
>  	struct iomap iomap = { 0 };

Ugh, I had forgotten that fs/dax.c open-codes iomap_apply, probably
because the actor returns vm_fault_t, not bytes copied.  I guess that
makes it a tiny bit more complicated to pass in two (struct iomap *) to
the iomap_begin function...

>  	unsigned flags = IOMAP_FAULT;
> @@ -1375,16 +1376,26 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	sync = dax_fault_is_synchronous(flags, vma, &iomap);
>  
>  	switch (iomap.type) {
> +	case IOMAP_DAX_COW:
>  	case IOMAP_MAPPED:
>  		if (iomap.flags & IOMAP_F_NEW) {
>  			count_vm_event(PGMAJFAULT);
>  			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>  			major = VM_FAULT_MAJOR;
>  		}
> -		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
> +		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn, &addr);
>  		if (error < 0)
>  			goto error_finish_iomap;
>  
> +		if (iomap.type == IOMAP_DAX_COW) {
> +			if (iomap.inline_data) {
> +				error = memcpy_mcsafe(addr, iomap.inline_data,
> +					      PAGE_SIZE);
> +				if (error < 0)
> +					goto error_finish_iomap;
> +			} else
> +				memset(addr, 0, PAGE_SIZE);

This memcpy_mcsafe/memset chunk shows up a lot in this series.  Maybe it
should be a static inline within dax.c?

--D

> +		}
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						 0, write && !sync);
>  
> @@ -1597,7 +1608,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  	switch (iomap.type) {
>  	case IOMAP_MAPPED:
> -		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
> +		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn, NULL);
>  		if (error < 0)
>  			goto finish_iomap;
>  
> -- 
> 2.16.4
> 
