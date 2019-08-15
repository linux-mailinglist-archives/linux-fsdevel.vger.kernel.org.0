Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6268E1EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 02:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfHOAlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 20:41:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfHOAlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:41:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F0d615021987;
        Thu, 15 Aug 2019 00:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=wrrcCBfWY1APe+B+NgXDGXxzdV118puhYhlidf2Oa2k=;
 b=aKpDeEhWREnaDfKHy5OVR0TzaWnF3wWBWTm6GaXsfwk1uD3tBXS+ZjZ7dGqRgpkvpxbR
 d5o5B87lvnPiJ8OgfKSUIZ4SbTG9BJkG4WHXaJv9pERt4Kw8csXZeQ1uLvoeQsmOgzHj
 q1xEteVePiC3tDIhRcPnGYbSaL+ws4olGSX0qHkXuHVAblzxQe4tq5f8Wv4ZAFva0TDG
 gjpFa7qxiTzDNRZgH1B8GXDvnHVGPwbBoYRkM/AngnSGVDhk+3LdaWX+xxSjpKa3UTxH
 xkUmT5P9MRiNg1cGXTwsJQEfHbtedZBYNqNVpqUF+aYC2Y9l9RYO17X/I6CiQAryDBUZ 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u9nbtr03b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 00:41:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F0cLmU090469;
        Thu, 15 Aug 2019 00:41:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ucs87e73j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 00:41:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7F0ffHb018055;
        Thu, 15 Aug 2019 00:41:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 17:41:41 -0700
Date:   Wed, 14 Aug 2019 17:41:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190815004140.GE3440173@magnolia>
References: <20190813151434.GQ7138@magnolia>
 <20190813154010.GD5307@bombadil.infradead.org>
 <20190814095448.GK6129@dread.disaster.area>
 <20190814153349.GS7138@magnolia>
 <20190814212833.GO6129@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814212833.GO6129@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 07:28:33AM +1000, Dave Chinner wrote:
> On Wed, Aug 14, 2019 at 08:33:49AM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 14, 2019 at 07:54:48PM +1000, Dave Chinner wrote:
> > > On Tue, Aug 13, 2019 at 08:40:10AM -0700, Matthew Wilcox wrote:
> > > > On Tue, Aug 13, 2019 at 08:14:34AM -0700, Darrick J. Wong wrote:
> > > > > +		/*
> > > > > +		 * Now that we've locked both pages, make sure they still
> > > > > +		 * represent the data we're interested in.  If not, someone
> > > > > +		 * is invalidating pages on us and we lose.
> > > > > +		 */
> > > > > +		if (src_page->mapping != src->i_mapping ||
> > > > > +		    src_page->index != srcoff >> PAGE_SHIFT ||
> > > > > +		    dest_page->mapping != dest->i_mapping ||
> > > > > +		    dest_page->index != destoff >> PAGE_SHIFT) {
> > > > > +			same = false;
> > > > > +			goto unlock;
> > > > > +		}
> > > > 
> > > > It is my understanding that you don't need to check the ->index here.
> > > > If I'm wrong about that, I'd really appreciate being corrected, because
> > > > the page cache locking is subtle.
> > > 
> > > Ah, when talking to Darrick about this, I didn't notice the code
> > > took references on the page, so it probably doesn't need the index
> > > check - the page can't be recycled out from under us here an
> > > inserted into a new mapping until we drop the reference.
> > > 
> > > What I was mainly concerned about here is that we only have a shared
> > > inode lock on the src inode, so this code can be running
> > > concurrently with both invalidation and insertion into the mapping.
> > > e.g. direct write io does invalidation, buffered read does
> > > insertion. Hence we have to be really careful about the data in the
> > > source page being valid and stable while we run the comparison.
> > > 
> > > And on further thought, I don't think shared locking is actually
> > > safe here. A shared lock doesn't stop new direct IO from being
> > > submitted, so inode_dio_wait() just drains IO at that point in time
> > > and but doesn't provide any guarantee that there isn't concurrent
> > > DIO running.
> > > 
> > > Hence we could do the comparison here, see the data is the same,
> > > drop the page lock, a DIO write then invalidates the page and writes
> > > new data while we are comparing the rest of page(s) in the range. By
> > > the time we've checked the whole range, the data at the start is no
> > > longer the same, and the comparison is stale.
> > > 
> > > And then we do the dedupe operation oblivious to the fact the data
> > > on disk doesn't actually match anymore, and we corrupt the data in
> > > the destination file as it gets linked to mismatched data in the
> > > source file....
> > 
> > <urrrrrrk> Yeah, that looks like a bug to me.  I didn't realize that
> > directio writes were IOLOCK_SHARED and therefore reflink has to take
> > IOLOCK_EXCL to block them.
> > 
> > Related question: do we need to do the same for MMAPLOCK?  I think the
> > answer is yes because xfs_filemap_fault can call page_mkwrite with
> > MMAPLOCK_SHARED.
> 
> Hmmmm. Yes, you are right, but I don't just holding MMAPLOCK_EXCL is
> enough. Holding the MMAPLOCK will hold off page faults while we have
> the lock, but it won't prevent pages that already have writeable
> ptes from being modified as they don't require another page fault
> until they've been cleaned.
> 
> So it seems to me that if we need to ensure that the file range is
> not being concurrently modified, we have to:
> 
> 	a) inode lock exclusive
> 	b) mmap lock exclusive
> 	c) break layouts(*)
> 	d) wait for dio
> 	e) clean all the dirty pages
> 
> On both the source and destination files. And then, because the
> locks we hold form a barrier against newly dirtied pages, will all
> attempts to modify the data be blocked. And so now the data
> comparison can be done safely.

I think xfs already proceeds in this order (a-e), it's just that we
aren't correctly taking IOLOCK_EXCL/MMAPLOCK_EXCL on the source file to
prevent some other thread from starting a directio write or dirtying an
mmap'd page.  But let's try my crappy little patch that fixes the shared
locks and see what other smoke comes out of the machine...

--D

> (*) The break layouts bit is necessary to handle co-ordination with
> RDMA, NVMEoF, P2P DMA, pNFS, etc that manipulate data directly via
> the block device rather than through file pages or DIO...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
