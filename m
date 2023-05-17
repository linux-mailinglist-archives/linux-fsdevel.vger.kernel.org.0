Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49010705D74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 04:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjEQCu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjEQCu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 22:50:57 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492F103;
        Tue, 16 May 2023 19:50:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0ViqnrSZ_1684291846;
Received: from 30.97.48.190(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0ViqnrSZ_1684291846)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 10:50:50 +0800
Message-ID: <93e0e991-147f-0021-d635-95e615057273@linux.alibaba.com>
Date:   Wed, 17 May 2023 10:50:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
To:     Daniel Rosenberg <drosen@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CA+PiJmTMs2u=J6ANYqHdGww5SoE_focZGjMRZk5WgoH8fVuCsA@mail.gmail.com>
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



On 2023/5/2 17:07, Daniel Rosenberg wrote:
> On Mon, Apr 24, 2023 at 8:32 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>
>> The security model needs to be thought about and documented.  Think
>> about this: the fuse server now delegates operations it would itself
>> perform to the passthrough code in fuse.  The permissions that would
>> have been checked in the context of the fuse server are now checked in
>> the context of the task performing the operation.  The server may be
>> able to bypass seccomp restrictions.  Files that are open on the
>> backing filesystem are now hidden (e.g. lsof won't find these), which
>> allows the server to obfuscate accesses to backing files.  Etc.
>>
>> These are not particularly worrying if the server is privileged, but
>> fuse comes with the history of supporting unprivileged servers, so we
>> should look at supporting passthrough with unprivileged servers as
>> well.
>>
> 
> This is on my todo list. My current plan is to grab the creds that the
> daemon uses to respond to FUSE_INIT. That should keep behavior fairly
> similar. I'm not sure if there are cases where the fuse server is
> operating under multiple contexts.
> I don't currently have a plan for exposing open files via lsof. Every
> such file should relate to one that will show up though. I haven't dug
> into how that's set up, but I'm open to suggestions.
> 
>> My other generic comment is that you should add justification for
>> doing this in the first place.  I guess it's mainly performance.  So
>> how performance can be won in real life cases?   It would also be good
>> to measure the contribution of individual ops to that win.   Is there
>> another reason for this besides performance?
>>
>> Thanks,
>> Miklos
> 
> Our main concern with it is performance. We have some preliminary
> numbers looking at the pure passthrough case. We've been testing using
> a ramdrive on a somewhat slow machine, as that should highlight
> differences more. We ran fio for sequential reads, and random
> read/write. For sequential reads, we were seeing libfuse's
> passthrough_hp take about a 50% hit, with fuse-bpf not being
> detectably slower. For random read/write, we were seeing a roughly 90%
> drop in performance from passthrough_hp, while fuse-bpf has about a 7%
> drop in read and write speed. When we use a bpf that traces every
> opcode, that performance hit increases to a roughly 1% drop in
> sequential read performance, and a 20% drop in both read and write
> performance for random read/write. We plan to make more complex bpf
> examples, with fuse daemon equivalents to compare against.
> 
> We have not looked closely at the impact of individual opcodes yet.
> 
> There's also a potential ease of use for fuse-bpf. If you're
> implementing a fuse daemon that is largely mirroring a backing
> filesystem, you only need to write code for the differences in
> behavior. For instance, say you want to remove image metadata like
> location. You could give bpf information on what range of data is
> metadata, and zero out that section without having to handle any other
> operations.

A bit out of topic (although I'm not quite look into FUSE BPF internals)
After roughly listening to this topic in FS track last week, I'm not
quite sure (at least in the long term) if it might be better if
ebpf-related filter/redirect stuffs could be landed in vfs or in a
somewhat stackable fs so that we could redirect/filter any sub-fstree
in principle?    It's just an open question and I have no real tendency
of this but do we really need a BPF-filter functionality for each
individual fs?

It sounds much like
https://learn.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers

Thanks,
Gao Xiang

> 
>   -Daniel
