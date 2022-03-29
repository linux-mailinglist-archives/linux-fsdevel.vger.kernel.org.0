Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DEB4EAA24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiC2JKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiC2JKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:10:21 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E306D1A821;
        Tue, 29 Mar 2022 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=D42xy
        7+yLkaYpKU3vck1zzruTxb/f4x0p/TZLmiRNTo=; b=kisq2YePN3sT38yovDcv3
        O7bsjf9e4RlccTQzf+5tfX+pvkEqLh9izPhtYzwp0uCoYtVkSQP6CugAgW1UFRre
        1JGKTqfHjzLHLOjb4MZIQNxDB0BXtkk6ZAPzV8hBM7/3NMM0kL1mVl4Oa7dIc9gs
        5lvsTktXEl9/CmfzCkGNig=
Received: from [192.168.3.109] (unknown [218.201.129.19])
        by smtp11 (Coremail) with SMTP id D8CowAA3+mR9zEJioe8DAA--.82S2;
        Tue, 29 Mar 2022 17:08:15 +0800 (CST)
Message-ID: <e69813b2-9b60-02de-dbec-414c2baf42c8@163.com>
Date:   Tue, 29 Mar 2022 17:08:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux resetting when the usb storage was removed while copying
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com>
 <87pmmee9kr.fsf@mail.parknet.co.jp>
 <06ebc7fb-e7eb-b994-78fd-df07155ef4b5@163.com>
 <15b83842-60d9-78b8-54e9-3a27211caded@roeck-us.net>
 <87pmm6hbk9.fsf@mail.parknet.co.jp>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <87pmm6hbk9.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAA3+mR9zEJioe8DAA--.82S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1xtFy5tFyxuw48ZF48tFb_yoW8uF4fpr
        WxJFs2k3yqqry3uF12yF1kCr4Fq39FyF98Gr1rZw13uas0vw1rAr48JFyI9ay7Grs8J3Wr
        K3WUWa9rZwsrX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0XdbUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbCqQzS7V0DefSsPgAAsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/3/28 13:48, OGAWA Hirofumi 写道:
>>> I had changed console to ttynull and the system doesn't reset again.  kernel driver generate lots of error messages when usb storage is disconnected:
>>>
>>> $ dmesg | grep 'FAT read failed' | wc -l
>>>
>>> 608
>>>
>>> usb storage can work again when reconnected.
>>>
>>> The gpio watchdog depends on hrtimer, maybe printk in ISR delayed hrtimer that cause watchdog reset.
> This limits the rate of messages. Can you try if a this patch fixes behavior?

Yes, this patch fixed the problem and watchdog doesn't reset again.

Next is the console log when usb storage disconnected:

[  217.265033] musb-hdrc musb-hdrc.0: ep2 RX three-strikes error
[  218.085454] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 
driverbyte=DRIVER_OK cmd_age=0s
[  218.095658] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 04 81 d6 00 00 
f0 00
[  218.103611] blk_update_request: I/O error, dev sda, sector 295382 op 
0x0:(READ) flags 0x84700 phys_seg 2 prio class 0
[  218.116414] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 
driverbyte=DRIVER_OK cmd_age=0s
[  218.126576] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 04 82 c6 00 00 
10 00
[  218.134582] blk_update_request: I/O error, dev sda, sector 295622 op 
0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  218.146542] usb 1-1: USB disconnect, device number 4
[  218.166668] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 
driverbyte=DRIVER_OK cmd_age=0s
[  218.176831] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 04 82 d6 00 00 
f0 00
[  218.184864] blk_update_request: I/O error, dev sda, sector 295638 op 
0x0:(READ) flags 0x84700 phys_seg 2 prio class 0
[  218.196996] blk_update_request: I/O error, dev sda, sector 295878 op 
0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[  218.208339] blk_update_request: I/O error, dev sda, sector 295382 op 
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
cp: read error: Input/output error
# [  218.253995] FAT-fs (sda1): FAT read failed (blocknr 1130)

'FAT read failed' error message printed only once.

Interesting.

>
> Thanks.

