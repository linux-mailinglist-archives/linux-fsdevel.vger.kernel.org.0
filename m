Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC1752FEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjGND2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGND2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:28:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3B26B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:28:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57a551ce7e9so13114117b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689305283; x=1691897283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVS7ecz+Tx6laHctZLUv0aqtxaQcW9LCasiYQzJZMYU=;
        b=eunW4QV+6RRGw/XKHtzPWQVyx0X2YNeYREGetoPAyzUjRZssZD1vPmGeGbbDL6tnQC
         fZ0hwCUZZ4nBnVxb6UArgTU4jmuorGQm0RbZahLb7aRFzvDThpueeKIVy+a4OwA1iq75
         eg61QNjGlFFhczfi2CQTAmfQNF+qnOA3dxe0FuTDQx3sCEmrQ22k0OwtRWri67+YvYRI
         HlIBFh3PYH7OR1pxALop/EIXCRbjCq/oyvvjXOfM+sz9nL7QBniqvtMjSuRV+oFGI5hD
         oy5+FA0Ilwsjt36lwj1SLliF3iHYLA1KG1htM/8p0VyBp3HjD9Byz4gyNfNXOm7mbudt
         eBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305283; x=1691897283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVS7ecz+Tx6laHctZLUv0aqtxaQcW9LCasiYQzJZMYU=;
        b=fq8sIqd9V3lUMWXDRnlTkAMPXfguqMPBpAQDQzq1c+OpN5gU60ckDplt3RPUSq3sKE
         NSnGQ31tf6LQgOufHMhCZT9QqSNUVDK4RiL8uZU6AxaV7mxI58NqyitFKnUnAQV9Rhf9
         V4cLEicCxL5xIlR6D6J7xSYqZ/RoQfp+0mDwZOiQl2P/tidqkHkfPsR3xFukhBXuAGVe
         QZOJLHHVzE+jUyprt7K78SgeQmIbghUfyMTIlUlwFkGuF1gsqsBHrBoGTu1NTfnAtDXB
         sowKHh0lNNguhCz2J28NDEpGG0M2PIJkuHT6hC0fvzaL70d9/vr70JlmHZ1I+mi3JKdk
         TLeA==
X-Gm-Message-State: ABy/qLbcCAdlvltHCv3fS55en03iQ7FZ5LqR9XSIbENprHTsrMoBk0pS
        L/yPcMx3BM6aO7oYlkvINcrqvsTAiu7WLKS5R+sgTw==
X-Google-Smtp-Source: APBJJlFUI8JMbfb59tDAy3tY8cEvKiDjrPZtBmyBEphHPQPqyL8cp2mdpktOiqA7cmtzdAzLRadlrXed20wL7LTI6B4=
X-Received: by 2002:a0d:dc43:0:b0:57a:250:27ec with SMTP id
 f64-20020a0ddc43000000b0057a025027ecmr3583257ywe.32.1689305283106; Thu, 13
 Jul 2023 20:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-7-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-7-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:27:51 -0700
Message-ID: <CAJuCfpELoy5S7WMQan+FhtH+GewVh=PS58fyFt9Uri=+nfB2Yw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] mm: Move the FAULT_FLAG_VMA_LOCK check down from do_fault()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:21=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Perform the check at the start of do_read_fault(), do_cow_fault()
> and do_shared_fault() instead.  Should be no performance change from
> the last commit.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 88cf9860f17e..709bffee8aa2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4547,6 +4547,11 @@ static vm_fault_t do_read_fault(struct vm_fault *v=
mf)
>         vm_fault_t ret =3D 0;
>         struct folio *folio;
>
> +       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         /*
>          * Let's call ->map_pages() first and use ->fault() as fallback
>          * if page by the offset is not ready to be mapped (cold cache or
> @@ -4575,6 +4580,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vm=
f)
>         struct vm_area_struct *vma =3D vmf->vma;
>         vm_fault_t ret;
>
> +       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +               vma_end_read(vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         if (unlikely(anon_vma_prepare(vma)))
>                 return VM_FAULT_OOM;
>
> @@ -4615,6 +4625,11 @@ static vm_fault_t do_shared_fault(struct vm_fault =
*vmf)
>         vm_fault_t ret, tmp;
>         struct folio *folio;
>
> +       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +               vma_end_read(vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         ret =3D __do_fault(vmf);
>         if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_R=
ETRY)))
>                 return ret;
> @@ -4661,11 +4676,6 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>         struct mm_struct *vm_mm =3D vma->vm_mm;
>         vm_fault_t ret;
>
> -       if (vmf->flags & FAULT_FLAG_VMA_LOCK){
> -               vma_end_read(vma);
> -               return VM_FAULT_RETRY;
> -       }
> -
>         /*
>          * The VMA was not fully populated on mmap() or missing VM_DONTEX=
PAND
>          */
> --
> 2.39.2
>
