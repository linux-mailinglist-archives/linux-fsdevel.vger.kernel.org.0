Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3E4E9551
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 13:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiC1LlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiC1Lg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:36:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46101EEDF;
        Mon, 28 Mar 2022 04:28:54 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nYnYI-0003Fc-C2; Mon, 28 Mar 2022 13:28:50 +0200
Message-ID: <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
Date:   Mon, 28 Mar 2022 13:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1648466934;fd67f8be;
X-HE-SMSGID: 1nYnYI-0003Fc-C2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Btrfs developers, this is your Linux kernel regression tracker.
Top-posting for once, to make this easily accessible to everyone.

Are there any known regressions in 5.15 that cause more inode evictions?
There is a user reporting such problems, see the msg quoted below, which
is the last from this thread:

https://lore.kernel.org/all/MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com/

@Bruno: sorry, you report is very hard to follow at least for me. Maybe
the btrfs developers have a idea what's wrong here, but if not you
likely need to make this easier for all us:

Write a really simple testcase and run it on those vanilla kernels that
matter, which are in this case: The latest 5.17.y and 5.15.y releases to
check if it was already solved -- and if not, on 5.14 and 5.15. Maybe
you need to bisect the issue to bring us closer the the root of the
problem. But with a bit of luck the btrfs developers might have an idea
already.

Ciao, Thosten

On 28.03.22 05:12, Bruno Damasceno Freire wrote:
> ___Updated test results
> 
> These results were obtained with the script I've made to research this regression [1].
> [1] https://github.com/bdamascen0/s3e
> 
> 
> Main results
> 
> The regression was reproduced on:
> -several different 5.15 kernels versions across several different distros.
> -all 5.15 kernels that I have tried on.
> -the 5.15.0-rc1 kernel from the opensuse tumbleweed comunity repository.
> -the 5.15.12 vanilla kernel from the official opensuse tumbleweed repository.
> 
> The regression could not be reproduced on kernels versions other than the 5.15.
> 
> The vanilla kernel test was suggested by Thorsten Leemhuis to make sure downstream custom patches aren't causing the symptoms.
> The vanilla kernel test result shows the exact same pattern verified on downstream kernels and fully validates the regression.
> 
> 
> General test results for the 5.15 kernel series (x86_64)
> 
> opensuse tumbleweed ----- kernel 5.15.12 --- vanilla --- (kvm)
> ... 250 files - zstd:         13327 ms @inode_evictions: 31375
> ... 250 files - lzo:          13361 ms @inode_evictions: 31375
> ... 250 files - uncompressed:  1204 ms @inode_evictions: 499
> opensuse tumbleweed ----- kernel 5.15.0-rc1-1.g8787773 - (kvm)
> ... 250 files - zstd:         13875 ms @inode_evictions: 31375
> ... 250 files - lzo:          15351 ms @inode_evictions: 31375
> ... 250 files - uncompressed:  1231 ms @inode_evictions: 499
> opensuse tumbleweed ----- kernel 5.15.12----------------------
> ... 250 files - zstd:         12500 ms @inode_evictions: 31375
> ... 250 files - lzo:          12327 ms @inode_evictions: 31375
> ... 250 files - uncompressed:  1482 ms @inode_evictions: 499
> debian bookworm --------- kernel 5.15.0-3 - (5.15.15) -- (kvm)
> ... 250 files - zstd:         12343 ms @inode_evictions: 31375
> ... 250 files - lzo:          14028 ms @inode_evictions: 31375
> ... 250 files - uncompressed:  1092 ms @inode_evictions: 499
> Zenwalk 15.0 Skywalker ---kernel 5.15.19 --------------- (kvm)
> ... 250 files - zstd:         14374 ms @inode_evictions: -
> ... 250 files - lzo:          14163 ms @inode_evictions: -
> ... 250 files - uncompressed:  2173 ms @inode_evictions: -
> ubuntu jammy jellyfish -- kernel 5.15.0.23 - (5.15.27) - (kvm) 
> ... 250 files - zstd:         17521 ms @inode_evictions: 31375
> ... 250 files - lzo:          17114 ms @inode_evictions: 31375
> ... 250 files - uncompressed:  1138 ms @inode_evictions: 499
> 
> 
> General test results for other kernels (x86_64)
> 
> opensuse leap 15.3 ------ kernel 5.3.18-150300.59.54----------
> ... 250 files - zstd:           668 ms @inode_evictions: 251
> ... 250 files - lzo:            693 ms @inode_evictions: 251
> ... 250 files - uncompressed:   661 ms @inode_evictions: 252
> opensuse leap 15.4 beta - kernel 5.14.21-150400.11 ----- (kvm)
> ... 250 files - zstd:           811 ms @inode_evictions: 251
> ... 250 files - lzo:            912 ms @inode_evictions: 251
> ... 250 files - uncompressed:   993 ms @inode_evictions: 251
> opensuse tumbleweed ----- kernel 5.14.14 --------------- (kvm)
> ... 250 files - zstd:           888 ms @inode_evictions: 251
> ... 250 files - lzo:           1063 ms @inode_evictions: 251
> ... 250 files - uncompressed:   778 ms @inode_evictions: 251
> opensuse tumbleweed ----- kernel 5.16.14----------------------
> ... 250 files - zstd:          1398 ms @inode_evictions: 250
> ... 250 files - lzo:           1323 ms @inode_evictions: 250
> ... 250 files - uncompressed:  1365 ms @inode_evictions: 250
> 
> 
> Load test results (x86_64):
> 
> opensuse leap 15.4 beta - kernel 5.14.21-150400.11 ----- (kvm)
> ...   50 files - zstd:            261 ms @inode_evictions: 51
> ...   50 files - lzo:             256 ms @inode_evictions: 51
> ...   50 files - uncompressed:    317 ms @inode_evictions: 51
> ...  100 files - zstd:            450 ms @inode_evictions: 101
> ...  100 files - lzo:             461 ms @inode_evictions: 101
> ...  100 files - uncompressed:    471 ms @inode_evictions: 101
> ...  150 files - zstd:            618 ms @inode_evictions: 151
> ...  150 files - lzo:             624 ms @inode_evictions: 151
> ...  150 files - uncompressed:    612 ms @inode_evictions: 151
> ...  200 files - zstd:            822 ms @inode_evictions: 201
> ...  200 files - lzo:             933 ms @inode_evictions: 201
> ...  200 files - uncompressed:    747 ms @inode_evictions: 201
> ...  250 files - zstd:           1128 ms @inode_evictions: 251
> ...  250 files - lzo:             974 ms @inode_evictions: 251
> ...  250 files - uncompressed:    936 ms @inode_evictions: 251
> ... 1000 files - zstd:           3517 ms @inode_evictions: 1001
> ... 1000 files - lzo:            4373 ms @inode_evictions: 1001
> ... 1000 files - uncompressed:   3797 ms @inode_evictions: 1001
> ubuntu jammy jellyfish -- kernel 5.15.0.23 - (5.15.27) - (kvm) 
> ...   50 files - zstd:            424 ms @inode_evictions: 1275
> ...   50 files - lzo:             423 ms @inode_evictions: 1275
> ...   50 files - uncompressed:    207 ms @inode_evictions: 99
> ...  100 files - zstd:           1744 ms @inode_evictions: 5050
> ...  100 files - lzo:            1838 ms @inode_evictions: 5050
> ...  100 files - uncompressed:    373 ms @inode_evictions: 199
> ...  150 files - zstd:           4785 ms @inode_evictions: 11325
> ...  150 files - lzo:            4660 ms @inode_evictions: 11325
> ...  150 files - uncompressed:    689 ms @inode_evictions: 299
> ...  200 files - zstd:           9763 ms @inode_evictions: 20100
> ...  200 files - lzo:           10106 ms @inode_evictions: 20100
> ...  200 files - uncompressed:    938 ms @inode_evictions: 399
> ...  250 files - zstd:          17550 ms @inode_evictions: 31375
> ...  250 files - lzo:           17337 ms @inode_evictions: 31375
> ...  250 files - uncompressed:   1373 ms @inode_evictions: 499
> ... 1000 files - zstd:         143614 ms @inode_evictions: 101132
> ... 1000 files - lzo:          146724 ms @inode_evictions: 100314
> ... 1000 files - uncompressed:   7735 ms @inode_evictions: 1999
> 
> 
> Load test results comparisson for compressed files (x86_64):
> ubuntu jammy jellyfish - compared to - opensuse leap 15.4 beta
> 
> 50   files gives aprox.  1.6 x more time and aprox.  25 x more inode evictions 
> 100  files gives aprox.  3.8 x more time and aprox.  50 x more inode evictions 
> 150  files gives aprox.  7.4 x more time and aprox.  75 x more inode evictions 
> 200  files gives aprox. 10.8 x more time and aprox. 100 x more inode evictions 
> 250  files gives aprox. 15.5 x more time and aprox. 125 x more inode evictions 
> 1000 files gives aprox. 33.5 x more time and aprox. 100 x more inode evictions 
> 
> 
> Load test results comparisson for uncompressed files (x86_64):
> ubuntu jammy jellyfish - compared to - opensuse leap 15.4 beta
> 
> 50   files gives aprox. 0.6 x more time and aprox. 2 x more inode evictions 
> 100  files gives aprox. 0.8 x more time and aprox. 2 x more inode evictions 
> 150  files gives aprox. 1.1 x more time and aprox. 2 x more inode evictions 
> 200  files gives aprox. 1.2 x more time and aprox. 2 x more inode evictions 
> 250  files gives aprox. 1.4 x more time and aprox. 2 x more inode evictions 
> 1000 files gives aprox. 2.0 x more time and aprox. 2 x more inode evictions 
> 
> 
> CPU usage results:
> The regression causes significant CPU usage by the kernel.
> 
> ubuntu jammy jellyfish -- kernel  5.15.0.23 (5.15.27) - (kvm) 
> ... 1000 files - zstd:         137841 ms
>     real    2m17,881s
>     user    0m 1,704s
>     sys     2m11,937s
> ... 1000 files - lzo:          135456 ms
>     real    2m15,478s
>     user    0m 1,805s
>     sys     2m 9,758s
> ... 1000 files - uncompressed:   7496 ms
>     real    0m 7,517s
>     user    0m 1,386s
>     sys     0m 4,899s
> 
> 
> Test system specification:
> host: AMD FX-8370E 8 cores / 8GB RAM / ssd
> guests (kvm): 2 cores / 2G RAM / ssd
> test storage medium: RAM disk block device (host and guest)
> 
> 
> TIA, Bruno
