Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3E3ACBDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFRNRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRNRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:17:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A10C061574;
        Fri, 18 Jun 2021 06:15:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m2so7787501pgk.7;
        Fri, 18 Jun 2021 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Twuar8f1m162HtsR53xfdWJPeS8wU+HnCYEtzd/kDzU=;
        b=AKX0kcMMvFjzJmYNyo47EZQExEAJf+yPrIVuo6TGfBEcUwYl4fNhCriY/k20JIK0ad
         h9tdQ0t+SNXkvndqB8KI64u+94DRMjv3+DmrjILrGvaKNdiw9N1wmwyb8YrhJodqtaH7
         mKEnCulDiPU3f2v3ZNgp/TzXeufjS7GIxJaoD45IjO32u1k8OsALhfkFctz4UKD9Jjc3
         MS6yqoRcTIM9SXJf1V7ywu415d5WrsYTfiFhf0nOCBMuxioZ2OWrDOWhZkd366fAU13P
         RXOvAvY5PcADcKwlTzKH84P+hlsvLU9FZZFooubwn+z+kWJ6gKt8HE+lsUVKbTA9fceH
         cjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Twuar8f1m162HtsR53xfdWJPeS8wU+HnCYEtzd/kDzU=;
        b=JUw/GkKYVaehiY0JQ8J7cCDYemsnkkkrC/l8F0a4i7frxnrD1dK4e2CheFVdiE+tuX
         97zeB7QEvyPBzfwVsyvLaQLX5LgWOaq/tFuTaJFdFsP/bvJuKIUmbGvOWM7NR3CaIhoQ
         /1MxK78nTY1raIFAvE3z8LyfYx7WrEK47LTqBrAQSYDGy0BtlbOKqPihMfj6vrO/eRQc
         xe2oIquQ27N7BUuMmajVx4k1UP2Ur5Yb08XwC41/KVTAmQ344Lzi4IrJ6kppVN15SbMI
         x/wW8rK0ol4RExRSVsR+xuRC09Pdn9LwyBVIaXMoxYXFW5Nc6hxhbGUxIsqKNn2FRXuA
         9IDw==
X-Gm-Message-State: AOAM531oZhjP2V3c6P4zs8wTmAIGx7V1de7GpNnOKctMArflA8Er7maV
        JHa8Z/dzyLtjoNRuq96pnG0RiDBSJaJwnLMD/Nk=
X-Google-Smtp-Source: ABdhPJyQFLfjGWZTbirdbthO6x+tp600u8Q2ytxfqIv3ETREf+tc28SEiMP3sqX8pv6J4q82AxW8TQe8z6rK8Eq6frs=
X-Received: by 2002:a63:b00d:: with SMTP id h13mr10126532pgf.74.1624022127826;
 Fri, 18 Jun 2021 06:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <1624019875-611-1-git-send-email-faiyazm@codeaurora.org>
In-Reply-To: <1624019875-611-1-git-send-email-faiyazm@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Jun 2021 16:15:11 +0300
Message-ID: <CAHp75VePzuYwHxA4S8UiUKG1uSqpvnJhfajjJkQi1qS-BhHSdg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: slub: fix the leak of alloc/free traces debugfs interface
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 3:38 PM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>
> fix the leak of alloc/free traces debugfs interface, reported

Fix

> by kmemleak like below,
>
> unreferenced object 0xffff00091ae1b540 (size 64):
>   comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
>     6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
>   backtrace:
>     [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
>     [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
>     [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
>     slab_debugfs_start at mm/slub.c:5831
>     [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
>     [<ffff8000107b4b84>] seq_read+0x28c/0x418
>     [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
>     [<ffff800010738f24>] vfs_read+0x104/0x340
>     [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
>     [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
>     [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
>     [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
>     [<ffff800011138528>] el0_svc+0x20/0x30
>     [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
>     [<ffff80001001259c>] el0t_64_sync+0x178/0x17c

Can you shrink this a bit?

> Fixes: 84a2bdb1b458fc968d6d9e07dab388dc679bd747 ("mm: slub: move sysfs slab alloc/free interfaces to debugfs")

We use 12, which is shorter.

> Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/mm/slub.c?h=next-20210617&id=84a2bdb1b458fc968d6d9e07dab388dc679bd747

>

Must be no blank lines in the tag block.

> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

...

>  static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>  {
> -       loff_t *spos = v;
>         struct loc_track *t = seq->private;
>
> +       v = ppos;
>         if (*ppos < t->count) {
> -               *ppos = ++*spos;
> -               return spos;
> +               ++*ppos;
> +               return v;
>         }
> -       *ppos = ++*spos;
> +       ++*ppos;
>         return NULL;

Can it be

       v = ppos;
       ++*ppos;
       if (*ppos <= t->count)
              return v;
       return NULL;

?  (basically the question is, is the comparison equivalent in this case or not)

>  }

-- 
With Best Regards,
Andy Shevchenko
