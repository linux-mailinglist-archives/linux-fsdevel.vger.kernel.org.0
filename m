Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BCF1EFD6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 18:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgFEQTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 12:19:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFEQTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:19:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055GCsgS156348;
        Fri, 5 Jun 2020 16:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=aBdfKaTXhF7hzd2MYEhJyVNS1XcyS/zHMmaC1In3i5M=;
 b=dDH8AMjV0lZlpRusueChse3h0K6XZJXeIxKPgKy0najDU5cVeqrhpFVsGJ056rIrmC5M
 GUra11wjaSkG960uTWxxVHX74fZt2VOqHr4vr7JnF39jPkX5Y31UgfaZHLgC/EFaxvwx
 vPrsmIKNfuZkUGPU+9wItzoiI/RCCKHmQ7+h32P5UywNTVPMrAgmGPmoLEOJ5QTLvJse
 fAvsoMRQ+0T1D+cc4FukAcWBbV6NjDLwDnJX/kMvhS/1oYJxTMXNMzZFtNyn5LJHy/cj
 W5mCQBAtD8PlzNu36Eh0brFB6EfYbuuBE0EzZHdiBKhqJrubCkGCUIwMVrs6a6RqEqtL kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31f91dupq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 16:18:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055GIALp092154;
        Fri, 5 Jun 2020 16:18:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31f927euas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 16:18:54 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055GIru0000523;
        Fri, 5 Jun 2020 16:18:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 09:18:53 -0700
Date:   Fri, 5 Jun 2020 09:18:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200605161852.GB1334206@magnolia>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
 <20200604235050.GX19604@bombadil.infradead.org>
 <20200605003159.GX2040@dread.disaster.area>
 <20200605022451.GZ19604@bombadil.infradead.org>
 <20200605030758.GB2040@dread.disaster.area>
 <20200605124826.GF19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605124826.GF19604@bombadil.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=5 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=5 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:48:26AM -0700, Matthew Wilcox wrote:
> On Fri, Jun 05, 2020 at 01:07:58PM +1000, Dave Chinner wrote:
> > On Thu, Jun 04, 2020 at 07:24:51PM -0700, Matthew Wilcox wrote:
> > > On Fri, Jun 05, 2020 at 10:31:59AM +1000, Dave Chinner wrote:
> > > > On Thu, Jun 04, 2020 at 04:50:50PM -0700, Matthew Wilcox wrote:
> > > > > > Sure, but that's not really what I was asking: why isn't this
> > > > > > !uptodate state caught before the page fault code calls
> > > > > > ->page_mkwrite? The page fault code has a reference to the page,
> > > > > > after all, and in a couple of paths it even has the page locked.
> > > > > 
> > > > > If there's already a PTE present, then the page fault code doesn't
> > > > > check the uptodate bit.  Here's the path I'm looking at:
> > > > > 
> > > > > do_wp_page()
> > > > >  -> vm_normal_page()
> > > > >  -> wp_page_shared()
> > > > >      -> do_page_mkwrite()
> > > > > 
> > > > > I don't see anything in there that checked Uptodate.
> > > > 
> > > > Yup, exactly the code I was looking at when I asked this question.
> > > > The kernel has invalidated the contents of a page, yet we still have
> > > > it mapped into userspace as containing valid contents, and we don't
> > > > check it at all when userspace generates a protection fault on the
> > > > page?
> > > 
> > > Right.  The iomap error path only clears PageUptodate.  It doesn't go
> > > to the effort of unmapping the page from userspace, so userspace has a
> > > read-only view of a !Uptodate page.
> > 
> > Hmmm - did you miss the ->discard_page() callout just before we call
> > ClearPageUptodate() on error in iomap_writepage_map()? That results
> > in XFS calling iomap_invalidatepage() on the page, which ....
> 
> ... I don't think that's the interesting path.  I mean, that's
> the submission path, and usually we discover errors in the completion
> path, not the submission path.
> 
> > /me sighs as he realises that ->invalidatepage doesn't actually
> > invalidate page mappings but only clears the page dirty state and
> > releases filesystem references to the page.

<nod> Yes, we have preserved the old feebleness.

I've long felt that we should leave the page dirty and retry the write,
but that was objectionable because we could run out of memory and
reclaim will stall and OOM on pages it can't clean if IO is still
broken.

I can't remember the exact reasons for leaving a /clean/ page in memory,
but I think it had to do with preserving mmap'd page contents long
enough that a program could redirty the mapping <bluh bluh race
conditions><this is glitchy><blarghallthisisstupid>.

> > Yay. We leave -invalidated page cache pages- mapped into userspace,
> > and page faults on those pages don't catch access to invalidated
> > pages.
> 
> More than that ... by clearing Uptodate, you're trying to prevent
> future reads to this page from succeeding without verifying the data
> is still on storage, but a task that had it mapped before can still
> load the data that was written but never made it to storage.
> So at some point it'll teleport backwards when another task has a
> successful read().  Funfunfun.

Let's just invalidate the mapping and see if anyone complains. :D

> > Geez, we really suck at this whole software thing, don't we?
> 
> Certainly at handling errors ...
> 
> > It's not clear to me that we can actually unmap those pages safely
> > in a race free manner from this code - can we actually do that from
> > the page writeback path?
> 
> I don't see why it can't be done from the submission path.
> unmap_mapping_range() calls i_mmap_lock_write(), which is
> down_write(i_mmap_rwsem) in drag.  There might be a lock ordering
> issue there, although lockdep should find it pretty quickly.
> 
> The bigger problem is the completion path.  We're in softirq context,
> so that will have to punt to a thread that can take mutexes.

<nod> It's more workqueue punting, but I guess at least errors ought to
be infrequent.

--D
