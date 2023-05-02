Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69796F46DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjEBPR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjEBPRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:17:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C14E1FD8;
        Tue,  2 May 2023 08:17:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f315712406so174448145e9.0;
        Tue, 02 May 2023 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683040641; x=1685632641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AQcCC9exWPjreW5MHIiqHtd9KhbvEqX3I4mJNwb4nU=;
        b=kxCel7DkPdXMMH07VAc7VqwEhTnGVm+pbIQ15//i5MlDk1TWuqqI6pcLWDw2Ib4T/D
         n+1EKCgqlPnv6VDnOveZ2/qXNdZsaH3mfeOhsAtKnrvNVNgpkQWKKYtSYaANk6slizKs
         +8eRjn78pEyj1+/+PnPjRQVtct8VznYzKZznTCdWYc2HQTyKoHevXaQ79SuvnwR1zb/r
         Rd/blQW/8TszZAMYf50gNMKchW3OMS1l6kbMl2ioUNZk+Mwl/9uupRYN035HAVbB8YBE
         jrCik4CN12kE2LTId0dDLiiG6MllGT3BPzGf4CIVmttl+OVluPe9qOpnxOcajgaZHFXk
         h/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683040641; x=1685632641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AQcCC9exWPjreW5MHIiqHtd9KhbvEqX3I4mJNwb4nU=;
        b=Oyc0QlIOJE26oZJ5HmEa08bUBEO3mnnp7s1eOK9ptqsVQVE4DI/Zk3xS4ACbkDkEEW
         FMgj1B59sAlaFNN80ZO59mB7Hohq9ePAzQxtCTLY6qyjtwc0PfhY0jjRa3S34SpI3jkN
         BghBiZooXLdDLugyyig6pHBKKxocRm6XWYX8lEv/dIQDsh9FqRdPx1/GEhNJoNTqcWT0
         E+hv0VQrRDcOZ52qsDQWBCfi6OZozeVPj/mNUpIkqSqwYOate7262wqc4FF68ZO1or5O
         IIfjsrciAsR/uVGWwcInC6EwdhtgFXAhdMNUD3IJ4rd6rdEGkWyj/lyCTjOSY2fzUa7L
         q1eQ==
X-Gm-Message-State: AC+VfDxRUFxZ8ruET+xb24U+tOeHlf5WtRLbLr7/TTr8nDrjUQobBh/t
        21+ycBGdJvx1kJZZ4EXu9JM=
X-Google-Smtp-Source: ACHHUZ7PpMYSrEm33sje6MQVgFubENvnaHm2UDtMsju/mA3zHrKSGucAmVYTcFKMu95lYjDUz3PqbA==
X-Received: by 2002:a05:600c:378e:b0:3f1:65cb:8156 with SMTP id o14-20020a05600c378e00b003f165cb8156mr11648603wmr.0.1683040641576;
        Tue, 02 May 2023 08:17:21 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id y3-20020a7bcd83000000b003f33f8f0a05sm5225567wmj.9.2023.05.02.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:17:20 -0700 (PDT)
Date:   Tue, 2 May 2023 16:17:19 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v6 2/3] mm/gup: disallow FOLL_LONGTERM GUP-nonfast
 writing to file-backed mappings
Message-ID: <bc769df3-35e6-4e7a-bc8b-ec46eeca56de@lucifer.local>
References: <cover.1682981880.git.lstoakes@gmail.com>
 <ff543d504d2bf83f60b1fb478149b4b3d6298119.1682981880.git.lstoakes@gmail.com>
 <1d82794a-4c12-cdc3-a868-f013bf9fe46f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d82794a-4c12-cdc3-a868-f013bf9fe46f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 05:04:02PM +0200, David Hildenbrand wrote:
> On 02.05.23 01:11, Lorenzo Stoakes wrote:
> > Writing to file-backed mappings which require folio dirty tracking using
> > GUP is a fundamentally broken operation, as kernel write access to GUP
> > mappings do not adhere to the semantics expected by a file system.
> >
> > A GUP caller uses the direct mapping to access the folio, which does not
> > cause write notify to trigger, nor does it enforce that the caller marks
> > the folio dirty.
> >
> > The problem arises when, after an initial write to the folio, writeback
> > results in the folio being cleaned and then the caller, via the GUP
> > interface, writes to the folio again.
> >
> > As a result of the use of this secondary, direct, mapping to the folio no
> > write notify will occur, and if the caller does mark the folio dirty, this
> > will be done so unexpectedly.
> >
> > For example, consider the following scenario:-
> >
> > 1. A folio is written to via GUP which write-faults the memory, notifying
> >     the file system and dirtying the folio.
> > 2. Later, writeback is triggered, resulting in the folio being cleaned and
> >     the PTE being marked read-only.
> > 3. The GUP caller writes to the folio, as it is mapped read/write via the
> >     direct mapping.
> > 4. The GUP caller, now done with the page, unpins it and sets it dirty
> >     (though it does not have to).
> >
> > This results in both data being written to a folio without writenotify, and
> > the folio being dirtied unexpectedly (if the caller decides to do so).
> >
> > This issue was first reported by Jan Kara [1] in 2018, where the problem
> > resulted in file system crashes.
> >
> > This is only relevant when the mappings are file-backed and the underlying
> > file system requires folio dirty tracking. File systems which do not, such
> > as shmem or hugetlb, are not at risk and therefore can be written to
> > without issue.
> >
> > Unfortunately this limitation of GUP has been present for some time and
> > requires future rework of the GUP API in order to provide correct write
> > access to such mappings.
> >
> > However, for the time being we introduce this check to prevent the most
> > egregious case of this occurring, use of the FOLL_LONGTERM pin.
> >
> > These mappings are considerably more likely to be written to after
> > folios are cleaned and thus simply must not be permitted to do so.
> >
> > This patch changes only the slow-path GUP functions, a following patch
> > adapts the GUP-fast path along similar lines.
> >
> > [1]:https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/
> >
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: Mika Penttil� <mpenttil@redhat.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >   mm/gup.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index ff689c88a357..0f09dec0906c 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -959,16 +959,51 @@ static int faultin_page(struct vm_area_struct *vma,
> >   	return 0;
> >   }
> > +/*
> > + * Writing to file-backed mappings which require folio dirty tracking using GUP
> > + * is a fundamentally broken operation, as kernel write access to GUP mappings
> > + * do not adhere to the semantics expected by a file system.
> > + *
> > + * Consider the following scenario:-
> > + *
> > + * 1. A folio is written to via GUP which write-faults the memory, notifying
> > + *    the file system and dirtying the folio.
> > + * 2. Later, writeback is triggered, resulting in the folio being cleaned and
> > + *    the PTE being marked read-only.
> > + * 3. The GUP caller writes to the folio, as it is mapped read/write via the
> > + *    direct mapping.
> > + * 4. The GUP caller, now done with the page, unpins it and sets it dirty
> > + *    (though it does not have to).
> > + *
> > + * This results in both data being written to a folio without writenotify, and
> > + * the folio being dirtied unexpectedly (if the caller decides to do so).
> > + */
> > +static bool writeable_file_mapping_allowed(struct vm_area_struct *vma,
> > +					   unsigned long gup_flags)
> > +{
> > +	/* If we aren't pinning then no problematic write can occur. */
> > +	if (!(gup_flags & (FOLL_GET | FOLL_PIN)))
> > +		return true;
>
> I think we should really not look at FOLL_GET here. Just check for FOLL_PIN
> (as said, even FOLL_LONGTERM would be sufficient, but I understand the
> reasoning to keep it, although I would drop it :P ). It also better matches
> your comment regarding pinning ...
>
> See the comment in is_valid_gup_args() regarding "LONGTERM can only be
> specified when pinning". (well, there we also check that FOLL_PIN has to be
> set ... ;) )

I think I will finally give in, in penance for the very silly mistake I made
below...

>
> > +
> > +	/* We limit this check to the most egregious case - a long term pin. */
> > +	if (!(gup_flags & FOLL_LONGTERM))
> > +		return true;
> > +
> > +	/* If the VMA requires dirty tracking then GUP will be problematic. */
> > +	return vma_needs_dirty_tracking(vma);
>
>
> ... should that be "!vma_needs_dirty_tracking(vma)" ?
>
> If the fs needs dirty tracking, it should be disallowed.
>
> Maybe that explains why it's still working for Matthew in his s390x test.
> ... or I am too tired and messed up :)
>

No, no it was I who was too tired it seems! You're correct, this is wrong,
will respin with fix :))

> --
> Thanks,
>
> David / dhildenb
>
