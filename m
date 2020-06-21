Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E932028FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgFUGAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 02:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgFUGAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 02:00:13 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F0C061794;
        Sat, 20 Jun 2020 23:00:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t8so13075958ilm.7;
        Sat, 20 Jun 2020 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oACwMnGxV711lDft/mL2GTQM/QCIsRYS4HyU3R9wY9g=;
        b=K3xEZg8Lev6ya/17Z0awjRX9rPVz2RmlS6dL2qaRTO7hFzQXVktwBSbyTKrVFq5RfR
         bUWWVxMw8aJ1q1x6+uPcvluW3KpNa8A5M01b3cBsR52H/UNl7lCv1jbF18ECWoKV0BOv
         uj8EEAfXC4rpmtaeYbB4dULplLZHB+hXA2tMmKOvkxO/2ICgSAgSbqJSAfeY8ohdkKLN
         +bw4D3EPMF1z3LjpXHr0Sl1R99MZIWtFwRXDSqcGJBlNDbm4/s8sLz2BGlfaYkZKu2Rq
         rJk8n0QOGX9oUw0nBbgStb7G/sWlHav1RKGCibvGto/c3AGTNO341AEJAYyHSmMhyr0u
         YDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oACwMnGxV711lDft/mL2GTQM/QCIsRYS4HyU3R9wY9g=;
        b=nL/xdDTyiSbWdXNxcXK28CHbqx5tj2WB3erVZcIexZaC06PjxOEU4/g6EnU9OLwNog
         8K5O8dqkrkgZDrtudJrT5MJJfvu6CYeZxGRJsEiCd9hGL+hTbSKgRM4eAaZ3RfKM8Zjr
         uAWNztp1MINLD0yqwGbL9MK4VKZq5sMgpWygl7ioqPFfQi4chTYPIPXa1xsWz5UFt56s
         3e2JD115+4Z/7asRduw8AhvOwvcu6B9AceSP2Fpjtgek0aMFo3HV6xnA3pAyARTNOIWG
         eNyLW3pJ5MbcMwQ4+QF+WIAK/pHDXnt68RVZmBu/skxPRrXl8V+7zckofxcs4uGFG5pX
         dASw==
X-Gm-Message-State: AOAM53379pDfOATs9SO4GH5W/ghVoB2LFPoCC0c02Z21kDvekrDuA+a4
        FGN9ooU/Xz/tdnnNa05v6m9nCjrP2DwbJpMhx+zFXVvO
X-Google-Smtp-Source: ABdhPJxqCRebQRDCScb+zwuWhADWhU3C7P0rpGnfUjMYacyzMd5l68nGUffrQS8wi00YLBrpOVoYPtwfZrYuSjuR52E=
X-Received: by 2002:a92:5856:: with SMTP id m83mr11411406ilb.72.1592719212802;
 Sat, 20 Jun 2020 23:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155036.GZ8681@bombadil.infradead.org> <CAOQ4uxjy6JTAQqvK9pc+xNDfzGQ3ACefTrySXtKb_OcAYQrdzw@mail.gmail.com>
 <20200620191521.GG8681@bombadil.infradead.org>
In-Reply-To: <20200620191521.GG8681@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 Jun 2020 09:00:01 +0300
Message-ID: <CAOQ4uxgSc7hK1=GuUajzG1Z+ks6gzFFX+EtuBMULOk0s85zi3A@mail.gmail.com>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC: Dave Chinner, Jan Kara, xfs]

On Sat, Jun 20, 2020 at 10:15 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jun 20, 2020 at 09:19:37AM +0300, Amir Goldstein wrote:
> > On Fri, Jun 19, 2020 at 6:52 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > > The advantage of this patch is that we can avoid taking any filesystem
> > > lock, as long as the pages being accessed are in the cache (and we don't
> > > need to readahead any pages into the cache).  We also avoid an indirect
> > > function call in these cases.
> >
> > XFS is taking i_rwsem lock in read_iter() for a surprising reason:
> > https://lore.kernel.org/linux-xfs/CAOQ4uxjpqDQP2AKA8Hrt4jDC65cTo4QdYDOKFE-C3cLxBBa6pQ@mail.gmail.com/
> > In that post I claim that ocfs2 and cifs also do some work in read_iter().
> > I didn't go back to check what, but it sounds like cache coherence among
> > nodes.
>
> That's out of date.  Here's POSIX-2017:
>
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/read.html
>
>   "I/O is intended to be atomic to ordinary files and pipes and
>   FIFOs. Atomic means that all the bytes from a single operation that
>   started out together end up together, without interleaving from other
>   I/O operations. It is a known attribute of terminals that this is not
>   honored, and terminals are explicitly (and implicitly permanently)
>   excepted, making the behavior unspecified. The behavior for other
>   device types is also left unspecified, but the wording is intended to
>   imply that future standards might choose to specify atomicity (or not)."
>
> That _doesn't_ say "a read cannot observe a write in progress".  It says
> "Two writes cannot interleave".  Indeed, further down in that section, it says:
>
>   "Earlier versions of this standard allowed two very different behaviors
>   with regard to the handling of interrupts. In order to minimize the
>   resulting confusion, it was decided that POSIX.1-2017 should support
>   only one of these behaviors. Historical practice on AT&T-derived systems
>   was to have read() and write() return -1 and set errno to [EINTR] when
>   interrupted after some, but not all, of the data requested had been
>   transferred. However, the US Department of Commerce FIPS 151-1 and FIPS
>   151-2 require the historical BSD behavior, in which read() and write()
>   return the number of bytes actually transferred before the interrupt. If
>   -1 is returned when any data is transferred, it is difficult to recover
>   from the error on a seekable device and impossible on a non-seekable
>   device. Most new implementations support this behavior. The behavior
>   required by POSIX.1-2017 is to return the number of bytes transferred."
>
> That explicitly allows for a write to be interrupted by a signal and
> later resumed, allowing a read to observe a half-complete write.
>

Tell that to Dave Chinner (cc). I too, find it surprising that XFS developers
choose to "not regress" a behavior that is XFS specific and there is no
proof or even clues of any application that could rely on such behavior.
While the price that is being paid by all real world applications that do
mixed random rw workload is very much real and very much significant.

The original discussion on the original post quickly steered towards the
behavior change of rwsem [1], which you Matthew also participated in.
The reason for taking the rwsem lock in the first place was never seriously
challenged.

I posted a followup patch that fixes the performance issue without breaking
the "atomic rw" behavior [2] by calling generic_file_read_iter() once without
i_rwsem to pre-populate the page cache.
Dave had some technical concerns about this patch, regarding racing
with truncate_pagecache_range(), which later led to a fix by Jan Kara to
solve a readahead(2) vs. hole punch race [3].

At the time, Jan Kara wrote [3]:
"...other filesystems need similar protections but e.g. in case of ext4 it isn't
so simple without seriously regressing mixed rw workload performance so
I'm pushing just xfs fix at this moment which is simple."

And w.r.t solving the race without taking i_rwsem:
"...So I have an idea how it could be solved: Change calling convention for
->readpage() so that it gets called without page locked and take
i_mmap_sem there (and in ->readpages()) to protect from the race..."

My question to both Jan and Matthew is - does the new aops ->readahead()
API make things any better in that regard?
Will it make it easier for us to address the readahead vs. hole punch race
without having to take i_rwsem before readahead()?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-xfs/20190325154731.GT1183@magnolia/
[2] https://lore.kernel.org/linux-xfs/20190404165737.30889-1-amir73il@gmail.com/
[3] https://lore.kernel.org/linux-xfs/20200120165830.GB28285@quack2.suse.cz/
