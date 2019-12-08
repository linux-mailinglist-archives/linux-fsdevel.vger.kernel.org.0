Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB6116102
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 06:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfLHFvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 00:51:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLHFvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:51:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so5523383pfb.0;
        Sat, 07 Dec 2019 21:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nYFwbpLaaswUDwrRriDYGVEu+aiGIUE5GwrUGVWIogs=;
        b=SqH0ZUHtV5w6vIrh8ywH6qMJlBblQA2fpSU3vCH3ONuSzuT3U7DmdF+cb2UCpf4Nae
         JEgDq7KDPMIOBArjKHDOWXROKPEJQZPdp2sHVIVyUorRiateM7oom04IOdJZH9I/w+XU
         ZoOdTINNE8WTVtCL60xEDhmgh6ds8ijdkl47IKWqriRF5IpKxZNbNSAGW5MzoGJr+ayG
         VNMpI3si7sdw0fSykpKlYxM67Y85A+DOvxCDfVMTMeznXJd4b/hWl/ZYs6Ua7FVV5S51
         VPAh/IdORpYLR9fWfLlkWBKM+SKkatziPglcPMrQ+0K0oZ46LW1lo3v6ejZi5KA7mL+u
         Hpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYFwbpLaaswUDwrRriDYGVEu+aiGIUE5GwrUGVWIogs=;
        b=Ua1+usmU35vNLTNxaL5O2JEAPdGUtnki80W1ZstDNYaksrYsUarkaQYQXwNsIXMHUw
         cNeJ2/GoP6KB/ZkebjViECJHGr6O4jt4cdiyzs5G1RihhBW08GVUU0BRgwi4lVGU6bDr
         RGwatMGZQOGt/T/ed5ZpddkyT1D3PFyFP1sr8zNkluMfE7UPypT5fWW7Yy5gDsc9EIhJ
         bxxMfmuoOTz+dB6W77dlso4f1z8xuVSX2HY2fHGUVocRuDYDXSbo9bj8yW93nwg5YPYp
         BKQgVMtUzIRT47J8bo9wUWtCpTLYKdVRhj7AWxSQIkc7G2rnVA3X780CdNYGSBI3mM5y
         lRiQ==
X-Gm-Message-State: APjAAAVijVebny4drbuSObtJbYxewWw8njsGEgtPdmo1G1n/VGFeCvEg
        mM7IzuJAmjZpcjnSUHP/vSpa07lH
X-Google-Smtp-Source: APXvYqxkTZ5n8iVdqPUrRNOtSrf+Jv96Wb4ztHxZHcQRio3VJpXbJQ0mkUrA2FY2D0n4B06esf6ncA==
X-Received: by 2002:a62:7711:: with SMTP id s17mr15188546pfc.88.1575784308846;
        Sat, 07 Dec 2019 21:51:48 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id k190sm20512799pga.73.2019.12.07.21.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 21:51:48 -0800 (PST)
Subject: Re: memory leak in fasync_helper
To:     syzbot <syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com>,
        bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>
References: <00000000000023dba505992ac8aa@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <50681a5e-96e1-da38-e936-f817389c8b65@gmail.com>
Date:   Sat, 7 Dec 2019 21:51:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <00000000000023dba505992ac8aa@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/7/19 9:45 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bf929479 Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123e91e2e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=874c75a332209d41
> dashboard link: https://syzkaller.appspot.com/bug?extid=4b1fe8105f8044a26162
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120faee2e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178a0ef6e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88812a4082a0 (size 48):
>   comm "syz-executor670", pid 6989, jiffies 4294952355 (age 19.520s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>     00 00 00 00 00 00 00 00 00 6b 05 1f 81 88 ff ff  .........k......
>   backtrace:
>     [<000000002a74b343>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
>     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
>     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
>     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
>     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
>     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
>     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
>     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
>     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0 arch/x86/entry/common.c:290
>     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff888128cdf240 (size 48):
>   comm "syz-executor670", pid 6990, jiffies 4294952942 (age 13.650s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>     00 00 00 00 00 00 00 00 00 d8 02 19 81 88 ff ff  ................
>   backtrace:
>     [<000000002a74b343>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
>     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
>     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
>     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
>     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
>     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
>     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
>     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
>     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0 arch/x86/entry/common.c:290
>     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff888128cdff60 (size 48):
>   comm "syz-executor670", pid 6991, jiffies 4294953529 (age 7.780s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 01 46 00 00 03 00 00 00  .........F......
>     00 00 00 00 00 00 00 00 00 63 05 1f 81 88 ff ff  .........c......
>   backtrace:
>     [<000000002a74b343>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>     [<000000002a74b343>] slab_post_alloc_hook mm/slab.h:586 [inline]
>     [<000000002a74b343>] slab_alloc mm/slab.c:3319 [inline]
>     [<000000002a74b343>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>     [<00000000fa370506>] fasync_alloc fs/fcntl.c:895 [inline]
>     [<00000000fa370506>] fasync_add_entry fs/fcntl.c:953 [inline]
>     [<00000000fa370506>] fasync_helper+0x37/0xa9 fs/fcntl.c:982
>     [<000000006c3eaaf1>] sock_fasync+0x4d/0xa0 net/socket.c:1293
>     [<0000000098076f55>] ioctl_fioasync fs/ioctl.c:550 [inline]
>     [<0000000098076f55>] do_vfs_ioctl+0x409/0x810 fs/ioctl.c:655
>     [<00000000df24d2b9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>     [<000000003fec9c80>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>     [<000000003fec9c80>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>     [<000000003fec9c80>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>     [<000000002bebbfe6>] do_syscall_64+0x73/0x1f0 arch/x86/entry/common.c:290
>     [<00000000722d8431>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patche


AF_SMC bug it seems....

Repro does essentially :

socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC) = 3
ioctl(3, FIOASYNC, [-1])   = 0
sendmsg(3, {msg_name=NULL, msg_namelen=0, msg_iov=NULL, msg_iovlen=0, msg_controllen=0, msg_flags=0}, MSG_FASTOPEN)


console logs :

__sock_release: fasync list not empty!


