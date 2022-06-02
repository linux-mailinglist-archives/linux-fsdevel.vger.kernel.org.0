Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721153C09F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 00:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiFBWIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 18:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239545AbiFBWIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:08:00 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9347CE28;
        Thu,  2 Jun 2022 15:07:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A7A3010E6F2A;
        Fri,  3 Jun 2022 08:07:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwsyy-001xAy-Vm; Fri, 03 Jun 2022 08:07:57 +1000
Date:   Fri, 3 Jun 2022 08:07:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <20220602220756.GH1098723@dread.disaster.area>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
 <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <0B09932C-66FB-4ED9-8CF1-006EEC522E6B@fb.com>
 <YpkWhZmM1OOqEW4C@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YpkWhZmM1OOqEW4C@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=629934be
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=ufHFDILaAAAA:8 a=7-415B0cAAAA:8
        a=0qgzfhI4ut9e49UDcLwA:9 a=QEXdDO2ut3YA:10 a=ZmIg1sZ3JBWsdXgziEIF:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 08:59:01PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 02, 2022 at 07:41:55PM +0000, Chris Mason wrote:
> > 
> > > On Jun 2, 2022, at 11:32 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > 
> > > On Thu, Jun 02, 2022 at 04:52:52PM +1000, Dave Chinner wrote:
> > >> 
> > >> Further, I don't think we need to invalidate the folio, either. If
> > >> it's beyond EOF, then it is because a truncate is in progress that
> > >> means it is somebody else's problem to clean up. Hence we should
> > >> leave it to the truncate to deal with, just like the pre-2013 code
> > >> did....
> > > 
> > > Perfect, that works.
> > 
> > Ok, I’ll run it through xfstests and resend a v2.  Will this cover all of the subpage blocksize concerns?
> 
> I run with:
> export MKFS_OPTIONS="-m reflink=1,rmapbt=1 -i sparse=1 -b size=1024"
> 
> Dave may have other options he'd like to see.

No, that above is what I'd suggest.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
