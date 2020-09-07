Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC325F14F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 02:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIGA4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 20:56:47 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:49802 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgIGA4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 20:56:46 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 46221824E4D;
        Mon,  7 Sep 2020 10:56:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kF5Sc-0007Em-Bm; Mon, 07 Sep 2020 10:56:42 +1000
Date:   Mon, 7 Sep 2020 10:56:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Support for I/O to a bitbucket
Message-ID: <20200907005642.GN12096@dread.disaster.area>
References: <20200818172231.GU17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818172231.GU17456@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=Ef7kLf-3TfD9jEVqzc4A:9 a=2NErrjxDFYTfbisk:21 a=r9V8D18BDwGW_k-_:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 06:22:31PM +0100, Matthew Wilcox wrote:
> One of the annoying things in the iomap code is how we handle
> block-misaligned I/Os.  Consider a write to a file on a 4KiB block size
> filesystem (on a 4KiB page size kernel) which starts at byte offset 5000
> and is 4133 bytes long.
> 
> Today, we allocate page 1 and read bytes 4096-8191 of the file into
> it, synchronously.  Then we allocate page 2 and read bytes 8192-12287
> into it, again, synchronously.  Then we copy the user's data into the
> pagecache and mark it dirty.  This is a fairly significant delay for
> the user who normally sees the latency of a memcpy() now has to wait
> for two non-overlapping reads to complete.
> 
> What I'd love to be able to do is allocate pages 1 & 2, copy the user
> data into it and submit one read which targets:
> 
> 0-903: page 1, offset 0, length 904
> 904-5036: bitbucket, length 4133
> 5037-8191: page 2, offset 942, length 3155
> 
> That way, we don't even need to wait for the read to complete.

I'm not sure that offloading the page cache's job of isolating
unaligned IO from the block layer to the block layer is the write
way to do this.

Essentially you are moving the RMW down in the block layer where it
will have to allocate memory to do IO on sector based boundaries so
it doesn't trash the data you've already copied into the pages in
the bio.

Either way, you need a secondary buffer to do this - one for the
read IO to DMA into with sector alignment, the other to contain the
user data that is sungle byte aligned.

This seems to me like it could be done entirely at the iomap level
just by linking the async read IO buffer back to the page cache page
and holding the "data to copy in" state in a struct attached to the
async IO buffer's page->private. It adds a little complexity to the
read IO completion (i.e. iomap_read_finish()), but it's no worse
than anything we do with write IO completions...

And if the two pages are adjacent like the above, it could be done
with a single async reads, or even two separate async reads that
get merged into one IO at the block layer via plugging...

> Anyway, I don't have time to take on this work, but I thought I'd throw
> it out in case anyone's looking for a project.  Or if it's a stupid idea,
> someone can point out why.

I think it's pretty straight forward to do it in the iomap layer...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
