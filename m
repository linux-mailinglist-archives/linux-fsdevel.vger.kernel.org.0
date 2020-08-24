Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAE2501B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXQGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 12:06:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53698 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgHXQGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:06:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OG4TiO109651;
        Mon, 24 Aug 2020 16:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B8afCU0kqYEurujCqEA3axmicCMwLxa8fetgaydR9hw=;
 b=CVoTKKGKwsJdhDndTow7kPrccrclOJDJOT/x06z6F+wgWEE8GUS6h1h2X233NbuK7HXr
 UBDPO4zDzf+cA8T448kv85s23BPg8egW0mlP2FWLvN2NrWdb+s/ZCJqFHaJOftUgbn/9
 DomkW/ohRoEb9dm2DZlDspt1pZY9OM3gkX7QAF38Xp4rWokii2CvEhw4t5s7Aj3b8VS2
 7jtpmIKAfopvWsIT9AVYprMYRudu+byi4BCcdbBx6R2f76Tgunf5wV8NWeX89/PjTnpW
 tGuYn6+il/GvAEX3BGhQB3NtbQM8aRM1ChEPkgsMHZCSanL1dign/hPcy2WVDupY1fxd Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 333cshwgmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 16:06:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OG5Hds031425;
        Mon, 24 Aug 2020 16:06:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 333r9heywn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 16:06:17 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07OG6Gwa028592;
        Mon, 24 Aug 2020 16:06:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 09:06:16 -0700
Date:   Mon, 24 Aug 2020 09:06:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, david@fromorbit.com,
        yukuai3@huawei.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Splitting an iomap_page
Message-ID: <20200824160614.GO6107@magnolia>
References: <20200821144021.GV17456@casper.infradead.org>
 <20200822060618.GE17129@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822060618.GE17129@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=2 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=2 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 22, 2020 at 07:06:18AM +0100, Christoph Hellwig wrote:
> On Fri, Aug 21, 2020 at 03:40:21PM +0100, Matthew Wilcox wrote:
> > I have only bad ideas for solving this problem, so I thought I'd share.
> > 
> > Operations like holepunch or truncate call into
> > truncate_inode_pages_range() which just remove THPs which are
> > entirely within the punched range, but pages which contain one or both
> > ends of the range need to be split.
> > 
> > What I have right now, and works, calls do_invalidatepage() from
> > truncate_inode_pages_range().  The iomap implementation just calls
> > iomap_page_release().  We have the page locked, and we've waited for
> > writeback to finish, so there is no I/O outstanding against the page.
> > We may then get into one of the writepage methods without an iomap being
> > allocated, so we have to allocate it.  Patches here:
> > 
> > http://git.infradead.org/users/willy/pagecache.git/commitdiff/167f81e880ef00d83ab7db50d56ed85bfbae2601
> > http://git.infradead.org/users/willy/pagecache.git/commitdiff/82fe90cde95420c3cf155b54ed66c74d5fb6ffc5
> > 
> > If the page is Uptodate, this works great.  But if it's not, then we're
> > going to unnecessarily re-read data from storage -- indeed, we may as
> > well just dump the entire page if it's !Uptodate.  Of course, right now
> > the only way to get THPs is through readahead and that's going to always
> > read the entire page, so we're never going to see a !Uptodate THP.  But
> > in the future, maybe we shall?  I wouldn't like to rely on that without
> > pasting some big warnings for anyone who tries to change it.
> > 
> > Alternative 1: Allocate a new iop for each base page if needed.  This is
> > the obvious approach.  If the block size is >= PAGE_SIZE, we don't even
> > need to allocate a new iop; we can just mark the page as being Uptodate
> > if that range is.  The problem is that we might need to allocate a lot of
> > them -- 512 if we're splitting a 2MB page into 4kB chunks (which would
> > be 12kB -- plus a 2kB array to hold 512 pointers).  And at the point
> > where we know we need to allocate them, we're under a spin_lock_irq().
> > We could allocate them in advance, but then we might find out we aren't
> > going to split this page after all.
> > 
> > Alternative 2: Always allocate an iop for each base page in a THP.  We pay
> > the allocation price up front for every THP, even though the majority
> > will never be split.  It does save us from allocating any iop at all for
> > block size >= page size, but it's a lot of extra overhead to gather all
> > the Uptodate bits.  As above, it'd be 12kB of iops vs 80 bytes that we
> > currently allocate for a 2MB THP.  144 once we also track dirty bits.
> > 
> > Alternative 3: Allow pages to share an iop.  Do something like add a
> > pgoff_t base and a refcount_t to the iop and have each base page point
> > to the same iop, using the part of the bit array indexed by (page->index
> > - base) * blocks_per_page.  The read/write count are harder to share,
> > and I'm not sure I see a way to do it.
> > 
> > Alternative 4: Don't support partially-uptodate THPs.  We declare (and
> > enforce with strategic assertions) that all THPs must always be Uptodate
> > (or Error) once unlocked.  If your workload benefits from using THPs,
> > you want to do big I/Os anyway, so these "write 512 bytes at a time
> > using O_SYNC" workloads aren't going to use THPs.
> > 
> > Funnily, buffer_heads are easier here.  They just need to be reparented
> > to their new page.  Of course, they're allocated up front, so they're
> > essentially alternative 2.
> 
> At least initially I'd go for 4.  And then see if someone screams loudly
> enough to reconsider.  And if we really have to I wonder if we can do
> a variation of variant 1 where we avoid allocating under the irqs
> disabled spinlock by a clever retry trick.

/me doesn't have any objection to #4, and bets #1 and #3 will probably
lead to weird problems /somewhere/ ;)

--D
