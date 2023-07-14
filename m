Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7E752FEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjGND1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGND1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:27:10 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409A212E
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:27:09 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5703d12ab9aso13797237b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689305228; x=1691897228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qja0tGHUe3CsYUmybjA5LsF+JmwMV9f/Md1cgSpFeFc=;
        b=eBIxiJBmNuBrgP7lGfOCYZeaxPghyTYNFVFvrB8O7EUSpMHfLBf2WdBOStaLDe15JY
         1hGhXx+8d5UnegrQnkh37kGdVMyaC9X34saBUabXFlGOcOmm21t+kxrHpQBHohPp0V4E
         mZwMpUc1n5DgEsocrc19qZW8NiJGdu4R2gyGz6jq03FQCsa85Oi+zu8JNmyycmd/a9ow
         39M6bYOcRT52Zv807V16ymbMkJXnCGKRv5qev8LmyQsn/aN9udI8eTM0z7zKR2hMLUuO
         Rz+3uExoIX6IxPD1xhnQUfAg7wd/BjPOR+KvEHJVIhn//23vpJ+73ygxlH6Cgz9t2GMK
         vQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305228; x=1691897228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qja0tGHUe3CsYUmybjA5LsF+JmwMV9f/Md1cgSpFeFc=;
        b=GCs/WWLNfnxIN8J7xQqrBxSk400Njfn8FLZ9Z1BZ2OrzDNb4RYDBdt6ZLQRuXmmTEp
         NDI2uCta4p8dpuxZWjsqfNEG0PzyAo0J3KOSmk+Ry5GoDGQ4JrR+7ASWk42pPoXsfcDI
         SOTLt+Fcz6oI09HYpcmMoIf1ehN4AeJzppVbRl8lhdpso0XkLzRkpf9D62vNp5dqdSnz
         qz86nlcwfhDGqh+RiUegTQznbuCRIysy/lRx6/rriNYsXS/inID+eIofp6QXUzV8+JP+
         JZUOxXvu9GSJiVsNIQZU5dEdh2Wcm5R3gLfZ0782lEr5OB5ULI2RqtW9tARrhDeTBIRB
         s/XQ==
X-Gm-Message-State: ABy/qLaocVG7VGvgl444z7O+iuvtq2pbwnj3lGtYJwf62sUwWHLwG9E1
        8DQ3H6yiVXr0Ap7aKhGKMk7paR3zgAiTwOu8PJlTyg==
X-Google-Smtp-Source: APBJJlF734dzdExqRsWZRf+j+L3+ORNaprFS+TD7rC3zGtYH5xO5mXdouTYbUfYS4VP5VS+yM81ztEOoaQ1jzCBLqYY=
X-Received: by 2002:a0d:e687:0:b0:57a:3f43:236a with SMTP id
 p129-20020a0de687000000b0057a3f43236amr3215201ywe.8.1689305228424; Thu, 13
 Jul 2023 20:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-6-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-6-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:26:57 -0700
Message-ID: <CAJuCfpGZguujc0NBe5ox+7Sq2ByWzFd6uhth35UYQoiJAxRuXQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mm: Move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
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
> Call do_pte_missing() under the VMA lock ... then immediately retry
> in do_fault().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 52f7fdd78380..88cf9860f17e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4661,6 +4661,11 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>         struct mm_struct *vm_mm =3D vma->vm_mm;
>         vm_fault_t ret;
>
> +       if (vmf->flags & FAULT_FLAG_VMA_LOCK){

nit: space before {

> +               vma_end_read(vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         /*
>          * The VMA was not fully populated on mmap() or missing VM_DONTEX=
PAND
>          */
> @@ -4924,11 +4929,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>  {
>         pte_t entry;
>
> -       if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->=
vma)) {
> -               vma_end_read(vmf->vma);
> -               return VM_FAULT_RETRY;
> -       }
> -

A comment a bit further talks about " A regular pmd is established and
it can't morph into a huge pmd by anon khugepaged, since that takes
mmap_lock in write mode"
I assume this is about collapse_pte_mapped_thp() and it does call
vma_start_write(vma), so I think we are ok.


>         if (unlikely(pmd_none(*vmf->pmd))) {
>                 /*
>                  * Leave __pte_alloc() until later: because vm_ops->fault=
 may
> @@ -4961,6 +4961,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>         if (!vmf->pte)
>                 return do_pte_missing(vmf);
>
> +       if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vmf->=
vma)) {
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         if (!pte_present(vmf->orig_pte))
>                 return do_swap_page(vmf);
>
> --
> 2.39.2
>
