Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C711510B68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiDZVhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbiDZVhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:37:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C161A5DC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 14:34:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so219221iov.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJHneikLXEGfJde4krQasd9PQhsFRpApoS4ZRag7+RU=;
        b=EdwxR0V/0R58E5VQDj0HrytGDcfRa0ZaI7Me6rDBjirAgNHRbWWWvGaw7HmQEIGzu+
         8UTTpBJpVmtohKiGL5cVYIq8PicWJvFUQVly2vSP4TS+56W86k/aX6l5WCrdoFzyILM+
         1Yehf40AqvUszrZodWCBswvT50v8vrsYb0CT9VT0ik1assb3s50rjI/Ghc6ERMC0+hQS
         kngQQpUrenrx0Z/CG7kuYI7vOHHB9pxCvklytawOfmTdu9cTLRddizluzNirEjBtvgHq
         /7wjZvrPSoiAuTCiyBqcBwBGz7SjzYicglmkQ0p2ZcHJZmj17y1/IkCZAoejAg68UMHJ
         xOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJHneikLXEGfJde4krQasd9PQhsFRpApoS4ZRag7+RU=;
        b=BXJf22LQ0yxCfGR9NNmyWffzC+UuAinRpS9rtMj8S5LWKo1WD2Z24KHSEgGt+lmJmM
         pLdFtT/aRTBf81hJem9oRqnh4RkoEJ9Q3bh4Z3V3bi3ICyRALQyVi7hFX5c2kBIMHwi6
         +22CXuKr9eRi1XakWY2QNNI9Kp/scDl4wsUuEt84iP3/QnMmj7nSbK2z0GNHe/fIa4S3
         g3MlAaMlrReHbXMYcVnTtxbY2XWirFQIqkm0PFyOz5A93qjeHG+Xcpj8uSAhKT9e6fEE
         RgCShwjxTsoq2x98zW6eBezwY7FTm9WPDd7jveZsap3sHTl4OPwJnAkhbKig+aPgNwmW
         KLKg==
X-Gm-Message-State: AOAM533we3AhEg82fnXgfcMwTvSqzNv6cO2LjCXRAQEi/1wVyUXhB+av
        LxhpfmgUPYiel75Voi+akeg6QFrQlef2oovZ6APYIw==
X-Google-Smtp-Source: ABdhPJyGNR5sOXzGqUeKg6keEazd9H9Z8L/jAzBgMCoHI+lyyK7gNjS+2erCu0X4dzgJTpnr7YSLg3mNpJ5fsfcJHI0=
X-Received: by 2002:a5d:9448:0:b0:657:24e0:c0b2 with SMTP id
 x8-20020a5d9448000000b0065724e0c0b2mr10388348ior.167.1651008843696; Tue, 26
 Apr 2022 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-3-axelrasmussen@google.com> <YmhW+mOuQUWsByj4@xz-m1.local>
In-Reply-To: <YmhW+mOuQUWsByj4@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 26 Apr 2022 14:33:27 -0700
Message-ID: <CAJHvVch=8znnY-u1PbPb1qUeczn+9AR_eZOP5z9kD6PgtPQjrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:33 PM Peter Xu <peterx@redhat.com> wrote:
>
> Axel,
>
> On Fri, Apr 22, 2022 at 02:29:41PM -0700, Axel Rasmussen wrote:
> > @@ -65,6 +66,8 @@ struct userfaultfd_ctx {
> >       unsigned int flags;
> >       /* features requested from the userspace */
> >       unsigned int features;
> > +     /* whether or not to handle kernel faults */
> > +     bool handle_kernel_faults;
>
> Could you help explain why we need this bool?  I failed to figure out
> myself on the difference against "!(ctx->flags & UFFD_USER_MODE_ONLY)".

Ah, yeah you're right, we can get rid of it and just rely on
UFFD_USER_MODE_ONLY.

Just to add context, in a previous version I never sent out, I had:

ctx->handle_kernel_faults = userfaultfd_allowed(...);

That's wrong for other reasons, but if we were going to do that we'd
have to store the result, since it's a function not just of the flags,
but also of the method used to create the userfaultfd. I changed this
without also dropping the boolean, which can now be cleaned up. I'll
include this change in a v3.

>
> Thanks,
>
> --
> Peter Xu
>
