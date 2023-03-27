Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060066C990B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjC0AjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 20:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjC0AjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:39:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3B46B6
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 17:38:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so6942142pjt.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679877535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL3a+TWIB4wbyH+pk+yppXVzEy45w2PnT959afXZzfE=;
        b=Gfy6rgbqQVzlNT/IqFJC4s7YUkiSfRHkSozUxvidIMjOLmOwomJ5cqMjYLGOoAJ2uW
         BSr2RUY/EQtVtt2Rgzv6fJM3bXde2QyLTjhZ3GDyu6tPvjmJirsmt3NOcQ4sdjWGL7HM
         w5J4XUDP9RplRMJ/7PO+1/a/Ou/XwCwAEYemRsZgoaybiN7WY7MYd6m7bTa/AUoaH4ff
         7PY7hNTaHUA1u5ATl+6dTxBG3FYljAZ6LnSCrm7xkRL6EOwDjFCwDxBrirqvH03aqWWz
         nyyMbDRtciGtEzzRC9W1IAGWhGZ9idnqglS5SONBeH03aOGgo8/1Gw8AIqEYf79cIDy4
         zUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679877535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL3a+TWIB4wbyH+pk+yppXVzEy45w2PnT959afXZzfE=;
        b=WLoRi1z97fTreGYZ9zqYm284GxR2OdvN878C7eIYUSq9LI3edaPJchJfU+S/QtvZv1
         YfD22TKDnmI4+uO5z1jzB6dsbj9hlKv8N0FaG90nYxrENKgkxf+fyu1PQF7P7Wq9nFlr
         pyvVuJGrp6ajeYQgIvoz8Qvb7VM6KIofb59d69bD0XE4DmOxbzJA17orZ7fNGFlcAcoK
         rh/N8+SUEZqMsHvqLJRcBrf2w9T7CbmDNcYywMGEhRp8GkAl0AQYxtCAW0cS/krsuSe1
         OBJ7WlgSAVxp0+oYWj1Q8IUqPcNlWSOoTKQpgm1zWgRH41fK/uecqlJI7Rrnpp/RGK0r
         HANA==
X-Gm-Message-State: AAQBX9cwiQrqAN/snzzWkWko0ETuhe9rcrQ5TGM7ubhXsbXO0l1G2Noc
        8p9U+tUuIFArAp1KgkoQlac5Ew==
X-Google-Smtp-Source: AKy350Zn6mhhHR8MBqsUL/fpMKj0au7tP24g1nhgaaInJCemK83mogbizHRNfMnFFf6N1TmLLZFOAA==
X-Received: by 2002:a17:90b:17c9:b0:237:9cc7:28a6 with SMTP id me9-20020a17090b17c900b002379cc728a6mr10658956pjb.26.1679877534805;
        Sun, 26 Mar 2023 17:38:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id dw18-20020a17090b095200b002407750c3c3sm1432675pjb.37.2023.03.26.17.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 17:38:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pgasr-00Da2e-QH; Mon, 27 Mar 2023 11:38:49 +1100
Date:   Mon, 27 Mar 2023 11:38:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <20230327003849.GA3222767@dread.disaster.area>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZB00U2S4g+VqzDPL@destitution>
 <ZB01yw3MpOswyL1e@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB01yw3MpOswyL1e@casper.infradead.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:31:55AM +0000, Matthew Wilcox wrote:
> On Fri, Mar 24, 2023 at 04:25:39PM +1100, Dave Chinner wrote:
> > Did you read the comment above this function? I mean, it's all about
> > how poorly kvmalloc() works for the highly concurrent, fail-fast
> > context that occurs in the journal commit fast path, and how we open
> > code it with kmalloc and vmalloc to work "ok" in this path.
> > 
> > Then if you go look at the commits related to it, you might find
> > that XFS developers tend to write properly useful changelogs to
> > document things like "it's better, but vmalloc will soon have lock
> > contention problems if we hit it any harder"....
> 
> The problem with writing whinges like this is that mm developers don't
> read XFS changelogs.  I certainly had no idea this was a problem, and
> I doubt anybody else who could make a start at fixing this problem had
> any idea either.  Why go to all this effort instead of sending an email
> to linux-mm?

<sigh>

If you read the mm/vmalloc.c change logs, you'd find that two weeks
later, a bunch of commits went into the vmalloc code to change some
of the stuff mentioned in the above XFS commit. That was a direct
result of the discussion of vmalloc/kvmalloc inadequacies, and if
you followed the links from these three commits:

30d3f01191d3 mm/vmalloc: be more explicit about supported gfp flags.
9376130c390a mm/vmalloc: add support for __GFP_NOFAIL
451769ebb7e7 mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc

You'd have found those discussions.

I went into great detail in that discussion about the problems with
the kvmalloc/vmalloc APIs and the problems with actually using it in
anger. e.g:

https://lore.kernel.org/all/163184741778.29351.16920832234899124642.stgit@noble.brown/T/#e8bc85de35d432dcbc35a16fc72b6a3daef2a0f78

In that discussion, I gave these examples and use cases about
fail-fast for the kmalloc part of kvmalloc being needed, that
arguments that GFP_NOFS didn't work with vmalloc were bullshit
because we'd been using it heavily for years in GFP_NOFS contexts
without issues, the lack of scope APIs for anything other NOFS/NOIO,
that filesytsems want "retry forever" semantics, not the current
__GFP_NOFAIL semantics that have all sorts of weird side effects,
etc. I also point out that vmalloc is rapidly becoming one of the
hottest paths in XFS in response to the comments that vmalloc "isn't
a hot path".

Indeed, I point that the XFS change in that commit during that
discussion, and you made exactly the same "you should raise this
with mm developers" complaint then, too. Imagine how frsutrating it
is when I was being told to raise vmalloc issues on the linux-mm
list with mm developers during a discussion about vmalloc issues
with mm developers on the linux-mm list. Especially as it wasn't
just one mm developer that responded like that.

And yet, the 3 commits that came out of the discussion did nothing
to change the actual problem we need to fix - fail-fast high-order
kmalloc behaviour in kvmalloc() - and so the XFS commit still stands
and is badly needed.

Repeatedly castigating people saying we should talk to mm developers
rather than working around the API they maintain when we've
repeatedly talked to the mm developers about getting changes made
and repeatedly failed to get the changes we need made? Yeah, that
leads to frustrations and commit messages documenting all the shit
we haven't been able to get changed and so need to work around.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
