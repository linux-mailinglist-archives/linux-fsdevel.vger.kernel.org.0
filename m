Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78FCBD4DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 00:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405087AbfIXWYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 18:24:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35260 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbfIXWYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 18:24:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OLxmTP104494;
        Tue, 24 Sep 2019 22:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WCg8CK8lWdtRYaIcgzqcnsusbOJTcVFGgkO6t2EG+yM=;
 b=TH0vkSgaVbdxJ4htA7j/eU4CoH5fDJ6p+VtmqQ4waz0NODS3hQDMUA4w1mRJSmm1uzMw
 /Ugg2Z6l5c87eWnHiNiA0ZLk+VUyvRh8IzdHKJ5Be+wk/sYp3KZ9INQKYknE7lpoymDj
 jEFg8CzdInss05LIgC81XalDPsg3dD432VNBULeKRHnYqiQi0/t6CfFSgm9bwT3q8iZl
 PUYFAbDoDmo/6RthhD2XWmJzFhEEzwPcTDqqc+wKOYPflaS2wNvmX8kkgy0u+EOovCdC
 lIvZJB7nHlngQJ7Q9/MRCYWpPwM/r5oLsN1+FRR3gj9tK/VsU5AteBT8SKlSwRhM2cfm Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v5cgr111h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 22:23:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OLxWpG053203;
        Tue, 24 Sep 2019 22:21:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v6yvptu7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 22:21:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8OML5SN017569;
        Tue, 24 Sep 2019 22:21:06 GMT
Received: from localhost (/10.159.232.132)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 15:21:05 -0700
Date:   Tue, 24 Sep 2019 15:21:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, dsterba@suse.cz,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190924222103.GB2229799@magnolia>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz>
 <20190923175146.GT2229799@magnolia>
 <172b2ed8-f260-6041-5e10-502d1c91f88c@suse.cz>
 <20190924215353.GG16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924215353.GG16973@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240178
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 07:53:53AM +1000, Dave Chinner wrote:
> On Tue, Sep 24, 2019 at 11:19:29PM +0200, Vlastimil Babka wrote:
> > On 9/23/19 7:51 PM, Darrick J. Wong wrote:
> > > On Mon, Sep 23, 2019 at 07:17:10PM +0200, David Sterba wrote:
> > >> On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> > >>> So if anyone thinks this is a good idea, please express it (preferably
> > >>> in a formal way such as Acked-by), otherwise it seems the patch will be
> > >>> dropped (due to a private NACK, apparently).
> > > 
> > > Oh, I didn't realize  ^^^^^^^^^^^^ that *some* of us are allowed the
> > > privilege of gutting a patch via private NAK without any of that open
> > > development discussion incovenience. <grumble>
> > > 
> > > As far as XFS is concerned I merged Dave's series that checks the
> > > alignment of io memory allocations and falls back to vmalloc if the
> > > alignment won't work, because I got tired of scrolling past the endless
> > > discussion and bug reports and inaction spanning months.
> > 
> > I think it's a big fail of kmalloc API that you have to do that, and
> > especially with vmalloc, which has the overhead of setting up page
> > tables, and it's a waste for allocation requests smaller than page size.
> > I wish we could have nice things.
> 
> I don't think the problem here is the code. The problem here is that
> we have a dysfunctional development community and there are no
> processes we can follow to ensure architectural problems in core
> subsystems are addressed in a timely manner...
> 
> And this criticism isn't just of the mm/ here - this alignment
> problem is exacerbated by exactly the same issue on the block layer
> side. i.e. the block layer and drivers have -zero- bounds checking
> to catch these sorts of things and the block layer maintainer will
> not accept patches for runtime checks that would catch these issues
> and make them instantly visible to us.
> 
> These are not code problems: we can fix the problems with code (and
> I have done so to demonstrate "this is how we do what you say is
> impossible").  The problem here is people in positions of
> control/power are repeatedly demonstrating an inability to
> compromise to reach a solution that works for everyone.
> 
> It's far better for us just to work around bullshit like this in XFS
> now, then when the core subsystems get they act together years down
> the track we can remove the workaround from XFS. Users don't care
> how we fix the problem, they just want it fixed. If that means we
> have to route around dysfunctional developer groups, then we'll just
> have to do that....

Seconded.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
