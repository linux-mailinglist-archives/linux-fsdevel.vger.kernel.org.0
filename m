Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CDA710E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbjEYOSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjEYOSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 10:18:03 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D334189;
        Thu, 25 May 2023 07:17:59 -0700 (PDT)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPS id 0F5225CC312;
        Thu, 25 May 2023 09:17:58 -0500 (CDT)
Message-ID: <2099f62e-460b-cc49-d0d0-a288d33619f0@sandeen.net>
Date:   Thu, 25 May 2023 09:17:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [Syzkaller & bisect] There is "soft lockup in __cleanup_mnt" in
 v6.4-rc3 kernel
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     dchinner@redhat.com, djwong@kernel.org, heng.su@intel.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lkp@intel.com
References: <ZG7PGdRED5A68Jyh@xpf.sh.intel.com>
 <f723cb17-ca68-4db9-c296-cf33b16c529c@sandeen.net>
 <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <ZG71v9dlDm0h4idA@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/25/23 12:44 AM, Pengfei Xu wrote:
> On 2023-05-24 at 22:51:27 -0500, Eric Sandeen wrote:
>> On 5/24/23 9:59 PM, Pengfei Xu wrote:
>>> Hi Dave,
>>>
>>> Greeting!
>>>
>>> Platform: Alder lake
>>> There is "soft lockup in __cleanup_mnt" in v6.4-rc3 kernel.
>>>
>>> Syzkaller analysis repro.report and bisect detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230524_140757___cleanup_mnt
>>> Guest machine info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/machineInfo0
>>> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.c
>>> Reproduced syscall: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/repro.prog
>>> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bisect_info.log
>>> Kconfig origin: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/kconfig_origin
>>
>> There was a lot of discussion yesterday about how turning the crank on
>> syzkaller and throwing un-triaged bug reports over the wall at stressed-out
>> xfs developers isn't particularly helpful.
>>
>> There was also a very specific concern raised in that discussion:
>>
>>> IOWs, the bug report is deficient and not complete, and so I'm
>>> forced to spend unnecessary time trying to work out how to extract
>>> the filesystem image from a weird syzkaller report that is basically
>>> just a bunch of undocumented blobs in a github tree.
>>
>> but here we are again, with another undocumented blob in a github tree, and
>> no meaningful attempt at triage.
>>
>> Syzbot at least is now providing filesystem images[1], which relieves some
>> of the burden on the filesystem developers you're expecting to fix these
>> bugs.
>>
>> Perhaps before you send the /next/ filesystem-related syzkaller report, you
>> can at least work out how to provide a standard filesystem image as part of
>> the reproducer, one that can be examined with normal filesystem development
>> and debugging tools?
>>
>    There is a standard filesystem image after
> 
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> image is named as centos8_3.img, and will boot by start3.sh.

Honestly, this suggests to me that you don't really have much 
understanding at all about the bugs you're reporting.

> There is bzImage v6.4-rc3 in link: https://github.com/xupengfe/syzkaller_logs/blob/main/230524_140757___cleanup_mnt/bzImage_v64rc3
> You could use it to boot v6.4-rc3 kernel.
> 
> ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Then you could reproduce this issue easily in above environment.

You seem to be suggesting that the xfs developers should go do /more 
work/ to get to the bare minimum of a decent fuzzed filesystem bug 
report, instead of you doing a little bit of prep work yourself by 
providing the fuzzed filesystem image itself?

Your github account says you are "looking to collaborate on Linux kernel 
learning" - tossing auto-generated and difficult-to-triage bug reports 
at other developers is not collaboration. Wouldn't it be more 
interesting to take the time to understand the reports you're 
generating, find ways to make them more accessible/debuggable, and/or 
take some time to look into the problems yourself, in order to learn 
about the code you're turning the crank on?

> Thanks!
> BR.
> 
>> [1]
>> https://lore.kernel.org/lkml/0000000000001f239205fb969174@google.com/T/
>>
>>
> 

