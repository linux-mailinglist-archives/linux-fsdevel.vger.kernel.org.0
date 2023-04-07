Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375B06DB21C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDGRyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 13:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDGRyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:54:13 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E05597
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 10:54:12 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54c17fa9ae8so87514137b3.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680890052; x=1683482052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrpM89/D2Jn+yeowi/ZK21yY3Yfqiq0AvpzdxVqWoEM=;
        b=nlyl4ar9a4UnjXUJbWwyNT15heLTVsga62hvSGc21eVb9UWoJwENRKkCHxa5FPQFr9
         gV7S7wullm2HeT+4AnshpPvxPoc/bNK/lK5bxw46U43/wq8KTCAnbWtb7nYMzxxq+js4
         gx9NNQ0o1nOvjfjqnRtpyeOHYZEyeZY/lF05JYz9AH77KPg1uvmSWOFtB3qzl8QQFq47
         bkJGzSNqCUpT8YN+koW5g5N2kmWIE+HBHTgYdM4i+KlqZZmyuI2GFondvb232fl7KZcA
         lNPtUD76pkAQ0gaFS5pqXOo4GPKrRbHy9B5f8zhLtwJDUdFxoCT2eSYxdEJz9vdTlMDa
         hU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890052; x=1683482052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrpM89/D2Jn+yeowi/ZK21yY3Yfqiq0AvpzdxVqWoEM=;
        b=cUPUw8QoQJcqHbbQL4zlErY6Cj8LAdneM+2ikeeWWtRHmCjRj7WlIX8CD07oktdDwN
         ODUthOfvKmsTovNgjvfjRPgp6gLV0yu38rE2iY2nIliFqT+POCYa+jlrIqvfF2+A+E9c
         yWdPjmoXXWqoVBile2o2T233RyvLWS/fU7lQPwx5F+nQaGgBpH3RGb+YqDvAFpEFO+FY
         +4C6Q0cbqV2Q/eyxnzawCMwNgvVod6kjWZmCsweH4fdIBMQaId/ktnCw3uJXfQNqQNbt
         us6y4fFWysec//s+HM7XYZ4ist7Ug0vtVQPX38LoYSaETLJLs40AZsDC6hXxRTMPK8dj
         FaYA==
X-Gm-Message-State: AAQBX9dhwVMmIYOE29AEkaNAA1LwFKtqkA/w7UM0wAocceSCqAgAN2ys
        zUrWFesGpuHZktucViGp2GlwlJG+uGy+ZbC9N5cHbw==
X-Google-Smtp-Source: AKy350ZWpvYDt+JfeFh+Py8WeV6sDraw/et/qng2n8kcHk5mR5OCQ9G6DpPScjEmkGgZVMaXtvyqeGRFv8+flPdxkmY=
X-Received: by 2002:a81:ad0b:0:b0:54c:2723:55ff with SMTP id
 l11-20020a81ad0b000000b0054c272355ffmr1456279ywh.1.1680890051783; Fri, 07 Apr
 2023 10:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230404135850.3673404-1-willy@infradead.org> <20230404135850.3673404-2-willy@infradead.org>
In-Reply-To: <20230404135850.3673404-2-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Apr 2023 10:54:00 -0700
Message-ID: <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Allow per-VMA locks on file-backed VMAs
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 4, 2023 at 6:59=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> The fault path will immediately fail in handle_mm_fault(), so this
> is the minimal step which allows the per-VMA lock to be taken on
> file-backed VMAs.  There may be a small performance reduction as a
> little unnecessary work will be done on each page fault.  See later
> patches for the improvement.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memory.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index fdaec7772fff..f726f85f0081 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5223,6 +5223,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *v=
ma, unsigned long address,
>                                             flags & FAULT_FLAG_REMOTE))
>                 return VM_FAULT_SIGSEGV;
>
> +       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
> +               return VM_FAULT_RETRY;
> +

There are count_vm_event(PGFAULT) and count_memcg_event_mm(vma->vm_mm,
PGFAULT) earlier in this function. Returning here and retrying I think
will double-count this page fault. Returning before this accounting
should fix this issue.

>         /*
>          * Enable the memcg OOM handling for faults triggered in user
>          * space.  Kernel faults are handled more gracefully.
> @@ -5275,12 +5278,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
>         if (!vma)
>                 goto inval;
>
> -       /* Only anonymous vmas are supported for now */
> -       if (!vma_is_anonymous(vma))
> -               goto inval;
> -
>         /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> -       if (!vma->anon_vma)
> +       if (vma_is_anonymous(vma) && !vma->anon_vma)
>                 goto inval;
>
>         if (!vma_start_read(vma))
> --
> 2.39.2
>
