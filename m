Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E7123C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLRBZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:25:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfLRBZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:25:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1JhJl017398;
        Wed, 18 Dec 2019 01:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CPrPTKGRWbte5d18j8OyziiV63P7dvuHEgE/Q71iwPA=;
 b=OGVchsZMv9g7X7LtF9Ayc6TQeIzSwqUHV2M1v9QCjLQktykMPgCbuEff9XcFGhlcZpCX
 MCy43T5fy/GKyMhvLbGS/1Fr3kmuh6XYWC+7liKOtWIisa/Dy/d5MUdefDhjx7Ikz3eW
 YpqZaMm1TeG4DdXAnnwm1PDcLxxumA/3h3jjY+hJ+bgdItMf11SQ92Uz+llhN8z3WrU3
 1GvgkITmE1RLWWp3HvW17qfLExEItakRW+8zb0Rqb5lRULcloz7YEVjNihm0n6N2eiPH
 AKF7a/m7vfZC7TSIPeGPISq6ReJbWlVS5nXXe1hC+7RMUr7e7HS3039exUEy9jizGNQo HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wvqpqacgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1MtxK037321;
        Wed, 18 Dec 2019 01:25:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wxm74v2j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:25:20 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBI1PIQ4003591;
        Wed, 18 Dec 2019 01:25:19 GMT
Received: from localhost (/10.159.137.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 17:25:17 -0800
Date:   Tue, 17 Dec 2019 17:25:16 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/6] iomap: add struct iomap_ctx
Message-ID: <20191218012516.GA12752@magnolia>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-5-axboe@kernel.dk>
 <CAHk-=wgcPAfOSigMf0xwaGfVjw413XN3UPATwYWHrss+QuivhQ@mail.gmail.com>
 <CAHk-=wgvROUnrEVADVR_zTHY8NmYo-_jVjV37O1MdDm2de+Lmw@mail.gmail.com>
 <9941995e-19c5-507b-9339-b8d2cb568932@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9941995e-19c5-507b-9339-b8d2cb568932@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:15:46PM -0700, Jens Axboe wrote:
> On 12/17/19 1:26 PM, Linus Torvalds wrote:
> > On Tue, Dec 17, 2019 at 11:39 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> 'loff_t length' is not right.
> > 
> > Looking around, it does seem to get used that way. Too much, though.
> > 
> >>> +       loff_t pos = data->pos;
> >>> +       loff_t length = pos + data->len;
> >>
> >> And WTH is that? "pos + data->len" is not "length", that's end. And this:
> >>
> >>>         loff_t end = pos + length, done = 0;
> >>
> >> What? Now 'end' is 'pos+length', which is 'pos+pos+data->len'.
> > 
> > But this is unrelated to the crazy types. That just can't bve right.
> 
> Yeah, I fixed that one up, that was my error.
> 
> >> Is there some reason for this horrible case of "let's allow 64-bit sizes?"
> >>
> >> Because even if there is, it shouldn't be "loff_t". That's an
> >> _offset_. Not a length.
> > 
> > We do seem to have a lot of these across filesystems. And a lot of
> > confusion. Most of the IO reoutines clearly take or return a size_t
> > (returning ssize_t) as the IO size. And then you have the
> > zeroing/truncation stuff that tends to take loff_t. Which still smells
> > wrong, and s64 would look like a better case, but whatever.
> > 
> > The "iomap_zero_range() for truncate" case really does seem to need a
> > 64-bit value, because people do the difference of two loff_t's for it.
> > In fact, it almost looks like that function should take a "start ,
> > end" pair, which would make loff_t be the _right_ thing.

Yeah.  "loff_t length" always struck me as a little odd, but until now I
hadn't heard enough complaining about it to put any effort into fixing
the iomap_apply code that (afaict) mostly worked ok.  But it shouldn't
be a difficult change.

> > Because "length" really is just (a positive) size_t normally.

However, I don't think it's a good idea to reduce the @length argument
to size_t (and the iomap_apply return value to ssize_t) because they're
32-bit values and doing that will force iomap to clamp lengths and
return values to S32_MAX.  Instituting a ~2G max on read and write calls
is fine because those operate directly on file data (== slow), but the
vfs already clamps the length before the iov gets to iomap.

For the other iomap users that care more about the mappings and less
about the data in those mappings (seek hole, seek data, fiemap, swap) it
doesn't make much sense.  If the filesystem can send back a 100GB extent
map (e.g. holes in a sparse file, or we just have superstar allocation
strategies), the fs should send that straight to the iomap actor
function without having to cut that into 50x loop iterations.  Looking
ahead to things like file mapping leases, a (formerly wealthy) client
should be able to request a mmap lease on 100GB worth of pmem and get
the whole lease if the fs can allocate 100G at once.

I like the idea of making the length parameter and the return value
int64_t instead of loff_t.  Is int64_t the preferred typedef or s64?  I
forget.

> Honestly, I'd much rather leave the loff_t -> size_t/ssize_t to
> Darrick/Dave, it's really outside the scope of this patch, and I'd
> prefer not to have to muck with it. They probably feel the same way!

Don't forget Christoph.  Heh, we /did/ forget Christoph. :(
Maybe they have better historical context since they invented this iomap
mechanism for pnfs or something long before I came along.

--D

> -- 
> Jens Axboe
> 
