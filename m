Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBB8D740
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHNPej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 11:34:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNPej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:34:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EFYIvm192834;
        Wed, 14 Aug 2019 15:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9IqF4p5h1jCqS8rEmqMdhO7MKnvHdKzALR6Hjrvxyqw=;
 b=A9ON3LIqyNO1HX9Bhw+98JWlNd2BvmZAaiQz9PKw9jeiqA7Rz2JVxLrKrDbIxV+b5PZh
 lUafDB4Ectq82NGyrMEgtCR5h6eZd6XfU5BqlN3EgtddAvEBf3S1NJBb99nLm0GlgbNk
 D6xqkMxNgMti+KutbjaVXJRRSPfVm4/LLCwEHwL8ykG8h2EeiOd7ePmlzUrtaSXwsRi1
 64H9swAYmVo9R4kwlq4Ul+/FY1RXW8BLvzMpL13YFxtuoltJgvqoxf5y3vtsX4hLqS1o
 1iB7RaFKQ4bMzIw5Gt7aAjlfdnJQ0VNHupwcZ8bzN97R+G8OkJlqkhFUdU6fwdnklxGq IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvpdq5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 15:34:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EFXN0U001015;
        Wed, 14 Aug 2019 15:34:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2ubwcy5jyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 15:34:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EFXobL026332;
        Wed, 14 Aug 2019 15:33:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 08:33:50 -0700
Date:   Wed, 14 Aug 2019 08:33:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190814153349.GS7138@magnolia>
References: <20190813151434.GQ7138@magnolia>
 <20190813154010.GD5307@bombadil.infradead.org>
 <20190814095448.GK6129@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814095448.GK6129@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 07:54:48PM +1000, Dave Chinner wrote:
> On Tue, Aug 13, 2019 at 08:40:10AM -0700, Matthew Wilcox wrote:
> > On Tue, Aug 13, 2019 at 08:14:34AM -0700, Darrick J. Wong wrote:
> > > +		/*
> > > +		 * Now that we've locked both pages, make sure they still
> > > +		 * represent the data we're interested in.  If not, someone
> > > +		 * is invalidating pages on us and we lose.
> > > +		 */
> > > +		if (src_page->mapping != src->i_mapping ||
> > > +		    src_page->index != srcoff >> PAGE_SHIFT ||
> > > +		    dest_page->mapping != dest->i_mapping ||
> > > +		    dest_page->index != destoff >> PAGE_SHIFT) {
> > > +			same = false;
> > > +			goto unlock;
> > > +		}
> > 
> > It is my understanding that you don't need to check the ->index here.
> > If I'm wrong about that, I'd really appreciate being corrected, because
> > the page cache locking is subtle.
> 
> Ah, when talking to Darrick about this, I didn't notice the code
> took references on the page, so it probably doesn't need the index
> check - the page can't be recycled out from under us here an
> inserted into a new mapping until we drop the reference.
> 
> What I was mainly concerned about here is that we only have a shared
> inode lock on the src inode, so this code can be running
> concurrently with both invalidation and insertion into the mapping.
> e.g. direct write io does invalidation, buffered read does
> insertion. Hence we have to be really careful about the data in the
> source page being valid and stable while we run the comparison.
> 
> And on further thought, I don't think shared locking is actually
> safe here. A shared lock doesn't stop new direct IO from being
> submitted, so inode_dio_wait() just drains IO at that point in time
> and but doesn't provide any guarantee that there isn't concurrent
> DIO running.
> 
> Hence we could do the comparison here, see the data is the same,
> drop the page lock, a DIO write then invalidates the page and writes
> new data while we are comparing the rest of page(s) in the range. By
> the time we've checked the whole range, the data at the start is no
> longer the same, and the comparison is stale.
> 
> And then we do the dedupe operation oblivious to the fact the data
> on disk doesn't actually match anymore, and we corrupt the data in
> the destination file as it gets linked to mismatched data in the
> source file....

<urrrrrrk> Yeah, that looks like a bug to me.  I didn't realize that
directio writes were IOLOCK_SHARED and therefore reflink has to take
IOLOCK_EXCL to block them.

Related question: do we need to do the same for MMAPLOCK?  I think the
answer is yes because xfs_filemap_fault can call page_mkwrite with
MMAPLOCK_SHARED.

--D

> Darrick?
> 
> > You call read_mapping_page() which returns the page with an elevated
> > refcount.  That means the page can't go back to the page allocator and
> > be allocated again.  It can, because it's unlocked, still be truncated,
> > so the check for ->mapping after locking it is needed.  But the check
> > for ->index being correct was done by find_get_entry().
> > 
> > See pagecache_get_page() -- if we specify FGP_LOCK, then it will lock
> > the page, check the ->mapping but not check ->index.  OK, it does check
> > ->index, but in a VM_BUG_ON(), so it's not something that ought to be
> > able to be wrong.
> 
> Yeah, we used to have to play tricks in the old XFS writeback
> clustering code to do our own non-blocking page cache lookups adn
> this was one of the things we needed to be careful about until
> the pagevec_lookup* interfaces came along and solved all the
> problems for us. Funny how the brain remembers old gotchas with
> also reminding you that the problems went away almost as long
> ago.....
> 
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
