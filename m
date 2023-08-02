Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13B76D9C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 23:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHBVmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHBVmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:42:19 -0400
Received: from out-70.mta0.migadu.com (out-70.mta0.migadu.com [IPv6:2001:41d0:1004:224b::46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F111BC7
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 14:42:16 -0700 (PDT)
Date:   Wed, 2 Aug 2023 17:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691012534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZzBQg5VUXqLAKjjN4npoHC5O8MdyP2pe5UxP8f8UCv0=;
        b=CY9jWmaOO/AQjkgCnBVJ1+PgFoc7NS1FexhWJqyh/hcsBz9oJ8ZJsAryVBNcutKnZazgGn
        uMYGXkTOPD/HJi6qqM/rca2STB17n6e3Gf+YF0XOjjZJekBp8VLo81Mt1W9//N3rpDOcWE
        QQ9pOpLGjwqcbbJdIWWRMe7zkw8zAl0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Message-ID: <20230802214211.y3x3swic4jbphmtg@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-12-kent.overstreet@linux.dev>
 <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
 <20230802204407.lk5mnj7ua6idddbd@moria.home.lan>
 <11d39248-31fc-c625-7c06-341f0146bd67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d39248-31fc-c625-7c06-341f0146bd67@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:09:13PM -0400, Waiman Long wrote:
> On 8/2/23 16:44, Kent Overstreet wrote:
> > On Wed, Aug 02, 2023 at 04:16:12PM -0400, Waiman Long wrote:
> > > On 7/12/23 17:11, Kent Overstreet wrote:
> > > > These are used by bcachefs's six locks.
> > > > 
> > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Waiman Long <longman@redhat.com>
> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > >    kernel/locking/osq_lock.c | 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > > > index d5610ad52b..b752ec5cc6 100644
> > > > --- a/kernel/locking/osq_lock.c
> > > > +++ b/kernel/locking/osq_lock.c
> > > > @@ -203,6 +203,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> > > >    	return false;
> > > >    }
> > > > +EXPORT_SYMBOL_GPL(osq_lock);
> > > >    void osq_unlock(struct optimistic_spin_queue *lock)
> > > >    {
> > > > @@ -230,3 +231,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
> > > >    	if (next)
> > > >    		WRITE_ONCE(next->locked, 1);
> > > >    }
> > > > +EXPORT_SYMBOL_GPL(osq_unlock);
> > > Have you considered extending the current rw_semaphore to support a SIX lock
> > > semantics? There are a number of instances in the kernel that a up_read() is
> > > followed by a down_write(). Basically, the code try to upgrade the lock from
> > > read to write. I have been thinking about adding a upgrade_read() API to do
> > > that. However, the concern that I had was that another writer may come in
> > > and make modification before the reader can be upgraded to have exclusive
> > > write access and will make the task to repeat what has been done in the read
> > > lock part. By adding a read with intent to upgrade to write, we can have
> > > that guarantee.
> > It's been discussed, Linus had the same thought.
> > 
> > But it'd be a massive change to the rw semaphore code; this "read with
> > intent" really is a third lock state which needs all the same
> > lock/trylock/unlock paths, and with the way rw semaphore has separate
> > entry points for read and write it'd be a _ton_ of new code. It really
> > touches everything - waitlist handling included.
> 
> Yes, it is a major change, but I had done that before and it is certainly
> doable. There are spare bits in the low byte of rwsem->count that can be
> used as an intent bit. We also need to add a new rwsem_wake_type for that
> for waitlist handling.
> 
> 
> > 
> > And six locks have several other features that bcachefs needs, and other
> > users may also end up wanting, that rw semaphores don't have; the two
> > main features being a percpu read lock mode and support for an external
> > cycle detector (which requires exposing lock waitlists, with some
> > guarantees about how those waitlists are used).
> 
> Can you provide more information about those features?
> 
> > 
> > > With that said, I would prefer to keep osq_{lock/unlock} for internal use by
> > > some higher level locking primitives - mutex, rwsem and rt_mutex.
> > Yeah, I'm aware, but it seems like exposing osq_(lock|unlock) is the
> > most palatable solution for now. Long term, I'd like to get six locks
> > promoted to kernel/locking.
> 
> Your SIX overlaps with rwsem in term of features. So we will have to somehow
> merge them instead of having 2 APIs with somewhat similar functionality.

Waiman, if you think you can add all the features of six locks to rwsem,
knock yourself out - but right now this is a vaporware idea for you, not
something I can seriously entertain. I'm looking to merge bcachefs next
cycle, not sit around and bikeshed for the next six months.

If you start making a serious effort on adding those features to rwsem
I'll start walking you through everything six locks has, but right now
this is a major digression on a patch that just exports two symbols.
