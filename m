Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91115F0B16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiI3LxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 07:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiI3LxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:53:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D683206;
        Fri, 30 Sep 2022 04:52:59 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oeEZd-0005wF-Di; Fri, 30 Sep 2022 13:52:57 +0200
Message-ID: <99249078-2026-c76c-87eb-8e3ac5dde73d@leemhuis.info>
Date:   Fri, 30 Sep 2022 13:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
Content-Language: en-US, de-DE
To:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664538780;c1816c87;
X-HE-SMSGID: 1oeEZd-0005wF-Di
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. This might be a Qemu
bug, but it's exposed by kernel change, so I at least want to have it in
the tracking. I'll simply remove it in a few weeks, if it turns out that
nobody except Maxim hits this.

On 29.09.22 17:41, Maxim Levitsky wrote:
> Hi!
>  
> Recently I noticed that this commit broke the boot of some of the VMs that I run on my dev machine.
>  
> It seems that I am not the first to notice this but in my case it is a bit different
>  
> https://lore.kernel.org/all/e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com/
>  
> My VM is a normal x86 VM, and it uses virtio-blk in the guest to access the virtual disk,
> which is a qcow2 file stored on ext4 filesystem which is stored on NVME drive with 4K sectors.
> (however I was also able to reproduce this on a raw file)
>  
> It seems that the only two things that is needed to reproduce the issue are:
>  
> 1. The qcow2/raw file has to be located on a drive which has 4K hardware block size.
> 2. Qemu needs to use direct IO (both aio and 'threads' reproduce this). 
>  
> I did some debugging and I isolated the kernel change in behavior from qemu point of view:
>  
>  
> Qemu, when using direct IO, 'probes' the underlying file.
>  
> It probes two things:
>  
> 1. It probes the minimum block size it can read.
>    It does so by trying to read 1, 512, 1024, 2048 and 4096 bytes at offset 0,
>    using a 4096 bytes aligned buffer, and notes the first read that works as the hardware block size.
>  
>    (The relevant function is 'raw_probe_alignment' in src/block/file-posix.c in qemu source code).
>  
>  
> 2. It probes the buffer alignment by reading 4096 bytes also at file offset 0,
>    this time using a buffer that is 1, 512, 1024, 2048 and 4096 aligned
>    (this is done by allocating a buffer which is 4K aligned and adding 1/512 and so on to its address)
>  
>    First successful read is saved as the required buffer alignment. 
>  
>  
> Before the patch, both probes would yield 4096 and everything would work fine.
> (The file in question is stored on 4K block device)
>  
>  
> After the patch the buffer alignment probe succeeds at 512 bytes.
> This means that the kernel now allows to read 4K of data at file offset 0 with a buffer that
> is only 512 bytes aligned. 
>  
> It is worth to note that the probe was done using 'pread' syscall.
>  
>  
> Later on, qemu likely reads the 1st 512 sector of the drive.
>  
> It uses preadv with 2 io vectors:
>  
> First one is for 512 bytes and it seems to have 0xC00 offset into page 
> (likely depends on debug session but seems to be consistent)
>  
> Second one is for 3584 bytes and also has a buffer that is not 4K aligned.
> (0x200 page offset this time)
>  
> This means that the qemu does respect the 4K block size but only respects 512 bytes buffer alignment,
> which is consistent with the result of the probing.
>  
> And that preadv fails with -EINVAL
>  
> Forcing qemu to use 4K buffer size fixes the issue, as well as reverting the offending commit.
>  
> Any patches, suggestions are welcome.
> 
> I use 6.0-rc7, using mainline master branch as yesterday.
>  
> Best regards,
> 	Maxim Levitsky
> 
Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced bf8d08532bc1
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
