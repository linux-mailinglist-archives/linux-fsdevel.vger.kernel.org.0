Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC96752FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjGNDcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjGNDck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:32:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B226A5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:32:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57688a146ecso13611277b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689305558; x=1691897558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms2nXM5/BYwo7k1GZ/TYUrAcxu0MWAJVcs3twyNZFFA=;
        b=kBrYQjoaHeK5Wm7RCg7UO4ciFSyH+qP2dOrO9Lr5m1ohajjcGyumbjS5nPh71v5pnU
         +TlP8tO7rO3g0HdLAqPSfHxq+afufc9sRRiXhLhWZ8knNODUl9wv8zYt3foShtMGyokj
         LNFp3r4fs+ytYiaVsQ334hv7AOq0Z+E4c3BcACyb6jJ/Vj7kdRtZacTS4qa1FRclOaxu
         gvbcj63zfZiG4jGhmE7UPCkJP83qsp5R6SjwCnhzWjn5QYOhrUMuon+CFiTd7LM26uMr
         0jCYOr6p2E/kl2a05NnPHIvbX4ldvFJ9JfDNDA9gFXIefjuwnVv+VdamRPKTErKlScjs
         xsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305558; x=1691897558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms2nXM5/BYwo7k1GZ/TYUrAcxu0MWAJVcs3twyNZFFA=;
        b=bLl/A9/slaAXPvzP97Pkw+OAyAnDzgduKSIMFV34TOrRh5G5joPYFGXan25CRPEeiC
         DPw+TQmcZKX4Tu4xrj3v895jJxfN4/1WvApGUSiW3V9BLJsxFyKXV8OuhDXtoeO9SafH
         NgtOk1Xf2Iyu2bPoQ4cF+BB13/GgbMDHxyPQ89924R4ktyozbyCH+FCDlnYMmu/LBbPY
         y1B80Va8mYCH2bIe5q8HAYxJ7C+x1uiwKxx6PqyzFmEAcu68DmtvTQMStL3hb9NZ45AB
         vnKjvZQ9FZCTpEvjmLcoOPoAIMsNeTtLbsGF8Fyx9ESsCmTxOj9siGswgKwVpX59HhE8
         esyg==
X-Gm-Message-State: ABy/qLZTSdLSaZBcUiVLkM3qFYlcXPQayYP1O/4L6b84tD8NM/9Dgyoy
        PJ3vA4MGtXKtyPkqbYhcWeHD0AZKfXNCBitfZT2OJQ==
X-Google-Smtp-Source: APBJJlGrDZMKzvXFY6r1M2JbPa+K0Ahc7dCi91emrnWB5ZMTMu8jshQtko/9FvONCrPVy//c6H7o/UbZarOtttfeU+4=
X-Received: by 2002:a81:4ecf:0:b0:56c:f32d:1753 with SMTP id
 c198-20020a814ecf000000b0056cf32d1753mr3761753ywb.44.1689305558011; Thu, 13
 Jul 2023 20:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-8-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-8-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:32:27 -0700
Message-ID: <CAJuCfpF9DjN1OqKer_aGRWAHCBtEfYVcyThYzu9CXbWXSB8ybQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] mm: Run the fault-around code under the VMA lock
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
> The map_pages fs method should be safe to run under the VMA lock instead
> of the mmap lock.  This should have a measurable reduction in contention
> on the mmap lock.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'll trust your claim that vmf->vma->vm_ops->map_pages() never rely on
mmap_lock. I think it makes sense but I did not check every case :)

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 709bffee8aa2..0a4e363b0605 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4547,11 +4547,6 @@ static vm_fault_t do_read_fault(struct vm_fault *v=
mf)
>         vm_fault_t ret =3D 0;
>         struct folio *folio;
>
> -       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> -               vma_end_read(vmf->vma);
> -               return VM_FAULT_RETRY;
> -       }
> -
>         /*
>          * Let's call ->map_pages() first and use ->fault() as fallback
>          * if page by the offset is not ready to be mapped (cold cache or
> @@ -4563,6 +4558,11 @@ static vm_fault_t do_read_fault(struct vm_fault *v=
mf)
>                         return ret;
>         }
>
> +       if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }
> +
>         ret =3D __do_fault(vmf);
>         if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_R=
ETRY)))
>                 return ret;
> --
> 2.39.2
>
