Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F241C7060FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEQHT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjEQHTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:19:40 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54301E1;
        Wed, 17 May 2023 00:19:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Vireqb9_1684307968;
Received: from 30.97.48.190(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vireqb9_1684307968)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 15:19:32 +0800
Message-ID: <caea44dd-10a8-accb-7dec-868fb8f2f061@linux.alibaba.com>
Date:   Wed, 17 May 2023 15:19:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
References: <20230418014037.2412394-1-drosen@google.com>
 <CAJfpegtuNgbZfLiKnpzdEP0sNtCt=83NjGtBnmtvMaon2avv2w@mail.gmail.com>
 <CA+PiJmTMs2u=J6ANYqHdGww5SoE_focZGjMRZk5WgoH8fVuCsA@mail.gmail.com>
 <93e0e991-147f-0021-d635-95e615057273@linux.alibaba.com>
 <CAOQ4uxjCebxGxkguAh9s4_Vg7QHM=oBoV0LUPZpb+0pcm3z1bw@mail.gmail.com>
 <7386e858-1026-2924-9df9-22350b1e33a7@linux.alibaba.com>
In-Reply-To: <7386e858-1026-2924-9df9-22350b1e33a7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/17 00:05, Gao Xiang wrote:
> Hi Amir,
> 
> On 2023/5/17 23:51, Amir Goldstein wrote:
>> On Wed, May 17, 2023 at 5:50 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2023/5/2 17:07, Daniel Rosenberg wrote:
>>>> On Mon, Apr 24, 2023 at 8:32 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>
>>>>>
>>>>> The security model needs to be thought about and documented.  Think
>>>>> about this: the fuse server now delegates operations it would itself
>>>>> perform to the passthrough code in fuse.  The permissions that would
>>>>> have been checked in the context of the fuse server are now checked in
>>>>> the context of the task performing the operation.  The server may be
>>>>> able to bypass seccomp restrictions.  Files that are open on the
>>>>> backing filesystem are now hidden (e.g. lsof won't find these), which
>>>>> allows the server to obfuscate accesses to backing files.  Etc.
>>>>>
>>>>> These are not particularly worrying if the server is privileged, but
>>>>> fuse comes with the history of supporting unprivileged servers, so we
>>>>> should look at supporting passthrough with unprivileged servers as
>>>>> well.
>>>>>
>>>>
>>>> This is on my todo list. My current plan is to grab the creds that the
>>>> daemon uses to respond to FUSE_INIT. That should keep behavior fairly
>>>> similar. I'm not sure if there are cases where the fuse server is
>>>> operating under multiple contexts.
>>>> I don't currently have a plan for exposing open files via lsof. Every
>>>> such file should relate to one that will show up though. I haven't dug
>>>> into how that's set up, but I'm open to suggestions.
>>>>
>>>>> My other generic comment is that you should add justification for
>>>>> doing this in the first place.  I guess it's mainly performance.  So
>>>>> how performance can be won in real life cases?   It would also be good
>>>>> to measure the contribution of individual ops to that win.   Is there
>>>>> another reason for this besides performance?
>>>>>
>>>>> Thanks,
>>>>> Miklos
>>>>
>>>> Our main concern with it is performance. We have some preliminary
>>>> numbers looking at the pure passthrough case. We've been testing using
>>>> a ramdrive on a somewhat slow machine, as that should highlight
>>>> differences more. We ran fio for sequential reads, and random
>>>> read/write. For sequential reads, we were seeing libfuse's
>>>> passthrough_hp take about a 50% hit, with fuse-bpf not being
>>>> detectably slower. For random read/write, we were seeing a roughly 90%
>>>> drop in performance from passthrough_hp, while fuse-bpf has about a 7%
>>>> drop in read and write speed. When we use a bpf that traces every
>>>> opcode, that performance hit increases to a roughly 1% drop in
>>>> sequential read performance, and a 20% drop in both read and write
>>>> performance for random read/write. We plan to make more complex bpf
>>>> examples, with fuse daemon equivalents to compare against.
>>>>
>>>> We have not looked closely at the impact of individual opcodes yet.
>>>>
>>>> There's also a potential ease of use for fuse-bpf. If you're
>>>> implementing a fuse daemon that is largely mirroring a backing
>>>> filesystem, you only need to write code for the differences in
>>>> behavior. For instance, say you want to remove image metadata like
>>>> location. You could give bpf information on what range of data is
>>>> metadata, and zero out that section without having to handle any other
>>>> operations.
>>>
>>> A bit out of topic (although I'm not quite look into FUSE BPF internals)
>>> After roughly listening to this topic in FS track last week, I'm not
>>> quite sure (at least in the long term) if it might be better if
>>> ebpf-related filter/redirect stuffs could be landed in vfs or in a
>>> somewhat stackable fs so that we could redirect/filter any sub-fstree
>>> in principle?    It's just an open question and I have no real tendency
>>> of this but do we really need a BPF-filter functionality for each
>>> individual fs?
>>
>> I think that is a valid question, but the answer is that even if it makes sense,
>> doing something like this in vfs would be a much bigger project with larger
>> consequences on performance and security and whatnot, so even if
>> (and a very big if) this ever happens, using FUSE-BPF as a playground for
>> this sort of stuff would be a good idea.
> 
> My current observation is that the total Fuse-BPF LoC is already beyond the


                          ^ sorry I double-checked now I was wrong, forget about it.

> whole FUSE itself.  In addition, it almost hooks all fs operations which
> impacts something to me.
> 
>>
>> This reminds me of union mounts - it made sense to have union mount
>> functionality in vfs, but after a long winding road, a stacked fs (overlayfs)
>> turned out to be a much more practical solution.
> 
> Yeah, I agree.  So it was just a pure hint on my side.
> 
>>
>>>
>>> It sounds much like
>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers
>>>
>>
>> Nice reference.
>> I must admit that I found it hard to understand what Windows filter drivers
>> can do compared to FUSE-BPF design.
>> It'd be nice to get some comparison from what is planned for FUSE-BPF.
> 
> At least some investigation/analysis first might be better in the long
> term development.
> 
>>
>> Interesting to note that there is a "legacy" Windows filter driver API,
>> so Windows didn't get everything right for the first API - that is especially
>> interesting to look at as repeating other people's mistakes would be a shame.
> 
> I'm not familiar with that details as well, yet I saw that they have a
> filesystem filter subsystem, so I mentioned it here.
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Amir.
