Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F76EC744
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjDXHjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjDXHjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:39:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2899C10C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:38:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so10683e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682321936; x=1684913936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e//pvNXcoanFwliZ7s+8jS5hr41JlVa9XYAEnl3Aj6k=;
        b=KBg53HVUoAwH5lT6YouyoqqEcMD4J9sS8sxGp68X/3BMamLG0f6WrquPBcAuJS4Jfy
         mHAa5PIryNnqx/53u7Ie6bGOHb3mnQpgw3f4hf/eISDq9JDnS3bstirG5odpcnkBO8Do
         N2xMpwu5rJOF+Te9TJjYr2FQtRXaYDCmytJT0vCu2OHRnY25RwyQQTOIVglH44PQkSx4
         qqz6DbbvkpR1JOulBonssSDUivBaRoH82DSVfnlxnoXEcXFEE/QpUUAVUFjqe1NJp4v3
         /zbWW3e4UrXykKCDyk0vzz3l3lxF7X85GyIareRMkz0It/kKlnQYFZWXW6NmKLMRXw+1
         kE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682321936; x=1684913936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e//pvNXcoanFwliZ7s+8jS5hr41JlVa9XYAEnl3Aj6k=;
        b=XYDyo78Ra632HQqYIElLCeViXE5cp9wYkIjKC9zOMexwDnOKqeEf/ISGp9zWi03wM7
         vzmsK3lnTZxFTEf+PB75SmwGB03/l7U/Sps4P/RTZiNfjrdNS53w6kCb5beM6MiVg39a
         SCFZ1dJzbpRfZLP8sevGqL2MWrzau6ZLTiL8oEUiGJUwhiLAFrbNP8zOQz15ujNMGyze
         Gi/cVA25S0vVM8h/HWj+k6rYHRkwOb6P9kWoyVwqZs1i20RJRRgklMRrlO/H7UzxAAVZ
         11Br9eyafwBmp3QGp4VdPWxyHqrjjUbxb6XmF+y1+tWSXZaf8v3TteNi4UJEmPHsoySf
         Vu2A==
X-Gm-Message-State: AAQBX9fdajhp6SqzaK6iJBkIMXEEhHzgSa6jNp3RehCvT8ccv+Lt7WWA
        3AMWufLcNBJYg/Lzc0qq+bJBE3tsfFGRqrt7vQnu2A==
X-Google-Smtp-Source: AKy350azvuFUbzB5Ml19ono/FiqTyeKyybdKc07Fahco/IbPFxwXDNo85nc/c50Pm8LNPG7XZeg97i4e8B3wzzEjbRM=
X-Received: by 2002:a05:6512:3ca2:b0:4ed:b0bd:a96c with SMTP id
 h34-20020a0565123ca200b004edb0bda96cmr217559lfv.6.1682321936088; Mon, 24 Apr
 2023 00:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0737c05fa0fd499@google.com>
In-Reply-To: <000000000000d0737c05fa0fd499@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 09:38:43 +0200
Message-ID: <CACT4Y+YKt-YvQ5fKimXAP8nsV=X81OymPd3pxVXvmPG-51YjOw@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio /
 folio_mapping (2)
To:     syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Apr 2023 at 09:19, syzbot
<syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    622322f53c6d Merge tag 'mips-fixes_6.3_2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12342880280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8b5f31d96315/disk-622322f5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/adca7dc8daae/vmlinux-622322f5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed78ddc31ccb/bzImage-622322f5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com

If I am reading this correctly, it can lead to NULL derefs in
folio_mapping() if folio->mapping is read twice. I think
folio->mapping reads/writes need to use READ/WRITE_ONCE if racy.


> ==================================================================
> BUG: KCSAN: data-race in __filemap_remove_folio / folio_mapping
>
> write to 0xffffea0004958618 of 8 bytes by task 17586 on cpu 1:
>  page_cache_delete mm/filemap.c:145 [inline]
>  __filemap_remove_folio+0x210/0x330 mm/filemap.c:225
>  invalidate_complete_folio2 mm/truncate.c:586 [inline]
>  invalidate_inode_pages2_range+0x506/0x790 mm/truncate.c:673
>  iomap_dio_complete+0x383/0x470 fs/iomap/direct-io.c:115
>  iomap_dio_rw+0x62/0x90 fs/iomap/direct-io.c:687
>  ext4_dio_write_iter fs/ext4/file.c:597 [inline]
>  ext4_file_write_iter+0x9e6/0x10e0 fs/ext4/file.c:708
>  do_iter_write+0x418/0x700 fs/read_write.c:861
>  vfs_iter_write+0x50/0x70 fs/read_write.c:902
>  iter_file_splice_write+0x456/0x7d0 fs/splice.c:778
>  do_splice_from fs/splice.c:856 [inline]
>  direct_splice_actor+0x84/0xa0 fs/splice.c:1022
>  splice_direct_to_actor+0x2ee/0x5f0 fs/splice.c:977
>  do_splice_direct+0x104/0x180 fs/splice.c:1065
>  do_sendfile+0x3b8/0x950 fs/read_write.c:1255
>  __do_sys_sendfile64 fs/read_write.c:1323 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1309 [inline]
>  __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1309
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffffea0004958618 of 8 bytes by task 17568 on cpu 0:
>  folio_mapping+0x92/0x110 mm/util.c:774
>  folio_evictable mm/internal.h:156 [inline]
>  lru_add_fn+0x92/0x450 mm/swap.c:181
>  folio_batch_move_lru+0x21e/0x2f0 mm/swap.c:217
>  folio_batch_add_and_move mm/swap.c:234 [inline]
>  folio_add_lru+0xc9/0x130 mm/swap.c:517
>  filemap_add_folio+0xfc/0x150 mm/filemap.c:954
>  page_cache_ra_unbounded+0x15e/0x2e0 mm/readahead.c:251
>  do_page_cache_ra mm/readahead.c:300 [inline]
>  page_cache_ra_order mm/readahead.c:560 [inline]
>  ondemand_readahead+0x550/0x6c0 mm/readahead.c:682
>  page_cache_sync_ra+0x284/0x2a0 mm/readahead.c:709
>  page_cache_sync_readahead include/linux/pagemap.h:1214 [inline]
>  filemap_get_pages+0x257/0xea0 mm/filemap.c:2598
>  filemap_read+0x223/0x680 mm/filemap.c:2693
>  generic_file_read_iter+0x76/0x320 mm/filemap.c:2840
>  ext4_file_read_iter+0x1cc/0x290
>  call_read_iter include/linux/fs.h:1845 [inline]
>  generic_file_splice_read+0xe3/0x290 fs/splice.c:402
>  do_splice_to fs/splice.c:885 [inline]
>  splice_direct_to_actor+0x25a/0x5f0 fs/splice.c:956
>  do_splice_direct+0x104/0x180 fs/splice.c:1065
>  do_sendfile+0x3b8/0x950 fs/read_write.c:1255
>  __do_sys_sendfile64 fs/read_write.c:1323 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1309 [inline]
>  __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1309
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0xffff88810a98f7b0 -> 0x0000000000000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 17568 Comm: syz-executor.2 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d0737c05fa0fd499%40google.com.
