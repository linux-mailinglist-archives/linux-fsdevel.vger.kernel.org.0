Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7C597B1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiHRBc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 21:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiHRBcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:32:55 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7E24A1D5F;
        Wed, 17 Aug 2022 18:32:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 92D9710E967D;
        Thu, 18 Aug 2022 11:32:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOUOx-00EPVF-9C; Thu, 18 Aug 2022 11:32:51 +1000
Date:   Thu, 18 Aug 2022 11:32:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220818013251.GC3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
 <20220816224257.GV3600936@dread.disaster.area>
 <166078288043.5425.8131814891435481157@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166078288043.5425.8131814891435481157@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62fd96c6
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=nA8wMrABTE87hgugSQkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:34:40AM +1000, NeilBrown wrote:
> On Wed, 17 Aug 2022, Dave Chinner wrote:
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
> So what you are saying is that the i_version provided by XFS does not
> match the changeid semantics required by NFSv4.  Fair enough.  I guess
> we shouldn't use the one to implement the other then.

True, but there's more nuance to it than that. We can already
provide the NFSv4 requirements without filesystem modification -
just mount the filesytsem with "-o lazytime".

There's *always* a difference between what the filesystem implements
and what an application require. The filesystem implements what the
VFS asks it to do, not what the application needs. The VFS provides
the functionality they applications require, not the filesystems.

atime update filtering has long been VFS functionality - we do it
there so behaviour is common across all filesystems. Therefore, if
the NFS application wants atime to always behave as if lazytime is
enabled, that filtering should be done at the VFS atime filtering
layer.

Why should we duplicate VFS atime update filtering in every
filesystem for the default relatime behaviour when the VFS lazytime
filter already provides this filtering function to everyone?

> Maybe we should just go back to using ctime.  ctime is *exactly* what
> NFSv4 wants, as long as its granularity is sufficient to catch every
> single change.  Presumably XFS doesn't try to ensure this.  How hard
> would it be to get any ctime update to add at least one nanosecond?
> This would be enabled by a mount option, or possibly be a direct request
> from nfsd.

We can't rely on ctime to be changed during a modification because
O_NOCMTIME exists to enable "user invisible" modifications to be
made. On XFS these still bump iversion, so while they are invisible
to the user, they are still tracked by the filesystem and anything
that wants to know if the inode data/metadata changed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
