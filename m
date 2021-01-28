Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519243073B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhA1K2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 05:28:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:52576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231873AbhA1K2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:28:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E674ACC6;
        Thu, 28 Jan 2021 10:27:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 31D8A1E14D9; Thu, 28 Jan 2021 11:27:56 +0100 (CET)
Date:   Thu, 28 Jan 2021 11:27:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify_merge improvements
Message-ID: <20210128102756.GB3324@quack2.suse.cz>
References: <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
 <20200226143843.GT10728@quack2.suse.cz>
 <CAOQ4uxh+Mpr-f3LY5PHNDtCoqTrey69-339DabzSkhRR4cbUYA@mail.gmail.com>
 <CAOQ4uxj_C4EbzwwcrE09P5Z83WqmwNVdeZRJ6qNaThM3pkUinQ@mail.gmail.com>
 <20210125130149.GC1175@quack2.suse.cz>
 <CAOQ4uxiSSYr4bejwZBBPDjs1Vg_BUSSjY4YiUAgri=adHdOLuQ@mail.gmail.com>
 <20210127112416.GB3108@quack2.suse.cz>
 <CAOQ4uxhqm4kZ4sDpYqnknRTMbwfTft5zr=3P+ijV8ex5C_+y-w@mail.gmail.com>
 <20210127151525.GC13717@quack2.suse.cz>
 <CAOQ4uxhJJ9OJChGmf=wA_P80mGMqVaRStc0MM=ZiVZe2cbtEPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhJJ9OJChGmf=wA_P80mGMqVaRStc0MM=ZiVZe2cbtEPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-01-21 20:03:23, Amir Goldstein wrote:
> On Wed, Jan 27, 2021 at 5:15 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 27-01-21 14:57:56, Amir Goldstein wrote:
> > > On Wed, Jan 27, 2021 at 1:24 PM Jan Kara <jack@suse.cz> wrote:
> > > > > - With multi queue, high bit of obejctid will be masked for merge compare.
> > > > > - Instead, they will be used to store the next_qid to read from
> > > > >
> > > > > For example:
> > > > > - event #1 is added to queue 6
> > > > > - set group->last_qid = 6
> > > > > - set group->next_qid = 6 (because group->num_events == 1)
> > > > > - event #2 is added to queue 13
> > > > > - the next_qid bits of the last event in last_qid (6) queue are set to 13
> > > > > - set group->last_qid = 13
> > > > >
> > > > > - read() checks value of group->next_qid and reads the first event
> > > > > from queue 6 (event #1)
> > > > > - event #1 has 13 stored in next_qid bits so set group->next_qid = 13
> > > > > - read() reads first event from queue 13 (event #2)
> > > >
> > > > That's an interesting idea. I like it and I think it would work. Just
> > > > instead of masking, I'd use bitfields. Or we could just restrict objectid
> > > > to 32-bits and use remaining 32-bits for the next_qid pointer. I know it
> > > > will waste some bits but 32-bits of objectid should provide us with enough
> > > > space to avoid doing full event comparison in most cases
> > >
> > > Certainly.
> > > The entire set of objects to compare is going to be limited to 128*128,
> > > so 32bit should be plenty of hash bits.
> > > Simplicity is preferred.
> > >
> > > >  - BTW WRT naming I
> > > > find 'qid' somewhat confusing. Can we call it say 'next_bucket' or
> > > > something like that?
> > > >
> > >
> > > Sure. If its going to be 32bit, I can just call it next_key for simplicity
> > > and store the next event key instead of the next event bucket.
> > >
> > > > > Permission events require special care, but that is the idea of a simple
> > > > > singly linked list using qid's for reading events by insert order and
> > > > > merging by hashed queue.
> > > >
> > > > Why are permission events special in this regard?
> > > >
> > >
> > > They are not removed from the head of the queue, so
> > > middle event next_key may need to be updated when they
> > > are removed.
> >
> > Oh, you mean the special case when we receive a signal and thus remove
> > permission event from a notification queue? I forgot about that one and
> > yes, it needs a special handling...
> >
> > > I guess since permission events are not merged, they could
> > > use their own queue. If we do not care about ordering of
> > > permission events and non-permission events, we can treat this
> > > as a priority queue and it will simplify things considerably.
> > > Boosting priority of blocking hooks seems like the right thing to do.
> > > I wonder if we could make that change?
> >
> > Yes, permission events are not merged and I'm not aware of any users
> > actually mixing permission and other events in a notification group. OTOH
> > I'm somewhat reluctant to reorder events that much. It could break
> > someone, it could starve notification events, etc. AFAIU the pain with
> > permission events is updating the ->next_key field in case we want to remove
> > unreported permission event. Finding previous entry with this scheme is
> > indeed somewhat painful (we'd have to walk the queue which requires
> > maintaining 'cur' pointer for every queue). So maybe growing fsnotify_event
> > by one pointer to contain single linked list for a hash chain would be
> > simplest in the end? Then removing from the hash chain in the corner case of
> > tearing permission event out is simple enough...
> >
> 
> Better to disable the multi queue for the very uninteresting corner case (mixing
> permissions and non permissions) . The simplest thing to do is to enable multi
> queue only for FAN_CLASS_NOTIF. I suppose users do not use high priority
> classes for non-permission event use case and if they do, they will get less
> merged events - no big deal.
> 
> The important things we get are:
> 1. Code remains simple
> 2. Deterministic CPU usage (linear search is capped to 128 events)
> 3. In the most common use case of async change listener we can merge
>     events on up to 16K unique objects which should be sufficient
> 
> I'll try to write this up.

OK, sounds fine to me. We can always reconsider if some users come back
complaining...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
