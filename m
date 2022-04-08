Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023AF4F8E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiDHFFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 01:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiDHFF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:05:29 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F19921A5906;
        Thu,  7 Apr 2022 22:03:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D55325343FA;
        Fri,  8 Apr 2022 15:03:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ncgmH-00F7iB-6G; Fri, 08 Apr 2022 15:03:21 +1000
Date:   Fri, 8 Apr 2022 15:03:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
Message-ID: <20220408050321.GF1609613@dread.disaster.area>
References: <20220406195424.GA1242@fieldses.org>
 <20220407001453.GE1609613@dread.disaster.area>
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>
 <164930468885.10985.9905950866720150663@noble.neil.brown.name>
 <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>
 <164938596863.10985.998515507989861871@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164938596863.10985.998515507989861871@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624fc21d
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=d5fOfDb67WCC2U-2ANoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 12:46:08PM +1000, NeilBrown wrote:
> On Thu, 07 Apr 2022, Trond Myklebust wrote:
> > The bottom line is that we use ordinary GFP_KERNEL memory allocations
> > where we can. The new code follows that rule, breaking it only in cases
> > where the specific rules of rpciod/xprtiod/nfsiod make it impossible to
> > wait forever in the memory manager.
> 
> It is not safe to use GFP_KERNEL for an allocation that is needed in
> order to free memory - and so any allocation that is needed to write out
> data from the page cache.

Except that same page cache writeback path can be called from
syscall context (e.g.  fsync()) which has nothing to do with memory
reclaim. In that case GFP_KERNEL is the correct allocation context
to use because there are no constraints on what memory reclaim can
be performed from this path.

IOWs, if the context initiating data writeback doesn't allow
GFP_KERNEL allocations, then it should be calling
memalloc_nofs_save() or memalloc_noio_save() to constrain all
allocations to the required context. We should not be requiring the
filesystem (or any other subsystem) to magically infer that the IO
is being done in a constrained allocation context and modify the
context they use appropriately.

If we this, then all filesystems would simply use GFP_NOIO
everywhere because the loop device layers the entire filesystem IO
path under block device context (i.e. requiring GFP_NOIO allocation
context). We don't do this - the loop device sets PF_MEMALLOC_NOIO
instead so all allocations in that path run with at least GFP_NOIO
constraints and filesystems are none the wiser about the constraints
of the calling context.

IOWs, GFP_KERNEL is generally right context to be using in
filesystem IO paths and callers need to restrict allocation contexts
via task flags if they cannot allow certain types of reclaim
recursion to occur...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
