Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027196C9516
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjCZOVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCZOVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:21:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C659C3;
        Sun, 26 Mar 2023 07:21:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r11so6076351wrr.12;
        Sun, 26 Mar 2023 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679840459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cJMZnqUsBgrNdX88leORoUPzqPUZDQUspY2yewjVqs=;
        b=bsg1Ww16uXAdzsN9tnYPmboinU7IVqUqXYdIeiqDNyghvMNrHjSlj6BzF/AYnvkgC3
         Lc9hMtxQaXWskmyxtMMG6Viw7yv0IX1A2ZGk1xbIUK4OqCvCUqxRaMh0ruUNr83hZ3w2
         NO12WEHmHpFptqjQPZrwOvhvwa18mUy4nvIQCRbPPtPW3DW5Pg4G7amvVG+kJFR4RnhK
         s3kAOktRgBXEOX3upoSNG5IzasXvHJ4t5f4RlcodKbYO54IJyxeysljugvNWovMGM/JI
         x+WFNttDZZWHrxzArp/uKKODRPR6ar82ufL2WZ3ihpCTd3RHtze2Bbwo5JjCrC7uCZ1J
         BGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679840459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cJMZnqUsBgrNdX88leORoUPzqPUZDQUspY2yewjVqs=;
        b=2JyuN5RgLJswOEnXT3ayVluwYBkJvCDYgld9M4L8Bt0KdkUQmDWMt2I7frCLfsii1Q
         zZdt/bLKc7o08YxDIYe3Lu4LPIj0vD2YT+t5bajDt1RSx0XcJqtFuyXHZ3+9mO8ygOge
         IGAJwOrvXSPRVSTRjj1YCK+IPPzLEAb3mxNuWzG6gf0UyZvRgurhJmcyr1Q6chd6DEHe
         mwptG8bmNTzAAgvkFc7BcleqnJVmWjGw40VB/0eKNJglqq+8tusCzr7LPUGChjGrcndm
         JoQIMV4/oDpMvuqOF93JF9zv5ghgFULXFjYbc8Z1cOPtMWJ49Gy/FlmyUlDb/Ib7Mjmc
         Dkkg==
X-Gm-Message-State: AAQBX9fSokUuzqSfhhWn9TKPhxHztGQN5J5Gb4MjtrUBfEwtTW7749FU
        /qFbY4/KtrDgrSrX7mxfhpQ=
X-Google-Smtp-Source: AKy350ZHigTNNCX9fxVkA2dbVTJk/enyX94yk83jX+DJYZT2kDKB1pL/+IZYMYuNZPOZuBxJ+yVZrw==
X-Received: by 2002:a5d:4248:0:b0:2ce:a8a2:37d7 with SMTP id s8-20020a5d4248000000b002cea8a237d7mr6501298wrr.27.1679840458729;
        Sun, 26 Mar 2023 07:20:58 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm22796795wrr.46.2023.03.26.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 07:20:57 -0700 (PDT)
Date:   Sun, 26 Mar 2023 15:20:56 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Baoquan He' <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <01d87b9f-3c8b-4f92-89c2-3e07420e9c67@lucifer.local>
References: <cover.1679511146.git.lstoakes@gmail.com>
 <941f88bc5ab928e6656e1e2593b91bf0f8c81e1b.1679511146.git.lstoakes@gmail.com>
 <ZBu+2cPCQvvFF/FY@MiWiFi-R3L-srv>
 <ff630c2e-42ff-42ec-9abb-38922d5107ec@lucifer.local>
 <ZBwroYh22pEqJYhv@MiWiFi-R3L-srv>
 <7aee68e9-6e31-925f-68bc-73557c032a42@redhat.com>
 <ZBxUvBFHcQvsl0r9@MiWiFi-R3L-srv>
 <0cff573c3a344504b1b1b77486b4d853@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cff573c3a344504b1b1b77486b4d853@AcuMS.aculab.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 26, 2023 at 01:26:57PM +0000, David Laight wrote:
> From: Baoquan He
> > Sent: 23 March 2023 13:32
> ...
> > > > > If this fails, then we fault in, and try again. We loop because there could
> > > > > be some extremely unfortunate timing with a race on e.g. swapping out or
> > > > > migrating pages between faulting in and trying to write out again.
> > > > >
> > > > > This is extremely unlikely, but to avoid any chance of breaking userland we
> > > > > repeat the operation until it completes. In nearly all real-world
> > > > > situations it'll either work immediately or loop once.
> > > >
> > > > Thanks a lot for these helpful details with patience. I got it now. I was
> > > > mainly confused by the while(true) loop in KCORE_VMALLOC case of read_kcore_iter.
> > > >
> > > > Now is there any chance that the faulted in memory is swapped out or
> > > > migrated again before vread_iter()? fault_in_iov_iter_writeable() will
> > > > pin the memory? I didn't find it from code and document. Seems it only
> > > > falults in memory. If yes, there's window between faluting in and
> > > > copy_to_user_nofault().
> > > >
> > >
> > > See the documentation of fault_in_safe_writeable():
> > >
> > > "Note that we don't pin or otherwise hold the pages referenced that we fault
> > > in.  There's no guarantee that they'll stay in memory for any duration of
> > > time."
> >
> > Thanks for the info. Then swapping out/migration could happen again, so
> > that's why while(true) loop is meaningful.
>
> One of the problems is that is the system is under severe memory
> pressure and you try to fault in (say) 20 pages, the first page
> might get unmapped in order to map the last one in.
>
> So it is quite likely better to retry 'one page at a time'.

If you look at the kcore code, it is in fact only faulting one page at a
time. tsz never exceeds PAGE_SIZE, so we never attempt to fault in or copy
more than one page at a time, e.g.:-

if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
	tsz = buflen;

...

tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);

It might be a good idea to make this totally explicit in vread_iter()
(perhaps making it vread_page_iter() or such), but I think that might be
good for another patch series.

>
> There have also been cases where the instruction to copy data
> has faulted for reasons other than 'page fault'.
> ISTR an infinite loop being caused by misaligned accesses failing
> due to 'bad instruction choice' in the copy code.
> While this is rally a bug, an infinite retry in a file read/write
> didn't make it easy to spot.

I am not sure it's reasonable to not write code just in case an arch
implements buggy user copy code (do correct me if I'm misunderstanding you
about this!). By that token wouldn't a lot more be broken in that
situation? I don't imagine all other areas of the kernel would make
explicitly clear to you that this was the problem.

>
> So maybe there are cases where a dropping back to a 'bounce buffer'
> may be necessary.

One approach could be to reinstate the kernel bounce buffer, set up an
iterator that points to it and pass that in after one attempt with
userland.

But it feels a bit like overkill, as in the case of an aligment issue,
surely that would still occur and that'd just error out anyway? Again I'm
not sure bending over backwards to account for possibly buggy arch code is
sensible.

Ideally the iterator code would explicitly pass back the EFAULT error which
we could then explicitly handle but that'd require probably quite
significant rework there which feels a bit out of scope for this change.

We could implement some maximum number of attempts which statistically must
reduce the odds of repeated faults in the tiny window between fault in and
copy to effectively zero. But I'm not sure the other David would be happy
with that!

If we were to make a change to be extra careful I'd opt for simply trying X
times then giving up, given we're trying this a page at a time I don't
think X need be that large before any swap out/migrate bad luck becomes so
unlikely that we're competing with heat death of the universe timescales
before it might happen (again, I may be missing some common scenario where
the same single page swaps out/migrates over and over, please correct me if
so).

However I think there's a case to be made that it's fine as-is unless there
is another scenario we are overly concerned about?

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
