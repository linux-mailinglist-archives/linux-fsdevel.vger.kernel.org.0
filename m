Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA64FB0D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 01:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbiDJXgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbiDJXgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:36:45 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF12E12778;
        Sun, 10 Apr 2022 16:34:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E7E7053A325;
        Mon, 11 Apr 2022 09:34:17 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ndh4R-00GDJl-2v; Mon, 11 Apr 2022 09:34:15 +1000
Date:   Mon, 11 Apr 2022 09:34:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
Message-ID: <20220410233415.GG1609613@dread.disaster.area>
References: <20220406195424.GA1242@fieldses.org>
 <20220407001453.GE1609613@dread.disaster.area>
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>
 <164930468885.10985.9905950866720150663@noble.neil.brown.name>
 <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>
 <164938596863.10985.998515507989861871@noble.neil.brown.name>
 <20220408050321.GF1609613@dread.disaster.area>
 <164939595866.10985.2936909905164009297@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164939595866.10985.2936909905164009297@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6253697b
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=sHeWs7URuTVpttbXkC8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:32:38PM +1000, NeilBrown wrote:
> On Fri, 08 Apr 2022, Dave Chinner wrote:
> > On Fri, Apr 08, 2022 at 12:46:08PM +1000, NeilBrown wrote:
> > > On Thu, 07 Apr 2022, Trond Myklebust wrote:
> > > > The bottom line is that we use ordinary GFP_KERNEL memory allocations
> > > > where we can. The new code follows that rule, breaking it only in cases
> > > > where the specific rules of rpciod/xprtiod/nfsiod make it impossible to
> > > > wait forever in the memory manager.
> > > 
> > > It is not safe to use GFP_KERNEL for an allocation that is needed in
> > > order to free memory - and so any allocation that is needed to write out
> > > data from the page cache.
> > 
> > Except that same page cache writeback path can be called from
> > syscall context (e.g.  fsync()) which has nothing to do with memory
> > reclaim. In that case GFP_KERNEL is the correct allocation context
> > to use because there are no constraints on what memory reclaim can
> > be performed from this path.
> > 
> > IOWs, if the context initiating data writeback doesn't allow
> > GFP_KERNEL allocations, then it should be calling
> > memalloc_nofs_save() or memalloc_noio_save() to constrain all
> > allocations to the required context. We should not be requiring the
> > filesystem (or any other subsystem) to magically infer that the IO
> > is being done in a constrained allocation context and modify the
> > context they use appropriately.
> > 
> > If we this, then all filesystems would simply use GFP_NOIO
> > everywhere because the loop device layers the entire filesystem IO
> > path under block device context (i.e. requiring GFP_NOIO allocation
> > context). We don't do this - the loop device sets PF_MEMALLOC_NOIO
> > instead so all allocations in that path run with at least GFP_NOIO
> > constraints and filesystems are none the wiser about the constraints
> > of the calling context.
> > 
> > IOWs, GFP_KERNEL is generally right context to be using in
> > filesystem IO paths and callers need to restrict allocation contexts
> > via task flags if they cannot allow certain types of reclaim
> > recursion to occur...
> 
> NOIO and NOFS are not the issue here.  We all agree that
> memalloc_noXX_save() is the right thing to do.
> 
> The issue is that memalloc can block indefinitely in low-memory
> situations, and any code that has to make progress in low-memory
> situations - like writeout - needs to be careful.

Yup, and you've missed my point entirely, then explained exactly why
high level memory allocation context needs to be set by mempool
based allocations...

> The bio is allocated from a mempool, and nothing below submit_bio() uses
> GFP_KERNEL to alloc_page() - they all use mempools (or accept failure in
> some other way).  A separate mempool at each level - they aren't shared
> (so they are quite different from __GFP_MEMALLOC).

.... because this house of cards using mempools only works if it
is nested mempools all the way down.

> The networking people refuse to use mempools (or at least, they did once

Same as many filesystem people refuse to use mempools, because the
page writeback IO path in a filesystem can have *unbound* memory
demand. mempools just don't work in filesytsems that need to run
transactions or read metadata (e.g. for block allocation
transactions).  We've been through this many times before; it's why
filesystems like XFS and Btrfs do not allow ->writepage from memory
reclaim contexts.

> But in NFS and particularly in SUNRPC we already have the mempool, and
> there is only a small number of things that we need to allocate to
> ensure forward progress.  So using a mempool as designed, rather than
> relying on MEMALLOC reserves is the sensible thing to do, and leaves
> more of the reserves for the networking layer.

Except the mempool now requires everything in the path below it not
to block on memory allocation for it to guarantee forwards progress
i.e. nested allocations need to succeed or error out - either
guarantees *mempool* forwards progress, not necessarily forwards
progress cleaning memory, but this is only needed for the paths
where we actually need to provide a forwards progress guarantee.

THe RPC code puts the entire network stack under a mempool, and as
you say the network stack is resistent to using mempools.  At which
point, NFS needs memalloc_noreclaim_save() context to be set
explicitly in the path nested inside the mempool allocation so that
non-mempool allocations don't block trying to reclaim memory that
might never come available....

That's the point I was trying to make - GFP_KERNEL is not the
problem here - it's that mempools only work when it's mempools all
the way down. Individual code paths and/or allocations may have no
idea that they are running in a nested mempool allocation context,
and so all allocations in that path - GFP_KERNEL or otherwise - need
to be automatically converted to fail-instead-of-block semantics by
the high level code that uses a mempool based allocation...

> In fact, the allocation that SUNRPC now does before trying a mempool
> should really be using __GFP_NOMEMALLOC so that they don't take from the
> shared reserves (even when PF_MEMALLOC is set).  As it has a private
> reserve (the mempool) it should leave the common reserve for other
> layers (sockets etc).

Yup, but that's a high level, pre-mempool allocation optimisation
which is not useful to future allocations done inside the mempool
forwards progress guarantee context....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
