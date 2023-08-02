Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034C76D8C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 22:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjHBUoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 16:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjHBUoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:44:16 -0400
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0341FF2
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 13:44:15 -0700 (PDT)
Date:   Wed, 2 Aug 2023 16:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691009052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+6roQ7aDRsYVdornB0/QF0ZuvdFIKibmGJzuhAsITs=;
        b=ngeef85pSI2YC4jwYc5pAWo8dkd1cu30hUu+UEEnBkdZVQTzhpvjKba/HvVG8IgedQP6OH
        ZSRI9qOAxm8Gcm5slEkz9Z/SDXNIm8rTJ30ShPoAXtsCFJho4AY34yp1favy4BFlfFovSM
        BGh4hdqt0vugZWHSczxCqfuL8KS6FbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 11/20] locking/osq: Export osq_(lock|unlock)
Message-ID: <20230802204407.lk5mnj7ua6idddbd@moria.home.lan>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-12-kent.overstreet@linux.dev>
 <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb77f456-8804-b63a-7868-19e0cd9e697f@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 04:16:12PM -0400, Waiman Long wrote:
> On 7/12/23 17:11, Kent Overstreet wrote:
> > These are used by bcachefs's six locks.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >   kernel/locking/osq_lock.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > index d5610ad52b..b752ec5cc6 100644
> > --- a/kernel/locking/osq_lock.c
> > +++ b/kernel/locking/osq_lock.c
> > @@ -203,6 +203,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> >   	return false;
> >   }
> > +EXPORT_SYMBOL_GPL(osq_lock);
> >   void osq_unlock(struct optimistic_spin_queue *lock)
> >   {
> > @@ -230,3 +231,4 @@ void osq_unlock(struct optimistic_spin_queue *lock)
> >   	if (next)
> >   		WRITE_ONCE(next->locked, 1);
> >   }
> > +EXPORT_SYMBOL_GPL(osq_unlock);
> 
> Have you considered extending the current rw_semaphore to support a SIX lock
> semantics? There are a number of instances in the kernel that a up_read() is
> followed by a down_write(). Basically, the code try to upgrade the lock from
> read to write. I have been thinking about adding a upgrade_read() API to do
> that. However, the concern that I had was that another writer may come in
> and make modification before the reader can be upgraded to have exclusive
> write access and will make the task to repeat what has been done in the read
> lock part. By adding a read with intent to upgrade to write, we can have
> that guarantee.

It's been discussed, Linus had the same thought.

But it'd be a massive change to the rw semaphore code; this "read with
intent" really is a third lock state which needs all the same
lock/trylock/unlock paths, and with the way rw semaphore has separate
entry points for read and write it'd be a _ton_ of new code. It really
touches everything - waitlist handling included.

And six locks have several other features that bcachefs needs, and other
users may also end up wanting, that rw semaphores don't have; the two
main features being a percpu read lock mode and support for an external
cycle detector (which requires exposing lock waitlists, with some
guarantees about how those waitlists are used).

> With that said, I would prefer to keep osq_{lock/unlock} for internal use by
> some higher level locking primitives - mutex, rwsem and rt_mutex.

Yeah, I'm aware, but it seems like exposing osq_(lock|unlock) is the
most palatable solution for now. Long term, I'd like to get six locks
promoted to kernel/locking.
