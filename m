Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA640583998
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiG1HiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiG1HiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:38:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6452E54;
        Thu, 28 Jul 2022 00:38:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oGy5o-0000kv-Ci; Thu, 28 Jul 2022 09:38:00 +0200
Message-ID: <62df64ca-dc79-c308-a8e0-7c2b2c45248a@leemhuis.info>
Date:   Thu, 28 Jul 2022 09:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev,
        Jan Kara <jack@suse.cz>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <Yt6xsyy3+qEMn08y@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <0840b428-3a77-2339-354f-7fbd3295bb4d@i2se.com>
 <Yt+M+JgW6KuZFMvc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <e9aa5629-b6a8-3e5d-422e-eb79ac333fdc@i2se.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
In-Reply-To: <e9aa5629-b6a8-3e5d-422e-eb79ac333fdc@i2se.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1658993883;e2a7abd8;
X-HE-SMSGID: 1oGy5o-0000kv-Ci
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26.07.22 17:54, Stefan Wahren wrote:
> Hi Ojaswin,
> 
> Am 26.07.22 um 08:43 schrieb Ojaswin Mujoo:
>> On Mon, Jul 25, 2022 at 09:09:32PM +0200, Stefan Wahren wrote:
>>> Hi Ojaswin,
>>>
>>> Am 25.07.22 um 17:07 schrieb Ojaswin Mujoo:
>>>> On Mon, Jul 18, 2022 at 03:29:47PM +0200, Stefan Wahren wrote:
>>>>> Hi,
>>>>>
>>>>> i noticed that since Linux 5.18 (Linux 5.19-rc6 is still affected) i'm
>>>>> unable to run "rpi-update" without massive performance regression
>>>>> on my
>>>>> Raspberry Pi 4 (multi_v7_defconfig + CONFIG_ARM_LPAE). Using Linux
>>>>> 5.17 this
>>>>> tool successfully downloads the latest firmware (> 100 MB) on my
>>>>> development
>>>>> micro SD card (Kingston 16 GB Industrial) with a ext4 filesystem
>>>>> within ~ 1
>>>>> min. The same scenario on Linux 5.18 shows the following symptoms:
>>>>>
>>>>> - download takes endlessly much time and leads to an abort by
>>>>> userspace in
>>>>> most cases because of the poor performance
>>>>> - massive system load during download even after download has been
>>>>> aborted
>>>>> (heartbeat LED goes wild)
>>>>> - whole system becomes nearly unresponsive
>>>>> - system load goes back to normal after > 10 min
>>>>> - dmesg doesn't show anything suspicious
>>>>>
>>>>> I was able to bisect this issue:
>>>>>
>>>>> ff042f4a9b050895a42cae893cc01fa2ca81b95c good
>>>>> 4b0986a3613c92f4ec1bdc7f60ec66fea135991f bad
>>>>> 25fd2d41b505d0640bdfe67aa77c549de2d3c18a bad
>>>>> b4bc93bd76d4da32600795cd323c971f00a2e788 bad
>>>>> 3fe2f7446f1e029b220f7f650df6d138f91651f2 bad
>>>>> b080cee72ef355669cbc52ff55dc513d37433600 good
>>>>> ad9c6ee642a61adae93dfa35582b5af16dc5173a good
>>>>> 9b03992f0c88baef524842e411fbdc147780dd5d bad
>>>>> aab4ed5816acc0af8cce2680880419cd64982b1d good
>>>>> 14705fda8f6273501930dfe1d679ad4bec209f52 good
>>>>> 5c93e8ecd5bd3bfdee013b6da0850357eb6ca4d8 good
>>>>> 8cb5a30372ef5cf2b1d258fce1711d80f834740a bad
>>>>> 077d0c2c78df6f7260cdd015a991327efa44d8ad bad
>>>>> cc5095747edfb054ca2068d01af20be3fcc3634f good
>>>>> 27b38686a3bb601db48901dbc4e2fc5d77ffa2c1 good
>>>>>
>>>>> commit 077d0c2c78df6f7260cdd015a991327efa44d8ad
>>>>> Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>> Date:   Tue Mar 8 15:22:01 2022 +0530
>>>>>
>>>>> ext4: make mb_optimize_scan performance mount option work with extents
>>>>>
>>>>> If i revert this commit with Linux 5.19-rc6 the performance regression
>>>>> disappears.
>>>>>
>>>>> Please ask if you need more information.
>>>> Hi Stefan,
>>>>
>>>> Apologies, I had missed this email initially. So this particular patch
>>>> simply changed a typo in an if condition which was preventing the
>>>> mb_optimize_scan option to be enabled correctly (This feature was
>>>> introduced in the following commit [1]). I think with the
>>>> mb_optimize_scan now working, it is somehow causing the firmware
>>>> download/update to take a longer time.
>>>>
>>>> I'll try to investigate this and get back with my findings.
>>> thanks. I wasn't able to reproduce this heavy load symptoms with
>>> every SD
>>> card. Maybe this depends on the write performance of the SD card to
>>> trigger
>>> the situation (used command to measure write performance: dd
>>> if=/dev/zero
>>> of=/boot/test bs=1M count=30 oflag=dsync,direct ).
>>>
>>> I tested a Kingston consumer 32 GB which had nearly constant write
>>> performance of 13 MB/s and didn't had the heavy load symptoms. The
>>> firmware
>>> update was done in a few seconds, so hard to say that at least the
>>> performance regression is reproducible.
>>>
>>> I also tested 2x Kingston industrial 16 GB which had a floating write
>>> performance between 5 and 10 MB/s (wear leveling?) and both had the
>>> heavy
>>> load symptoms.
>>>
>>> All SD cards has been detected as ultra high speed DDR50 by the emmc2
>>> interface.
>>>
>>> Best regards
>>>
>>>> Regard,
>>>> Ojaswin
>>>>
>>>> [1]
>>>>     commit 196e402adf2e4cd66f101923409f1970ec5f1af3
>>>>     From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>>>>     Date: Thu, 1 Apr 2021 10:21:27 -0700
>>>>     
>>>>     ext4: improve cr 0 / cr 1 group scanning
>>>>
>>>>> Regards
>>>>>
>> Thanks for the info Stefan, I'm still trying to reproduce the issue but
>> it's slightly challenging since I don't have my RPi handy at the moment.
>>
>> In the meantime, would you please try out the mb_optmize_scan=0 command
>> line options to see if that helps bypass the issue. This will help
>> confirm if the issue lies in mb_optmize_scan itself or if its something
>> else.
>>
> I run the firmware update 5 times with mb_optimize_scan=0 on my
> Raspberry Pi 4 and the industrial SD card and everytime the update worked.
>>

[CCing Jan]

FYI, Jan yesterday reported benchmark regresses that might or might not
be related Stefan's regression on the Raspberry Pi:
https://lore.kernel.org/all/20220727105123.ckwrhbilzrxqpt24@quack3/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot monitor
https://lore.kernel.org/all/20220727105123.ckwrhbilzrxqpt24@quack3/
