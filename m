Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF27C765BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjG0TA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjG0TAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0E2D73
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690484369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMOQdXUv2yVWKzk+yt3Uwzdo1xJhdejfXEHNT0nP2D4=;
        b=hnDKKPVXtH2Kl49Ugtdpxda3aHoDgldsUkJF95vEFLlHM/J2dSWJYiMkudAdbsdXsSCIFu
        4bVYaatkaHOpay+fBPmj0KdmncorKaeGnyUvr84/76+ieMfWzl0iikKOKLCayc2V57EOnx
        NQ49gRTHwreWzmwSiPNmcXQUN7coXxw=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-XeHLn5ZhP3qI9SsPq4C7Qg-1; Thu, 27 Jul 2023 14:59:28 -0400
X-MC-Unique: XeHLn5ZhP3qI9SsPq4C7Qg-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4864d4dc337so46482e0c.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 11:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484368; x=1691089168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMOQdXUv2yVWKzk+yt3Uwzdo1xJhdejfXEHNT0nP2D4=;
        b=Pu46vcIQEaB+JXr3wOJO8dtOuoxz23JQvUiYWn/6x06TLScSQ+XMkymtw+uPJFsiGu
         acUPHqxKOElnfDz8yVFTdWADfvOnHp6IMgsb1o+wfJMG89ch8fsYb9dIB7FAhsGx3yc3
         dx9Jz4LdtkZd4UT2QYzvAFvumL82s6emRus9xDLBNWMSCKg34qGLbWimU8+cjaMhQVTj
         vTGK8AdJQhlk8Mdm+X3ePVLEW3UdZ8YFU6IOQeepA5MJpfm4MxtnEhrD3TFFG8qOw0lW
         IxHWd3mP7Laf39De1LGhDFR8ue2u3g63kHeGoLh02FAg1anLUfO9cftAo/uGORApL0Wb
         C74Q==
X-Gm-Message-State: ABy/qLaiflq4NGSYRlL+bk4iYwFGGFlNJ4h3FPO3rxHd0bKVU1ENbVU+
        mwQtgdVGcuGKYiRA6sZYOzycLSQeRSP0U/hOgwfVnKAoB5dsCW+SEcJ3vG1rzPqaRMvTUUULIzA
        ns313Ky5mMjut8MzxjzOm6bZtAA==
X-Received: by 2002:a05:6122:985:b0:471:c1e9:f9bb with SMTP id g5-20020a056122098500b00471c1e9f9bbmr399989vkd.0.1690484367920;
        Thu, 27 Jul 2023 11:59:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8X06vYzK90HGV2bXKMhvJAhmCYwqU27IT+hrPEO9guKFDUgBmgYGePjsCNkSeDfXXAw2qsw==
X-Received: by 2002:a05:6122:985:b0:471:c1e9:f9bb with SMTP id g5-20020a056122098500b00471c1e9f9bbmr399978vkd.0.1690484367623;
        Thu, 27 Jul 2023 11:59:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z4-20020a0cf244000000b0063cf8ae182esm613643qvl.60.2023.07.27.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:59:27 -0700 (PDT)
Date:   Thu, 27 Jul 2023 14:59:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
Message-ID: <ZMK+jSDgOmJKySTr@x1n>
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n>
 <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
 <ZMKJjDaqZ7FW0jfe@x1n>
 <5a2c9ae4-50f5-3301-3b50-f57026e1f8e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a2c9ae4-50f5-3301-3b50-f57026e1f8e8@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:27:02PM +0200, David Hildenbrand wrote:
> > > 
> > > This was wrong from the very start. If we're not in GUP, we shouldn't call
> > > GUP functions.
> > 
> > My understanding is !GET && !PIN is also called gup.. otherwise we don't
> > need GET and it can just be always implied.
> 
> That's not the point. The point is that _arbitrary_ code shouldn't call into
> GUP internal helper functions, where they bypass, for example, any sanity
> checks.

What's the sanity checks that you're referring to?

> 
> > 
> > The other proof is try_grab_page() doesn't fail hard on !GET && !PIN.  So I
> > don't know whether that's "wrong" to be used..
> > 
> 
> To me, that is arbitrary code using a GUP internal helper and, therefore,
> wrong.
> 
> > Back to the topic: I'd say either of the patches look good to solve the
> > problem.  If p2pdma pages are mapped as PFNMAP/MIXEDMAP (?), I guess
> > vm_normal_page_pmd() proposed here will also work on it, so nothing I see
> > wrong on 2nd one yet.
> > 
> > It looks nicer indeed to not have FOLL_FORCE here, but it also makes me
> > just wonder whether we should document NUMA behavior for FOLL_* somewhere,
> > because we have an implication right now on !FOLL_FORCE over NUMA, which is
> > not obvious to me..
> 
> Yes, we probably should. For get_use_pages() and friends that behavior was
> always like that and it makes sense: usually it represent application
> behavior.
> 
> > 
> > And to look more over that aspect, see follow_page(): previously we can
> > follow a page for protnone (as it never applies FOLL_NUMA) but now it won't
> > (it never applies FOLL_FORCE, either, so it seems "accidentally" implies
> > FOLL_NUMA now).  Not sure whether it's intended, though..
> 
> That was certainly an oversight, thanks for spotting that. That patch was
> not supposed to change semantics:
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 76d222ccc3ff..ac926e19ff72 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -851,6 +851,13 @@ struct page *follow_page(struct vm_area_struct *vma,
> unsigned long address,
>         if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
>                 return NULL;
> 
> +       /*
> +        * In contrast to get_user_pages() and friends, we don't want to
> +        * fail if the PTE is PROT_NONE: see gup_can_follow_protnone().
> +        */
> +       if (!(foll_flags & FOLL_WRITE))
> +               foll_flags |= FOLL_FORCE;
> +
>         page = follow_page_mask(vma, address, foll_flags, &ctx);
>         if (ctx.pgmap)
>                 put_dev_pagemap(ctx.pgmap);

This seems to be slightly against your other solution though for smaps,
where we want to avoid abusing FOLL_FORCE.. isn't it..

Why read only?  That'll always attach FOLL_FORCE to all follow page call
sites indeed for now, but just curious - logically "I want to fetch the
page even if protnone" is orthogonal to do with write permission here to
me.

I still worry about further abuse of FOLL_FORCE, I believe you also worry
that so you proposed the other way for the smaps issue.

Do you think we can just revive FOLL_NUMA?  That'll be very clear to me
from that aspect that we do still have valid use cases for it.

The very least is if with above we should really document FOLL_FORCE - we
should mention NUMA effects.  But that's ... really confusing. Thinking
about that I personally prefer a revival of FOLL_NUMA, then smaps issue all
go away.

Thanks,

-- 
Peter Xu

