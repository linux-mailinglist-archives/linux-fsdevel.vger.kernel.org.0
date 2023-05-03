Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00E6F5A33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjECOen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjECOed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176097696
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683124387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFXd5ix15SvNReqhl4i1pG9MIhuegRONOWBlaLSwSeQ=;
        b=jOjXn/+Ze6v00vPc9Bw5aM91h6OaAspjWeWS9H/Yhpecb7Sy+fv+xMGVn+337aulV21WL9
        ELPXoBt2AmnFDxWQUXvHATA+LzQ/L9aBQfe3/l0rMN4s4Kd35ddwOiKS/RQQrpG/TCnkSO
        TH8+ZIfrZoKgE+59Xatsf8PPTmPgOto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-8zbaDiWMM7K8lLQGuEjkPg-1; Wed, 03 May 2023 10:33:06 -0400
X-MC-Unique: 8zbaDiWMM7K8lLQGuEjkPg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f171d201afso31911495e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 07:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124385; x=1685716385;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFXd5ix15SvNReqhl4i1pG9MIhuegRONOWBlaLSwSeQ=;
        b=BKQf882k7xMAyc2r91RS/iJEoHCf29AuByVMLIXdLKcSQ4Y00Lb2HlvPi8FaFeN5ek
         q77THVFpz6e8bRIzTCvjI7ashevHPTfMeOAtY6cG3WQ0j1UIcho9m84TIyGSVRyPw8A2
         L+93w+vvaygbLOjVxN0pRZckJJjBgJpLPCVdUJqdF1jcGYP2NSuQ2j4w9QZJhl1GJ+bn
         IX0aJ3fGNRg1v/xdptTLiQRpVWFp0HRfZ+qTY5iAvUMDYBaduFetJqAEbvHiRsy4KX7i
         Ymdd1Vgjp0CEz7uYQ4LFd7r3OKNU+1ivfe0lkRiq8LMjs1NvjY0rAqLsEugQiQ/hQKnX
         3zoA==
X-Gm-Message-State: AC+VfDwNJmDpCyfpGJ4mTUIys2XbLN+dcdFft2PIGgg+rpWHtMJpBwBW
        Ja2dO6VrzdpauAra/FTvGX/IAe3COPYXxLSgURduloY4aFy0kdgX+SQr1SLQwDiUA1URirEYIe/
        r+FmRtGiUL9hJ8Iw9P/T6gx4mZg==
X-Received: by 2002:a1c:f217:0:b0:3f2:5641:1477 with SMTP id s23-20020a1cf217000000b003f256411477mr15136877wmc.2.1683124384968;
        Wed, 03 May 2023 07:33:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IA1wfeoYMvE0N/oKVhaMpFqr+HbxFL4frAmX6LWoafreyHi/p/vsvnASiXOwopn3+i8VKyw==
X-Received: by 2002:a1c:f217:0:b0:3f2:5641:1477 with SMTP id s23-20020a1cf217000000b003f256411477mr15136833wmc.2.1683124384528;
        Wed, 03 May 2023 07:33:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:6a00:9109:6424:1804:a441? (p200300cbc7116a00910964241804a441.dip0.t-ipconnect.de. [2003:cb:c711:6a00:9109:6424:1804:a441])
        by smtp.gmail.com with ESMTPSA id u24-20020a7bc058000000b003f173987ec2sm2063013wmc.22.2023.05.03.07.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 07:33:03 -0700 (PDT)
Message-ID: <052b66e9-eed2-15a4-cecf-fa26f5cc49c9@redhat.com>
Date:   Wed, 3 May 2023 16:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 2/3] mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing
 to file-backed mappings
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
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
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683067198.git.lstoakes@gmail.com>
 <f7533317ee29a1a4aa54afe0002367a4cd288a1d.1683067198.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f7533317ee29a1a4aa54afe0002367a4cd288a1d.1683067198.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.05.23 00:51, Lorenzo Stoakes wrote:
> Writing to file-backed mappings which require folio dirty tracking using
> GUP is a fundamentally broken operation, as kernel write access to GUP
> mappings do not adhere to the semantics expected by a file system.
> 
> A GUP caller uses the direct mapping to access the folio, which does not
> cause write notify to trigger, nor does it enforce that the caller marks
> the folio dirty.
> 
> The problem arises when, after an initial write to the folio, writeback
> results in the folio being cleaned and then the caller, via the GUP
> interface, writes to the folio again.
> 
> As a result of the use of this secondary, direct, mapping to the folio no
> write notify will occur, and if the caller does mark the folio dirty, this
> will be done so unexpectedly.
> 
> For example, consider the following scenario:-
> 
> 1. A folio is written to via GUP which write-faults the memory, notifying
>     the file system and dirtying the folio.
> 2. Later, writeback is triggered, resulting in the folio being cleaned and
>     the PTE being marked read-only.
> 3. The GUP caller writes to the folio, as it is mapped read/write via the
>     direct mapping.
> 4. The GUP caller, now done with the page, unpins it and sets it dirty
>     (though it does not have to).
> 
> This results in both data being written to a folio without writenotify, and
> the folio being dirtied unexpectedly (if the caller decides to do so).
> 
> This issue was first reported by Jan Kara [1] in 2018, where the problem
> resulted in file system crashes.
> 
> This is only relevant when the mappings are file-backed and the underlying
> file system requires folio dirty tracking. File systems which do not, such
> as shmem or hugetlb, are not at risk and therefore can be written to
> without issue.
> 
> Unfortunately this limitation of GUP has been present for some time and
> requires future rework of the GUP API in order to provide correct write
> access to such mappings.
> 
> However, for the time being we introduce this check to prevent the most
> egregious case of this occurring, use of the FOLL_LONGTERM pin.
> 
> These mappings are considerably more likely to be written to after
> folios are cleaned and thus simply must not be permitted to do so.
> 
> This patch changes only the slow-path GUP functions, a following patch
> adapts the GUP-fast path along similar lines.
> 
> [1]:https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Mika Penttilä <mpenttil@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

