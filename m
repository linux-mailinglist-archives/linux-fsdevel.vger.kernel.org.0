Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E271193A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbjEYVhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 17:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjEYVg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 17:36:59 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [IPv6:2001:41d0:203:375::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3700099
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 14:36:56 -0700 (PDT)
Date:   Thu, 25 May 2023 17:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685050615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpYQakP/W6RPFRm8zMcoftE0dEwMWiRIJfKT61WqU5A=;
        b=roxaxnnCj6QAgIhBd9kxUeFAPPtmRVShCsgRk0igZ5IGFV8A7jpK/mwf08EfF1eOFHZGO7
        HhKkv9PeMGbSwxEK7v6BZzFwNEaqiGws2iz7UaOgLwxxM4E0oEiFCv9UbOTyherZqJI/Bb
        pVen4KprM+zmgXIpbY5iu33iRIkEZ7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Message-ID: <ZG/U8pl8Zp3Wei7Z@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzugpw7vgCFxOYL@moria.home.lan>
 <20230525084731.losrlnarpbqtqzil@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525084731.losrlnarpbqtqzil@quack3>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 10:47:31AM +0200, Jan Kara wrote:
> If we submit direct IO that uses mapped file F at offset O as a buffer for
> direct IO from file F, offset O, it will currently livelock in an
> indefinite retry loop. It should rather return error or fall back to
> buffered IO. But that should be fixable. Andreas?
> 
> But if the buffer and direct IO range does not overlap, it will just
> happily work - iomap_dio_rw() invalidates only the range direct IO is done
> to.

*nod*

readahead triggered from the page fault path is another consideration.
No idea how that interacts with the gf2s method; IIRC there's a hack in
the page fault path that says somewhere "we may be getting called via
gup(), don't invoke readahead".

We could potentially kill that hack if we lifted this to the VFS layer.

> 
> > What happens if we race with the pages we faulted in being evicted?
> 
> We fault them in again and retry.
> 
> > > Also good that you've written a fstest for this, that is definitely a useful
> > > addition, although I suspect GFS2 guys added a test for this not so long
> > > ago when testing their stuff. Maybe they have a pointer handy?
> > 
> > More tests more good.
> > 
> > So if we want to lift this scheme to the VFS layer, we'd start by
> > replacing the lock you added (grepping for it, the name escapes me) with
> > a different type of lock - two_state_shared_lock in my code, it's like a
> > rw lock except writers don't exclude other writers. That way the DIO
> > path can use it without singlethreading writes to a single file.
> 
> Yes, I've noticed that you are introducing in bcachefs a lock with very
> similar semantics to mapping->invalidate_lock, just with this special lock
> type. What I'm kind of worried about with two_state_shared_lock as
> implemented in bcachefs is the fairness. AFAICS so far if someone is e.g.
> heavily faulting pages on a file, direct IO to that file can be starved
> indefinitely. That is IMHO not a good thing and I would not like to use
> this type of lock in VFS until this problem is resolved. But it should be
> fixable e.g. by introducing some kind of deadline for a waiter after which
> it will block acquisitions of the other lock state.

Yeah, my two_state_shared lock is definitely at the quick and dirty
prototype level, the implementation would need work. Lockdep support
would be another hard requirement.

The deadline might be a good idea, OTOH it'd want tuning. Maybe
something like what rwsem does where we block new read acquirerers if
there's a writer waiting would work.
