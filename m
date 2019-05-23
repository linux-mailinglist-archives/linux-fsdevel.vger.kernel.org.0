Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF041274E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 06:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEWECy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 00:02:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:32862 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEWECy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 00:02:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4N3sLwU086500;
        Thu, 23 May 2019 04:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SpnlCnP/O9ZkZqlUX+vUBOkfGqSOfQHrVg1yrZjTXDs=;
 b=oTE2W0bRi34AyZgfWmQVQXAA9VcxLbzdRVkX62uTll9zZaiizxf3pTqA/8pLxO6Bvtm1
 5G8ay60GkxkeA1qKuLHSprf6I5n3tgxMFgPgo/29ornRWhXDrhhDFhuw2m21q/8zk8aV
 jOwz2AcWjgaW5wsZMfKZcS2DsyTozukLooud+NA4zAaR/E/kBf/WKN4AHl3bM2H8fI8e
 4qa2CDDPJkrs/jWOUgZusfpcr/15TJjGuz1Bn00/R7PhQg8W3xFSuJ7s+DDwURpzNlgJ
 7K1ebwmAMxYGh317Cx0kswnL+dEzOwdZVP3lNYXU06Y9mvMCb0vn80xYwnM292TdCVTA Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2smsk5fnm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 04:02:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4N41YAS070556;
        Thu, 23 May 2019 04:02:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2smsgt0ae9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 04:02:15 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4N424Jj030507;
        Thu, 23 May 2019 04:02:04 GMT
Received: from localhost (/10.159.244.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 May 2019 04:02:03 +0000
Date:   Wed, 22 May 2019 21:02:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 08/18] dax: memcpy page in case of IOMAP_DAX_COW for mmap
 faults
Message-ID: <20190523040202.GH5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-9-rgoldwyn@suse.de>
 <20190521174625.GF5125@magnolia>
 <20190522191139.62v2rgby5ptjhzcd@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522191139.62v2rgby5ptjhzcd@fiona>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905230026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905230026
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 02:11:39PM -0500, Goldwyn Rodrigues wrote:
> On 10:46 21/05, Darrick J. Wong wrote:
> > On Mon, Apr 29, 2019 at 12:26:39PM -0500, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > Change dax_iomap_pfn to return the address as well in order to
> > > use it for performing a memcpy in case the type is IOMAP_DAX_COW.
> > > We don't handle PMD because btrfs does not support hugepages.
> > > 
> > > Question:
> > > The sequence of bdev_dax_pgoff() and dax_direct_access() is
> > > used multiple times to calculate address and pfn's. Would it make
> > > sense to call it while calculating address as well to reduce code?
> > > 
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > ---
> > >  fs/dax.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index 610bfa861a28..718b1632a39d 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -984,7 +984,7 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
> > >  }
> > >  
> > >  static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> > > -			 pfn_t *pfnp)
> > > +			 pfn_t *pfnp, void **addr)
> > >  {
> > >  	const sector_t sector = dax_iomap_sector(iomap, pos);
> > >  	pgoff_t pgoff;
> > > @@ -996,7 +996,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> > >  		return rc;
> > >  	id = dax_read_lock();
> > >  	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> > > -				   NULL, pfnp);
> > > +				   addr, pfnp);
> > >  	if (length < 0) {
> > >  		rc = length;
> > >  		goto out;
> > > @@ -1286,6 +1286,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > >  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
> > >  	struct inode *inode = mapping->host;
> > >  	unsigned long vaddr = vmf->address;
> > > +	void *addr;
> > >  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
> > >  	struct iomap iomap = { 0 };
> > 
> > Ugh, I had forgotten that fs/dax.c open-codes iomap_apply, probably
> > because the actor returns vm_fault_t, not bytes copied.  I guess that
> > makes it a tiny bit more complicated to pass in two (struct iomap *) to
> > the iomap_begin function...
> 
> I am not sure I understand this. We do not use iomap_apply() in
> the fault path: dax_iomap_pte_fault(). We just use iomap_begin()
> and iomap_end(). So, why can we not implement your idea of using two
> iomaps?

Oh, sorry, I wasn't trying to say that calling ->iomap_begin made it
*impossible* to implement.  I was merely complaining about the increased
maintenance burden that results from open coding -- now there are three
places where we have to change a struct iomap declaration, not one
(iomap_apply) as I had originally thought.

> What does open-coding iomap-apply mean?

Any function that calls (1) ->iomap_begin; (2) performs an action on the
returned iomap; and (3) then calls calling ->iomap_end.  That's what
iomap_apply() does.

Really I'm just being maintainer-cranky.  Ignore me for now. :)

--D

> 
> -- 
> Goldwyn
