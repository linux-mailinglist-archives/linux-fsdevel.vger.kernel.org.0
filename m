Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A686A45B3CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 06:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhKXF0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 00:26:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54164 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhKXF0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 00:26:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C5DCB1FD37;
        Wed, 24 Nov 2021 05:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637731419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82iKLYBW8rYQ5jmnl9wsyslf/WVop5hDwhEeh5BNm5g=;
        b=flf8VnS8/39Jk4ubFShKU22PigHOY3QGsslDQlkvHMdzUodtDx9MnSDPzxv+3rPxWhB4bg
        4sSxy3Nl3V3oMBxwyDNQKl1CeheWs/tiHKcKlVCK4hp6hb65haSm4oFYqf6M0zXnbqoZaX
        M0WQM1PXLAjrwkWeXobq181iGvYaPfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637731419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82iKLYBW8rYQ5jmnl9wsyslf/WVop5hDwhEeh5BNm5g=;
        b=6K9yHncLI0GZR+YQqB5UvSEcFSVWqp8jfGG3JVg+tQSj+eYX6kzS4k9BQ/yrv29mj/jchT
        9N7BQHcOs9S2dXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C49713A1E;
        Wed, 24 Nov 2021 05:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jRSrCVjMnWHWaAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 24 Nov 2021 05:23:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki" <urezki@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Christoph Hellwig" <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <20211123194833.4711add38351d561f8a1ae3e@linux-foundation.org>
References: <20211122153233.9924-1-mhocko@kernel.org>,
 <20211122153233.9924-3-mhocko@kernel.org>, <YZ06nna7RirAI+vJ@pc638.lan>,
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>,
 <163772381628.1891.9102201563412921921@noble.neil.brown.name>,
 <20211123194833.4711add38351d561f8a1ae3e@linux-foundation.org>
Date:   Wed, 24 Nov 2021 16:23:31 +1100
Message-id: <163773141164.1891.1440920123016055540@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Nov 2021, Andrew Morton wrote:
> On Wed, 24 Nov 2021 14:16:56 +1100 "NeilBrown" <neilb@suse.de> wrote:
> 
> > On Wed, 24 Nov 2021, Andrew Morton wrote:
> > > 
> > > I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> > > sites were doing open-coded try-forever loops.  I thought "hey, they
> > > shouldn't be doing that in the first place, but let's at least
> > > centralize the concept to reduce code size, code duplication and so
> > > it's something we can now grep for".  But longer term, all GFP_NOFAIL
> > > sites should be reworked to no longer need to do the retry-forever
> > > thing.  In retrospect, this bright idea of mine seems to have added
> > > license for more sites to use retry-forever.  Sigh.
> > 
> > One of the costs of not having GFP_NOFAIL (or similar) is lots of
> > untested failure-path code.
> 
> Well that's bad of the relevant developers and testers!  It isn't that
> hard to fake up allocation failures.  Either with the formal fault
> injection framework or with ad-hackery.

If we have CONFIG_RANDOM_ALLOC_PAGE_FAILURE then I might agree.
lockdep is AWESOME.  It makes testing for deadlock problems *so* easy.  
That is the level of ease-of-use we need if you want people to handle
page-alloc failures reliably.

> 
> > When does an allocation that is allowed to retry and reclaim ever fail
> > anyway? I think the answer is "only when it has been killed by the oom
> > killer".  That of course cannot happen to kernel threads, so maybe
> > kernel threads should never need GFP_NOFAIL??
> 
> > I'm not sure the above is 100%, but I do think that is the sort of
> > semantic that we want.  We want to know what kmalloc failure *means*.
> > We also need well defined and documented strategies to handle it.
> > mempools are one such strategy, but not always suitable.
> 
> Well, mempools aren't "handling" it.  They're just another layer to
> make memory allocation attempts appear to be magical.  The preferred
> answer is "just handle the damned error and return ENOMEM".

No.  mempools are EXACTLY handling it - in a specific context.  When
writing out dirty pages so as to free up memory, you often need to
allocate memory.  And you may need a sequence of allocations, typically
at different levels in the stack.  Global water-marks cannot help
reliably as it might all be used up with top-level requests, and the
lower levels can starve indefinitely.  mempools ensure that when memory
is freed, it is returned to the same level it was allocated for.  That
ensures you can get at least one request at a time all the way out to
storage.

If swap-out just returned ENOMEM, you'd really be in trouble.

> 
> Obviously this gets very painful at times (arguably because of
> high-level design shortcomings).  The old radix_tree_preload approach
> was bulletproof, but was quite a lot of fuss.

It would get particularly painful if some system call started returned
-ENOMEM, which had never returned that before.  I note that ext4 uses
__GFP_NOFAIL when handling truncate.  I don't think user-space would be
happy with ENOMEM from truncate (or fallocate(PUNHC_HOLE)), though a
recent commit which adds it focuses more on wanting to avoid the need
for fsck.

> 
> > preallocating can also be useful but can be clumsy to implement.  Maybe
> > we should support a process preallocating a bunch of pages which can
> > only be used by the process - and are auto-freed when the process
> > returns to user-space.  That might allow the "error paths" to be simple
> > and early, and subsequent allocations that were GFP_USEPREALLOC would be
> > safe.
> 
> Yes, I think something like that would be quite feasible.  Need to
> prevent interrupt code from stealing the task's page store.
> 
> It can be a drag calculating (by hand) what the max possible amount of
> allocation will be and one can end up allocating and then not using a
> lot of memory.

CONFIG_DEBUG_PREALLOC could force every GFP_USE_PREALLOC request to use
a different page, and warn if there weren't enough.  Not perfect, but
useful.

Concerning the "lot of memory" having prealloc as an easy option means
people can use it until it becomes too expensive, then find a better
solution.  There will likely always be a better solution, but it might
not often be worth the effort.

> 
> I forget why radix_tree_preload used a cpu-local store rather than a
> per-task one.
> 
> Plus "what order pages would you like" and "on which node" and "in
> which zone", etc...

"what order" - only order-0 I hope.  I'd hazard a guess that 90% of
current NOFAIL allocations only need one page (providing slub is used -
slab seems to insist on high-order pages sometimes).
"which node" - whichever.  Unless __GFP_HARDWALL is set, alloc_page()
will fall-back to "whichever" anyway, and NOFAIL with HARDWALL is
probably a poor choice.
"which zone" - NORMAL.  I cannot find any NOFAIL allocations that want
DMA.  fs/ntfs asks for __GFP_HIGHMEM with NOFAIL, but that that doesn't
*requre* highmem.

Of course, before designing this interface too precisely we should check
if anyone can use it.  From a quick through the some of the 100-ish
users of __GFP_NOFAIL I'd guess that mempools would help - the
preallocation should happen at init-time, not request-time.  Maybe if we
made mempools even more light weight .... though that risks allocating a
lot of memory that will never get used.

This brings me back to the idea that
    alloc_page(wait and reclaim allowed)
should only fail on OOM_KILL.  That way kernel threads are safe, and
user-threads are free to return ENOMEM knowing it won't get to
user-space.  If user-thread code really needs NOFAIL, it punts to a
workqueue and waits - aborting the wait if it is killed, while the work
item still runs eventually.

NeilBrown
