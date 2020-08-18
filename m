Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD782248B3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHRQNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 12:13:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34578 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHRQNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:13:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IGCR6b076721;
        Tue, 18 Aug 2020 16:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Z4JyWG9GYx40D449jT2SjIZ+/FrA45k/t7nbWC1W2ME=;
 b=XedNvxk9JX13hSSYLNXrWjhgbNP1hh4R07ULkgct1y9+gFtvsgtt4PSEEH2fcM9j3uvM
 F2CZgJvb50atFE53NE8F5K91J9zov24NAuLsixCcSG/eU/Kilo/87u/ttgicq2UBv054
 +piXEOWrprHZler9cm0LBJUVBiL/tguVYpRmwq3jufop97+YSv75eIVYL309EPswKvrZ
 Mz0ew/U53+lZHRm1Bm2oeBFVZyxlIjuEncZ3gijk9AffvyZGb0Gtjt8DSeuO59MGkqbQ
 UQWjWzKK/NHj5kdXJ41j6TCUNw0LR2iwiWDYMT/4g2c52+sNz9dHbtpluYqIjNgJlbUM Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32x74r5vc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 16:12:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IFllTW076145;
        Tue, 18 Aug 2020 16:12:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32xsm37mj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 16:12:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IGCU8l025942;
        Tue, 18 Aug 2020 16:12:30 GMT
Received: from localhost (/10.159.245.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 09:12:30 -0700
Date:   Tue, 18 Aug 2020 09:12:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V2] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200818161229.GK6107@magnolia>
References: <20200818134618.2345884-1-yukuai3@huawei.com>
 <20200818155305.GR17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818155305.GR17456@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9717 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:53:05PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 18, 2020 at 09:46:18PM +0800, Yu Kuai wrote:
> > changes from v1:
> >  - separate set dirty and clear dirty functions
> >  - don't test uptodate bit in iomap_writepage_map()
> >  - use one bitmap array for uptodate and dirty.
> 
> This looks much better.
> 
> > +	spinlock_t		state_lock;
> > +	/*
> > +	 * The first half bits are used to track sub-page uptodate status,
> > +	 * the second half bits are for dirty status.
> > +	 */
> > +	DECLARE_BITMAP(state, PAGE_SIZE / 256);
> 
> It would be better to use the same wording as below:
> 
> > +	bitmap_zero(iop->state, PAGE_SIZE * 2 / SECTOR_SIZE);

ISTR there was some reason why '512' was hardcoded in here instead of
SECTOR_SIZE.  I /think/ it was so that iomap.h did not then have a hard
dependency on blkdev.h and everything else that requires...

https://lore.kernel.org/linux-xfs/20181215105155.GD1575@lst.de/

--D

> 
> [...]
> 
> > +static void
> > +iomap_iop_set_range_dirty(struct page *page, unsigned int off,
> > +		unsigned int len)
> > +{
> > +	struct iomap_page *iop = to_iomap_page(page);
> > +	struct inode *inode = page->mapping->host;
> > +	unsigned int total = PAGE_SIZE / SECTOR_SIZE;
> > +	unsigned int first = off >> inode->i_blkbits;
> > +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
> > +	unsigned long flags;
> > +	unsigned int i;
> > +
> > +	spin_lock_irqsave(&iop->state_lock, flags);
> > +	for (i = first; i <= last; i++)
> > +		set_bit(i + total, iop->state);
> > +	spin_unlock_irqrestore(&iop->state_lock, flags);
> > +}
> 
> How about:
> 
> -	unsigned int total = PAGE_SIZE / SECTOR_SIZE;
> ...
> +	first += PAGE_SIZE / SECTOR_SIZE;
> +	last += PAGE_SIZE / SECTOR_SIZE;
> ...
> 	for (i = first; i <= last; i++)
> -		set_bit(i + total, iop->state);
> +		set_bit(i, iop->state);
> 
> We might want
> 
> #define	DIRTY_BITS(x)	((x) + PAGE_SIZE / SECTOR_SIZE)
> 
> and then we could do:
> 
> +	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
> 
> That might be overthinking things a bit though.
> 
> > @@ -705,6 +767,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> >  	if (unlikely(copied < len && !PageUptodate(page)))
> >  		return 0;
> >  	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> > +	iomap_set_range_dirty(page, offset_in_page(pos), len);
> >  	iomap_set_page_dirty(page);
> 
> I would move the call to iomap_set_page_dirty() into
> iomap_set_range_dirty() to parallel iomap_set_range_uptodate more closely.
> We don't want a future change to add a call to iomap_set_range_dirty()
> and miss the call to iomap_set_page_dirty().
> 
> >  	return copied;
> >  }
> > @@ -1030,6 +1093,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		WARN_ON_ONCE(!PageUptodate(page));
> >  		iomap_page_create(inode, page);
> >  		set_page_dirty(page);
> > +		iomap_set_range_dirty(page, offset_in_page(pos), length);
> 
> I would move all this from the mkwrite_actor() to iomap_page_mkwrite()
> and call it once with (0, PAGE_SIZE) rather than calling it once for
> each extent in the page.
> 
> > @@ -1435,6 +1500,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  		 */
> >  		set_page_writeback_keepwrite(page);
> >  	} else {
> > +		iomap_clear_range_dirty(page, 0,
> > +				end_offset - page_offset(page) + 1);
> >  		clear_page_dirty_for_io(page);
> >  		set_page_writeback(page);
> 
> I'm not sure it's worth doing this calculation.  Better to just clear
> the dirty bits on the entire page?  Opinions?
