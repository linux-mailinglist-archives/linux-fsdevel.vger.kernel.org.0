Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A776A0DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjGaTID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGaTHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:07:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903D1B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:07:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso704556066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690830470; x=1691435270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0D+OWW2wByasWNJM+tEhbiKI7Yb1duh5NU83GOmeCY=;
        b=JZwiXX7skaxM5ZjjFhi+e88VSUCJ8kQ6OIPqSH+47oIZCTJNOQvi1mWqvTiYd5fpGS
         nf1Q/xIzB0oB1Hmfz0iGiYhAu52LznBvcxYIaocckrzcWi8BjpWDFg4fUb6QSXt8RUcq
         7RXhWWdqPwcUUYb8cbvwKwBt6eKXrxsidzbSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830470; x=1691435270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0D+OWW2wByasWNJM+tEhbiKI7Yb1duh5NU83GOmeCY=;
        b=g8jGvt88cuOuhg3l17JVUl2cL1Uy5jMwF26D/sUqDhEbhXXawjAdG9qh5LB4LaZGWP
         st92snAISOIdMyYPLaWIB2Ni/SzpxL6aB2A8WrXGHJu4D+pyHgH6vOVR1rjzyRpGAD3X
         S8GdjCT9gB1WV44F++GtjiE64651PtDjxwHrGt5rd5n332j2CSfeTANo/WNcacwGnoWE
         uWh3d0QpooYQ7j2phbKHiVcTIXWCr2DCVeibW/hJuGqBfsLrwPCDObb7BazRSBvRa+vI
         tkoIiP+MKhbGzRykFCppRzLKJu2cOqe5PtsI58cl9VlnhiSd1JFnnJO997WvFcIyHDXc
         sI3A==
X-Gm-Message-State: ABy/qLa/0PXdMFnF5qwabHn4HBxDs8GDoKh8Bua+GueRrs34T4i+HUWV
        8fbTTHDNerJXR3DrI89NkE+f9zDgp8GXtsVMHqSBjlHR
X-Google-Smtp-Source: APBJJlEW3YqxSC679Go8Jw3ZN/FD1VGejYTHEEx/wNwJCPj8lKvBg4QdYokIliW7sPzFq81tRE01fQ==
X-Received: by 2002:a17:906:2214:b0:99b:4956:e4df with SMTP id s20-20020a170906221400b0099b4956e4dfmr529702ejs.11.1690830469869;
        Mon, 31 Jul 2023 12:07:49 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id s13-20020a1709060c0d00b009930042510csm6502142ejf.222.2023.07.31.12.07.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:07:49 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-522aad4e82fso3901988a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:07:48 -0700 (PDT)
X-Received: by 2002:aa7:d702:0:b0:51e:d4b:3c9d with SMTP id
 t2-20020aa7d702000000b0051e0d4b3c9dmr679676edq.23.1690830468573; Mon, 31 Jul
 2023 12:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com> <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
 <ZMfc9+/44kViqjeN@x1n> <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com> <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
In-Reply-To: <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
Message-ID: <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Jul 2023 at 12:00, David Hildenbrand <david@redhat.com> wrote:
>
> So in the "!writable" case, we would always call
> get_user_pages_unlocked() and never honor NUMA faults.

Ok, so kvm doesn't just use the fast version. Oh well. It was an idea..

         Linus
