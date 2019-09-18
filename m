Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10233B6876
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfIRQs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 12:48:58 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:46053 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbfIRQs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:48:58 -0400
Received: by mail-lf1-f43.google.com with SMTP id r134so154404lff.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86ZUn97/3KZwNNgVgFqkj5nnsJKKhe/XOuAYAPGVnyg=;
        b=CyLWlrJoS3bO7FoH77HyM4XEqzmX9zqgMXKEBMrGTDXCSDubDkAV6dEVe9f+9NU6ps
         TjIQho7CvgDPZyQ2qs0MfWbp+zWKGSXvdZ4IBJgiegj5BiaixElPEV/qUQVMRqfs505T
         j+1vHPZbB2Dvu8j2pvIkSc4y42bGPAM9/jxKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86ZUn97/3KZwNNgVgFqkj5nnsJKKhe/XOuAYAPGVnyg=;
        b=ja6zWNxqjgoePF2ooLk1fEzJsIGEz+Mq88W4uQPhHU3kWxe+y1A7MSMsGzj+enZLLg
         +33U+neGbHS4MytpqcQuDgxxLFMBHp94GrWuKu4yFUg26/cna/inCRkHMg296Op2cYNv
         tZUhPd3Ah5rQB1r9M2PDYz1cXOK73mhA7j+N91fvxqkD2FUUDmxOr5FixW8GQasCUWpg
         p0a/gkFQ0qYAB2OC+A9JpEOV7A/ZCWDJFMeEvRwpiBTwSdmaZmmXjVuKnevmUvz+MgpC
         23N+Pm+RHrRlcyKyHU24o53qQiAnfvwMKXqzcW+ou1uUimFW/AuS8DNUvt4Yryb2ig3z
         9zjA==
X-Gm-Message-State: APjAAAWhUxPSCWLWl+65nYbRakLLJYOTnFmF8A3yfXC3lhEkIaWozuzb
        9t5qzmSqzRNN4Wt34aaH4ui1EnyQUYY=
X-Google-Smtp-Source: APXvYqwjhPNsZSuvEDOijs4ywUMbdpntrw7GCxiyGkLtDSVOS1xAdILzP8a8PXUkMQZPucq/SmJpnA==
X-Received: by 2002:ac2:483a:: with SMTP id 26mr2559042lft.188.1568825335142;
        Wed, 18 Sep 2019 09:48:55 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z9sm1129849ljn.78.2019.09.18.09.48.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 09:48:54 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y23so629570ljn.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 09:48:53 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr2848073lji.52.1568825333672;
 Wed, 18 Sep 2019 09:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk> <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck> <15228.1568821380@warthog.procyon.org.uk>
In-Reply-To: <15228.1568821380@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 09:48:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
Message-ID: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
To:     David Howells <dhowells@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:43 AM David Howells <dhowells@redhat.com> wrote:
>
> It mandates using smp_store_release() to update buffer->head in the producer
> and buffer->tail in the consumer - but these need pairing with memory barriers
> used when reading buffer->head and buffer->tail on the other side.

No, the rule with smp_store_release() should be that it's paired with
"smp_load_acquire()". No other barriers needed.

If you do that

   thread #1            thread #2

   ... add data to queue ..
   smp_store_release(x)

                        smp_load_acquire(x)
                        ... read data from queue ..

then you should need no other barriers.

But yes, store_release(x) should always pair with the load_acquire(x),
and the guarantee is that if the load_acquire reads the value that the
store_release stored, then all subsequent reads in thread #2 will see
all preceding writes in thread #1.

That's the optimal locking for a simple queue with a reader and a
writer and no other locking needed between the two.

HOWEVER.

I think this is all entirely pointless wrt the pipe buffer use. You
don't have a simple queue. You have multiple writers, and you have
multiple readers. As a result, you need real locking.

So don't do the barriers. If you do the barriers, you're almost
certainly doing something buggy. You don't have the simple "consumer
-> producer" thing. Or rather, you don't _only_ have that thing.

A reader "produces" a new tail as far as the writer is concerned (so
the reader that has consumed an entry does a smp_store_release(tail)
-> smp_load_acquire(tail) on the writer side when the writer looks for
a new entry it can fill).

BUT! A writer also needs to make sure it's the *only* writer for that
new entry, and similarly a reader that is about to consume an entry
needs to make sure it's the only reader of that entry. So it is *not*
that kind of simple hand-off situation at all.

End result: use a lock. Seriously. Anything else is going to be buggy,
or going to be incredibly subtle.

Don't do those barriers. They are wrong. Barriers simply do not
protect against two concurrent readers, or two concurrent writers.
Barriers are useless.

Now, it's possible that barriers together with very clever atomics
could do a lockless model, but then all the cleverness is going to be
in the lockless part of the code, not the barriers. So even if we
eventually do a lockless model, it's completely wrong to do the
barriers first.

And no, lockless isn't as simple as "readers can do a
atomic_add_return_relaxed() to consume an entry, and writers can do a
atomic_cmpxchg() to produce one".

I think the only possible lockless model is that readers have some
exclusion against other readers (so now you have only one reader at a
time), and then you fundamentally know that a reader can update the
tail pointer without worrying about any races (because a reader will
never race against another reader, and a writer will only ever _read_
the tail pointer). So then - once you have reader-reader exclusion,
the _tail_ update is simple:

    smp_store_release(old_tail+1, &tail);

because while there are multiple writers, the reader doesn't care (the
above, btw, assumes that head/tail themselves aren't doing the "&
bufsize" thing, and that that is done at use time - that also makes it
easy to see the difference between empty and full).

But this still requires that lock around all readers. And we have
that: the pipe mutex.

But writers have the same issue, and we don't want to use the pipe
mutex for writer exclusion, since we want to allow atomic writers.

So writers do have to have a lock, or they need to do something clever
with a reservation system that uses cmpxchg. Honestly, just do the
lock.

The way this should be done:

 1) do the head/tail conversion using the EXISTING locking. We have
the pipe_mutex, and it serializes everybody right now, and it makes
any barriers or atomics pointless. Just covert to a sane and simple
head/tail model.

    NO BARRIERS!

*after* you've done this, do the next phase:

 2) convert the writers to use an irq-safe spinlock, and either make
the readers look at it too, or do the above smp_store_release() for
the final tail update (and the writers need to use a
smp_load_acquire() to look at the tail, despite their lock).

    NO BARRIERS (well, outside the tail thing above).

and *after* you've done #2, you can now do writes from atomic context.

At that point you are done. Consider youself happy, but also allow for
the possibility that some day you'll see lock contention with lots of
writers, and that *maybe* some day (unlikely) you'd want to look at
doing

 3) see if you can make the writers do some clever lockless reservation model.

But that #3 really should be considered a "we are pretty sure it's
possible in theory, but it's questinably useful, and hopefully we'll
never even need to consider it".

                Linus
