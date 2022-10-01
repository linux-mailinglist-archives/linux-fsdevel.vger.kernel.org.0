Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871B85F1759
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 02:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiJAA1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 20:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiJAA0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:26:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A2336842;
        Fri, 30 Sep 2022 17:24:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m15so7891258edb.13;
        Fri, 30 Sep 2022 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AGRUoio3uI4f7S0p87aWXQ0q14GMUPYSMzSuMcnui98=;
        b=OnpxhWD7HXdimAxnquarrFbJfnvQ/03bFsbzbzkMueVPVI2zOtx5Jf1ns2X5EUKl7g
         7JVMOQrPokhqQasVl8SA1/C9iBAkuqGJJBH4kpnyPpgIpQA8VgOS8oH5DTNCkFcJljkB
         ZKtustJ3JlalCF2TtoO+DSDQgH2G6G/DLTsRg30S4/xn27DOc9pjqAGPXSnegrMfgPUk
         Y995AXVrY4KPkFcBac2+3ht13UR9wKbUBc6z4b0TtJ06Fnss8bA3NT4JDdB3IN6NPon/
         rY0hleDTW+kK4DeKyLL8/sGR4dEKjGEx0YvQUdRSscF6XYsdLti6WIG87bsrDy3CmLfQ
         oSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AGRUoio3uI4f7S0p87aWXQ0q14GMUPYSMzSuMcnui98=;
        b=V04K8tIn3UNq9dWxjOvKCE94axYina4jCxuMEAK1PAOr/SA8p7oy+MgRaQ37bpUL4k
         lBY/kQjWyiz0S56AZ3EM2+uri/FE+Pb324Fo5lbSiA++nvprAOTv2z9DiSyiqt6nNOb2
         sUqH1Qr1XXDol4HyeFfwOFFCu3Mog+dprxIOJQnXWDApmvUgS+2lC9ckZxQvMq8Usafe
         nWHIbpgRFM445tBWN2Q6M/pjzwbPOAnyf9a/gEQwUo/jAdt5JEE4nUo118jf1ItrEdps
         2VswUFGH3AF06LfyIXoaXPbuuEPAEY1VEiiUbZ1cbWGg7++Gya5QX33y4oQm2hTGPWau
         Jb5w==
X-Gm-Message-State: ACrzQf0+i+3E/18UJoSK3GiqgaddRwkNVHvNqL3Jsw2fcf5pBDSSqdHj
        bmvNex0wj/shxkg0Vg3siwxsxdpRNVJEYknSIrQ=
X-Google-Smtp-Source: AMsMyM6GSslZ/AflTUMqinVIVyRwvSLV5spXexk9YJNxZ33IyH8LkD99A8lziJ3CJyyf+nf4U/8XpMMfeNqnAqXzfmw=
X-Received: by 2002:aa7:cc02:0:b0:453:b0f3:9927 with SMTP id
 q2-20020aa7cc02000000b00453b0f39927mr9920399edt.66.1664583892771; Fri, 30 Sep
 2022 17:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <1fc38ba0-2bbe-a496-604d-7deeb4e72787@linux.dev>
 <CA+PiJmQM_Fi-W7ZaPQHiM6w6eqo0TSpTh3rUz+CnmXRbp_PUBA@mail.gmail.com>
In-Reply-To: <CA+PiJmQM_Fi-W7ZaPQHiM6w6eqo0TSpTh3rUz+CnmXRbp_PUBA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 30 Sep 2022 17:24:41 -0700
Message-ID: <CAADnVQKstXUbzovSqn-WRPnUCRzeRvS4n7VdbwTm4DhqvBo8kg@mail.gmail.com>
Subject: Re: [PATCH 00/26] FUSE BPF: A Stacked Filesystem Extension for FUSE
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 5:05 PM Daniel Rosenberg <drosen@google.com> wrote:
>
> >    - Please make the patches that can be applied to the bpf-next tree cleanly.
> > For example, in patch 3, where is 18e2ec5bf453 coming from? I cannot find it in
> > bpf-next and linux-next tree.
> >    - Without applying it to an upstream tree cleanly, in a big set like this, I
> > have no idea when bpf_prog_run() is called in patch 24 because the diff context
> > is in fuse_bpf_cleanup and apparently it is not where the bpf prog is run.
> >
>
> Currently this is based off of
> bf682942cd26ce9cd5e87f73ae099b383041e782 in
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> I would have rebased on top of bpf-next, except that from my
> conversations at plumbers, I figured that the set up would need to
> change significantly, and that effort would be wasted. My goal
> including them here was to give more of a sense of what our needs are,
> and be a starting point for working out what we really ought to be
> using.

It was a good idea to send it early :)

>
> > Some high level comments on the set:
> > - Instead of adding bpf helpers, you should consider kfunc instead. You can take
> > a look at the recent HID patchset v10 or the recent nf conntrack bpf set.
> >
> > - Instead of expressing as packet data, using the recent dynptr is a better way
> > to go for handling a mem blob.
> >
>
> I'll look into those, I remember them coming up at LPC. My current use
> of packets/buffers does seem to abuse their intended meaning a bit.

This 'abuse' is sorta, kinda, ok-ish. We can accept that,
but once you convert to kfunc interface you might realize that
"packet" abstraction is not necessary here and there are
cleaner alternatives. Have you looked at dynptr ?

> > - iiuc, the idea is to allow bpf prog to optionally handle the 'struct
> > file_operations' without going back to the user daemon? Have you looked at
> > struct_ops which seems to be a better fit here?  If the bpf prog does not know
> > how to handle an operation (or file?), it can call fuse_file_llseek (for
> > example) as a kfunc to handle the request.
> >
>
> I wasn't aware of struct_ops. It looks like that may work for us
> instead of making a new prog type. I'll definitely look into that.
> I'll likely sign up for the bpf office hours next week.

I have to second everything that Martin suggested.

To reiterate his points in different words:
. patch 26 with printk debug only gives very low
confidence that the presented api towards bpf programs
will be usable.
The patch series gotta have a production worthy bpf program
that actually does things you want it to do.

. please use kfunc mechanism similar to the way hid-bpf is doing.
If individual funcs are not enough and you need to attach
a set of bpf programs all at once then use struct_ops.
kfuncs are prefered if you don't need atomicity of a set of progs.
If it's fine to attach progs one at a time to different nop==empty
functions than just use a set of nop funcs and call back into
the kernel with kfuncs.
That would be easier to rip out when api turns out to
be insufficient or extensions are necessary.

> > - The test SEC("test_trace") seems mostly a synthetic test for checking
> > correctness.  Does it have a test that shows a more real life use case? or I
> > have missed things in patch 26?
> >
>
> Patch 26 is pretty much all synthetic tests. A lot of them are just
> ensuring that we even call in to the bpf program, and some limited
> testing that changing the filters has the expected results. We
> mentioned a few more concrete usecases in the LPC talk. One of those
> is folder hiding. In Android we've had an issue with leaking the
> existence of some apps to other apps. We needed to hide certain
> directories from apps where they do have permissions to traverse the
> directory. Attempting to access a folder without permissions would
> result in EPERM, revealing the existence of that folder. Since the
> application doesn't have permission to create arbitrary folders at
> that level, we can hide it by using fuse-bpf to change the EPERM into
> an ENOENT, and then filter readdir to remove disallowed entries. You
> can see something like that in bpf_test_redact_readdir. We also have
> some file level redaction. If an app doesn't have location
> permissions, but does have file permissions, they could just read
> picture metadata to get location information. We could have bpf
> redirect reads that might contain location data to the daemon, while
> passing through other parts.

The described use cases sound useful.
Just present them as real bpf progs.

My main concern, though, is with patches 7-25.
I don't understand file systems, but it looks like the patches
bring features into fuse from other file systems.
In many ways it looks like overlayfs.
Maybe just add bpf hooks to overlayfs?
Why fuse at all?
It might look like a bunch of nop functions sprinkled around overlayfs
code.
If you need to talk to user space from bpf prog you'll have
ringbuf and user_ringbuf to stream data from bpf prog to user
and back.
