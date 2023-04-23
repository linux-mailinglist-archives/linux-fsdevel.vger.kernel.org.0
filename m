Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9A6EC090
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Apr 2023 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjDWOvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjDWOvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:51:12 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C63271C;
        Sun, 23 Apr 2023 07:51:07 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-42ff08ab61dso765420137.1;
        Sun, 23 Apr 2023 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682261466; x=1684853466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Byy5aNIeSbfDla4aJVVFrIzVSy2E3RHqITcEmVo7JRE=;
        b=RKBXXCzMbPO0c3dNHN4kOwMb50a1vI21F46uM2qNrVGZnxlLgn6ryNiwH1XqALlyv7
         mZQRQuTDmWR38qNqUA2rrHKP5Uhei0U8KHgtxj0lsz6a2FfEzm3+tYKroNLLgYxBiwKk
         MLD2rYfWu3b0phFlVaYGkcvgnIFD3jbaMYAPdk5rPRrdzAvXYf7mJJMJ4KGa34iDcPt4
         5ox0VFI/dPyeyTAhwd0MFh3YbdadxiwI14v1BK4DXfxDmc0mcGoQDdBZXnXi4+2CrscN
         FyRRXhJW9V/P8Nb0SBdcjBCgwi04HqJfwI20sjH4UMKLdKUutDpCdU1VvKebky04iNnp
         P9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682261466; x=1684853466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Byy5aNIeSbfDla4aJVVFrIzVSy2E3RHqITcEmVo7JRE=;
        b=GzX2wnZG97WGdB1le7spxvoebd1vJqz9duV/KV+vBz6YU0+OYg+eTUSBpGYixvBwAQ
         A2ukyAt/8/yvW06Rm1+vRIlYFwtxC+/xSl+/gfSJHcdCYEYRwp6ko4laz+cnKuyibza4
         cCeJF8NwTckjEhzIDHI1HgnNvnbT8NSvQ+6ew95L124ch4WLugOwFSZRwiKSm156JJAa
         CPZ1ADB3vEAPWcCkWo0FPQZlEVShSg/XbOXeiFU72bzlLbOnYoExAAG2wHyJaCVjSEiK
         ir9zJYhB7FQ/HuQfpGw/xsq/NSNFmhGeL9GPeyeug/kH25pTeJbl3v7xdEOxP2BIlwpw
         /m6w==
X-Gm-Message-State: AAQBX9ds2/4kjJ7PTkuRS51NclIssKzjw6znnCCVBEMafEsxNJsSPKma
        v7l+6Mg+6KZBhPVKXSAdx9I1bJq8QCkmKKVo950=
X-Google-Smtp-Source: AKy350Z5gzn4UWfEtW4Wn7+TaHy7dwqZraT/JdO1pegO5CuBK/GTa8ixWUrBAabB5nkoPrMqhSd1EaFai8Vxlw5iCMg=
X-Received: by 2002:a67:fe97:0:b0:430:23c2:1c05 with SMTP id
 b23-20020a67fe97000000b0043023c21c05mr4275621vsr.4.1682261466002; Sun, 23 Apr
 2023 07:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <CAOQ4uxhpFrRVcviQ6bK1ZMtZDSMXRFuqY-d_+uQ1C0YMDtQpLA@mail.gmail.com>
 <CA+PiJmT1wCoGnqtVSfcM-0qKm=Vu-jPf=7Op90vcGo3A7kYr0g@mail.gmail.com>
In-Reply-To: <CA+PiJmT1wCoGnqtVSfcM-0qKm=Vu-jPf=7Op90vcGo3A7kYr0g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 23 Apr 2023 17:50:53 +0300
Message-ID: <CAOQ4uxgwmsAA8b1ApmHh9fKuSyy0-NKgpkDSLk-gUWnaGKXtFQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 4:41=E2=80=AFAM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> On Mon, Apr 17, 2023 at 10:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> >
> > Which brings me to my biggest concern.
> > I still do not see how these patches replace Allesio's
> > FUSE_DEV_IOC_PASSTHROUGH_OPEN patches.
> >
> > Is the idea here that ioctl needs to be done at FUSE_LOOKUP
> > instead or in addition to the ioctl on FUSE_OPEN to setup the
> > read/write passthrough on the backing file?
> >
>
> In these patches, the fuse daemon responds to the lookup request via
> an ioctl, essentially in the same way it would have to the /dev/fuse
> node. It just flags the write as coming from an ioctl and calls
> fuse_dev_do_write. An additional block in the lookup response gives
> the backing file and what bpf_ops to use. The main difference is that
> fuse-bpf uses backing inodes, while passthrough uses a file.

Ah right. I wonder if there is benefit in both APIs or if backing inode
is sufficient to impelelent everything the could be interesting to implemen=
t
with a backing file.

> Fuse-bpf's read/write support currently isn't complete, but it does
> allow for direct passthrough. You could set ops to default to
> userspace in every case that Allesio's passthrough code does and it
> should have about the same effect.

What are the subtle differences then?

> With the struct_op change, I did
> notice that doing something like that is more annoying, and am
> planning to add a default op which only takes the meta info and runs
> if the opcode specific op is not present.
>

Sounds interesting. I'll wait to see what you propose.

>
> > I am missing things like the FILESYSTEM_MAX_STACK_DEPTH check that
> > was added as a result of review on Allesio's patches.
> >
>
> I'd definitely want to fix any issues that were fixed there. There's a
> lot of common code between fuse-bpf and fuse passthrough, so many of
> the suggestions there will apply here.
>

That's why I suggested trying to implement the passthough file ioctl
functionality first to make sure that none of the review comments
in the first round were missed.

But if we need functionality of both ioctls, we can collaborate the
work on merging them separately.

> > The reason I am concerned about this is that we are using the
> > FUSE_DEV_IOC_PASSTHROUGH_OPEN patches and I would like
> > to upstream their functionality sooner rather than later.
> > These patches have already been running in production for a while
> > I believe that they are running in Android as well and there is value
> > in upsteaming well tested patches.
> >
> > The API does not need to stay FUSE_DEV_IOC_PASSTHROUGH_OPEN
> > it should be an API that is extendable to FUSE-BPF, but it would be
> > useful if the read/write passthrough could be the goal for first merge.
> >
> > Does any of this make sense to you?
> > Can you draw a roadmap for merging FUSE-BPF that starts with
> > a first (hopefully short term) phase that adds the read/write passthrou=
gh
> > functionality?
> >
> > I can help with review and testing of that part if needed.
> > I was planning to discuss this with you on LSFMM anyway,
> > but better start the discussion beforehand.
> >
> > Thanks,
> > Amir.
>
> We've been using an earlier version of fuse-bpf on Android, closer to
> the V1 patches. They fit our current needs but don't cover everything
> we intend to. The V3 patches switch to a new style of bpf program,
> which I'm hoping to get some feedback on before I spend too much time
> fixing up the details. The backing calls themselves can be reviewed
> separately from that though.
>
> Without bpf, we're essentially enabling complete passthrough at a
> directory or file. By default, once you set a backing file fuse-bpf
> calls by the backing filesystem by default, with no additional
> userspace interaction apart from if an installed bpf program says
> otherwise. If we had some commands without others, we'd have behavior
> changes as we introduce support for additional calls. We'd need a way
> to set default behavior. Perhaps something like a u64 flag field
> extension in FUSE_INIT for indicating which opcodes support backing,
> and a response for what those should default to doing. If there's a
> bpf_op present for a given opcode, it would be able to override that
> default. If we had something like that, we'd be able to add support
> for a subset of opcodes in a sensible way.

So maybe this is something to consider.

Thanks,
Amir.
