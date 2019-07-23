Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DC71738
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 13:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfGWLhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 07:37:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfGWLhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:37:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NBX4w2068081
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 07:37:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2twy8b6hwt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 07:37:16 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Tue, 23 Jul 2019 12:37:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 12:37:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NBbAJ150593954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 11:37:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A71BB4203F;
        Tue, 23 Jul 2019 11:37:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EFBE4204B;
        Tue, 23 Jul 2019 11:37:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.106.240])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 11:37:08 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
Cc:     lkp@01.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 402b1b327a: BUG:unable_to_handle_page_fault_for_address
Date:   Tue, 23 Jul 2019 17:08:39 +0530
Organization: IBM
In-Reply-To: <3752190.lVsyvYfFkZ@localhost.localdomain>
References: <20190626085800.GD7221@shao2-debian> <3752190.lVsyvYfFkZ@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19072311-0020-0000-0000-000003566895
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072311-0021-0000-0000-000021AA5304
Message-Id: <3632093.Zdehkhkgl2@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230114
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, July 23, 2019 3:08:57 PM IST Chandan Rajendra wrote:
> On Wednesday, June 26, 2019 2:28:00 PM IST kernel test robot wrote:

Adding Ted and Eric on TO list explicitly ...

> 
> Hi Ted & Eric,
> 
> The subpage encryption patchset assumes that bio->bi_private and
> bh->b_private is set to NULL when reading data for non-encrypted regular
> files. However, there are instances that have come up where this
> assumption does not hold good.
> 
> 1. In Btrfs, write_dev_supers() sets bh->b_private to 'struct
>    btrfs_device' pointer and submits the buffer head for a write
>    operation.
>    1. In the btrfs/146 test, the write operation fails and hence the
>       kernel clears the BH_Uptodate flag.
>    2. A read operation initiated later will submit the buffer head to
>       the block layer. During endio processing, "read callbacks" state
>       machine is initiated because bh->b_private is set to a non-NULL
>       value.
>    3. This results in the following call trace,
>       ,----
>       | [  255.588689] BUG: unable to handle page fault for address: ffffffffb5f7e399
>       | [  255.591659] #PF: supervisor read access in kernel mode
>       | [  255.593967] #PF: error_code(0x0000) - not-present page
>       | [  255.596113] PGD 465026067 P4D 465026067 PUD 465027063 PMD 0
>       | [  255.598007] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>       | [  255.599646] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 5.2.0-rc2-00023-gb98a16901
>       | [  255.602229] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-4
>       | [  255.604998] RIP: 0010:read_callbacks+0xf0/0x190
>       | [  255.606479] Code: e0 04 49 03 47 58 45 85 f6 75 87 8b 50 0c 44 89 e9 89 d3 81 eb
>       | [  255.612608] RSP: 0018:ffff941343338e70 EFLAGS: 00010286
>       | [  255.614316] RAX: 0000000000000329 RBX: ffffffffb5f7e391 RCX: 0000000000000329
>       | [  255.616678] RDX: 000000009396fc38 RSI: 0000000000000001 RDI: ffff8cd792e16f98
>       | [  255.619030] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>       | [  255.621350] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8cd79396fbd8
>       | [  255.623725] R13: 0000000000001000 R14: 0000000000000329 R15: ffff8cd78fa507c0
>       | [  255.626046] FS:  0000000000000000(0000) GS:ffff8cd79dc00000(0000) knlGS:00000000
>       | [  255.628740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>       | [  255.630632] CR2: ffffffffb5f7e399 CR3: 0000000615f3a000 CR4: 00000000000006e0
>       | [  255.633004] Call Trace:
>       | [  255.633839]  <IRQ>
>       | [  255.634531]  read_callbacks_end_bh+0x1b/0x40
>       | [  255.635963]  __end_buffer_async_read+0x18/0x60
>       | [  255.637454]  end_bio_bh_io_sync+0x26/0x40
>       | [  255.638803]  clone_endio+0x90/0x180
>       | [  255.639989]  blk_update_request+0x8f/0x360
>       | [  255.641340]  blk_mq_end_request+0x1a/0x120
>       | [  255.642685]  blk_done_softirq+0x8d/0xc0
>       | [  255.644098]  __do_softirq+0xcc/0x3fe
>       | [  255.645029]  irq_exit+0xbb/0xc0
>       | [  255.645755]  call_function_single_interrupt+0xf/0x20
>       | [  255.646896]  </IRQ>
>       `----
> 
> 2. Another instance is when a metadata block with BH_Uptodate set and
>    also part of the in-memory JBD list undergoes the following,
>    1. A sync() syscall is invoked by the userspace and the write
>       operation on the metadata block is initiated.
>    2. Due to an I/O failure, the BH_Uptodate flag is cleared by
>       end_buffer_async_write(). The bh->b_private member would be
>       pointing to a journal head structure.
>    3. In such a case, a read opertion invoked on the block mapped by the buffer
>       head will initiate a read from the disk since the buffer head is
>       missing the BH_Uptodate flag. E.g. On my test machine, I see the
>       following,
>       ,----
>       | probe-bcache 5185 [008] 230.484959: probe:submit_bh: (ffffffffb845c180) b_private=0xffff8b6b3e1fc008 b_bdev=0xffff8b701c41e1c0 b_state=2279596 bh_x64=0xffff8b6b3a8b86e8 op_u32=0
>       | 		    ffffffffb845c181 submit_bh+0x1
>       | ([kernel.kallsyms]) ffffffffb845a6fc block_read_full_page+0x29c
>       | ([kernel.kallsyms]) ffffffffb845d9c5 blkdev_readpage+0x25
>       | ([kernel.kallsyms]) ffffffffb83a1e84 generic_file_read_iter+0x684
>       | ([kernel.kallsyms]) ffffffffb8415679 new_sync_read+0x109
>       | ([kernel.kallsyms]) ffffffffb841807c vfs_read+0x8c
>       | ([kernel.kallsyms]) ffffffffb84185f4 ksys_pread64+0x74
>       | ([kernel.kallsyms]) ffffffffb8202720 do_syscall_64+0x50
>       | ([kernel.kallsyms]) ffffffffb9000081 entry_SYSCALL_64_after_hwframe+0x49
>       | ([kernel.kallsyms]) 7f2512ae0637
>       | __libc_pread+0x17 (/lib/x86_64-linux-gnu/libc-2.27.so) 7ffd65bb6e4d
>       | [unknown] ([unknown])
>       `----
> 
>    4. After the read I/O request is submitted, end_buffer_async_read()
>       will find a non-NULL value at bh->b_private. Due to the non-NULL
>       bh->b_private value, this function initiates "read callbacks"
>       state machine.
>    This scenario was seen when executing generic/475 test case.
> 
> The first case can be handled by setting a NULL value to the bh->b_private
> member in the write operation's endio function. However I don't see a method
> to disassociate the journal head from the buffer head for the second case
> described above.
> 
> Hence I propose that we introduce new flags (one each for bio and
> buffer_head structures) to track if the payload needs further processing
> (e.g. decryption). Please let me know your thoughts on this.
> 
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: 402b1b327a0b0e8fd23d5866b9585ccc2380f199 ("Add decryption support for sub-pagesized blocks")
> > https://git.kernel.org/cgit/linux/kernel/git/ebiggers/linux.git wip-subpage-encryption
> > 
> > in testcase: xfstests
> > with following parameters:
> > 
> > 	disk: 6HDD
> > 	fs: btrfs
> > 	test: btrfs-group1
> > 
> > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +-------------------------------------------------------+------------+------------+
> > |                                                       | 31d0610be3 | 402b1b327a |
> > +-------------------------------------------------------+------------+------------+
> > | boot_successes                                        | 1          | 0          |
> > | boot_failures                                         | 43         | 40         |
> > | BUG:kernel_reboot-without-warning_in_test_stage       | 41         | 31         |
> > | BUG:kernel_NULL_pointer_dereference,address           | 2          | 2          |
> > | Oops:#[##]                                            | 2          | 7          |
> > | RIP:raid#_sse21_gen_syndrome[raid#_pq]                | 2          | 2          |
> > | Kernel_panic-not_syncing:Fatal_exception              | 2          | 2          |
> > | BUG:unable_to_handle_page_fault_for_address           | 0          | 5          |
> > | RIP:read_callbacks                                    | 0          | 5          |
> > | RIP:native_safe_halt                                  | 0          | 5          |
> > | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 5          |
> > | BUG:soft_lockup-CPU##stuck_for#s                      | 0          | 1          |
> > | RIP:__do_softirq                                      | 0          | 1          |
> > | RIP:clear_page_rep                                    | 0          | 1          |
> > | Kernel_panic-not_syncing:softlockup:hung_tasks        | 0          | 1          |
> > | BUG:kernel_hang_in_boot_stage                         | 0          | 1          |
> > +-------------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > [ 1439.695830] BUG: unable to handle page fault for address: 0000000003fffe53
> > [ 1439.702109] #PF: supervisor read access in kernel mode
> > [ 1439.705572] #PF: error_code(0x0000) - not-present page
> > [ 1439.709289] PGD 0 P4D 0 
> > [ 1439.711570] Oops: 0000 [#1] SMP PTI
> > [ 1439.714095] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.2.0-rc2-00022-g402b1b3 #1
> > [ 1439.717917] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [ 1439.722137] RIP: 0010:read_callbacks+0x102/0x170
> > [ 1439.725031] Code: 48 c1 e3 06 48 03 18 eb 80 48 8b 35 a8 9c dd 01 4c 89 e7 e8 20 2c f0 ff 4c 89 ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 be 8b 12 00 <48> 8b 53 08 48 8d 42 ff 83 e2 01 48 0f 44 c3 f0 80 20 fb f0 80 4b
> > [ 1439.733926] RSP: 0018:ffffb279c06cce58 EFLAGS: 00010282
> > [ 1439.736950] RAX: 0000000000000598 RBX: 0000000003fffe4b RCX: 0000000000000598
> > [ 1439.740608] RDX: 00000000bd464770 RSI: 0000000000000001 RDI: ffff9a68bae02c00
> > [ 1439.744285] RBP: 0000000000000000 R08: 0000000000033850 R09: ffffffffc04738dd
> > [ 1439.747933] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9a68bd6d0a20
> > [ 1439.751612] R13: 0000000000001000 R14: 0000000000000598 R15: ffff9a68bfcf5498
> > [ 1439.755564] FS:  0000000000000000(0000) GS:ffff9a697fd00000(0000) knlGS:0000000000000000
> > [ 1439.761896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1439.769318] CR2: 0000000003fffe53 CR3: 000000007c628000 CR4: 00000000000406e0
> > [ 1439.777936] Call Trace:
> > [ 1439.788378]  <IRQ>
> > [ 1439.790308]  read_callbacks_end_bh+0x1b/0x40
> > [ 1439.793087]  __end_buffer_async_read+0x18/0x60
> > [ 1439.795949]  end_bio_bh_io_sync+0x26/0x40
> > [ 1439.798726]  clone_endio+0x90/0x180 [dm_mod]
> > [ 1439.801543]  blk_update_request+0x78/0x300
> > [ 1439.804197]  blk_mq_end_request+0x1a/0x120
> > [ 1439.806903]  blk_done_softirq+0xa1/0xd0
> > [ 1439.809404]  __do_softirq+0xe3/0x311
> > [ 1439.811862]  irq_exit+0xdd/0xf0
> > [ 1439.814164]  call_function_single_interrupt+0xf/0x20
> > [ 1439.817082]  </IRQ>
> > [ 1439.819030] RIP: 0010:native_safe_halt+0xe/0x10
> > [ 1439.821795] Code: eb bd 90 90 90 90 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 56 de 5a 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 46 de 5a 00 fb f4 <c3> 90 66 66 66 66 90 41 55 41 54 55 53 e8 f0 03 6c ff 65 8b 2d 19
> > [ 1439.830746] RSP: 0018:ffffb279c0697eb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
> > [ 1439.834651] RAX: ffffffffbc85c1d0 RBX: 0000000000000001 RCX: 0000000000000000
> > [ 1439.838373] RDX: 0000000000000001 RSI: 0000000000000087 RDI: 0000000000000001
> > [ 1439.842157] RBP: 0000000000000001 R08: 000002a24abd49ba R09: ffff9a697ffd3328
> > [ 1439.845956] R10: 0000000000000000 R11: 0000000000000b20 R12: 0000000000000000
> > [ 1439.849750] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [ 1439.853563]  ? __sched_text_end+0x7/0x7
> > [ 1439.856261]  default_idle+0x1c/0x160
> > [ 1439.858875]  do_idle+0x1c4/0x280
> > [ 1439.861363]  cpu_startup_entry+0x19/0x20
> > [ 1439.864171]  start_secondary+0x184/0x1d0
> > [ 1439.867043]  secondary_startup_64+0xb6/0xc0
> > [ 1439.869803] Modules linked in: ext4 mbcache jbd2 btrfs xor zstd_decompress zstd_compress raid6_pq libcrc32c dm_flakey dm_mod sr_mod cdrom sg ata_generic pata_acpi bochs_drm ttm crct10dif_pclmul crc32_pclmul drm_kms_helper crc32c_intel ghash_clmulni_intel ppdev snd_pcm syscopyarea snd_timer sysfillrect sysimgblt snd fb_sys_fops drm aesni_intel crypto_simd ata_piix soundcore cryptd glue_helper joydev pcspkr serio_raw libata parport_pc i2c_piix4 parport floppy ip_tables [last unloaded: xor]
> > [ 1439.890150] CR2: 0000000003fffe53
> > [ 1439.892797] ---[ end trace 762467852b11b149 ]---
> > 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.2.0-rc2-00022-g402b1b3 .config
> > 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> > 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> > 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> > 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> > 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> > 
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> > 	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> > 
> > 
> > 
> > 
> > Thanks,
> > Rong Chen
> > 
> > 
> 
> 
> 


-- 
chandan



