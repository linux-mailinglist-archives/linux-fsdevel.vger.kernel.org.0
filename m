Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237D777FE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjHJSCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjHJSCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:02:53 -0400
Received: from out-80.mta0.migadu.com (out-80.mta0.migadu.com [IPv6:2001:41d0:1004:224b::50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF352715
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 11:02:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691690569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8dtvltwxe9GpUk64vNVIpMuGwfyjEXky0AlDC9nQsl0=;
        b=evMeZLbwLASvgab2eASCSsx0BMJ3x+w8WmFhkv/BkD/Kb3qE86IPqp18nTVQBZ/dE6tTNJ
        cZumN7IH0wNK9a87gcxHRn3pzm22IwQXRXihkmrzkjPNAW3cRLN6OZl0Y+lGmm14TN+KpF
        iwT0y4VQAjvOc3JTQxouA66IJBTstwA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230810180244.cx3vouaqtisklttn@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <CAHk-=wie4U8hwRN+nYRwV4G51qXPJKr0DpjbxO1XSMZnPA_LTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wie4U8hwRN+nYRwV4G51qXPJKr0DpjbxO1XSMZnPA_LTw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:40:08AM -0700, Linus Torvalds wrote:
> > > Some of the other oddity is around the this_cpu ops, but I suspect
> > > that is at least partly then because we don't have acquire/release
> > > versions of the local cpu ops that the code looks like it would want.
> >
> > You mean using full barriers where acquire/release would be sufficient?
> 
> Yes.
> 
> That code looks like it should work, but be hugely less efficient than
> it might be. "smp_mb()" tends to be expensive everywhere, even x86.

do_six_unlock_type() doesn't need a full barrier, but I'm not sure we
can avoid the one in __do_six_trylock(), in the percpu reader path.

> Of course, I might be missing some other cases. That percpu reader
> queue worries me a bit just because it ends up generating ordering
> based on two different things - the lock word _and_ the percpu word.
> 
> And I get very nervous if the final "this gets the lock" isn't some
> obvious "try_cmpxchg_acquire()" or similar, just because we've
> historically had *so* many very subtle bugs in just about every single
> lock we've ever had.

kernel/locking/percpu-rwsem.c uses the same idea. The difference is that
percpu-rwsem avoids the memory barrier on the read side in the fast path
at the cost of requiring an rcu barrier on the write side... and all the
crazyness that entails.

But __percpu_down_read_trylock() uses the same algorithm I'm using,
including the same smp_mb(): we need to ensure that the read of the lock
state happens after the store to the percpu read count, and I don't know
how to that without a smp_mb() - smp_store_acquire() isn't a thing.

> > Matthew was planning on sending the iov_iter patch to you - right around
> > now, I believe, as a bugfix, since right now
> > copy_page_from_iter_atomic() silently does crazy things if you pass it a
> > compound page.
> >
> > Block layer patches aside, are there any _others_ you really want to go
> > via maintainers?
> 
> It was mainly just the iov and the block layer.
> 
> The superblock cases I really don't understand why you insist on just
> being different from everybody else.
> 
> Your exclusivity arguments make no sense to me. Just open the damn
> thing. No other filesystem has ever had the fundamental problems you
> describe. You can do any exclusivity test you want in the
> "test()/set()" functions passed to sget().

When using sget() in the conventional way it's not possible for
FMODE_EXCL to protect against concurrent opens scribbling over each
other because we open the block device before checking if it's already
mounted, and we expect that open to succeed.

> You say that it's a problem because of a "single spinlock", but it
> hasn't been a problem for anybody else.

The spinlock means you can't do the actual open in set(), which is why
the block device has to be opened in not-really-exclusive mode.

I think it's be possible to change the locking in sget() so that the
set() callback could do the open, but I haven't looked closely at it.

> and basically sent your first pull request as a fait-accompli.

When did I ever do that?
