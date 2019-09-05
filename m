Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCCAA9F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbfIER1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 13:27:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbfIER1Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:27:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55CE6AC49;
        Thu,  5 Sep 2019 17:27:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Sep 2019 19:27:13 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Heiher <r@hev.cc>
Cc:     Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        Eric Wong <e@80x24.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested
 epoll
In-Reply-To: <CAHirt9iZAj67FVnhd9ORp2Sk2xAXHDrJ2BANf4VrtM4dLWv9ww@mail.gmail.com>
References: <20190902052034.16423-1-r@hev.cc>
 <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
 <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com>
 <23659bc3e5f80efe9746aefd4d6791e8@suse.de>
 <341df9eb-7e8e-98c8-5183-402bdfff7d59@akamai.com>
 <CAHirt9hra2tA_OPNSow+CgD_CF2Z11ZqGG=1P45noqtdMtWuJw@mail.gmail.com>
 <CAHirt9j+DSR+uP-SBLHn0ika86uixSOPLXft+vVj5G5Ge0xr5w@mail.gmail.com>
 <CAHirt9iZAj67FVnhd9ORp2Sk2xAXHDrJ2BANf4VrtM4dLWv9ww@mail.gmail.com>
Message-ID: <d5914273597707b8780d188688fe0ac2@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-09-05 11:56, Heiher wrote:
> Hi,
> 
> On Thu, Sep 5, 2019 at 10:53 AM Heiher <r@hev.cc> wrote:
>> 
>> Hi,
>> 
>> I created an epoll wakeup test project, listed some possible cases,
>> and any other corner cases needs to be added?
>> 
>> https://github.com/heiher/epoll-wakeup/blob/master/README.md
>> 
>> On Wed, Sep 4, 2019 at 10:02 PM Heiher <r@hev.cc> wrote:
>> >
>> > Hi,
>> >
>> > On Wed, Sep 4, 2019 at 8:02 PM Jason Baron <jbaron@akamai.com> wrote:
>> > >
>> > >
>> > >
>> > > On 9/4/19 5:57 AM, Roman Penyaev wrote:
>> > > > On 2019-09-03 23:08, Jason Baron wrote:
>> > > >> On 9/2/19 11:36 AM, Roman Penyaev wrote:
>> > > >>> Hi,
>> > > >>>
>> > > >>> This is indeed a bug. (quick side note: could you please remove efd[1]
>> > > >>> from your test, because it is not related to the reproduction of a
>> > > >>> current bug).
>> > > >>>
>> > > >>> Your patch lacks a good description, what exactly you've fixed.  Let
>> > > >>> me speak out loud and please correct me if I'm wrong, my understanding
>> > > >>> of epoll internals has become a bit rusty: when epoll fds are nested
>> > > >>> an attempt to harvest events (ep_scan_ready_list() call) produces a
>> > > >>> second (repeated) event from an internal fd up to an external fd:
>> > > >>>
>> > > >>>      epoll_wait(efd[0], ...):
>> > > >>>        ep_send_events():
>> > > >>>           ep_scan_ready_list(depth=0):
>> > > >>>             ep_send_events_proc():
>> > > >>>                 ep_item_poll():
>> > > >>>                   ep_scan_ready_list(depth=1):
>> > > >>>                     ep_poll_safewake():
>> > > >>>                       ep_poll_callback()
>> > > >>>                         list_add_tail(&epi, &epi->rdllist);
>> > > >>>                         ^^^^^^
>> > > >>>                         repeated event
>> > > >>>
>> > > >>>
>> > > >>> In your patch you forbid wakeup for the cases, where depth != 0, i.e.
>> > > >>> for all nested cases. That seems clear.  But what if we can go further
>> > > >>> and remove the whole chunk, which seems excessive:
>> > > >>>
>> > > >>> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
>> > > >>> eventpoll *ep,
>> > > >>>
>> > > >>> -
>> > > >>> -       if (!list_empty(&ep->rdllist)) {
>> > > >>> -               /*
>> > > >>> -                * Wake up (if active) both the eventpoll wait list and
>> > > >>> -                * the ->poll() wait list (delayed after we release the
>> > > >>> lock).
>> > > >>> -                */
>> > > >>> -               if (waitqueue_active(&ep->wq))
>> > > >>> -                       wake_up(&ep->wq);
>> > > >>> -               if (waitqueue_active(&ep->poll_wait))
>> > > >>> -                       pwake++;
>> > > >>> -       }
>> > > >>>         write_unlock_irq(&ep->lock);
>> > > >>>
>> > > >>>         if (!ep_locked)
>> > > >>>                 mutex_unlock(&ep->mtx);
>> > > >>>
>> > > >>> -       /* We have to call this outside the lock */
>> > > >>> -       if (pwake)
>> > > >>> -               ep_poll_safewake(&ep->poll_wait);
>> > > >>>
>> > > >>>
>> > > >>> I reason like that: by the time we've reached the point of scanning events
>> > > >>> for readiness all wakeups from ep_poll_callback have been already fired and
>> > > >>> new events have been already accounted in ready list (ep_poll_callback()
>> > > >>> calls
>> > > >>> the same ep_poll_safewake()). Here, frankly, I'm not 100% sure and probably
>> > > >>> missing some corner cases.
>> > > >>>
>> > > >>> Thoughts?
>> > > >>
>> > > >> So the: 'wake_up(&ep->wq);' part, I think is about waking up other
>> > > >> threads that may be in waiting in epoll_wait(). For example, there may
>> > > >> be multiple threads doing epoll_wait() on the same epoll fd, and the
>> > > >> logic above seems to say thread 1 may have processed say N events and
>> > > >> now its going to to go off to work those, so let's wake up thread 2 now
>> > > >> to handle the next chunk.
>> > > >
>> > > > Not quite. Thread which calls ep_scan_ready_list() processes all the
>> > > > events, and while processing those, removes them one by one from the
>> > > > ready list.  But if event mask is !0 and event belongs to
>> > > > Level Triggered Mode descriptor (let's say default mode) it tails event
>> > > > again back to the list (because we are in level mode, so event should
>> > > > be there).  So at the end of this traversing loop ready list is likely
>> > > > not empty, and if so, wake up again is called for nested epoll fds.
>> > > > But, those nested epoll fds should get already all the notifications
>> > > > from the main event callback ep_poll_callback(), regardless any thread
>> > > > which traverses events.
>> > > >
>> > > > I suppose this logic exists for decades, when Davide (the author) was
>> > > > reshuffling the code here and there.
>> > > >
>> > > > But I do not feel confidence to state that this extra wakeup is bogus,
>> > > > I just have a gut feeling that it looks excessive.
>> > >
>> > > Note that I was talking about the wakeup done on ep->wq not ep->poll_wait.
>> > > The path that I'm concerned about is let's say that there are N events
>> > > queued on the ready list. A thread that was woken up in epoll_wait may
>> > > decide to only process say N/2 of then. Then it will call wakeup on ep->wq
>> > > and this will wakeup another thread to process the remaining N/2. Without
>> > > the wakeup, the original thread isn't going to process the events until
>> > > it finishes with the original N/2 and gets back to epoll_wait(). So I'm not
>> > > sure how important that path is but I wanted to at least note the change
>> > > here would impact that behavior.
>> > >
>> > > Thanks,
>> > >
>> > > -Jason
>> > >
>> > >
>> > > >
>> > > >> So I think removing all that even for the
>> > > >> depth 0 case is going to change some behavior here. So perhaps, it
>> > > >> should be removed for all depths except for 0? And if so, it may be
>> > > >> better to make 2 patches here to separate these changes.
>> > > >>
>> > > >> For the nested wakeups, I agree that the extra wakeups seem unnecessary
>> > > >> and it may make sense to remove them for all depths. I don't think the
>> > > >> nested epoll semantics are particularly well spelled out, and afaict,
>> > > >> nested epoll() has behaved this way for quite some time. And the current
>> > > >> behavior is not bad in the way that a missing wakeup or false negative
>> > > >> would be.
>> > > >
>> > > > That's 100% true! For edge mode extra wake up is not a bug, not optimal
>> > > > for userspace - yes, but that can't lead to any lost wakeups.
>> > > >
>> > > > --
>> > > > Roman
>> > > >
>> >
>> > I tried to remove the whole chunk of code that Roman said, and it
>> > seems that there
>> > are no obvious problems with the two test programs below:
> 
> I recall this message, the test case 9/25/26 of epoll-wakeup (on
> github) are failed while
> the whole chunk are removed.
> 
> Apply the original patch, all tests passed.


These are failing on my bare 5.2.0-rc2

TEST  bin/epoll31       FAIL
TEST  bin/epoll46       FAIL
TEST  bin/epoll50       FAIL
TEST  bin/epoll32       FAIL
TEST  bin/epoll19       FAIL
TEST  bin/epoll27       FAIL
TEST  bin/epoll42       FAIL
TEST  bin/epoll34       FAIL
TEST  bin/epoll48       FAIL
TEST  bin/epoll40       FAIL
TEST  bin/epoll20       FAIL
TEST  bin/epoll28       FAIL
TEST  bin/epoll38       FAIL
TEST  bin/epoll52       FAIL
TEST  bin/epoll24       FAIL
TEST  bin/epoll23       FAIL


These are failing if your patch is applied:
(my 5.2.0-rc2 is old? broken?)

TEST  bin/epoll46       FAIL
TEST  bin/epoll42       FAIL
TEST  bin/epoll34       FAIL
TEST  bin/epoll48       FAIL
TEST  bin/epoll40       FAIL
TEST  bin/epoll44       FAIL
TEST  bin/epoll38       FAIL

These are failing if "ep_poll_safewake(&ep->poll_wait)" is not called,
but wakeup(&ep->wq); is still invoked:

TEST  bin/epoll46       FAIL
TEST  bin/epoll42       FAIL
TEST  bin/epoll34       FAIL
TEST  bin/epoll40       FAIL
TEST  bin/epoll44       FAIL
TEST  bin/epoll38       FAIL

So at least 48 has been "fixed".

These are failing if the whole chunk is removed, like your
said 9,25,26 are among which do not pass:

TEST  bin/epoll26       FAIL
TEST  bin/epoll42       FAIL
TEST  bin/epoll34       FAIL
TEST  bin/epoll9        FAIL
TEST  bin/epoll48       FAIL
TEST  bin/epoll40       FAIL
TEST  bin/epoll25       FAIL
TEST  bin/epoll44       FAIL
TEST  bin/epoll38       FAIL

This can be a good test suite, probably can be added to kselftests?

--
Roman

