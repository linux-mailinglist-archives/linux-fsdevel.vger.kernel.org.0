Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6E1C46D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgEDTLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 15:11:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFAC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2020 12:11:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c10so748749qka.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=VGvSAvWLe7+IJSwNMQEyo7m7FXM+79LRvXotwNFZf2s=;
        b=kAyV4PUynjGB9Pg4P/67U0gxD+gr2+FcBJL6hSl3Cbb6lNF1QE965aRb+yFK6FiKgl
         4hQFwnwIusFItt4by2VT/VMNe2LH+aRvOvEyJ//MlpU61ROWkTE3tz53DQec0KU8tq0E
         S8TCA8I/jdgYx/o238ovH7THJTK+M8bz0SED0WKXYMdJ5rHuBUQLzLkeTq6uAW5aZDIh
         nxSx+/cSQG9/vr9QMgaTZKyYE4l7mYVqPRo8xEeGt64LB/Olv1ruQhceVy5m6+ReDX3r
         rjAm76To9yUwqbYCeLqbTX4OwbbiyHZSDjq6f3A4puU25D/fm9pKOsgqPBE/sULnYD//
         cOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=VGvSAvWLe7+IJSwNMQEyo7m7FXM+79LRvXotwNFZf2s=;
        b=ZoevGESqNxx/2xb0GTdLIBbL9zTgxPfU0i/TY/jhVS0dxR5RjR6yUUzjaawIuBoj6X
         gheeZYMy/jayour5jsye8GGBt275Y5R9kQg3Bc6ztIWYn/4Y4oRsZ3Z47aunXKdWj58A
         8qhOgON10tAOU2wWrqOsfvA4xyNfmK1dOqGWDs20GeJxN+KcceZza2wSF9HAuMytffPy
         DGNvn3JRzvTK9MrVax2AXQv/U+wvGZt0sDaUGHJ1jDMQhF1qJ1pJIRahmiJjTfHV1A6L
         XJqdH1ePX7tQ+Hb33xrr4W7Pmep6NaVv/c/sqUfLhduiwA4jgL/5xQTZWqiqL9NkG8oK
         RnAw==
X-Gm-Message-State: AGi0PubcOgzh2OQj5zmyLA2A6G3FKm6r/zxzp4h12M0yAzW/ApVQviOT
        2OT4yZKOYwLykxP/azS2z4GuhFVtQuLNKQ==
X-Google-Smtp-Source: APiQypLoc1Bl2ZCLxPBUvax2c2dnuxnfkz9fTYPan6cEz0DB7ycCLbC8dg232ptBJL+tl1HgXm9uXg==
X-Received: by 2002:a05:620a:693:: with SMTP id f19mr695285qkh.299.1588619470939;
        Mon, 04 May 2020 12:11:10 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h185sm4503286qkc.19.2020.05.04.12.11.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 12:11:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: splice() rcu_sched self-detected stall on CPU
Message-Id: <89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw>
Date:   Mon, 4 May 2020 15:11:09 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running a syscall fuzzer inside a container on linux-next floods systems =
with soft lockups. It looks like stuck in this line at =
iov_iter_copy_from_user_atomic(), Thoughts?

iterate_all_kinds(i, bytes, v,
                copyin((p +=3D v.iov_len) - v.iov_len, v.iov_base, =
v.iov_len),
                memcpy_from_page((p +=3D v.bv_len) - v.bv_len, =
v.bv_page,
                                 v.bv_offset, v.bv_len),
                memcpy((p +=3D v.iov_len) - v.iov_len, v.iov_base, =
v.iov_len)
        )

[18310.203791][  C118] watchdog: BUG: soft lockup - CPU#118 stuck for =
22s! [trinity-c93:129976]
[18310.212289][  C118] Modules linked in: nfnetlink cn brd ext4 crc16 =
mbcache jbd2 loop nls_iso8859_1 nls_cp437 vfat fat kvm_amd kvm ses =
enclosure dax_pmem irqbypass dax_pmem_core efivars acpi_cpufreq efivarfs =
ip_tables x_tables xfs sd_mod smartpqi scsi_transport_sas mlx5_core tg3 =
libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod [last =
unloaded: binfmt_misc]
[18310.245012][  C118] irq event stamp: 0
[18310.248847][  C118] hardirqs last  enabled at (0): =
[<0000000000000000>] 0x0
[18310.255867][  C118] hardirqs last disabled at (0): =
[<ffffffffa5ebffef>] copy_process+0x10ff/0x30a0
[18310.264889][  C118] softirqs last  enabled at (0): =
[<ffffffffa5ebffef>] copy_process+0x10ff/0x30a0
[18310.273908][  C118] softirqs last disabled at (0): =
[<0000000000000000>] 0x0
[18310.280958][  C118] CPU: 118 PID: 129976 Comm: trinity-c93 Tainted: G =
          O L    5.7.0-rc4-next-20200504+ #1
[18310.291463][  C118] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[18310.300814][  C118] RIP: =
0010:iov_iter_copy_from_user_atomic+0x3b4/0x510
lib/iov_iter.c:1000 (discriminator 10)
[18310.307699][  C118] Code: 92 dd ff 41 8b 47 08 8b 75 c8 8b 55 b8 29 =
d8 81 e2 ff 0f 00 00 39 f0 0f 47 c6 89 c1 b8 00 10 00 00 29 d0 39 c1 0f =
46 c1 85 c0 <74> 55 4c 89 ff 89 45 d0 89 55 a4 e8 2c 93 dd ff 8b 75 b8 =
48 8b 7d
[18310.327430][  C118] RSP: 0018:ffffc900387f7758 EFLAGS: 00000246 =
ORIG_RAX: ffffffffffffff13
[18310.335863][  C118] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[18310.343747][  C118] RDX: 0000000000000000 RSI: 0000000000000b99 RDI: =
ffff888c8f804208
[18310.351731][  C118] RBP: ffffc900387f77b8 R08: ffffed1117c50075 R09: =
ffffed1117c50075
[18310.359659][  C118] R10: ffff8888be2803a7 R11: ffffed1117c50074 R12: =
0000000000000b99
[18310.367624][  C118] R13: ffffc900387f7c30 R14: 0000000000000000 R15: =
ffff888c8f804200
[18310.375601][  C118] FS:  00007f733446f740(0000) =
GS:ffff889030700000(0000) knlGS:0000000000000000
[18310.384444][  C118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18310.391026][  C118] CR2: 00007f73340852fc CR3: 00000009e6ea4000 CR4: =
00000000003406e0
[18310.398951][  C118] Call Trace:
[18310.402123][  C118]  generic_perform_write+0x254/0x340
[18310.407402][  C118]  ? filemap_check_errors+0xb0/0xb0
[18310.412493][  C118]  ? file_update_time+0x18a/0x220
[18310.417532][  C118]  ? update_time+0x70/0x70
[18310.421836][  C118]  ? __kasan_check_write+0x14/0x20
[18310.426928][  C118]  __generic_file_write_iter+0x1a5/0x2a0
[18310.432453][  C118]  generic_file_write_iter+0x219/0x2d8
[18310.437900][  C118]  ? kernel_text_address+0x59/0xc0
[18310.442901][  C118]  ? __generic_file_write_iter+0x2a0/0x2a0
[18310.448670][  C118]  do_iter_readv_writev+0x2cb/0x3d0
[18310.453757][  C118]  ? default_llseek+0x140/0x140
[18310.458571][  C118]  ? create_object+0x4a7/0x540
[18310.463224][  C118]  do_iter_write+0xd7/0x2b0
[18310.467680][  C118]  vfs_iter_write+0x4e/0x70
[18310.472072][  C118]  iter_file_splice_write+0x44a/0x620
[18310.477430][  C118]  ? page_cache_pipe_buf_steal+0x130/0x130
[18310.483130][  C118]  ? debug_lockdep_rcu_enabled+0x27/0x60
[18310.488709][  C118]  ? ___might_sleep+0x178/0x210
[18310.493449][  C118]  ? __sb_start_write+0x17b/0x270
[18310.498476][  C118]  do_splice+0x5ce/0xa20
[18310.502602][  C118]  ? __task_pid_nr_ns+0x5/0x290
[18310.507426][  C118]  ? __task_pid_nr_ns+0x145/0x290
[18310.512339][  C118]  ? default_file_splice_write+0x40/0x40
[18310.517952][  C118]  ? __kasan_check_read+0x11/0x20
[18310.522866][  C118]  ? __fget_light+0xba/0x120
[18310.527423][  C118]  __x64_sys_splice+0x16e/0x180
[18310.532163][  C118]  do_syscall_64+0xcc/0xaf0
[18310.536643][  C118]  ? syscall_return_slowpath+0x580/0x580
[18310.542168][  C118]  ? lockdep_hardirqs_off+0x1f/0x140
[18310.547386][  C118]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[18310.553349][  C118]  ? trace_hardirqs_off_caller+0x3a/0x150
[18310.559046][  C118]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[18310.564484][  C118]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[18310.570342][  C118] RIP: 0033:0x7f73345b070d
[18310.574647][  C118] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 53 f7 0c 00 f7 d8 64 =
89 01 48
[18310.594352][  C118] RSP: 002b:00007ffe560d32f8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000113
[18310.602719][  C118] RAX: ffffffffffffffda RBX: 0000000000000113 RCX: =
00007f73345b070d
[18310.610653][  C118] RDX: 00000000000000a0 RSI: 0000000000000000 RDI: =
00000000000000b1
[18310.618628][  C118] RBP: 0000000000000113 R08: 0000000000001000 R09: =
0000000000000002
[18310.626597][  C118] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000000002
[18310.634477][  C118] R13: 00007f7332cd5058 R14: 00007f733446f6c0 R15: =
00007f7332cd5000
[18321.464794][  C118] rcu: INFO: rcu_sched self-detected stall on CPU
[18321.471149][  C118] rcu: 	118-....: (6410 ticks this GP) =
idle=3D496/1/0x4000000000000002 softirq=3D311635/311638 fqs=3D2933=20
[18321.482019][  C118] 	(t=3D6502 jiffies g=3D1028673 q=3D377159)
[18321.487375][  C118] NMI backtrace for cpu 118
[18321.491767][  C118] CPU: 118 PID: 129976 Comm: trinity-c93 Tainted: G =
          O L    5.7.0-rc4-next-20200504+ #1
[18321.502180][  C118] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[18321.511477][  C118] Call Trace:
[18321.514643][  C118]  <IRQ>
[18321.517381][  C118]  dump_stack+0xa7/0xea
[18321.521423][  C118]  nmi_cpu_backtrace.cold.9+0x2e/0x33
[18321.526706][  C118]  ? nmi_cpu_backtrace_handler+0x20/0x20
[18321.532230][  C118]  nmi_trigger_cpumask_backtrace+0x19f/0x1b2
[18321.538108][  C118]  arch_trigger_cpumask_backtrace+0x19/0x20
[18321.543898][  C118]  rcu_dump_cpu_stacks+0x1a3/0x1ee
[18321.549030][  C118]  rcu_sched_clock_irq.cold.110+0xe9/0x73a
[18321.554731][  C118]  ? trace_hardirqs_off+0x3a/0x150
[18321.559858][  C118]  update_process_times+0x28/0x60
[18321.564776][  C118]  tick_sched_handle+0x44/0x90
[18321.569525][  C118]  tick_sched_timer+0x3c/0xa0
[18321.574086][  C118]  __hrtimer_run_queues+0x45d/0x8c0
[18321.579251][  C118]  ? tick_sched_do_timer+0x90/0x90
[18321.584249][  C118]  ? enqueue_hrtimer+0x240/0x240
[18321.589203][  C118]  ? trace_hardirqs_off+0x3a/0x150
[18321.594205][  C118]  ? ktime_get_update_offsets_now+0xb7/0x1f0
[18321.600167][  C118]  hrtimer_interrupt+0x1aa/0x360
[18321.605071][  C118]  ? __kasan_check_read+0x11/0x20
[18321.610023][  C118]  smp_apic_timer_interrupt+0x103/0x430
[18321.615518][  C118]  apic_timer_interrupt+0xf/0x20
[18321.620341][  C118]  </IRQ>
[18321.623160][  C118] RIP: =
0010:iov_iter_copy_from_user_atomic+0x35d/0x510
[18321.629982][  C118] Code: fe ff ff 49 8d 45 18 44 89 65 c8 45 31 f6 =
48 89 45 a8 8b 45 c8 85 c0 0f 84 0e fe ff ff 48 8b 7d a8 e8 97 93 dd ff =
49 8b 4d 18 <44> 89 f0 48 c1 e0 04 48 89 4d d0 48 01 c1 49 89 cf 48 8d =
79 0c 48
[18321.649567][  C118] RSP: 0018:ffffc900387f7758 EFLAGS: 00000246 =
ORIG_RAX: ffffffffffffff13
[18321.657890][  C118] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
ffff888c8f804200
[18321.665906][  C118] RDX: dffffc0000000000 RSI: 0000000000000b99 RDI: =
ffffc900387f7c48
[18321.673789][  C118] RBP: ffffc900387f77b8 R08: ffffed1117c50075 R09: =
ffffed1117c50075
[18321.681753][  C118] R10: ffff8888be2803a7 R11: ffffed1117c50074 R12: =
0000000000000b99
[18321.689635][  C118] R13: ffffc900387f7c30 R14: 0000000000000000 R15: =
ffff888c8f804200
[18321.697523][  C118]  ? iov_iter_copy_from_user_atomic+0x359/0x510
[18321.703660][  C118]  generic_perform_write+0x254/0x340
[18321.708920][  C118]  ? filemap_check_errors+0xb0/0xb0
[18321.714010][  C118]  ? file_update_time+0x18a/0x220
[18321.718944][  C118]  ? update_time+0x70/0x70
[18321.723242][  C118]  ? __kasan_check_write+0x14/0x20
[18321.728310][  C118]  __generic_file_write_iter+0x1a5/0x2a0
[18321.733833][  C118]  generic_file_write_iter+0x219/0x2d8
[18321.739236][  C118]  ? kernel_text_address+0x59/0xc0
[18321.744237][  C118]  ? __generic_file_write_iter+0x2a0/0x2a0
[18321.749937][  C118]  do_iter_readv_writev+0x2cb/0x3d0
[18321.755095][  C118]  ? default_llseek+0x140/0x140
[18321.759834][  C118]  ? create_object+0x4a7/0x540
[18321.764488][  C118]  do_iter_write+0xd7/0x2b0
[18321.768878][  C118]  vfs_iter_write+0x4e/0x70
[18321.773273][  C118]  iter_file_splice_write+0x44a/0x620
[18321.778537][  C118]  ? page_cache_pipe_buf_steal+0x130/0x130
[18321.784237][  C118]  ? debug_lockdep_rcu_enabled+0x27/0x60
[18321.789760][  C118]  ? ___might_sleep+0x178/0x210
[18321.794500][  C118]  ? __sb_start_write+0x17b/0x270
[18321.799410][  C118]  do_splice+0x5ce/0xa20
[18321.803534][  C118]  ? __task_pid_nr_ns+0x5/0x290
[18321.808275][  C118]  ? __task_pid_nr_ns+0x145/0x290
[18321.813186][  C118]  ? default_file_splice_write+0x40/0x40
[18321.818709][  C118]  ? __kasan_check_read+0x11/0x20
[18321.823622][  C118]  ? __fget_light+0xba/0x120
[18321.828131][  C118]  __x64_sys_splice+0x16e/0x180
[18321.832868][  C118]  do_syscall_64+0xcc/0xaf0
[18321.837290][  C118]  ? syscall_return_slowpath+0x580/0x580
[18321.842817][  C118]  ? lockdep_hardirqs_off+0x1f/0x140
[18321.847991][  C118]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[18321.853952][  C118]  ? trace_hardirqs_off_caller+0x3a/0x150
[18321.859565][  C118]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[18321.865040][  C118]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[18321.870867][  C118] RIP: 0033:0x7f73345b070d
[18321.875174][  C118] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 53 f7 0c 00 f7 d8 64 =
89 01 48
[18321.894764][  C118] RSP: 002b:00007ffe560d32f8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000113
[18321.903082][  C118] RAX: ffffffffffffffda RBX: 0000000000000113 RCX: =
00007f73345b070d
[18321.910963][  C118] RDX: 00000000000000a0 RSI: 0000000000000000 RDI: =
00000000000000b1
[18321.918845][  C118] RBP: 0000000000000113 R08: 0000000000001000 R09: =
0000000000000002
[18321.926724][  C118] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000000002
[18321.934605][  C118] R13: 00007f7332cd5058 R14: 00007f733446f6c0 R15: =
00007f7332cd5000
 INFO: task trinity-c93:129976 can't die for more than 1725 seconds.
[20088.049356][  T794] trinity-c93     R  running task    27728 129976  =
97040 0x8000000e
[20088.057298][  T794] Call Trace:
[20088.060541][  T794]  ? __kasan_check_read+0x11/0x20
[20088.065459][  T794]  ? activate_page+0x233/0x330
[20088.070157][  T794]  ? __kasan_check_read+0x11/0x20
[20088.075074][  T794]  ? mark_page_accessed+0x10a/0x5f0
[20088.080202][  T794]  ? retint_kernel+0x10/0x10
[20088.084681][  T794]  ? lockdep_hardirqs_on+0x16/0x2c0
[20088.089772][  T794]  ? retint_kernel+0x10/0x10
[20088.094288][  T794]  ? trace_hardirqs_on_caller+0x3a/0x160
[20088.099909][  T794]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[20088.105306][  T794]  ? irq_exit+0x60/0xf0
[20088.109346][  T794]  ? retint_kernel+0x10/0x10
[20088.113857][  T794]  ? iov_iter_copy_from_user_atomic+0x359/0x510
[20088.120156][  T794]  ? __asan_load8+0x30/0xb0
[20088.124602][  T794]  ? iov_iter_copy_from_user_atomic+0x38d/0x510
[20088.130850][  T794]  ? generic_perform_write+0x254/0x340
[20088.136204][  T794]  ? filemap_check_errors+0xb0/0xb0
[20088.141384][  T794]  ? file_update_time+0x18a/0x220
[20088.146299][  T794]  ? update_time+0x70/0x70
[20088.150633][  T794]  ? __kasan_check_write+0x14/0x20
[20088.155637][  T794]  ? __generic_file_write_iter+0x1a5/0x2a0
[20088.161371][  T794]  ? generic_file_write_iter+0x219/0x2d8
[20088.166902][  T794]  ? kernel_text_address+0x59/0xc0
[20088.171936][  T794]  ? __generic_file_write_iter+0x2a0/0x2a0
[20088.177638][  T794]  ? do_iter_readv_writev+0x2cb/0x3d0
[20088.182931][  T794]  ? default_llseek+0x140/0x140
[20088.187672][  T794]  ? create_object+0x4a7/0x540
[20088.192350][  T794]  ? do_iter_write+0xd7/0x2b0
[20088.196919][  T794]  ? vfs_iter_write+0x4e/0x70
[20088.201512][  T794]  ? iter_file_splice_write+0x44a/0x620
[20088.206952][  T794]  ? page_cache_pipe_buf_steal+0x130/0x130
[20088.212686][  T794]  ? debug_lockdep_rcu_enabled+0x27/0x60
[20088.218213][  T794]  ? ___might_sleep+0x178/0x210
[20088.223046][  T794]  ? __sb_start_write+0x17b/0x270
[20088.227959][  T794]  ? do_splice+0x5ce/0xa20
[20088.232290][  T794]  ? __task_pid_nr_ns+0x5/0x290
[20088.237028][  T794]  ? __task_pid_nr_ns+0x145/0x290
[20088.242054][  T794]  ? default_file_splice_write+0x40/0x40
[20088.247579][  T794]  ? __kasan_check_read+0x11/0x20
[20088.252564][  T794]  ? __fget_light+0xba/0x120
[20088.257041][  T794]  ? __x64_sys_splice+0x16e/0x180
[20088.262010][  T794]  ? do_syscall_64+0xcc/0xaf0
[20088.266575][  T794]  ? syscall_return_slowpath+0x580/0x580
[20088.272144][  T794]  ? lockdep_hardirqs_off+0x1f/0x140
[20088.277320][  T794]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[20088.283305][  T794]  ? trace_hardirqs_off_caller+0x3a/0x150
[20088.288920][  T794]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[20088.294398][  T794]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3=
