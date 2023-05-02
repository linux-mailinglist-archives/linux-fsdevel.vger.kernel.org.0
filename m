Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC03B6F42BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjEBL0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjEBL0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 07:26:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C355B3;
        Tue,  2 May 2023 04:25:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so21803475e9.1;
        Tue, 02 May 2023 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683026756; x=1685618756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRs10HvNSyY4aofcI1ZBj0OmWfT5cmFsMr/bJt88upc=;
        b=XbCA26o8ji4R6knYZSzqsn4arwaV1Ls0n54VsyC3sh0XCRguzgo6WYIfgRd6ISDSt5
         EBSoA9d4ff6fzLEyt8lDCARZg417MLQF6Cda/Sj/INzQf8UAiKe9xq0jxanbbaCXb5ca
         ird2BaI1KxOxusUCTot0hGE3b9bTAKbhtLRXrHuQGz9T8uWtgcTXX8dIbFH7KEZ4Kx3x
         hkafrI1ZIb5hjjqlu7SHj32Whz0HqU8FAWd32BMv5U68yhvj+Y+9qvyWPtF3JeOa0fAk
         0LZ+VwuYrUAvzeXVUWDYBhwsrMj6iQZb8+GlJtH8P8givV/slC/aXYHm9iipyqYaaUke
         iRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026756; x=1685618756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRs10HvNSyY4aofcI1ZBj0OmWfT5cmFsMr/bJt88upc=;
        b=Xdz41b+r+0Qfl0a+GgeimCOSw0dik0TtG4B75On2Q0szcX1w/5bmcL5X6dDYSMcbi7
         kQM1wKNBkT+dpivHJRvzKjfl1JcJ60w6CMCVTGB+TQ+eG9SM8WbwFEDibmpHJLTpbJMp
         V83Tl0zFge+hrZLmi+DLhjoM3qu/vAtsQof2vNDJAytkiDEX1aN3CEgAkd/hLGRap3XS
         1XmrwSDo+IbxNA7SAqvTeUEv39EDxUUbMo7byjbiLVVo5Do+Kaqy3FYXCfLJDH+Ah19e
         SzycoTi81ov5lQHt4PIr9SUL/ZQrthMNbF5o3kJOcD4RWg7LyVjA7WX1uqxLEVfUVB3G
         REWw==
X-Gm-Message-State: AC+VfDwyOgxvqojOFM11FxYpuZN6X1Lufw1MNhDhGNKxqP5XTjORujY/
        dF6GYzfBg9ULQVXkqww6FgU=
X-Google-Smtp-Source: ACHHUZ5LhZMn8zC/XVOdRH0O9q5eFynI6mY/ADOayr/C7Ur8HRCDGD1BQqumNxthDJQRB5HwenjdKQ==
X-Received: by 2002:a5d:544c:0:b0:306:264d:5667 with SMTP id w12-20020a5d544c000000b00306264d5667mr6360015wrv.41.1683026756161;
        Tue, 02 May 2023 04:25:56 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id s4-20020adfeb04000000b003047f7a7ad1sm21455310wrn.71.2023.05.02.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:25:55 -0700 (PDT)
Date:   Tue, 2 May 2023 12:25:54 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
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
        David Hildenbrand <david@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v6 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing
 to file-backed mappings
Message-ID: <ab66d15a-acd0-4d9b-aa12-49cddd12c6a5@lucifer.local>
References: <cover.1682981880.git.lstoakes@gmail.com>
 <dee4f4ad6532b0f94d073da263526de334d5d7e0.1682981880.git.lstoakes@gmail.com>
 <20230502111334.GP1597476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502111334.GP1597476@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 01:13:34PM +0200, Peter Zijlstra wrote:
> On Tue, May 02, 2023 at 12:11:49AM +0100, Lorenzo Stoakes wrote:
> > @@ -95,6 +96,77 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
> >  	return folio;
> >  }
> >
> > +#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > +static bool stabilise_mapping_rcu(struct folio *folio)
> > +{
> > +	struct address_space *mapping = READ_ONCE(folio->mapping);
> > +
> > +	rcu_read_lock();
> > +
> > +	return mapping == READ_ONCE(folio->mapping);
>
> This doesn't make sense; why bother reading the same thing twice?

The intent is to see whether the folio->mapping has been truncated from
underneath us, as per the futex code that Kirill referred to which does
something similar [1].

>
> Who cares if the thing changes from before; what you care about is that
> the value you see has stable storage, this doesn't help with that.
>
> > +}
> > +
> > +static void unlock_rcu(void)
> > +{
> > +	rcu_read_unlock();
> > +}
> > +#else
> > +static bool stabilise_mapping_rcu(struct folio *)
> > +{
> > +	return true;
> > +}
> > +
> > +static void unlock_rcu(void)
> > +{
> > +}
> > +#endif
>
> Anyway, this all can go away. RCU can't progress while you have
> interrupts disabled anyway.

There seems to be other code in the kernel that assumes that this is not
the case, i.e. the futex code, though not sure if that's being run with
IRQs disabled... if not and it's absolutely certain that we need no special
handling for the RCU case, then happy days and more than glad to remove
this bit.

I'm far from an expert on RCU (I need to gain a better understanding of it)
so I'm deferring how best to proceed on _this part_ to the community.

>
> > +/*
> > + * Used in the GUP-fast path to determine whether a FOLL_PIN | FOLL_LONGTERM |
> > + * FOLL_WRITE pin is permitted for a specific folio.
> > + *
> > + * This assumes the folio is stable and pinned.
> > + *
> > + * Writing to pinned file-backed dirty tracked folios is inherently problematic
> > + * (see comment describing the writeable_file_mapping_allowed() function). We
> > + * therefore try to avoid the most egregious case of a long-term mapping doing
> > + * so.
> > + *
> > + * This function cannot be as thorough as that one as the VMA is not available
> > + * in the fast path, so instead we whitelist known good cases.
> > + *
> > + * The folio is stable, but the mapping might not be. When truncating for
> > + * instance, a zap is performed which triggers TLB shootdown. IRQs are disabled
> > + * so we are safe from an IPI, but some architectures use an RCU lock for this
> > + * operation, so we acquire an RCU lock to ensure the mapping is stable.
> > + */
> > +static bool folio_longterm_write_pin_allowed(struct folio *folio)
> > +{
> > +	bool ret;
> > +
> > +	/* hugetlb mappings do not require dirty tracking. */
> > +	if (folio_test_hugetlb(folio))
> > +		return true;
> > +
>
> This:
>
> > +	if (stabilise_mapping_rcu(folio)) {
> > +		struct address_space *mapping = folio_mapping(folio);
>
> And this is 3rd read of folio->mapping, just for giggles?

I like to giggle :)

Actually this is to handle the various cases in which the mapping might not
be what we want (i.e. have PAGE_MAPPING_FLAGS set) which doesn't appear to
have a helper exposed for a check. Given previous review about duplication
I felt best to reuse this even though it does access again... yes I felt
weird about doing that.

>
> > +
> > +		/*
> > +		 * Neither anonymous nor shmem-backed folios require
> > +		 * dirty tracking.
> > +		 */
> > +		ret = folio_test_anon(folio) ||
> > +			(mapping && shmem_mapping(mapping));
> > +	} else {
> > +		/* If the mapping is unstable, fallback to the slow path. */
> > +		ret = false;
> > +	}
> > +
> > +	unlock_rcu();
> > +
> > +	return ret;
>
> then becomes:
>
>
> 	if (folio_test_anon(folio))
> 		return true;

This relies on the mapping so belongs below the lockdep assert imo.

>
> 	/*
> 	 * Having IRQs disabled (as per GUP-fast) also inhibits RCU
> 	 * grace periods from making progress, IOW. they imply
> 	 * rcu_read_lock().
> 	 */
> 	lockdep_assert_irqs_disabled();
>
> 	/*
> 	 * Inodes and thus address_space are RCU freed and thus safe to
> 	 * access at this point.
> 	 */
> 	mapping = folio_mapping(folio);
> 	if (mapping && shmem_mapping(mapping))
> 		return true;
>
> 	return false;
>
> > +}

I'm more than happy to do this (I'd rather drop the RCU bits if possible)
but need to be sure it's safe.
