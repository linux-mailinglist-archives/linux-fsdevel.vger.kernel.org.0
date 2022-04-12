Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8C4FDDD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351216AbiDLLZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351255AbiDLLZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:25:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6DA2B25A;
        Tue, 12 Apr 2022 03:07:51 -0700 (PDT)
Received: from zn.tnic (p200300ea97156149329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6149:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9608C1EC04EC;
        Tue, 12 Apr 2022 12:07:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649758065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o3lXO1BKF/S5AzldA58rjm6HBnn56CuwTB6uiL2Y1Ag=;
        b=MnAIT7Er8JwAM4b0GD9rgLkDQyjcarmya9EyILrxMvNLKZ0HrhcSex/LUG4qj5DimKo4xp
        FUSPF+Ow9Iqn/lR66hENQLYudzalsAfqsYDdVNCEP3UQRqaJ97IASCFGZJ0A5WCoQftN+r
        A6Lci8BJ2YNNbYwSUe5vjOAJqh086DM=
Date:   Tue, 12 Apr 2022 12:07:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v7 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Message-ID: <YlVPcrK4SSXyPx+Y@zn.tnic>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-4-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405194747.2386619-4-jane.chu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:47:44PM -0600, Jane Chu wrote:
> The set_memory_uc() approach doesn't work well in all cases.
> For example, when "The VMM unmapped the bad page from guest
> physical space and passed the machine check to the guest."
> "The guest gets virtual #MC on an access to that page.
>  When the guest tries to do set_memory_uc() and instructs
>  cpa_flush() to do clean caches that results in taking another
>  fault / exception perhaps because the VMM unmapped the page
>  from the guest."

I presume this is quoting someone...

> Since the driver has special knowledge to handle NP or UC,
> let's mark the poisoned page with NP and let driver handle it

s/let's mark/mark/

> when it comes down to repair.
> 
> Please refer to discussions here for more details.
> https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/
> 
> Now since poisoned page is marked as not-present, in order to
> avoid writing to a 'np' page and trigger kernel Oops, also fix

You can write it out: "non-present page..."

> pmem_do_write().
> 
> Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  6 +++---
>  arch/x86/mm/pat/set_memory.c   | 18 ++++++------------
>  drivers/nvdimm/pmem.c          | 31 +++++++------------------------
>  include/linux/set_memory.h     |  4 ++--
>  4 files changed, 18 insertions(+), 41 deletions(-)

For such mixed subsystem patches we probably should talk about who picks
them up, eventually...

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 981496e6bc0e..fa67bb9d1afe 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -579,7 +579,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
>  
>  	pfn = mce->addr >> PAGE_SHIFT;
>  	if (!memory_failure(pfn, 0)) {
> -		set_mce_nospec(pfn, whole_page(mce));
> +		set_mce_nospec(pfn);
>  		mce->kflags |= MCE_HANDLED_UC;
>  	}
>  
> @@ -1316,7 +1316,7 @@ static void kill_me_maybe(struct callback_head *cb)
>  
>  	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
>  	if (!ret) {
> -		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> +		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
>  		sync_core();
>  		return;
>  	}
> @@ -1342,7 +1342,7 @@ static void kill_me_never(struct callback_head *cb)
>  	p->mce_count = 0;
>  	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
>  	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
> -		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> +		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
>  }

Both that ->mce_whole_page and whole_page() look unused after this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
