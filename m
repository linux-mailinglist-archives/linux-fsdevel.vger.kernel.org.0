Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B09A4E4690
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiCVTUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiCVTUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:20:48 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8866C85
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1647976758;
        bh=qzxa+ekQgQg9R3QIHa0OrC2IHvue00FhzYQSDMWvkyo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sBJfDGRwkLMj9XAziNa6i2wU8HXUK71Fqzl0Vvi0fA9xF1B/Sxh818kWZ+sBL6V2H
         H2iDvJvzRczhORjPuQyZ4yAUEGSH+6j8YtIb+QJ8EkSES684ark7LIeYg9bk7aURvZ
         JAjQqXd7Ob2/ruC786SIohjUHTUhU7VtrRdE1Zvc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 59EF31286EB1;
        Tue, 22 Mar 2022 15:19:18 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HCBRGRG6ZBZb; Tue, 22 Mar 2022 15:19:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1647976758;
        bh=qzxa+ekQgQg9R3QIHa0OrC2IHvue00FhzYQSDMWvkyo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sBJfDGRwkLMj9XAziNa6i2wU8HXUK71Fqzl0Vvi0fA9xF1B/Sxh818kWZ+sBL6V2H
         H2iDvJvzRczhORjPuQyZ4yAUEGSH+6j8YtIb+QJ8EkSES684ark7LIeYg9bk7aURvZ
         JAjQqXd7Ob2/ruC786SIohjUHTUhU7VtrRdE1Zvc=
Received: from [172.20.40.85] (unknown [12.247.251.114])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6F4A61286EA9;
        Tue, 22 Mar 2022 15:19:17 -0400 (EDT)
Message-ID: <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Date:   Tue, 22 Mar 2022 15:19:15 -0400
In-Reply-To: <YjnmcaHhE1F2oTcH@casper.infradead.org>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
         <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
         <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
         <20220316025223.GR661808@dread.disaster.area>
         <YjnmcaHhE1F2oTcH@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-22 at 15:08 +0000, Matthew Wilcox wrote:
> On Wed, Mar 16, 2022 at 01:52:23PM +1100, Dave Chinner wrote:
> > On Wed, Mar 16, 2022 at 10:07:19AM +0800, Gao Xiang wrote:
> > > On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > > > > On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <
> > > > > willy@infradead.org> wrote:
> > > > > 
> > > > > The number of negative dentries is effectively constrained
> > > > > only by memory
> > > > > size.  Systems which do not experience significant memory
> > > > > pressure for
> > > > > an extended period can build up millions of negative dentries
> > > > > which
> > > > > clog the dcache.  That can have different symptoms, such as
> > > > > inotify
> > > > > taking a long time [1], high memory usage [2] and even just
> > > > > poor lookup
> > > > > performance [3].  We've also seen problems with cgroups being
> > > > > pinned
> > > > > by negative dentries, though I think we now reparent those
> > > > > dentries to
> > > > > their parent cgroup instead.
> > > > 
> > > > Yes, it should be fixed already.
> > > > 
> > > > > We don't have a really good solution yet, and maybe some
> > > > > focused
> > > > > brainstorming on the problem would lead to something that
> > > > > actually works.
> > > > 
> > > > I’d be happy to join this discussion. And in my opinion it’s
> > > > going beyond negative dentries: there are other types of
> > > > objects which tend to grow beyond any reasonable limits if
> > > > there is no memory pressure.
> > > 
> > > +1, we once had a similar issue as well, and agree that is not
> > > only
> > > limited to negative dentries but all too many LRU-ed dentries and
> > > inodes.
> > 
> > Yup, any discussion solely about managing buildup of negative
> > dentries doesn't acknowledge that it is just a symptom of larger
> > problems that need to be addressed.
> 
> Yes, but let's not make this _so_ broad a discussion that it becomes
> unsolvable.  Rather, let's look for a solution to this particular
> problem that can be adopted by other caches that share a similar
> problem.

Well, firstly what is the exact problem?  People maliciously looking up
nonexistent files and causing the negative dentries to balloon or
simply managing dentries for a well behaved workload (which is what
good examples?)

> For example, we might be seduced into saying "this is a slab problem"
> because all the instances we have here allocate from slab.  But slab
> doesn't have enough information to solve the problem.  Maybe the
> working set of the current workload really needs 6 million dentries
> to perform optimally.  Maybe it needs 600.  Slab can't know
> that.  Maybe slab can play a role here, but the only component which
> can know the appropriate size for a cache is the cache itself.

Could we do something depending on the age of the oldest dentry on the
lru list?  We don't currently keep a last accessed time, but we could.

> I think the logic needs to be in d_alloc().  Before it calls
> __d_alloc(), it should check ... something ... to see if it should
> try to shrink the LRU list.

We could also do it in kill_dentry() or retain_dentry() ... we're past
all the fast paths when they start running.  They also have a view on
the liveness of the dentry.  Chances are if you get a negative dentry
back in kill_dentry, it isn't going to be instantiated, so it's only
use is to cache -ENOENT and we could perform more agressive shrinking
heuristics.

>   The devil is in what that something
> should be.  I'm no expert on the dcache; do we just want to call
> prune_dcache_sb() for every 1/1000 time?  Rely on DCACHE_REFERENCED
> to make sure that we're not over-pruning the list?  If so, what do we
> set nr_to_scan to?  1000 so that we try to keep the dentry list the
> same size?  1500 so that it actually tries to shrink?

Fundamentally, a negative dentry that doesn't get promoted to a
positive one better be looked up pretty often for us to keep it in the
cache, I think?  So last accessed time seems to be a good indicator.

We also have to scan the whole list for negative dentries, perhaps they
might get on better with their own lru list (although that complicates
the instantiation case and perhaps we can afford to spend the time
walking backwards over the lru list in alloc/kill anyway, so there's no
need for a separate list).

> I don't feel like I know enough to go further here.  But it feels
> better than what we currently do -- calling all the shrinkers from
> deep in the page allocator.

Well, yes, but that's not a high bar.

James


