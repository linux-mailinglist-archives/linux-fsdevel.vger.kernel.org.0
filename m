Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAEC6F1C11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbjD1P5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1P5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8432D51
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682697422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zf2i3kVXtlVgFFMbGoUpKI0IDlebsU5o6nl1WehrK4Y=;
        b=WZftwkHuUmn1AsZCykRUmgsb6D66yWFCvVLobkOSLMa8trvFrpIY+hFcOErWT7ZGcarx0D
        PuBoKLJJ+Yop5xWU19mALUsQGjX/vf6/rRSY5il8Updr2HGWrvLy64R3yFYCysaRjZCejz
        4/yqEyglRbyjWi+HpKNWEKe3bKGdJjE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-9yMPl1kyOUKGjLlFN990rA-1; Fri, 28 Apr 2023 11:57:00 -0400
X-MC-Unique: 9yMPl1kyOUKGjLlFN990rA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ecc0c4b867so24761cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 08:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697420; x=1685289420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf2i3kVXtlVgFFMbGoUpKI0IDlebsU5o6nl1WehrK4Y=;
        b=hm5S03A7cAewRq9QZP8OQh73wpzYASOOFbpoaYIFNWYbSc6bAWLzzJngesg2cpKdZ3
         9ChiPG3b1ZI954uwCPslnopTwXg4xi9ZvwQxodkX7nNN7NoyFRuD5YyYjbwNY0UXmAdI
         jMoR7BiMQbY9Gpp0eVUiAS8sJMX65zARLPS0CVWYwoDsDiby610N1MsIS6weCzCVpl80
         fj38ykqjIoZPCjOW90Y5PuG3XKa3nD/ym99DHW148EQ8pio2kqq9yVGvmG8epHn4UEMt
         G3Mb/gsl1P/iuSTW8BvVy46nHV0N1vaJFti0wYlfoGvSPKfkaWjWNtyrOIfjSWnuLZm6
         8dGA==
X-Gm-Message-State: AC+VfDzfS/tgCENFl6jgHgYcGMb0J0kvB9LyIO60X3t43Mwh1CU0Xu8Y
        bisFmZl7yWqoePV36EsIcHaA1bnqjjxEANqLpOQ5xFiW8VcfT6yell/819jcqvn+XCy3lW2ULKB
        Vof7ngMn8HHaaZFIyC3c4Q/Oleg==
X-Received: by 2002:a05:622a:1047:b0:3f0:a887:7d2c with SMTP id f7-20020a05622a104700b003f0a8877d2cmr5184843qte.6.1682697419812;
        Fri, 28 Apr 2023 08:56:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ehg//He+hcp0mx8gVUNQ8HJe0s0NcsM4chiANUARw7z3NEuycfTLFrEHAF1k8Z5nqwT+zkQ==
X-Received: by 2002:a05:622a:1047:b0:3f0:a887:7d2c with SMTP id f7-20020a05622a104700b003f0a8877d2cmr5184790qte.6.1682697419513;
        Fri, 28 Apr 2023 08:56:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o16-20020ac872d0000000b003ef5ba0702fsm6392726qtp.7.2023.04.28.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:56:58 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:56:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
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
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5] mm/gup: disallow GUP writing to file-backed mappings
 by default
Message-ID: <ZEvsx998gDFig/zq@x1n>
References: <6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com>
 <afcc124e-7a9b-879c-dfdf-200426b84e24@redhat.com>
 <ZEvZtIb2EDb/WudP@nvidia.com>
 <094d2074-5b69-5d61-07f7-9f962014fa68@redhat.com>
 <400da248-a14e-46a4-420a-a3e075291085@redhat.com>
 <077c4b21-8806-455f-be98-d7052a584259@lucifer.local>
 <62ec50da-5f73-559c-c4b3-bde4eb215e08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62ec50da-5f73-559c-c4b3-bde4eb215e08@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 05:34:35PM +0200, David Hildenbrand wrote:
> On 28.04.23 17:33, Lorenzo Stoakes wrote:
> > On Fri, Apr 28, 2023 at 05:23:29PM +0200, David Hildenbrand wrote:
> > > > > 
> > > > > Security is the primary case where we have historically closed uAPI
> > > > > items.
> > > > 
> > > > As this patch
> > > > 
> > > > 1) Does not tackle GUP-fast
> > > > 2) Does not take care of !FOLL_LONGTERM
> > > > 
> > > > I am not convinced by the security argument in regard to this patch.
> > > > 
> > > > 
> > > > If we want to sells this as a security thing, we have to block it
> > > > *completely* and then CC stable.
> > > 
> > > Regarding GUP-fast, to fix the issue there as well, I guess we could do
> > > something similar as I did in gup_must_unshare():
> > > 
> > > If we're in GUP-fast (no VMA), and want to pin a !anon page writable,
> > > fallback to ordinary GUP. IOW, if we don't know, better be safe.
> > 
> > How do we determine it's non-anon in the first place? The check is on the
> > VMA. We could do it by following page tables down to folio and checking
> > folio->mapping for PAGE_MAPPING_ANON I suppose?
> 
> PageAnon(page) can be called from GUP-fast after grabbing a reference. See
> gup_must_unshare().

Hmm.. Is it a good idea at all to sacrifise all "!anon" fast-gups for this?
People will silently got degrade even on legal pins on shmem/hugetlb, I
think, which seems to be still a very major use case.

-- 
Peter Xu

