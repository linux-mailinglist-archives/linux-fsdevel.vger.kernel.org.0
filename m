Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6F76A050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGaSY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGaSY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:24:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6BB1BC5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 11:24:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so7441373e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690827857; x=1691432657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JsJGaMslWBF9ml2379UCHrdiT1Bj5wN4ELxCIbCizg=;
        b=CtRurR7TocHfwYJED+G5FJni7/g3phT4SLTFdA3TZ23s5uriP01O/X5nquVcDm3ccP
         IwG96ndm/zHE233TIveqlV9fL/k3riH3i6vQuif/IIBJZiV+amRWGNzT11kEl0j4f7UX
         4qcBotaaEm8KSelrT9L5ebHAjRNuDWzwNAGRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827857; x=1691432657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JsJGaMslWBF9ml2379UCHrdiT1Bj5wN4ELxCIbCizg=;
        b=OkaZ+MrjCr/zrXQi9IlJ9HQLXP4rPxNYBBDyr5cmmXK+/qtCACMjfeesrzPE+LMqOk
         cmhGy7XEgLrIS0LZUK3i3BKuUoZEyxqVyMvp99/jbSl+PN80wutt8b+DtXT9X8XPnMhF
         XTHRTzHeFN7cc7mAgyLLb4Kq2XGZhrEoGxS6w2AaF+ZgooTCAmM1yRYincPSwZNIb42U
         mGOxm5n/k0dQVjEZdyBLKf3JlEuDXs+F9O7TvnSWj6faw0ystakm2oD3WvIzC1/I+1wd
         Qjcl61h2UKjdwhWXl1oH3m3a6o1JQgA1vvo12LbxPT0Bci5w+Q1Gey9YxLyATsgI0f9K
         opug==
X-Gm-Message-State: ABy/qLbeKeyfdWwFhRRZKE3zdY80Rmh32sbuvs/eAv4z7R1UQRfIBODd
        dBNfmJ/bPJpjc71Ahzgz7g9TMJGvZ+FdCtEjmBXD4Hib
X-Google-Smtp-Source: APBJJlGsp34TN3zU2r0lH1uE+ugYLdc66A1XqgnDmHTsGgJjmxzh3FcyBKhl5wWx2/Ltx3shHO4tzg==
X-Received: by 2002:ac2:5f8a:0:b0:4fd:d4b4:faba with SMTP id r10-20020ac25f8a000000b004fdd4b4fabamr455792lfe.51.1690827857068;
        Mon, 31 Jul 2023 11:24:17 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25110000000b004fe1fc5d0e3sm1714552lfb.206.2023.07.31.11.24.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:24:16 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so7441344e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 11:24:16 -0700 (PDT)
X-Received: by 2002:a05:6512:20c1:b0:4fd:faa3:2352 with SMTP id
 u1-20020a05651220c100b004fdfaa32352mr423948lfr.14.1690827855949; Mon, 31 Jul
 2023 11:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com> <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
 <ZMfc9+/44kViqjeN@x1n> <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
In-Reply-To: <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 11:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
Message-ID: <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
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

On Mon, 31 Jul 2023 at 09:20, David Hildenbrand <david@redhat.com> wrote:
>
> I modified it slightly: FOLL_HONOR_NUMA_FAULT is now set in
> is_valid_gup_args(), such that it will always be set for any GUP users,
> including GUP-fast.

But do we actually want that? It is actively crazy to honor NUMA
faulting at least for get_user_pages_remote().

So right now, GUP-fast requires us to honor NUMA faults, because
GUP-fast doesn't have a vma (which in turn is because GUP-fast doesn't
take any locks).

So GUP-fast can only look at the page table data, and as such *has* to
fail if the page table is inaccessible.

But GUP in general? Why would it want to honor numa faulting?
Particularly by default, and _particularly_ for things like
FOLL_REMOTE.

In fact, I feel like this is what the real rule should be: we simply
define that get_user_pages_fast() is about looking up the page in the
page tables.

So if you want something that acts like a page table lookup, you use
that "fast" thing.  It's literally how it is designed. The whole - and
pretty much only - point of it is that it can be used with no locking
at all, because it basically acts like the hardware lookup does.

So then if KVM wants to look up a page in the page table, that is what
kvm should use, and it automatically gets the "honor numa faults"
behavior, not because it sets a magic flag, but simply because that is
how GUP-fast *works*.

But if you use the "normal" get/pin_user_pages() function, which looks
up the vma, at that point you are following things at a "software
level", and it wouldn't do NUMA faulting, it would just get the page.

(Ok, we have the whole "FAST_ONLY vs fall back" case, so "fast" can
look up the vma too, but read the above argument as "fast *can* be
done without vma, so fast must honor page table bits as per
hardware").

              Linus
