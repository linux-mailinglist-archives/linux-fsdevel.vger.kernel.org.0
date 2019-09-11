Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C13B004F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfIKPji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:39:38 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:14275 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728552AbfIKPjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:39:37 -0400
Received: (qmail 27193 invoked from network); 11 Sep 2019 17:39:30 +0200
X-Fcrdns: Yes
Received: from tmo-114-72.customers.d1-online.com (HELO [10.17.207.201]) (80.187.114.72)
  (smtp-auth username s.priebe@profihost.ag, mechanism plain)
  by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Wed, 11 Sep 2019 17:39:30 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: 5.3-rc-8 hung task in IO (was: Re: lot of MemAvailable but falling cache and raising PSI)
From:   Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <CAL3q7H5GZPoXTBqGtU8g9cEuxjbn4F0E80cZ9SW_GOyFSiTeoQ@mail.gmail.com>
Date:   Wed, 11 Sep 2019 17:39:28 +0200
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, l.roehrs@profihost.ag,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6F49D228-4B9B-409E-9D9D-6D24F80CED8C@profihost.ag>
References: <132e1fd0-c392-c158-8f3a-20e340e542f0@profihost.ag> <20190910090241.GM2063@dhcp22.suse.cz> <743a047e-a46f-32fa-1fe4-a9bd8f09ed87@profihost.ag> <20190910110741.GR2063@dhcp22.suse.cz> <364d4c2e-9c9a-d8b3-43a8-aa17cccae9c7@profihost.ag> <20190910125756.GB2063@dhcp22.suse.cz> <d7448f13-899a-5805-bd36-8922fa17b8a9@profihost.ag> <b1fe902f-fce6-1aa9-f371-ceffdad85968@profihost.ag> <20190910132418.GC2063@dhcp22.suse.cz> <d07620d9-4967-40fe-fa0f-be51f2459dc5@profihost.ag> <20190911070951.GL4023@dhcp22.suse.cz> <CAL3q7H5GZPoXTBqGtU8g9cEuxjbn4F0E80cZ9SW_GOyFSiTeoQ@mail.gmail.com>
To:     Filipe Manana <fdmanana@kernel.org>
X-User-Auth: Auth by s.priebe@profihost.ag through 80.187.114.72
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks! Is this the same as for the 5.3-rc8 I tested? Stacktrace looked different to me.

Stefan

> Am 11.09.2019 um 16:56 schrieb Filipe Manana <fdmanana@kernel.org>:
> 
>> On Wed, Sep 11, 2019 at 8:10 AM Michal Hocko <mhocko@kernel.org> wrote:
>> 
>> This smells like IO/Btrfs issue to me. Cc some more people.
>> 
>>> On Wed 11-09-19 08:12:28, Stefan Priebe - Profihost AG wrote:
>>> [...]
>>> Sadly i'm running into issues with btrfs on 5.3-rc8 - the rsync process
>>> on backup disk completely hangs / is blocked at 100% i/o:
>>> [54739.065906] INFO: task rsync:9830 blocked for more than 120 seconds.
>>> [54739.066973]       Not tainted 5.3.0-rc8 #1
>>> [54739.067988] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [54739.069065] rsync           D    0  9830   9829 0x00004002
>>> [54739.070146] Call Trace:
>>> [54739.071183]  ? __schedule+0x3cf/0x680
>>> [54739.072202]  ? bit_wait+0x50/0x50
>>> [54739.073196]  schedule+0x39/0xa0
>>> [54739.074213]  io_schedule+0x12/0x40
>>> [54739.075219]  bit_wait_io+0xd/0x50
>>> [54739.076227]  __wait_on_bit+0x66/0x90
>>> [54739.077239]  ? bit_wait+0x50/0x50
>>> [54739.078273]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [54739.078741]  ? init_wait_var_entry+0x40/0x40
>>> [54739.079162]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [54739.079557]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [54739.079956]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [54739.080357]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [54739.080748]  do_writepages+0x1a/0x60
>>> [54739.081140]  __filemap_fdatawrite_range+0xc8/0x100
>>> [54739.081558]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [54739.081985]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [54739.082412]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [54739.082847]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [54739.083280]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [54739.083725]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [54739.084170]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [54739.084608]  ? retarget_shared_pending+0x70/0x70
>>> [54739.085049]  do_fsync+0x38/0x60
>>> [54739.085494]  __x64_sys_fdatasync+0x13/0x20
>>> [54739.085944]  do_syscall_64+0x55/0x1a0
>>> [54739.086395]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [54739.086850] RIP: 0033:0x7f1db3fc85f0
>>> [54739.087310] Code: Bad RIP value.
> 
> It's a regression introduced in 5.2
> Fix just sent: https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
> 
> Thanks.
> 
>>> [54739.087772] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [54739.088249] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [54739.088733] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [54739.089234] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [54739.089722] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [54739.090205] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [54859.899715] INFO: task rsync:9830 blocked for more than 241 seconds.
>>> [54859.900863]       Not tainted 5.3.0-rc8 #1
>>> [54859.901885] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [54859.902909] rsync           D    0  9830   9829 0x00004002
>>> [54859.903930] Call Trace:
>>> [54859.904888]  ? __schedule+0x3cf/0x680
>>> [54859.905831]  ? bit_wait+0x50/0x50
>>> [54859.906751]  schedule+0x39/0xa0
>>> [54859.907653]  io_schedule+0x12/0x40
>>> [54859.908535]  bit_wait_io+0xd/0x50
>>> [54859.909441]  __wait_on_bit+0x66/0x90
>>> [54859.910306]  ? bit_wait+0x50/0x50
>>> [54859.911177]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [54859.912043]  ? init_wait_var_entry+0x40/0x40
>>> [54859.912727]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [54859.913113]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [54859.913501]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [54859.913894]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [54859.914276]  do_writepages+0x1a/0x60
>>> [54859.914656]  __filemap_fdatawrite_range+0xc8/0x100
>>> [54859.915052]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [54859.915449]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [54859.915855]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [54859.916256]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [54859.916658]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [54859.917078]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [54859.917497]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [54859.917903]  ? retarget_shared_pending+0x70/0x70
>>> [54859.918307]  do_fsync+0x38/0x60
>>> [54859.918707]  __x64_sys_fdatasync+0x13/0x20
>>> [54859.919106]  do_syscall_64+0x55/0x1a0
>>> [54859.919482]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [54859.919866] RIP: 0033:0x7f1db3fc85f0
>>> [54859.920243] Code: Bad RIP value.
>>> [54859.920614] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [54859.920997] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [54859.921383] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [54859.921773] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [54859.922165] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [54859.922551] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [54980.733463] INFO: task rsync:9830 blocked for more than 362 seconds.
>>> [54980.734061]       Not tainted 5.3.0-rc8 #1
>>> [54980.734619] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [54980.735209] rsync           D    0  9830   9829 0x00004002
>>> [54980.735802] Call Trace:
>>> [54980.736473]  ? __schedule+0x3cf/0x680
>>> [54980.737054]  ? bit_wait+0x50/0x50
>>> [54980.737664]  schedule+0x39/0xa0
>>> [54980.738243]  io_schedule+0x12/0x40
>>> [54980.738712]  bit_wait_io+0xd/0x50
>>> [54980.739171]  __wait_on_bit+0x66/0x90
>>> [54980.739623]  ? bit_wait+0x50/0x50
>>> [54980.740073]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [54980.740548]  ? init_wait_var_entry+0x40/0x40
>>> [54980.741033]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [54980.741579]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [54980.742076]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [54980.742560]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [54980.743045]  do_writepages+0x1a/0x60
>>> [54980.743516]  __filemap_fdatawrite_range+0xc8/0x100
>>> [54980.744019]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [54980.744513]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [54980.745026]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [54980.745563]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [54980.746073]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [54980.746575]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [54980.747074]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [54980.747575]  ? retarget_shared_pending+0x70/0x70
>>> [54980.748059]  do_fsync+0x38/0x60
>>> [54980.748539]  __x64_sys_fdatasync+0x13/0x20
>>> [54980.749012]  do_syscall_64+0x55/0x1a0
>>> [54980.749512]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [54980.749995] RIP: 0033:0x7f1db3fc85f0
>>> [54980.750368] Code: Bad RIP value.
>>> [54980.750735] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [54980.751117] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [54980.751505] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [54980.751895] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [54980.752291] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [54980.752680] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55101.567251] INFO: task rsync:9830 blocked for more than 483 seconds.
>>> [55101.567775]       Not tainted 5.3.0-rc8 #1
>>> [55101.568218] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55101.568649] rsync           D    0  9830   9829 0x00004002
>>> [55101.569101] Call Trace:
>>> [55101.569609]  ? __schedule+0x3cf/0x680
>>> [55101.570052]  ? bit_wait+0x50/0x50
>>> [55101.570504]  schedule+0x39/0xa0
>>> [55101.570938]  io_schedule+0x12/0x40
>>> [55101.571404]  bit_wait_io+0xd/0x50
>>> [55101.571934]  __wait_on_bit+0x66/0x90
>>> [55101.572601]  ? bit_wait+0x50/0x50
>>> [55101.573235]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55101.573599]  ? init_wait_var_entry+0x40/0x40
>>> [55101.574008]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55101.574394]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55101.574783]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55101.575184]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55101.575580]  do_writepages+0x1a/0x60
>>> [55101.575959]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55101.576351]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55101.576746]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55101.577144]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55101.577543]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55101.577939]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55101.578343]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55101.578746]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55101.579139]  ? retarget_shared_pending+0x70/0x70
>>> [55101.579543]  do_fsync+0x38/0x60
>>> [55101.579928]  __x64_sys_fdatasync+0x13/0x20
>>> [55101.580312]  do_syscall_64+0x55/0x1a0
>>> [55101.580706]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55101.581086] RIP: 0033:0x7f1db3fc85f0
>>> [55101.581463] Code: Bad RIP value.
>>> [55101.581834] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55101.582219] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55101.582607] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55101.582998] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55101.583397] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55101.583784] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55222.405056] INFO: task rsync:9830 blocked for more than 604 seconds.
>>> [55222.405773]       Not tainted 5.3.0-rc8 #1
>>> [55222.406456] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55222.407158] rsync           D    0  9830   9829 0x00004002
>>> [55222.407776] Call Trace:
>>> [55222.408450]  ? __schedule+0x3cf/0x680
>>> [55222.409206]  ? bit_wait+0x50/0x50
>>> [55222.409942]  schedule+0x39/0xa0
>>> [55222.410658]  io_schedule+0x12/0x40
>>> [55222.411346]  bit_wait_io+0xd/0x50
>>> [55222.411946]  __wait_on_bit+0x66/0x90
>>> [55222.412572]  ? bit_wait+0x50/0x50
>>> [55222.413249]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55222.413944]  ? init_wait_var_entry+0x40/0x40
>>> [55222.414675]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55222.415362]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55222.416085]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55222.416796]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55222.417505]  do_writepages+0x1a/0x60
>>> [55222.418243]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55222.418969]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55222.419713]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55222.420453]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55222.421206]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55222.421925]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55222.422656]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55222.423400]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55222.424140]  ? retarget_shared_pending+0x70/0x70
>>> [55222.424861]  do_fsync+0x38/0x60
>>> [55222.425581]  __x64_sys_fdatasync+0x13/0x20
>>> [55222.426308]  do_syscall_64+0x55/0x1a0
>>> [55222.427025]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55222.427732] RIP: 0033:0x7f1db3fc85f0
>>> [55222.428396] Code: Bad RIP value.
>>> [55222.429087] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55222.429757] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55222.430451] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55222.431159] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55222.431856] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55222.432544] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55343.234863] INFO: task rsync:9830 blocked for more than 724 seconds.
>>> [55343.235887]       Not tainted 5.3.0-rc8 #1
>>> [55343.236611] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55343.237213] rsync           D    0  9830   9829 0x00004002
>>> [55343.237766] Call Trace:
>>> [55343.238353]  ? __schedule+0x3cf/0x680
>>> [55343.238971]  ? bit_wait+0x50/0x50
>>> [55343.239592]  schedule+0x39/0xa0
>>> [55343.240173]  io_schedule+0x12/0x40
>>> [55343.240721]  bit_wait_io+0xd/0x50
>>> [55343.241266]  __wait_on_bit+0x66/0x90
>>> [55343.241835]  ? bit_wait+0x50/0x50
>>> [55343.242418]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55343.242938]  ? init_wait_var_entry+0x40/0x40
>>> [55343.243496]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55343.244090]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55343.244720]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55343.245296]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55343.245843]  do_writepages+0x1a/0x60
>>> [55343.246407]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55343.247014]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55343.247631]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55343.248186]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55343.248743]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55343.249326]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55343.249931]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55343.250562]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55343.251139]  ? retarget_shared_pending+0x70/0x70
>>> [55343.251628]  do_fsync+0x38/0x60
>>> [55343.252208]  __x64_sys_fdatasync+0x13/0x20
>>> [55343.252702]  do_syscall_64+0x55/0x1a0
>>> [55343.253212]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55343.253798] RIP: 0033:0x7f1db3fc85f0
>>> [55343.254294] Code: Bad RIP value.
>>> [55343.254821] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55343.255404] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55343.255989] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55343.256521] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55343.257073] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55343.257649] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55464.068704] INFO: task rsync:9830 blocked for more than 845 seconds.
>>> [55464.069701]       Not tainted 5.3.0-rc8 #1
>>> [55464.070655] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55464.071637] rsync           D    0  9830   9829 0x00004002
>>> [55464.072637] Call Trace:
>>> [55464.073623]  ? __schedule+0x3cf/0x680
>>> [55464.074604]  ? bit_wait+0x50/0x50
>>> [55464.075577]  schedule+0x39/0xa0
>>> [55464.076531]  io_schedule+0x12/0x40
>>> [55464.077480]  bit_wait_io+0xd/0x50
>>> [55464.078400]  __wait_on_bit+0x66/0x90
>>> [55464.079300]  ? bit_wait+0x50/0x50
>>> [55464.080184]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55464.081107]  ? init_wait_var_entry+0x40/0x40
>>> [55464.082047]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55464.083001]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55464.083963]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55464.084944]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55464.085456]  do_writepages+0x1a/0x60
>>> [55464.085840]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55464.086231]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55464.086625]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55464.087019]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55464.087417]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55464.087814]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55464.088219]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55464.088652]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55464.089043]  ? retarget_shared_pending+0x70/0x70
>>> [55464.089429]  do_fsync+0x38/0x60
>>> [55464.089811]  __x64_sys_fdatasync+0x13/0x20
>>> [55464.090190]  do_syscall_64+0x55/0x1a0
>>> [55464.090568]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55464.090944] RIP: 0033:0x7f1db3fc85f0
>>> [55464.091321] Code: Bad RIP value.
>>> [55464.091693] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55464.092078] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55464.092467] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55464.092863] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55464.093254] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55464.093643] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55584.902564] INFO: task rsync:9830 blocked for more than 966 seconds.
>>> [55584.903748]       Not tainted 5.3.0-rc8 #1
>>> [55584.904868] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55584.906023] rsync           D    0  9830   9829 0x00004002
>>> [55584.907207] Call Trace:
>>> [55584.908355]  ? __schedule+0x3cf/0x680
>>> [55584.909507]  ? bit_wait+0x50/0x50
>>> [55584.910682]  schedule+0x39/0xa0
>>> [55584.911230]  io_schedule+0x12/0x40
>>> [55584.911666]  bit_wait_io+0xd/0x50
>>> [55584.912092]  __wait_on_bit+0x66/0x90
>>> [55584.912510]  ? bit_wait+0x50/0x50
>>> [55584.912924]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55584.913343]  ? init_wait_var_entry+0x40/0x40
>>> [55584.913795]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55584.914242]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55584.914698]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55584.915152]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55584.915588]  do_writepages+0x1a/0x60
>>> [55584.916022]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55584.916474]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55584.916928]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55584.917386]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55584.917844]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55584.918300]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55584.918772]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55584.919233]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55584.919679]  ? retarget_shared_pending+0x70/0x70
>>> [55584.920122]  do_fsync+0x38/0x60
>>> [55584.920559]  __x64_sys_fdatasync+0x13/0x20
>>> [55584.920996]  do_syscall_64+0x55/0x1a0
>>> [55584.921429]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55584.921865] RIP: 0033:0x7f1db3fc85f0
>>> [55584.922298] Code: Bad RIP value.
>>> [55584.922734] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55584.923174] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55584.923568] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55584.923982] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55584.924378] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55584.924774] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55705.736285] INFO: task rsync:9830 blocked for more than 1087 seconds.
>>> [55705.736999]       Not tainted 5.3.0-rc8 #1
>>> [55705.737694] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55705.738411] rsync           D    0  9830   9829 0x00004002
>>> [55705.739072] Call Trace:
>>> [55705.739455]  ? __schedule+0x3cf/0x680
>>> [55705.739837]  ? bit_wait+0x50/0x50
>>> [55705.740215]  schedule+0x39/0xa0
>>> [55705.740610]  io_schedule+0x12/0x40
>>> [55705.741243]  bit_wait_io+0xd/0x50
>>> [55705.741897]  __wait_on_bit+0x66/0x90
>>> [55705.742524]  ? bit_wait+0x50/0x50
>>> [55705.743131]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55705.743750]  ? init_wait_var_entry+0x40/0x40
>>> [55705.744128]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55705.744766]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55705.745440]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55705.746118]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55705.746753]  do_writepages+0x1a/0x60
>>> [55705.747411]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55705.748106]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55705.748807]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55705.749495]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55705.750190]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55705.750890]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55705.751580]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55705.752293]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55705.752981]  ? retarget_shared_pending+0x70/0x70
>>> [55705.753686]  do_fsync+0x38/0x60
>>> [55705.754340]  __x64_sys_fdatasync+0x13/0x20
>>> [55705.755012]  do_syscall_64+0x55/0x1a0
>>> [55705.755678]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55705.756375] RIP: 0033:0x7f1db3fc85f0
>>> [55705.757042] Code: Bad RIP value.
>>> [55705.757690] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55705.758300] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55705.758678] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55705.759107] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55705.759785] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55705.760471] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [55826.570182] INFO: task rsync:9830 blocked for more than 1208 seconds.
>>> [55826.571349]       Not tainted 5.3.0-rc8 #1
>>> [55826.572469] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [55826.573618] rsync           D    0  9830   9829 0x00004002
>>> [55826.574790] Call Trace:
>>> [55826.575932]  ? __schedule+0x3cf/0x680
>>> [55826.577079]  ? bit_wait+0x50/0x50
>>> [55826.578233]  schedule+0x39/0xa0
>>> [55826.579350]  io_schedule+0x12/0x40
>>> [55826.580451]  bit_wait_io+0xd/0x50
>>> [55826.581527]  __wait_on_bit+0x66/0x90
>>> [55826.582596]  ? bit_wait+0x50/0x50
>>> [55826.583178]  out_of_line_wait_on_bit+0x8b/0xb0
>>> [55826.583550]  ? init_wait_var_entry+0x40/0x40
>>> [55826.583953]  lock_extent_buffer_for_io+0x10b/0x2c0 [btrfs]
>>> [55826.584356]  btree_write_cache_pages+0x17d/0x350 [btrfs]
>>> [55826.584755]  ? btrfs_set_token_32+0x72/0x130 [btrfs]
>>> [55826.585155]  ? merge_state.part.47+0x3f/0x160 [btrfs]
>>> [55826.585547]  do_writepages+0x1a/0x60
>>> [55826.585937]  __filemap_fdatawrite_range+0xc8/0x100
>>> [55826.586352]  ? convert_extent_bit+0x2e8/0x580 [btrfs]
>>> [55826.586761]  btrfs_write_marked_extents+0x141/0x160 [btrfs]
>>> [55826.587171]  btrfs_write_and_wait_transaction.isra.26+0x58/0xb0 [btrfs]
>>> [55826.587581]  ? btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55826.587990]  btrfs_commit_transaction+0x752/0x9d0 [btrfs]
>>> [55826.588406]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
>>> [55826.588818]  btrfs_sync_file+0x395/0x3e0 [btrfs]
>>> [55826.589219]  ? retarget_shared_pending+0x70/0x70
>>> [55826.589617]  do_fsync+0x38/0x60
>>> [55826.590011]  __x64_sys_fdatasync+0x13/0x20
>>> [55826.590411]  do_syscall_64+0x55/0x1a0
>>> [55826.590798]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [55826.591185] RIP: 0033:0x7f1db3fc85f0
>>> [55826.591572] Code: Bad RIP value.
>>> [55826.591952] RSP: 002b:00007ffe6f827db8 EFLAGS: 00000246 ORIG_RAX:
>>> 000000000000004b
>>> [55826.592347] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
>>> 00007f1db3fc85f0
>>> [55826.592743] RDX: 00007f1db4aa6060 RSI: 0000000000000003 RDI:
>>> 0000000000000001
>>> [55826.593143] RBP: 0000000000000001 R08: 0000000000000000 R09:
>>> 0000000081c492ca
>>> [55826.593543] R10: 0000000000000008 R11: 0000000000000246 R12:
>>> 0000000000000028
>>> [55826.593941] R13: 00007ffe6f827e40 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> 
>>> 
>>> Greets,
>>> Stefan
>> 
>> --
>> Michal Hocko
>> SUSE Labs

