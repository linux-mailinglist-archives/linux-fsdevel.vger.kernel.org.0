Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1B6E589B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDRFdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 01:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDRFdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:33:51 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F42527C;
        Mon, 17 Apr 2023 22:33:50 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id h42so600052vsv.1;
        Mon, 17 Apr 2023 22:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681796029; x=1684388029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btoO374fPa5onU2eXgJ4HR6tiMGcCFF/1uruvZyJrMA=;
        b=bi6YChZtZX14ZlO75gXi5ZrBPeQ5kvd/II3t2NFxUr5T0qthK4SCQP8hC4G7m1Hw4b
         QwQ7Hx0tzHnWpyvbH7kyw4H0fS+m0FGKgC5XT3j+ETfp1zTxaY0Mo46KsNibC+Udk2N0
         O4gxVIffchphG6IyYuVV+mXe4TRJBAmcBKmu/D18oWul6nKPd1leNx0HMGKoXVAY47VZ
         jDx5aJnvdfbGumWbA4F/YjxRW0xv7MxMWwS4Vkjq0PdoK2nSO8NrK8RcCMhp8Qrb13g9
         Vjpu4ydo3W6B7BeV5gzDRpnmh6iBSBeA7/UVkIOTYTHM4oBwt1tMSJCd3HugfDvpn1qX
         VAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681796029; x=1684388029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btoO374fPa5onU2eXgJ4HR6tiMGcCFF/1uruvZyJrMA=;
        b=erQrU0OnvTQI5YA5iQ9P606S+gSOqKxif/qgU3G6lG6bS80iA/u/3/ujYkKGcSXbC4
         /3p68u51MoXOYPfr5B0ePFaPHlAlGzLDIKjFVpXcG802+hkTRGztjdYPz8xu83G8aTV1
         t7/IL6kDBbMf9clnpPF6W/JzcnDkqFn1swXFA1EFoWhNFBpuNhjZa49iFsif/1kPfdr/
         KuexKbjXFBfmUFfDyMK//G8zzEQ5jYm9oJBAUmq+Hv64R4rPxWSH+tqqT+Sq4Iin+tTm
         I54YUYanB+wuYXDuwcrho9iVgI3bI4kvjQmmcHauHEszCXtetedaZG7Z5P7KHAxmd7/8
         7+bQ==
X-Gm-Message-State: AAQBX9cLfPbhU5RavoOKt+0TpA5Mh9LWDcexkKQK5K2C4vuuSRFEPXlQ
        tvMnUroRaG18ffY8YxyoABSg/9smSF4+ckdxS7c=
X-Google-Smtp-Source: AKy350Y+rCn5zqoN+WTxD60V46QnRZwyEdYAQKVW+mzCDUo57czmWZWxZ7+7dFLOCc0CSGnwYquwEoW3PvdRNrEhDmg=
X-Received: by 2002:a67:c391:0:b0:42e:3c54:742b with SMTP id
 s17-20020a67c391000000b0042e3c54742bmr9515946vsj.0.1681796029072; Mon, 17 Apr
 2023 22:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Apr 2023 08:33:38 +0300
Message-ID: <CAOQ4uxhpFrRVcviQ6bK1ZMtZDSMXRFuqY-d_+uQ1C0YMDtQpLA@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 4:40=E2=80=AFAM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> These patches extend FUSE to be able to act as a stacked filesystem. This
> allows pure passthrough, where the fuse file system simply reflects the l=
ower
> filesystem, and also allows optional pre and post filtering in BPF and/or=
 the
> userspace daemon as needed. This can dramatically reduce or even eliminat=
e
> transitions to and from userspace.
>
> In this patch set, I've reworked the bpf code to add a new struct_op type
> instead of a new program type, and used new kfuncs in place of new helper=
s.
> Additionally, it now uses dynptrs for variable sized buffers. The first t=
hree
> patches are repeats of a previous patch set which I have not yet adjusted=
 for
> comments. I plan to adjust those and submit them separately with fixes, b=
ut
> wanted to have the current fuse-bpf code visible before then.
>
> Patches 4-7 mostly rearrange existing code to remove noise from the main =
patch.
> Patch 8 contains the main sections of fuse-bpf
> Patches 9-25 implementing most FUSE functions as operations on a lower
> filesystem. From patch 25, you can run fuse as a passthrough filesystem.
> Patches 26-32 provide bpf functionality so that you can alter fuse parame=
ters
> via fuse_op programs.
> Patch 33 extends this to userspace, and patches 34-37 add some testing
> functionality.
>

That's a nice logical breakup for review.

I feel there is so much subtle code in those patches that the
only sane path forward is to review and merge them in phases.

Your patches adds this config:

+config FUSE_BPF
+       bool "Adds BPF to fuse"
+       depends on FUSE_FS
+       depends on BPF
+       help
+         Extends FUSE by adding BPF to prefilter calls and
potentially pass to a
+         backing file system

Since your patches add the PASSTHROUGH functionality before adding
BPF functionality, would it make sense to review and merge the PASSTHROUGH
functionality strictly before the BPF functionality?

Alternatively, you could aim to merge support for some PASSTHROUGH ops
then support for some BPF functionality and then slowly add ops to both.

Which brings me to my biggest concern.
I still do not see how these patches replace Allesio's
FUSE_DEV_IOC_PASSTHROUGH_OPEN patches.

Is the idea here that ioctl needs to be done at FUSE_LOOKUP
instead or in addition to the ioctl on FUSE_OPEN to setup the
read/write passthrough on the backing file?

I am missing things like the FILESYSTEM_MAX_STACK_DEPTH check that
was added as a result of review on Allesio's patches.

The reason I am concerned about this is that we are using the
FUSE_DEV_IOC_PASSTHROUGH_OPEN patches and I would like
to upstream their functionality sooner rather than later.
These patches have already been running in production for a while
I believe that they are running in Android as well and there is value
in upsteaming well tested patches.

The API does not need to stay FUSE_DEV_IOC_PASSTHROUGH_OPEN
it should be an API that is extendable to FUSE-BPF, but it would be
useful if the read/write passthrough could be the goal for first merge.

Does any of this make sense to you?
Can you draw a roadmap for merging FUSE-BPF that starts with
a first (hopefully short term) phase that adds the read/write passthrough
functionality?

I can help with review and testing of that part if needed.
I was planning to discuss this with you on LSFMM anyway,
but better start the discussion beforehand.

Thanks,
Amir.
