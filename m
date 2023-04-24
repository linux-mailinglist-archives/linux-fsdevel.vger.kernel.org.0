Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613CC6EC764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjDXHs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjDXHs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:48:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4D10C6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:48:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efea87c578so2190e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682322531; x=1684914531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sBn9MP8gsO/9Z4/eW6ATiLedWzLjSk/fKcpX7dMZveA=;
        b=508/yBtlnonuvvT+/PvqrAjIjdJiOjGt/S0cx2WdIneDC1rDxi2GCj+P59chqtm3kr
         FsEh7PH8fWZJuMbuLUetNWWo5k7EzV8ZyhOBrxdEefOrunjivJ7ptpJyYkR8PNSpetDJ
         v5k8c+Wy1y2GyJeOYEp+PYbgiaQOJ7+IPQk27D8xKzB02Y5JL5f9WgTDeE1DzuupJz4t
         l95u6kRFu8DfB9PBQmGAa2HuHsTAwIQ4K/Cbc9w2HT+XGuzXeBGz21kc8KznUkfDGkbu
         BG+OUbwkvUXPlN4XMZLtuK/WIb2B/XfF5Dxf7RXKQNxpYc8dbXc57Nl04rBVsTy2CfNw
         pQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682322531; x=1684914531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBn9MP8gsO/9Z4/eW6ATiLedWzLjSk/fKcpX7dMZveA=;
        b=NUdsfYBFeifz6pbZVZ/gCqM8+/SieeDcGyCPOOnlNnTRLlFXZQbkzinRrOhTO4qAaj
         /6q+OLvnx1eo7s+3/elHJtAjRNMKoZ7ElD0HlCKpj2V9LIlV+DDeAPZsAJNTfLnDBP70
         4IiUzmIoghrn0OuHq7DLL/Ag88LOOKx1zlh4nK8no9he7sNylf7I/S+ZN0LBL6X0bRVb
         ivp9grperjp0OFf3eD7lUb8/ZGYwy3iuknkTLUYh9U0pv5vmE/BD4jbxAR11/7VJ0ncm
         imWhBTh9Lt9rMtDydtsFnmwk8utRi7C4kPhJ5LLQ8HeJFuGysoWShTLfipjFhdiJfHFq
         gkjw==
X-Gm-Message-State: AAQBX9eH9F3NK1PNZ39cGD9msnWjNegfIbWcCxRNXX/MUAW6gy6dMJSi
        mix5AdZlKUemLG1Dt+xwmhgPQmZPHAzQ8yo6FAi2bg==
X-Google-Smtp-Source: AKy350aQBjeLf7pGBQHnXgI4moJm5eqG1WAVCi9zY6m161Flll023f+bc0gDJapF0elzS0jIdPTFF8YsCe0xnS8l7T4=
X-Received: by 2002:a05:6512:12ce:b0:4e8:3f1e:de43 with SMTP id
 p14-20020a05651212ce00b004e83f1ede43mr220567lfg.7.1682322530834; Mon, 24 Apr
 2023 00:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fb55ed05fa0fdb4b@google.com>
In-Reply-To: <000000000000fb55ed05fa0fdb4b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 09:48:37 +0200
Message-ID: <CACT4Y+aGqEb-Z9JOR0eccoL9cw2BYZVspTJfB_33y=Q_+PO4QA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [fs?] KCSAN: data-race in __filemap_remove_folio / shmem_get_folio_gfp
To:     syzbot <syzbot+ec4650f158c91a963120@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

On Mon, 24 Apr 2023 at 09:21, syzbot
<syzbot+ec4650f158c91a963120@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cb0856346a60 Merge tag 'mm-hotfixes-stable-2023-04-19-16-3..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=170802cfc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=ec4650f158c91a963120
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a02dd7789fb2/disk-cb085634.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a1a1eac454f6/vmlinux-cb085634.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bb0447014913/bzImage-cb085634.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ec4650f158c91a963120@syzkaller.appspotmail.com

shmem_recalc_inode() has a check for "freed > 0", but I think it can
be violated due to this race, if i_mapping->nrpages is read twice. If
there are concurrent modifications, the code should use at least
READ/WRITE_ONCE for accesses.

> ==================================================================
> BUG: KCSAN: data-race in __filemap_remove_folio / shmem_get_folio_gfp
>
> read-write to 0xffff888136bf8960 of 8 bytes by task 19402 on cpu 1:
>  page_cache_delete mm/filemap.c:147 [inline]
>  __filemap_remove_folio+0x22f/0x330 mm/filemap.c:225
>  filemap_remove_folio+0x6c/0x220 mm/filemap.c:257
>  truncate_inode_folio+0x19f/0x1e0 mm/truncate.c:196
>  shmem_undo_range+0x24d/0xc20 mm/shmem.c:942
>  shmem_truncate_range mm/shmem.c:1041 [inline]
>  shmem_fallocate+0x2fc/0x8d0 mm/shmem.c:2779
>  vfs_fallocate+0x369/0x3d0 fs/open.c:324
>  madvise_remove mm/madvise.c:1001 [inline]
>  madvise_vma_behavior mm/madvise.c:1025 [inline]
>  madvise_walk_vmas mm/madvise.c:1260 [inline]
>  do_madvise+0x77b/0x28a0 mm/madvise.c:1439
>  __do_sys_madvise mm/madvise.c:1452 [inline]
>  __se_sys_madvise mm/madvise.c:1450 [inline]
>  __x64_sys_madvise+0x60/0x70 mm/madvise.c:1450
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888136bf8960 of 8 bytes by task 19400 on cpu 0:
>  shmem_recalc_inode mm/shmem.c:359 [inline]
>  shmem_get_folio_gfp+0xc0a/0x1120 mm/shmem.c:1977
>  shmem_fault+0xd9/0x3d0 mm/shmem.c:2152
>  __do_fault mm/memory.c:4155 [inline]
>  do_read_fault mm/memory.c:4506 [inline]
>  do_fault mm/memory.c:4635 [inline]
>  handle_pte_fault mm/memory.c:4923 [inline]
>  __handle_mm_fault mm/memory.c:5065 [inline]
>  handle_mm_fault+0x115d/0x21d0 mm/memory.c:5211
>  faultin_page mm/gup.c:925 [inline]
>  __get_user_pages+0x363/0xc30 mm/gup.c:1147
>  populate_vma_page_range mm/gup.c:1543 [inline]
>  __mm_populate+0x23a/0x360 mm/gup.c:1652
>  mm_populate include/linux/mm.h:3026 [inline]
>  vm_mmap_pgoff+0x174/0x210 mm/util.c:547
>  ksys_mmap_pgoff+0xc5/0x320 mm/mmap.c:1410
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x0000000000000437 -> 0x0000000000000430
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 19400 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000fb55ed05fa0fdb4b%40google.com.
