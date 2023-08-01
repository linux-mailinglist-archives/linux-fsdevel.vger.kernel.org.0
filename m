Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877A976B7C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjHAOhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjHAOhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:37:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EC1BE3
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 07:37:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso88175e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690900661; x=1691505461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX3SCaL+nqbzWlgV5r+kEcLJhVHCw6bNrKQyQYjtem8=;
        b=enlBs4nPSHmJlxPf/6AVeGstDtXbwpRj75G0reJfj3CnEzEVYDhdBDAlvWLxW0Z4CC
         XDzIM7cy35pR4LjZRnRuNU/7Zg1pY85H2kHZXqTtvOKMasL7b+EazRrtEmSis2bwkHHw
         dIlXaFL1oC5huRki64GGMYqrPoz1mupbCSS8NDos3NG0PY9ZTBGH3ckERHYQW87KvlUO
         jx9VR9jSp3Y6LrGFOpXmeBgN+HZPnPzT6qB61McFARoksbx9ItMyJ6UQKE1abJ1KsxEA
         pbo0MJtMaxX3gOLjSKfPt7Pja8IfZMsBqvia5sy2A/AJ8QNM/9Mt+hNFk4ZleJIo32uZ
         +qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900661; x=1691505461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX3SCaL+nqbzWlgV5r+kEcLJhVHCw6bNrKQyQYjtem8=;
        b=XkpJ+7hC/FoATrvDbys2lAgeEUQityjL5+GoKhML5cfki9VdyAtYGLckcDr4Gpzyl5
         X2GbKSLPh+wS2Hic2r/bJe6aLFcx9OuBxB255+0dap5Q9GslrF0xjzVrjg3TbYifbrkM
         9gnEUHMqjOJ3crLg/qOhYWbHqGj1m3EI912FulXxxxdP9222DPSphs6uc/HN5U4+hlqk
         tgptDdgp+4b045ilu0joOJfVWm+afA60zbEIl26kJx3IlaiazQJoDT/xcp5dbI1iwfoK
         izVFaheK0TixGe+KuB3xqHC3QgdoRYek5bwfALyRQD1mUI/nQvhdME5QVRCZ+ic156aI
         /rag==
X-Gm-Message-State: ABy/qLY/tUgi+69BdzQ/rlMe+HYvzmkxIsP5NNbnz5ynUwABO4t73iaK
        5do2kLCYEGdGrtG9zF0N2AX0XgKjEYjXwp8x5CntivpK8aKytn+0CYaVI2HmiJo=
X-Google-Smtp-Source: APBJJlHEhqpGmdESgiHQb58sHvhoL+2K7yFSMocOzwLGs2L6SlZdbUXLPkwl2g68mEyzybDwhT99tX4xu1l8lfROl0o=
X-Received: by 2002:a05:600c:1d14:b0:3fe:b38:5596 with SMTP id
 l20-20020a05600c1d1400b003fe0b385596mr257851wms.6.1690900661198; Tue, 01 Aug
 2023 07:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f20fc00601b75a80@google.com> <0a79a1ad-697a-7687-ff94-2f4897648c22@gmx.com>
 <98aa463d-b257-0c2b-8a7c-b1782f73e02c@gmx.com>
In-Reply-To: <98aa463d-b257-0c2b-8a7c-b1782f73e02c@gmx.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 1 Aug 2023 17:37:25 +0300
Message-ID: <CANp29Y5vZZN0a3NOhk6N2HR89dzQ30xJYdhqZO5C0fsC+C0sKA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 8:26=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/7/31 13:11, Qu Wenruo wrote:
> >
> >
> > On 2023/7/31 01:07, syzbot wrote:
> >> syzbot has found a reproducer for the following issue on:
> >>
> >> HEAD commit:    d31e3792919e Merge tag '6.5-rc3-smb3-client-fixes' of
> >> git:..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17afd745a8=
0000
> >> kernel config:
> >> https://syzkaller.appspot.com/x/.config?x=3D9d670a4f6850b6f4
> >> dashboard link:
> >> https://syzkaller.appspot.com/bug?extid=3Dae97a827ae1c3336bbb4
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> >> for Debian) 2.40
> >> syz repro:
> >> https://syzkaller.appspot.com/x/repro.syz?x=3D15278939a80000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14dd3f31a8=
0000
> >>
> >> Downloadable assets:
> >> disk image (non-bootable):
> >> https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable=
_disk-d31e3792.raw.xz
> >> vmlinux:
> >> https://storage.googleapis.com/syzbot-assets/c6c2342933c9/vmlinux-d31e=
3792.xz
> >> kernel image:
> >> https://storage.googleapis.com/syzbot-assets/42df60b42886/bzImage-d31e=
3792.xz
> >> mounted in repro:
> >> https://storage.googleapis.com/syzbot-assets/78ffd1ddff6c/mount_0.gz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the
> >> commit:
> >> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
> >>
> >> BTRFS info (device loop1): relocating block group 5242880 flags
> >> data|metadata
> >> assertion failed: root->reloc_root =3D=3D reloc_root, in
> >> fs/btrfs/relocation.c:1919
> >> ------------[ cut here ]------------
> >> kernel BUG at fs/btrfs/relocation.c:1919!
> >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 0 PID: 12638 Comm: syz-executor311 Not tainted
> >> 6.5.0-rc3-syzkaller-00297-gd31e3792919e #0
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> >> 1.16.2-debian-1.16.2-1 04/01/2014
> >> RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
> >> Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9
> >> b6 8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b
> >> 4c 8b 7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
> >> RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
> >> RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
> >> RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
> >> RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
> >> R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
> >> R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
> >> FS:  00007fb31aba26c0(0000) GS:ffff88806b600000(0000)
> >> knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>   <TASK>
> >>   relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3749
> >>   btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:4087
> >>   btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3283
> >>   __btrfs_balance fs/btrfs/volumes.c:4018 [inline]
> >>   btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4395
> >>   btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
> >>   btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
> >>   vfs_ioctl fs/ioctl.c:51 [inline]
> >>   __do_sys_ioctl fs/ioctl.c:870 [inline]
> >>   __se_sys_ioctl fs/ioctl.c:856 [inline]
> >>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
> >>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> >>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >> RIP: 0033:0x7fb31abe6e49
> >> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48
> >> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> >> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007fb31aba2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >> RAX: ffffffffffffffda RBX: 00007fb31ac73728 RCX: 00007fb31abe6e49
> >> RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
> >> RBP: 00007fb31ac73720 R08: 00007fb31aba26c0 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb31ac7372c
> >> R13: 0000000000000006 R14: 00007ffe768d5660 R15: 00007ffe768d5748
> >>   </TASK>
> >> Modules linked in:
> >> ---[ end trace 0000000000000000 ]---
> >> RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
> >> Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9
> >> b6 8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b
> >> 4c 8b 7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
> >> RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
> >> RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
> >> RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
> >> RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
> >> R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
> >> R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
> >> FS:  00007fb31aba26c0(0000) GS:ffff88806b600000(0000)
> >> knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>
> >
> > I failed to reproduce it locally, although it's on David's misc-next.
> >
> > # syz test: git://github.com/kdave/btrfs-devel.git misc-next
>
> # syz test: git://github.com/adam900710/linux.git graceful_reloc_mismatch

#syz test: https://github.com/adam900710/linux graceful_reloc_mismatch

> >
> > Thanks,
> > Qu
> >>
> >> ---
> >> If you want syzbot to run the reproducer, reply with:
> >> #syz test: git://repo/address.git branch-or-commit-hash
> >> If you attach or paste a git patch, syzbot will apply it before testin=
g.
>
