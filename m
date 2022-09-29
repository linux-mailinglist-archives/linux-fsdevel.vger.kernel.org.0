Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5935EEB14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 03:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiI2Bpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 21:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiI2Bpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:45:38 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3966792C6;
        Wed, 28 Sep 2022 18:45:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EAC828AB76D;
        Thu, 29 Sep 2022 11:45:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1odicI-00DNpZ-1h; Thu, 29 Sep 2022 11:45:34 +1000
Date:   Thu, 29 Sep 2022 11:45:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <20220929014534.GE3600936@dread.disaster.area>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-3-david@fromorbit.com>
 <YyvaAY6UT1gKRF9U@magnolia>
 <20220923000403.GW3600936@dread.disaster.area>
 <YzPTg8jrDiNBU1N/@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzPTg8jrDiNBU1N/@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6334f8c0
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=9oVDiJGAsm_3coSZFlMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 09:54:27PM -0700, Darrick J. Wong wrote:
> On Fri, Sep 23, 2022 at 10:04:03AM +1000, Dave Chinner wrote:
> > On Wed, Sep 21, 2022 at 08:44:01PM -0700, Darrick J. Wong wrote:
> > > On Wed, Sep 21, 2022 at 06:29:59PM +1000, Dave Chinner wrote:
> > > > @@ -1182,9 +1210,26 @@ xfs_buffered_write_iomap_end(
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Check that the iomap passed to us is still valid for the given offset and
> > > > + * length.
> > > > + */
> > > > +static bool
> > > > +xfs_buffered_write_iomap_valid(
> > > > +	struct inode		*inode,
> > > > +	const struct iomap	*iomap)
> > > > +{
> > > > +	int			seq = *((int *)&iomap->private);
> > > > +
> > > > +	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
> > > > +		return false;
> > > > +	return true;
> > > > +}
> > > 
> > > Wheee, thanks for tackling this one. :)
> > 
> > I think this one might have a long way to run yet.... :/
> 
> It's gonna be a fun time backporting this all to 4.14. ;)

Hopefully it won't be a huge issue, the current code is more
contained to XFS and much less dependent on iomap iteration stuff...

> Btw, can you share the reproducer?

Not sure. The current reproducer I have is 2500 lines of complex C
code that was originally based on a reproducer the original reporter
provided. It does lots of stuff that isn't directly related to
reproducing the issue, and will be impossible to review and maintain
as it stands in fstests.

I will probably end up cutting it down to just a simple program that
reproduces the specific IO pattern that leads to the corruption
(reverse sequential non-block-aligned writes), then use the fstest
wrapper script to setup cgroup memory limits to cause writeback and
memory reclaim to race with the non-block-aligned writes. We only
need md5sums to detect corruption, so I think that the whole thing
can be done in a couple of hundred lines of shell and C code. If I
can reduce the write() IO pattern down to an xfs_io invocation,
everythign can be done directly in the fstest script...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
