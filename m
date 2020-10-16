Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5419D290DF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406696AbgJPXDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 19:03:36 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54357 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404054AbgJPXDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:03:35 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7BEC73AABAC;
        Sat, 17 Oct 2020 10:03:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kTYkz-001HaQ-Bz; Sat, 17 Oct 2020 10:03:29 +1100
Date:   Sat, 17 Oct 2020 10:03:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Qian Cai <cai@lca.pw>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20201016230329.GC7322@dread.disaster.area>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <20201016181908.GA282856@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016181908.GA282856@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=7-415B0cAAAA:8
        a=2Er5gBTTgXofXWECVHgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 02:19:08PM -0400, Vivek Goyal wrote:
> On Thu, Oct 15, 2020 at 02:21:58PM -0700, Linus Torvalds wrote:
> 
> [..]
> > 
> > I don't know why fuse does multiple pages to begin with. Why can't it
> > do whatever it does just one page at a time?
> 
> Sending multiple pages in single WRITE command does seem to help a lot
> with performance. I modified code to write only one page at a time
> and ran a fio job with sequential writes(and random writes),
> block size 64K and compared the performance on virtiofs.
> 
> NAME                    WORKLOAD                Bandwidth       IOPS
> one-page-write          seqwrite-psync          58.3mb          933
> multi-page-write        seqwrite-psync          265.7mb         4251
> 
> one-page-write          randwrite-psync         53.5mb          856
> multi-page-write        randwrite-psync         315.5mb         5047
> 
> So with multi page writes performance seems much better for this
> particular workload.

Huh. This is essentially the problem the iomap buffered write path
was designed to solve.  Filesystems like gfs2 got similar major
improvements in large buffered write throughput when switching to
use iomap for buffered IO....

Essentially, it works by having iomap_apply() first ask the
filesystem to map the IO range, then iterates the page cache across
the io range performing the desired operation (iomap_write_actor()
in the case of a buffered write), then it tells the filesystem how
much of the original range it completed copying into the cache.

Hence the filesystem only does one mapping/completion operation per
contiguous IO range instead of once per dirtied page, and the inner
loop just locks a page at a time as it works over the range.  Pages
are marked uptodate+dirty as the user data is copied into them, not
when the entire IO is completely written.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
