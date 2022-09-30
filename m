Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11045F0FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiI3QPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiI3QPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:15:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5483341A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 09:14:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s10so5301242ljp.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GtlSJkLXw2SNcPVROAD1SJDnwutfnbZAayHj4onnywk=;
        b=DOMyGYFKf+TZsvY4xp2ON3TIpgoHPlU49dDhE2e+lblBc8uIrSThwS/2igACfNwrxT
         B80A327TY7zTQhfHZWcTomLg9RP5BFCafC1G5Xq0tQ7fwoJvvStDoxT0G2gxcG663JP2
         Fs7G3g4B/VZpF4ch3hxit7Ug+GQ+GOdS/DQOAl43rZESxPq8F6OkxZ3VQDuWTfhZaVv4
         SIQHFtGYvuP6RLRGuDR8p9bpU8nbzmLRHnOHWxhEywjmhLPHJS0aPcx7Quodth6mnW/e
         VlopEFYGcfN96ScGyCOubqRcKtcTue5tCsqbI81iqfPNUwyTk6FXx34dym02k3Ilq/RK
         sZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GtlSJkLXw2SNcPVROAD1SJDnwutfnbZAayHj4onnywk=;
        b=5elQ94HQnOMloT+yHDDsrvia5PZi3gG07ZvLhRGoQj++N4/hFqzUafwurYp8PoOybJ
         5ieUNg37AWiiv7/CzTX9BXVJ7OoZxGh/UdIHa9iWgIk0b0djI+TA4muCXXevWSIB22fs
         q/j8iELJeEV5ECn4h+ocT77tPQRXRxcdkcfhfMIOBvuA3+XI2Q9Amtj5mFCkOrOnoThD
         /mzP8jRKlw5yYCh8C1wu4yOq55kf/SQyz5/1qUrQ4TyLHAJWwLHRT7u8Ag7+ov/5wHXk
         FpEPY7LSClQhTLU+TreI12fMjTb95E0gageHNAybUp1uU0moNCtSD6uggMNIR5XmGP/F
         AQ9g==
X-Gm-Message-State: ACrzQf1RzCtRniQNxgfeCicfblNxYuTPI1DyKDZ4FnNuP4DYQR2yv7Y0
        HMmxCPUc9WasdTGqV6iUL3CG7dGIwRvXJBKa/0r8SA==
X-Google-Smtp-Source: AMsMyM7jpq+XBzS300JrKAbZeYDxFloAXMmPfSxwUISYLv3b6zRl+QtVRiHq6i7/nDDb8l/3nFMe7wpgyR1WcsBFjoI=
X-Received: by 2002:a05:651c:1508:b0:26c:622e:abe1 with SMTP id
 e8-20020a05651c150800b0026c622eabe1mr3044232ljf.228.1664554497777; Fri, 30
 Sep 2022 09:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com> <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
In-Reply-To: <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 30 Sep 2022 17:14:00 +0100
Message-ID: <CA+EHjTyrexb_LX7Jm9-MGwm4DBvfjCrADH4oumFyAvs2_0oSYw@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

<...>

> diff --git a/mm/memfd_inaccessible.c b/mm/memfd_inaccessible.c
> new file mode 100644
> index 000000000000..2d33cbdd9282
> --- /dev/null
> +++ b/mm/memfd_inaccessible.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/sbitmap.h"
> +#include <linux/memfd.h>
> +#include <linux/pagemap.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/shmem_fs.h>
> +#include <uapi/linux/falloc.h>
> +#include <uapi/linux/magic.h>
> +
> +struct inaccessible_data {
> +       struct mutex lock;
> +       struct file *memfd;
> +       struct list_head notifiers;
> +};
> +
> +static void inaccessible_notifier_invalidate(struct inaccessible_data *data,
> +                                pgoff_t start, pgoff_t end)
> +{
> +       struct inaccessible_notifier *notifier;
> +
> +       mutex_lock(&data->lock);
> +       list_for_each_entry(notifier, &data->notifiers, list) {
> +               notifier->ops->invalidate(notifier, start, end);
> +       }
> +       mutex_unlock(&data->lock);
> +}
> +
> +static int inaccessible_release(struct inode *inode, struct file *file)
> +{
> +       struct inaccessible_data *data = inode->i_mapping->private_data;
> +
> +       fput(data->memfd);
> +       kfree(data);
> +       return 0;
> +}
> +
> +static long inaccessible_fallocate(struct file *file, int mode,
> +                                  loff_t offset, loff_t len)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +       struct file *memfd = data->memfd;
> +       int ret;
> +
> +       if (mode & FALLOC_FL_PUNCH_HOLE) {
> +               if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> +                       return -EINVAL;
> +       }
> +
> +       ret = memfd->f_op->fallocate(memfd, mode, offset, len);

I think that shmem_file_operations.fallocate is only set if
CONFIG_TMPFS is enabled (shmem.c). Should there be a check at
initialization that fallocate is set, or maybe a config dependency, or
can we count on it always being enabled?

> +       inaccessible_notifier_invalidate(data, offset, offset + len);
> +       return ret;
> +}
> +

<...>

> +void inaccessible_register_notifier(struct file *file,
> +                                   struct inaccessible_notifier *notifier)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +
> +       mutex_lock(&data->lock);
> +       list_add(&notifier->list, &data->notifiers);
> +       mutex_unlock(&data->lock);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_register_notifier);

If the memfd wasn't marked as inaccessible, or more generally
speaking, if the file isn't a memfd_inaccessible file, this ends up
accessing an uninitialized pointer for the notifier list. Should there
be a check for that here, and have this function return an error if
that's not the case?

Thanks,
/fuad



> +
> +void inaccessible_unregister_notifier(struct file *file,
> +                                     struct inaccessible_notifier *notifier)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +
> +       mutex_lock(&data->lock);
> +       list_del(&notifier->list);
> +       mutex_unlock(&data->lock);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_unregister_notifier);
> +
> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +                        int *order)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +       struct file *memfd = data->memfd;
> +       struct page *page;
> +       int ret;
> +
> +       ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> +       if (ret)
> +               return ret;
> +
> +       *pfn = page_to_pfn_t(page);
> +       *order = thp_order(compound_head(page));
> +       SetPageUptodate(page);
> +       unlock_page(page);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
> +
> +void inaccessible_put_pfn(struct file *file, pfn_t pfn)
> +{
> +       struct page *page = pfn_t_to_page(pfn);
> +
> +       if (WARN_ON_ONCE(!page))
> +               return;
> +
> +       put_page(page);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_put_pfn);
> --
> 2.25.1
>
