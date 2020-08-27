Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD0254CB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH0SPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0SPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:15:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B20AC061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 11:15:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so7469764ljn.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ln4YDv+McQTrVSBLkYMyzgo5ffLr7W4nh7mUMFYOZo=;
        b=GjsK/u6ib7N+ctD2EUfS3Yg2gOjkfLasSaGCU/YbFFT4pm7wC/mAUjkvSP+UBZidUg
         P75Y7Q+9vqNQMjHTBy6Jwr30jghzFLvVdhlC7Nn9Ui5WCs2KOmFbugeMsgtI/Xw61N8K
         QeupHGovYgcCrHWAn29zkzD17dqNMKZTBIjAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ln4YDv+McQTrVSBLkYMyzgo5ffLr7W4nh7mUMFYOZo=;
        b=QzilrRIlA9aT7pY3vi/bMh+8NuJXXdnUcYn0bKJvVWc2t6DUXM+T6/DoDnatjO8tZt
         isH8vmm2AgNyLdoaayKXh9VVvrvj2Dl7nPMV1V+/qSwCPGhOhU7H9GgOAz4CusM0Uu6Z
         A8J/rda7awC8m13EDy4i9tFvWaA0JULrIR1GSXhSqkqnPdaUpTsk6Y7ZxNLO8ml4fDjh
         8x3TW+Z83BpsywnapUNRPV/c1CjAaFhrzoO0tclyah49rljx0bd9/c1Hf8VwCh+7TkCB
         ehP96BYYdly/d9qSALXN+vXM278g2Gr0/3bN2bigjOAyRR1mKb7aZMA7E5OzEURVJlph
         eGmg==
X-Gm-Message-State: AOAM5311np0lXkuMiqVQlYV0dPtz5KsJbyqPrSoB0cMQebPcVCKv3kf7
        9GiCgqMvvysjS1FxCtvipJDaLNQ8fiVgng==
X-Google-Smtp-Source: ABdhPJzWYU3j9gpT4NmJ8MHSa291FypzK+Pi8+2seoUEMsTdNV5SqzuX4Vnl8n47V54pqwrKknUL9A==
X-Received: by 2002:a2e:9854:: with SMTP id e20mr9629165ljj.318.1598552130643;
        Thu, 27 Aug 2020 11:15:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n24sm682874lfe.38.2020.08.27.11.15.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 185so7482449ljj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr9604351ljh.70.1598552128279;
 Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-9-hch@lst.de>
In-Reply-To: <20200827150030.282762-9-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:15:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
Message-ID: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
Subject: Re: [PATCH 08/10] x86: remove address space overrides using set_fs()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
>  SYM_FUNC_START(__get_user_2)
>         add $1,%_ASM_AX
>         jc bad_get_user

This no longer makes sense, and

> -       mov PER_CPU_VAR(current_task), %_ASM_DX
> -       cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
> +       LOAD_TASK_SIZE_MAX
> +       cmp %_ASM_DX,%_ASM_AX

This should be

        LOAD_TASK_SIZE_MAX_MINUS_N(1)
        cmp %_ASM_DX,%_ASM_AX

instead (and then because we no longer modify _ASM_AX, we'd also
remove the offset on the access).

>  SYM_FUNC_START(__put_user_2)
> -       ENTER
> -       mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
> +       LOAD_TASK_SIZE_MAX
>         sub $1,%_ASM_BX

It's even more obvious here. We load a constant and then immediately
do a "sub $1" on that value.

It's not a huge deal, you don't have to respin the series for this, I
just wanted to point it out so that people are aware of it and if I
forget somebody else will hopefully remember that "we should fix that
too".

                   Linus
