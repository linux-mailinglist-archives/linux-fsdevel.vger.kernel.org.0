Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5036DFED0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 21:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDLTig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDLTif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:38:35 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8EF1FE9;
        Wed, 12 Apr 2023 12:38:30 -0700 (PDT)
Received: from [192.168.1.190] (ip5b426bea.dynamic.kabel-deutschland.de [91.66.107.234])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C628860027FEB;
        Wed, 12 Apr 2023 21:38:25 +0200 (CEST)
Message-ID: <cb0cc2f1-48cb-8b15-35af-33a31ccc922c@molgen.mpg.de>
Date:   Wed, 12 Apr 2023 21:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-4-sergei.shtepa@veeam.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <20230404140835.25166-4-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think, you can trigger all kind of user-after-free when userspace deletes a snapshot image or the snapshot image and the tracker while the disk device snapshot image is kept alive (mounted or just opened) and doing I/O.

Here is what I did to provoke that:

root@dose:~# s=$(blksnap snapshot_create -d /dev/vdb)
root@dose:~# blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
device path: '/dev/block/253:2'
allocate range: ofs=11264624 cnt=2097152
root@dose:~# blksnap snapshot_take -i $s
root@dose:~# mount /dev/blksnap-image_253\:16 /mnt
root@dose:~# dd if=/dev/zero of=/mnt/x.x &
[1] 2514
root@dose:~# blksnap snapshot_destroy -i $s
dd: writing to '/mnt/x.x': No space left on device
1996041+0 records in
1996040+0 records out
1021972480 bytes (1.0 GB, 975 MiB) copied, 8.48923 s, 120 MB/s
[1]+  Exit 1                  dd if=/dev/zero of=/mnt/x.x

And here's the UAF:

[ 4508.526091] [2475] diff_storage_event_low:64: blksnap-diff-storage: Diff storage low free space. Portion: 2097152 sectors, requested: 2097152
[ 4508.526141] [2475] event_gen:44: blksnap-event_queue: Generate event: time=4507748140846 code=0 data_size=8
[ 4508.526158] blksnap-snapshot: Snapshot aa986b45-bf07-46f7-a52d-8d7829221f24 was created
[ 4512.731380] [2478] ioctl_snapshot_append_storage:195: blksnap: Append difference storage
[ 4512.731417] [2478] diff_storage_append_block:223: blksnap-diff-storage: Append 1 blocks
[ 4512.731485] [2478] diff_storage_add_range:193: blksnap-diff-storage: Add range to diff storage: [253:2] 11264624:2097152
[ 4512.780757] [2481] diff_area_new:180: blksnap-diff-area: Open device [253:16]
[ 4512.780786] [2481] diff_area_calculate_chunk_size:57: blksnap-diff-area: Minimal IO block 1 sectors
[ 4512.780794] [2481] diff_area_calculate_chunk_size:58: blksnap-diff-area: Device capacity 2097152 sectors
[ 4512.780801] [2481] diff_area_calculate_chunk_size:61: blksnap-diff-area: Chunks count 4096
[ 4512.780808] [2481] diff_area_calculate_chunk_size:76: blksnap-diff-area: The optimal chunk size was calculated as 262144 bytes for device [253:16]
[ 4512.780817] [2481] diff_area_new:200: blksnap-diff-area: Chunk size 262144 in bytes
[ 4512.780824] [2481] diff_area_new:201: blksnap-diff-area: Chunk count 4096
[ 4512.828814] [2481] snapshot_take_trackers:250: blksnap-snapshot: Device [253:16] was frozen
[ 4512.834029] [2481] cbt_map_switch:142: blksnap-cbt_map: CBT map switch
[ 4512.834051] [2481] snapshot_take_trackers:277: blksnap-snapshot: Device [253:16] was unfrozen
[ 4512.834058] blksnap-image: Create snapshot image device for original device [253:16]
[ 4512.835437] [2481] snapimage_create:97: blksnap-image: Snapshot image disk name [blksnap-image_253:16]
[ 4512.838499] [2481] snapimage_create:112: blksnap-image: Image block device [259:1] has been created
[ 4512.838508] blksnap-snapshot: Snapshot aa986b45-bf07-46f7-a52d-8d7829221f24 was taken successfully
[ 4525.592286] XFS (blksnap-image_253:16): Mounting V5 Filesystem 35f0c7a2-27fa-4183-8ede-7462ac31a97d
[ 4525.619281] XFS (blksnap-image_253:16): Ending clean mount
[ 4558.292030] clocksource: timekeeping watchdog on CPU10: hpet retried 2 times before success
[ 4558.486074] blksnap-snapshot: Destroy snapshot aa986b45-bf07-46f7-a52d-8d7829221f24
[ 4558.488731] blksnap-snapshot: Release snapshot aa986b45-bf07-46f7-a52d-8d7829221f24
[ 4558.505931] [2527] tracker_release_snapshot:293: blksnap-tracker: Tracker for device [253:16] release snapshot
[ 4558.505959] [2527] snapimage_free:63: blksnap-image: Snapshot image disk blksnap-image_253:16 delete
[ 4558.548358] [1899] diff_storage_event_low:64: blksnap-diff-storage: Diff storage low free space. Portion: 2097152 sectors, requested: 4194304
[ 4558.548378] [1899] event_gen:44: blksnap-event_queue: Generate event: time=4557770519985 code=0 data_size=8
[ 4561.444548] ==================================================================
[ 4561.446224] BUG: KASAN: slab-use-after-free in chunk_notify_store+0x40/0x190 [blksnap]
[ 4561.448018] Read of size 8 at addr ffff888112d21500 by task kworker/13:0/1504

[ 4561.449965] CPU: 13 PID: 1504 Comm: kworker/13:0 Not tainted 6.3.0-rc5.mx64.428-00094-g21dc08a94f59 #40
[ 4561.452025] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[ 4561.454538] Workqueue: events chunk_notify_store [blksnap]
[ 4561.455809] Call Trace:
[ 4561.456393]  <TASK>
[ 4561.456915]  dump_stack_lvl+0x37/0x50
[ 4561.457807]  print_report+0xcc/0x630
[ 4561.458650]  ? __virt_addr_valid+0xf5/0x180
[ 4561.459607]  ? chunk_notify_store+0x40/0x190 [blksnap]
[ 4561.460785]  kasan_report+0xb2/0xe0
[ 4561.468472]  ? chunk_notify_store+0x40/0x190 [blksnap]
[ 4561.476365]  chunk_notify_store+0x40/0x190 [blksnap]
[ 4561.483755]  process_one_work+0x407/0x790
[ 4561.490118]  worker_thread+0x2ab/0x700
[ 4561.495707]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[ 4561.500883]  ? __pfx_worker_thread+0x10/0x10
[ 4561.505664]  kthread+0x15d/0x190
[ 4561.509864]  ? __pfx_kthread+0x10/0x10
[ 4561.513824]  ret_from_fork+0x2c/0x50
[ 4561.517546]  </TASK>

[ 4561.524020] Allocated by task 2481:
[ 4561.527147]  kasan_save_stack+0x22/0x50
[ 4561.530226]  kasan_set_track+0x25/0x30
[ 4561.533096]  __kasan_kmalloc+0x80/0x90
[ 4561.535868]  chunk_alloc+0x37/0xf0 [blksnap]
[ 4561.538569]  diff_area_new+0x42d/0x690 [blksnap]
[ 4561.541251]  snapshot_take+0x13b/0x530 [blksnap]
[ 4561.543853]  ioctl_snapshot_take+0x7a/0xc0 [blksnap]
[ 4561.546394]  ctrl_unlocked_ioctl+0x3a/0x60 [blksnap]
[ 4561.548898]  __x64_sys_ioctl+0xc6/0xe0
[ 4561.551276]  do_syscall_64+0x47/0xa0
[ 4561.553621]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[ 4561.558154] Freed by task 2527:
[ 4561.560350]  kasan_save_stack+0x22/0x50
[ 4561.562569]  kasan_set_track+0x25/0x30
[ 4561.564788]  kasan_save_free_info+0x2b/0x50
[ 4561.567012]  ____kasan_slab_free+0xf9/0x1a0
[ 4561.569210]  __kmem_cache_free+0x141/0x200
[ 4561.571370]  diff_area_free+0xab/0x150 [blksnap]
[ 4561.573546]  tracker_release_snapshot+0xc8/0x110 [blksnap]
[ 4561.575763]  snapshot_free+0x9f/0x170 [blksnap]
[ 4561.577882]  snapshot_destroy+0x119/0x170 [blksnap]
[ 4561.579992]  ioctl_snapshot_destroy+0x7a/0xc0 [blksnap]
[ 4561.582155]  ctrl_unlocked_ioctl+0x3a/0x60 [blksnap]
[ 4561.584270]  __x64_sys_ioctl+0xc6/0xe0
[ 4561.586247]  do_syscall_64+0x47/0xa0
[ 4561.588176]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[ 4561.591915] Last potentially related work creation:
[ 4561.593833]  kasan_save_stack+0x22/0x50
[ 4561.595611]  __kasan_record_aux_stack+0x60/0x70
[ 4561.597442]  kvfree_call_rcu+0x2e/0x460
[ 4561.599235]  cache_clean+0x46d/0x500 [sunrpc]
[ 4561.601181]  cache_flush+0x15/0x40 [sunrpc]
[ 4561.603096]  ip_map_parse+0x2ca/0x300 [sunrpc]
[ 4561.605035]  cache_do_downcall+0x59/0x90 [sunrpc]
[ 4561.606993]  cache_write_procfs+0x90/0xd0 [sunrpc]
[ 4561.608946]  proc_reg_write+0xe0/0x140
[ 4561.610728]  vfs_write+0x186/0x680
[ 4561.612465]  ksys_write+0xbd/0x160
[ 4561.614186]  do_syscall_64+0x47/0xa0
[ 4561.615922]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[ 4561.619340] The buggy address belongs to the object at ffff888112d21500
                 which belongs to the cache kmalloc-96 of size 96
[ 4561.623265] The buggy address is located 0 bytes inside of
                 freed 96-byte region [ffff888112d21500, ffff888112d21560)

[ 4561.628960] The buggy address belongs to the physical page:
[ 4561.631000] page:00000000b32dc240 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x112d21
[ 4561.633393] flags: 0x17fffc000000200(slab|node=0|zone=2|lastcpupid=0x1ffff)
[ 4561.635646] raw: 017fffc000000200 ffff888100040300 ffffea0004317ed0 ffffea000406a350
[ 4561.637982] raw: 0000000000000000 ffff888112d21000 0000000100000020 0000000000000000
[ 4561.640338] page dumped because: kasan: bad access detected

[ 4561.644448] Memory state around the buggy address:
[ 4561.646610]  ffff888112d21400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[ 4561.649000]  ffff888112d21480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[ 4561.651367] >ffff888112d21500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[ 4561.653709]                    ^
[ 4561.655754]  ffff888112d21580: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[ 4561.658132]  ffff888112d21600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[ 4561.660503] ==================================================================
[ 4561.662931] Disabling lock debugging due to kernel taint
[ 4561.665449] general protection fault, probably for non-canonical address 0x79a00c8000009df: 0000 [#1] PREEMPT SMP KASAN PTI
[ 4561.668387] CPU: 13 PID: 1504 Comm: kworker/13:0 Tainted: G    B              6.3.0-rc5.mx64.428-00094-g21dc08a94f59 #40
[ 4561.671243] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[ 4561.674216] Workqueue: events chunk_notify_store [blksnap]
[ 4561.676778] RIP: 0010:chunk_notify_store+0x66/0x190 [blksnap]
[ 4561.679365] Code: d0 f5 90 e0 4c 8b 75 00 48 8d 7d 08 e8 c3 f5 90 e0 4c 8b 65 08 49 8d 7e 08 e8 66 f6 90 e0 4d 89 66 08 4c 89 e7 e8 5a f6 90 e0 <4d> 89 34 24 48 89 ef 4c 8d 73 68 e8 4a f6 90 e0 48 89 6d 00 48 89
[ 4561.685274] RSP: 0000:ffff88810e49fdd0 EFLAGS: 00010282
[ 4561.687972] RAX: 0000000000000000 RBX: ffff888181be3300 RCX: ffffffffa0b98f56
[ 4561.690821] RDX: 0000000000000001 RSI: 0000000000000008 RDI: 079a00c8000009df
[ 4561.693676] RBP: ffff888112d21500 R08: 0000000000000001 R09: ffffffff84286a47
[ 4561.696550] R10: fffffbfff0850d48 R11: 0000000000000001 R12: 079a00c8000009df
[ 4561.699418] R13: ffff888181be3320 R14: ffff88817f708800 R15: ffff888181be3308
[ 4561.702307] FS:  0000000000000000(0000) GS:ffff888261c80000(0000) knlGS:0000000000000000
[ 4561.705292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4561.708105] CR2: 00007f7189264c58 CR3: 0000000111dec001 CR4: 0000000000170ee0
[ 4561.711052] Call Trace:
[ 4561.713647]  <TASK>
[ 4561.716196]  process_one_work+0x407/0x790
[ 4561.718912]  worker_thread+0x2ab/0x700
[ 4561.721597]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[ 4561.724372]  ? __pfx_worker_thread+0x10/0x10
[ 4561.727101]  kthread+0x15d/0x190
[ 4561.729745]  ? __pfx_kthread+0x10/0x10
[ 4561.732418]  ret_from_fork+0x2c/0x50
[ 4561.735097]  </TASK>
[ 4561.737655] Modules linked in: blksnap rpcsec_gss_krb5 nfsv4 nfs 8021q garp stp mrp llc bochs kvm_intel drm_vram_helper drm_ttm_helper ttm kvm drm_kms_helper input_leds led_class drm virtio_net irqbypass syscopyarea net_failover sysfillrect intel_agp crc32c_intel failover floppy sysimgblt intel_gtt i2c_piix4 nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc ip_tables x_tables unix ipv6 autofs4
[ 4561.748159] ---[ end trace 0000000000000000 ]---
[ 4561.751205] RIP: 0010:chunk_notify_store+0x66/0x190 [blksnap]
[ 4561.754393] Code: d0 f5 90 e0 4c 8b 75 00 48 8d 7d 08 e8 c3 f5 90 e0 4c 8b 65 08 49 8d 7e 08 e8 66 f6 90 e0 4d 89 66 08 4c 89 e7 e8 5a f6 90 e0 <4d> 89 34 24 48 89 ef 4c 8d 73 68 e8 4a f6 90 e0 48 89 6d 00 48 89
[ 4561.761441] RSP: 0000:ffff88810e49fdd0 EFLAGS: 00010282
[ 4561.764695] RAX: 0000000000000000 RBX: ffff888181be3300 RCX: ffffffffa0b98f56
[ 4561.768108] RDX: 0000000000000001 RSI: 0000000000000008 RDI: 079a00c8000009df
[ 4561.771488] RBP: ffff888112d21500 R08: 0000000000000001 R09: ffffffff84286a47
[ 4561.774845] R10: fffffbfff0850d48 R11: 0000000000000001 R12: 079a00c8000009df
[ 4561.778140] R13: ffff888181be3320 R14: ffff88817f708800 R15: ffff888181be3308
[ 4561.781476] FS:  0000000000000000(0000) GS:ffff888261c80000(0000) knlGS:0000000000000000
[ 4561.784909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4561.788164] CR2: 00007f7189264c58 CR3: 0000000111dec001 CR4: 0000000000170ee0
[ 4586.218197] XFS (blksnap-image_253:16): log I/O error -5
[ 4586.218889] XFS (blksnap-image_253:16): metadata I/O error in "xfs_buf_ioend+0x3ea/0xb50" at daddr 0x1 len 1 error 5
[ 4586.225814] XFS (blksnap-image_253:16): Filesystem has been shut down due to log error (0x2).
[ 4586.246191] XFS (blksnap-image_253:16): Please unmount the filesystem and rectify the problem(s).


I was actually targeting this deref in snapimage.c:

     +static void snapimage_submit_bio(struct bio *bio)
     +{
     +	struct tracker *tracker = bio->bi_bdev->bd_disk->private_data;
     +	struct diff_area *diff_area = tracker->diff_area;

but didn't even get to delete the tracker...


Best

   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
