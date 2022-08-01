Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0C586267
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiHACGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 22:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHACGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:06:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CEB4A8;
        Sun, 31 Jul 2022 19:05:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lx1c15BKxz1M7tv;
        Mon,  1 Aug 2022 10:02:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 10:05:56 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 10:05:56 +0800
Subject: Re: [PATCH RESEND] chardev: fix error handling in cdev_device_add()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <logang@deltatee.com>, <dan.j.williams@intel.com>,
        <hans.verkuil@cisco.com>, <alexandre.belloni@free-electrons.com>,
        <viro@zeniv.linux.org.uk>
References: <20220714092355.991306-1-yangyingliang@huawei.com>
 <Ys/i3EBk2nZea8Hy@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <0705d0a6-7897-c8eb-666f-711ea8be1cd6@huawei.com>
Date:   Mon, 1 Aug 2022 10:05:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Ys/i3EBk2nZea8Hy@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Greg

On 2022/7/14 17:33, Greg KH wrote:
> On Thu, Jul 14, 2022 at 05:23:55PM +0800, Yang Yingliang wrote:
>> If dev->devt is not set, cdev_add() will not be called, so if device_add()
>> fails, cdev_del() is not needed. Fix this by checking dev->devt in error
>> case.
>>
>> Fixes: 233ed09d7fda ("chardev: add helper function to register char devs with a struct device")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   fs/char_dev.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/char_dev.c b/fs/char_dev.c
>> index ba0ded7842a7..3f667292608c 100644
>> --- a/fs/char_dev.c
>> +++ b/fs/char_dev.c
>> @@ -547,7 +547,7 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>>   	}
>>   
>>   	rc = device_add(dev);
>> -	if (rc)
>> +	if (rc && dev->devt)
>>   		cdev_del(cdev);
>>   
>>   	return rc;
>> -- 
>> 2.25.1
>>
> Please see https://lore.kernel.org/r/YsLtXYa4kRYEEaX/@kroah.com for why
> I will no longer accept patches from Huawei with the "hulk robot" claim
> without the required information.
I found this bug by fault injection test and it can be reproduced in the 
5.19.0-rc6.
When inject error in device_add(), it triggers the bug.

The FAULT_INJECTION stack is:
[   90.246918][ T1527] FAULT_INJECTION: forcing a failure.
[   90.246918][ T1527] name failslab, interval 1, probability 0, space 
0, times 0
[   90.248546][ T1527] CPU: 3 PID: 1527 Comm: 63 Not tainted 
5.19.0-rc6-00276-g187506bb1928-dirty #668 
3b1a4a46ce78a2173f0a10415bb4c4ff7194a867
[   90.249993][ T1527] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   90.251114][ T1527] Call Trace:
[   90.251500][ T1527]  <TASK>
[   90.251889][ T1527]  dump_stack_lvl+0xe4/0x156
[   90.252661][ T1527]  should_fail.cold.3+0x5/0x1f
[   90.253242][ T1527]  ? device_add+0x10cd/0x1de0
[   90.253835][ T1527]  ? device_add+0x10cd/0x1de0
[   90.254391][ T1527]  should_failslab+0xa/0x20
[   90.254902][ T1527]  kmem_cache_alloc_trace+0x5a/0x2e0
[   90.255496][ T1527]  device_add+0x10cd/0x1de0
[   90.256100][ T1527]  ? rcu_read_lock_held_common+0xe/0xb0
[   90.256951][ T1527]  ? rcu_read_lock_sched_held+0x62/0xf0
[   90.257811][ T1527]  ? rcu_read_lock_bh_held+0xd0/0xd0
[   90.258627][ T1527]  ? iio_dev_release+0x161/0x1c0 [industrialio]
[   90.260110][ T1527]  ? __fw_devlink_link_to_suppliers+0x2c0/0x2c0
[   90.260818][ T1527]  ? write_comp_data+0x2a/0x90
[   90.261366][ T1527]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[   90.262003][ T1527]  ? iio_device_register_eventset+0x6f6/0xea0 
[industrialio]
[   90.263365][ T1527]  cdev_device_add+0x130/0x1b0
[   90.263923][ T1527]  __iio_device_register+0x1392/0x1ac0 [industrialio]
[   90.265218][ T1527]  __devm_iio_device_register+0x22/0x90 [industrialio]
[   90.266502][ T1527]  max517_probe+0x3d8/0x6b4 [max517]
[   90.267456][ T1527]  ? max517_write_raw+0x1e0/0x1e0 [max517]
[   90.268472][ T1527]  i2c_device_probe+0x974/0xae0
[   90.269016][ T1527]  ? i2c_device_match+0x120/0x120
[   90.269577][ T1527]  really_probe+0x44a/0xaf0

The kernel reported this warning:
[   90.309159][ T1527] ------------[ cut here ]------------
[   90.309981][ T1527] kobject: '(null)' (000000008ab24cf9): is not 
initialized, yet kobject_put() is being called.
[   90.311910][ T1527] WARNING: CPU: 3 PID: 1527 at kobject_put+0x24c/0x540
[   90.312975][ T1527] Modules linked in: max517 industrialio spi_stub 
i2c_stub i2c_dev joydev mousedev intel_rapl_msr input_leds led_class 
nfit edac_core libnvdimm intel_rapl_common intel_uncore_frequency_common 
isst_if_common ppdev serio_raw psmouse atkbd kvm_intel libps2 
vivaldi_fmap kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel 
ghash_clmulni_intel aesni_intel crypto_simd cryptd bochs drm_vram_helper 
drm_ttm_helper ttm sr_mod evdev drm_kms_helper cdrom mac_hid drm sg 
drm_panel_orientation_quirks cfbfillrect cfbimgblt parport_pc 
cfbcopyarea parport rtc_cmos fb_sys_fops floppy syscopyarea sysfillrect 
i8042 serio sysimgblt ata_generic fb pata_acpi fbdev i2c_piix4 backlight 
intel_agp tiny_power_button intel_gtt agpgart qemu_fw_cfg button 
ip_tables x_tables ipv6 crc_ccitt autofs4
[   90.324844][ T1527] CPU: 3 PID: 1527 Comm: 63 Not tainted 
5.19.0-rc6-00276-g187506bb1928-dirty #668 
3b1a4a46ce78a2173f0a10415bb4c4ff7194a867
[   90.326763][ T1527] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   90.328285][ T1527] RIP: 0010:kobject_put+0x24c/0x540
[   90.329113][ T1527] Code: e8 c9 21 e5 fe 90 48 89 d8 48 c1 e8 03 80 
3c 28 00 0f 85 7a 02 00 00 48 8b 33 48 89 da 48 c7 c7 a0 73 ff 88 e8 22 
83 ff 00 90 <0f> 0b 90 90 e9 1c fe ff ff e8 96 21 e5 fe 4c 8b 0c 24 48 
89 d9 4c
[   90.331985][ T1527] RSP: 0018:ffffc9000496f508 EFLAGS: 00010286
[   90.332902][ T1527] RAX: 0000000000000000 RBX: ffff88800c1b2788 RCX: 
ffffffff861ac93a
[   90.334079][ T1527] RDX: 0000000000000000 RSI: ffff888005608000 RDI: 
0000000000000002
[   90.335248][ T1527] RBP: dffffc0000000000 R08: ffffed1021240346 R09: 
ffffed1021240346
[   90.336464][ T1527] R10: ffff888109201a2b R11: ffffed1021240345 R12: 
ffff88800c1b27c4
[   90.337640][ T1527] R13: 0000000000000000 R14: 00000000ffffffff R15: 
0000000000000000
[   90.338827][ T1527] FS:  00007fe80c499500(0000) 
GS:ffff888109000000(0000) knlGS:0000000000000000
[   90.340190][ T1527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.341173][ T1527] CR2: 000055837fa23708 CR3: 0000000005c36001 CR4: 
0000000000770ee0
[   90.342307][ T1527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   90.343140][ T1527] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   90.344024][ T1527] PKRU: 55555554
[   90.344562][ T1527] Call Trace:
[   90.345063][ T1527]  <TASK>
[   90.345529][ T1527]  cdev_device_add+0x15e/0x1b0
[   90.346214][ T1527]  __iio_device_register+0x1392/0x1ac0 [industrialio]
[   90.347509][ T1527]  __devm_iio_device_register+0x22/0x90 [industrialio]
[   90.348840][ T1527]  max517_probe+0x3d8/0x6b4 [max517]
[   90.350091][ T1527]  ? max517_write_raw+0x1e0/0x1e0 [max517]
[   90.351093][ T1527]  i2c_device_probe+0x974/0xae0
[   90.351633][ T1527]  ? i2c_device_match+0x120/0x120
[   90.352255][ T1527]  really_probe+0x44a/0xaf0

If attached_buffers_cnt and event_interface of iio_dev_opaque is not 
set, the 'cdev' is not initialized and the
dev->devt is not set, but cdev_del() is called in error path, then it 
triggers this bug.
>
> Also, you did not state why this was a RESEND.
https://lore.kernel.org/lkml/1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com/T/ 

This patch has been sent last year, and the bug can be reproduced, so I 
tried to resend to fix it.

Thanks,
Yang
>
> Now dropped from my review queue,
>
> greg k-h
> .
