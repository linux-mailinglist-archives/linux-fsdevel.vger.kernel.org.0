Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB256ACB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiGGU2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiGGU2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:28:20 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735762A94D
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 13:28:19 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v2so2671789ilo.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnPdki3U1HzYs0CImjis2nyJH9ZY1bhBPOIDGHPVDrw=;
        b=f/+n6NnnOyy+rz5DYYmTw3B1MCd7fk1PKnsKmvCKhWZP/bR9y/KKqqJ8Hr9inQZVf9
         eG6YeqBRj95B8m2MJjUWSusb2rDPoyiYVSw1hGcy8U6Gn18T0rQa0LWDy71kyXfqX9Ig
         dk3MJJHrEqf11QvXorsaV5z4I4iKUayii5z9k7cJCx9s5PeJB0eeKFejQWwZGgo+irbt
         vSv3tVDn/7R0Qiu/rmi14L0Ij/G5v1pmCd3qLg8dyC1jXRel+CbF750in+IL5G+NR2oL
         q1XcKnOTm5YPZfOyX2Y7WXezKSs8AFyk8sfQi/ZCNsxAED5oyGlpTwiGoBIF52u3U90X
         NQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnPdki3U1HzYs0CImjis2nyJH9ZY1bhBPOIDGHPVDrw=;
        b=MNNiyroLWFOs1zlVA6hgYOOIISrDUjCGkvLL/j4xV9CF+a6KTgkeinZDr5M0DPwQx9
         LJCvZbzGFF2P3eSoBlKHBGCuCe7PXVsbczViqn7ZuAJB0F2oPvi56aGnGFC3o0LnScJf
         btu51Ygety2B70XoulVt92BwPvdvaBubh3w7YR1hOze2a5wC89Cj1KF3rOIB7sGTCI4e
         PU/1W5uZsWk7zxKrBeTIzypRbpCe+uq5dNOJPX417GSba4P+IPlVC1vaAn1d/3W5MsV2
         kTSYRYmo+1iK+caHFnITjnq6eYivic20oaDpRotSGesuwlf6pHwRPglgnyg0NRc5Xdbk
         zShw==
X-Gm-Message-State: AJIora/tu9QqSCOPFrIFrCNRLyWMUB1kzSpn8GsIUtfuPUBRF6EqwcI3
        y6UWIEZCcrvK955vhRZof8Kck5vNgbFeLFvCdi7L+Q==
X-Google-Smtp-Source: AGRyM1tM/KnkuQVig9sLggudWlxS0l+TZ6ubWAAz8YA3uJntlv3Ha8v/eItGrj3jm2fMpqn8xenn2fg11jZjfISsrbQ=
X-Received: by 2002:a92:a801:0:b0:2da:b79f:777 with SMTP id
 o1-20020a92a801000000b002dab79f0777mr28719684ilh.275.1657225698668; Thu, 07
 Jul 2022 13:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220707165650.248088-1-rppt@kernel.org>
In-Reply-To: <20220707165650.248088-1-rppt@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 7 Jul 2022 13:27:42 -0700
Message-ID: <CAJHvVcjH_MZq083ot3x2p=n-rQhiEjfzW82cnruBG9a4cozrpg@mail.gmail.com>
Subject: Re: [PATCH v2] secretmem: fix unhandled fault in truncate
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Looks correct to me - at least, I'm confident it will prevent the
race. I'm not really familiar enough with filesystem APIs to know
whether Yang's suggestion is better or not, though.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>


On Thu, Jul 7, 2022 at 9:57 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> syzkaller reports the following issue:
>
> BUG: unable to handle page fault for address: ffff888021f7e005
> PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
> Oops: 0002 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
> Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
> RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
> RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
> R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
> R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
> FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  zero_user_segments include/linux/highmem.h:272 [inline]
>  folio_zero_range include/linux/highmem.h:428 [inline]
>  truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
>  truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
>  truncate_inode_pages mm/truncate.c:452 [inline]
>  truncate_pagecache+0x63/0x90 mm/truncate.c:753
>  simple_setattr+0xed/0x110 fs/libfs.c:535
>  secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
>  notify_change+0xb8c/0x12b0 fs/attr.c:424
>  do_truncate+0x13c/0x200 fs/open.c:65
>  do_sys_ftruncate+0x536/0x730 fs/open.c:193
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fb29d900899
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
> RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
> RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
> R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> CR2: ffff888021f7e005
> ---[ end trace 0000000000000000 ]---
>
> Eric Biggers suggested that this happens when
> secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> that a page that is faulted in by secretmem_fault() (and thus removed
> from the direct map) is zeroed by inode truncation right afterwards.
>
> Since do_truncate() takes inode_lock(), adding inode_lock_shared() to
> secretmem_fault() prevents the race.
>
> Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>
> v2: use inode_lock_shared() rather than add a new rw_sem to secretmem
>
> Axel, I didn't add your Reviewed-by because v2 is quite different.
>
>  mm/secretmem.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 206ed6b40c1d..a4fabf705e4f 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -55,22 +55,28 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>         gfp_t gfp = vmf->gfp_mask;
>         unsigned long addr;
>         struct page *page;
> +       vm_fault_t ret;
>         int err;
>
>         if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>                 return vmf_error(-EINVAL);
>
> +       inode_lock_shared(inode);
> +
>  retry:
>         page = find_lock_page(mapping, offset);
>         if (!page) {
>                 page = alloc_page(gfp | __GFP_ZERO);
> -               if (!page)
> -                       return VM_FAULT_OOM;
> +               if (!page) {
> +                       ret = VM_FAULT_OOM;
> +                       goto out;
> +               }
>
>                 err = set_direct_map_invalid_noflush(page);
>                 if (err) {
>                         put_page(page);
> -                       return vmf_error(err);
> +                       ret = vmf_error(err);
> +                       goto out;
>                 }
>
>                 __SetPageUptodate(page);
> @@ -86,7 +92,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>                         if (err == -EEXIST)
>                                 goto retry;
>
> -                       return vmf_error(err);
> +                       ret = vmf_error(err);
> +                       goto out;
>                 }
>
>                 addr = (unsigned long)page_address(page);
> @@ -94,7 +101,11 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>         }
>
>         vmf->page = page;
> -       return VM_FAULT_LOCKED;
> +       ret = VM_FAULT_LOCKED;
> +
> +out:
> +       inode_unlock_shared(inode);
> +       return ret;
>  }
>
>  static const struct vm_operations_struct secretmem_vm_ops = {
>
> base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
> --
> 2.34.1
>
