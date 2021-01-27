Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1F305F4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 16:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbhA0PQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 10:16:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:56444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343642AbhA0PQH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:16:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAC86B74D;
        Wed, 27 Jan 2021 15:15:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DF891E14D0; Wed, 27 Jan 2021 16:15:25 +0100 (CET)
Date:   Wed, 27 Jan 2021 16:15:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify_merge improvements
Message-ID: <20210127151525.GC13717@quack2.suse.cz>
References: <20200217131455.31107-9-amir73il@gmail.com>
 <20200226091804.GD10728@quack2.suse.cz>
 <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
 <20200226143843.GT10728@quack2.suse.cz>
 <CAOQ4uxh+Mpr-f3LY5PHNDtCoqTrey69-339DabzSkhRR4cbUYA@mail.gmail.com>
 <CAOQ4uxj_C4EbzwwcrE09P5Z83WqmwNVdeZRJ6qNaThM3pkUinQ@mail.gmail.com>
 <20210125130149.GC1175@quack2.suse.cz>
 <CAOQ4uxiSSYr4bejwZBBPDjs1Vg_BUSSjY4YiUAgri=adHdOLuQ@mail.gmail.com>
 <20210127112416.GB3108@quack2.suse.cz>
 <CAOQ4uxhqm4kZ4sDpYqnknRTMbwfTft5zr=3P+ijV8ex5C_+y-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhqm4kZ4sDpYqnknRTMbwfTft5zr=3P+ijV8ex5C_+y-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-01-21 14:57:56, Amir Goldstein wrote:
> On Wed, Jan 27, 2021 at 1:24 PM Jan Kara <jack@suse.cz> wrote:
> > > - With multi queue, high bit of obejctid will be masked for merge compare.
> > > - Instead, they will be used to store the next_qid to read from
> > >
> > > For example:
> > > - event #1 is added to queue 6
> > > - set group->last_qid = 6
> > > - set group->next_qid = 6 (because group->num_events == 1)
> > > - event #2 is added to queue 13
> > > - the next_qid bits of the last event in last_qid (6) queue are set to 13
> > > - set group->last_qid = 13
> > >
> > > - read() checks value of group->next_qid and reads the first event
> > > from queue 6 (event #1)
> > > - event #1 has 13 stored in next_qid bits so set group->next_qid = 13
> > > - read() reads first event from queue 13 (event #2)
> >
> > That's an interesting idea. I like it and I think it would work. Just
> > instead of masking, I'd use bitfields. Or we could just restrict objectid
> > to 32-bits and use remaining 32-bits for the next_qid pointer. I know it
> > will waste some bits but 32-bits of objectid should provide us with enough
> > space to avoid doing full event comparison in most cases
> 
> Certainly.
> The entire set of objects to compare is going to be limited to 128*128,
> so 32bit should be plenty of hash bits.
> Simplicity is preferred.
> 
> >  - BTW WRT naming I
> > find 'qid' somewhat confusing. Can we call it say 'next_bucket' or
> > something like that?
> >
> 
> Sure. If its going to be 32bit, I can just call it next_key for simplicity
> and store the next event key instead of the next event bucket.
> 
> > > Permission events require special care, but that is the idea of a simple
> > > singly linked list using qid's for reading events by insert order and
> > > merging by hashed queue.
> >
> > Why are permission events special in this regard?
> >
> 
> They are not removed from the head of the queue, so
> middle event next_key may need to be updated when they
> are removed.

Oh, you mean the special case when we receive a signal and thus remove
permission event from a notification queue? I forgot about that one and
yes, it needs a special handling...

> I guess since permission events are not merged, they could
> use their own queue. If we do not care about ordering of
> permission events and non-permission events, we can treat this
> as a priority queue and it will simplify things considerably.
> Boosting priority of blocking hooks seems like the right thing to do.
> I wonder if we could make that change?

Yes, permission events are not merged and I'm not aware of any users
actually mixing permission and other events in a notification group. OTOH
I'm somewhat reluctant to reorder events that much. It could break
someone, it could starve notification events, etc. AFAIU the pain with
permission events is updating the ->next_key field in case we want to remove
unreported permission event. Finding previous entry with this scheme is
indeed somewhat painful (we'd have to walk the queue which requires
maintaining 'cur' pointer for every queue). So maybe growing fsnotify_event
by one pointer to contain single linked list for a hash chain would be
simplest in the end? Then removing from the hash chain in the corner case of
tearing permission event out is simple enough...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
