Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8F595848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiHPK3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiHPK3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:29:00 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D01D65E309;
        Tue, 16 Aug 2022 02:03:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7B45B62D403;
        Tue, 16 Aug 2022 19:03:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oNsTg-00Dk22-Ca; Tue, 16 Aug 2022 19:03:12 +1000
Date:   Tue, 16 Aug 2022 19:03:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Message-ID: <20220816090312.GU3600936@dread.disaster.area>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
 <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain>
 <YuXyKh8Zvr56rR4R@google.com>
 <YvrrEcw4E+rpDLwM@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvrrEcw4E+rpDLwM@sol.localdomain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62fb5d51
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8
        a=0f_GdJSvYQN_4D2ffm4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:55:45PM -0700, Eric Biggers wrote:
> On Sat, Jul 30, 2022 at 08:08:26PM -0700, Jaegeuk Kim wrote:
> > On 07/25, Eric Biggers wrote:
> > > On Sat, Jul 23, 2022 at 07:01:59PM -0700, Jaegeuk Kim wrote:
> > > > On 07/22, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > Currently, if an f2fs filesystem is mounted with the mode=lfs and
> > > > > io_bits mount options, DIO reads are allowed but DIO writes are not.
> > > > > Allowing DIO reads but not DIO writes is an unusual restriction, which
> > > > > is likely to be surprising to applications, namely any application that
> > > > > both reads and writes from a file (using O_DIRECT).  This behavior is
> > > > > also incompatible with the proposed STATX_DIOALIGN extension to statx.
> > > > > Given this, let's drop the support for DIO reads in this configuration.
> > > > 
> > > > IIRC, we allowed DIO reads since applications complained a lower performance.
> > > > So, I'm afraid this change will make another confusion to users. Could
> > > > you please apply the new bahavior only for STATX_DIOALIGN?
> > > > 
> > > 
> > > Well, the issue is that the proposed STATX_DIOALIGN fields cannot represent this
> > > weird case where DIO reads are allowed but not DIO writes.  So the question is
> > > whether this case actually matters, in which case we should make STATX_DIOALIGN
> > > distinguish between DIO reads and DIO writes, or whether it's some odd edge case
> > > that doesn't really matter, in which case we could just fix it or make
> > > STATX_DIOALIGN report that DIO is unsupported.  I was hoping that you had some
> > > insight here.  What sort of applications want DIO reads but not DIO writes?
> > > Is this common at all?
> > 
> > I think there's no specific application to use the LFS mode at this
> > moment, but I'd like to allow DIO read for zoned device which will be
> > used for Android devices.
> > 
> 
> So if the zoned device feature becomes widely adopted, then STATX_DIOALIGN will
> be useless on all Android devices?  That sounds undesirable.  Are you sure that
> supporting DIO reads but not DIO writes actually works?  Does it not cause
> problems for existing applications?

What purpose does DIO in only one direction actually serve? All it
means is that we're forcibly mixing buffered and direct IO to the
same file and that simply never ends well from a data coherency POV.

Hence I'd suggest that mixing DIO reads and buffered writes like
this ends up exposing uses to the worst of both worlds - all of the
problems with none of the benefits...

> What we need to do is make a decision about whether this means we should build
> in a stx_dio_direction field (indicating no support / readonly support /
> writeonly support / readwrite support) into the API from the beginning.  If we
> don't do that, then I don't think we could simply add such a field later, as the
> statx_dio_*_align fields will have already been assigned their meaning.  I think
> we'd instead have to "duplicate" the API, with STATX_DIOROALIGN and
> statx_dio_ro_*_align fields.  That seems uglier than building a directional
> indicator into the API from the beginning.  On the other hand, requiring all
> programs to check stx_dio_direction would add complexity to using the API.
> 
> Any thoughts on this?

Decide whether partial, single direction DIO serves a useful purpose
before trying to work out what is needed in the API to indicate that
this sort of crazy will be supported....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
