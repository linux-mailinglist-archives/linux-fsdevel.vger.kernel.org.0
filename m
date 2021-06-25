Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057C13B49EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFYVKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 17:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYVKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:10:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEB0C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jun 2021 14:08:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h23so6154124pjv.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jun 2021 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iwdrmqNuPsOzJ+vHk2n49886jjtTpzSZRkfEIGBbrK4=;
        b=Mxh1EfJo071k5FikITprA7j5KY1IpIuJVfvkEl7ZWsosdwyTDiEvFDy740fuGMhGIQ
         AxAOKh8mDMZ3Zk0bZBUGmheDV4XKa+X5VOYjR3tb552FmUqirzTC69g1j2uI2Zt2HVSC
         kC6sm4BY7G892gR8UZP2ovtLklcLtsSgGVp0NNXyyseHl767ePNdRsR3hjnDZhBiWprh
         R9peJ861wi34qzN4qW/8ANN6oeKZBRo6YVCBE2raFlTFBPxATQ3fedEwqYhLpKPXU2ha
         c75O8Mh2sIjpWzsruGt1Dlto433gIoPup3EMvmVJIeODO8h4Hfc9AwQturZpSOGnOy6W
         LGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwdrmqNuPsOzJ+vHk2n49886jjtTpzSZRkfEIGBbrK4=;
        b=LWrfYAHGp2uh7nVRf7fAWCAteMoEeOTX1C66l564pQjxDIQGm+OgHMEsw5TX6AZND/
         HjdcyFPL4ZHgxAMsPZpNK8OblQOCO+j3T5qOBCO+zxEUrOJQluvs9iwdulupCcArg9wY
         1VJ3Rt01GPzgXYARqC48ro7Z4SgQzglg9w7QDOmmM90kSwzf9+4xqn5mBi/4Yy9w2uQf
         3K7YWSS1ye00s5KQWfHYucCqVjmvJwbsMxT5gT5005zYxnd2Qg8+PlA6uV5c4dWf3EnO
         bYVrOUF8UMWfwBRjCeLVRd423uxIaH/yOHVhE1l7I8PZsxClof2SpVVm4Dr6gU/Xu4kK
         XovQ==
X-Gm-Message-State: AOAM533KOcnbdsOqlI8Jhy4Hb5KPZkmmpbCYDOTcV+sXtPy59Gk7HW3S
        vWLlgFrE9oFKcIW+2jpFzsab5Q==
X-Google-Smtp-Source: ABdhPJwR+3izSSktVvZl0BZ1BTZ8AP1mV7Dv3U/8nWTz+Ja1L+paTYW+Uc/D2EqGapUY+o0q7OmDBQ==
X-Received: by 2002:a17:90a:db0c:: with SMTP id g12mr13113680pjv.166.1624655282162;
        Fri, 25 Jun 2021 14:08:02 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:dd6d])
        by smtp.gmail.com with ESMTPSA id l6sm6381275pgh.34.2021.06.25.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:08:01 -0700 (PDT)
Date:   Fri, 25 Jun 2021 14:07:59 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNZFr7oJj1nkrwJY@relinquished.localdomain>
References: <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
 <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org>
 <YNQi3vgCLVs/ExiK@relinquished.localdomain>
 <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
 <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
 <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
 <yq1tulmoqxf.fsf@ca-mkp.ca.oracle.com>
 <YNVPp/Pgqshami3U@casper.infradead.org>
 <CAHk-=wgH5pUbrL7CM5v6TWyNzDYpVM9k1qYCEgmY+b3Gx9nEAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgH5pUbrL7CM5v6TWyNzDYpVM9k1qYCEgmY+b3Gx9nEAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:16:15AM -0700, Linus Torvalds wrote:
> On Thu, Jun 24, 2021 at 8:38 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Does it make any kind of sense to talk about doing this for buffered I/O,
> > given that we can't generate them for (eg) mmaped files?
> 
> Sure we can.
> 
> Or rather, some people might very well like to do it even for mutable
> data. In fact, _especially_ for mutable data.
> 
> You might want to do things like "write out the state I verified just
> a moment ago", and if it has changed since then, you *want* the result
> to be invalid because the checksums no longer match - in case somebody
> else changed the data you used for the state calculation and
> verification in the meantime. It's very much why you'd want a separate
> checksum in the first place.
> 
> Yeah, yeah,  you can - and people do - just do things like this with a
> separate checksum. But if you know that the filesystem has internal
> checksumming support _anyway_, you might want to use it, and basically
> say "use this checksum, if the data doesn't match when I read it back
> I want to get an IO error".
> 
> (The "data doesn't match" _could_ be just due to DRAM corruption etc,
> of course. Some people care about things like that. You want
> "verified" filesystem contents - it might not be about security, it
> might simply be about "I have validated this data and if it's not the
> same data any more it's useless and I need to re-generate it").
> 
> Am I a big believer in this model? No. Portability concerns (across
> OS'es, across filesystems, even just across backups on the same exact
> system) means that even if we did this, very few people would use it.
> 
> People who want this end up using an external checksum instead and do
> it outside of and separately from the actual IO, because then they can
> do it on existing systems.
> 
> So my argument is not "we want this". My argument is purely that some
> buffered filesystem IO case isn't actually any different from the
> traditional "I want access to the low-level sector hardware checksum
> data". The use cases are basically exactly the same.
> 
> Of course, basically nobody does that hw sector checksum either, for
> all the same reasons, even if it's been around for decades.
> 
> So my "checksum metadata interface" is not something I'm a big
> believer in, but I really don't think it's really all _that_ different
> from the whole "compressed format interface" that this whole patch
> series is about. They are pretty much the same thing in many ways.

I see the similarity in the sense that we basically want to pass some
extra metadata down with the read or write. So then do we want to add
preadv3/pwritev3 for encoded I/O now so that checksums can use it in the
future? The encoding metadata could go in this "struct io_how", either
directly or in a separate structure with a pointer in "struct io_how".
It could get messy with compat syscalls.
