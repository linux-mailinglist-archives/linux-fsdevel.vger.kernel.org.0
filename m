Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0F45B2C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbhKXDvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240877AbhKXDvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:51:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1605360F58;
        Wed, 24 Nov 2021 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637725715;
        bh=eNm19UYlyEnaAc3du4K/HQR+rTR/djVUDLeSLSIhcts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JdF/fCodrkt5hEwxfSHE1X76M7lQ3pfdJTBw3VeryrpK9UqmZLcfJY7svGM6i1Kjs
         E2o/AR4AWth4IxC/jmFLdolOq5nhUXue0F+Y2oXajjMa9hf34HJUc8r+LyAiFi4xtG
         FJvTvAMs5pojCHIU4EaEovqh2qEzW1yxiZglEUxc=
Date:   Tue, 23 Nov 2021 19:48:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "NeilBrown" <neilb@suse.de>
Cc:     "Uladzislau Rezki" <urezki@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Dave Chinner" <david@fromorbit.com>,
        "Christoph Hellwig" <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-Id: <20211123194833.4711add38351d561f8a1ae3e@linux-foundation.org>
In-Reply-To: <163772381628.1891.9102201563412921921@noble.neil.brown.name>
References: <20211122153233.9924-1-mhocko@kernel.org>
        <20211122153233.9924-3-mhocko@kernel.org>
        <YZ06nna7RirAI+vJ@pc638.lan>
        <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
        <163772381628.1891.9102201563412921921@noble.neil.brown.name>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Nov 2021 14:16:56 +1100 "NeilBrown" <neilb@suse.de> wrote:

> On Wed, 24 Nov 2021, Andrew Morton wrote:
> > 
> > I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> > sites were doing open-coded try-forever loops.  I thought "hey, they
> > shouldn't be doing that in the first place, but let's at least
> > centralize the concept to reduce code size, code duplication and so
> > it's something we can now grep for".  But longer term, all GFP_NOFAIL
> > sites should be reworked to no longer need to do the retry-forever
> > thing.  In retrospect, this bright idea of mine seems to have added
> > license for more sites to use retry-forever.  Sigh.
> 
> One of the costs of not having GFP_NOFAIL (or similar) is lots of
> untested failure-path code.

Well that's bad of the relevant developers and testers!  It isn't that
hard to fake up allocation failures.  Either with the formal fault
injection framework or with ad-hackery.

> When does an allocation that is allowed to retry and reclaim ever fail
> anyway? I think the answer is "only when it has been killed by the oom
> killer".  That of course cannot happen to kernel threads, so maybe
> kernel threads should never need GFP_NOFAIL??

> I'm not sure the above is 100%, but I do think that is the sort of
> semantic that we want.  We want to know what kmalloc failure *means*.
> We also need well defined and documented strategies to handle it.
> mempools are one such strategy, but not always suitable.

Well, mempools aren't "handling" it.  They're just another layer to
make memory allocation attempts appear to be magical.  The preferred
answer is "just handle the damned error and return ENOMEM".

Obviously this gets very painful at times (arguably because of
high-level design shortcomings).  The old radix_tree_preload approach
was bulletproof, but was quite a lot of fuss.

> preallocating can also be useful but can be clumsy to implement.  Maybe
> we should support a process preallocating a bunch of pages which can
> only be used by the process - and are auto-freed when the process
> returns to user-space.  That might allow the "error paths" to be simple
> and early, and subsequent allocations that were GFP_USEPREALLOC would be
> safe.

Yes, I think something like that would be quite feasible.  Need to
prevent interrupt code from stealing the task's page store.

It can be a drag calculating (by hand) what the max possible amount of
allocation will be and one can end up allocating and then not using a
lot of memory.

I forget why radix_tree_preload used a cpu-local store rather than a
per-task one.

Plus "what order pages would you like" and "on which node" and "in
which zone", etc...
