Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DA65E6CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAEI0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 03:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjAEIZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:25:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18750069;
        Thu,  5 Jan 2023 00:23:33 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pDLX6-0004ow-0d; Thu, 05 Jan 2023 09:23:28 +0100
Message-ID: <311733fe-cd0d-5afb-b189-835d9ab92aa2@leemhuis.info>
Date:   Thu, 5 Jan 2023 09:23:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [REGRESSION] XArray commit prevents booting with 6.0-rc1 or later
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
To:     Jorropo <jorropo.pgm@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, nborisov@suse.com,
        Matthew Wilcox <willy@infradead.org>
References: <CAHWihb_EYWKXOqdN0iDBDygk+EGbhaxWHTKVRhtpm_TihbCjtw@mail.gmail.com>
 <Y3h118oIDsvclZHM@casper.infradead.org>
 <CAHWihb_HugpV44NdvUc2CV_0q2wk-XWyhmGdQhwCP6nDmo1k7g@mail.gmail.com>
 <Y4SnKWCWZt0LtYVN@casper.infradead.org>
 <f2ff04c7-fbae-6343-a9cb-10a9c681463b@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <f2ff04c7-fbae-6343-a9cb-10a9c681463b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672907013;47d936b1;
X-HE-SMSGID: 1pDLX6-0004ow-0d
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.12.22 08:03, Thorsten Leemhuis wrote:
> On 28.11.22 13:18, Matthew Wilcox wrote:
>> On Sun, Nov 20, 2022 at 12:20:13AM +0100, Jorropo wrote:
>>> Matthew Wilcox <willy@infradead.org> wrote :
>>>> On Sat, Nov 19, 2022 at 05:07:45AM +0100, Jorropo wrote:
>>>>>
>>>>> Hi, I recently tried to upgrade to linux v6.0.x but when trying to
>>>>> boot it fails with "error: out of memory" when or after loading
>>>>> initramfs (which then kpanics because the vfs root is missing).
>>>>> The latest releases I tested are v6.0.9 and v6.1-rc5 and it's broken there too.
>>>>>
>>>>> I bisected the error to this patch:
>>>>> 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae "XArray: Add calls to
>>>>> might_alloc()" is the first bad commit.
>>>>> I've confirmed this is not a side effect of a poor bitsect because
>>>>> 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae~1 (v5.19-rc6) works.
>>>>
>>>> That makes no sense.  I can't look into this until Wednesday, but I
>>>> suggest that what you have is an intermittent failure to boot, and
>>>> the bisect has led you down the wrong path.
>>>
>>> I rebuilt both 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae and
>>> the parent commit (v5.19-rc6), then tried to start each one 8 times
>>> (shuffled in a Thue morse sequence).
>>> 0 successes for 1dd685c414a7b9fdb3d23aca3aedae84f0b998ae
>>> 8 successes for v5.19-rc6
>>>
>>> This really does not look like an intermittent issue.
>>
>> OK, you convinced me.  Can you boot 1dd685c414 with the command line
>> parameters "debug initcall_debug" so we get more information?
> 
> Jorropo, did you ever provide the information Matthew asked for? I'm
> asking, as this looks stalled -- and I wonder why. Or was progress made
> somewhere and I just missed it?

For the record: Jorropo sent me a private mail where he states "this is
some installation issue because after some updates the previous release
that used to work does not anymore. You can close this.". Hence:

#regzbot resolve: not a regression according to the reporter

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
