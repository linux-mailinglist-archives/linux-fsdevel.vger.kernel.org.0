Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A307A244C29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHNPaX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 11:30:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHNPaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A58EAE2C;
        Fri, 14 Aug 2020 15:30:41 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: NTFS read-write driver GPL implementation by
 Paragon Software.
In-Reply-To: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
Date:   Fri, 14 Aug 2020 17:30:16 +0200
Message-ID: <87h7t5454n.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've tried this using libntfs-3g mkfs.ntfs

# mkfs.ntfs /dev/vb1
# mount -t ntfs3 /dev/vb1 /mnt

This already triggered UBSAN:

 ================================================================================
 UBSAN: object-size-mismatch in fs/ntfs3/super.c:834:16
 load of address 000000006ae096b5 with insufficient space
 for an object of type 'const char'
 CPU: 3 PID: 1248 Comm: mount Not tainted 5.8.0+ #4
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
 Call Trace:
  dump_stack+0x78/0xa0
  ubsan_epilogue+0x5/0x40
  ubsan_type_mismatch_common.cold+0xc8/0xcd
  __ubsan_handle_type_mismatch_v1+0x32/0x37
  ntfs_fill_super+0x9f/0x13e0
  ? vsnprintf+0x1ef/0x4f0
  mount_bdev+0x193/0x1c0

Which points to:

	sb->s_magic = *(unsigned long *)s_magic; /* TODO */

Maybe store ('n'<<32)|('t'<<24)|('f'<<16)|('s'<<8) ?
Seems harmless.

* * *

Then I've tried to copy /etc into it:

# cp -rp /etc /mnt

But this triggered a NULL ptr deref:

 BUG: kernel NULL pointer dereference, address: 0000000000000028
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0 
 Oops: 0000 [#1] SMP NOPTI
 CPU: 0 PID: 1255 Comm: cp Not tainted 5.8.0+ #4
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
 RIP: 0010:ntfs_insert_security+0x187/0x4a0
 Code: 00 48 83 c4 18 85 c0 0f 85 54 01 00 00 48 8b 44 24 50 49 8d b5 d8 01 00 00 8b 54 24 60 83 c3 14 48 89 74 24 30 48 85 c0 74 3a <39> 58 28 0f 84 7e 01 00 00 49 89 e8 48 8d 4c 24 50 4c 89 f2 4c 89
 RSP: 0018:ffffac73403dfc58 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000064 RCX: 0000000000000010
 RDX: 00000000000000b0 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffff94154ed5fe00 R08: 0000000000000000 R09: 0000000000000001
 R10: ffff9415781a6180 R11: 0000000000000003 R12: ffff94155c989800
 R13: ffff94151e8d2a38 R14: ffff9415781a6170 R15: ffff9415781173f0
 FS:  00007fd19b86e580(0000) GS:ffff94157dc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000028 CR3: 000000001ac2a000 CR4: 0000000000350ef0
 Call Trace:
  ? mark_held_locks+0x49/0x70
  ? lockdep_hardirqs_on_prepare+0xf7/0x190
  ? ktime_get_coarse_real_ts64+0x9e/0xd0
  ? trace_hardirqs_on+0x1c/0xe0
  ntfs_create_inode+0x2db/0x11c0
  ntfs_mkdir+0x58/0x90
  vfs_mkdir+0x109/0x1f0
  do_mkdirat+0x81/0x120
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7fd19ad54dd7
 Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 b9 70 2c 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 70 2c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffec3c41588 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
 RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fd19ad54dd7
 RDX: 00000000000c0001 RSI: 00000000000001c0 RDI: 000055cad585fcf0
 RBP: 00007ffec3c41990 R08: 00007ffec3c41b50 R09: 00007fd19ada55c0
 R10: 00000000000001ef R11: 0000000000000206 R12: 00007ffec3c41b50
 R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffec3c437be


(gdb) list *(ntfs_insert_security+0x187)
0xffffffff814e5097 is in ntfs_insert_security (fs/ntfs3/fsntfs.c:1811).
1806
1807            if (!e)
1808                    goto insert_security;
1809
1810    next_security:
1811            if (le32_to_cpu(e->sec_hdr.size) != new_sec_size)
1812                    goto skip_read_sds;
1813
1814            err = ntfs_read_run_nb(sbi, &ni->file.run, le64_to_cpu(e->sec_hdr.off),
1815                                   d_security, new_sec_size, NULL);

(gdb) disas /s ntfs_insert_security
....
1811            if (le32_to_cpu(e->sec_hdr.size) != new_sec_size)
   0xffffffff814e5097 <+391>:   cmp    %ebx,0x28(%rax) <=====
   0xffffffff814e509a <+394>:   je     0xffffffff814e521e <ntfs_insert_security+782>

(gdb) p/x (int)&((NTFS_DE_SDH*)0)->sec_hdr.size
$4 = 0x28

So I think 'e' is NULL. Not sure how it can happen.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
