Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87FCF85803
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 04:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfHHCKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 22:10:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53764 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfHHCKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:10:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7828n9a075780;
        Thu, 8 Aug 2019 02:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TXriKJvJy2myVnw3c051jaeKryW3drWG0pSPjwioE5Q=;
 b=ADL40WecBnB1Z3f42497pGyz1FyclGQ12j8lMNgbk8lS2dQH08wmqTtk61/uTFlpsPhw
 zxrefhxHc33igYwECLs1R2GLPBjHP1B5tFfW2WTj/hrt6GUgi4z/JYrDBn7MrifRAIKT
 mnsrLpoihyFchsX613OBx61Y5hgEZxSKCIRpdTOh/U9zhRNJmq41K9QgLqXt+9Ac2oLm
 AjczwomaVHvfu9qBvXhwDvzDJQVUOLeQ/RPa5oCtTqZR55hnXUwmsUk1rdWDSb/MCSpg
 px81wxj13WmfCMA5n+Wwlu2bZLks8SAk5tzLwlCMAbRQHdlShrUj/KGgx5RQB60/nqL+ eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u51pu7q65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 02:10:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7828OEE109698;
        Thu, 8 Aug 2019 02:10:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u7578h0y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 02:10:48 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x782Alj2012359;
        Thu, 8 Aug 2019 02:10:47 GMT
Received: from localhost (/10.159.246.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 19:10:47 -0700
Date:   Wed, 7 Aug 2019 19:10:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     viro@zeniv.linux.org.uk, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190808021046.GD7157@magnolia>
References: <20190807145114.GP7138@magnolia>
 <20190807223850.GQ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807223850.GQ7777@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:38:50AM +1000, Dave Chinner wrote:
> On Wed, Aug 07, 2019 at 07:51:14AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > +/*
> > + * Lock two pages, ensuring that we lock in offset order if the pages are from
> > + * the same file.
> > + */
> > +static void vfs_lock_two_pages(struct page *page1, struct page *page2)
> > +{
> > +	if (page1 == page2) {
> > +		lock_page(page1);
> > +		return;
> > +	}
> > +
> > +	if (page1->mapping == page2->mapping && page1->index > page2->index)
> > +		swap(page1, page2);
> 
> I would do this even if the pages are on different mappings. That
> way we don't expose a landmine if some other code locks two pages
> from the same mappings in a different order...

Sure.

> > +	lock_page(page1);
> > +	lock_page(page2);
> > +}
> > +
> >  /*
> >   * Compare extents of two files to see if they are the same.
> >   * Caller must have locked both inodes to prevent write races.
> > @@ -1867,10 +1881,12 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> >  		dest_page = vfs_dedupe_get_page(dest, destoff);
> >  		if (IS_ERR(dest_page)) {
> >  			error = PTR_ERR(dest_page);
> > -			unlock_page(src_page);
> >  			put_page(src_page);
> >  			goto out_error;
> >  		}
> > +
> > +		vfs_lock_two_pages(src_page, dest_page);
> > +
> >  		src_addr = kmap_atomic(src_page);
> >  		dest_addr = kmap_atomic(dest_page);
> >  
> > @@ -1882,7 +1898,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> >  
> >  		kunmap_atomic(dest_addr);
> >  		kunmap_atomic(src_addr);
> > -		unlock_page(dest_page);
> > +		if (dest_page != src_page)
> > +			unlock_page(dest_page);
> >  		unlock_page(src_page);
> 
> Would it make sense for symmetry to wrap these in
> vfs_unlock_two_pages()?

Sure.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
