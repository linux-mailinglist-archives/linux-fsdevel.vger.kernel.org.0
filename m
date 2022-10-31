Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C24613E6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJaTjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJaTjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:39:36 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE362E1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 12:39:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id j6so8960979qvn.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cI4L73xQe5xD5sZPWZ+eD7Nk5Id/MYSPSiVIsL0qYks=;
        b=kwIKrCX7vBco0pC6zZImgSGTn+heg0kI+VQhJ5E0tvI5FMQw9Oq2m2hPSZanAVjxIO
         qOGC/RT6aOkvCtvchn3F5zqfm9NSN6rdSSyvQYKsGl9iHsipHrbviRHtXI4vqLA3wfsr
         66YDgEzxTdWSAqtbPyRWvyFT3t3VyKHbOYW6FUbUjTZBu+YevmJA9Kh/+cnaz2+n5lZ7
         SfD3MgzvJj8g1APqe+Zr4UL0+/p9B2AJ9uZWuMajMCI+YNz6LUBPNZPMgUTFJTHV+DkR
         /blDkLjUG7PlZ1DDnXOtQGPrs+UAWXemmQp3PnEhBJK47t5iReDy3ISCwuFarB14DZo5
         WLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cI4L73xQe5xD5sZPWZ+eD7Nk5Id/MYSPSiVIsL0qYks=;
        b=ZWADKdm0e2o2Czdv+T1vm1coLBEeEKxrj+/Lp8kO2dxipUpcPPx9KwFmV31goZjv+x
         JRsty5s429JrPc89PLeMh8Z8ND+WOG0AxSKpYbxqVES1E5invgLxI21YSvcE1BCNfuDi
         AUJorPlGFcSFSljzWgimdfytGWaUZByNcqpBA0H2BrHyThZKsBwhAOdcKIfO077vAVfT
         +YYw1PoInXpT4Tp6XtceB/wIPVVCvtv2d5fq7WzYKJhnm7sjJDa9Lgy+DCDuKM2ry/Cr
         AvtdIvegNl234Mdac9XMgHB2/dytPEHXmGyY74kEDGblZXY1lEt9kPnFZH10KZkv2lnb
         c9Cg==
X-Gm-Message-State: ACrzQf0SMChw/JTACcvvA70/85ZNEwb38ED/yrnALp7astaF02blJoX8
        6ia6xCMpmyhJyEBYJxR/ptFAeQ==
X-Google-Smtp-Source: AMsMyM7y6baUsR2YtDWqWhD54Rq7SJoCmrpIfCC1tyLYfmQ9R0swRRBhuW2NtB7FvvmXXGikOpVOYQ==
X-Received: by 2002:a0c:979a:0:b0:4b7:4a8c:a80d with SMTP id l26-20020a0c979a000000b004b74a8ca80dmr12863775qvd.42.1667245174245;
        Mon, 31 Oct 2022 12:39:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h15-20020ac87d4f000000b0039cbbcc7da8sm3592512qtb.7.2022.10.31.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:39:33 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:39:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Pulavarty, Badari" <badari.pulavarty@intel.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "huangzhaoyang@gmail.com" <huangzhaoyang@gmail.com>,
        "ke.wang@unisoc.com" <ke.wang@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [RFC PATCH] mm: move xa forward when run across zombie page
In-Reply-To: <DM6PR11MB3978F27D63F743CDA577645D9C379@DM6PR11MB3978.namprd11.prod.outlook.com>
Message-ID: <751d242-20a2-3792-d39c-29531b40c37f@google.com>
References: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com> <Y1Md0hzhkqzik/WA@casper.infradead.org> <DM6PR11MB3978F27D63F743CDA577645D9C379@DM6PR11MB3978.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Oct 2022, Pulavarty, Badari wrote:

> Hi,
> 
> Just want to give an update on the issue, hoping to get more thoughts/suggestions.
> 
> I have been adding lot of debug to try to root cause the issue.
> When I enabled CONFIG_VM_DEBUG, I run into following assertion failure:
> 
> [ 1810.282055] entry: 0 folio: ffe6dfc30e428040 
> [ 1810.282059] page dumped because: VM_BUG_ON_PAGE(entry != folio)
> [ 1810.282062] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 1810.282084] #PF: supervisor read access in kernel mode
> [ 1810.282095] #PF: error_code(0x0000) - not-present page
> [ 1810.282104] PGD 0
> [ 1810.282110] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 1810.282119] CPU: 86 PID: 15043 Comm: kdamond.1 Kdump: loaded Tainted: G S          E      6.1.0-rc1+ #32
> [ 1810.282145] RIP: 0010:dump_page+0x25/0x340
> [ 1810.282156] Code: 0b cc cc cc cc 0f 1f 44 00 00 55 48 89 e5 41 57 49 89 ff 41 56 41 55 49 89 f5 41 54 53 48 83 ec 20 48 85 f6 0f 85 7d 72 ab 00 <49> 8b 07 48 83 f8 ff 0f 84 82 71 ab 00 49 8b 5f 08 f6 c3 01 0f 85
> [ 1810.282185] RSP: 0018:ff3fae02170637b8 EFLAGS: 00010046
> [ 1810.282193] RAX: 0000000000000033 RBX: ffe6dfc30e428040 RCX: 0000000000000002
> [ 1810.282204] RDX: 0000000000000000 RSI: ffffffffb85ad649 RDI: 00000000ffffffff
> [ 1810.282215] RBP: ff3fae0217063800 R08: 0000000000000000 R09: c0000000fffeffff
> [ 1810.282225] R10: 0000000000000001 R11: ff3fae0217063620 R12: 0000000000000001
> [ 1810.282234] R13: ffffffffb85c87e0 R14: 0000000000000000 R15: 0000000000000000
> [ 1810.282244] FS:  0000000000000000(0000) GS:ff25c2ea7e780000(0000) knlGS:0000000000000000
> [ 1810.282255] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1810.282264] CR2: 0000000000000000 CR3: 000000552f40a006 CR4: 0000000000771ee0
> [ 1810.282274] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1810.282284] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 1810.282293] PKRU: 55555554
> [ 1810.282299] Call Trace:
> [ 1810.282304]  <TASK>
> [ 1810.282310]  __delete_from_swap_cache.cold.20+0x33/0x35
> [ 1810.282321]  delete_from_swap_cache+0x50/0xa0
> [ 1810.282330]  folio_free_swap+0xab/0xe0
> [ 1810.282339]  free_swap_cache+0x8a/0xa0
> [ 1810.282346]  free_page_and_swap_cache+0x12/0xb0
> [ 1810.282356]  split_huge_page_to_list+0xf13/0x10d0     <<<<<<<<<<<<<<<<<<
> [ 1810.282365]  madvise_cold_or_pageout_pte_range+0x528/0x1390
> [ 1810.282374]  walk_pgd_range+0x5fe/0xa10
> [ 1810.282383]  __walk_page_range+0x184/0x190
> [ 1810.282391]  walk_page_range+0x120/0x190
> [ 1810.282398]  madvise_pageout+0x10b/0x2a0
> [ 1810.282406]  ? set_track_prepare+0x48/0x70
> [ 1810.282415]  madvise_vma_behavior+0x2f2/0xb10
> [ 1810.282422]  ? find_vma_prev+0x72/0xc0
> [ 1810.282431]  do_madvise+0x21b/0x440
> [ 1810.282439]  damon_va_apply_scheme+0x76/0xa0
> [ 1810.282448]  kdamond_fn+0xbe9/0xe10
> [ 1810.282456]  ? damon_split_region_at+0x70/0x70
> [ 1810.282675]  kthread+0xfc/0x130
> [ 1810.282837]  ? kthread_complete_and_exit+0x20/0x20
> 
> Since I am not using hugepages explicitly..  I recompiled the kernel with 
> 
> CONFIG_TRANSPARENT_HUGEPAGE=n
> 
> And my problem went away (including the original issue).

For that one, please try with 6.1-rc3 (and CONFIG_TRANSPARENT_HUGEPAGE
back to y).  Mel put a fix to that kind of thing into 6.1-rc2, then I 
fixed its warning in 6.1-rc3 (git log -n2 mm/huge_memory.c tells more).

Hugh
