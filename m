Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73510750C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjGLPS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjGLPSY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:18:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8819BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 08:18:01 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1324731276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689175058; x=1691767058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHAZ4nXdHvzREhD7ythMQPAptGGmCEr8uwZv+V4swA8=;
        b=ZYVtw2ZfjlpidFv6pVDlBwrQjlN6+lwDG/jdmFdAXbUl3RCCHFs+uxxDVFzTmiO9HW
         kckpsiET+zfPSi6YQbzwR6kAwknxaPSQVfa8P96bgPfbC6X/K6Ow1HrWQ32sHB3UKWgi
         Gy3J7e69bXL6dh+vw+wsdSi11YOnWSJJRXh7ZXDUvM/gMggEFCfSoDkN8N8XoZqLb7Tj
         qBDIpDvdLPlG8UlbuBL/kphnNQcgG6xad7pqwVOVhQTAuXmpRue8fH7/D4yWDLWeNZRR
         s36I1EikJnK0LVyj/pgFhkwNc8jTmHqVrwrhWcKoHTmgOI6mtbUvttDTDNFWNO+Rs3lm
         fMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175058; x=1691767058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHAZ4nXdHvzREhD7ythMQPAptGGmCEr8uwZv+V4swA8=;
        b=ZUfwsEiZfSvxQHHrIyVjpmG6oWnmn8S7gnALjXo0mnC+tqRigLs2GaDDC+Sbxq/GNT
         EfQLu/45Xu1YaBJ2kIB5/QQzc/akmEibjgjsZwiMT97f+tCMusSGESNrZ5dfnrEWjK3c
         6SdOBA6lbCa6Dn5M+F0POjekk7n16K5GQZJi0wjiVrPy2UvvlDdYbBColu0mYgYqc+6l
         BM4EI1v467HBTtPf3aWGTPgBM3QQyGJ1ivmZexwGZC9g9cFCZ+I1E8HOrE+ySNc5ZwjB
         EE6AosILLhiOUoS8axKauS2npgQdwPUJAPdPobMlQTOkBP/Ni06oCj3FMeaWrxJhskY4
         PzJQ==
X-Gm-Message-State: ABy/qLZOorHWCinhdZ7MTmHM4yVDeQlXOii0f40rPwm3Lh29wNDTpeOy
        rE+jF/aHrAIorSDCMcdP7fKdkcg7jxWoZ3EDGmLolCt8YwjJQYD3ao1pSw==
X-Google-Smtp-Source: APBJJlEQs3tBQaSLqcvcjc038Bvt+LkvA5bIgndsO4hnOPuqX/VuO41lZEPYYmv9I4YxXXlz8+UcgHqqbmEA2W36TYM=
X-Received: by 2002:a5b:d06:0:b0:bfe:c5cf:6e60 with SMTP id
 y6-20020a5b0d06000000b00bfec5cf6e60mr2849828ybp.8.1689175057791; Wed, 12 Jul
 2023 08:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002db68f05ffb791bc@google.com> <0000000000005b75ce05ffbd34bc@google.com>
In-Reply-To: <0000000000005b75ce05ffbd34bc@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jul 2023 08:17:26 -0700
Message-ID: <CAJuCfpFGVvtK61Cgd0pN9GRRaw7kRcEUVSG3kceQxtNtPoeaGA@mail.gmail.com>
Subject: Re: [syzbot] [fs?] WARNING in handle_userfault
To:     syzbot <syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 5, 2023 at 6:16=E2=80=AFAM syzbot
<syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    e1f6a8eaf1c2 Add linux-next specific files for 20230705
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13ec5228a8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D347a3e7e531c1=
809
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D339b02f826caafd=
5f7a8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1716aeaca80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12e882e2a8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2d0435d8ff5d/dis=
k-e1f6a8ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d28b2df82094/vmlinu=
x-e1f6a8ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fb4e5bfa0a0f/b=
zImage-e1f6a8ea.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
>
> kvm_intel: L1TF CPU bug present and SMT on, data leak possible. See CVE-2=
018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1t=
f.html for details.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 mmap_assert_wri=
te_locked include/linux/mmap_lock.h:71 [inline]
> WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 __is_vma_write_=
locked include/linux/mm.h:712 [inline]
> WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 vma_assert_lock=
ed include/linux/mm.h:753 [inline]
> WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 assert_fault_lo=
cked include/linux/mm.h:786 [inline]
> WARNING: CPU: 0 PID: 5028 at include/linux/mmap_lock.h:71 handle_userfaul=
t+0x149b/0x27a0 fs/userfaultfd.c:440
> Modules linked in:
> CPU: 0 PID: 5028 Comm: syz-executor359 Not tainted 6.4.0-next-20230705-sy=
zkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/27/2023
> RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:71 [inline]
> RIP: 0010:__is_vma_write_locked include/linux/mm.h:712 [inline]
> RIP: 0010:vma_assert_locked include/linux/mm.h:753 [inline]
> RIP: 0010:assert_fault_locked include/linux/mm.h:786 [inline]
> RIP: 0010:handle_userfault+0x149b/0x27a0 fs/userfaultfd.c:440
> Code: ff 49 8d bc 24 a0 01 00 00 31 f6 e8 2f b9 23 08 31 ff 41 89 c5 89 c=
6 e8 c3 a2 87 ff 45 85 ed 0f 85 83 ed ff ff e8 95 a6 87 ff <0f> 0b e9 77 ed=
 ff ff e8 89 a6 87 ff 49 8d bc 24 a0 01 00 00 be ff
> RSP: 0000:ffffc90003a4fb68 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc90003a4fd88 RCX: 0000000000000000
> RDX: ffff8880133bbb80 RSI: ffffffff81fd6ddb RDI: 0000000000000005
> RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807d8e4280
> R13: 0000000000000000 R14: ffff888021cb9110 R15: ffff888021cb9100
> FS:  000055555738f300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020b7d800 CR3: 0000000029d0e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_anonymous_page mm/memory.c:4151 [inline]
>  do_pte_missing mm/memory.c:3671 [inline]
>  handle_pte_fault mm/memory.c:4949 [inline]
>  __handle_mm_fault+0x35ff/0x3cc0 mm/memory.c:5089
>  handle_mm_fault+0x3c2/0xa20 mm/memory.c:5254
>  do_user_addr_fault+0x2ed/0x13a0 arch/x86/mm/fault.c:1365
>  handle_page_fault arch/x86/mm/fault.c:1509 [inline]
>  exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7faa694e34d5
> Code: 52 89 c2 01 f6 29 f2 83 fa 05 0f 87 0a 02 00 00 48 63 14 97 48 01 f=
a ff e2 0f 1f 40 00 4c 89 d2 66 c1 e9 03 83 c0 01 0f b7 c9 <48> 89 14 cd 00=
 d8 b7 20 83 f8 20 75 b6 48 8b 84 24 f0 00 00 00 f3
> RSP: 002b:00007ffefcb0d8e0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000860000109120 RSI: 0000000000000000 RDI: 00007faa69564020
> RBP: 0000000000000006 R08: 0000830000789120 R09: 00000000aaaaaaab
> R10: 0000870000109120 R11: 00008f0000309120 R12: 00008b0000889120
> R13: 0000000000000000 R14: 00008e0000309120 R15: 00007ffefcb0de40
>  </TASK>
>

Sorry, this is my code. Missed that __is_vma_write_locked() generates
assertion. Will post a fix shortly.

>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
