Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E45768B1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 07:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGaF1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 01:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGaF1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:27:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92AE1730;
        Sun, 30 Jul 2023 22:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690781168; x=1691385968; i=quwenruo.btrfs@gmx.com;
 bh=ixIkyqsVzuNalaLB+gxKKOW0Gj/G6DiNV/SwgXzDGkg=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=RPrkUehPcmgMOz1riySyzYoJkOnp0jopQ0cpsMD3yDLxNhlEB4F7pgn+pNfHnKZyHa64jC4
 8wD/YDO+HWAbeEsTE5xW0mm/VB8+aRy1r+/1lU3++YZkXvUoKz3wZFiC14EY8DcX5gn6ESyEp
 sHN/heOuB9fN4no63VO6y//JmJTWmQafZXKEfAHHECHJRPgtvOFQvr304ZPXHf/GadQjr3xH7
 r07taqhnK+HzvaJaOzkkrKYgZooqn4IqWb8zP8+lK2D10wJHxXl2bWg/EF4A+e99g+NKIsYQ9
 evpTowiagNQ7jywwEsQ8I7aWWw3wcRu7jOYqWKRMrR3ntToovivQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIx3C-1qAKxx2fBC-00KQVJ; Mon, 31
 Jul 2023 07:26:08 +0200
Message-ID: <98aa463d-b257-0c2b-8a7c-b1782f73e02c@gmx.com>
Date:   Mon, 31 Jul 2023 13:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f20fc00601b75a80@google.com>
 <0a79a1ad-697a-7687-ff94-2f4897648c22@gmx.com>
In-Reply-To: <0a79a1ad-697a-7687-ff94-2f4897648c22@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+L3COKOYHKjKMaxWVuw3pAYL1iw4w5GRG+p2KfhoQ7eyAxUYWym
 eliPmperxIKFdc19tu25iwHczWBALk/KoPJjk9sHyMOX7Gpvzm1h+OV2CHz2Ge38ddzqHWJ
 lxBSnOhoXjKOt/qlHKTV2595+txAbsvlbMOAXEvikxv6b8jZSdqIt2ce9H/bVf5RvHYNxh9
 F0cUIbiou06PH1n1QUWeg==
UI-OutboundReport: notjunk:1;M01:P0:oS2XP9gs9eQ=;D7RdJgnvoIVapv23ZkQ0g+bqphq
 kKA2mhOnCdpBNcEyT3DpGwcDzw7tqg2oWJR8vvL2UtWPCUKvSgYTVaWtXl9Pu+/EsMOGL+Bwh
 n3/9iKkukQUpCvoekvQV8lVyOj0xc9UikPilptfYUgIywNSnCoJCgt8DLpvbFpVc6akYgqk/z
 GICOwcz/qmqLMQWZYMSqhyKjsOOKDAinnIqcROc3gZZYJEnY0cnTTvMJ4UXM87gZ63mrDNNmI
 Ra3suaoXBj56D2uP6Gj4ySzN3xjTyKJ2ixbW87kbhUu83jZesqOpRN3t0tkYIrk8y3SyMz09R
 m8Ry4ieQ0bJogVEYgLQhuJyCS4tQxGkLP/zEtwOcYsqCK1XSJrrgxwvXMtc1Oz2abN3D8MWqS
 DwJNpm6mA/2QEJG72R4c7p+P06zUsUaFMiuDh/JklVoJDL9sv/eJ0LZiBxObqriLebodzQ7Ez
 HBvafMTRC8BR4VD6JndBTjvLDgVxLi5d0Ak1CAcWfNhz/xsIfAULVrx2jAPbCffl28jjkdcMb
 n5mAtLN/13RIiX0ChsTHPq+nJVCYD1fPGq7ocqrp37iK362DPxsY9ZC2jV3USzY8C/U7ChzMy
 DFeLdFJ2gwyr87tmG8o9mxZBM+yfx7bT1aKrANcb9gbDZAM2Kv2oZcwtsAJPKSnxGZUxJVkoe
 dgS2RVpLf+8ojQTJ9pnPwV9PH6/7EIsW+/bRvY6JyloHEmjcl6jmzFqC3kpWxZ8NLfIZvWsPk
 3bdkHLe9jiIrQUqFpjler3DKL7RiKnI4kVOG7XeMEqWMleOPo195DIPNECHqsxvR+reM0jY52
 1FIdJaWtxEWbGXnZoW6bhTTIcFVp7W3R8N04BSI9K/ltXhOuOG9CglwvcZwV8xgVwUgqc4qF/
 FWkQRkn00a6RtNvcERCyPx9tBECUxbl+KbwwDdSvPXwncSuHM6pzzJ5pSXLn8cZCcYbDFxiQ1
 DHmRyCucJUT4aWKKmj/JSKM7VdE=
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/31 13:11, Qu Wenruo wrote:
>
>
> On 2023/7/31 01:07, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:=C2=A0=C2=A0=C2=A0 d31e3792919e Merge tag '6.5-rc3-smb3-cli=
ent-fixes' of
>> git:..
>> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17afd745a80=
000
>> kernel config:
>> https://syzkaller.appspot.com/x/.config?x=3D9d670a4f6850b6f4
>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=3Dae97a827ae1c3336bbb4
>> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gcc (Debian 12.2.0-14) 12=
.2.0, GNU ld (GNU Binutils
>> for Debian) 2.40
>> syz repro:
>> https://syzkaller.appspot.com/x/repro.syz?x=3D15278939a80000
>> C reproducer:=C2=A0=C2=A0 https://syzkaller.appspot.com/x/repro.c?x=3D1=
4dd3f31a80000
>>
>> Downloadable assets:
>> disk image (non-bootable):
>> https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_=
disk-d31e3792.raw.xz
>> vmlinux:
>> https://storage.googleapis.com/syzbot-assets/c6c2342933c9/vmlinux-d31e3=
792.xz
>> kernel image:
>> https://storage.googleapis.com/syzbot-assets/42df60b42886/bzImage-d31e3=
792.xz
>> mounted in repro:
>> https://storage.googleapis.com/syzbot-assets/78ffd1ddff6c/mount_0.gz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the
>> commit:
>> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
>>
>> BTRFS info (device loop1): relocating block group 5242880 flags
>> data|metadata
>> assertion failed: root->reloc_root =3D=3D reloc_root, in
>> fs/btrfs/relocation.c:1919
>> ------------[ cut here ]------------
>> kernel BUG at fs/btrfs/relocation.c:1919!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 12638 Comm: syz-executor311 Not tainted
>> 6.5.0-rc3-syzkaller-00297-gd31e3792919e #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 1.16.2-debian-1.16.2-1 04/01/2014
>> RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
>> Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9
>> b6 8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b
>> 4c 8b 7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
>> RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
>> RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
>> RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
>> R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
>> FS:=C2=A0 00007fb31aba26c0(0000) GS:ffff88806b600000(0000)
>> knlGS:0000000000000000
>> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>> =C2=A0 <TASK>
>> =C2=A0 relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3749
>> =C2=A0 btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:408=
7
>> =C2=A0 btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3283
>> =C2=A0 __btrfs_balance fs/btrfs/volumes.c:4018 [inline]
>> =C2=A0 btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4395
>> =C2=A0 btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
>> =C2=A0 btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
>> =C2=A0 vfs_ioctl fs/ioctl.c:51 [inline]
>> =C2=A0 __do_sys_ioctl fs/ioctl.c:870 [inline]
>> =C2=A0 __se_sys_ioctl fs/ioctl.c:856 [inline]
>> =C2=A0 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
>> =C2=A0 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> =C2=A0 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>> =C2=A0 entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7fb31abe6e49
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fb31aba2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00007fb31ac73728 RCX: 00007fb31abe6e49
>> RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
>> RBP: 00007fb31ac73720 R08: 00007fb31aba26c0 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb31ac7372c
>> R13: 0000000000000006 R14: 00007ffe768d5660 R15: 00007ffe768d5748
>> =C2=A0 </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:prepare_to_merge+0x9cc/0xcd0 fs/btrfs/relocation.c:1919
>> Code: c5 e9 81 fd ff ff e8 e3 59 00 fe b9 7f 07 00 00 48 c7 c2 40 d9
>> b6 8a 48 c7 c6 20 e6 b6 8a 48 c7 c7 a0 da b6 8a e8 54 bc e3 fd <0f> 0b
>> 4c 8b 7c 24 38 48 8b 5c 24 10 44 8b 6c 24 0c e8 ae 59 00 fe
>> RSP: 0018:ffffc90023e176d0 EFLAGS: 00010282
>> RAX: 000000000000004f RBX: ffff88801e898560 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff81698120 RDI: 0000000000000005
>> RBP: ffff88801e898558 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000080000000 R11: 6f69747265737361 R12: dffffc0000000000
>> R13: ffff88801e898000 R14: ffff88802d944000 R15: ffff888017616618
>> FS:=C2=A0 00007fb31aba26c0(0000) GS:ffff88806b600000(0000)
>> knlGS:0000000000000000
>> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fb31ac3a758 CR3: 000000002e1dc000 CR4: 0000000000350ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>
>
> I failed to reproduce it locally, although it's on David's misc-next.
>
> # syz test: git://github.com/kdave/btrfs-devel.git misc-next

# syz test: git://github.com/adam900710/linux.git graceful_reloc_mismatch
>
> Thanks,
> Qu
>>
>> ---
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing=
.
