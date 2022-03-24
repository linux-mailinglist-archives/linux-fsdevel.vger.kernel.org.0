Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05D4E631E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiCXMUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350089AbiCXMUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:20:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD833137E
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 05:18:34 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nXMQC-0007XD-DU; Thu, 24 Mar 2022 13:18:32 +0100
Message-ID: <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
Date:   Thu, 24 Mar 2022 13:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Content-Language: en-US
To:     Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648124315;ceeb3a61;
X-HE-SMSGID: 1nXMQC-0007XD-DU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 21.03.22 05:53, Bruno Damasceno Freire wrote:
> Hello everybody;
> 
> This regression was first found during rpm operations with specific packages that became A LOT slower to update ranging from 4 to 30 minutes.
> 
> The slowness results from:
> a_ the kernel regression: specific system calls touching files with btrfs compression property will generate higher inode eviction on 5.15 kernels.
> b_ the inode eviction generating btrfs inode logging and directory logging.
> c_ the btrfs directory logging on the 5.15 kernel not being particulary efficient in the presence of high inode eviction.
> 
> There is already an ongoing work [1] to improve "c" on newer kernels but I was told they are not elegible for the 5.15 version due to backporting policy restrictions.
> AFAIK there isn't any work for "a" yet.
> The consequence is that btrfs users running the 5.15 LTS kernel may experience severely degraded performance for specific I/O workloads on files with the compression property enabled.
> 
> ___How to reproduce:
> After some research I learned how to reproduce the regression without rpm.
>
> 1st option)
> I made a script specifically to research this regression [2].
> It has more information, more test results and several options.
> The scrip does a little too much so I'm just linking it here.
> I hope it can help.
> 
> 2nd option)
> boot a 5.15 kernel,
> setup and mount a RAM disk with btrfs,
> create a folder and set its compression property,
> populate the folder,
> make a loop that:
> -rename a file,
> -unlink the renamed file,
> -create a new file.
> 
> [1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
> [2] https://github.com/bdamascen0/s3e
> 
> ___Test results
> These tests were done on a virtual machine (kvm) with Ubuntu Jammy Jellyfish.
> The kernel is 5.15.0.23 that relates to the 5.15.27 upstream kernel.

Please repeat this with a vanilla kernel, Ubuntu's kernel are heavily
patched and one of their patches might be causing your problem.

> Main results (x86_64):
> 250 files - zstd:         17521 ms @inode_evictions: 31375
> 250 files - lzo:          17114 ms @inode_evictions: 31375
> 250 files - uncompressed:  1138 ms @inode_evictions: 499
> 
> Load test results (x86_64):
> 1000 files - 51.6 x more inode evictions - 18.1 x more time
> 250  files - 62.9 x more inode evictions - 15.2 x more time
> 100  files - 25.4 x more inode evictions -  3.7 x more time
> 50   files - 12.8 x more inode evictions -  2.0 x more time
> 10   files -  2.8 x more inode evictions -  1.3 x more time

I'm missing something: more inode evictions when compared to what? A
5.14 vanilla kernel?

> CPU usage results (x86_64):
> 1000 files - zstd:           137841 ms
> real    2m17,881s
> user    0m1,704s
> sys     2m11,937s
> 1000 files - lzo:            135456 ms
> real    2m15,478s
> user    0m1,805s
> sys	2m9,758s
> 1000 files - uncompressed:     7496 ms
> real    0m7,517s
> user    0m1,386s
> sys     0m4,899s
> 
> I'm sending this message to the linux-fsdevel mailing list first.
> Please tell if you think this subject would be of interest of another kernel subsystem.
> PS: I'm not subscribed to this list.

We need to get Btrfs people into the boat, but please clarify first if
this really is a regression with the upstream kernel.

Ciao, Thorsten
