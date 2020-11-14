Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613612B2BBB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 07:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgKNGTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 01:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgKNGTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 01:19:39 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF1C0613D1;
        Fri, 13 Nov 2020 22:19:39 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id a18so9397758pfl.3;
        Fri, 13 Nov 2020 22:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFcNWsKScBD9eTizApDD+kVNhhB4MsjnuPB00Wxaw7E=;
        b=p+30U9qxKJvQ53ngaBH1SxBxautSdRoevuXhF/O5sf6CkIdQ8gbj73il7O/hqGPav6
         4J6z3GX/zMRXy6MwhPhy9rtkk3PJcCzGS5xhGaAHA3bo/WpDJgY6NM8BRF0IZw8mnp82
         qHEtZlWvQTHMawjWNqs8d5RezDcX4om8ihIWAR23v8idQemcNNM2o06PNad7OVj75kEl
         y11mGwiZ5Ydl3AfZiPZhM3cW7GzBZQmgyQto/wsbqxGBkEa/7LlhDQaTA7Hork3jwQXv
         VNtd4Ren7n9fTBx9t4CAlV7Ps1sYPnKF2YyjEVl07/22e/LMN6ZX2iXIcUlM9o/mcxZ7
         4FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFcNWsKScBD9eTizApDD+kVNhhB4MsjnuPB00Wxaw7E=;
        b=KGfnjeYWULKXOPIOL2HZM7MczfKC/mDGgr7PKytT8yutjsJzMhllXZPLVB0tDrietf
         myTtTdSyU2fxJpdMZSYWse8kfy9L3doFFezoQITw5Hu6d4hAcIvG6de0M+C83i/7Q2t6
         wxrl+qzhdrKub32HpGTuSF6X3vmLEgW3Y5/S5YRQDac7FnLx+5BTEpy4ovKl4/EtFZnk
         H4ngKUzkI+iWK6SaYOIJ1i69MLapb90Eebiq1AMAG+KhUrPYHMEPCejMbKde1NvCHQJI
         mFWQgROy9bOS8Hs+GSsZr3SkO2ubhRaYxEjoO8yhkp0zWNzDjuEyJv46xx5yJx+G2SLY
         2wdw==
X-Gm-Message-State: AOAM533exbhXoo8yQfVO1khaJbM7QOc6+7mqsO+WAwlESMTsap8ONJ44
        KBGsiBdXiL701TBSd7Aeglo=
X-Google-Smtp-Source: ABdhPJyTe0W+fpSK3KWK7uSpQB7D2U7iuvRXjqG8bjth6L5Y+XA20tSLzQFbqsY589Fc0qu+Y98Tmg==
X-Received: by 2002:a63:1901:: with SMTP id z1mr4515131pgl.87.1605334778569;
        Fri, 13 Nov 2020 22:19:38 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-98-75-144.ph.ph.cox.net. [68.98.75.144])
        by smtp.gmail.com with ESMTPSA id gg19sm590776pjb.21.2020.11.13.22.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 22:19:36 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114061934.GA658@Ryzen-9-3900X.localdomain>
References: <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
 <20201114011754.GL3576660@ZenIV.linux.org.uk>
 <20201114030124.GA236@Ryzen-9-3900X.localdomain>
 <20201114035453.GM3576660@ZenIV.linux.org.uk>
 <20201114041420.GA231@Ryzen-9-3900X.localdomain>
 <20201114055048.GN3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20201114055048.GN3576660@ZenIV.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 14, 2020 at 05:50:48AM +0000, Al Viro wrote:
> On Fri, Nov 13, 2020 at 09:14:20PM -0700, Nathan Chancellor wrote:
> 
> > Unfortunately that patch does not solve my issue. Is there any other
> > debugging I should add?
> 
> Hmm...  I wonder which file it is; how about
> 		if (WARN_ON(!iovec.iov_len))
> 			printk(KERN_ERR "odd readv on %pd4\n", file);
> in the loop in fs/read_write.c:do_loop_readv_writev()?

Assuming you mean this?

diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..91dc07074a3f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -757,6 +757,9 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 		struct iovec iovec = iov_iter_iovec(iter);
 		ssize_t nr;
 
+		if (WARN_ON(!iovec.iov_len))
+			printk(KERN_ERR "odd readv on %pd4\n", filp);
+
 		if (type == READ) {
 			nr = filp->f_op->read(filp, iovec.iov_base,
 					      iovec.iov_len, ppos);

---

Assuming so, I have attached the output both with and without the
WARN_ON. Looks like mountinfo is what is causing the error?

Cheers,
Nathan

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_warn_on.txt"

[    3.072868] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.072869] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.072869] Call Trace:
[    3.072870]  dump_stack+0xa1/0xfb
[    3.072871]  __warn+0x7f/0x120
[    3.072871]  ? do_iter_read+0x182/0x1c0
[    3.072872]  report_bug+0xb1/0x110
[    3.072873]  handle_bug+0x3d/0x70
[    3.072873]  exc_invalid_op+0x18/0xb0
[    3.072874]  asm_exc_invalid_op+0x12/0x20
[    3.072875] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.072875] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.072876] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.072876] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.072877] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b240446900
[    3.072877] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.072877] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.072878] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.072879]  ? do_iter_write+0x1d0/0x1d0
[    3.072879]  ? do_iter_read+0x4c/0x1c0
[    3.072880]  do_readv+0x18d/0x240
[    3.072881]  do_syscall_64+0x33/0x70
[    3.072882]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.072882] RIP: 0033:0x22c483
[    3.072883] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.072883] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.072884] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.072884] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.072885] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.072885] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.072885] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.072886] ---[ end trace bd91d80d59f05b9e ]---
[    3.072886] odd readv on /369/cmdline/
[    3.074657] ------------[ cut here ]------------
[    3.074659] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.074660] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.074661] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.074661] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.074662] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.074663] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.074663] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b24070f980
[    3.074663] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.074664] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.074664] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.074666] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.074666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.074667] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.074668] Call Trace:
[    3.074669]  do_readv+0x18d/0x240
[    3.074670]  do_syscall_64+0x33/0x70
[    3.074671]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.074671] RIP: 0033:0x22c483
[    3.074672] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.074672] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.074673] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.074673] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.074674] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.074674] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.074675] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.074675] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.074676] Call Trace:
[    3.074677]  dump_stack+0xa1/0xfb
[    3.074678]  __warn+0x7f/0x120
[    3.074678]  ? do_iter_read+0x182/0x1c0
[    3.074679]  report_bug+0xb1/0x110
[    3.074680]  handle_bug+0x3d/0x70
[    3.074680]  exc_invalid_op+0x18/0xb0
[    3.074681]  asm_exc_invalid_op+0x12/0x20
[    3.074682] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.074682] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.074682] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.074683] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.074683] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b24070f980
[    3.074684] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.074684] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.074685] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.074686]  ? do_iter_write+0x1d0/0x1d0
[    3.074687]  ? do_iter_read+0x4c/0x1c0
[    3.074687]  do_readv+0x18d/0x240
[    3.074688]  do_syscall_64+0x33/0x70
[    3.074689]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.074689] RIP: 0033:0x22c483
[    3.074690] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.074690] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.074691] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.074691] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.074692] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.074692] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.074693] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.074693] ---[ end trace bd91d80d59f05b9f ]---
[    3.074694] odd readv on /370/cmdline/
[    3.074699] ------------[ cut here ]------------
[    3.074700] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.074701] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.074702] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.074702] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.074702] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.074703] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.074703] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b24070f980
[    3.074704] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.074704] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.074705] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.074706] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.074706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.074707] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.074707] Call Trace:
[    3.074708]  do_readv+0x18d/0x240
[    3.074709]  do_syscall_64+0x33/0x70
[    3.074710]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.074710] RIP: 0033:0x22c483
[    3.074710] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.074711] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.074711] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.074712] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.074712] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.074713] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.074713] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.074714] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.074714] Call Trace:
[    3.074715]  dump_stack+0xa1/0xfb
[    3.074716]  __warn+0x7f/0x120
[    3.074716]  ? do_iter_read+0x182/0x1c0
[    3.074717]  report_bug+0xb1/0x110
[    3.074718]  handle_bug+0x3d/0x70
[    3.074718]  exc_invalid_op+0x18/0xb0
[    3.074719]  asm_exc_invalid_op+0x12/0x20
[    3.074719] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.074720] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.074720] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.074721] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.074721] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b24070f980
[    3.074722] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.074722] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.074722] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.074723]  ? do_iter_write+0x1d0/0x1d0
[    3.074724]  ? do_iter_read+0x4c/0x1c0
[    3.074725]  do_readv+0x18d/0x240
[    3.074726]  do_syscall_64+0x33/0x70
[    3.074727]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.074727] RIP: 0033:0x22c483
[    3.074727] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.074728] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.074728] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.074729] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.074729] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.074730] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.074730] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.074730] ---[ end trace bd91d80d59f05ba0 ]---
[    3.074731] odd readv on /370/cmdline/
[    3.076396] ------------[ cut here ]------------
[    3.076398] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.076399] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.076400] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.076401] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.076402] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.076402] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.076403] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef2c0
[    3.076403] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.076404] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.076404] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.076406] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.076406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.076406] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.076407] Call Trace:
[    3.076409]  do_readv+0x18d/0x240
[    3.076409]  do_syscall_64+0x33/0x70
[    3.076410]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.076411] RIP: 0033:0x22c483
[    3.076412] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.076412] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.076413] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.076413] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.076413] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.076414] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.076414] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.076415] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.076415] Call Trace:
[    3.076416]  dump_stack+0xa1/0xfb
[    3.076417]  __warn+0x7f/0x120
[    3.076418]  ? do_iter_read+0x182/0x1c0
[    3.076418]  report_bug+0xb1/0x110
[    3.076419]  handle_bug+0x3d/0x70
[    3.076420]  exc_invalid_op+0x18/0xb0
[    3.076420]  asm_exc_invalid_op+0x12/0x20
[    3.076421] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.076421] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.076422] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.076422] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.076423] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef2c0
[    3.076423] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.076424] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.076424] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.076425]  ? do_iter_write+0x1d0/0x1d0
[    3.076426]  ? do_iter_read+0x4c/0x1c0
[    3.076427]  do_readv+0x18d/0x240
[    3.076427]  do_syscall_64+0x33/0x70
[    3.076428]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.076429] RIP: 0033:0x22c483
[    3.076429] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.076430] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.076430] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.076431] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.076431] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.076431] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.076432] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.076432] ---[ end trace bd91d80d59f05ba1 ]---
[    3.076433] odd readv on /371/cmdline/
[    3.076436] ------------[ cut here ]------------
[    3.076437] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.076438] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.076439] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.076439] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.076439] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.076440] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.076440] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef2c0
[    3.076441] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.076441] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.076442] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.076443] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.076443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.076444] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.076444] Call Trace:
[    3.076445]  do_readv+0x18d/0x240
[    3.076446]  do_syscall_64+0x33/0x70
[    3.076446]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.076447] RIP: 0033:0x22c483
[    3.076447] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.076448] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.076448] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.076449] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.076449] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.076450] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.076450] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.076451] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.076451] Call Trace:
[    3.076452]  dump_stack+0xa1/0xfb
[    3.076453]  __warn+0x7f/0x120
[    3.076453]  ? do_iter_read+0x182/0x1c0
[    3.076454]  report_bug+0xb1/0x110
[    3.076454]  handle_bug+0x3d/0x70
[    3.076455]  exc_invalid_op+0x18/0xb0
[    3.076456]  asm_exc_invalid_op+0x12/0x20
[    3.076456] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.076457] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.076457] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.076458] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.076458] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef2c0
[    3.076459] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.076459] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.076459] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.076460]  ? do_iter_write+0x1d0/0x1d0
[    3.076461]  ? do_iter_read+0x4c/0x1c0
[    3.076462]  do_readv+0x18d/0x240
[    3.076463]  do_syscall_64+0x33/0x70
[    3.076463]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.076464] RIP: 0033:0x22c483
[    3.076464] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.076465] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.076465] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.076466] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.076466] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.076467] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.076467] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.076467] ---[ end trace bd91d80d59f05ba2 ]---
[    3.076468] odd readv on /371/cmdline/
[    3.079303] ------------[ cut here ]------------
[    3.079305] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.079306] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.079307] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.079308] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.079309] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.079309] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.079310] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefb00
[    3.079310] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.079311] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.079311] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.079313] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.079313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.079314] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.079315] Call Trace:
[    3.079316]  do_readv+0x18d/0x240
[    3.079317]  do_syscall_64+0x33/0x70
[    3.079318]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.079319] RIP: 0033:0x22c483
[    3.079319] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.079320] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.079321] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.079321] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.079321] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.079322] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.079322] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.079323] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.079323] Call Trace:
[    3.079324]  dump_stack+0xa1/0xfb
[    3.079325]  __warn+0x7f/0x120
[    3.079326]  ? do_iter_read+0x182/0x1c0
[    3.079327]  report_bug+0xb1/0x110
[    3.079328]  handle_bug+0x3d/0x70
[    3.079328]  exc_invalid_op+0x18/0xb0
[    3.079329]  asm_exc_invalid_op+0x12/0x20
[    3.079330] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.079330] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.079331] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.079331] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.079332] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefb00
[    3.079332] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.079333] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.079333] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.079334]  ? do_iter_write+0x1d0/0x1d0
[    3.079335]  ? do_iter_read+0x4c/0x1c0
[    3.079336]  do_readv+0x18d/0x240
[    3.079336]  do_syscall_64+0x33/0x70
[    3.079337]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.079338] RIP: 0033:0x22c483
[    3.079338] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.079339] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.079339] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.079340] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.079340] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.079340] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.079341] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.079341] ---[ end trace bd91d80d59f05ba3 ]---
[    3.079342] odd readv on /373/cmdline/
[    3.079348] ------------[ cut here ]------------
[    3.079349] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.079349] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.079350] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.079351] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.079351] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.079352] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.079352] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefb00
[    3.079353] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.079353] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.079353] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.079355] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.079355] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.079355] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.079356] Call Trace:
[    3.079357]  do_readv+0x18d/0x240
[    3.079357]  do_syscall_64+0x33/0x70
[    3.079358]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.079359] RIP: 0033:0x22c483
[    3.079359] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.079360] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.079360] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.079361] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.079361] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.079361] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.079362] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.079363] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.079363] Call Trace:
[    3.079363]  dump_stack+0xa1/0xfb
[    3.079364]  __warn+0x7f/0x120
[    3.079365]  ? do_iter_read+0x182/0x1c0
[    3.079366]  report_bug+0xb1/0x110
[    3.079366]  handle_bug+0x3d/0x70
[    3.079367]  exc_invalid_op+0x18/0xb0
[    3.079367]  asm_exc_invalid_op+0x12/0x20
[    3.079368] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.079369] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.079369] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.079370] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.079370] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefb00
[    3.079370] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.079371] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.079371] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.079372]  ? do_iter_write+0x1d0/0x1d0
[    3.079373]  ? do_iter_read+0x4c/0x1c0
[    3.079374]  do_readv+0x18d/0x240
[    3.079375]  do_syscall_64+0x33/0x70
[    3.079376]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.079376] RIP: 0033:0x22c483
[    3.079377] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.079377] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.079378] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.079378] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.079378] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.079379] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.079379] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.079380] ---[ end trace bd91d80d59f05ba4 ]---
[    3.079380] odd readv on /373/cmdline/
[    3.216198] ------------[ cut here ]------------
[    3.216203] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.216204] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.216205] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.216206] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.216207] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.216208] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.216208] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef800
[    3.216209] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.216209] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.216210] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.216212] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.216212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.216213] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.216214] Call Trace:
[    3.216216]  do_readv+0x18d/0x240
[    3.216218]  do_syscall_64+0x33/0x70
[    3.216219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.216220] RIP: 0033:0x22c483
[    3.216221] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.216221] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.216222] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.216222] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.216223] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.216223] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.216223] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.216224] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.216225] Call Trace:
[    3.216226]  dump_stack+0xa1/0xfb
[    3.216228]  __warn+0x7f/0x120
[    3.216229]  ? do_iter_read+0x182/0x1c0
[    3.216230]  report_bug+0xb1/0x110
[    3.216230]  handle_bug+0x3d/0x70
[    3.216231]  exc_invalid_op+0x18/0xb0
[    3.216232]  asm_exc_invalid_op+0x12/0x20
[    3.216233] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.216234] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.216234] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.216235] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.216235] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef800
[    3.216235] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.216236] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.216236] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.216237]  ? do_iter_write+0x1d0/0x1d0
[    3.216238]  ? do_iter_read+0x4c/0x1c0
[    3.216239]  do_readv+0x18d/0x240
[    3.216240]  do_syscall_64+0x33/0x70
[    3.216240]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.216241] RIP: 0033:0x22c483
[    3.216241] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.216242] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.216242] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.216243] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.216243] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.216244] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.216244] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.216245] ---[ end trace bd91d80d59f05ba5 ]---
[    3.216246] odd readv on /392/cmdline/
[    3.216249] ------------[ cut here ]------------
[    3.216250] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.216251] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.216252] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.216252] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.216253] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.216253] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.216254] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef800
[    3.216254] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.216255] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.216255] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.216256] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.216257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.216257] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.216257] Call Trace:
[    3.216258]  do_readv+0x18d/0x240
[    3.216259]  do_syscall_64+0x33/0x70
[    3.216260]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.216260] RIP: 0033:0x22c483
[    3.216261] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.216261] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.216262] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.216262] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.216262] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.216263] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.216263] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.216264] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.216264] Call Trace:
[    3.216265]  dump_stack+0xa1/0xfb
[    3.216266]  __warn+0x7f/0x120
[    3.216266]  ? do_iter_read+0x182/0x1c0
[    3.216267]  report_bug+0xb1/0x110
[    3.216268]  handle_bug+0x3d/0x70
[    3.216268]  exc_invalid_op+0x18/0xb0
[    3.216269]  asm_exc_invalid_op+0x12/0x20
[    3.216270] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.216270] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.216270] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.216271] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.216271] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef800
[    3.216272] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.216272] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.216273] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.216273]  ? do_iter_write+0x1d0/0x1d0
[    3.216274]  ? do_iter_read+0x4c/0x1c0
[    3.216275]  do_readv+0x18d/0x240
[    3.216276]  do_syscall_64+0x33/0x70
[    3.216276]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.216277] RIP: 0033:0x22c483
[    3.216277] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.216278] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.216278] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.216279] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.216279] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.216280] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.216280] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.216280] ---[ end trace bd91d80d59f05ba6 ]---
[    3.216281] odd readv on /392/cmdline/
[    3.222005] ------------[ cut here ]------------
[    3.222008] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.222009] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222010] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222011] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222011] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222012] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222013] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    3.222013] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.222013] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222014] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.222016] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.222016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.222016] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.222018] Call Trace:
[    3.222019]  do_readv+0x18d/0x240
[    3.222020]  do_syscall_64+0x33/0x70
[    3.222021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222022] RIP: 0033:0x22c483
[    3.222022] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222023] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222024] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222024] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222024] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.222025] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.222025] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222026] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222027] Call Trace:
[    3.222028]  dump_stack+0xa1/0xfb
[    3.222029]  __warn+0x7f/0x120
[    3.222030]  ? do_iter_read+0x182/0x1c0
[    3.222031]  report_bug+0xb1/0x110
[    3.222031]  handle_bug+0x3d/0x70
[    3.222032]  exc_invalid_op+0x18/0xb0
[    3.222033]  asm_exc_invalid_op+0x12/0x20
[    3.222034] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222034] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222035] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222035] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222036] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    3.222036] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.222036] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222037] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.222038]  ? do_iter_write+0x1d0/0x1d0
[    3.222039]  ? do_iter_read+0x4c/0x1c0
[    3.222040]  do_readv+0x18d/0x240
[    3.222040]  do_syscall_64+0x33/0x70
[    3.222041]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222042] RIP: 0033:0x22c483
[    3.222042] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222043] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222043] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222044] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222044] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.222045] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.222045] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222045] ---[ end trace bd91d80d59f05ba7 ]---
[    3.222046] odd readv on /395/cmdline/
[    3.222050] ------------[ cut here ]------------
[    3.222051] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.222052] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222053] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222053] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222054] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222054] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222055] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    3.222055] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.222055] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222056] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.222057] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.222057] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.222058] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.222058] Call Trace:
[    3.222059]  do_readv+0x18d/0x240
[    3.222060]  do_syscall_64+0x33/0x70
[    3.222061]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222061] RIP: 0033:0x22c483
[    3.222062] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222062] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222063] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222063] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222063] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.222064] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.222064] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222065] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222065] Call Trace:
[    3.222066]  dump_stack+0xa1/0xfb
[    3.222067]  __warn+0x7f/0x120
[    3.222068]  ? do_iter_read+0x182/0x1c0
[    3.222068]  report_bug+0xb1/0x110
[    3.222069]  handle_bug+0x3d/0x70
[    3.222069]  exc_invalid_op+0x18/0xb0
[    3.222070]  asm_exc_invalid_op+0x12/0x20
[    3.222071] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222071] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222072] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222072] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222073] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    3.222073] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.222073] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222074] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.222075]  ? do_iter_write+0x1d0/0x1d0
[    3.222075]  ? do_iter_read+0x4c/0x1c0
[    3.222076]  do_readv+0x18d/0x240
[    3.222077]  do_syscall_64+0x33/0x70
[    3.222078]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222078] RIP: 0033:0x22c483
[    3.222079] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222079] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222080] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222080] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222081] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.222081] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.222081] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222082] ---[ end trace bd91d80d59f05ba8 ]---
[    3.222082] odd readv on /395/cmdline/
[    3.222703] ------------[ cut here ]------------
[    3.222705] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.222706] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222707] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222708] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222708] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222709] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222709] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef200
[    3.222710] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8588
[    3.222710] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222710] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.222712] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.222713] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.222713] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.222714] Call Trace:
[    3.222715]  do_readv+0x18d/0x240
[    3.222716]  do_syscall_64+0x33/0x70
[    3.222717]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222718] RIP: 0033:0x22c483
[    3.222718] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222719] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222719] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222720] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222720] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.222721] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.222721] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222722] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222722] Call Trace:
[    3.222723]  dump_stack+0xa1/0xfb
[    3.222724]  __warn+0x7f/0x120
[    3.222725]  ? do_iter_read+0x182/0x1c0
[    3.222726]  report_bug+0xb1/0x110
[    3.222726]  handle_bug+0x3d/0x70
[    3.222727]  exc_invalid_op+0x18/0xb0
[    3.222727]  asm_exc_invalid_op+0x12/0x20
[    3.222728] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222729] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222729] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222730] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222730] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef200
[    3.222731] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8588
[    3.222731] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222731] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.222732]  ? do_iter_write+0x1d0/0x1d0
[    3.222733]  ? do_iter_read+0x4c/0x1c0
[    3.222734]  do_readv+0x18d/0x240
[    3.222735]  do_syscall_64+0x33/0x70
[    3.222736]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222736] RIP: 0033:0x22c483
[    3.222736] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222737] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222738] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222738] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222738] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.222739] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.222739] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222740] ---[ end trace bd91d80d59f05ba9 ]---
[    3.222740] odd readv on /396/cmdline/
[    3.222744] ------------[ cut here ]------------
[    3.222745] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.222746] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222746] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222747] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222747] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222748] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222748] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef200
[    3.222749] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8588
[    3.222749] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222749] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.222751] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.222751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.222752] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.222752] Call Trace:
[    3.222753]  do_readv+0x18d/0x240
[    3.222753]  do_syscall_64+0x33/0x70
[    3.222754]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222755] RIP: 0033:0x22c483
[    3.222755] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222756] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222756] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222757] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222757] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.222758] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.222758] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222767] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.222768] Call Trace:
[    3.222769]  dump_stack+0xa1/0xfb
[    3.222770]  __warn+0x7f/0x120
[    3.222771]  ? do_iter_read+0x182/0x1c0
[    3.222772]  report_bug+0xb1/0x110
[    3.222772]  handle_bug+0x3d/0x70
[    3.222773]  exc_invalid_op+0x18/0xb0
[    3.222773]  asm_exc_invalid_op+0x12/0x20
[    3.222774] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.222775] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.222776] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.222776] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.222777] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef200
[    3.222777] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8588
[    3.222778] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.222778] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.222779]  ? do_iter_write+0x1d0/0x1d0
[    3.222780]  ? do_iter_read+0x4c/0x1c0
[    3.222781]  do_readv+0x18d/0x240
[    3.222781]  do_syscall_64+0x33/0x70
[    3.222782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.222783] RIP: 0033:0x22c483
[    3.222783] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.222784] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.222784] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.222785] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.222785] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.222785] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.222786] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.222786] ---[ end trace bd91d80d59f05baa ]---
[    3.222787] odd readv on /396/cmdline/
[    3.231715] ------------[ cut here ]------------
[    3.231718] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.231719] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.231720] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.231721] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.231721] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.231722] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.231722] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.231723] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.231723] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.231724] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.231726] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.231726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.231727] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.231728] Call Trace:
[    3.231729]  do_readv+0x18d/0x240
[    3.231730]  do_syscall_64+0x33/0x70
[    3.231731]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.231732] RIP: 0033:0x22c483
[    3.231732] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.231733] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.231734] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.231734] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.231734] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.231735] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.231735] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.231736] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.231737] Call Trace:
[    3.231738]  dump_stack+0xa1/0xfb
[    3.231739]  __warn+0x7f/0x120
[    3.231739]  ? do_iter_read+0x182/0x1c0
[    3.231740]  report_bug+0xb1/0x110
[    3.231741]  handle_bug+0x3d/0x70
[    3.231741]  exc_invalid_op+0x18/0xb0
[    3.231742]  asm_exc_invalid_op+0x12/0x20
[    3.231743] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.231744] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.231744] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.231745] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.231745] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.231745] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.231746] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.231746] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.231747]  ? do_iter_write+0x1d0/0x1d0
[    3.231748]  ? do_iter_read+0x4c/0x1c0
[    3.231749]  do_readv+0x18d/0x240
[    3.231750]  do_syscall_64+0x33/0x70
[    3.231751]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.231751] RIP: 0033:0x22c483
[    3.231752] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.231752] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.231753] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.231765] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.231766] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.231766] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.231767] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.231767] ---[ end trace bd91d80d59f05bab ]---
[    3.231768] odd readv on /400/cmdline/
[    3.231772] ------------[ cut here ]------------
[    3.231774] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.231775] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.231776] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.231776] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.231777] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.231778] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.231778] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.231778] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.231779] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.231779] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.231781] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.231781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.231782] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.231783] Call Trace:
[    3.231784]  do_readv+0x18d/0x240
[    3.231785]  do_syscall_64+0x33/0x70
[    3.231785]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.231786] RIP: 0033:0x22c483
[    3.231787] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.231787] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.231788] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.231788] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.231789] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.231789] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.231789] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.231790] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.231791] Call Trace:
[    3.231791]  dump_stack+0xa1/0xfb
[    3.231792]  __warn+0x7f/0x120
[    3.231793]  ? do_iter_read+0x182/0x1c0
[    3.231794]  report_bug+0xb1/0x110
[    3.231794]  handle_bug+0x3d/0x70
[    3.231795]  exc_invalid_op+0x18/0xb0
[    3.231795]  asm_exc_invalid_op+0x12/0x20
[    3.231796] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.231797] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.231797] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.231798] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.231798] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.231798] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.231799] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.231799] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.231800]  ? do_iter_write+0x1d0/0x1d0
[    3.231801]  ? do_iter_read+0x4c/0x1c0
[    3.231802]  do_readv+0x18d/0x240
[    3.231802]  do_syscall_64+0x33/0x70
[    3.231803]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.231804] RIP: 0033:0x22c483
[    3.231804] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.231805] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.231805] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.231806] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.231806] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.231807] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.231807] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.231807] ---[ end trace bd91d80d59f05bac ]---
[    3.231808] odd readv on /400/cmdline/
[    3.232675] ------------[ cut here ]------------
[    3.232677] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.232678] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.232679] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.232680] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.232681] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.232681] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.232682] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.232682] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.232683] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.232683] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.232685] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.232685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.232686] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.232687] Call Trace:
[    3.232688]  do_readv+0x18d/0x240
[    3.232689]  do_syscall_64+0x33/0x70
[    3.232690]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.232691] RIP: 0033:0x22c483
[    3.232691] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.232692] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.232693] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.232693] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.232694] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.232694] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.232694] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.232695] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.232696] Call Trace:
[    3.232697]  dump_stack+0xa1/0xfb
[    3.232698]  __warn+0x7f/0x120
[    3.232698]  ? do_iter_read+0x182/0x1c0
[    3.232699]  report_bug+0xb1/0x110
[    3.232700]  handle_bug+0x3d/0x70
[    3.232700]  exc_invalid_op+0x18/0xb0
[    3.232701]  asm_exc_invalid_op+0x12/0x20
[    3.232702] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.232703] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.232703] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.232704] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.232704] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.232705] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.232705] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.232705] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.232706]  ? do_iter_write+0x1d0/0x1d0
[    3.232707]  ? do_iter_read+0x4c/0x1c0
[    3.232708]  do_readv+0x18d/0x240
[    3.232709]  do_syscall_64+0x33/0x70
[    3.232710]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.232710] RIP: 0033:0x22c483
[    3.232711] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.232711] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.232712] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.232712] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.232713] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.232713] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.232713] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.232714] ---[ end trace bd91d80d59f05bad ]---
[    3.232714] odd readv on /402/cmdline/
[    3.232720] ------------[ cut here ]------------
[    3.232721] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.232722] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.232723] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.232723] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.232724] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.232724] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.232725] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.232725] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.232725] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.232726] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.232727] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.232728] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.232728] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.232728] Call Trace:
[    3.232729]  do_readv+0x18d/0x240
[    3.232730]  do_syscall_64+0x33/0x70
[    3.232731]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.232731] RIP: 0033:0x22c483
[    3.232732] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.232732] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.232733] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.232733] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.232734] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.232734] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.232734] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.232735] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.232735] Call Trace:
[    3.232736]  dump_stack+0xa1/0xfb
[    3.232737]  __warn+0x7f/0x120
[    3.232738]  ? do_iter_read+0x182/0x1c0
[    3.232738]  report_bug+0xb1/0x110
[    3.232739]  handle_bug+0x3d/0x70
[    3.232740]  exc_invalid_op+0x18/0xb0
[    3.232740]  asm_exc_invalid_op+0x12/0x20
[    3.232741] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.232742] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.232742] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.232743] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.232743] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.232743] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.232744] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.232744] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.232745]  ? do_iter_write+0x1d0/0x1d0
[    3.232746]  ? do_iter_read+0x4c/0x1c0
[    3.232747]  do_readv+0x18d/0x240
[    3.232747]  do_syscall_64+0x33/0x70
[    3.232748]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.232749] RIP: 0033:0x22c483
[    3.232749] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.232750] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.232750] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.232751] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.232751] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.232751] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.232752] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.232752] ---[ end trace bd91d80d59f05bae ]---
[    3.232753] odd readv on /402/cmdline/
[    3.233675] ------------[ cut here ]------------
[    3.233678] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.233679] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.233680] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.233680] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.233681] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.233682] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.233682] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.233682] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.233683] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.233683] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.233685] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.233685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.233686] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.233687] Call Trace:
[    3.233688]  do_readv+0x18d/0x240
[    3.233689]  do_syscall_64+0x33/0x70
[    3.233690]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.233691] RIP: 0033:0x22c483
[    3.233691] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.233692] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.233692] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.233693] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.233693] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.233693] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.233694] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.233695] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.233695] Call Trace:
[    3.233696]  dump_stack+0xa1/0xfb
[    3.233697]  __warn+0x7f/0x120
[    3.233698]  ? do_iter_read+0x182/0x1c0
[    3.233698]  report_bug+0xb1/0x110
[    3.233699]  handle_bug+0x3d/0x70
[    3.233700]  exc_invalid_op+0x18/0xb0
[    3.233700]  asm_exc_invalid_op+0x12/0x20
[    3.233701] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.233702] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.233702] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.233703] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.233703] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.233703] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.233704] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.233704] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.233705]  ? do_iter_write+0x1d0/0x1d0
[    3.233706]  ? do_iter_read+0x4c/0x1c0
[    3.233707]  do_readv+0x18d/0x240
[    3.233707]  do_syscall_64+0x33/0x70
[    3.233708]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.233709] RIP: 0033:0x22c483
[    3.233709] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.233710] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.233710] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.233711] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.233711] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.233712] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.233712] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.233712] ---[ end trace bd91d80d59f05baf ]---
[    3.233713] odd readv on /405/cmdline/
[    3.233717] ------------[ cut here ]------------
[    3.233718] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.233718] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.233719] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.233720] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.233720] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.233721] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.233721] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.233721] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.233722] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.233722] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.233723] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.233724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.233724] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.233725] Call Trace:
[    3.233725]  do_readv+0x18d/0x240
[    3.233726]  do_syscall_64+0x33/0x70
[    3.233727]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.233727] RIP: 0033:0x22c483
[    3.233728] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.233728] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.233729] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.233729] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.233730] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.233730] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.233731] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.233731] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.233732] Call Trace:
[    3.233732]  dump_stack+0xa1/0xfb
[    3.233733]  __warn+0x7f/0x120
[    3.233734]  ? do_iter_read+0x182/0x1c0
[    3.233735]  report_bug+0xb1/0x110
[    3.233735]  handle_bug+0x3d/0x70
[    3.233736]  exc_invalid_op+0x18/0xb0
[    3.233736]  asm_exc_invalid_op+0x12/0x20
[    3.233737] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.233737] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.233738] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.233738] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.233739] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.233739] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.233740] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.233740] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.233741]  ? do_iter_write+0x1d0/0x1d0
[    3.233742]  ? do_iter_read+0x4c/0x1c0
[    3.233742]  do_readv+0x18d/0x240
[    3.233743]  do_syscall_64+0x33/0x70
[    3.233744]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.233744] RIP: 0033:0x22c483
[    3.233745] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.233745] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.233746] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.233746] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.233747] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.233747] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.233748] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.233748] ---[ end trace bd91d80d59f05bb0 ]---
[    3.233748] odd readv on /405/cmdline/
[    3.234790] ------------[ cut here ]------------
[    3.234792] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.234793] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.234794] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.234795] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.234796] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.234796] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.234797] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.234797] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.234798] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.234798] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.234800] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.234800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.234800] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.234801] Call Trace:
[    3.234803]  do_readv+0x18d/0x240
[    3.234804]  do_syscall_64+0x33/0x70
[    3.234805]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.234805] RIP: 0033:0x22c483
[    3.234806] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.234806] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.234807] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.234807] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.234808] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.234808] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.234808] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.234809] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.234809] Call Trace:
[    3.234810]  dump_stack+0xa1/0xfb
[    3.234811]  __warn+0x7f/0x120
[    3.234812]  ? do_iter_read+0x182/0x1c0
[    3.234813]  report_bug+0xb1/0x110
[    3.234813]  handle_bug+0x3d/0x70
[    3.234814]  exc_invalid_op+0x18/0xb0
[    3.234814]  asm_exc_invalid_op+0x12/0x20
[    3.234815] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.234816] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.234816] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.234817] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.234817] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.234818] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.234818] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.234818] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.234819]  ? do_iter_write+0x1d0/0x1d0
[    3.234820]  ? do_iter_read+0x4c/0x1c0
[    3.234821]  do_readv+0x18d/0x240
[    3.234822]  do_syscall_64+0x33/0x70
[    3.234822]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.234823] RIP: 0033:0x22c483
[    3.234823] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.234824] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.234824] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.234825] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.234825] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.234826] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.234826] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.234826] ---[ end trace bd91d80d59f05bb1 ]---
[    3.234827] odd readv on /408/cmdline/
[    3.234831] ------------[ cut here ]------------
[    3.234832] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.234832] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.234833] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.234834] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.234834] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.234834] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.234835] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.234835] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.234836] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.234836] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.234837] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.234838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.234838] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.234838] Call Trace:
[    3.234839]  do_readv+0x18d/0x240
[    3.234840]  do_syscall_64+0x33/0x70
[    3.234841]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.234841] RIP: 0033:0x22c483
[    3.234842] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.234842] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.234843] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.234843] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.234844] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.234844] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.234844] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.234845] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.234845] Call Trace:
[    3.234846]  dump_stack+0xa1/0xfb
[    3.234847]  __warn+0x7f/0x120
[    3.234848]  ? do_iter_read+0x182/0x1c0
[    3.234848]  report_bug+0xb1/0x110
[    3.234849]  handle_bug+0x3d/0x70
[    3.234849]  exc_invalid_op+0x18/0xb0
[    3.234850]  asm_exc_invalid_op+0x12/0x20
[    3.234851] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.234851] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.234852] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.234852] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.234853] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.234853] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.234853] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.234854] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.234855]  ? do_iter_write+0x1d0/0x1d0
[    3.234855]  ? do_iter_read+0x4c/0x1c0
[    3.234856]  do_readv+0x18d/0x240
[    3.234857]  do_syscall_64+0x33/0x70
[    3.234858]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.234858] RIP: 0033:0x22c483
[    3.234859] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.234859] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.234860] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.234860] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.234861] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.234861] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.234861] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.234862] ---[ end trace bd91d80d59f05bb2 ]---
[    3.234862] odd readv on /408/cmdline/
[    3.235552] ------------[ cut here ]------------
[    3.235554] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.235555] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.235556] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.235556] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.235557] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.235558] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.235558] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.235558] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.235559] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.235559] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.235561] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.235561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.235562] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.235563] Call Trace:
[    3.235564]  do_readv+0x18d/0x240
[    3.235565]  do_syscall_64+0x33/0x70
[    3.235566]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.235566] RIP: 0033:0x22c483
[    3.235567] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.235567] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.235568] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.235568] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.235569] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.235569] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.235570] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.235570] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.235571] Call Trace:
[    3.235572]  dump_stack+0xa1/0xfb
[    3.235572]  __warn+0x7f/0x120
[    3.235573]  ? do_iter_read+0x182/0x1c0
[    3.235574]  report_bug+0xb1/0x110
[    3.235574]  handle_bug+0x3d/0x70
[    3.235575]  exc_invalid_op+0x18/0xb0
[    3.235576]  asm_exc_invalid_op+0x12/0x20
[    3.235576] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.235577] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.235577] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.235578] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.235578] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.235579] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.235579] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.235580] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.235580]  ? do_iter_write+0x1d0/0x1d0
[    3.235581]  ? do_iter_read+0x4c/0x1c0
[    3.235582]  do_readv+0x18d/0x240
[    3.235583]  do_syscall_64+0x33/0x70
[    3.235584]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.235584] RIP: 0033:0x22c483
[    3.235585] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.235585] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.235586] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.235586] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.235586] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.235587] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.235587] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.235588] ---[ end trace bd91d80d59f05bb3 ]---
[    3.235588] odd readv on /410/cmdline/
[    3.235592] ------------[ cut here ]------------
[    3.235593] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.235593] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.235594] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.235595] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.235595] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.235595] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.235596] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.235596] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.235597] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.235597] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.235598] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.235599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.235599] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.235599] Call Trace:
[    3.235600]  do_readv+0x18d/0x240
[    3.235601]  do_syscall_64+0x33/0x70
[    3.235602]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.235602] RIP: 0033:0x22c483
[    3.235603] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.235603] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.235604] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.235604] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.235605] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.235605] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.235605] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.235606] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.235606] Call Trace:
[    3.235607]  dump_stack+0xa1/0xfb
[    3.235608]  __warn+0x7f/0x120
[    3.235609]  ? do_iter_read+0x182/0x1c0
[    3.235609]  report_bug+0xb1/0x110
[    3.235610]  handle_bug+0x3d/0x70
[    3.235610]  exc_invalid_op+0x18/0xb0
[    3.235611]  asm_exc_invalid_op+0x12/0x20
[    3.235612] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.235612] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.235613] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.235613] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.235614] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.235614] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.235614] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.235615] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.235616]  ? do_iter_write+0x1d0/0x1d0
[    3.235616]  ? do_iter_read+0x4c/0x1c0
[    3.235617]  do_readv+0x18d/0x240
[    3.235618]  do_syscall_64+0x33/0x70
[    3.235619]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.235619] RIP: 0033:0x22c483
[    3.235620] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.235620] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.235621] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.235621] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.235621] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.235622] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.235622] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.235623] ---[ end trace bd91d80d59f05bb4 ]---
[    3.235623] odd readv on /410/cmdline/
[    3.237998] ------------[ cut here ]------------
[    3.238000] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.238001] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238002] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238003] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238003] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238004] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238004] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.238005] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.238005] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238006] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.238007] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.238008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.238008] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.238009] Call Trace:
[    3.238010]  do_readv+0x18d/0x240
[    3.238011]  do_syscall_64+0x33/0x70
[    3.238012]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238013] RIP: 0033:0x22c483
[    3.238013] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238014] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238014] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238015] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238015] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.238016] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.238016] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238017] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238017] Call Trace:
[    3.238018]  dump_stack+0xa1/0xfb
[    3.238019]  __warn+0x7f/0x120
[    3.238020]  ? do_iter_read+0x182/0x1c0
[    3.238020]  report_bug+0xb1/0x110
[    3.238021]  handle_bug+0x3d/0x70
[    3.238022]  exc_invalid_op+0x18/0xb0
[    3.238022]  asm_exc_invalid_op+0x12/0x20
[    3.238023] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238023] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238024] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238024] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238025] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.238025] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.238026] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238026] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.238027]  ? do_iter_write+0x1d0/0x1d0
[    3.238028]  ? do_iter_read+0x4c/0x1c0
[    3.238029]  do_readv+0x18d/0x240
[    3.238029]  do_syscall_64+0x33/0x70
[    3.238030]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238031] RIP: 0033:0x22c483
[    3.238031] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238031] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238032] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238032] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238033] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.238033] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.238034] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238034] ---[ end trace bd91d80d59f05bb5 ]---
[    3.238035] odd readv on /412/cmdline/
[    3.238039] ------------[ cut here ]------------
[    3.238040] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.238041] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238042] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238042] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238043] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238043] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238043] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.238044] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.238044] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238045] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.238046] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.238046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.238047] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.238047] Call Trace:
[    3.238048]  do_readv+0x18d/0x240
[    3.238049]  do_syscall_64+0x33/0x70
[    3.238050]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238050] RIP: 0033:0x22c483
[    3.238050] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238051] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238051] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238052] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238052] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.238053] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.238053] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238054] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238054] Call Trace:
[    3.238055]  dump_stack+0xa1/0xfb
[    3.238056]  __warn+0x7f/0x120
[    3.238056]  ? do_iter_read+0x182/0x1c0
[    3.238057]  report_bug+0xb1/0x110
[    3.238058]  handle_bug+0x3d/0x70
[    3.238058]  exc_invalid_op+0x18/0xb0
[    3.238059]  asm_exc_invalid_op+0x12/0x20
[    3.238059] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238060] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238060] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238061] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238061] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.238062] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.238062] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238062] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.238063]  ? do_iter_write+0x1d0/0x1d0
[    3.238064]  ? do_iter_read+0x4c/0x1c0
[    3.238065]  do_readv+0x18d/0x240
[    3.238065]  do_syscall_64+0x33/0x70
[    3.238066]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238067] RIP: 0033:0x22c483
[    3.238067] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238068] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238068] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238069] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238069] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.238069] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.238070] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238070] ---[ end trace bd91d80d59f05bb6 ]---
[    3.238071] odd readv on /412/cmdline/
[    3.238713] ------------[ cut here ]------------
[    3.238715] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.238716] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238717] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238718] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238719] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238719] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238720] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.238720] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.238720] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238721] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.238722] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.238723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.238723] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.238724] Call Trace:
[    3.238726]  do_readv+0x18d/0x240
[    3.238726]  do_syscall_64+0x33/0x70
[    3.238727]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238728] RIP: 0033:0x22c483
[    3.238728] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238729] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238729] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238730] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238730] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.238731] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.238731] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238732] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238732] Call Trace:
[    3.238733]  dump_stack+0xa1/0xfb
[    3.238734]  __warn+0x7f/0x120
[    3.238735]  ? do_iter_read+0x182/0x1c0
[    3.238736]  report_bug+0xb1/0x110
[    3.238736]  handle_bug+0x3d/0x70
[    3.238737]  exc_invalid_op+0x18/0xb0
[    3.238737]  asm_exc_invalid_op+0x12/0x20
[    3.238738] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238739] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238739] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238740] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238740] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.238740] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.238741] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238741] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.238742]  ? do_iter_write+0x1d0/0x1d0
[    3.238743]  ? do_iter_read+0x4c/0x1c0
[    3.238744]  do_readv+0x18d/0x240
[    3.238744]  do_syscall_64+0x33/0x70
[    3.238745]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238746] RIP: 0033:0x22c483
[    3.238746] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238747] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238747] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238748] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238748] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.238748] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.238749] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238749] ---[ end trace bd91d80d59f05bb7 ]---
[    3.238750] odd readv on /414/cmdline/
[    3.238754] ------------[ cut here ]------------
[    3.238755] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.238755] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238756] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238757] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238757] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238757] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238758] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.238758] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.238759] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238759] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.238769] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.238770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.238771] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.238772] Call Trace:
[    3.238773]  do_readv+0x18d/0x240
[    3.238774]  do_syscall_64+0x33/0x70
[    3.238775]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238775] RIP: 0033:0x22c483
[    3.238776] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238777] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238777] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238778] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238778] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.238779] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.238779] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238780] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.238780] Call Trace:
[    3.238791]  dump_stack+0xa1/0xfb
[    3.238793]  __warn+0x7f/0x120
[    3.238794]  ? do_iter_read+0x182/0x1c0
[    3.238794]  report_bug+0xb1/0x110
[    3.238795]  handle_bug+0x3d/0x70
[    3.238795]  exc_invalid_op+0x18/0xb0
[    3.238796]  asm_exc_invalid_op+0x12/0x20
[    3.238797] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.238798] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.238798] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.238799] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.238799] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.238800] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.238800] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.238801] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.238801]  ? do_iter_write+0x1d0/0x1d0
[    3.238802]  ? do_iter_read+0x4c/0x1c0
[    3.238803]  do_readv+0x18d/0x240
[    3.238804]  do_syscall_64+0x33/0x70
[    3.238805]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.238805] RIP: 0033:0x22c483
[    3.238806] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.238806] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.238807] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.238807] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.238808] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.238808] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.238808] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.238809] ---[ end trace bd91d80d59f05bb8 ]---
[    3.238810] odd readv on /414/cmdline/
[    3.387444] ------------[ cut here ]------------
[    3.387448] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.387450] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.387451] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.387452] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.387453] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.387454] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.387455] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef080
[    3.387455] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.387456] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.387456] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.387458] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.387459] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.387459] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.387460] Call Trace:
[    3.387462]  do_readv+0x18d/0x240
[    3.387464]  do_syscall_64+0x33/0x70
[    3.387465]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.387466] RIP: 0033:0x22c483
[    3.387467] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.387467] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.387468] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.387469] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.387469] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.387470] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.387470] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.387471] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.387471] Call Trace:
[    3.387473]  dump_stack+0xa1/0xfb
[    3.387475]  __warn+0x7f/0x120
[    3.387476]  ? do_iter_read+0x182/0x1c0
[    3.387477]  report_bug+0xb1/0x110
[    3.387477]  handle_bug+0x3d/0x70
[    3.387478]  exc_invalid_op+0x18/0xb0
[    3.387479]  asm_exc_invalid_op+0x12/0x20
[    3.387480] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.387480] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.387481] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.387481] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.387482] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef080
[    3.387482] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.387483] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.387483] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.387484]  ? do_iter_write+0x1d0/0x1d0
[    3.387485]  ? do_iter_read+0x4c/0x1c0
[    3.387486]  do_readv+0x18d/0x240
[    3.387486]  do_syscall_64+0x33/0x70
[    3.387487]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.387488] RIP: 0033:0x22c483
[    3.387488] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.387489] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.387490] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.387490] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.387490] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.387491] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.387491] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.387492] ---[ end trace bd91d80d59f05bb9 ]---
[    3.387492] odd readv on /433/cmdline/
[    3.387496] ------------[ cut here ]------------
[    3.387498] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.387498] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.387499] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.387500] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.387500] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.387500] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.387501] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef080
[    3.387501] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.387502] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.387502] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.387503] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.387504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.387504] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.387505] Call Trace:
[    3.387505]  do_readv+0x18d/0x240
[    3.387506]  do_syscall_64+0x33/0x70
[    3.387507]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.387508] RIP: 0033:0x22c483
[    3.387508] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.387509] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.387509] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.387510] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.387510] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.387511] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.387511] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.387512] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.387512] Call Trace:
[    3.387513]  dump_stack+0xa1/0xfb
[    3.387514]  __warn+0x7f/0x120
[    3.387514]  ? do_iter_read+0x182/0x1c0
[    3.387515]  report_bug+0xb1/0x110
[    3.387516]  handle_bug+0x3d/0x70
[    3.387516]  exc_invalid_op+0x18/0xb0
[    3.387517]  asm_exc_invalid_op+0x12/0x20
[    3.387518] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.387518] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.387518] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.387519] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.387519] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef080
[    3.387520] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee82e8
[    3.387520] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.387521] R13: 00007ffef20efe57 R14: ffffa3b240b9b600 R15: ffffb9be8080be48
[    3.387522]  ? do_iter_write+0x1d0/0x1d0
[    3.387522]  ? do_iter_read+0x4c/0x1c0
[    3.387523]  do_readv+0x18d/0x240
[    3.387524]  do_syscall_64+0x33/0x70
[    3.387525]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.387525] RIP: 0033:0x22c483
[    3.387526] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.387526] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.387527] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.387527] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.387528] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.387528] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.387528] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.387529] ---[ end trace bd91d80d59f05bba ]---
[    3.387529] odd readv on /433/cmdline/
[    3.389228] ------------[ cut here ]------------
[    3.389230] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.389231] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.389232] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.389233] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.389233] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.389234] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.389234] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee9c0
[    3.389235] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee92a8
[    3.389235] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.389235] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.389237] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.389238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.389238] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.389239] Call Trace:
[    3.389240]  do_readv+0x18d/0x240
[    3.389241]  do_syscall_64+0x33/0x70
[    3.389242]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.389243] RIP: 0033:0x22c483
[    3.389244] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.389244] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.389245] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.389245] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.389245] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.389246] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.389246] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.389247] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.389247] Call Trace:
[    3.389248]  dump_stack+0xa1/0xfb
[    3.389249]  __warn+0x7f/0x120
[    3.389250]  ? do_iter_read+0x182/0x1c0
[    3.389251]  report_bug+0xb1/0x110
[    3.389251]  handle_bug+0x3d/0x70
[    3.389252]  exc_invalid_op+0x18/0xb0
[    3.389253]  asm_exc_invalid_op+0x12/0x20
[    3.389254] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.389254] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.389255] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.389255] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.389256] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee9c0
[    3.389256] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee92a8
[    3.389256] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.389257] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.389258]  ? do_iter_write+0x1d0/0x1d0
[    3.389258]  ? do_iter_read+0x4c/0x1c0
[    3.389259]  do_readv+0x18d/0x240
[    3.389260]  do_syscall_64+0x33/0x70
[    3.389261]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.389261] RIP: 0033:0x22c483
[    3.389262] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.389262] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.389263] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.389263] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.389264] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.389264] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.389265] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.389265] ---[ end trace bd91d80d59f05bbb ]---
[    3.389266] odd readv on /436/cmdline/
[    3.389271] ------------[ cut here ]------------
[    3.389272] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.389273] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.389273] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.389274] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.389274] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.389275] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.389275] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee9c0
[    3.389276] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee92a8
[    3.389276] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.389276] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.389278] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.389278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.389279] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.389279] Call Trace:
[    3.389280]  do_readv+0x18d/0x240
[    3.389280]  do_syscall_64+0x33/0x70
[    3.389281]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.389282] RIP: 0033:0x22c483
[    3.389282] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.389283] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.389283] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.389284] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.389284] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.389285] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.389285] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.389286] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.389286] Call Trace:
[    3.389287]  dump_stack+0xa1/0xfb
[    3.389287]  __warn+0x7f/0x120
[    3.389288]  ? do_iter_read+0x182/0x1c0
[    3.389289]  report_bug+0xb1/0x110
[    3.389289]  handle_bug+0x3d/0x70
[    3.389290]  exc_invalid_op+0x18/0xb0
[    3.389291]  asm_exc_invalid_op+0x12/0x20
[    3.389291] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.389292] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.389292] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.389293] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.389293] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee9c0
[    3.389294] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee92a8
[    3.389294] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.389294] R13: 00007ffef20efe57 R14: ffffa3b240b9b000 R15: ffffb9be8080be48
[    3.389295]  ? do_iter_write+0x1d0/0x1d0
[    3.389296]  ? do_iter_read+0x4c/0x1c0
[    3.389297]  do_readv+0x18d/0x240
[    3.389297]  do_syscall_64+0x33/0x70
[    3.389298]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.389299] RIP: 0033:0x22c483
[    3.389299] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.389300] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.389300] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.389301] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.389301] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.389302] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.389302] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.389302] ---[ end trace bd91d80d59f05bbc ]---
[    3.389303] odd readv on /436/cmdline/
[    3.390295] ------------[ cut here ]------------
[    3.390298] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.390299] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.390300] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.390300] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.390301] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.390302] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.390302] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef980
[    3.390302] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.390303] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.390303] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.390305] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.390305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.390306] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.390307] Call Trace:
[    3.390308]  do_readv+0x18d/0x240
[    3.390309]  do_syscall_64+0x33/0x70
[    3.390310]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.390310] RIP: 0033:0x22c483
[    3.390311] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.390311] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.390312] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.390313] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.390313] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.390313] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.390314] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.390315] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.390315] Call Trace:
[    3.390316]  dump_stack+0xa1/0xfb
[    3.390317]  __warn+0x7f/0x120
[    3.390317]  ? do_iter_read+0x182/0x1c0
[    3.390318]  report_bug+0xb1/0x110
[    3.390319]  handle_bug+0x3d/0x70
[    3.390319]  exc_invalid_op+0x18/0xb0
[    3.390320]  asm_exc_invalid_op+0x12/0x20
[    3.390321] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.390321] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.390321] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.390322] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.390322] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef980
[    3.390323] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.390323] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.390324] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.390324]  ? do_iter_write+0x1d0/0x1d0
[    3.390325]  ? do_iter_read+0x4c/0x1c0
[    3.390326]  do_readv+0x18d/0x240
[    3.390327]  do_syscall_64+0x33/0x70
[    3.390328]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.390328] RIP: 0033:0x22c483
[    3.390329] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.390329] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.390330] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.390330] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.390330] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.390331] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.390331] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.390332] ---[ end trace bd91d80d59f05bbd ]---
[    3.390332] odd readv on /437/cmdline/
[    3.390338] ------------[ cut here ]------------
[    3.390339] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.390339] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.390340] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.390341] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.390341] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.390342] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.390342] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef980
[    3.390342] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.390343] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.390343] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.390345] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.390345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.390345] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.390346] Call Trace:
[    3.390347]  do_readv+0x18d/0x240
[    3.390347]  do_syscall_64+0x33/0x70
[    3.390348]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.390349] RIP: 0033:0x22c483
[    3.390349] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.390349] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.390350] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.390351] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.390351] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.390351] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.390352] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.390352] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.390353] Call Trace:
[    3.390353]  dump_stack+0xa1/0xfb
[    3.390354]  __warn+0x7f/0x120
[    3.390355]  ? do_iter_read+0x182/0x1c0
[    3.390356]  report_bug+0xb1/0x110
[    3.390356]  handle_bug+0x3d/0x70
[    3.390357]  exc_invalid_op+0x18/0xb0
[    3.390357]  asm_exc_invalid_op+0x12/0x20
[    3.390358] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.390358] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.390359] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.390359] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.390360] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef980
[    3.390360] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eebca8
[    3.390361] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.390361] R13: 00007ffef20efe57 R14: ffffa3b240b9a400 R15: ffffb9be8080be48
[    3.390362]  ? do_iter_write+0x1d0/0x1d0
[    3.390363]  ? do_iter_read+0x4c/0x1c0
[    3.390363]  do_readv+0x18d/0x240
[    3.390364]  do_syscall_64+0x33/0x70
[    3.390365]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.390365] RIP: 0033:0x22c483
[    3.390366] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.390366] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.390367] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.390367] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.390368] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.390368] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.390369] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.390369] ---[ end trace bd91d80d59f05bbe ]---
[    3.390369] odd readv on /437/cmdline/
[    3.391276] ------------[ cut here ]------------
[    3.391278] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.391279] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.391280] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.391281] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.391281] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.391282] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.391282] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee900
[    3.391282] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.391283] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.391283] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.391285] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.391285] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.391286] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.391287] Call Trace:
[    3.391288]  do_readv+0x18d/0x240
[    3.391289]  do_syscall_64+0x33/0x70
[    3.391290]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.391290] RIP: 0033:0x22c483
[    3.391291] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.391291] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.391292] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.391292] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.391293] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.391293] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.391293] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.391294] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.391294] Call Trace:
[    3.391295]  dump_stack+0xa1/0xfb
[    3.391296]  __warn+0x7f/0x120
[    3.391297]  ? do_iter_read+0x182/0x1c0
[    3.391298]  report_bug+0xb1/0x110
[    3.391298]  handle_bug+0x3d/0x70
[    3.391299]  exc_invalid_op+0x18/0xb0
[    3.391299]  asm_exc_invalid_op+0x12/0x20
[    3.391300] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.391301] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.391301] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.391301] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.391302] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee900
[    3.391302] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.391303] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.391303] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.391304]  ? do_iter_write+0x1d0/0x1d0
[    3.391305]  ? do_iter_read+0x4c/0x1c0
[    3.391306]  do_readv+0x18d/0x240
[    3.391306]  do_syscall_64+0x33/0x70
[    3.391307]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.391307] RIP: 0033:0x22c483
[    3.391308] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.391308] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.391309] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.391309] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.391310] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.391310] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.391311] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.391311] ---[ end trace bd91d80d59f05bbf ]---
[    3.391311] odd readv on /438/cmdline/
[    3.391317] ------------[ cut here ]------------
[    3.391318] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.391319] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.391319] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.391320] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.391320] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.391321] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.391321] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee900
[    3.391322] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.391322] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.391322] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.391324] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.391324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.391324] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.391325] Call Trace:
[    3.391326]  do_readv+0x18d/0x240
[    3.391326]  do_syscall_64+0x33/0x70
[    3.391327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.391328] RIP: 0033:0x22c483
[    3.391328] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.391328] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.391329] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.391329] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.391330] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.391330] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.391331] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.391331] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.391332] Call Trace:
[    3.391332]  dump_stack+0xa1/0xfb
[    3.391333]  __warn+0x7f/0x120
[    3.391334]  ? do_iter_read+0x182/0x1c0
[    3.391334]  report_bug+0xb1/0x110
[    3.391335]  handle_bug+0x3d/0x70
[    3.391336]  exc_invalid_op+0x18/0xb0
[    3.391336]  asm_exc_invalid_op+0x12/0x20
[    3.391337] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.391337] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.391338] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.391338] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.391339] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee900
[    3.391339] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeba08
[    3.391339] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.391340] R13: 00007ffef20efe57 R14: ffffa3b240b9a200 R15: ffffb9be8080be48
[    3.391341]  ? do_iter_write+0x1d0/0x1d0
[    3.391341]  ? do_iter_read+0x4c/0x1c0
[    3.391342]  do_readv+0x18d/0x240
[    3.391343]  do_syscall_64+0x33/0x70
[    3.391344]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.391344] RIP: 0033:0x22c483
[    3.391345] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.391345] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.391346] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.391346] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.391346] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.391347] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.391347] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.391348] ---[ end trace bd91d80d59f05bc0 ]---
[    3.391348] odd readv on /438/cmdline/
[    3.392699] ------------[ cut here ]------------
[    3.392701] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.392702] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.392703] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.392704] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.392704] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.392705] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.392706] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef500
[    3.392706] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.392706] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.392707] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.392709] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.392709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.392709] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.392711] Call Trace:
[    3.392712]  do_readv+0x18d/0x240
[    3.392713]  do_syscall_64+0x33/0x70
[    3.392714]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.392714] RIP: 0033:0x22c483
[    3.392715] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.392715] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.392716] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.392716] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.392717] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.392717] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.392717] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.392718] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.392718] Call Trace:
[    3.392719]  dump_stack+0xa1/0xfb
[    3.392720]  __warn+0x7f/0x120
[    3.392721]  ? do_iter_read+0x182/0x1c0
[    3.392722]  report_bug+0xb1/0x110
[    3.392722]  handle_bug+0x3d/0x70
[    3.392723]  exc_invalid_op+0x18/0xb0
[    3.392723]  asm_exc_invalid_op+0x12/0x20
[    3.392724] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.392725] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.392725] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.392726] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.392726] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef500
[    3.392726] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.392727] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.392727] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.392728]  ? do_iter_write+0x1d0/0x1d0
[    3.392729]  ? do_iter_read+0x4c/0x1c0
[    3.392730]  do_readv+0x18d/0x240
[    3.392730]  do_syscall_64+0x33/0x70
[    3.392731]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.392732] RIP: 0033:0x22c483
[    3.392732] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.392733] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.392733] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.392734] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.392734] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.392735] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.392735] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.392735] ---[ end trace bd91d80d59f05bc1 ]---
[    3.392736] odd readv on /441/cmdline/
[    3.392742] ------------[ cut here ]------------
[    3.392743] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.392744] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.392745] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.392745] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.392745] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.392746] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.392746] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef500
[    3.392747] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.392747] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.392748] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.392749] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.392749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.392750] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.392750] Call Trace:
[    3.392751]  do_readv+0x18d/0x240
[    3.392751]  do_syscall_64+0x33/0x70
[    3.392752]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.392753] RIP: 0033:0x22c483
[    3.392753] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.392754] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.392754] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.392755] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.392755] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.392755] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.392756] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.392757] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.392757] Call Trace:
[    3.392758]  dump_stack+0xa1/0xfb
[    3.392758]  __warn+0x7f/0x120
[    3.392759]  ? do_iter_read+0x182/0x1c0
[    3.392760]  report_bug+0xb1/0x110
[    3.392760]  handle_bug+0x3d/0x70
[    3.392761]  exc_invalid_op+0x18/0xb0
[    3.392761]  asm_exc_invalid_op+0x12/0x20
[    3.392762] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.392763] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.392763] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.392764] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.392764] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef500
[    3.392764] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eea7a8
[    3.392765] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.392765] R13: 00007ffef20efe57 R14: ffffa3b240b9b400 R15: ffffb9be8080be48
[    3.392766]  ? do_iter_write+0x1d0/0x1d0
[    3.392775]  ? do_iter_read+0x4c/0x1c0
[    3.392777]  do_readv+0x18d/0x240
[    3.392778]  do_syscall_64+0x33/0x70
[    3.392779]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.392780] RIP: 0033:0x22c483
[    3.392780] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.392781] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.392782] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.392782] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.392783] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.392783] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.392783] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.392784] ---[ end trace bd91d80d59f05bc2 ]---
[    3.392784] odd readv on /441/cmdline/
[    3.393575] ------------[ cut here ]------------
[    3.393577] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.393578] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.393579] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.393579] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.393580] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.393581] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.393581] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee780
[    3.393581] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.393582] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.393582] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.393584] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.393584] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.393585] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.393586] Call Trace:
[    3.393587]  do_readv+0x18d/0x240
[    3.393588]  do_syscall_64+0x33/0x70
[    3.393589]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.393589] RIP: 0033:0x22c483
[    3.393590] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.393590] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.393591] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.393591] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.393592] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.393592] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.393593] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.393593] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.393594] Call Trace:
[    3.393594]  dump_stack+0xa1/0xfb
[    3.393595]  __warn+0x7f/0x120
[    3.393596]  ? do_iter_read+0x182/0x1c0
[    3.393597]  report_bug+0xb1/0x110
[    3.393597]  handle_bug+0x3d/0x70
[    3.393598]  exc_invalid_op+0x18/0xb0
[    3.393598]  asm_exc_invalid_op+0x12/0x20
[    3.393599] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.393600] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.393600] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.393601] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.393601] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee780
[    3.393601] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.393602] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.393602] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.393603]  ? do_iter_write+0x1d0/0x1d0
[    3.393604]  ? do_iter_read+0x4c/0x1c0
[    3.393605]  do_readv+0x18d/0x240
[    3.393605]  do_syscall_64+0x33/0x70
[    3.393606]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.393607] RIP: 0033:0x22c483
[    3.393607] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.393608] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.393608] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.393609] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.393609] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.393609] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.393610] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.393610] ---[ end trace bd91d80d59f05bc3 ]---
[    3.393611] odd readv on /442/cmdline/
[    3.393614] ------------[ cut here ]------------
[    3.393615] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.393616] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.393617] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.393617] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.393618] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.393618] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.393619] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee780
[    3.393619] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.393619] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.393620] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.393621] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.393622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.393622] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.393622] Call Trace:
[    3.393623]  do_readv+0x18d/0x240
[    3.393624]  do_syscall_64+0x33/0x70
[    3.393625]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.393625] RIP: 0033:0x22c483
[    3.393626] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.393626] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.393627] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.393627] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.393628] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.393628] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.393628] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.393629] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.393629] Call Trace:
[    3.393630]  dump_stack+0xa1/0xfb
[    3.393631]  __warn+0x7f/0x120
[    3.393631]  ? do_iter_read+0x182/0x1c0
[    3.393632]  report_bug+0xb1/0x110
[    3.393633]  handle_bug+0x3d/0x70
[    3.393633]  exc_invalid_op+0x18/0xb0
[    3.393634]  asm_exc_invalid_op+0x12/0x20
[    3.393635] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.393635] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.393635] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.393636] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.393636] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee780
[    3.393637] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8048
[    3.393637] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.393637] R13: 00007ffef20efe57 R14: ffffa3b240b9b900 R15: ffffb9be8080be48
[    3.393638]  ? do_iter_write+0x1d0/0x1d0
[    3.393639]  ? do_iter_read+0x4c/0x1c0
[    3.393640]  do_readv+0x18d/0x240
[    3.393641]  do_syscall_64+0x33/0x70
[    3.393641]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.393642] RIP: 0033:0x22c483
[    3.393642] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.393643] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.393643] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.393644] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.393644] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.393645] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.393645] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.393645] ---[ end trace bd91d80d59f05bc4 ]---
[    3.393646] odd readv on /442/cmdline/
[    3.395637] ------------[ cut here ]------------
[    3.395640] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.395641] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.395642] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.395643] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.395643] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.395644] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.395644] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeed80
[    3.395645] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.395645] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.395646] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.395648] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.395648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.395648] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.395650] Call Trace:
[    3.395651]  do_readv+0x18d/0x240
[    3.395652]  do_syscall_64+0x33/0x70
[    3.395653]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.395654] RIP: 0033:0x22c483
[    3.395654] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.395655] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.395656] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.395656] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.395656] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.395657] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.395657] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.395658] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.395659] Call Trace:
[    3.395659]  dump_stack+0xa1/0xfb
[    3.395660]  __warn+0x7f/0x120
[    3.395661]  ? do_iter_read+0x182/0x1c0
[    3.395662]  report_bug+0xb1/0x110
[    3.395663]  handle_bug+0x3d/0x70
[    3.395663]  exc_invalid_op+0x18/0xb0
[    3.395664]  asm_exc_invalid_op+0x12/0x20
[    3.395665] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.395665] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.395666] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.395666] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.395667] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeed80
[    3.395667] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.395668] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.395668] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.395669]  ? do_iter_write+0x1d0/0x1d0
[    3.395670]  ? do_iter_read+0x4c/0x1c0
[    3.395671]  do_readv+0x18d/0x240
[    3.395672]  do_syscall_64+0x33/0x70
[    3.395673]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.395673] RIP: 0033:0x22c483
[    3.395674] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.395674] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.395675] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.395675] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.395675] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.395676] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.395676] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.395677] ---[ end trace bd91d80d59f05bc5 ]---
[    3.395677] odd readv on /444/cmdline/
[    3.395682] ------------[ cut here ]------------
[    3.395683] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.395683] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.395684] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.395685] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.395685] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.395686] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.395686] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeed80
[    3.395686] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.395687] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.395687] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.395689] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.395689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.395689] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.395690] Call Trace:
[    3.395691]  do_readv+0x18d/0x240
[    3.395691]  do_syscall_64+0x33/0x70
[    3.395692]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.395693] RIP: 0033:0x22c483
[    3.395693] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.395694] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.395694] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.395695] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.395695] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.395695] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.395696] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.395696] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.395697] Call Trace:
[    3.395697]  dump_stack+0xa1/0xfb
[    3.395698]  __warn+0x7f/0x120
[    3.395699]  ? do_iter_read+0x182/0x1c0
[    3.395700]  report_bug+0xb1/0x110
[    3.395700]  handle_bug+0x3d/0x70
[    3.395701]  exc_invalid_op+0x18/0xb0
[    3.395701]  asm_exc_invalid_op+0x12/0x20
[    3.395702] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.395703] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.395703] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.395704] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.395704] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeed80
[    3.395704] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9fc8
[    3.395705] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.395705] R13: 00007ffef20efe57 R14: ffffa3b240b9b300 R15: ffffb9be8080be48
[    3.395706]  ? do_iter_write+0x1d0/0x1d0
[    3.395707]  ? do_iter_read+0x4c/0x1c0
[    3.395708]  do_readv+0x18d/0x240
[    3.395709]  do_syscall_64+0x33/0x70
[    3.395709]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.395710] RIP: 0033:0x22c483
[    3.395710] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.395711] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.395711] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.395712] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.395712] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.395713] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.395713] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.395713] ---[ end trace bd91d80d59f05bc6 ]---
[    3.395714] odd readv on /444/cmdline/
[    3.396069] ------------[ cut here ]------------
[    3.396072] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.396073] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396074] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396075] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396075] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396076] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396077] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef5c0
[    3.396077] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.396078] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396078] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.396080] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.396080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.396081] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.396082] Call Trace:
[    3.396083]  do_readv+0x18d/0x240
[    3.396084]  do_syscall_64+0x33/0x70
[    3.396086]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396086] RIP: 0033:0x22c483
[    3.396087] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396087] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396088] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396089] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396089] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396089] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396090] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396091] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396091] Call Trace:
[    3.396092]  dump_stack+0xa1/0xfb
[    3.396093]  __warn+0x7f/0x120
[    3.396094]  ? do_iter_read+0x182/0x1c0
[    3.396095]  report_bug+0xb1/0x110
[    3.396096]  handle_bug+0x3d/0x70
[    3.396096]  exc_invalid_op+0x18/0xb0
[    3.396097]  asm_exc_invalid_op+0x12/0x20
[    3.396098] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396098] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396099] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396099] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396100] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef5c0
[    3.396100] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.396101] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396101] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.396102]  ? do_iter_write+0x1d0/0x1d0
[    3.396103]  ? do_iter_read+0x4c/0x1c0
[    3.396104]  do_readv+0x18d/0x240
[    3.396104]  do_syscall_64+0x33/0x70
[    3.396105]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396106] RIP: 0033:0x22c483
[    3.396106] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396107] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396107] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396108] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396108] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396109] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396109] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396109] ---[ end trace bd91d80d59f05bc7 ]---
[    3.396110] odd readv on /446/cmdline/
[    3.396114] ------------[ cut here ]------------
[    3.396115] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.396116] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396116] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396117] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396117] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396118] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396118] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef5c0
[    3.396119] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.396119] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396119] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.396121] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.396121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.396122] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.396122] Call Trace:
[    3.396123]  do_readv+0x18d/0x240
[    3.396124]  do_syscall_64+0x33/0x70
[    3.396125]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396125] RIP: 0033:0x22c483
[    3.396126] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396126] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396127] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396127] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396128] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.396128] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.396128] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396129] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396129] Call Trace:
[    3.396130]  dump_stack+0xa1/0xfb
[    3.396131]  __warn+0x7f/0x120
[    3.396132]  ? do_iter_read+0x182/0x1c0
[    3.396132]  report_bug+0xb1/0x110
[    3.396133]  handle_bug+0x3d/0x70
[    3.396134]  exc_invalid_op+0x18/0xb0
[    3.396134]  asm_exc_invalid_op+0x12/0x20
[    3.396135] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396135] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396136] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396137] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396137] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef5c0
[    3.396137] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee97e8
[    3.396138] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396138] R13: 00007ffef20efe57 R14: ffffa3b240b9a700 R15: ffffb9be8080be48
[    3.396139]  ? do_iter_write+0x1d0/0x1d0
[    3.396140]  ? do_iter_read+0x4c/0x1c0
[    3.396141]  do_readv+0x18d/0x240
[    3.396141]  do_syscall_64+0x33/0x70
[    3.396142]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396143] RIP: 0033:0x22c483
[    3.396143] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396144] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396144] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396145] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396145] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.396146] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.396146] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396147] ---[ end trace bd91d80d59f05bc8 ]---
[    3.396147] odd readv on /446/cmdline/
[    3.396674] ------------[ cut here ]------------
[    3.396676] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.396677] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396678] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396679] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396680] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396680] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396681] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef740
[    3.396681] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8d68
[    3.396682] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396682] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.396684] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.396684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.396685] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.396686] Call Trace:
[    3.396687]  do_readv+0x18d/0x240
[    3.396688]  do_syscall_64+0x33/0x70
[    3.396689]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396690] RIP: 0033:0x22c483
[    3.396691] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396691] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396692] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396692] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396693] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396693] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396693] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396694] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396695] Call Trace:
[    3.396695]  dump_stack+0xa1/0xfb
[    3.396696]  __warn+0x7f/0x120
[    3.396697]  ? do_iter_read+0x182/0x1c0
[    3.396698]  report_bug+0xb1/0x110
[    3.396699]  handle_bug+0x3d/0x70
[    3.396699]  exc_invalid_op+0x18/0xb0
[    3.396700]  asm_exc_invalid_op+0x12/0x20
[    3.396701] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396701] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396702] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396702] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396703] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef740
[    3.396703] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8d68
[    3.396704] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396704] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.396705]  ? do_iter_write+0x1d0/0x1d0
[    3.396706]  ? do_iter_read+0x4c/0x1c0
[    3.396707]  do_readv+0x18d/0x240
[    3.396707]  do_syscall_64+0x33/0x70
[    3.396708]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396709] RIP: 0033:0x22c483
[    3.396709] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396710] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396710] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396711] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396711] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396712] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396712] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396713] ---[ end trace bd91d80d59f05bc9 ]---
[    3.396713] odd readv on /451/cmdline/
[    3.396717] ------------[ cut here ]------------
[    3.396718] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.396719] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396720] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396720] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396721] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396721] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396722] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef740
[    3.396722] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8d68
[    3.396723] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396723] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.396724] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.396725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.396725] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.396726] Call Trace:
[    3.396727]  do_readv+0x18d/0x240
[    3.396727]  do_syscall_64+0x33/0x70
[    3.396728]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396729] RIP: 0033:0x22c483
[    3.396729] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396729] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396730] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396731] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396731] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396731] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396732] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396733] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396733] Call Trace:
[    3.396734]  dump_stack+0xa1/0xfb
[    3.396734]  __warn+0x7f/0x120
[    3.396736]  ? do_iter_read+0x182/0x1c0
[    3.396736]  report_bug+0xb1/0x110
[    3.396737]  handle_bug+0x3d/0x70
[    3.396737]  exc_invalid_op+0x18/0xb0
[    3.396738]  asm_exc_invalid_op+0x12/0x20
[    3.396739] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396739] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396740] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396740] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396741] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef740
[    3.396741] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee8d68
[    3.396742] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396742] R13: 00007ffef20efe57 R14: ffffa3b240b9a000 R15: ffffb9be8080be48
[    3.396743]  ? do_iter_write+0x1d0/0x1d0
[    3.396744]  ? do_iter_read+0x4c/0x1c0
[    3.396744]  do_readv+0x18d/0x240
[    3.396745]  do_syscall_64+0x33/0x70
[    3.396746]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396746] RIP: 0033:0x22c483
[    3.396747] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396747] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396748] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396748] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396749] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396749] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396750] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396750] ---[ end trace bd91d80d59f05bca ]---
[    3.396751] odd readv on /451/cmdline/
[    3.396765] ------------[ cut here ]------------
[    3.396766] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.396777] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396779] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396779] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396780] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396781] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396781] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.396781] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.396782] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396782] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.396784] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.396784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.396784] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.396785] Call Trace:
[    3.396787]  do_readv+0x18d/0x240
[    3.396787]  do_syscall_64+0x33/0x70
[    3.396789]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396789] RIP: 0033:0x22c483
[    3.396790] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396790] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396791] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396791] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396792] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396792] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396792] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396793] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396794] Call Trace:
[    3.396794]  dump_stack+0xa1/0xfb
[    3.396795]  __warn+0x7f/0x120
[    3.396796]  ? do_iter_read+0x182/0x1c0
[    3.396797]  report_bug+0xb1/0x110
[    3.396797]  handle_bug+0x3d/0x70
[    3.396798]  exc_invalid_op+0x18/0xb0
[    3.396798]  asm_exc_invalid_op+0x12/0x20
[    3.396799] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396800] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396800] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396801] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396801] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.396801] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.396802] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396802] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.396803]  ? do_iter_write+0x1d0/0x1d0
[    3.396804]  ? do_iter_read+0x4c/0x1c0
[    3.396805]  do_readv+0x18d/0x240
[    3.396805]  do_syscall_64+0x33/0x70
[    3.396806]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396807] RIP: 0033:0x22c483
[    3.396807] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396808] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396808] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396809] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396809] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396810] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396810] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396810] ---[ end trace bd91d80d59f05bcb ]---
[    3.396811] odd readv on /450/cmdline/
[    3.396816] ------------[ cut here ]------------
[    3.396817] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.396817] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396818] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396819] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396819] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396820] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396820] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.396820] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.396821] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396821] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.396823] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.396823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.396824] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.396824] Call Trace:
[    3.396825]  do_readv+0x18d/0x240
[    3.396825]  do_syscall_64+0x33/0x70
[    3.396826]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396827] RIP: 0033:0x22c483
[    3.396827] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396828] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396828] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396829] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396829] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396829] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396830] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396831] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.396831] Call Trace:
[    3.396832]  dump_stack+0xa1/0xfb
[    3.396832]  __warn+0x7f/0x120
[    3.396833]  ? do_iter_read+0x182/0x1c0
[    3.396834]  report_bug+0xb1/0x110
[    3.396834]  handle_bug+0x3d/0x70
[    3.396835]  exc_invalid_op+0x18/0xb0
[    3.396835]  asm_exc_invalid_op+0x12/0x20
[    3.396836] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.396837] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.396837] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.396838] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.396838] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefa40
[    3.396839] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9008
[    3.396839] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.396839] R13: 00007ffef20efe57 R14: ffffa3b240b9b800 R15: ffffb9be8080be48
[    3.396840]  ? do_iter_write+0x1d0/0x1d0
[    3.396841]  ? do_iter_read+0x4c/0x1c0
[    3.396842]  do_readv+0x18d/0x240
[    3.396843]  do_syscall_64+0x33/0x70
[    3.396843]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.396844] RIP: 0033:0x22c483
[    3.396844] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.396845] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.396845] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.396846] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.396846] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.396847] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.396847] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.396847] ---[ end trace bd91d80d59f05bcc ]---
[    3.396848] odd readv on /450/cmdline/
[    3.397127] ------------[ cut here ]------------
[    3.397129] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.397130] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.397131] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.397132] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.397133] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.397133] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.397134] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.397134] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.397135] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.397135] R13: 00007ffef20efe57 R14: ffffa3b240b9a500 R15: ffffb9be8080be48
[    3.397137] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.397137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.397137] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.397138] Call Trace:
[    3.397140]  do_readv+0x18d/0x240
[    3.397140]  do_syscall_64+0x33/0x70
[    3.397141]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.397142] RIP: 0033:0x22c483
[    3.397142] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.397143] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.397144] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.397144] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.397144] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.397145] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.397145] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.397146] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.397146] Call Trace:
[    3.397147]  dump_stack+0xa1/0xfb
[    3.397148]  __warn+0x7f/0x120
[    3.397149]  ? do_iter_read+0x182/0x1c0
[    3.397149]  report_bug+0xb1/0x110
[    3.397150]  handle_bug+0x3d/0x70
[    3.397150]  exc_invalid_op+0x18/0xb0
[    3.397151]  asm_exc_invalid_op+0x12/0x20
[    3.397152] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.397152] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.397153] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.397153] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.397154] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.397154] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.397155] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.397155] R13: 00007ffef20efe57 R14: ffffa3b240b9a500 R15: ffffb9be8080be48
[    3.397156]  ? do_iter_write+0x1d0/0x1d0
[    3.397157]  ? do_iter_read+0x4c/0x1c0
[    3.397157]  do_readv+0x18d/0x240
[    3.397158]  do_syscall_64+0x33/0x70
[    3.397159]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.397159] RIP: 0033:0x22c483
[    3.397160] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.397160] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.397161] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.397161] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.397162] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.397162] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.397163] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.397163] ---[ end trace bd91d80d59f05bcd ]---
[    3.397164] odd readv on /452/cmdline/
[    3.397167] ------------[ cut here ]------------
[    3.397168] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.397169] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.397169] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.397170] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.397170] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.397171] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.397171] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.397172] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.397172] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.397173] R13: 00007ffef20efe57 R14: ffffa3b240b9a500 R15: ffffb9be8080be48
[    3.397174] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.397174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.397175] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.397175] Call Trace:
[    3.397176]  do_readv+0x18d/0x240
[    3.397176]  do_syscall_64+0x33/0x70
[    3.397177]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.397178] RIP: 0033:0x22c483
[    3.397178] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.397179] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.397179] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.397180] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.397180] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.397181] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.397181] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.397182] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.397182] Call Trace:
[    3.397183]  dump_stack+0xa1/0xfb
[    3.397183]  __warn+0x7f/0x120
[    3.397184]  ? do_iter_read+0x182/0x1c0
[    3.397185]  report_bug+0xb1/0x110
[    3.397185]  handle_bug+0x3d/0x70
[    3.397186]  exc_invalid_op+0x18/0xb0
[    3.397187]  asm_exc_invalid_op+0x12/0x20
[    3.397187] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.397188] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.397188] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.397189] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.397189] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee6c0
[    3.397190] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249eeaa48
[    3.397190] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.397191] R13: 00007ffef20efe57 R14: ffffa3b240b9a500 R15: ffffb9be8080be48
[    3.397191]  ? do_iter_write+0x1d0/0x1d0
[    3.397192]  ? do_iter_read+0x4c/0x1c0
[    3.397193]  do_readv+0x18d/0x240
[    3.397194]  do_syscall_64+0x33/0x70
[    3.397195]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.397195] RIP: 0033:0x22c483
[    3.397196] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.397196] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.397197] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.397197] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.397198] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.397198] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.397198] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.397199] ---[ end trace bd91d80d59f05bce ]---
[    3.397199] odd readv on /452/cmdline/
[    3.398992] ------------[ cut here ]------------
[    3.398994] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.398995] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.398996] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.398997] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.398998] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.398998] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.398999] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.398999] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.399000] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399000] R13: 00007ffef20efe57 R14: ffffa3b240b9ba00 R15: ffffb9be8080be48
[    3.399002] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.399003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.399003] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.399004] Call Trace:
[    3.399006]  do_readv+0x18d/0x240
[    3.399006]  do_syscall_64+0x33/0x70
[    3.399008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399008] RIP: 0033:0x22c483
[    3.399009] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399009] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399010] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399011] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399011] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399011] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399012] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399013] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399013] Call Trace:
[    3.399014]  dump_stack+0xa1/0xfb
[    3.399015]  __warn+0x7f/0x120
[    3.399016]  ? do_iter_read+0x182/0x1c0
[    3.399017]  report_bug+0xb1/0x110
[    3.399017]  handle_bug+0x3d/0x70
[    3.399018]  exc_invalid_op+0x18/0xb0
[    3.399019]  asm_exc_invalid_op+0x12/0x20
[    3.399019] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.399020] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.399020] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.399021] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.399021] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.399022] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.399022] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399023] R13: 00007ffef20efe57 R14: ffffa3b240b9ba00 R15: ffffb9be8080be48
[    3.399024]  ? do_iter_write+0x1d0/0x1d0
[    3.399025]  ? do_iter_read+0x4c/0x1c0
[    3.399025]  do_readv+0x18d/0x240
[    3.399026]  do_syscall_64+0x33/0x70
[    3.399027]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399028] RIP: 0033:0x22c483
[    3.399028] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399029] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399029] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399030] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399030] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399030] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399031] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399031] ---[ end trace bd91d80d59f05bcf ]---
[    3.399032] odd readv on /454/cmdline/
[    3.399036] ------------[ cut here ]------------
[    3.399037] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.399037] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399038] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.399039] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.399039] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.399040] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.399040] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.399041] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.399041] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399041] R13: 00007ffef20efe57 R14: ffffa3b240b9ba00 R15: ffffb9be8080be48
[    3.399043] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.399043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.399044] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.399044] Call Trace:
[    3.399045]  do_readv+0x18d/0x240
[    3.399046]  do_syscall_64+0x33/0x70
[    3.399046]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399047] RIP: 0033:0x22c483
[    3.399047] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399048] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399048] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399049] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399049] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399050] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399050] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399051] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399051] Call Trace:
[    3.399052]  dump_stack+0xa1/0xfb
[    3.399053]  __warn+0x7f/0x120
[    3.399053]  ? do_iter_read+0x182/0x1c0
[    3.399054]  report_bug+0xb1/0x110
[    3.399055]  handle_bug+0x3d/0x70
[    3.399055]  exc_invalid_op+0x18/0xb0
[    3.399056]  asm_exc_invalid_op+0x12/0x20
[    3.399057] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.399057] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.399057] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.399058] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.399058] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee540
[    3.399059] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249ee9a88
[    3.399059] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399060] R13: 00007ffef20efe57 R14: ffffa3b240b9ba00 R15: ffffb9be8080be48
[    3.399060]  ? do_iter_write+0x1d0/0x1d0
[    3.399061]  ? do_iter_read+0x4c/0x1c0
[    3.399062]  do_readv+0x18d/0x240
[    3.399063]  do_syscall_64+0x33/0x70
[    3.399064]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399064] RIP: 0033:0x22c483
[    3.399065] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399065] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399066] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399066] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399067] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399067] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399067] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399068] ---[ end trace bd91d80d59f05bd0 ]---
[    3.399068] odd readv on /454/cmdline/
[    3.399941] ------------[ cut here ]------------
[    3.399943] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.399944] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399945] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.399946] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.399947] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.399947] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.399948] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.399948] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c2e8
[    3.399949] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399949] R13: 00007ffef20efe57 R14: ffffa3b240b9be00 R15: ffffb9be8080be48
[    3.399951] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.399951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.399952] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.399953] Call Trace:
[    3.399954]  do_readv+0x18d/0x240
[    3.399955]  do_syscall_64+0x33/0x70
[    3.399956]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399957] RIP: 0033:0x22c483
[    3.399957] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399958] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399958] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399959] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399959] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399960] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399960] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399961] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399961] Call Trace:
[    3.399962]  dump_stack+0xa1/0xfb
[    3.399963]  __warn+0x7f/0x120
[    3.399964]  ? do_iter_read+0x182/0x1c0
[    3.399965]  report_bug+0xb1/0x110
[    3.399965]  handle_bug+0x3d/0x70
[    3.399966]  exc_invalid_op+0x18/0xb0
[    3.399967]  asm_exc_invalid_op+0x12/0x20
[    3.399968] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.399968] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.399969] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.399969] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.399970] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.399970] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c2e8
[    3.399970] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399971] R13: 00007ffef20efe57 R14: ffffa3b240b9be00 R15: ffffb9be8080be48
[    3.399972]  ? do_iter_write+0x1d0/0x1d0
[    3.399973]  ? do_iter_read+0x4c/0x1c0
[    3.399973]  do_readv+0x18d/0x240
[    3.399974]  do_syscall_64+0x33/0x70
[    3.399975]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399976] RIP: 0033:0x22c483
[    3.399976] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399976] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399977] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399978] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399978] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399978] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399979] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399979] ---[ end trace bd91d80d59f05bd1 ]---
[    3.399980] odd readv on /459/cmdline/
[    3.399983] ------------[ cut here ]------------
[    3.399984] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.399985] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399986] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.399986] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.399987] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.399987] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.399988] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.399988] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c2e8
[    3.399989] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.399989] R13: 00007ffef20efe57 R14: ffffa3b240b9be00 R15: ffffb9be8080be48
[    3.399990] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.399991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.399991] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.399991] Call Trace:
[    3.399992]  do_readv+0x18d/0x240
[    3.399993]  do_syscall_64+0x33/0x70
[    3.399994]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.399994] RIP: 0033:0x22c483
[    3.399995] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.399995] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.399996] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.399996] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.399997] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.399997] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.399998] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.399998] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.399999] Call Trace:
[    3.399999]  dump_stack+0xa1/0xfb
[    3.400000]  __warn+0x7f/0x120
[    3.400001]  ? do_iter_read+0x182/0x1c0
[    3.400002]  report_bug+0xb1/0x110
[    3.400002]  handle_bug+0x3d/0x70
[    3.400003]  exc_invalid_op+0x18/0xb0
[    3.400003]  asm_exc_invalid_op+0x12/0x20
[    3.400004] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.400005] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.400005] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.400006] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.400006] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eefc80
[    3.400007] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c2e8
[    3.400007] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.400007] R13: 00007ffef20efe57 R14: ffffa3b240b9be00 R15: ffffb9be8080be48
[    3.400008]  ? do_iter_write+0x1d0/0x1d0
[    3.400009]  ? do_iter_read+0x4c/0x1c0
[    3.400010]  do_readv+0x18d/0x240
[    3.400011]  do_syscall_64+0x33/0x70
[    3.400012]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.400012] RIP: 0033:0x22c483
[    3.400013] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.400013] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.400014] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.400014] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.400015] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.400015] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.400015] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.400016] ---[ end trace bd91d80d59f05bd2 ]---
[    3.400016] odd readv on /459/cmdline/
[    3.400160] ------------[ cut here ]------------
[    3.400162] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.400163] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.400164] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.400164] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.400165] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.400166] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.400166] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.400166] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fca8
[    3.400167] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.400167] R13: 00007ffef20efe57 R14: ffffa3b240b9af00 R15: ffffb9be8080be48
[    3.400169] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.400169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.400170] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.400171] Call Trace:
[    3.400172]  do_readv+0x18d/0x240
[    3.400173]  do_syscall_64+0x33/0x70
[    3.400174]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.400175] RIP: 0033:0x22c483
[    3.400175] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.400175] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.400176] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.400177] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.400177] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.400177] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.400178] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.400179] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.400179] Call Trace:
[    3.400180]  dump_stack+0xa1/0xfb
[    3.400181]  __warn+0x7f/0x120
[    3.400181]  ? do_iter_read+0x182/0x1c0
[    3.400182]  report_bug+0xb1/0x110
[    3.400183]  handle_bug+0x3d/0x70
[    3.400183]  exc_invalid_op+0x18/0xb0
[    3.400184]  asm_exc_invalid_op+0x12/0x20
[    3.400185] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.400185] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.400185] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.400186] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.400186] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.400187] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fca8
[    3.400187] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.400188] R13: 00007ffef20efe57 R14: ffffa3b240b9af00 R15: ffffb9be8080be48
[    3.400189]  ? do_iter_write+0x1d0/0x1d0
[    3.400189]  ? do_iter_read+0x4c/0x1c0
[    3.400190]  do_readv+0x18d/0x240
[    3.400191]  do_syscall_64+0x33/0x70
[    3.400192]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.400192] RIP: 0033:0x22c483
[    3.400193] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.400193] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.400194] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.400194] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.400195] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.400195] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.400195] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.400196] ---[ end trace bd91d80d59f05bd3 ]---
[    3.400196] odd readv on /460/cmdline/
[    3.400201] ------------[ cut here ]------------
[    3.400202] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.400202] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.400203] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.400204] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.400204] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.400204] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.400205] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.400205] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fca8
[    3.400206] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.400206] R13: 00007ffef20efe57 R14: ffffa3b240b9af00 R15: ffffb9be8080be48
[    3.400207] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.400208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.400208] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.400209] Call Trace:
[    3.400209]  do_readv+0x18d/0x240
[    3.400210]  do_syscall_64+0x33/0x70
[    3.400211]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.400212] RIP: 0033:0x22c483
[    3.400212] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.400212] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.400213] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.400213] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.400214] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.400214] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.400215] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.400215] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.400216] Call Trace:
[    3.400216]  dump_stack+0xa1/0xfb
[    3.400217]  __warn+0x7f/0x120
[    3.400218]  ? do_iter_read+0x182/0x1c0
[    3.400219]  report_bug+0xb1/0x110
[    3.400219]  handle_bug+0x3d/0x70
[    3.400220]  exc_invalid_op+0x18/0xb0
[    3.400220]  asm_exc_invalid_op+0x12/0x20
[    3.400221] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.400222] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.400222] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.400222] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.400223] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eef680
[    3.400223] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fca8
[    3.400224] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.400224] R13: 00007ffef20efe57 R14: ffffa3b240b9af00 R15: ffffb9be8080be48
[    3.400225]  ? do_iter_write+0x1d0/0x1d0
[    3.400226]  ? do_iter_read+0x4c/0x1c0
[    3.400227]  do_readv+0x18d/0x240
[    3.400227]  do_syscall_64+0x33/0x70
[    3.400228]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.400229] RIP: 0033:0x22c483
[    3.400229] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.400230] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.400230] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.400231] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.400231] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.400231] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.400232] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.400232] ---[ end trace bd91d80d59f05bd4 ]---
[    3.400233] odd readv on /460/cmdline/
[    3.401793] ------------[ cut here ]------------
[    3.401796] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.401797] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.401798] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.401799] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.401799] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.401800] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.401801] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.401801] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fa08
[    3.401801] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.401802] R13: 00007ffef20efe57 R14: ffffa3b240b9aa00 R15: ffffb9be8080be48
[    3.401804] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.401804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.401805] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.401806] Call Trace:
[    3.401807]  do_readv+0x18d/0x240
[    3.401808]  do_syscall_64+0x33/0x70
[    3.401809]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.401810] RIP: 0033:0x22c483
[    3.401810] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.401811] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.401812] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.401812] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.401812] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.401813] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.401813] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.401814] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.401815] Call Trace:
[    3.401816]  dump_stack+0xa1/0xfb
[    3.401817]  __warn+0x7f/0x120
[    3.401817]  ? do_iter_read+0x182/0x1c0
[    3.401818]  report_bug+0xb1/0x110
[    3.401819]  handle_bug+0x3d/0x70
[    3.401819]  exc_invalid_op+0x18/0xb0
[    3.401820]  asm_exc_invalid_op+0x12/0x20
[    3.401821] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.401822] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.401822] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.401823] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.401823] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.401823] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fa08
[    3.401824] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.401824] R13: 00007ffef20efe57 R14: ffffa3b240b9aa00 R15: ffffb9be8080be48
[    3.401825]  ? do_iter_write+0x1d0/0x1d0
[    3.401826]  ? do_iter_read+0x4c/0x1c0
[    3.401827]  do_readv+0x18d/0x240
[    3.401828]  do_syscall_64+0x33/0x70
[    3.401829]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.401829] RIP: 0033:0x22c483
[    3.401830] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.401830] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.401831] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.401831] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.401832] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.401832] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.401832] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.401833] ---[ end trace bd91d80d59f05bd5 ]---
[    3.401834] odd readv on /462/cmdline/
[    3.401837] ------------[ cut here ]------------
[    3.401838] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.401839] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.401840] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.401840] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.401841] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.401841] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.401842] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.401842] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fa08
[    3.401843] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.401843] R13: 00007ffef20efe57 R14: ffffa3b240b9aa00 R15: ffffb9be8080be48
[    3.401844] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.401845] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.401845] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.401846] Call Trace:
[    3.401847]  do_readv+0x18d/0x240
[    3.401847]  do_syscall_64+0x33/0x70
[    3.401848]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.401849] RIP: 0033:0x22c483
[    3.401849] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.401850] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.401850] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.401851] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.401851] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.401851] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.401852] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.401853] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.401853] Call Trace:
[    3.401854]  dump_stack+0xa1/0xfb
[    3.401854]  __warn+0x7f/0x120
[    3.401855]  ? do_iter_read+0x182/0x1c0
[    3.401856]  report_bug+0xb1/0x110
[    3.401856]  handle_bug+0x3d/0x70
[    3.401857]  exc_invalid_op+0x18/0xb0
[    3.401858]  asm_exc_invalid_op+0x12/0x20
[    3.401858] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.401859] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.401859] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.401860] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.401860] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eee180
[    3.401861] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9fa08
[    3.401861] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.401861] R13: 00007ffef20efe57 R14: ffffa3b240b9aa00 R15: ffffb9be8080be48
[    3.401862]  ? do_iter_write+0x1d0/0x1d0
[    3.401863]  ? do_iter_read+0x4c/0x1c0
[    3.401864]  do_readv+0x18d/0x240
[    3.401865]  do_syscall_64+0x33/0x70
[    3.401866]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.401866] RIP: 0033:0x22c483
[    3.401867] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.401867] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.401868] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.401868] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.401869] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.401869] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.401869] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.401870] ---[ end trace bd91d80d59f05bd6 ]---
[    3.401870] odd readv on /462/cmdline/
[    3.402648] ------------[ cut here ]------------
[    3.402650] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.402651] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.402652] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.402653] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.402653] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.402654] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.402655] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeee40
[    3.402655] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9da88
[    3.402655] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.402656] R13: 00007ffef20efe57 R14: ffffa3b240b9a900 R15: ffffb9be8080be48
[    3.402657] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.402658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.402658] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.402659] Call Trace:
[    3.402661]  do_readv+0x18d/0x240
[    3.402662]  do_syscall_64+0x33/0x70
[    3.402663]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.402663] RIP: 0033:0x22c483
[    3.402664] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.402665] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.402665] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.402666] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.402666] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.402667] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.402667] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.402668] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.402668] Call Trace:
[    3.402669]  dump_stack+0xa1/0xfb
[    3.402670]  __warn+0x7f/0x120
[    3.402671]  ? do_iter_read+0x182/0x1c0
[    3.402672]  report_bug+0xb1/0x110
[    3.402672]  handle_bug+0x3d/0x70
[    3.402673]  exc_invalid_op+0x18/0xb0
[    3.402673]  asm_exc_invalid_op+0x12/0x20
[    3.402674] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.402675] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.402675] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.402676] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.402676] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeee40
[    3.402677] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9da88
[    3.402677] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.402678] R13: 00007ffef20efe57 R14: ffffa3b240b9a900 R15: ffffb9be8080be48
[    3.402678]  ? do_iter_write+0x1d0/0x1d0
[    3.402679]  ? do_iter_read+0x4c/0x1c0
[    3.402680]  do_readv+0x18d/0x240
[    3.402681]  do_syscall_64+0x33/0x70
[    3.402682]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.402682] RIP: 0033:0x22c483
[    3.402683] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.402683] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.402684] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.402684] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.402685] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.402685] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.402686] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.402686] ---[ end trace bd91d80d59f05bd7 ]---
[    3.402687] odd readv on /467/cmdline/
[    3.402690] ------------[ cut here ]------------
[    3.402691] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.402692] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.402693] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.402693] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.402694] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.402694] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.402695] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeee40
[    3.402695] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9da88
[    3.402696] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.402696] R13: 00007ffef20efe57 R14: ffffa3b240b9a900 R15: ffffb9be8080be48
[    3.402697] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.402698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.402698] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.402699] Call Trace:
[    3.402699]  do_readv+0x18d/0x240
[    3.402700]  do_syscall_64+0x33/0x70
[    3.402701]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.402701] RIP: 0033:0x22c483
[    3.402702] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.402702] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.402703] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.402703] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.402704] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.402704] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.402705] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.402705] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.402706] Call Trace:
[    3.402706]  dump_stack+0xa1/0xfb
[    3.402707]  __warn+0x7f/0x120
[    3.402708]  ? do_iter_read+0x182/0x1c0
[    3.402709]  report_bug+0xb1/0x110
[    3.402709]  handle_bug+0x3d/0x70
[    3.402710]  exc_invalid_op+0x18/0xb0
[    3.402710]  asm_exc_invalid_op+0x12/0x20
[    3.402711] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.402712] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.402712] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.402713] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.402713] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeee40
[    3.402714] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9da88
[    3.402714] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.402714] R13: 00007ffef20efe57 R14: ffffa3b240b9a900 R15: ffffb9be8080be48
[    3.402715]  ? do_iter_write+0x1d0/0x1d0
[    3.402716]  ? do_iter_read+0x4c/0x1c0
[    3.402717]  do_readv+0x18d/0x240
[    3.402718]  do_syscall_64+0x33/0x70
[    3.402718]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.402719] RIP: 0033:0x22c483
[    3.402719] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.402720] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.402720] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.402721] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.402721] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.402722] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.402722] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.402722] ---[ end trace bd91d80d59f05bd8 ]---
[    3.402723] odd readv on /467/cmdline/
[    3.407012] ------------[ cut here ]------------
[    3.407014] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.407015] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.407017] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.407017] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.407018] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.407019] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.407019] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.407020] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9ea48
[    3.407020] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.407021] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    3.407022] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.407023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.407023] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.407024] Call Trace:
[    3.407026]  do_readv+0x18d/0x240
[    3.407027]  do_syscall_64+0x33/0x70
[    3.407028]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.407029] RIP: 0033:0x22c483
[    3.407029] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.407030] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.407031] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.407031] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.407032] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.407032] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.407032] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.407033] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.407034] Call Trace:
[    3.407035]  dump_stack+0xa1/0xfb
[    3.407036]  __warn+0x7f/0x120
[    3.407037]  ? do_iter_read+0x182/0x1c0
[    3.407037]  report_bug+0xb1/0x110
[    3.407038]  handle_bug+0x3d/0x70
[    3.407039]  exc_invalid_op+0x18/0xb0
[    3.407039]  asm_exc_invalid_op+0x12/0x20
[    3.407040] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.407041] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.407041] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.407042] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.407042] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.407043] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9ea48
[    3.407043] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.407043] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    3.407044]  ? do_iter_write+0x1d0/0x1d0
[    3.407045]  ? do_iter_read+0x4c/0x1c0
[    3.407046]  do_readv+0x18d/0x240
[    3.407047]  do_syscall_64+0x33/0x70
[    3.407048]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.407048] RIP: 0033:0x22c483
[    3.407049] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.407049] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.407050] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.407051] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.407051] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    3.407051] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    3.407052] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.407052] ---[ end trace bd91d80d59f05bd9 ]---
[    3.407053] odd readv on /468/cmdline/
[    3.407056] ------------[ cut here ]------------
[    3.407058] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    3.407058] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.407059] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.407060] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.407060] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.407061] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.407061] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.407061] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9ea48
[    3.407062] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.407062] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    3.407064] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    3.407064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.407064] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    3.407065] Call Trace:
[    3.407066]  do_readv+0x18d/0x240
[    3.407066]  do_syscall_64+0x33/0x70
[    3.407067]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.407068] RIP: 0033:0x22c483
[    3.407068] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.407069] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.407069] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.407070] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.407070] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.407071] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.407071] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.407072] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    3.407072] Call Trace:
[    3.407073]  dump_stack+0xa1/0xfb
[    3.407074]  __warn+0x7f/0x120
[    3.407074]  ? do_iter_read+0x182/0x1c0
[    3.407075]  report_bug+0xb1/0x110
[    3.407076]  handle_bug+0x3d/0x70
[    3.407076]  exc_invalid_op+0x18/0xb0
[    3.407077]  asm_exc_invalid_op+0x12/0x20
[    3.407078] RIP: 0010:do_iter_read+0x182/0x1c0
[    3.407078] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    3.407079] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    3.407079] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    3.407080] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeef00
[    3.407080] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9ea48
[    3.407080] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    3.407081] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    3.407082]  ? do_iter_write+0x1d0/0x1d0
[    3.407083]  ? do_iter_read+0x4c/0x1c0
[    3.407083]  do_readv+0x18d/0x240
[    3.407084]  do_syscall_64+0x33/0x70
[    3.407085]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    3.407085] RIP: 0033:0x22c483
[    3.407086] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    3.407086] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    3.407087] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    3.407087] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    3.407088] RBP: 00000000ffffffff R08: 8080808080808080 R09: fefefefefefefeff
[    3.407088] R10: 0a0a0a0a0a0a0a0a R11: 0000000000000257 R12: 0000000001631080
[    3.407089] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    3.407089] ---[ end trace bd91d80d59f05bda ]---
[    3.407090] odd readv on /468/cmdline/
[    4.135232] ------------[ cut here ]------------
[    4.135236] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    4.135238] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    4.135239] RIP: 0010:do_iter_read+0x182/0x1c0
[    4.135240] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    4.135241] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    4.135242] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    4.135242] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    4.135243] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c588
[    4.135243] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    4.135244] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    4.135246] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    4.135246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.135247] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    4.135248] Call Trace:
[    4.135250]  do_readv+0x18d/0x240
[    4.135252]  do_syscall_64+0x33/0x70
[    4.135253]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    4.135254] RIP: 0033:0x22c483
[    4.135255] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    4.135255] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    4.135256] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    4.135257] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    4.135257] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    4.135257] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    4.135258] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    4.135259] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    4.135259] Call Trace:
[    4.135261]  dump_stack+0xa1/0xfb
[    4.135262]  __warn+0x7f/0x120
[    4.135263]  ? do_iter_read+0x182/0x1c0
[    4.135264]  report_bug+0xb1/0x110
[    4.135265]  handle_bug+0x3d/0x70
[    4.135266]  exc_invalid_op+0x18/0xb0
[    4.135267]  asm_exc_invalid_op+0x12/0x20
[    4.135268] RIP: 0010:do_iter_read+0x182/0x1c0
[    4.135268] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    4.135269] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    4.135269] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    4.135270] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    4.135270] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c588
[    4.135271] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    4.135271] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    4.135272]  ? do_iter_write+0x1d0/0x1d0
[    4.135273]  ? do_iter_read+0x4c/0x1c0
[    4.135274]  do_readv+0x18d/0x240
[    4.135274]  do_syscall_64+0x33/0x70
[    4.135275]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    4.135276] RIP: 0033:0x22c483
[    4.135276] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    4.135277] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    4.135277] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    4.135278] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    4.135278] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    4.135279] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    4.135279] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    4.135280] ---[ end trace bd91d80d59f05bdb ]---
[    4.135281] odd readv on /470/cmdline/
[    4.135284] ------------[ cut here ]------------
[    4.135285] WARNING: CPU: 20 PID: 240 at fs/read_write.c:760 do_iter_read+0x182/0x1c0
[    4.135286] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    4.135287] RIP: 0010:do_iter_read+0x182/0x1c0
[    4.135287] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    4.135288] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    4.135288] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    4.135289] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    4.135289] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c588
[    4.135290] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    4.135290] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    4.135291] FS:  000000000029c800(0000) GS:ffffa3b537d00000(0000) knlGS:0000000000000000
[    4.135292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.135292] CR2: 00007ffef20edd40 CR3: 00000001073e0000 CR4: 0000000000350ea0
[    4.135292] Call Trace:
[    4.135293]  do_readv+0x18d/0x240
[    4.135294]  do_syscall_64+0x33/0x70
[    4.135295]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    4.135295] RIP: 0033:0x22c483
[    4.135296] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    4.135296] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    4.135297] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    4.135297] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    4.135298] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    4.135298] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    4.135299] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    4.135299] CPU: 20 PID: 240 Comm: telagent Tainted: G        W         5.10.0-rc2-microsoft-cbl-00002-g6a9f696d1627-dirty #2
[    4.135300] Call Trace:
[    4.135300]  dump_stack+0xa1/0xfb
[    4.135301]  __warn+0x7f/0x120
[    4.135302]  ? do_iter_read+0x182/0x1c0
[    4.135303]  report_bug+0xb1/0x110
[    4.135303]  handle_bug+0x3d/0x70
[    4.135304]  exc_invalid_op+0x18/0xb0
[    4.135304]  asm_exc_invalid_op+0x12/0x20
[    4.135305] RIP: 0010:do_iter_read+0x182/0x1c0
[    4.135306] Code: 85 c0 78 3b 48 01 c3 48 39 e8 0f 85 11 ff ff ff 4c 89 e7 48 89 ee e8 8d 66 48 00 49 8b 44 24 10 48 85 c0 75 9e e9 f7 fe ff ff <0f> 0b 48 c7 c7 5d 39 3c 90 4c 89 f6 31 c0 e8 d8 29 eb ff eb a7 48
[    4.135306] RSP: 0018:ffffb9be8080be08 EFLAGS: 00010246
[    4.135307] RAX: 0000000000000400 RBX: 0000000000000000 RCX: 0000000000000000
[    4.135307] RDX: ffffb9be8080be80 RSI: 0000000000020000 RDI: ffffa3b249eeefc0
[    4.135307] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffa3b249f9c588
[    4.135308] R10: ffffa3b537938000 R11: ffffffff8f295da0 R12: ffffb9be8080be50
[    4.135308] R13: 00007ffef20efe57 R14: ffffa3b240b9b100 R15: ffffb9be8080be48
[    4.135309]  ? do_iter_write+0x1d0/0x1d0
[    4.135310]  ? do_iter_read+0x4c/0x1c0
[    4.135311]  do_readv+0x18d/0x240
[    4.135311]  do_syscall_64+0x33/0x70
[    4.135312]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    4.135313] RIP: 0033:0x22c483
[    4.135313] Code: 4e 66 48 0f 7e c8 48 83 f8 01 48 89 d0 48 83 d0 ff 48 89 46 08 66 0f 7f 46 10 48 63 7f 78 b8 13 00 00 00 ba 02 00 00 00 0f 05 <48> 89 c7 e8 15 bb ff ff 48 85 c0 7e 34 48 89 c1 48 2b 4c 24 08 76
[    4.135314] RSP: 002b:00007ffef20efe10 EFLAGS: 00000257 ORIG_RAX: 0000000000000013
[    4.135314] RAX: ffffffffffffffda RBX: 0000000001631080 RCX: 000000000022c483
[    4.135315] RDX: 0000000000000002 RSI: 00007ffef20efe10 RDI: 0000000000000005
[    4.135315] RBP: 00000000ffffffff R08: fefefefefefefeff R09: 8080808080808080
[    4.135315] R10: 00007ffef20efca0 R11: 0000000000000257 R12: 0000000001631080
[    4.135316] R13: 00007ffef20efef8 R14: 0000000000000001 R15: 00007ffef20efe57
[    4.135316] ---[ end trace bd91d80d59f05bdc ]---
[    4.135317] odd readv on /470/cmdline/

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_err.txt"

[    0.060212] PCI: Fatal: No config space access function found
[    0.080214] kvm: no hardware support
[    0.080216] kvm: no hardware support
[    0.109031] hv_utils: cannot register PTP clock: 0
[    0.223318] odd readv on 238/net/tcp/
[    0.223464] init: (238) ERROR: LogException:36: LOCALHOST: Could not start localhost port scanner.
[    2.037636] odd readv on /245/cmdline/
[    2.037639] odd readv on /245/cmdline/
[    2.368030] odd readv on /cgroups/
[    2.372484] odd readv on /263/cmdline/
[    2.372487] odd readv on /263/cmdline/
[    2.388721] odd readv on /264/cmdline/
[    2.388724] odd readv on /264/cmdline/
[    2.389879] odd readv on /265/cmdline/
[    2.389881] odd readv on /265/cmdline/
[    2.390365] FS-Cache: Duplicate cookie detected
[    2.390366] FS-Cache: O-cookie c=0000000081335f67 [p=00000000c8ad7a4d fl=222 nc=0 na=1]
[    2.390367] FS-Cache: O-cookie d=0000000089df09d5 n=00000000b59c15d3
[    2.390367] FS-Cache: O-key=[10] '34323934393337353332'
[    2.390370] FS-Cache: N-cookie c=00000000cb133f9d [p=00000000c8ad7a4d fl=2 nc=0 na=1]
[    2.390371] FS-Cache: N-cookie d=0000000089df09d5 n=000000008027ecc5
[    2.390371] FS-Cache: N-key=[10] '34323934393337353332'
[    2.400488] odd readv on /9/mountinfo/
[    2.400499] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.400503] init: (9) ERROR: CreateProcessParseCommon:849: Failed to translate C:\Users\natec
[    2.400513] odd readv on /9/mountinfo/
[    2.400518] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.400520] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\system32
[    2.400522] odd readv on /9/mountinfo/
[    2.400526] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.400527] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows
[    2.400529] odd readv on /9/mountinfo/
[    2.400533] init: (9) ERROR: UtilFindMount:700: Invalid mountinfo line 14
[    2.400534] init: (9) ERROR: UtilTranslatePathList:2373: Failed to translate C:\Windows\System32\Wbem
[    2.400536] odd readv on /9/mountinfo/
[    2.400543] odd readv on /9/mountinfo/
[    2.400549] odd readv on /9/mountinfo/
[    2.400555] odd readv on /9/mountinfo/
[    2.400561] odd readv on /9/mountinfo/
[    2.400567] odd readv on /9/mountinfo/
[    2.400574] odd readv on /9/mountinfo/
[    2.400580] odd readv on /9/mountinfo/
[    2.403226] odd readv on /270/cmdline/
[    2.403228] odd readv on /270/cmdline/
[    2.426710] odd readv on /273/cmdline/
[    2.426713] odd readv on /273/cmdline/
[    2.428579] odd readv on /272/cmdline/
[    2.428582] odd readv on /272/cmdline/
[    2.430729] odd readv on /275/cmdline/
[    2.430731] odd readv on /275/cmdline/
[    2.432128] odd readv on /274/cmdline/
[    2.432131] odd readv on /274/cmdline/
[    2.434269] odd readv on /276/cmdline/
[    2.434271] odd readv on /276/cmdline/
[    2.438031] odd readv on /280/cmdline/
[    2.438034] odd readv on /280/cmdline/
[    2.440450] odd readv on /282/cmdline/
[    2.440453] odd readv on /282/cmdline/
[    2.444238] odd readv on /283/cmdline/
[    2.444240] odd readv on /283/cmdline/
[    2.446347] odd readv on /284/cmdline/
[    2.446349] odd readv on /284/cmdline/
[    2.451049] odd readv on /286/cmdline/
[    2.451052] odd readv on /286/cmdline/
[    2.771066] odd readv on /305/cmdline/
[    2.771070] odd readv on /305/cmdline/
[    2.780465] odd readv on /308/cmdline/
[    2.780468] odd readv on /308/cmdline/
[    2.781179] odd readv on /309/cmdline/
[    2.781182] odd readv on /309/cmdline/
[    2.795141] odd readv on /313/cmdline/
[    2.795143] odd readv on /313/cmdline/
[    2.796934] odd readv on /315/cmdline/
[    2.796937] odd readv on /315/cmdline/
[    2.799490] odd readv on /318/cmdline/
[    2.799492] odd readv on /318/cmdline/
[    2.801695] odd readv on /321/cmdline/
[    2.801698] odd readv on /321/cmdline/
[    2.803765] odd readv on /323/cmdline/
[    2.803767] odd readv on /323/cmdline/
[    2.810629] odd readv on /325/cmdline/
[    2.810631] odd readv on /325/cmdline/
[    2.811846] odd readv on /327/cmdline/
[    2.811849] odd readv on /327/cmdline/
[    2.969117] odd readv on /346/cmdline/
[    2.969121] odd readv on /346/cmdline/
[    2.971431] odd readv on /349/cmdline/
[    2.971434] odd readv on /349/cmdline/
[    2.981936] odd readv on /350/cmdline/
[    2.981938] odd readv on /350/cmdline/
[    2.982862] odd readv on /351/cmdline/
[    2.982865] odd readv on /351/cmdline/
[    2.984412] odd readv on /354/cmdline/
[    2.984415] odd readv on /354/cmdline/
[    2.985784] odd readv on /355/cmdline/
[    2.985786] odd readv on /355/cmdline/
[    2.987106] odd readv on /356/cmdline/
[    2.987108] odd readv on /356/cmdline/
[    3.001274] odd readv on /359/cmdline/
[    3.001276] odd readv on /359/cmdline/
[    3.003738] odd readv on /361/cmdline/
[    3.003740] odd readv on /361/cmdline/
[    3.005227] odd readv on /360/cmdline/
[    3.005229] odd readv on /360/cmdline/
[    3.006987] odd readv on /363/cmdline/
[    3.006989] odd readv on /363/cmdline/
[    3.008433] odd readv on /362/cmdline/
[    3.008435] odd readv on /362/cmdline/
[    3.010021] odd readv on /364/cmdline/
[    3.010023] odd readv on /364/cmdline/
[    3.012279] odd readv on /368/cmdline/
[    3.012281] odd readv on /368/cmdline/
[    3.014239] odd readv on /370/cmdline/
[    3.014241] odd readv on /370/cmdline/
[    3.016063] odd readv on /371/cmdline/
[    3.016065] odd readv on /371/cmdline/
[    3.017741] odd readv on /372/cmdline/
[    3.017743] odd readv on /372/cmdline/
[    3.020509] odd readv on /374/cmdline/
[    3.020511] odd readv on /374/cmdline/
[    3.157708] odd readv on /393/cmdline/
[    3.157711] odd readv on /393/cmdline/
[    3.163185] odd readv on /396/cmdline/
[    3.163187] odd readv on /396/cmdline/
[    3.163887] odd readv on /397/cmdline/
[    3.163890] odd readv on /397/cmdline/
[    3.172881] odd readv on /401/cmdline/
[    3.172884] odd readv on /401/cmdline/
[    3.173836] odd readv on /403/cmdline/
[    3.173839] odd readv on /403/cmdline/
[    3.174781] odd readv on /406/cmdline/
[    3.174783] odd readv on /406/cmdline/
[    3.175963] odd readv on /409/cmdline/
[    3.175966] odd readv on /409/cmdline/
[    3.176878] odd readv on /411/cmdline/
[    3.176880] odd readv on /411/cmdline/
[    3.179229] odd readv on /413/cmdline/
[    3.179231] odd readv on /413/cmdline/
[    3.179948] odd readv on /415/cmdline/
[    3.179951] odd readv on /415/cmdline/
[    3.326708] odd readv on /434/cmdline/
[    3.326712] odd readv on /434/cmdline/
[    3.328545] odd readv on /437/cmdline/
[    3.328548] odd readv on /437/cmdline/
[    3.329624] odd readv on /438/cmdline/
[    3.329627] odd readv on /438/cmdline/
[    3.330547] odd readv on /439/cmdline/
[    3.330550] odd readv on /439/cmdline/
[    3.332041] odd readv on /442/cmdline/
[    3.332044] odd readv on /442/cmdline/
[    3.332947] odd readv on /443/cmdline/
[    3.332950] odd readv on /443/cmdline/
[    3.335031] odd readv on /445/cmdline/
[    3.335033] odd readv on /445/cmdline/
[    3.335475] odd readv on /447/cmdline/
[    3.335477] odd readv on /447/cmdline/
[    3.335935] odd readv on /451/cmdline/
[    3.335938] odd readv on /451/cmdline/
[    3.336048] odd readv on /452/cmdline/
[    3.336051] odd readv on /452/cmdline/
[    3.336583] odd readv on /453/cmdline/
[    3.336585] odd readv on /453/cmdline/
[    3.338345] odd readv on /455/cmdline/
[    3.338349] odd readv on /455/cmdline/
[    3.339376] odd readv on /460/cmdline/
[    3.339378] odd readv on /460/cmdline/
[    3.339625] odd readv on /461/cmdline/
[    3.339628] odd readv on /461/cmdline/
[    3.341230] odd readv on /463/cmdline/
[    3.341233] odd readv on /463/cmdline/
[    3.341986] odd readv on /468/cmdline/
[    3.341988] odd readv on /468/cmdline/
[    3.346158] odd readv on /469/cmdline/
[    3.346161] odd readv on /469/cmdline/
[   35.475981] odd readv on /477/cmdline/
[   35.475984] odd readv on /477/cmdline/
[   35.478735] odd readv on /478/cmdline/
[   35.478738] odd readv on /478/cmdline/
[   35.479536] odd readv on /483/cmdline/
[   35.479539] odd readv on /483/cmdline/
[   35.479720] odd readv on /484/cmdline/
[   35.479722] odd readv on /484/cmdline/
[   35.481396] odd readv on /486/cmdline/
[   35.481400] odd readv on /486/cmdline/
[   35.482089] odd readv on /491/cmdline/
[   35.482092] odd readv on /491/cmdline/
[   35.484058] odd readv on /492/cmdline/
[   35.484060] odd readv on /492/cmdline/
[   70.032836] odd readv on /500/cmdline/
[   70.032840] odd readv on /500/cmdline/

--IS0zKkzwUGydFO0o--
