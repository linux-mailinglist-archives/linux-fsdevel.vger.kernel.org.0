Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61833309FEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBABRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 20:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBABRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:17:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CFC0613ED
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jan 2021 17:16:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m12so160943pjs.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jan 2021 17:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RLU8sNVXRSwQvcQ9Qv8D6rwZxuEAO9er5VHUrLUQ6lo=;
        b=L2BSNt7JuuX3qwrFkNZjtFXfNANw5QJ85Zzv/tI14dXMoLSgBfFXpzNkCEQk/s7y+n
         c9pr4KSWgfja57hPagkEj3aixUcSalBsGKYezPNuM5yfObu8/dbV04WdroKRi/Rd0a4w
         O7Op0qUxgDVAKuovjloSRmC6zp8ufwg0s/wfHy8/sbP+huWE2bBFaNK0SHu7Z66ebzwf
         r4vJ8bEssS00XyFQhuv1gG82ev6Tu8DEyCSdg7CFvkSrHv19xK7s2AvSa8t8Cq2ux+g+
         DWjitlTOE0tXzXdee8aSLYl8CyS9NTAnBlNZXO4d2SLYFiJ/RLu6oOcYTz2Iw+p3kOZx
         L3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RLU8sNVXRSwQvcQ9Qv8D6rwZxuEAO9er5VHUrLUQ6lo=;
        b=jcL2SOoVuEGld9LkvRliARlHxuyizswFSSe/attBaIe6+ectrxooNGQ4aeYjVEzcQJ
         lsae5TkRFTculFIBbllracZc8ekv0+qCTHK3t0g0URFCVMzduRDBgvv+ENo6tE5fteDh
         HMJge3YLm1btMT1leAYIEL0JONqBEYO4MqigMYuHp4YvpygqCCqQJv98ETicOkUZ7W6Z
         TZs7HOO1n2jasf/Q4R1Yzn/LnbTOYv/6Zh5JYGGJKbzV32gCXuet8oxp8/86vQ35UDHX
         hkBYhx1OJuAL6Ygwycp973otnG6YceTDBlSll8Q87xLJlDByHs4Vz1Zpwr0fTY4EaD46
         sYRA==
X-Gm-Message-State: AOAM530zGXd5cF24Q8Cdm5nM8DfmUfWbJU16JrAIf9K9jbsRQwCpiXFx
        TDiJqlTGZURnLvZ4nZO/nxH/kw==
X-Google-Smtp-Source: ABdhPJy+7Y+iue1isMhdjoV1Xc/lHilNv71BbVLNluwnVBC9ltGuPGGKpSfDIeSgGZuBP/PW2ylyQQ==
X-Received: by 2002:a17:90a:7c08:: with SMTP id v8mr14272367pjf.135.1612142198128;
        Sun, 31 Jan 2021 17:16:38 -0800 (PST)
Received: from [10.8.1.62] ([89.187.162.118])
        by smtp.gmail.com with ESMTPSA id a37sm15527889pgm.79.2021.01.31.17.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 17:16:37 -0800 (PST)
Subject: Re: misc bio allocation cleanups
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20210126145247.1964410-1-hch@lst.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9d376309-5d67-d859-1ad0-a669bdb75cdd@cloud.ionos.com>
Date:   Mon, 1 Feb 2021 02:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

I tried with latest for-5.12/block branch, and got below issue when 
trying to create raid1 array.

[   80.605832] BUG: kernel NULL pointer dereference, address: 
0000000000000018
[   80.606159] #PF: supervisor read access in kernel mode
[   80.606159] #PF: error_code(0x0000) - not-present page
[   80.606159] PGD 0 P4D 0
[   80.606159] Oops: 0000 [#1] SMP NOPTI
[   80.606159] CPU: 1 PID: 207 Comm: mdadm Not tainted 5.11.0-rc5+ #37
[   80.606159] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[   80.606159] RIP: 0010:bdev_read_only+0x0/0x30
[   80.606159] Code: 89 df 5b 5d e9 71 21 e7 ff 81 e6 ff ff 0f 00 48 c7 
c7 40 99 d9 9e e8 0f e5 04 00 eb a0 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 
00 <80> 7f 18 00 b8 01 00 00 00 75 11 48 8b 97 60 03 00 00 48 8b 4a 40
[   80.606159] RSP: 0018:ffffb14f405dfd38 EFLAGS: 00000246
[   80.606159] RAX: 0000000000000000 RBX: ffff9b0e0863b018 RCX: 
ffff9b0e01edc000
[   80.606159] RDX: ffff9b0e01b54c00 RSI: ffff9b0e0863b000 RDI: 
0000000000000000
[   80.606159] RBP: ffff9b0e01272200 R08: 0000000000000000 R09: 
0000000000000000
[   80.606159] R10: ffffee978004da40 R11: 0000000000000cc0 R12: 
ffff9b0e0863b000
[   80.606159] R13: ffff9b0e01f2cc00 R14: ffff9b0e0863b000 R15: 
0000000000000000
[   80.606159] FS:  00007f522ec65740(0000) GS:ffff9b0e7bc80000(0000) 
knlGS:0000000000000000
[   80.606159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.606159] CR2: 0000000000000018 CR3: 0000000001364000 CR4: 
00000000000006e0
[   80.606159] Call Trace:
[   80.606159]  bind_rdev_to_array+0x2f7/0x380
[   80.606159]  ? cred_has_capability+0x80/0x120
[   80.606159]  md_add_new_disk+0x204/0x630
[   80.606159]  ? security_capable+0x33/0x50
[   80.606159]  md_ioctl+0xee7/0x1690
[   80.606159]  ? selinux_file_ioctl+0x143/0x200
[   80.606159]  blkdev_ioctl+0x1ff/0x240
[   80.606159]  block_ioctl+0x34/0x40
[   80.606159]  __x64_sys_ioctl+0x89/0xc0
[   80.606159]  do_syscall_64+0x33/0x40
[   80.606159]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   80.606159] RIP: 0033:0x7f522e564317
[   80.606159] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
[   80.606159] RSP: 002b:00007ffc3abd96f8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[   80.606159] RAX: ffffffffffffffda RBX: 00005653ee690350 RCX: 
00007f522e564317
[   80.606159] RDX: 00005653ee694058 RSI: 0000000040140921 RDI: 
0000000000000004
[   80.606159] RBP: 00005653ee690410 R08: 00007f522e839db0 R09: 
0000000000000000
[   80.606159] R10: 00005653ee690010 R11: 0000000000000246 R12: 
0000000000000000
[   80.606159] R13: 0000000000000000 R14: 0000000000000000 R15: 
00005653ee694010
[   80.606159] Modules linked in:
[   80.606159] CR2: 0000000000000018
[   80.622996] ---[ end trace 22144b856a3c1001 ]---
[   80.623285] RIP: 0010:bdev_read_only+0x0/0x30
[   80.623501] Code: 89 df 5b 5d e9 71 21 e7 ff 81 e6 ff ff 0f 00 48 c7 
c7 40 99 d9 9e e8 0f e5 04 00 eb a0 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 
00 <80> 7f 18 00 b8 01 00 00 00 75 11 48 8b 97 60 03 00 00 48 8b 4a 40
[   80.624544] RSP: 0018:ffffb14f405dfd38 EFLAGS: 00000246
[   80.624788] RAX: 0000000000000000 RBX: ffff9b0e0863b018 RCX: 
ffff9b0e01edc000
[   80.625136] RDX: ffff9b0e01b54c00 RSI: ffff9b0e0863b000 RDI: 
0000000000000000
[   80.625449] RBP: ffff9b0e01272200 R08: 0000000000000000 R09: 
0000000000000000
[   80.625761] R10: ffffee978004da40 R11: 0000000000000cc0 R12: 
ffff9b0e0863b000
[   80.626112] R13: ffff9b0e01f2cc00 R14: ffff9b0e0863b000 R15: 
0000000000000000
[   80.626429] FS:  00007f522ec65740(0000) GS:ffff9b0e7bc80000(0000) 
knlGS:0000000000000000
[   80.626784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.627035] CR2: 0000000000000018 CR3: 0000000001364000 CR4: 
00000000000006e0
Killed


Thanks,
Guoqing
