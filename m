Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E84E4284
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiCVPKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiCVPKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D68A19B
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2v149NWlYn2CH+2h0/HZeo0ZGcKwr3TJvt9YY3on0CE=; b=oRnqsPc48iKnnuzTfEESj3Vuzc
        +ehFBCZgJM9lNmYPH1xxdCtcH8qzExSTOF9XpqvtoaRBlBzjQ4qlaSwgyPDw8oGP8NrIQLbyYAkO7
        2/iW6Ab4EWChtfj5c1btnCZjFqPmrQGjMqkMsJLzhSlBaruDZGmq2S1nqhVF/oNsO2Kveodqwk8DI
        X58uShnaoNnuIWidJnu6BinfADm+kgDozyIhLaEQ73FFrfD/JuCl1fyWH2kmZIfV3K84qglH70XyC
        1tiYo1psjm1R43AO7xCGLTmwuKfBRmA8ez65EKT25EFmvN4lZWGpRlDK2dHAVjqzOgwQzETKGes56
        +EylN2iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWg7d-00BhYf-Kc; Tue, 22 Mar 2022 15:08:33 +0000
Date:   Tue, 22 Mar 2022 15:08:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <YjnmcaHhE1F2oTcH@casper.infradead.org>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220316025223.GR661808@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:52:23PM +1100, Dave Chinner wrote:
> On Wed, Mar 16, 2022 at 10:07:19AM +0800, Gao Xiang wrote:
> > On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > > 
> > > > On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > > 
> > > > The number of negative dentries is effectively constrained only by memory
> > > > size.  Systems which do not experience significant memory pressure for
> > > > an extended period can build up millions of negative dentries which
> > > > clog the dcache.  That can have different symptoms, such as inotify
> > > > taking a long time [1], high memory usage [2] and even just poor lookup
> > > > performance [3].  We've also seen problems with cgroups being pinned
> > > > by negative dentries, though I think we now reparent those dentries to
> > > > their parent cgroup instead.
> > > 
> > > Yes, it should be fixed already.
> > > 
> > > > 
> > > > We don't have a really good solution yet, and maybe some focused
> > > > brainstorming on the problem would lead to something that actually works.
> > > 
> > > I’d be happy to join this discussion. And in my opinion it’s going beyond negative dentries: there are other types of objects which tend to grow beyond any reasonable limits if there is no memory pressure.
> > 
> > +1, we once had a similar issue as well, and agree that is not only
> > limited to negative dentries but all too many LRU-ed dentries and inodes.
> 
> Yup, any discussion solely about managing buildup of negative
> dentries doesn't acknowledge that it is just a symptom of larger
> problems that need to be addressed.

Yes, but let's not make this _so_ broad a discussion that it becomes
unsolvable.  Rather, let's look for a solution to this particular problem
that can be adopted by other caches that share a similar problem.

For example, we might be seduced into saying "this is a slab problem"
because all the instances we have here allocate from slab.  But slab
doesn't have enough information to solve the problem.  Maybe the working
set of the current workload really needs 6 million dentries to perform
optimally.  Maybe it needs 600.  Slab can't know that.  Maybe slab can
play a role here, but the only component which can know the appropriate
size for a cache is the cache itself.

I think the logic needs to be in d_alloc().  Before it calls __d_alloc(),
it should check ... something ... to see if it should try to shrink
the LRU list.  The devil is in what that something should be.  I'm no
expert on the dcache; do we just want to call prune_dcache_sb() for
every 1/1000 time?  Rely on DCACHE_REFERENCED to make sure that we're
not over-pruning the list?  If so, what do we set nr_to_scan to?  1000 so
that we try to keep the dentry list the same size?  1500 so that it
actually tries to shrink?

I don't feel like I know enough to go further here.  But it feels better
than what we currently do -- calling all the shrinkers from deep in
the page allocator.
