Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39FF1DA45D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgESWST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 18:18:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:59191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESWSS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 18:18:18 -0400
IronPort-SDR: lrjb2qZIJsO0xK0kYXVTFlkz2IgD77d0/gC0UQIraycZdxocb2sXgGGN9mt+YvCaKZeuL/8TsI
 J4QOslXVBqIw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 15:18:14 -0700
IronPort-SDR: 5wX3/45rcwmTx+SspbBK1bSng/bzznPm+W7asqP2SZ2aaxMQL+r7HCZcwJmfFWH/GzV5yXWyrM
 FdX0a+KKSPsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="txt'?scan'208";a="300249435"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2020 15:18:14 -0700
Received: from tjmaciei-mobl1.localnet (10.255.229.215) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 May 2020 15:18:13 -0700
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fcntl(F_DUPFD) causing apparent file descriptor table corruption
Date:   Tue, 19 May 2020 15:18:13 -0700
Message-ID: <6266026.WxYS4g2YVZ@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <20200519214520.GS23230@ZenIV.linux.org.uk>
References: <1645568.el9gB4U55B@tjmaciei-mobl1> <20200519214520.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3186326.TUZDBpCOXO"
Content-Transfer-Encoding: 7Bit
X-Originating-IP: [10.255.229.215]
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--nextPart3186326.TUZDBpCOXO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 19 May 2020 14:45:20 PDT Al Viro wrote:
> ... and here's not getting the things copied.  Which means that pointer
> is left uninitialized and the damn thing might very well be a security
> problem - you'd lucked out and ran into NULL, but had there been a pointer
> to something, you would've gotten a memory corruptor.

Not sure I'd call it a security issue. Only root (CAP_SYS_RESOURCE) can cause 
it by raising the file descriptor limit from the defaults. The kernel still 
defaults to 4096 and systemd raises it on boot to 512k, which is 3 orders of 
magnitude less than what is needed to cause the issue.

> I really wonder about the missing couple of syscalls in your strace, though;
> could you verify that they _are_ missing and see what the fix above does to
> your testcase?

Looking at my terminal backtrace, I might have made a copy & paste mistake of 
the trace while flipping pages. Unfortunately, the trace file I had in /tmp 
was lost because I needed to reboot the machine. The other traces I have in my 
terminal show:

fcntl(2, F_DUPFD, 134217728)            = 134217728
close(134217728)                        = 0
fcntl(2, F_DUPFD, 268435456)            = 268435456
close(268435456)                        = 0
fcntl(2, F_DUPFD, 536870912)            = 536870912
close(536870912)                        = 0
write(1, "success\n", 8)                = ?
^C^Czsh: killed     sudo strace ./dupfd-bug

I had to killall -9 strace at this point. See the attached oops.

Then I insisted:

fcntl(2, F_DUPFD, 67108864)             = 67108864
close(67108864)                         = 0
fcntl(2, F_DUPFD, 134217728)            = 134217728
close(134217728)                        = 0
fcntl(2, F_DUPFD, 268435456Shared connection to <REDACTED> closed.

At this point, I need to drive to the office to reboot the machine. Building 
the kernel and testing will take a few days.

Note to self: don't play with possible kernel bugs without a VM.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel System Software Products

--nextPart3186326.TUZDBpCOXO
Content-Disposition: attachment; filename="oops.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="oops.txt"

[19186.822144] alloc_fd: slot 536870912 not NULL!
[19186.822963] BUG: unable to handle page fault for address: 00000000000d73ef
[19186.823725] #PF: supervisor read access in kernel mode
[19186.824331] #PF: error_code(0x0000) - not-present page
[19186.824950] PGD 0 P4D 0 
[19186.825344] Oops: 0000 [#6] SMP PTI
[19186.825813] CPU: 2 PID: 71323 Comm: dupfd-bug Tainted: G      D   I       5.6.13-952.native #1
[19186.826724] Hardware name: Gigabyte Technology Co., Ltd. X299 AORUS Gaming 3 Pro/X299 AORUS Gaming 3 Pro-CF, BIOS F3 12/28/2017
[19186.827837] RIP: 0010:__fget_light+0x63/0x70
[19186.828374] Code: c0 5d c3 48 8b 4f 20 8b 01 41 39 c0 73 22 44 89 c7 48 39 c7 48 19 ff 48 8b 41 08 41 21 f8 4a 8d 04 c0 48 8b 00 48 85 c0 74 06 <23> 50 44 75 01 c3 31 c0 c3 0f 1f 40 00 55 be 00 40 00 00 48 89 e5
[19186.830091] RSP: 0018:ffffaf8281fb7ed0 EFLAGS: 00010202
[19186.830750] RAX: 00000000000d73ab RBX: 0000000000000001 RCX: ffff8ab156879300
[19186.831537] RDX: 0000000000004000 RSI: 0000000000004000 RDI: ffffffffffffffff
[19186.832326] RBP: ffffaf8281fb7ee0 R08: 0000000000000001 R09: ffff8ab0d5988000
[19186.833121] R10: ffffaf8280127e6d R11: 000000000000000c R12: ffffaf8281fb7f58
[19186.833898] R13: 00005651ef8ac034 R14: 0000000000000008 R15: 0000000000000000
[19186.834672] FS:  00007ff99749d540(0000) GS:ffff8ab69f680000(0000) knlGS:0000000000000000
[19186.835529] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19186.836192] CR2: 00000000000d73ef CR3: 0000000255988006 CR4: 00000000003606e0
[19186.836967] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[19186.837741] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[19186.838520] Call Trace:
[19186.838920]  ? __fdget_pos+0x12/0x50
[19186.839411]  ksys_write+0x1a/0xd0
[19186.839877]  __x64_sys_write+0x15/0x20
[19186.840381]  do_syscall_64+0x55/0xf0
[19186.840866]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[19186.841467] RIP: 0033:0x7ff9973b789a
[19186.841945] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 c5 fc 77 0f 05 <66> 0f 1f 44 00 00 48 3d 00 f0 ff ff 77 60 c3 0f 1f 80 00 00 00 00
[19186.843655] RSP: 002b:00007ffd0f3801c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[19186.844475] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff9973b789a
[19186.845255] RDX: 0000000000000008 RSI: 00005651ef8ac034 RDI: 0000000000000001
[19186.846041] RBP: 00005651f0ae92a0 R08: 0000000000000000 R09: 0000000000000000
[19186.846825] R10: 0000000000000000 R11: 0000000000000246 R12: 00005651ef8ab1d0
[19186.847606] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[19186.848392] Modules linked in: xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_tables bpfilter intel_wmi_thunderbolt wmi_bmof snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio nfit edac_core libnvdimm nouveau snd_hda_codec_hdmi encrypted_keys trusted tpm snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core psmouse isst_if_common snd_hwdep mxm_wmi serio_raw snd_pcm nvidiafb snd_timer vgastate snd fb_ddc e1000e soundcore mei_me i2c_i801 mei wmi atkbd libps2 i8042
[19186.852589] CR2: 00000000000d73ef
[19186.853068] ---[ end trace de4959d19d1789ea ]---
[19189.681955] RIP: 0010:__fget_files+0x32/0x70
[19189.682535] Code: d0 48 8b 57 20 89 ce 8b 02 41 39 c2 73 49 49 39 c2 48 19 c0 48 8b 52 08 44 21 c0 48 8d 04 c2 4c 8b 18 4d 85 db 74 30 44 89 c8 <41> 23 43 44 75 27 49 8b 43 38 49 8d 53 38 48 85 c0 74 0f 48 8d 0c
[19189.684289] RSP: 0018:ffffaf8281883ec0 EFLAGS: 00010206
[19189.684945] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 0000000000000001
[19189.685750] RDX: ffffaf849e009000 RSI: 0000000000000001 RDI: ffff8aaff7dc1340
[19189.686559] RBP: ffffaf8281883ec8 R08: 0000000000000008 R09: 0000000000004000
[19189.687363] R10: 0000000000000008 R11: 0000000a00000000 R12: ffffaf8281883f58
[19189.688172] R13: 000000000593d323 R14: 0000000000000001 R15: 0000000000000000
[19189.688981] FS:  00007ff99749d540(0000) GS:ffff8ab69f680000(0000) knlGS:0000000000000000
[19189.689860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19189.690556] CR2: 00000000000d73ef CR3: 0000000255988006 CR4: 00000000003606e0
[19189.691360] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[19189.692170] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[19189.693774] ------------[ cut here ]------------

--nextPart3186326.TUZDBpCOXO--
