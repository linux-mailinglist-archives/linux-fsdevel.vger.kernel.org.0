Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD71F3B03F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhFVMOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52842 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhFVMOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0774D218D6;
        Tue, 22 Jun 2021 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624363926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8FU8UVi5nPdDY+zE8FGh4fOpPiQip+w88J/iISrayw=;
        b=ypU7A5mpbI/uy5MkStBMLsOR+WDc7p78YosCeNjDBnSRUVgWBfv0V2v/pK1iW++XVgJ1rS
        UkqJVXlbl+Ir0ONRFh8OPhT9hRTFZfZZwOsywOVS1fj61Dqv5GG/OQvVwgzrw9Xrn5wFrA
        h2+uDzPyJyi8Txsw7PQBPl693bbveZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624363926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8FU8UVi5nPdDY+zE8FGh4fOpPiQip+w88J/iISrayw=;
        b=7OBHe4E1/tMHiC0lrsPWECWykj4GeSeFoh3TBYu8HNoyZQAIlbRuQcXQmSsfREOknhnomI
        O/U28lFtOhj6+3AA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B70A7A3B94;
        Tue, 22 Jun 2021 12:12:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8E4111E1515; Tue, 22 Jun 2021 14:12:05 +0200 (CEST)
Date:   Tue, 22 Jun 2021 14:12:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Michael Stapelberg <stapelberg+linux@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
Message-ID: <20210622121205.GG14261@quack2.suse.cz>
References: <20210617095309.3542373-1-stapelberg+linux@google.com>
 <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com>
 <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
 <CAJfpegu0prjjHVhBzwZBVk5N+avHvUcyi4ovhKbf+F7GEuVkmw@mail.gmail.com>
 <CAH9Oa-YxeZ25Vbto3NyUw=RK5vQWv_v7xp3vHS9667iJJ8XV_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH9Oa-YxeZ25Vbto3NyUw=RK5vQWv_v7xp3vHS9667iJJ8XV_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-06-21 11:20:10, Michael Stapelberg wrote:
> Hey Miklos
> 
> On Fri, 18 Jun 2021 at 16:42, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, 18 Jun 2021 at 10:31, Michael Stapelberg
> > <stapelberg+linux@google.com> wrote:
> >
> > > Maybe, but I don’t have the expertise, motivation or time to
> > > investigate this any further, let alone commit to get it done.
> > > During our previous discussion I got the impression that nobody else
> > > had any cycles for this either:
> > > https://lore.kernel.org/linux-fsdevel/CANnVG6n=ySfe1gOr=0ituQidp56idGARDKHzP0hv=ERedeMrMA@mail.gmail.com/
> > >
> > > Have you had a look at the China LSF report at
> > > http://bardofschool.blogspot.com/2011/?
> > > The author of the heuristic has spent significant effort and time
> > > coming up with what we currently have in the kernel:
> > >
> > > """
> > > Fengguang said he draw more than 10K performance graphs and read even
> > > more in the past year.
> > > """
> > >
> > > This implies that making changes to the heuristic will not be a quick fix.
> >
> > Having a piece of kernel code sitting there that nobody is willing to
> > fix is certainly not a great situation to be in.
> 
> Agreed.
> 
> >
> > And introducing band aids is not going improve the above situation,
> > more likely it will prolong it even further.
> 
> Sounds like “Perfect is the enemy of good” to me: you’re looking for a
> perfect hypothetical solution,
> whereas we have a known-working low risk fix for a real problem.
> 
> Could we find a solution where medium-/long-term, the code in question
> is improved,
> perhaps via a Summer Of Code project or similar community efforts,
> but until then, we apply the patch at hand?
> 
> As I mentioned, I think adding min/max limits can be useful regardless
> of how the heuristic itself changes.
> 
> If that turns out to be incorrect or undesired, we can still turn the
> knobs into a no-op, if removal isn’t an option.

Well, removal of added knobs is more or less out of question as it can
break some userspace. Similarly making them no-op is problematic unless we
are pretty certain it cannot break some existing setup. That's why we have
to think twice (or better three times ;) before adding any knobs. Also
honestly the knobs you suggest will be pretty hard to tune when there are
multiple cgroups with writeback control involved (which can be affected by
the same problems you observe as well). So I agree with Miklos that this is
not the right way to go. Speaking of tunables, did you try tuning
/sys/devices/virtual/bdi/<fuse-bdi>/min_ratio? I suspect that may
workaround your problems...

Looking into your original report and tracing you did (thanks for that,
really useful), it seems that the problem is that writeback bandwidth is
updated at most every 200ms (more frequent calls are just ignored) and are
triggered only from balance_dirty_pages() (happen when pages are dirtied) and
inode writeback code so if the workload tends to have short spikes of activity
and extended periods of quiet time, then writeback bandwidth may indeed be
seriously miscomputed because we just won't update writeback throughput
after most of writeback has happened as you observed.

I think the fix for this can be relatively simple. We just need to make
sure we update writeback bandwidth reasonably quickly after the IO
finishes. I'll write a patch and see if it helps.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
