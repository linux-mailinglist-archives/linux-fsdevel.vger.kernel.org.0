Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462904F8DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 08:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiDHFeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 01:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiDHFet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:34:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0523C3A8;
        Thu,  7 Apr 2022 22:32:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F8EE1F85F;
        Fri,  8 Apr 2022 05:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649395964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdTW7COGvmCgK+LD5zU9u4m949ZH/XIvxLPVYTKkNWg=;
        b=COgZgDyt/iHlm/IOD0lhgw3zwv9X4kcDBRtS26ARUbM9IZ/E996GgZQH9RJ7as4uWKNGro
        HuCLZIqBravRjZLbHWWa0f2vUEQ1zqko5wM9Xb8zPDk/2BLKMrZa2vOq/LVyx/BIHDUg67
        HZr3wuyjEo2ywX2oeBiWLMrrQBe2bUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649395964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdTW7COGvmCgK+LD5zU9u4m949ZH/XIvxLPVYTKkNWg=;
        b=occToaFpUIV8dbC+VqS2dzVKUTzPpeEdjVxmFix1qtBWVv5L/uHRuqTmBCmtnkrwXCBrUw
        EdT+JNmWdqyjroBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96A4813A9C;
        Fri,  8 Apr 2022 05:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yzJEFfrIT2IlawAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 08 Apr 2022 05:32:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: sporadic hangs on generic/186
In-reply-to: <20220408050321.GF1609613@dread.disaster.area>
References: <20220406195424.GA1242@fieldses.org>,
 <20220407001453.GE1609613@dread.disaster.area>,
 <164929126156.10985.11316778982526844125@noble.neil.brown.name>,
 <164929437439.10985.5253499040284089154@noble.neil.brown.name>,
 <b282c5b98c4518952f62662ea3ba1d4e6ef85f26.camel@hammerspace.com>,
 <164930468885.10985.9905950866720150663@noble.neil.brown.name>,
 <43aace26d3a09f868f732b2ad94ca2dbf90f50bd.camel@hammerspace.com>,
 <164938596863.10985.998515507989861871@noble.neil.brown.name>,
 <20220408050321.GF1609613@dread.disaster.area>
Date:   Fri, 08 Apr 2022 15:32:38 +1000
Message-id: <164939595866.10985.2936909905164009297@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 08 Apr 2022, Dave Chinner wrote:
> On Fri, Apr 08, 2022 at 12:46:08PM +1000, NeilBrown wrote:
> > On Thu, 07 Apr 2022, Trond Myklebust wrote:
> > > The bottom line is that we use ordinary GFP_KERNEL memory allocations
> > > where we can. The new code follows that rule, breaking it only in cases
> > > where the specific rules of rpciod/xprtiod/nfsiod make it impossible to
> > > wait forever in the memory manager.
> > 
> > It is not safe to use GFP_KERNEL for an allocation that is needed in
> > order to free memory - and so any allocation that is needed to write out
> > data from the page cache.
> 
> Except that same page cache writeback path can be called from
> syscall context (e.g.  fsync()) which has nothing to do with memory
> reclaim. In that case GFP_KERNEL is the correct allocation context
> to use because there are no constraints on what memory reclaim can
> be performed from this path.
> 
> IOWs, if the context initiating data writeback doesn't allow
> GFP_KERNEL allocations, then it should be calling
> memalloc_nofs_save() or memalloc_noio_save() to constrain all
> allocations to the required context. We should not be requiring the
> filesystem (or any other subsystem) to magically infer that the IO
> is being done in a constrained allocation context and modify the
> context they use appropriately.
> 
> If we this, then all filesystems would simply use GFP_NOIO
> everywhere because the loop device layers the entire filesystem IO
> path under block device context (i.e. requiring GFP_NOIO allocation
> context). We don't do this - the loop device sets PF_MEMALLOC_NOIO
> instead so all allocations in that path run with at least GFP_NOIO
> constraints and filesystems are none the wiser about the constraints
> of the calling context.
> 
> IOWs, GFP_KERNEL is generally right context to be using in
> filesystem IO paths and callers need to restrict allocation contexts
> via task flags if they cannot allow certain types of reclaim
> recursion to occur...

NOIO and NOFS are not the issue here.  We all agree that
memalloc_noXX_save() is the right thing to do.

The issue is that memalloc can block indefinitely in low-memory
situations, and any code that has to make progress in low-memory
situations - like writeout - needs to be careful.

This is why the block layer uses mempools for request headers etc - so
that progress is guaranteed without depending on alloc_page() to
succeed.

File systems do often get away with using GFP_KERNEL because the
important paths has PF_MEMALLOC and hence __GFP_MEMALLOC in effect and
that provides access to some shared reserves.  Shared reserves are risky
- the other users you are sharing with might steal it all.

File systems tend to survive anyway because there is a limit on the
mount of dirty filesystem data - so there is lots of non-filesystem data
around, and a good chance that some of that can be freed.

I say "tend to" because I believe the is no real guarantee.  It seems to
actually work 99.999% of the time, and maybe that is enough.

I suspect you might be able to deadlock filesystem writeout by
memlocking lots of memory while there are lots of dirty pages.  It
probably wouldn't be easy though.

swap-out is different.  There is no limit the the amount of dirty anon
data, so it is fairly easy to get a situation where you absolutely must
write out some anon pages before alloc_page() can succeed. 
Most filesystems don't handle swap-out directly - they just tell the MM
which disk addresses to use and submit_bio() is used for writing.
The bio is allocated from a mempool, and nothing below submit_bio() uses
GFP_KERNEL to alloc_page() - they all use mempools (or accept failure in
some other way).  A separate mempool at each level - they aren't shared
(so they are quite different from __GFP_MEMALLOC).

NFS is different.  NFS handles swap using the same paths as other
writes, so it is much more likely to face indefinite waits in
alloc_page() - it least when handling swap.  __GFP_MEMALLOC helps to a
degree but there a lots of levels, and the more levels we have have
local reserves (even if the mempool only reserves a single element), the
better.

The networking people refuse to use mempools (or at least, they did once
some years ago) and I cannot entirely blame them as there are lots of
moving parts - lots of different things that might need to be allocated
(arp table entries?) but usually aren't.  So for everything in the
socket layer and below we rely on __GFP_MEMALLOC (and recommend
increasing the reserves a bit above the default, just in case).

But in NFS and particularly in SUNRPC we already have the mempool, and
there is only a small number of things that we need to allocate to
ensure forward progress.  So using a mempool as designed, rather than
relying on MEMALLOC reserves is the sensible thing to do, and leaves
more of the reserves for the networking layer.

In fact, the allocation that SUNRPC now does before trying a mempool
should really be using __GFP_NOMEMALLOC so that they don't take from the
shared reserves (even when PF_MEMALLOC is set).  As it has a private
reserve (the mempool) it should leave the common reserve for other
layers (sockets etc).

NeilBrown
