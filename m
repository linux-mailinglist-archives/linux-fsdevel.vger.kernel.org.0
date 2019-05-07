Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183A216135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEGJkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 05:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfEGJkV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 05:40:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF46C3082E4D;
        Tue,  7 May 2019 09:40:20 +0000 (UTC)
Received: from work (unknown [10.40.205.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36D1760BEC;
        Tue,  7 May 2019 09:40:19 +0000 (UTC)
Date:   Tue, 7 May 2019 11:40:15 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Tulak <jtulak@redhat.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: Testing devices for discard support properly
Message-ID: <20190507094015.hb76w3rjzx7shxjp@work>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507071021.wtm25mxx2as6babr@work>
 <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 07 May 2019 09:40:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 10:48:55AM +0200, Jan Tulak wrote:
> On Tue, May 7, 2019 at 9:10 AM Lukas Czerner <lczerner@redhat.com> wrote:
> >
> > On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
> > >
> ...
> > >
> > > * Whole device discard at the block level both for a device that has been
> > > completely written and for one that had already been trimmed
> >
> > Yes, usefull. Also note that a long time ago when I've done the testing
> > I noticed that after a discard request, especially after whole device
> > discard, the read/write IO performance went down significanly for some
> > drives. I am sure things have changed, but I think it would be
> > interesting to see how does it behave now.
> >
> > >
> > > * Discard performance at the block level for 4k discards for a device that
> > > has been completely written and again the same test for a device that has
> > > been completely discarded.
> > >
> > > * Same test for large discards - say at a megabyte and/or gigabyte size?
> >
> > From my testing (again it was long time ago and things probably changed
> > since then) most of the drives I've seen had largely the same or similar
> > timing for discard request regardless of the size (hence, the conclusion
> > was the bigger the request the better). A small variation I did see
> > could have been explained by kernel implementation and discard_max_bytes
> > limitations as well.
> >
> > >
> > > * Same test done at the device optimal discard chunk size and alignment
> > >
> > > Should the discard pattern be done with a random pattern? Or just
> > > sequential?
> >
> > I think that all of the above will be interesting. However there are two
> > sides of it. One is just pure discard performance to figure out what
> > could be the expectations and the other will be "real" workload
> > performance. Since from my experience discard can have an impact on
> > drive IO performance beyond of what's obvious, testing mixed workload
> > (IO + discard) is going to be very important as well. And that's where
> > fio workloads can come in (I actually do not know if fio already
> > supports this or not).
> >
> 
> And:
> 
> On Tue, May 7, 2019 at 10:22 AM Nikolay Borisov <nborisov@suse.com> wrote:
> > I have some vague recollection this was brought up before but how sure
> > are we that when a discard request is sent down to disk and a response
> > is returned the actual data has indeed been discarded. What about NCQ
> > effects i.e "instant completion" while doing work in the background. Or
> > ignoring the discard request altogether?
> 
> 
> As Nikolay writes in the other thread, I too have a feeling that there
> have been a discard-related discussion at LSF/MM before. And if I
> remember, there were hints that the drives (sometimes) do asynchronous
> trim after returning a success. Which would explain the similar time
> for all sizes and IO drop after trim.

Yes, that was definitely the case  in the past. It's also why we've
seen IO performance drop after a big (whole device) discard as the
device was busy in the background.

However Nikolay does have a point. IIRC device is free to ignore discard
requests, I do not think there is any reliable way to actually tell that
the data was really discarded. I can even imagine a situation that the
device is not going to do anything unless it's pass some threshold of
free blocks for wear leveling. If that's the case our tests are not
going to be very useful unless they do stress such corner cases. But
that's just my speculation, so someone with a better knowledge of what
vendors are doing might tell us if it's something to worry about or not.

> 
> So, I think that the mixed workload (IO + discard) is a pretty
> important part of the whole topic and a pure discard test doesn't
> really tell us anything, at least for some drives.

I think both are important especially since mixed IO tests are going to
be highly workload specific.

-Lukas

> 
> Jan
> 
> 
> 
> -- 
> Jan Tulak
