Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBB4EB04A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiC2P1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbiC2P0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:26:45 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C46A058
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648567499;
        bh=QbZskX1IvWgk27uei6kxxWQdo00nSjnI3uOY/msB4cg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q0uaWaa3WkpbXksH4RE1zNguvGO+AFgX2vn/A0714GgBCOuHX3fquSS6Y60W7+83e
         7wOkAUYjNruxri+Z5sz/r3dvDVXTbY5ovV41hhbcD2ssCGc3GdLk2zfY46R7vkTppn
         0j4ukCuKW4jt7VRga6r3YdjsVBuVQnqN9Yfmk+GI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C3EE7128816B;
        Tue, 29 Mar 2022 11:24:59 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VP9L89hMu5qf; Tue, 29 Mar 2022 11:24:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1648567499;
        bh=QbZskX1IvWgk27uei6kxxWQdo00nSjnI3uOY/msB4cg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q0uaWaa3WkpbXksH4RE1zNguvGO+AFgX2vn/A0714GgBCOuHX3fquSS6Y60W7+83e
         7wOkAUYjNruxri+Z5sz/r3dvDVXTbY5ovV41hhbcD2ssCGc3GdLk2zfY46R7vkTppn
         0j4ukCuKW4jt7VRga6r3YdjsVBuVQnqN9Yfmk+GI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ABF59128816A;
        Tue, 29 Mar 2022 11:24:58 -0400 (EDT)
Message-ID: <f849f7f981ef76b30b4d91457752b3740b1f6d51.camel@HansenPartnership.com>
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Date:   Tue, 29 Mar 2022 11:24:56 -0400
In-Reply-To: <3a7abaca-e20f-ad59-f6f0-caedd8450f9f@oracle.com>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
         <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
         <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
         <20220316025223.GR661808@dread.disaster.area>
         <YjnmcaHhE1F2oTcH@casper.infradead.org>
         <a8f6ea9ec9b8f4d9b48e97fe1236f80b62b76dc1.camel@HansenPartnership.com>
         <42d92c6f-28f2-459b-bc2a-13dd655dd4ae@www.fastmail.com>
         <YjozgfjcNLXIQKhG@casper.infradead.org>
         <3a7abaca-e20f-ad59-f6f0-caedd8450f9f@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-22 at 14:08 -0700, Stephen Brennan wrote:
> On 3/22/22 13:37, Matthew Wilcox wrote:
> > On Tue, Mar 22, 2022 at 04:17:16PM -0400, Colin Walters wrote:
> > > 
> > > On Tue, Mar 22, 2022, at 3:19 PM, James Bottomley wrote:
> > > > Well, firstly what is the exact problem?  People maliciously
> > > > looking up nonexistent files
> > > 
> > > Maybe most people have seen it, but for those who haven't:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1571183
> > > was definitely one of those things that just makes one recoil in
> > > horror.
> > > 
> > > TL;DR NSS used to have code that tried to detect "is this a
> > > network filesystem" by timing `stat()` calls to nonexistent
> > > paths, and this massively boated the negative dentry cache and
> > > caused all sorts of performance problems.
> > > It was particularly confusing because this would just happen as a
> > > side effect of e.g. executing `curl https://somewebsite`.
> > > 
> > > That code wasn't *intentionally* malicious but...
> 
> That's... unpleasant.
> 
> > Oh, the situation where we encountered the problem was systemd.
> > Definitely not malicious, and not even stupid (as the NSS example
> > above). I forget exactly which thing it was, but on some fairly
> > common event (user login?), it looked up a file in a PATH of some
> > type, failed to find it in the first two directories, then created
> > it in a third> At logout, it deleted the file.  Now there are three
> > negative dentries.
> 
> More or less this, although I'm not sure it even created and deleted
> the files... it just wanted to check for them in all sorts of places.
> The file paths were something like this:
> 
> /{etc,usr/lib}/systemd/system/session-
> XXXXXXXX.scope.{wants,d,requires}
> 
> > Repeat a few million times (each time looking for a different file)
> > with no memory pressure and you have a thoroughly soggy machine
> > that is faster to reboot than to reclaim dentries.
> 
> The speed of reclaiming memory wasn't the straw which broke this
> server's back, it ended up being that some operations might iterate
> over the entire list of children of a dentry, holding a spinlock,
> causing soft lockups. Thus, patches like [1] which are attempting to
> treat the symptom, not the cause.
> 
> It seems to me that the idea of doing something based on last access
> time, or number of accesses, would be a great step. But given a
> prioritized list of dentries to target, and even a reasonable call
> site like kill_dentry(), the hardest part still seems to be
> determining the working set of dentries, or at least determining what
> is a reasonable number of negative dentries to keep around.
> 
> If we're looking at issues like [1], then the amount needs to be on a
> per-directory basis, and maybe roughly based on CPU speed. For other
> priorities or failure modes, then the policy would need to be
> completely different. Ideally a solution could work for almost all
> scenarios, but failing that, maybe it is worth allowing policy to be
> set by administrators via sysctl or even a BPF?

Looking at [1], you're really trying to contain the parent's child list
from exploding with negative dentries.  Looking through the patch, it
still strikes me that dentry_kill/retain_dentry is still a better
place, because if a negative dentry comes back there, it's unlikely to
become positive (well, fstat followed by create would be the counter
example, but it would partly be the app's fault for not doing
open(O_CREAT)).

If we have the signal for reuse of negative dentry from the cache,
which would be a fast lookup, we know a newly created negative dentry
already had a slow lookup, so we can do more processing without
necessarily slowing down the workload too much.  In particular, we
could just iterate over the parent's children of this negative dentry
and start pruning if there are too many (too many being a relative
term, but I think something like 2x-10x the max positive entries
wouldn't be such a bad heuristic).  Assuming we don't allow the
parent's list to contain too many negative dentries, we might not need
the sweep negative logic because the list wouldn't be allowed to grow
overly large.  I think a second heuristic would be prune at least two
negative dentries from the end of the sb lru list if they've never been
used for a lookup and were created more than a specified time ago
(problem is what, but I bet a minute wouldn't be unreasonable).

Obviously, while I think it would work for some of the negative dentry
induced issues, the above is very heuristic in tuning and won't help
with any of the other object issues in filesystems.  But on the other
hand, negative dentries are special in that if they're never used to
cache an -ENOENT and they never go positive, they're just a waste of
space.

James


