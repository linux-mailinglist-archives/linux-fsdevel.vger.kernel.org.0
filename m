Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EE4820A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbhL3W10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 17:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbhL3W10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:27:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5CC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 14:27:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w24so19081270ply.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9vtcDpk6aGQabclb86rzKvG/uTxX02b8S1noue2Aapw=;
        b=clAsvIn0ous2+Vqv7XovaeKn+Zwy+Ye2fbnIgAxW4WlQLdyJ+hooEUx3T//hJhFc+W
         eC3vj5CRsUUSyaDjSyMl/a7518b9Q5Y3x5ioMqPfXhj6+0zfd2eAPwMDoWvOKOsVRh6E
         9HScn7h0+D8I7VcFeptuslOr6OBV0nVq7ry30Lt9X/4rdLV5LtMWQO6Da7oJfehId2EZ
         mIcCW2WDItR9WpgZLnGUTdbzjtGe1MX8Wln4RISRgstlWwgUjwtkU+TJ3CZmePJpRtXx
         knq3UY3oxJKzyPZzbRN3TcjDmZrpgRLwod3/E5k4Fax/dgLpOkC7ik6uQMMSqgE5nxOw
         BpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9vtcDpk6aGQabclb86rzKvG/uTxX02b8S1noue2Aapw=;
        b=1YG3KXmD8/H4684MwtA/ANVWIof9dpfGljPxPPlZrGInCU6+aREa+cnAoww/icSekT
         /47g6hhq0LYKBWZ0d/uSSRxAcHTzHwBkDcyOdjQmMAQ/1DA7dTHVaxfbfF8ifKnU5DJw
         R5Ew9NB8ofYSDp/OdTisyqjTnoL7ltgUZX2+g5Cica8yysZd+Q1lNHCAvcdvfCIbj6oP
         7FZBplUgRLSLW3brgyr4XrtWJWN+9vZ6seHzrmPSIbIf6+5nM4mE5XUyV3GN9kgh7CIR
         IyoKE4rq0yb0T2D/QZvEYyei59XwBI/OQdldhgWNUuD01MjixdNstn7Ov/fqJpbqVQxA
         0vPQ==
X-Gm-Message-State: AOAM5310K+WrSbaLmGhIDOb0ht5jiFmssCk8O8q4gsTYABsVPo48Acrj
        3PGU5x5Kz3orHHR5yWrR/e2VYA==
X-Google-Smtp-Source: ABdhPJxlN0Rlb7lxXP9cF+B+K3iV8aO6XUlweuhx+fez/n5y5oCaJNwic7LfRTAglElIW739DI0EHA==
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr39916364pjb.15.1640903245339;
        Thu, 30 Dec 2021 14:27:25 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d13sm22295426pfl.18.2021.12.30.14.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 14:27:24 -0800 (PST)
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <05bac8cb-e36a-b043-5ac3-82c585f76bbe@kernel.dk>
 <a42acb06152b0ecba3e99aec38349e1f29304b1e.camel@hammerspace.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1801967a-e538-3edf-4af6-2336e2fcb4a2@kernel.dk>
Date:   Thu, 30 Dec 2021 14:27:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a42acb06152b0ecba3e99aec38349e1f29304b1e.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/30/21 2:25 PM, Trond Myklebust wrote:
> On Thu, 2021-12-30 at 13:24 -0800, Jens Axboe wrote:
>> On 12/30/21 11:35 AM, trondmy@kernel.org wrote:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> We're observing the following stack trace using various kernels
>>> when
>>> running in the Azure cloud.
>>>
>>>  watchdog: BUG: soft lockup - CPU#12 stuck for 23s!
>>> [kworker/12:1:3106]
>>>  Modules linked in: raid0 ipt_MASQUERADE nf_conntrack_netlink
>>> xt_addrtype nft_chain_nat nf_nat br_netfilter bridge stp llc ext4
>>> mbcache jbd2 overlay xt_conntrack nf_conntrack nf_defrag_ipv6
>>> nf_defrag_ipv4 nft_counter rpcrdma rdma_ucm xt_owner ib_srpt
>>> nft_compat intel_rapl_msr ib_isert intel_rapl_common nf_tables
>>> iscsi_target_mod isst_if_mbox_msr isst_if_common nfnetlink
>>> target_core_mod nfit ib_iser libnvdimm libiscsi
>>> scsi_transport_iscsi ib_umad kvm_intel ib_ipoib rdma_cm iw_cm vfat
>>> ib_cm fat kvm irqbypass crct10dif_pclmul crc32_pclmul mlx5_ib
>>> ghash_clmulni_intel rapl ib_uverbs ib_core i2c_piix4 pcspkr
>>> hyperv_fb hv_balloon hv_utils joydev nfsd auth_rpcgss nfs_acl lockd
>>> grace sunrpc ip_tables xfs libcrc32c mlx5_core mlxfw tls pci_hyperv
>>> pci_hyperv_intf sd_mod t10_pi sg ata_generic hv_storvsc hv_netvsc
>>> scsi_transport_fc hyperv_keyboard hid_hyperv ata_piix libata
>>> crc32c_intel hv_vmbus serio_raw fuse
>>>  CPU: 12 PID: 3106 Comm: kworker/12:1 Not tainted 4.18.0-
>>> 305.10.2.el8_4.x86_64 #1
>>>  Hardware name: Microsoft Corporation Virtual Machine/Virtual
>>> Machine, BIOS 090008  12/07/2018
>>>  Workqueue: xfs-conv/md127 xfs_end_io [xfs]
>>>  RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
>>>  Code: 7c ff 48 29 e8 4c 39 e0 76 cf 80 0b 08 eb 8c 90 90 90 90 90
>>> 90 90 90 90 90 0f 1f 44 00 00 e8 e6 db 7e ff 66 90 48 89 f7 57 9d
>>> <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 07
>>>  RSP: 0018:ffffac51d26dfd18 EFLAGS: 00000202 ORIG_RAX:
>>> ffffffffffffff12
>>>  RAX: 0000000000000001 RBX: ffffffff980085a0 RCX: dead000000000200
>>>  RDX: ffffac51d3893c40 RSI: 0000000000000202 RDI: 0000000000000202
>>>  RBP: 0000000000000202 R08: ffffac51d3893c40 R09: 0000000000000000
>>>  R10: 00000000000000b9 R11: 00000000000004b3 R12: 0000000000000a20
>>>  R13: ffffd228f3e5a200 R14: ffff963cf7f58d10 R15: ffffd228f3e5a200
>>>  FS:  0000000000000000(0000) GS:ffff9625bfb00000(0000)
>>> knlGS:0000000000000000
>>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>  CR2: 00007f5035487500 CR3: 0000000432810004 CR4: 00000000003706e0
>>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>  Call Trace:
>>>   wake_up_page_bit+0x8a/0x110
>>>   iomap_finish_ioend+0xd7/0x1c0
>>>   iomap_finish_ioends+0x7f/0xb0
>>>   xfs_end_ioend+0x6b/0x100 [xfs]
>>>   ? xfs_setfilesize_ioend+0x60/0x60 [xfs]
>>>   xfs_end_io+0xb9/0xe0 [xfs]
>>>   process_one_work+0x1a7/0x360
>>>   worker_thread+0x1fa/0x390
>>>   ? create_worker+0x1a0/0x1a0
>>>   kthread+0x116/0x130
>>>   ? kthread_flush_work_fn+0x10/0x10
>>>   ret_from_fork+0x35/0x40
>>>
>>> Jens suggested adding a latency-reducing cond_resched() to the loop
>>> in
>>> iomap_finish_ioends().
>>
>> The patch doesn't add it there though, I was suggesting:
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 71a36ae120ee..4ad2436a936a 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -1078,6 +1078,7 @@ iomap_finish_ioends(struct iomap_ioend *ioend,
>> int error)
>>                 ioend = list_first_entry(&tmp, struct iomap_ioend,
>> io_list);
>>                 list_del_init(&ioend->io_list);
>>                 iomap_finish_ioend(ioend, error);
>> +               cond_resched();
>>         }
>>  }
>>  EXPORT_SYMBOL_GPL(iomap_finish_ioends);
>>
>> as I don't think you need it once-per-vec. But not sure if you tested
>> that variant or not...
>>
> 
> Yes, we did test that variant, but were still seeing the soft lockups
> on Azure, hence why I moved it into the inner loop.

Gotcha - but maybe just outside the vec loop then, after the bio_put()?
Once per vec seems excessive, each vec shouldn't take long, but I guess
the ioend inlines can be long?

-- 
Jens Axboe

