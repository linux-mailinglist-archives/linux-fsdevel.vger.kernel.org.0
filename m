Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0D3E22D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 07:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbhHFFVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 01:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbhHFFVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 01:21:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6894AC061799
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 22:21:28 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e1so1969335qvs.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Aug 2021 22:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=zcQ8sL2CqDTX+4kbgN4gpZBAnX2ERdxEAX8JcULAxIw=;
        b=gUNzJSOkj20KGKHXFPVIgJjwzfkmpuadqQVQpncG4R9KzZkgDK7F33mliEcdzrl5ep
         8A2fWKG5yycXn0Wm0gXcCfdmVRENQuZGBzUcUTbIjoymlifLcaASCmqk34KrHyI7k5wZ
         /wjyfSaCTB9U7DgfOrP5kz4ACwISxt/Nl1cXRSqkGnEu/LWRcJfBD+gAZ96FE551038H
         chdRHjClBWCNo80PpjOw1TXVOvt3UcianthQ0Fd4q8id+rjkVB3F48iuzM3AKao/OL2t
         phCu6ig+mjf+7opPXQB86ugRjpibTknZgynHrR2aY+DNUZ5NVBNiXx6CIXOSLc15/TZY
         LyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zcQ8sL2CqDTX+4kbgN4gpZBAnX2ERdxEAX8JcULAxIw=;
        b=UM6x8facB364RmwjvH++sArf9pgWpfwXmIQH9hJwyFQPq3R20lXG/scfzZ+RGRqc0Z
         0SrRVS/eiCBJQAXqJFov+Cgl5hnGvMr1Ew75uxJDMTAeF6skTRDdf4CA4Y88M7FL0Oi7
         Eeta03HYshS1JU7pRIeGdwwMGwqfx3kvrjtVeRyPnZYP7Z5B1lRMja9DQQGUl0YAZrGf
         ROf6g6vstd9+HZPq7VjH3Vh8cIgzevElrxofsfH+2lpf5vExOu3W0QFMtOwyVr6cMEuN
         ZH9zpDJp4ZmDavJ6Q/wSGleBvADk30koIGdZfAQI7RgAvald11gwDSOtHiimjTQqNTGS
         MeEA==
X-Gm-Message-State: AOAM531hupRl8SZLD8CUPDiYRXwIQY4V7OHDbobqeyH9Y54tM5Upkpvf
        8JlB84eLDfuHp2hPJLLoBFWerA==
X-Google-Smtp-Source: ABdhPJx2TIa3URYgDE8tF8OrtnfZbT+pjWok+3pEMPuWe/4OFj/lOx3ydolPsjWS9Et4I5nTeiWVeQ==
X-Received: by 2002:ad4:4312:: with SMTP id c18mr9113165qvs.54.1628227287282;
        Thu, 05 Aug 2021 22:21:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q3sm4181366qkn.14.2021.08.05.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 22:21:26 -0700 (PDT)
Date:   Thu, 5 Aug 2021 22:21:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <CAHbLzkrvOCCbN3EcDeKwfqWrtU6kH0+7fuSv7aahyjpKtsHn3g@mail.gmail.com>
Message-ID: <5add2467-3b23-f8b8-e07b-82d8a573ecb7@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com> <e7374d7e-4773-aba1-763-8fa2c953f917@google.com>
 <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com> <8baad8b2-8f7a-2589-ce21-4135a59c5dc6@google.com> <CAHbLzkrvOCCbN3EcDeKwfqWrtU6kH0+7fuSv7aahyjpKtsHn3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Aug 2021, Yang Shi wrote:
> On Wed, Aug 4, 2021 at 1:28 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Thanks, but despite us agreeing that the race is too unlikely to be worth
> > optimizing against, it does still nag at me ever since you questioned it:
> > silly, but I can't quite be convinced by my own dismissals.
> >
> > I do still want to get rid of SGP_HUGE and SGP_NOHUGE, clearing up those
> > huge allocation decisions remains the intention; but now think to add
> > SGP_NOALLOC for collapse_file() in place of SGP_NOHUGE or SGP_CACHE -
> > to rule out that possibility of mischarge after racing hole-punch,
> > no matter whether it's huge or small.  If any such race occurs,
> > collapse_file() should just give up.
> >
> > This being the "Stupid me" SGP_READ idea, except that of course would
> > not work: because half the point of that block in collapse_file() is
> > to initialize the !Uptodate pages, whereas SGP_READ avoids doing so.
> >
> > There is, of course, the danger that in fixing this unlikely mischarge,
> > I've got the code wrong and am introducing a bug: here's what a 17/16
> > would look like, though it will be better inserted early.  I got sick
> > of all the "if (page "s, and was glad of the opportunity to fix that
> > outdated "bring it back from swap" comment - swap got done above.
> >
> > What do you think? Should I add this in or leave it out?
> 
> Thanks for keeping investigating this. The patch looks good to me. I
> think we could go this way. Just a nit below.

Thanks, I'll add it into the series, a patch before SGP_NOHUGE goes away;
but I'm not intending to respin the series until there's more feedback
from others - fcntl versus fadvise is the main issue so far.

> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -108,6 +108,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
> >  /* Flag allocation requirements to shmem_getpage */
> >  enum sgp_type {
> >         SGP_READ,       /* don't exceed i_size, don't allocate page */
> > +       SGP_NOALLOC,    /* like SGP_READ, but do use fallocated page */
> 
> The comment looks misleading, it seems SGP_NOALLOC does clear the
> Uptodate flag but SGP_READ doesn't. Or it is fine not to distinguish
> this difference?

I think you meant to say, SGP_NOALLOC does *set* the Uptodate flag but
SGP_READ doesn't.  And a more significant difference, as coded to suit
collapse_file(), is that SGP_NOALLOC returns failure on hole, whereas
SGP_READ returns success: I should have mentioned that.

When I wrote "like SGP_READ" there, I just meant "like what's said in
the line above": would "ditto" be okay with you, and I say
	SGP_NOALLOC,	/* ditto, but fail on hole, or use fallocated page */

I don't really want to get into the "Uptodate" business there.
And I'm afraid someone is going to ask me to write multi-line comments
on each of those SGP_flags, and I'm going to plead "read the source"!

Oh, now I see why you said SGP_NOALLOC does clear the Uptodate flag:
"goto clear", haha: when we clear the page we set the Uptodate flag.

And I may have another patch to slot in: I was half expecting you to
question why SGP_READ behaves as it does, so in preparing its defence
I checked, and found it was not doing quite what I remembered: changes
were made a long time ago, which have left it slightly suboptimal.
But that really has nothing to do with the rest of this series,
and I don't need to run it past you before reposting.

I hope that some of the features in this series can be useful to you.

Thanks,
Hugh
