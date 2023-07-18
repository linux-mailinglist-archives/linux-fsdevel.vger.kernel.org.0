Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554275807A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjGRPK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGRPK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:10:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB66171A;
        Tue, 18 Jul 2023 08:10:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a3efee1d44so4313944b6e.3;
        Tue, 18 Jul 2023 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689693026; x=1692285026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNQ6/gc5vfGP1wHAlH0r+RXd8q2VGkAv8eOnlipw9dY=;
        b=CV3ZKEqZWXlKDj1uZ5AVabNJrLd2Eg+AK05DTeuCA+f5zQEMBxYFca0FBmwFTkHcK7
         3MlmM5lZTYfktW0UF6SbvxyLoTf1TuBv6ZgILXcv8VOuLPDPduWcM5h/tDvlr0ypg5/q
         smpype/Nr37YgegIwLWzCYWecOynGyznMId0h5Yu07QY99zOYbeNAPhOMiBJCFwdHIg1
         os2djPgcqhMTtJsBcOr448wqDatFIAol+X13i+uIjse3EoWbTEh8eawvWBB+t+x4nBHX
         AwOdbRVZlXT+Nd0dKShzXbdAGtZ+nCvMDk4XVNYGLQfeaKo9QT1PyMpwDQCP/QPpHn7V
         zClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693026; x=1692285026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNQ6/gc5vfGP1wHAlH0r+RXd8q2VGkAv8eOnlipw9dY=;
        b=LRA0oZN4mUBW4jmsOjoQ2EWbta78mTwljgAYIai1i8OEqEOAEcej0/jugixJtQnbJh
         P+6ZhYRp3LdX7pcnFhgA+hFRz3Kdo/APSJV+0WNFofoQCfdf4ngsC3XTBLKVOBCM36lz
         8ujR2MX2n4SrtplsBlPKkNpMPgZZF8DVSgRWiDdWpKk479KXg0UOXyiZ/r7e57NzkS0R
         kTrGFm5b2UH7uJSFMj6jyucrTQ4vFH/HqF1ZdChzzLcIV3Yn0bsBFn9Ns4iRG+CGOlf1
         E1yJb4S3trM7GXXGHAFSFEq8tfmejaOzxUH/QxnlSpj1M2o4ezRMxsMePL+pyBlB4dzk
         9Jjw==
X-Gm-Message-State: ABy/qLb0JpLIuAhc47AZr08INcMG88PRUX+b51N3aTeoKz8mPAuBFxiC
        ews8AYOnQ6swl2gsDjFLYBQTu4xWaKdujOAs13tenJbNcBEzWA==
X-Google-Smtp-Source: APBJJlHDVXGokvOwlHVsvWNoqkFMjjyNFTxOWLqeqnl954tIVvHpuyY0R8psa6PK/CXU+eZaGshpae8nJo4WqnvYlBA=
X-Received: by 2002:a05:6358:7f0d:b0:134:c37f:4b60 with SMTP id
 p13-20020a0563587f0d00b00134c37f4b60mr11494410rwn.32.1689693025766; Tue, 18
 Jul 2023 08:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com> <20230712143831.120701-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20230712143831.120701-2-wangkefeng.wang@huawei.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 18 Jul 2023 17:10:14 +0200
Message-ID: <CAJ2a_Dd+CUggq0gtaeuPSP+iCrqUH08cCwU95AYGXxv5TBWSuA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: introduce vma_is_stack() and vma_is_heap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
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

On Wed, 12 Jul 2023 at 16:25, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Introduce the two helpers for general use.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/mm.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1462cf15badf..0bbeb31ac750 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -926,6 +926,18 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
>         return !vma->vm_ops;
>  }
>
> +static inline bool vma_is_heap(struct vm_area_struct *vma)

What about declaring the parameters const to document in code these
functions do not modify any state, and allow callers to pass pointers
to const?

> +{
> +       return vma->vm_start <= vma->vm_mm->brk &&
> +               vma->vm_end >= vma->vm_mm->start_brk;
> +}
> +
> +static inline bool vma_is_stack(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->start_stack &&
> +              vma->vm_end >= vma->vm_mm->start_stack;
> +}
> +
>  static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>  {
>         int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
> --
> 2.41.0
>
