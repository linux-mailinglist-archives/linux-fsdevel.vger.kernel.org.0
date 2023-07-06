Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA474A1A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjGFP4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjGFP4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:56:14 -0400
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357A1BD0
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 08:56:11 -0700 (PDT)
Date:   Thu, 6 Jul 2023 11:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688658969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=JBjGDA7ydfKolArFlHyoGbaegXA0bjZVgRz3VNxz/Xk=;
        b=SCusYgRdj8dOs7PArJU2khmgLtU2z17xdTbwxRXF9bWGvdXsJMxXrIvr71ama0A7shFwLo
        ml/tQuW0nEFdOhQQCvzUJO60SoqXDXllAq7szN03L05GNwuj6gqVlTT8a5YGg+VjfCQmnp
        RuS9XJc36Nupr2F3e4xmwZ5GXrtaAUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706155602.mnhsylo3pnief2of@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626214656.hcp4puionmtoloat@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:47:01PM -0400, Kent Overstreet wrote:
> Hi Linus,
> 
> Here it is, the bcachefs pull request. For brevity the list of patches
> below is only the initial part of the series, the non-bcachefs prep
> patches and the first bcachefs patch, but the diffstat is for the entire
> series.
> 
> Six locks has all the changes you suggested, text size went down
> significantly. If you'd still like this to see more review from the
> locking people, I'm not against them living in fs/bcachefs/ as an
> interim; perhaps Dave could move them back to kernel/locking when he
> starts using them or when locking people have had time to look at them -
> I'm just hoping for this to not block the merge.
> 
> Recently some people have expressed concerns about "not wanting a repeat
> of ntfs3" - from what I understand the issue there was just severe
> buggyness, so perhaps showing the bcachefs automated test results will
> help with that:
> 
>   https://evilpiepirate.org/~testdashboard/ci
> 
> The main bcachefs branch runs fstests and my own test suite in several
> varations, including lockdep+kasan, preempt, and gcov (we're at 82% line
> coverage); I'm not currently seeing any lockdep or kasan splats (or
> panics/oopses, for that matter).
> 
> (Worth noting the bug causing the most test failures by a wide margin is
> actually an io_uring bug that causes random umount failures in shutdown
> tests. Would be great to get that looked at, it doesn't just affect
> bcachefs).
> 
> Regarding feature status - most features are considered stable and ready
> for use, snapshots and erasure coding are both nearly there. But a
> filesystem on this scale is a massive project, adequately conveying the
> status of every feature would take at least a page or two.
> 
> We may want to mark it as EXPERIMENTAL for a few releases, I haven't
> done that as yet. (I wouldn't consider single device without snapshots
> to be experimental, but - given that the number of users and bug reports
> is about to shoot up, perhaps I should...).

Restarting the discussion after the holiday weekend, hoping to get
something more substantive going:

Hoping to get:
 - Thoughts from people who have been following bcachefs development,
   and people who have looked at the code
 - Continuation of the LSF discussion - maybe some people could repeat
   here what they said there (re: code review, iomap, etc.)
 - Any concerns about how this might impact the rest of the kernel, or
   discussion about what impact merging a new filesystem is likely to
   have on other people's work

AFAIK the only big ask that hasn't happened yet is better documentation:
David Howells wanted (better) a man page, which is definitely something
that needs to happen but it'll be some months before I'm back to working
on documentation - I'm happy to share my current list of priorities if
that would be helpful.

In the meantime, the Latex principles of operation is reasonably up to
date (and I intend to greatly expand the sections on on disk data
structures, I think that'll be great reference documentation for
developers getting up to speed on the code)

https://bcachefs.org/bcachefs-principles-of-operation.pdf

I feel that bcachefs is in a pretty mature state at this point, but it's
also _huge_, which is a bit different than e.g. the btrfs merger; it's
hard to know where to start to get a meaninful discussion/review process
going.

Patch bombing the mailing list with 90k loc is clearly not going to be
productive, which is why I've been trying to talk more about development
process and status - but all suggestions and feedback are welcome.

Cheers,
Kent
