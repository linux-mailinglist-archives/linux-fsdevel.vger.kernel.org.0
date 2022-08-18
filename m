Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF35597C53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbiHRDhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 23:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHRDhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:37:37 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 702A55D126;
        Wed, 17 Aug 2022 20:37:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 892A962D863;
        Thu, 18 Aug 2022 13:37:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOWLb-00ERbm-EL; Thu, 18 Aug 2022 13:37:31 +1000
Date:   Thu, 18 Aug 2022 13:37:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jlayton@kernel.org" <jlayton@kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220818033731.GF3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
 <20220816224257.GV3600936@dread.disaster.area>
 <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61568de755fc9cd70c80c23d63c457918ab4643.camel@hammerspace.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62fdb3ff
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=L7LhDfuEwgk5s5nEfRgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 01:11:09AM +0000, Trond Myklebust wrote:
> On Wed, 2022-08-17 at 08:42 +1000, Dave Chinner wrote:
> > 
> > In XFS, we've defined the on-disk i_version field to mean
> > "increments with any persistent inode data or metadata change",
> > regardless of what the high level applications that use i_version
> > might actually require.
> > 
> > That some network filesystem might only need a subset of the
> > metadata to be covered by i_version is largely irrelevant - if we
> > don't cover every persistent inode metadata change with i_version,
> > then applications that *need* stuff like atime change notification
> > can't be supported.
> 
> OK, I'll bite...
> 
> What real world application are we talking about here, and why can't it
> just read both the atime + i_version if it cares?

The whole point of i_version is that the aplication can skip the
storage and comparison of individual metadata fields to determine if
anythign changed. If you're going to store multiple fields and
compare them all in addition to the change attribute, then what is
the change attribute actually gaining you?

> The value of the change attribute lies in the fact that it gives you
> ctime semantics without the time resolution limitation.
> i.e. if the change attribute has changed, then you know that someone
> has explicitly modified either the file data or the file metadata (with
> the emphasis being on the word "explicitly").
> Implicit changes such as the mtime change due to a write are reflected
> only because they are necessarily also accompanied by an explicit
> change to the data contents of the file.
> Implicit changes, such as the atime changes due to a read are not
> reflected in the change attribute because there is no explicit change
> being made by an application.

That's the *NFSv4 requirements*, not what people were asking XFS to
support in a persistent change attribute 10-15 years ago. What NFS
required was just one of the inputs at the time, and what we
implemented has kept NFSv4 happy for the past decade. I've mentioned
other requirements elsewhere in the thread.

The problem we're talking about here is essentially a relatime
filtering issue; it's triggering an filesystem update because the
first access after a modification triggers an on-disk atime update
rahter than just storing it in memory.

This is not a filesystem issue - the VFS controls when the on-disk
updates occur, and that what NFSv4 appears to need changed.
If NFS doesn't want the filesystem to bump change counters for
on-disk atime updates, then it should be asking the VFS to keep the
atime updates in memory. e.g. use lazytime semantics.

This way, every filesystem will have the same behaviour, regardless
of how they track/store persistent change count metadata.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
