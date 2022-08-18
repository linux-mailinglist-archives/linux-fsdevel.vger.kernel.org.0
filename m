Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C92597BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiHRDA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 23:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbiHRDAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:00:54 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2191A6C14;
        Wed, 17 Aug 2022 20:00:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6DE8A10E919C;
        Thu, 18 Aug 2022 13:00:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOVm4-00ER0v-O8; Thu, 18 Aug 2022 13:00:48 +1000
Date:   Thu, 18 Aug 2022 13:00:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220818030048.GE3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
 <20220816224257.GV3600936@dread.disaster.area>
 <166078288043.5425.8131814891435481157@noble.neil.brown.name>
 <20220818013251.GC3600936@dread.disaster.area>
 <166078753200.5425.8997202026343224290@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166078753200.5425.8997202026343224290@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62fdab63
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=UTXyKXW3ESHh9d1XWk0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:52:12AM +1000, NeilBrown wrote:
> On Thu, 18 Aug 2022, Dave Chinner wrote:
> > 
> > > Maybe we should just go back to using ctime.  ctime is *exactly* what
> > > NFSv4 wants, as long as its granularity is sufficient to catch every
> > > single change.  Presumably XFS doesn't try to ensure this.  How hard
> > > would it be to get any ctime update to add at least one nanosecond?
> > > This would be enabled by a mount option, or possibly be a direct request
> > > from nfsd.
> > 
> > We can't rely on ctime to be changed during a modification because
> > O_NOCMTIME exists to enable "user invisible" modifications to be
> > made. On XFS these still bump iversion, so while they are invisible
> > to the user, they are still tracked by the filesystem and anything
> > that wants to know if the inode data/metadata changed.
> > 
> 
> O_NOCMTIME isn't mentioned in the man page, so it doesn't exist :-(
> 
> If they are "user invisible", should they then also be "NFS invisible"?
> I think so.

Maybe, but now you're making big assumptions about what is being
done by those operations. Userspace can write whatever it likes,
nothing says that O_NOCMTIME can't change user visible data or
metadata.

> As I understand it, the purpose of O_NOCMTIME is to allow optimisations
> - do a lot of writes, then update the mtime, thus reducing latency.  I
> think it is perfectly reasonable for all of that to be invisible to NFS.

O_NOCMTIME is used by things like HSMs, file defragmenters,
deduplication tools, backup programs, etc to be able to read/write
data and manipulate file layout without modifying user visible
timestamps. i.e. users shouldn't notice that the online defragmenter
defragmented their file. Backup programs shouldn't notice the
defragmenter defragmented the file. 

But having uses of it that don't change user visible data does not
mean it can't be used for changing user visible data. Hence we made
the defensive assumption that O_NOCMTIME was a mechanism that could
be used to hide data changes from forensic analysis. With that in
mind, it was important that the change counter captured changes made
even when O_NOCMTIME was specified to leave behind a breadcrumb to
indicate unexpected changes may had been made to the file.

Yeah, we had lots of different requirements for the XFS on-disk
change counter when we were considering adding it. NFSv4 was one of
the least demanding and least defined requirements; it's taken a
*decade* for this atime issue to be noticed, so I really don't think
there's anything wrong with how XFs has implemented persistent
change counters.

What it tells me is that the VFS needs more appropriate atime
filtering for NFSv4's change attribute requirements....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
