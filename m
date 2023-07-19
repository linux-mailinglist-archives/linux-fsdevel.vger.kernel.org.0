Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6077590F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGSJDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGSJCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:02:36 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D1199A;
        Wed, 19 Jul 2023 02:02:34 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-440db8e60c8so2231471137.0;
        Wed, 19 Jul 2023 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689757354; x=1692349354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxIwZYUXAuriCTTrhHVqHKddrsis7m+qCsP3HgdIynU=;
        b=roMthWZenYjFJbkbM2mH9bPO4Bf42B0BRdA0sdFpwN48PKQ9gk4TZacDsuyYpWMUtU
         l7XYUiMzUMAy/phDMUaatUjESkkXKZSAnkJ4YsFYi4LHKq1cuYFBne+6nU2905/UPcSF
         eiRoC/YPnk4Xfg/OHZHNVe0aaySC7Dum98v/RDAWN8si4j+7KTylat/B7KzsdUU52gR0
         ATZdikwexy+mWOAK83xK6JMDtH6htGdJ9v/DCaLbaPTlmTZwkNX8scIlclg0p8FahA0R
         h6FoIIVMuIN5v6FVCN4uWBK72xyHC8S/m8tYhlYULPyoo8BMP5rmm5j7YoomYtBCUVRH
         okmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757354; x=1692349354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxIwZYUXAuriCTTrhHVqHKddrsis7m+qCsP3HgdIynU=;
        b=UtqZLJs/9dNaJ/ouji4lSjg9lWOiRDJHu6EFsAXZ0tegyRGQt9bj36VF6Lw6h0jEr4
         5oUryOvEL0rWpk8i4qBLToJCdQSl83cr2UTEZAc2yWEyC9pIwj4DDSFNKfRCTi0G/4VC
         XwxwEoX1EOCu3JbshtdtGc6m7Aj4KQqS3iGrUIgxGNSalgstJpwNuYEn8jm9+KIM0Yba
         4GwWP3FePJO4zqUxeWWkI8kQ9EFipr4Wg5b+stI1Emg8E/ZhabU9UY6dltY9w8eujctv
         1Jpx7/cJ4KRFwPKdlLYu0ep1Ahgrxk33hqVN6RzUUqqUS5moIkDMVfLuvf3za3B5RDeK
         P0Ew==
X-Gm-Message-State: ABy/qLZIxgKwJcpcJIPqFQB7N/0KFEvtmbZOH1CoTqoQMaVsnE6BMwYv
        J5T09xHseVKGMhrc4hYuKllbS8PKsOhX/T+AjJE=
X-Google-Smtp-Source: APBJJlFGC7hcxDjV2bvRpf7CwCMnWqPqtKrErYoLtJJRVn7WV3aGJI76Q4oBgWPzIE71Uc7VS02UNu6Z+sX11RmvnXE=
X-Received: by 2002:a67:ce82:0:b0:443:6e00:d32 with SMTP id
 c2-20020a67ce82000000b004436e000d32mr8825653vse.8.1689757353731; Wed, 19 Jul
 2023 02:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com> <20230719075127.47736-4-wangkefeng.wang@huawei.com>
In-Reply-To: <20230719075127.47736-4-wangkefeng.wang@huawei.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 19 Jul 2023 11:02:22 +0200
Message-ID: <CAJ2a_DfGvPeDuN38UBXD4f2928n9GZpHFgdiPo9MoSAY7YXeOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Jul 2023 at 09:40, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Use the helpers to simplify code.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  security/selinux/hooks.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..ee8575540a8e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>         if (default_noexec &&
>             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>                 int rc = 0;
> -               if (vma->vm_start >= vma->vm_mm->start_brk &&
> -                   vma->vm_end <= vma->vm_mm->brk) {
> +               if (vma_is_initial_heap(vma)) {

This seems to change the condition from

    vma->vm_start >= vma->vm_mm->start_brk && vma->vm_end <= vma->vm_mm->brk

to

    vma->vm_start <= vma->vm_mm->brk && vma->vm_end >= vma->vm_mm->start_brk

(or AND arguments swapped)

    vma->vm_end >= vma->vm_mm->start_brk && vma->vm_start <= vma->vm_mm->brk

Is this intended?

>                         rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECHEAP, NULL);
> -               } else if (!vma->vm_file &&
> -                          ((vma->vm_start <= vma->vm_mm->start_stack &&
> -                            vma->vm_end >= vma->vm_mm->start_stack) ||
> +               } else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
>                             vma_is_stack_for_current(vma))) {
>                         rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECSTACK, NULL);
> --
> 2.27.0
>
