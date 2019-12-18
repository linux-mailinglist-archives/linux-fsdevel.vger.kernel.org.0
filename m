Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523CB123E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 05:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLREQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 23:16:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLREQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:16:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI4Fwk9143662;
        Wed, 18 Dec 2019 04:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=ZdwOsyjN5HsgkVOu2FtsoDs7BV0Xv1iaEdwJgAfSqsY=;
 b=YgLEY4UdadOrIhYY5SUK4ZoC6t0t/Z8FCuX66lnkVQi04FOpfv8sJXTGvta7r64kohjW
 6veksFUflQ6UxXl8UVbHaMpiK02vG148vSDdPhnij1RaVbEWPMNDibrN/xXIE661H1Gs
 ZurCUcHSkCYU7bI/DXQ0Rh0533dct7waQ+5HCzlrdVClVV+RFXdcgU004AMQ5XBtDnDt
 H9Ey5+7zb63zoKdX6fSmVWbzxsbNj167yrW6Hnu8IYeuTKztlTs5RMuEbvk5O6qrrvwZ
 fzEuoNGuPniliCnYw9fRYDA9TTYqLLJanQ0L6tsadq6BL8xB2+G8todqmgideSq/9D7s 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wvqpqb05r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 04:15:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI4DrLY195461;
        Wed, 18 Dec 2019 04:15:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wxm75kw2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 04:15:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBI4Fm50023743;
        Wed, 18 Dec 2019 04:15:48 GMT
Received: from localhost (/10.159.137.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 20:15:48 -0800
Date:   Tue, 17 Dec 2019 20:15:46 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 5/6] iomap: support RWF_UNCACHED for buffered writes
Message-ID: <20191218041546.GN12766@magnolia>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-6-axboe@kernel.dk>
 <20191218015259.GJ12766@magnolia>
 <58036cc3-e0c3-70fe-0ce6-a86754258f24@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58036cc3-e0c3-70fe-0ce6-a86754258f24@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180031
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 08:18:07PM -0700, Jens Axboe wrote:
> On 12/17/19 6:52 PM, Darrick J. Wong wrote:
> > On Tue, Dec 17, 2019 at 07:39:47AM -0700, Jens Axboe wrote:
> >> This adds support for RWF_UNCACHED for file systems using iomap to
> >> perform buffered writes. We use the generic infrastructure for this,
> >> by tracking pages we created and calling write_drop_cached_pages()
> >> to issue writeback and prune those pages.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  fs/iomap/apply.c       | 35 +++++++++++++++++++++++++++++++++++
> >>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
> >>  fs/iomap/trace.h       |  4 +++-
> >>  include/linux/iomap.h  |  5 +++++
> >>  4 files changed, 67 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> >> index 792079403a22..687e86945b27 100644
> >> --- a/fs/iomap/apply.c
> >> +++ b/fs/iomap/apply.c
> >> @@ -92,5 +92,40 @@ iomap_apply(struct iomap_ctx *data, const struct iomap_ops *ops,
> >>  				     data->flags, &iomap);
> >>  	}
> >>  
> >> +	if (written <= 0)
> >> +		goto out;
> >> +
> >> +	/*
> >> +	 * If this is an uncached write, then we need to write and sync this
> >> +	 * range of data. This is only true for a buffered write, not for
> >> +	 * O_DIRECT.
> >> +	 */
> > 
> > I tracked down the original conversation, where Dave had this to say:
> > 
> > "Hence, IMO, this is the wrong layer in iomap to be dealing with¬
> > writeback and cache residency for uncached IO. We should be caching¬
> > residency/invalidation at a per-IO level, not a per-page level."
> > 
> > He's right, but I still think it doesn't quite smell right to be putting
> > this in iomap_apply, since that's a generic function that implements
> > iteration and shouldn't be messing with cache invalidation.
> > 
> > So I have two possible suggestions for where to put this:
> > 
> > (1) Add the "flush and maybe invalidate" behavior to the bottom of
> > iomap_write_actor like I said in the v4 patchset.  That will issue
> > writeback and invalidate pagecache in smallish quantities.
> > 
> > (2) Find a way to pass the IOMAP_F_PAGE_CREATE state from
> > iomap_write_actor back to iomap_file_buffered_write and do the
> > flush-and-invalidate for the entire write request once at the end.
> 
> Thanks for your suggestion, I'll look into option 2. Option 1 isn't
> going to work, as smaller quantities is going to cause a performance
> issue for streamed IO.

<nod> I would also conjecture that pushing fewer flushes through xfs
might reduce the amount of seeking writing around that it has to do,
which may or may not help with storage these days.

> >> @@ -851,10 +860,18 @@ iomap_write_actor(const struct iomap_ctx *data, struct iomap *iomap,
> >>  			break;
> >>  		}
> >>  
> >> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
> >> -				srcmap);
> >> -		if (unlikely(status))
> >> +retry:
> >> +		status = iomap_write_begin(inode, pos, bytes, flags,
> >> +						&page, iomap, srcmap);
> >> +		if (unlikely(status)) {
> >> +			if (status == -ENOMEM &&
> >> +			    (flags & IOMAP_WRITE_F_UNCACHED)) {
> >> +				iomap->flags |= IOMAP_F_PAGE_CREATE;
> >> +				flags &= ~IOMAP_WRITE_F_UNCACHED;
> > 
> > What's the strategy here?  We couldn't get a page for an uncached write,
> > so try again as a regular cached write?
> 
> The idea is that we start with IOMAP_WRITE_F_UNCACHED set, in which case
> we only do page lookup, not create. If that works, then we know that the
> given page was already in the page cache. If it fails with -ENOMEM, we
> store this information as IOMAP_F_PAGE_CREATE, and then clear
> IOMAP_WRITE_F_UNCACHED and retry. The retry will create the page, and
> now the caller knows that we had to create pages to satisfy this
> write. The caller uses this information to invalidate the entire range.

Ah, ok, it's intrinsic to the operation.  Would you mind putting that in
as a comment?

--D

> Hope that explains better!
> 
> > Thanks for making the updates, it's looking better.
> 
> Thanks!
> 
> -- 
> Jens Axboe
> 
