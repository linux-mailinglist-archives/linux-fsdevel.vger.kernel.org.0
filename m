Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499545757E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiGNXPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNXPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:15:24 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5833970E49
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 16:15:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id AB6FA62C65C;
        Fri, 15 Jul 2022 09:15:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oC83C-000yCP-4W; Fri, 15 Jul 2022 09:15:18 +1000
Date:   Fri, 15 Jul 2022 09:15:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: [PATCH] vf/remap: return the amount of bytes actually
 deduplicated
Message-ID: <20220714231518.GI3600936@dread.disaster.area>
References: <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
 <CAHk-=wjUw11O60KuPBpsq1-hut9-Y76puzGqvgFJr5RwUPLS_A@mail.gmail.com>
 <20220713064631.GC3600936@dread.disaster.area>
 <20220713074915.GD3600936@dread.disaster.area>
 <5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de>
 <CAHk-=wgw3mWybD3E4236sGjNdnFsR60XHKhQNe0rJW5mbhqUAA@mail.gmail.com>
 <b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de>
 <20220714223238.GH3600936@dread.disaster.area>
 <CAHk-=wh1TEGEAhj-obgjhMzDNaSxipZsdAUNS6dApt=OxktZAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1TEGEAhj-obgjhMzDNaSxipZsdAUNS6dApt=OxktZAQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62d0a389
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=gYgG_CQIOByMtlcn9XEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 03:42:13PM -0700, Linus Torvalds wrote:
> On Thu, Jul 14, 2022 at 3:32 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > Linus, can you please revert this commit for the 5.19 series (before
> > the stable autosel bot sends it back to stable kernels, please!) to
> > give us more time to investigate and consider the impact of the the
> > API change on userspace applications before we commit to changing
> > the API.
> 
> Done.

Thanks!

> That said, even from the fastest output, I have to say that the new
> behavior looks like the right one, and the old one just returned a
> fantasy that didn't actually match what the dedupe operation actually
> *did*.

Very true, and I'm definitely not arguing that the change is wrong.
We just need a bit of time to look at the various major dedupe apps
and check that they still do the right thing w.r.t. proposed change.
This late in the cycle I want to make sure we don't end up screwing
things up and creating unnecessary urgent work for anyone in the
near future...

> But leaving this for later is not a problem.

*nod*

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
