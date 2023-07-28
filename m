Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE17671BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjG1QTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjG1QTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:19:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F5C26B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 09:19:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so3055545a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690561143; x=1691165943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiqXtLXb56gWHpFHlkrGXB0htpi3zn1ShhYELBek5ko=;
        b=bynKf6n+TpRfz0DyR2rYNbqu0v4M0dTgmVz8xWQq8X+28lhY2cl5XnPRKgqX9HAqiE
         H79vFTkAB/9Itwu2leZ1xBpWwBB4F2uReu+dWnEz72qQ+dgV9BK2g3sOlh+7HQG5ShkZ
         9P+UQsfvk3Zbb2D6K+z9GjqGwuGQGpMLf/2Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690561143; x=1691165943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiqXtLXb56gWHpFHlkrGXB0htpi3zn1ShhYELBek5ko=;
        b=LUnmQkJ3FqzBdyRQXU4btT7sTF2SB0by1EuTcv4gsUbJ+3qape9YSo6FwyygUBnlNu
         aAZompDyZ36AvoIi7Ako/YAt0hYCxKegxemRa4I2SE/843gCp0XWMXjE6aQYKwVtjVyz
         WdWt/R0gj7YGxolaXy0YD1pvpgZRBE+bzQJ03NumCgly6yWBzZXIh3I6cqqKjZvQVD10
         yZMRPvNNaiKp0ghBr+u2D8Mr3AypqPN6JSNO/SBGeby2MWZfNEcvO30Ur7G0pkIB0Nnu
         I0oLSWfD9Up7tQHEiM/IfpJv8S/gZ7QSMA8joZnCw+diejCAvcKaU7WtGFASNdbZU/SB
         nVvw==
X-Gm-Message-State: ABy/qLZdvDVOLCYsoQhjBe7DLl3VLF6p+ekw9U0T87w8sG6H3abDwzOk
        FNJbS5eDjabzUFpXA8qZjosRW9zTLAaO/B9p5tknYFCx
X-Google-Smtp-Source: APBJJlE3cne5zALqgtFqshukboTVhNzAd5CFZO8tEtsKzDGbgbspGb3/0DNKOfL8ZTJq8dwRcEvT/g==
X-Received: by 2002:a17:906:10cd:b0:94e:4489:f24d with SMTP id v13-20020a17090610cd00b0094e4489f24dmr3076902ejv.61.1690561143292;
        Fri, 28 Jul 2023 09:19:03 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090603d600b0099275c59bc9sm2229162eja.33.2023.07.28.09.19.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:19:02 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso3075339a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 09:19:02 -0700 (PDT)
X-Received: by 2002:a05:6402:1141:b0:51e:5322:a642 with SMTP id
 g1-20020a056402114100b0051e5322a642mr2296690edw.27.1690561141923; Fri, 28 Jul
 2023 09:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com>
In-Reply-To: <20230727212845.135673-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 09:18:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
Message-ID: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 14:28, David Hildenbrand <david@redhat.com> wrote:
>
> This is my proposal on how to handle the fallout of 474098edac26
> ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
> accidentially missed that follow_page() and smaps implicitly kept the
> FOLL_NUMA flag clear by *not* setting it if FOLL_FORCE is absent, to
> not trigger faults on PROT_NONE-mapped PTEs.

Ugh.

I hate how it uses FOLL_FORCE that is inherently scary.

Why do we have that "gup_can_follow_protnone()" logic AT ALL?

Couldn't we just get rid of that disgusting thing, and just say that
GUP (and follow_page()) always just ignores NUMA hinting, and always
just follows protnone?

We literally used to have this:

        if (!(gup_flags & FOLL_FORCE))
                gup_flags |= FOLL_NUMA;

ie we *always* set FOLL_NUMA for any sane situation. FOLL_FORCE should
be the rare crazy case.

The original reason for not setting FOLL_NUMA all the time is
documented in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
page faults from gup/gup_fast") from way back in 2012:

         * If FOLL_FORCE and FOLL_NUMA are both set, handle_mm_fault
         * would be called on PROT_NONE ranges. We must never invoke
         * handle_mm_fault on PROT_NONE ranges or the NUMA hinting
         * page faults would unprotect the PROT_NONE ranges if
         * _PAGE_NUMA and _PAGE_PROTNONE are sharing the same pte/pmd
         * bitflag. So to avoid that, don't set FOLL_NUMA if
         * FOLL_FORCE is set.

but I don't think the original reason for this is *true* any more.

Because then two years later in 2014, in commit c46a7c817e66 ("x86:
define _PAGE_NUMA by reusing software bits on the PMD and PTE levels")
Mel made the code able to distinguish between PROT_NONE and NUMA
pages, and he changed the comment above too.

But I get the very very strong feeling that instead of changing the
comment, he should have actually removed the comment and the code.

So I get the strong feeling that all these FOLL_NUMA games should just
go away. You removed the FOLL_NUMA bit, but you replaced it with using
FOLL_FORCE.

So rather than make this all even more opaque and make it even harder
to figure out why we have that code in the first place, I think it
should all just be removed.

The original reason for FOLL_NUMA simply does not exist any more. We
know exactly when a page is marked for NUMA faulting, and we should
simply *ignore* it for GUP and follow_page().

I think we should treat a NUMA-faulting page as just being present
(and not NUMA-fault it).

Am I missing something?

                  Linus
