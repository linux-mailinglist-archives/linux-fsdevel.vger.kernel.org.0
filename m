Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38EEEA972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 04:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfJaDHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 23:07:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53626 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfJaDHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:07:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V34hie174554;
        Thu, 31 Oct 2019 03:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cxFwkp0Wx028V6b6YreaO9fUqUe3Fm77No3Nnu9rR3I=;
 b=m+3Tuyj9NCMjJr/mjzJWpTY7GG8y1Lu0RLRJuxKQ18qxtXzGvwvFg7B72b+TTg38xSr8
 TOgKwxCR6yhIIlM77OCRjrYLceEQb0CWMwiBt8lc0XUTlGgxZH5P43mUtAxEf7yuNqlI
 JzmXuG9hdL/85G0v0/NUCgeK4jgWjmCoGGYRDxK2gTkqFNq7aWKmn8o+8PMoj/NRasz8
 h5GG/U3HNDnne3S/beJtO1phXZaUB2W0dNxpo7popItN6jRi2K/M4iK3M4xNm7pJ+zHW
 qExWaD3i2Ebj32SjxH5gMYbGHnlp+VrmMlsHNo/074yW/HjYyWKVHv9km4myuxNUxUH2 eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vxwhfr48f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:07:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V32iD9032078;
        Thu, 31 Oct 2019 03:07:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vxwj865br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:07:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9V36xfD030222;
        Thu, 31 Oct 2019 03:06:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 20:06:59 -0700
Date:   Wed, 30 Oct 2019 20:06:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191031030658.GW15222@magnolia>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191030172517.GO15222@magnolia>
 <20191030214335.GQ4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030214335.GQ4614@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310029
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 08:43:35AM +1100, Dave Chinner wrote:
> On Wed, Oct 30, 2019 at 10:25:17AM -0700, Darrick J. Wong wrote:
> > On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > The buffer cache shrinker frees more than just the xfs_buf slab
> > > objects - it also frees the pages attached to the buffers. Make sure
> > > the memory reclaim code accounts for this memory being freed
> > > correctly, similar to how the inode shrinker accounts for pages
> > > freed from the page cache due to mapping invalidation.
> > > 
> > > We also need to make sure that the mm subsystem knows these are
> > > reclaimable objects. We provide the memory reclaim subsystem with a
> > > a shrinker to reclaim xfs_bufs, so we should really mark the slab
> > > that way.
> > > 
> > > We also have a lot of xfs_bufs in a busy system, spread them around
> > > like we do inodes.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/xfs_buf.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > > index e484f6bead53..45b470f55ad7 100644
> > > --- a/fs/xfs/xfs_buf.c
> > > +++ b/fs/xfs/xfs_buf.c
> > > @@ -324,6 +324,9 @@ xfs_buf_free(
> > >  
> > >  			__free_page(page);
> > >  		}
> > > +		if (current->reclaim_state)
> > > +			current->reclaim_state->reclaimed_slab +=
> > > +							bp->b_page_count;
> > 
> > Hmm, ok, I see how ZONE_RECLAIM and reclaimed_slab fit together.
> > 
> > >  	} else if (bp->b_flags & _XBF_KMEM)
> > >  		kmem_free(bp->b_addr);
> > >  	_xfs_buf_free_pages(bp);
> > > @@ -2064,7 +2067,8 @@ int __init
> > >  xfs_buf_init(void)
> > >  {
> > >  	xfs_buf_zone = kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
> > > -						KM_ZONE_HWALIGN, NULL);
> > > +			KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,
> > 
> > I guess I'm fine with ZONE_SPREAD too, insofar as it only seems to apply
> > to a particular "use another node" memory policy when slab is in use.
> > Was that your intent?
> 
> It's more documentation than anything - that we shouldn't be piling
> these structures all on to one node because that can have severe
> issues with NUMA memory reclaim algorithms. i.e. the xfs-buf
> shrinker sets SHRINKER_NUMA_AWARE, so memory pressure on a single
> node can reclaim all the xfs-bufs on that node without touching any
> other node.
> 
> That means, for example, if we instantiate all the AG header buffers
> on a single node (e.g. like we do at mount time) then memory
> pressure on that one node will generate IO stalls across the entire
> filesystem as other nodes doing work have to repopulate the buffer
> cache for any allocation for freeing of space/inodes..
> 
> IOWs, for large NUMA systems using cpusets this cache should be
> spread around all of memory, especially as it has NUMA aware
> reclaim. For everyone else, it's just documentation that improper
> cgroup or NUMA memory policy could cause you all sorts of problems
> with this cache.
> 
> It's worth noting that SLAB_MEM_SPREAD is used almost exclusively in
> filesystems for inode caches largely because, at the time (~2006),
> the only reclaimable cache that could grow to any size large enough
> to cause problems was the inode cache. It's been cargo-culted ever
> since, whether it is needed or not (e.g. ceph).
> 
> In the case of the xfs_bufs, I've been running workloads recently
> that cache several million xfs_bufs and only a handful of inodes
> rather than the other way around. If we spread inodes because
> caching millions on a single node can cause problems on large NUMA
> machines, then we also need to spread xfs_bufs...

Hmm, could we capture this as a comment somewhere?

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
