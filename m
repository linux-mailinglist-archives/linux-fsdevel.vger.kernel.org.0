Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB21752FDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjGNDSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjGNDSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:18:13 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D72D7B
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:18:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5701e8f2b79so13677067b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689304684; x=1691896684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5se9Q71tYrZnYz6cTWfOJGaDcecrGWzMqmmZbM1fWLU=;
        b=Jzcqxiz/lynPa8ympALsP1auz+/hu6TJ04+k4CK4OgDPKg+x92BMvc47W1PhzYOuGN
         OK6/8Ji93TOPza3RmieB8DjAWzJgmPv9Rn+TmCULAiLnxhs3auDIGJlwbFc4unqX5vxl
         MCJAh9ybogbvwoMm2FAET6IAYW3YJg3OGxVctHY+712aM02pCbKhN0f9pCrfV3jeap6o
         Kpytb3uT0oTkE9hAXQE21jJNZiurtD9HjpCh330QuIaJC17kWczgkjjnPtNmVmN/PKCG
         oLgyIY1fEestYkws4KgvEkc//fYhFvK9bHqzi5W0mCOtu7kOGCw2kiL0A4dMPEuPzwRV
         MFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689304684; x=1691896684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5se9Q71tYrZnYz6cTWfOJGaDcecrGWzMqmmZbM1fWLU=;
        b=UKYBBCvpwpvJMeqETVg5AC7m6JngxI56tv3gk6MlpdVVUvrgg0JTfkP6WLH443UVSo
         ShXvYuhx3Imf6n0cc5Aexm4Hv/xb8AfQY/LpAfc5HYoV90rH7tviBQnXDYqxbmVLTS7v
         JMyIZ5PXwuvyb+v7YuXvsuR8B+75pFDTWYPLvDZth53EQYsZmdAWtif9jEOT6CvCv+ur
         Ebrxk9qnj/TMEzoH7hR6GoD9NrwhvEm9duinlDwXDZYFOTtPzhEzZSSXHo7ouNsGx7LB
         AF3a16fEHGT/m0lohDU/yLdoZY8hcebFeHRIecf6AAPMfXJe42kaV844DEbr4s0RnbDo
         v6qg==
X-Gm-Message-State: ABy/qLYdQlrwpNu79YzlqrK2rUSw3aYPt3HIC1HApnz7BqL4kIH5JTbQ
        jCuT+aEMN9s77x6Pv8pMqakGE6kfnBs1bsdR2Hu5WA==
X-Google-Smtp-Source: APBJJlE3lnuxNpjYdU4F1ikDK4OMPE+g4uHPqGjwZQAUijDdmSv2CaMDc8zC+fwV02pKQU8ycUcFGkj7naJqT5Oda6U=
X-Received: by 2002:a81:4992:0:b0:581:5cb9:6c2b with SMTP id
 w140-20020a814992000000b005815cb96c2bmr3145277ywa.45.1689304684008; Thu, 13
 Jul 2023 20:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-5-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-5-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:17:53 -0700
Message-ID: <CAJuCfpHQKd-ZahnHJFUqU3p6uERtTf7wyG66zWbULtVjjp7i8g@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mm: Move FAULT_FLAG_VMA_LOCK check into handle_pte_fault()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:20=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Push the check down from __handle_mm_fault().  There's a mild upside to
> this patch in that we'll allocate the page tables while under the VMA
> lock rather than the mmap lock, reducing the hold time on the mmap lock,
> since the retry will find the page tables already populated.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Took some time but seems safe to me...

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 6eda5c5f2069..52f7fdd78380 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4924,6 +4924,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>  {
>         pte_t entry;
>
> +       if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->=
vma)) {
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         if (unlikely(pmd_none(*vmf->pmd))) {
>                 /*
>                  * Leave __pte_alloc() until later: because vm_ops->fault=
 may
> @@ -5020,11 +5025,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area=
_struct *vma,
>         p4d_t *p4d;
>         vm_fault_t ret;
>
> -       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
> -               vma_end_read(vma);
> -               return VM_FAULT_RETRY;
> -       }
> -
>         pgd =3D pgd_offset(mm, address);
>         p4d =3D p4d_alloc(mm, pgd, address);
>         if (!p4d)
> --
> 2.39.2
>
