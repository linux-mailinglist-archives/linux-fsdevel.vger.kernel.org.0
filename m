Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE14A15DE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEGHK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 03:10:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47461 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfEGHK2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 03:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9728B5BA;
        Tue,  7 May 2019 07:10:27 +0000 (UTC)
Received: from work (unknown [10.40.205.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E44461B67;
        Tue,  7 May 2019 07:10:26 +0000 (UTC)
Date:   Tue, 7 May 2019 09:10:21 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Testing devices for discard support properly
Message-ID: <20190507071021.wtm25mxx2as6babr@work>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 07 May 2019 07:10:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
> 
> (repost without the html spam, sorry!)
> 
> Last week at LSF/MM, I suggested we can provide a tool or test suite to test
> discard performance.
> 
> Put in the most positive light, it will be useful for drive vendors to use
> to qualify their offerings before sending them out to the world. For
> customers that care, they can use the same set of tests to help during
> selection to weed out any real issues.
> 
> Also, community users can run the same tools of course and share the
> results.
> 
> Down to the questions part:
> 
>  * Do we just need to figure out a workload to feed our existing tools like
> blkdiscard and fio?

Hi Ric,

I think being able to specify workload using fio will be very useful
regardless if we'll end up with with a standalone discard testing tool
or not.

> 
> * What workloads are key?
> 
> Thoughts about what I would start getting timings for:

A long time ago I wrote a tool for testing discaed performance. You can
find it here. Keep in mind that it was really long time ago since I even
looked at it, so not sure if it still even compiles.

https://sourceforge.net/projects/test-discard/

You can go through the README file to see what it does but in summary
you can:

- specify size of discard request
- specify range of discard request size to test
- discard already discarded blocks
- can test with sequential or random pattern
- for every discard request size tested it will give you results like

<record_size> <total_size> <min> <max> <avg> <sum> <throughput in MB/s>

> 
> * Whole device discard at the block level both for a device that has been
> completely written and for one that had already been trimmed

Yes, usefull. Also note that a long time ago when I've done the testing
I noticed that after a discard request, especially after whole device
discard, the read/write IO performance went down significanly for some
drives. I am sure things have changed, but I think it would be
interesting to see how does it behave now.

> 
> * Discard performance at the block level for 4k discards for a device that
> has been completely written and again the same test for a device that has
> been completely discarded.
> 
> * Same test for large discards - say at a megabyte and/or gigabyte size?

From my testing (again it was long time ago and things probably changed
since then) most of the drives I've seen had largely the same or similar
timing for discard request regardless of the size (hence, the conclusion
was the bigger the request the better). A small variation I did see
could have been explained by kernel implementation and discard_max_bytes
limitations as well.

> 
> * Same test done at the device optimal discard chunk size and alignment
> 
> Should the discard pattern be done with a random pattern? Or just
> sequential?

I think that all of the above will be interesting. However there are two
sides of it. One is just pure discard performance to figure out what
could be the expectations and the other will be "real" workload
performance. Since from my experience discard can have an impact on
drive IO performance beyond of what's obvious, testing mixed workload
(IO + discard) is going to be very important as well. And that's where
fio workloads can come in (I actually do not know if fio already
supports this or not).

-Lukas

> 
> I think the above would give us a solid base, thoughts or comments?
> 
> Thanks!
> 
> Ric
> 
> 
> 
> 
