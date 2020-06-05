Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E561F015D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 23:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFEVNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgFEVNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:13:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37EC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 14:13:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so5557408pfb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G4zsN65tVjo4h0PPrs8ZYLeVnAJC5o0SA9zYRoPKl1c=;
        b=DQmPCkvmgf5un3rEsOUS042Sdj7ltJpIX/ZP+C8UHy3bCpemfJttxQWjg7GKaRgQH6
         pKYnP0PPGOstMnxjiYr8lXLdzOxn73e/ttW6sQzdBd1wGH9aNLZeejd4RI4opDyJ9YmJ
         30OPPgRrjRxtigXIS2FUWL0Dym52oIT3RQrz0iih7ko5Ckr88ew6vqD3DakutbyZUI8y
         7mTxjBdwZiLZGShu0FxnjBZjcjColUo8TyrGh+09T25BfUcJiC6CKJjs5QY952RLvOgy
         CEu0UO1H5pIOdR4x+veR/szyRLM97ZVL0p7D2ssdnhNhZvDH5O63226M5w+DM6qRLorE
         3lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G4zsN65tVjo4h0PPrs8ZYLeVnAJC5o0SA9zYRoPKl1c=;
        b=pAdrM8j9fRUqJtv9CstI0PJ3gPJVdz3evGMXgR5xKORCS5tIU/QcRWHx1LlpI9W9it
         qht1aQtggKWlsu33ovhOBG9V9l4UYESxnNMSTccLacKPS0Jvxg4p8Uq/hPsfGHVe4Sgf
         AR87y92VqHgbpg3dqrvvQlXokfJuKiUlHHSxltDfYXSld2fXsjimNQ58SUrH4aimhV9b
         FyBtid+L28zx6DIw/+gYdZcJHXrW5GRnUd4AISvNFTBhS/paU1y0p2XrmkbAT/p3kVJj
         +VELj8aEqh0zOZqiMM9yjJ/o0bc+Stpb7/JlKxpn4VQwVq2sDn6Znji3x/e4Qp691kIx
         oHcw==
X-Gm-Message-State: AOAM533IeHxUrS72fq6PWYmjZI/zYb0NmzMCRs656RnVLlc8Qn1UIDot
        xePMv28z9CoHmisV1UbYuAxbCABXqSPwrA==
X-Google-Smtp-Source: ABdhPJxFMHsNXswHPEMpuSUH7nFjQ/gUVUQ516FPn2f86I7UXwQG8aDPVM42krWjzOm71EvrUmSJZw==
X-Received: by 2002:a63:29c3:: with SMTP id p186mr10900599pgp.332.1591391622188;
        Fri, 05 Jun 2020 14:13:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b29sm457122pff.176.2020.06.05.14.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:13:41 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
From:   Jens Axboe <axboe@kernel.dk>
To:     Andres Freund <andres@anarazel.de>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200604005916.niy2mejjcsx4sv6t@alap3.anarazel.de>
 <e3072371-1d6b-8ae5-d946-d83e60427cb0@kernel.dk>
 <6eeff14f-befc-a5cc-08da-cb77f811fbdf@kernel.dk>
 <20200605202028.d57nklzpeolukni7@alap3.anarazel.de>
 <20200605203613.ogfilu2edcsfpme4@alap3.anarazel.de>
 <75bfe993-008d-71ce-7637-369f130bd984@kernel.dk>
Message-ID: <3539a454-5321-0bdc-b59c-06f60cc64b56@kernel.dk>
Date:   Fri, 5 Jun 2020 15:13:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <75bfe993-008d-71ce-7637-369f130bd984@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/20 2:53 PM, Jens Axboe wrote:
> On 6/5/20 2:36 PM, Andres Freund wrote:
>> Hi,
>>
>> On 2020-06-05 13:20:28 -0700, Andres Freund wrote:
>>> I'll go and try to figure out why I don't see an oops...
>>
>> Err, that probably was a typo on my end in the serial console
>> config. After fixing that, I did get the below.
>>
>> If helpful I can try with debugging enabled or such.
>>
>> [   67.910265] tee (2577): drop_caches: 3
>> [   68.059674] BUG: unable to handle page fault for address: 00007f0b16a3c03c
>> [   68.062021] #PF: supervisor read access in kernel mode
>> [   68.063742] #PF: error_code(0x0000) - not-present page
>> [   68.065517] PGD 102e044067 P4D 102e044067 PUD 102bf7a067 PMD 0 
>> [   68.067519] Oops: 0000 [#1] SMP NOPTI
>> [   68.068800] CPU: 2 PID: 2554 Comm: postgres Not tainted 5.7.0-andres-10123-g87823242260e #44
>> [   68.071505] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1 04/01/2014
>> [   68.074139] RIP: 0010:__mutex_lock.isra.0+0x76/0x4e0
>> [   68.075389] Code: b7 01 00 00 48 39 c6 0f 84 a4 03 00 00 65 48 8b 04 25 80 7d 01 00 48 8b 00 a8 08 75 18 49 8b 06 48 83 e0 f8 0f 84 2f 02 00 00 <8b> 50 3c 85 d2 0f 85 12 02 00 00 65 48 8b 04 25 80 7d 01 00 48 8b
>> [   68.079125] RSP: 0018:ffffc90000befd50 EFLAGS: 00010206
>> [   68.080260] RAX: 00007f0b16a3c000 RBX: ffff889037617910 RCX: 0000000000000000
>> [   68.084115] RDX: 00007f0b16a3c000 RSI: ffff88902a4aca80 RDI: ffff8890376178c0
>> [   68.085374] RBP: ffffc90000befdf0 R08: 0000000000000001 R09: 0000000000000000
>> [   68.086409] R10: ffff889037617920 R11: ffff88903f8abaf0 R12: ffffc90000befe08
>> [   68.087447] R13: 0000000000000000 R14: ffff8890376178c0 R15: 0000000000000000
>> [   68.088697] FS:  00007f0b97743740(0000) GS:ffff88903f880000(0000) knlGS:0000000000000000
>> [   68.089903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   68.090776] CR2: 00007f0b16a3c03c CR3: 000000102cf7c004 CR4: 0000000000760ee0
>> [   68.091834] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   68.092902] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   68.093967] PKRU: 55555554
>> [   68.094427] Call Trace:
>> [   68.094845]  ? __schedule+0x2ac/0x720
>> [   68.095350]  ? schedule+0x55/0xc0
>> [   68.095797]  ? ep_read_events_proc+0xd0/0xd0
>> [   68.096354]  ep_scan_ready_list.constprop.0+0x16c/0x190
>> [   68.097016]  ep_poll+0x2a3/0x440
>> [   68.097449]  ? wait_woken+0x70/0x70
>> [   68.097904]  do_epoll_wait+0xb0/0xd0
>> [   68.098375]  __x64_sys_epoll_wait+0x1a/0x20
>> [   68.098913]  do_syscall_64+0x48/0x130
>> [   68.099393]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   68.100030] RIP: 0033:0x7f0b97845606
>> [   68.100498] Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 18 48 89 74 24
>> [   68.102718] RSP: 002b:00007ffe80ffdba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
>> [   68.103644] RAX: ffffffffffffffda RBX: 000055fb76a9a998 RCX: 00007f0b97845606
>> [   68.104533] RDX: 0000000000000001 RSI: 000055fb76a9aa10 RDI: 0000000000000005
>> [   68.105418] RBP: 0000000005000007 R08: 0000000005000007 R09: 0000000000000003
>> [   68.106296] R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb76a9a998
>> [   68.107187] R13: 0000000000000001 R14: 0000000000000009 R15: 000055fb76a9a998
>> [   68.108104] Modules linked in: 9pnet_virtio isst_if_common xhci_pci 9pnet iTCO_wdt intel_pmc_bxt xhci_hcd iTCO_vendor_support
>> [   68.109505] CR2: 00007f0b16a3c03c
>> [   68.109962] ---[ end trace 0ca39a5ed99162ce ]---
>> [   68.110547] RIP: 0010:__mutex_lock.isra.0+0x76/0x4e0
>> [   68.111214] Code: b7 01 00 00 48 39 c6 0f 84 a4 03 00 00 65 48 8b 04 25 80 7d 01 00 48 8b 00 a8 08 75 18 49 8b 06 48 83 e0 f8 0f 84 2f 02 00 00 <8b> 50 3c 85 d2 0f 85 12 02 00 00 65 48 8b 04 25 80 7d 01 00 48 8b
>> [   68.113435] RSP: 0018:ffffc90000befd50 EFLAGS: 00010206
>> [   68.114111] RAX: 00007f0b16a3c000 RBX: ffff889037617910 RCX: 0000000000000000
>> [   68.115016] RDX: 00007f0b16a3c000 RSI: ffff88902a4aca80 RDI: ffff8890376178c0
>> [   68.115902] RBP: ffffc90000befdf0 R08: 0000000000000001 R09: 0000000000000000
>> [   68.116810] R10: ffff889037617920 R11: ffff88903f8abaf0 R12: ffffc90000befe08
>> [   68.117663] R13: 0000000000000000 R14: ffff8890376178c0 R15: 0000000000000000
>> [   68.118520] FS:  00007f0b97743740(0000) GS:ffff88903f880000(0000) knlGS:0000000000000000
>> [   68.119482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   68.120181] CR2: 00007f0b16a3c03c CR3: 000000102cf7c004 CR4: 0000000000760ee0
>> [   68.121043] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   68.121904] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   68.122790] PKRU: 55555554
>> [   68.123401] general protection fault, probably for non-canonical address 0xfeeda989fef06266: 0000 [#2] SMP NOPTI
>> [   68.125052] CPU: 2 PID: 2554 Comm: postgres Tainted: G      D           5.7.0-andres-10123-g87823242260e #44
>> [   68.126260] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1 04/01/2014
>> [   68.127274] RIP: 0010:__pv_queued_spin_lock_slowpath+0x1a1/0x2b0
>> [   68.128032] Code: c4 c1 ea 12 41 be 01 00 00 00 8d 42 ff 41 83 e4 03 4c 8d 6b 14 49 c1 e4 05 48 98 49 81 c4 00 c7 02 00 4c 03 24 c5 e0 e6 fd 82 <49> 89 1c 24 b8 00 80 00 00 eb 15 84 c0 75 0a 41 0f b6 54 24 14 84
>> [   68.130221] RSP: 0018:ffffc90000befce8 EFLAGS: 00010086
>> [   68.130867] RAX: 0000000000003ffe RBX: ffff88903f8ac700 RCX: 0000000000000001
>> [   68.131752] RDX: 0000000000003fff RSI: 0000000000000000 RDI: 0000000000000000
>> [   68.132637] RBP: ffff889037617924 R08: 0000000000000000 R09: ffffc90000befdf8
>> [   68.133513] R10: ffff8890334d2bf0 R11: 0000000000000018 R12: feeda989fef06266
>> [   68.134399] R13: ffff88903f8ac714 R14: 0000000000000001 R15: 00000000000c0000
>> [   68.135323] FS:  00007f0b97743740(0000) GS:ffff88903f880000(0000) knlGS:0000000000000000
>> [   68.136307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   68.137004] CR2: 00007f0b16a3c03c CR3: 000000000360a005 CR4: 0000000000760ee0
>> [   68.137866] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   68.138748] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   68.139606] PKRU: 55555554
>> [   68.139973] Call Trace:
>> [   68.140313]  queued_read_lock_slowpath+0x6c/0x70
>> [   68.140915]  _raw_read_lock_irqsave+0x26/0x30
>> [   68.141485]  ep_poll_callback+0x3e/0x2b0
>> [   68.142007]  ? set_next_entity+0xab/0x1f0
>> [   68.142541]  __wake_up_common+0x7a/0x140
>> [   68.143077]  __wake_up_common_lock+0x7c/0xc0
>> [   68.143651]  pipe_release+0x5b/0xd0
>> [   68.144150]  __fput+0xda/0x240
>> [   68.144574]  task_work_run+0x62/0x90
>> [   68.145046]  do_exit+0x35c/0xa70
>> [   68.145505]  ? do_epoll_wait+0xb0/0xd0
>> [   68.146000]  rewind_stack_do_exit+0x17/0x20
>> [   68.146538] RIP: 0033:0x7f0b97845606
>> [   68.146988] Code: Bad RIP value.
>> [   68.147405] RSP: 002b:00007ffe80ffdba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
>> [   68.148314] RAX: ffffffffffffffda RBX: 000055fb76a9a998 RCX: 00007f0b97845606
>> [   68.149157] RDX: 0000000000000001 RSI: 000055fb76a9aa10 RDI: 0000000000000005
>> [   68.150021] RBP: 0000000005000007 R08: 0000000005000007 R09: 0000000000000003
>> [   68.150831] R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb76a9a998
>> [   68.151640] R13: 0000000000000001 R14: 0000000000000009 R15: 000055fb76a9a998
>> [   68.152459] Modules linked in: 9pnet_virtio isst_if_common xhci_pci 9pnet iTCO_wdt intel_pmc_bxt xhci_hcd iTCO_vendor_support
>> [   68.153707] ---[ end trace 0ca39a5ed99162cf ]---
>> [   68.154282] RIP: 0010:__mutex_lock.isra.0+0x76/0x4e0
>> [   68.154884] Code: b7 01 00 00 48 39 c6 0f 84 a4 03 00 00 65 48 8b 04 25 80 7d 01 00 48 8b 00 a8 08 75 18 49 8b 06 48 83 e0 f8 0f 84 2f 02 00 00 <8b> 50 3c 85 d2 0f 85 12 02 00 00 65 48 8b 04 25 80 7d 01 00 48 8b
>> [   68.156976] RSP: 0018:ffffc90000befd50 EFLAGS: 00010206
>> [   68.157614] RAX: 00007f0b16a3c000 RBX: ffff889037617910 RCX: 0000000000000000
>> [   68.158436] RDX: 00007f0b16a3c000 RSI: ffff88902a4aca80 RDI: ffff8890376178c0
>> [   68.159269] RBP: ffffc90000befdf0 R08: 0000000000000001 R09: 0000000000000000
>> [   68.160092] R10: ffff889037617920 R11: ffff88903f8abaf0 R12: ffffc90000befe08
>> [   68.160920] R13: 0000000000000000 R14: ffff8890376178c0 R15: 0000000000000000
>> [   68.161746] FS:  00007f0b97743740(0000) GS:ffff88903f880000(0000) knlGS:0000000000000000
>> [   68.162701] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   68.163386] CR2: 00007f0b978455dc CR3: 000000000360a005 CR4: 0000000000760ee0
>> [   68.164226] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   68.165079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   68.165931] PKRU: 55555554
>> [   68.166298] Fixing recursive fault but reboot is needed!
>> [  128.173729] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>> [  128.179267] rcu: 	11-...0: (1 GPs behind) idle=c56/1/0x4000000000000000 softirq=6897/6898 fqs=5976 
>> [  128.182232] rcu: 	19-...0: (1 GPs behind) idle=492/1/0x4000000000000000 softirq=1023/1023 fqs=5976 
>> [  128.185217] 	(detected by 10, t=18003 jiffies, g=15789, q=631)
>> [  128.186863] Sending NMI from CPU 10 to CPUs 11:
>> [  128.188902] NMI backtrace for cpu 11
>> [  128.188903] CPU: 11 PID: 2546 Comm: postgres Tainted: G      D           5.7.0-andres-10123-g87823242260e #44
>> [  128.188904] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1 04/01/2014
>> [  128.188904] RIP: 0010:queued_read_lock_slowpath+0x5b/0x70
>> [  128.188906] Code: 03 00 02 00 00 8b 03 84 c0 74 08 f3 90 8b 13 84 d2 75 f8 48 89 ef e8 74 e6 ff ff 66 90 5b 5d c3 8b 07 84 c0 74 08 f3 90 8b 03 <84> c0 75 f8 5b 5d c3 89 c6 48 89 ef e8 e4 e8 ff ff 66 90 eb bf 0f
>> [  128.188907] RSP: 0018:ffffc90000348c08 EFLAGS: 00000086
>> [  128.188908] RAX: 0000000037617cc0 RBX: ffff889037617920 RCX: 00000000000000c3
>> [  128.188909] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff889037617920
>> [  128.188910] RBP: ffff889037bb1a80 R08: 00000000000000c3 R09: ffffc90000348cd8
>> [  128.188910] R10: 0100000000000000 R11: 00000000de2ee17e R12: 0000000000000046
>> [  128.188911] R13: ffff889037617920 R14: 0000000000000001 R15: 00000000000000c3
>> [  128.188912] FS:  00007f0b97743740(0000) GS:ffff88903fac0000(0000) knlGS:0000000000000000
>> [  128.188912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  128.188913] CR2: 00007f0b16afc00e CR3: 000000102e5c6002 CR4: 0000000000760ee0
>> [  128.188914] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  128.188914] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  128.188915] PKRU: 55555554
>> [  128.188915] Call Trace:
>> [  128.188916]  <IRQ>
>> [  128.188916]  _raw_read_lock_irqsave+0x26/0x30
>> [  128.188917]  ep_poll_callback+0x3e/0x2b0
>> [  128.188917]  ? cpumask_next_and+0x19/0x20
>> [  128.188918]  ? update_sd_lb_stats.constprop.0+0xfe/0x810
>> [  128.188918]  __wake_up_common+0x7a/0x140
>> [  128.188919]  __wake_up_common_lock+0x7c/0xc0
>> [  128.188919]  sock_def_readable+0x37/0x60
>> [  128.188920]  __udp_enqueue_schedule_skb+0x168/0x260
>> [  128.188920]  udpv6_queue_rcv_one_skb+0x284/0x3c0
>> [  128.188921]  udp6_unicast_rcv_skb.isra.0+0x44/0xa0
>> [  128.188921]  ip6_protocol_deliver_rcu+0x235/0x4b0
>> [  128.188922]  ip6_input_finish+0x11/0x20
>> [  128.188922]  ip6_input+0xa2/0xb0
>> [  128.188923]  ? ip6_protocol_deliver_rcu+0x4b0/0x4b0
>> [  128.188923]  ipv6_rcv+0xc0/0xd0
>> [  128.188924]  ? ip6_rcv_finish_core.isra.0+0xd0/0xd0
>> [  128.188924]  __netif_receive_skb_one_core+0x63/0xa0
>> [  128.188925]  process_backlog+0x98/0x140
>> [  128.188925]  net_rx_action+0x13a/0x370
>> [  128.188926]  __do_softirq+0xe0/0x2ca
>> [  128.188926]  do_softirq_own_stack+0x2a/0x40
>> [  128.188926]  </IRQ>
>> [  128.188927]  do_softirq.part.0+0x2b/0x30
>> [  128.188927]  __local_bh_enable_ip+0x4b/0x50
>> [  128.188928]  ip6_finish_output2+0x264/0x5b0
>> [  128.188928]  ip6_output+0x73/0x120
>> [  128.188929]  ? __ip6_finish_output+0x110/0x110
>> [  128.188929]  ip6_send_skb+0x1e/0x60
>> [  128.188930]  udp_v6_send_skb.isra.0+0x197/0x460
>> [  128.188930]  udpv6_sendmsg+0xb4f/0xdb0
>> [  128.188931]  ? ip_reply_glue_bits+0x40/0x40
>> [  128.188931]  ? update_load_avg+0x78/0x630
>> [  128.188932]  ? update_curr+0x73/0x1d0
>> [  128.188932]  ? __sys_sendto+0x108/0x190
>> [  128.188933]  __sys_sendto+0x108/0x190
>> [  128.188933]  ? __fput+0x1a5/0x240
>> [  128.188934]  ? _cond_resched+0x19/0x30
>> [  128.188934]  ? task_work_run+0x67/0x90
>> [  128.188935]  __x64_sys_sendto+0x25/0x30
>> [  128.188935]  do_syscall_64+0x48/0x130
>> [  128.188936]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  128.188936] RIP: 0033:0x7f0b97a7826c
>> [  128.188945] Code: c0 ff ff ff ff eb b9 0f 1f 80 00 00 00 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
>> [  128.188946] RSP: 002b:00007ffe80ffcea8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>> [  128.188947] RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007f0b97a7826c
>> [  128.188948] RDX: 0000000000000058 RSI: 000055fb765264c0 RDI: 0000000000000009
>> [  128.188949] RBP: 000055fb765264c0 R08: 0000000000000000 R09: 0000000000000000
>> [  128.188949] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe80ffcfc0
>> [  128.188950] R13: 000000000002c600 R14: 0000000000000000 R15: 000055fb7629b751
>> [  128.188957] Sending NMI from CPU 10 to CPUs 19:
>> [  128.239939] NMI backtrace for cpu 19
>> [  128.239940] CPU: 19 PID: 2587 Comm: postgres Tainted: G      D           5.7.0-andres-10123-g87823242260e #44
>> [  128.239940] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1 04/01/2014
>> [  128.239940] RIP: 0010:kvm_wait+0x30/0x50
>> [  128.239941] Code: 8b 05 ac cb f4 7e a9 00 00 f0 00 75 1f 9c 58 fa 0f b6 17 40 38 d6 75 12 f6 c4 02 75 10 e9 07 00 00 00 0f 00 2d 6f ce 54 01 f4 <50> 9d c3 e9 07 00 00 00 0f 00 2d 5f ce 54 01 fb f4 eb ed 66 66 2e
>> [  128.239942] RSP: 0018:ffffc90000cc78e8 EFLAGS: 00000046
>> [  128.239942] RAX: 0000000000000046 RBX: ffff88903fcec700 RCX: 0000000000000008
>> [  128.239943] RDX: 0000000000000003 RSI: 0000000000000003 RDI: ffff889039049d80
>> [  128.239943] RBP: ffff889039049d80 R08: ffff88907ffe9f80 R09: 00000000000000f8
>> [  128.239944] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
>> [  128.239944] R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000500000
>> [  128.239944] FS:  00007f0b97743740(0000) GS:ffff88903fcc0000(0000) knlGS:0000000000000000
>> [  128.239945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  128.239945] CR2: 000055fb76a96030 CR3: 0000001035882004 CR4: 0000000000760ee0
>> [  128.239945] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  128.239946] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  128.239946] PKRU: 55555554
>> [  128.239946] Call Trace:
>> [  128.239946]  __pv_queued_spin_lock_slowpath+0x26e/0x2b0
>> [  128.239947]  _raw_spin_lock_irqsave+0x25/0x30
>> [  128.239947]  __wake_up_common_lock+0x62/0xc0
>> [  128.239947]  sock_def_write_space+0x49/0x90
>> [  128.239948]  sock_wfree+0x68/0xb0
>> [  128.239948]  loopback_xmit+0x49/0xe0
>> [  128.239948]  dev_hard_start_xmit+0x8d/0x1e0
>> [  128.239948]  __dev_queue_xmit+0x721/0x8e0
>> [  128.239949]  ip6_finish_output2+0x250/0x5b0
>> [  128.239949]  ip6_output+0x73/0x120
>> [  128.239949]  ? __ip6_finish_output+0x110/0x110
>> [  128.239950]  ip6_send_skb+0x1e/0x60
>> [  128.239950]  udp_v6_send_skb.isra.0+0x197/0x460
>> [  128.239950]  udpv6_sendmsg+0xb4f/0xdb0
>> [  128.239950]  ? release_pages+0x28f/0x2f0
>> [  128.239950]  ? ip_reply_glue_bits+0x40/0x40
>> [  128.239951]  ? _cond_resched+0x19/0x30
>> [  128.239951]  ? unmap_page_range+0x678/0xa60
>> [  128.239951]  ? __sys_sendto+0x108/0x190
>> [  128.239951]  __sys_sendto+0x108/0x190
>> [  128.239952]  ? __fput+0x1a5/0x240
>> [  128.239952]  ? _cond_resched+0x19/0x30
>> [  128.239952]  ? task_work_run+0x67/0x90
>> [  128.239952]  __x64_sys_sendto+0x25/0x30
>> [  128.239953]  do_syscall_64+0x48/0x130
>> [  128.239953]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  128.239953] RIP: 0033:0x7f0b97a7826c
>> [  128.239954] Code: c0 ff ff ff ff eb b9 0f 1f 80 00 00 00 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
>> [  128.239954] RSP: 002b:00007ffe80ffd7b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>> [  128.239955] RAX: ffffffffffffffda RBX: 00000000000003a8 RCX: 00007f0b97a7826c
>> [  128.239955] RDX: 00000000000003a8 RSI: 00007ffe80ffd800 RDI: 0000000000000009
>> [  128.239955] RBP: 00007ffe80ffd800 R08: 0000000000000000 R09: 0000000000000000
>> [  128.239956] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe80ffd800
>> [  128.239956] R13: 00007ffe80ffd800 R14: 000000000000000e R15: 000055fb76b37e58
> 
> I can reproduce this, and I see what it is. I'll send out a patch soonish.

Thinko, can you try with this on top?


diff --git a/fs/io_uring.c b/fs/io_uring.c
index d22830a423f1..ca96ece3ac18 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2787,9 +2787,11 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 			/* if we can retry, do so with the callbacks armed */
 			if (io_rw_should_retry(req)) {
 				ret2 = io_iter_do_read(req, &iter);
-				if (ret2 != -EAGAIN) {
+				if (ret2 == -EIOCBQUEUED) {
+					return 0;
+				} else if (ret2 != -EAGAIN) {
 					kiocb_done(kiocb, ret2);
-					goto out_free;
+					return 0;
 				}
 			}
 			kiocb->ki_flags &= ~IOCB_WAITQ;

-- 
Jens Axboe

