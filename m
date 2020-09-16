Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841A826C1D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIPKiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 06:38:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbgIPKfI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:35:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2CF4ACE3;
        Wed, 16 Sep 2020 10:35:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 119301E12E1; Wed, 16 Sep 2020 12:34:46 +0200 (CEST)
Date:   Wed, 16 Sep 2020 12:34:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200916103446.GB3607@quack2.suse.cz>
References: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net>
 <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
 <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com>
 <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
 <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
 <37989469-f88c-199b-d779-ed41bc65fe56@tessares.net>
 <CAHk-=wj8Bi5Kiufw8_1SEMmxc0GCO5Nh7TxEt+c1HdKaya=LaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8Bi5Kiufw8_1SEMmxc0GCO5Nh7TxEt+c1HdKaya=LaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-09-20 16:35:45, Linus Torvalds wrote:
> On Tue, Sep 15, 2020 at 12:56 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
> >
> > I am sorry, I am not sure how to verify this. I guess it was one
> > processor because I removed "-smp 2" option from qemu. So I guess it
> > switched to a uniprocessor mode.
> 
> Ok, that all sounds fine. So yes, your problem happens even with just
> one CPU, and it's not any subtle SMP race.
> 
> Which is all good - apart from the bug existing in the first place, of
> course. It just reinforces the "it's probably a latent deadlock"
> thing.

So from the traces another theory that appeared to me is that it could be a
"missed wakeup" problem. Looking at the code in wait_on_page_bit_common() I
found one suspicious thing (which isn't a great match because the problem
seems to happen on UP as well and I think it's mostly a theoretical issue but
still I'll write it here):

wait_on_page_bit_common() has:

        spin_lock_irq(&q->lock);
        SetPageWaiters(page);
        if (!trylock_page_bit_common(page, bit_nr, wait))
	  - which expands to:
	  (
	        if (wait->flags & WQ_FLAG_EXCLUSIVE) {
        	        if (test_and_set_bit(bit_nr, &page->flags))
                	        return false;
	        } else if (test_bit(bit_nr, &page->flags))
        	        return false;
	  )

                __add_wait_queue_entry_tail(q, wait);
        spin_unlock_irq(&q->lock);

Now the suspicious thing is the ordering here. What prevents the compiler
(or the CPU for that matter) from reordering SetPageWaiters() call behind
the __add_wait_queue_entry_tail() call? I know SetPageWaiters() and
test_and_set_bit() operate on the same long but is it really guaranteed
something doesn't reorder these?

In unlock_page() we have:

        if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
                wake_up_page_bit(page, PG_locked);

So if the reordering happens, clear_bit_unlock_is_negative_byte() could
return false even though we have a waiter queued.

And this seems to be a thing commit 2a9127fcf22 ("mm: rewrite
wait_on_page_bit_common() logic") introduced because before we had
set_current_state() between SetPageWaiters() and test_bit() which implies a
memory barrier.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
