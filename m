Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FAD58FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 03:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1Bd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 21:33:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF1Bd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:33:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S1SmAF121609;
        Fri, 28 Jun 2019 01:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iTffa50HD491h3uo63eZ68s9ZeVc6ii6J0ieF1QBP2M=;
 b=GLfhj2ca7KUob0ZvSjm06x0C65UezaKgq7GW3HhBUuzWr4YqU35pwXLgfuiZlxBAZZ51
 RjMBeTvy511th0lgsnpNUKkn1aSq7AvIl272l4m0PTlGhFuUEo8GVB+XU6WzTEY71iA8
 JLbYknd5B7vXb/qs+r0IRJHZOG/DUzjWFT/hQTWocG81R8Wr9JzWi2D83KchFVBwe82O
 rBXZesRhcafmhWKz6qxFOj6Me8ktH2eGfX4R/lBf5O6XHTqWkhKJHj+8mZzipzl+PkSf
 sLp6A7bH+K6Cd7yuKZ8ix+yca4nU52mMxXrn3AUhD6ObUNNEc/zfD6bPQauOXgPcCUHY dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtk4w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 01:33:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S1Wwj4003786;
        Fri, 28 Jun 2019 01:33:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f5apcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 01:33:00 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S1WvTF002302;
        Fri, 28 Jun 2019 01:32:57 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 18:32:56 -0700
Date:   Thu, 27 Jun 2019 18:32:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: lift the xfs writepage code into iomap v2
Message-ID: <20190628013256.GE5179@magnolia>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280008
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:48:23PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the xfs writepage code

Ok.  Patches #2 and #3 are trivial so I put them in my internal branch.

By now I'm sure everyone's noticed that I suspect that patch #7 fixes
the generic/475 crash that Eryu reported, so I've added it to my
internal branch for testing.

Patch #8 is a simple cleanup so I put that one in too.  If I notice any
problems with either of these two patches then I can always back them
out before the next push to for-next.  I'd wanted to make those cleanups
for a while and they're more or less what I would've done.

> and then lifts it to
> fs/iomap.c so that it could be use by other file system.  I've been
> wanting to this for a while so that I could eventually convert gfs2
> over to it, but I never got to it.  Now Damien has a new zonefs
> file system for semi-raw access to zoned block devices that would
> like to use the iomap code instead of reinventing it, so I finally
> had to do the work.

Sooo many conflicted feelings on this question. :)

I agree with Christoph that sharing /high quality/ code in the kernel
has served the kernel well over the years and I want that to continue.
Sharing the lower part of our writeback code so filesystems can opt out
of writing their own code to map dirty pages to storage extents and
attach them to struct bios is (I think) a good strategy.

However, I don't think sharing crap code in the kernel is serving us
well. I dislike this recent development where we decide to wire up XFS
to some new API, beat on it aggressively, and then spend months sorting
out how to make it work the way people think it does.  I do not wish to
see any of the iomap code bit rot to the point that it becomes a
nightmare to someone else.

I think Dave has voiced some valid concerns about our ability to support
this code over the long term once we start sharing it with other fses.
XFS has a longish history of sailing away from generic code so that we
can remove awkward abstractions which aren't working well for us.  If
we're going to continue to go our own way with things like file locking
and mapping I wonder how long we'd keep using the iomap ioends before
moving away again.  How well will that iomap code avoid bitrot once XFS
does that?

We are already past -rc6, so I think the second part of the series
(patches #10-13) is too late for 5.3.  I need more time to think about
how this would work out in the scenario where (a) we take on the extra
work of ensuring that our writeback improvements don't screw things up
for everyone else, or (b) we end up forking away after a while.

To be clear, I don't have a problem with the idea of iomap containing a
common ioend creation library, but I would really like to see what it
looks like to share the code with actual users.  I haven't seen any yet,
though at this early stage I am not surprised.

I think what I want to do is to proceed on a provisional basis -- create
a branch off of the next -rc1 (perhaps omitting the part that removes
xfs ioend processing) and let's see where zonedfs et. al. go from there.

How does that sound?  Who are the other potential users?

> This new version should have addressed all comments from the review,
> except that I haven't split iomap.c, which is a little too invasive
> with other pending changes to the file.  I do however offer to submit
> a split right at the end of the merge window when it is least invasive.

Already working on it, will send it tomorrow or tonight or something.

--D

> Changes since v1:
>  - rebased to the latest xfs for-next tree
>  - keep the preallocated transactions for size updates
>  - rename list_pop to list_pop_entry and related cleanups
>  - better document the nofs context handling
>  - document that the iomap tracepoints are not a stable API
