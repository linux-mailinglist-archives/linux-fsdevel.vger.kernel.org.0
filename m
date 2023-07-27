Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C377654B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjG0NQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjG0NQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59922726
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690463740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkGX/h7m3QPOunZGgc4OMZF0dALyUJfLw/fdSlyp7rI=;
        b=gjTNQCbk03Wh9hmiGZhYulmo2ZrjfxhzFKrOnLvweNXn1XDkm2QEnQvfsf1FLe6ul301Hd
        H9CQI4Sqct+7xVLnDVVUd1VBA/oYACusr4NcR4WooLz0YfC/lZwx9FcJWVRKb8L4k1qhvS
        Rh7n5kmefkcfXGjT575lr61ioY42oXw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-zVk4JXRCMv23UzoKhyRJxQ-1; Thu, 27 Jul 2023 09:15:39 -0400
X-MC-Unique: zVk4JXRCMv23UzoKhyRJxQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767edbf73cbso20940885a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 06:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463739; x=1691068539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkGX/h7m3QPOunZGgc4OMZF0dALyUJfLw/fdSlyp7rI=;
        b=afAn8FjSsQJijhMGO05K9gLPxweaUyxxqGvUpM9RRbZ1Efh1YAoYUvrMXfi360hzG9
         TQDSR9uzN72DDy83KqWwich8BaowVAQHLxchB7L0C8Pmgcc62LN2XCWAQhxLhnMxB3SJ
         UqtQn0fYthiedEaHlRFAdQapwuPGWlFPgwVz7smDUxZ/kR5Y2EyPS2xKjCeJzQtsxvsD
         yI3JZcv+HmVOfB5pbRFTk7EPUDKGcma5qgQ+XIxh6F9zyyWrlNHbsicCqh+OWZPWwrRQ
         SHXR/5NSwS7KoTHy7sH/ozkbOCCf9T0HmBJKKrWQnoDHU9ANe39RcBdzm0cIWC4Gt4Xy
         8TmA==
X-Gm-Message-State: ABy/qLbxOMF3WoKujpfsT+Ap8wgQPt6cflYGtXlJGkk94n4t2OoQUQYz
        YwT+lDbL1LGBemV1QbhrZXnUSvNQ898tZYfBH4Ht4iSxDyhoGy1gi7JkbD9ybU7o+LTdqu4roV4
        JcRBaFx/sFa+FJRwb6sp0j78ioA==
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id bi15-20020a05620a318f00b00765a957f526mr5491560qkb.3.1690463739080;
        Thu, 27 Jul 2023 06:15:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1DyY2M8hXAuCoIVwrMg350ou4HtJv049anJhsIv3IyMg4HxHTjRWByBzy/LHrzDeVZAZxLw==
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id bi15-20020a05620a318f00b00765a957f526mr5491539qkb.3.1690463738744;
        Thu, 27 Jul 2023 06:15:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z5-20020a05620a100500b00767cf5d3faasm396971qkj.86.2023.07.27.06.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:15:38 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:15:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
Message-ID: <ZMJt+VWzIG4GAjeb@x1n>
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:37:06PM +0200, David Hildenbrand wrote:
> On Wed, Jul 26, 2023 at 9:40 AM liubo <liubo254@huawei.com> wrote:
> >
> > In commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
> > gup_can_follow_protnone()"), FOLL_NUMA was removed and replaced by
> > the gup_can_follow_protnone interface.
> >
> > However, for the case where the user-mode process uses transparent
> > huge pages, when analyzing the memory usage through
> > /proc/pid/smaps_rollup, the obtained memory usage is not consistent
> > with the RSS in /proc/pid/status.
> >
> > Related examples are as follows:
> > cat /proc/15427/status
> > VmRSS:  20973024 kB
> > RssAnon:        20971616 kB
> > RssFile:            1408 kB
> > RssShmem:              0 kB
> >
> > cat /proc/15427/smaps_rollup
> > 00400000-7ffcc372d000 ---p 00000000 00:00 0 [rollup]
> > Rss:            14419432 kB
> > Pss:            14418079 kB
> > Pss_Dirty:      14418016 kB
> > Pss_Anon:       14418016 kB
> > Pss_File:             63 kB
> > Pss_Shmem:             0 kB
> > Anonymous:      14418016 kB
> > LazyFree:              0 kB
> > AnonHugePages:  14417920 kB
> >
> > The root cause is that the traversal In the page table, the number of
> > pages obtained by smaps_pmd_entry does not include the pages
> > corresponding to PROTNONE,resulting in a different situation.
> >
> 
> Thanks for reporting and debugging!
> 
> > Therefore, when obtaining pages through the follow_trans_huge_pmd
> > interface, add the FOLL_FORCE flag to count the pages corresponding to
> > PROTNONE to solve the above problem.
> >
> 
> We really want to avoid the usage of FOLL_FORCE, and ideally limit it
> to ptrace only.

Fundamentally when removing FOLL_NUMA we did already assumed !FORCE is
FOLL_NUMA.  It means to me after the removal it's not possible to say in a
gup walker that "it's not FORCEd, but I don't want to trigger NUMA but just
get the page".

Is that what we want?  Shall we document that in FOLL_FORCE if we intended
to enforce numa balancing as long as !FORCE?

> 
> > Signed-off-by: liubo <liubo254@huawei.com>
> > Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
> > ---
> >  fs/proc/task_mmu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index c1e6531cb02a..ed08f9b869e2 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -571,8 +571,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> >         bool migration = false;
> >
> >         if (pmd_present(*pmd)) {
> > -               /* FOLL_DUMP will return -EFAULT on huge zero page */
> > -               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> > +               /* FOLL_DUMP will return -EFAULT on huge zero page
> > +                * FOLL_FORCE follow a PROT_NONE mapped page
> > +                */
> > +               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP | FOLL_FORCE);
> >         } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> >                 swp_entry_t entry = pmd_to_swp_entry(*pmd);
> 
> Might do as an easy fix. But we really should get rid of that
> absolutely disgusting usage of follow_trans_huge_pmd().
> 
> We don't need 99% of what follow_trans_huge_pmd() does here.
> 
> Would the following also fix your issue?
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 507cd4e59d07..fc744964816e 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -587,8 +587,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>         bool migration = false;
> 
>         if (pmd_present(*pmd)) {
> -               /* FOLL_DUMP will return -EFAULT on huge zero page */
> -               page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +               page = vm_normal_page_pmd(vma, addr, *pmd);
>         } else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
>                 swp_entry_t entry = pmd_to_swp_entry(*pmd);
> 
> It also skips the shared zeropage and pmd_devmap(),
> 
> Otherwise, a simple pmd_page(*pmd) + is_huge_zero_pmd(*pmd) check will do, but I
> suspect vm_normal_page_pmd() might be what we actually want to have here.
> 
> Because smaps_pte_entry() properly checks for vm_normal_page().

There're indeed some very trivial detail in vm_normal_page_pmd() that's
different, but maybe not so relevant.  E.g.,

	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
		return -ENOMEM;

	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
		return -EREMOTEIO;

I'm not sure whether the p2pdma page would matter in any form here.  E.g.,
whether it can be mapped privately.

-- 
Peter Xu

