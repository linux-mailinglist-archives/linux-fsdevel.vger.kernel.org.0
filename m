Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1235ED532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 08:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiI1GnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiI1GmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:42:04 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E631D05CC;
        Tue, 27 Sep 2022 23:41:59 -0700 (PDT)
Message-ID: <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664347316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxmEJE2QQKtRPfcnLQGidM83NFh8jGdqF00NGS5ELXo=;
        b=Zb7QgKiZQwRACniiBv/HyHNiLS7Wz+gPShfDdJWIElyoCr+kfFep6DmPoCIBzw/qeaRrjh
        kCOQb1vYQ/ZT+OkSKkocuTXKmt1ycCmVwLx3QmmeznDFTfnqe7orUc9evlQZxfE2mlkzer
        /8ICr3kceBxT7Ij/bY8A41xLc4KTDLo=
Date:   Tue, 27 Sep 2022 23:41:50 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/22 4:17 PM, Daniel Rosenberg wrote:
> These patches extend FUSE to be able to act as a stacked filesystem. This
> allows pure passthrough, where the fuse file system simply reflects the lower
> filesystem, and also allows optional pre and post filtering in BPF and/or the
> userspace daemon as needed. This can dramatically reduce or even eliminate
> transitions to and from userspace.
> 
> Currently, we either set the backing file/bpf at mount time at the root level,
> or at lookup time, via an optional block added at the end of the lookup return
> call. The added lookup block contains an fd for the backing file/folder and bpf
> if necessary, or a signal to clear or inherit the parent values. We're looking
> into two options for extending this to mkdir/mknod/etc, as we currently only
> support setting the backing to a pre-existing file, although naturally you can
> create new ones. When we're doing a lookup for create, we could pass an
> fd for the parent dir and the name of the backing file we're creating. This has
> the benefit of avoiding an additional call to userspace, but requires hanging
> on to some data in a negative dentry where there is no elegant place to store it.
> Another option is adding the same block we added to lookup to the create type
> op codes. This keeps that code more uniform, but means userspace must implement
> that logic in more areas.
> 
> As is, the patches definitely need some work before they're ready. We still
> need to go through and ensure we respect changed filter values/disallow changes
> that don't make sense. We aren't currently calling mnt_want_write for the lower
> calls where appropriate, and we don't have an override_creds layer either. We
> also plan to add to our read/write iter filters to allow for more interesting
> use cases. There are also probably some node id inconsistencies. For nodes that
> will be completely passthrough, we give an id of 0.
> 
> For the BPF verification side, we have currently set things set up in the old
> style, with a new bpf program type and helper functions. From LPC, my
> understanding is that newer bpf additions are done in a new style, so I imagine
> much of that will need to be redone as well, but hopefully these patches get
> across what our needs there are.
> 
> For testing, we've provided the selftest code we have been using. We also have
> a mode to run with no userspace daemon in a pure passthrough mode that I have
> been running xfstests over to get some coverage on the backing operation code.
> I had to modify mounts/unmounts to get that running, along with some other
> small touch ups. The most notable failure I currently see there is in
> generic/126, which I suspect is likely related to override_creds.
> 

Interesting idea.

Some comments on review logistics:
- The set is too long and some of the individual patches are way too long for 
one single patch to review.  Keep in mind that not all of us here are experts in 
both fuse and bpf.  Making it easier to review first will help at the beginning. 
  Some ideas:

   - Only implement a few ops in the initial revision. From quickly browsing the 
set, it is implementing the 'struct file_operations fuse_file_operations'? 
Maybe the first few revisions can start with a few of the ops first.

   - Please make the patches that can be applied to the bpf-next tree cleanly. 
For example, in patch 3, where is 18e2ec5bf453 coming from? I cannot find it in 
bpf-next and linux-next tree.
   - Without applying it to an upstream tree cleanly, in a big set like this, I 
have no idea when bpf_prog_run() is called in patch 24 because the diff context 
is in fuse_bpf_cleanup and apparently it is not where the bpf prog is run.

Some high level comments on the set:
- Instead of adding bpf helpers, you should consider kfunc instead. You can take 
a look at the recent HID patchset v10 or the recent nf conntrack bpf set.

- Instead of expressing as packet data, using the recent dynptr is a better way 
to go for handling a mem blob.

- iiuc, the idea is to allow bpf prog to optionally handle the 'struct 
file_operations' without going back to the user daemon? Have you looked at 
struct_ops which seems to be a better fit here?  If the bpf prog does not know 
how to handle an operation (or file?), it can call fuse_file_llseek (for 
example) as a kfunc to handle the request.

- The test SEC("test_trace") seems mostly a synthetic test for checking 
correctness.  Does it have a test that shows a more real life use case? or I 
have missed things in patch 26?

- Please use the skel to load the program.  It is pretty hard to read the loader 
in patch 26.

- I assume the main objective is for performance by not going back to the user 
daemon?  Do you have performance number?
