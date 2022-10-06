Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D416C5F5E82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 03:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJFB6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 21:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJFB6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:58:23 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7E1D0F6;
        Wed,  5 Oct 2022 18:58:20 -0700 (PDT)
Message-ID: <25968b7b-7662-303e-c280-931e6330927e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665021497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LY2hnP1nNE0HYnTSxbNKf79QUruu2XPr8HxWVKrvw2k=;
        b=g6u09OrDC3nXdKT9uCiHyrW3IZn1ueVxtC/U83wwYQRWorBZB9NR4nR6Z72k9QMYW4PWsk
        oEayfraYxeWemOHVz2G7DRfPxmsE4R3lImrWfZZjRIeGFpQA5O9wtCxVDEgORjzzhCrmPy
        R9iEZ6+Pcq0vDqJxVyxYO/Wfmewmbxc=
Date:   Wed, 5 Oct 2022 18:58:03 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 00/26] FUSE BPF: A Stacked Filesystem Extension for FUSE
Content-Language: en-US
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
References: <20220926231822.994383-1-drosen@google.com>
 <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
 <CA+PiJmQM_Fi-W7ZaPQHiM6w6eqo0TSpTh3rUz+CnmXRbp_PUBA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CA+PiJmQM_Fi-W7ZaPQHiM6w6eqo0TSpTh3rUz+CnmXRbp_PUBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/30/22 5:05 PM, Daniel Rosenberg wrote:
> On Tue, Sep 27, 2022 at 11:41 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> Interesting idea.
>>
>> Some comments on review logistics:
>> - The set is too long and some of the individual patches are way too long for
>> one single patch to review.  Keep in mind that not all of us here are experts in
>> both fuse and bpf.  Making it easier to review first will help at the beginning.
>>    Some ideas:
>>
>>     - Only implement a few ops in the initial revision. From quickly browsing the
>> set, it is implementing the 'struct file_operations fuse_file_operations'?
>> Maybe the first few revisions can start with a few of the ops first.
>>
> 
> I've split it up a fair bit already, do you mean just sending a subset
> of them at a time? I think the current splitting roughly allows for
> that. Patch 1-4 and 5 deal with bpf/verifier code which isn't used
> until patch 24. I can reorder/split up the opcodes arbitrarily.


> Putting the op codes that implement file passthrough first makes
> sense. The code is much easier to test when all/most are present,
> since then I can just use patch 23 to mount without a daemon and run
> xfs tests on them. At least initially I felt the whole stack was
> useful to give the full picture.

I don't mind to have all op codes in each re-spin as long as it can apply 
cleanly to bpf-next where the bpf implementation part will eventually land. 
Patch 26 has to split up though.  It is a few thousand lines in one patch.

I was just thinking to only do a few op codes, eg. the few android use cases you 
have mentioned.  My feeling is other op codes should not be very different in 
term of the bpf side implementation (or it is not true?).  When the patch set 
getting enough traction, then start adding more op codes in the later revisions. 
  That will likely help to re-spin faster and save you time also.


>> - iiuc, the idea is to allow bpf prog to optionally handle the 'struct
>> file_operations' without going back to the user daemon? Have you looked at
>> struct_ops which seems to be a better fit here?  If the bpf prog does not know
>> how to handle an operation (or file?), it can call fuse_file_llseek (for
>> example) as a kfunc to handle the request.
>>
> 
> I wasn't aware of struct_ops. It looks like that may work for us
> instead of making a new prog type. I'll definitely look into that.
> I'll likely sign up for the bpf office hours next week.

You can take a look at the tools/testing/selftests/bpf/progs/bpf_cubic.c.
It implements the whole tcp congestion in bpf. In particular, the bpf prog is 
implementing the kernel 'struct tcp_congestion_ops'.  That selftest example is 
pretty much a direct copy from the kernel net/ipv4/tcp_cubic.c.  Also, in 
BPF_STRUCT_OPS(bpf_cubic_undo_cwnd, ...), it is directly calling the kfunc's 
tcp_reno_undo_cwnd() when the bpf prog does not need to do anything different 
from the kernel's tcp_reno_undo_cwnd().  Look at how it is marked as __ksym in 
bpf_cubic.c

However, echoing Alexei's earlier reply, struct_ops is good when it needs to 
implement a well defined 'struct xyz_operations' that has all function pointer 
in it.  Taking another skim at the set, it seems like it is mostly trying to 
intercept the fuse_simple_request() call?

