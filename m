Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E10708D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjESAyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 20:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjESAyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 20:54:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A5199F;
        Thu, 18 May 2023 17:54:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso3090689e87.3;
        Thu, 18 May 2023 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684457627; x=1687049627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sivbYrV1bwadAn0fltPP6rK4i4zR+Og2lN0Gw2Oc6Vo=;
        b=fV+U0lRFgOUrBk2S15+f6+JYfPBvpTkpMx8KtdzflaHNzL2S2y9Eli5t8RLxJu6Ide
         6ySt/2IknEJMCbGc0fZ/gUFSrMgJNGlnFgcBNq0eOaYloOYj5bh0m+J5miz0romABUM1
         fU72IZRjd7GBaD8J12mIiEYI5Lxsd6uZvErlWwjlga2C94GyF4E/T93K8v1DCFx312ii
         7/NG22ru5of/LDh4OJiwer85D5JHYS7DIyYmS65A+NVAAzjw3UvQ/E7eA2m7lvqAkigX
         t0CbXhKVxQc7y0CS9odK9PwBo5KOuGcBs62BjbhuED3oZl+W/HO54IOTiDxpWX+ZgDsL
         qpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684457627; x=1687049627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sivbYrV1bwadAn0fltPP6rK4i4zR+Og2lN0Gw2Oc6Vo=;
        b=c05h/BMdhFuKr3OdcEE5yLyWane0Pi/v/5/kqaE6yCwlvksTW2pDIJBtZpZJhImVYv
         CPKSgkmYA1aj0kyGGxA5ZIeaJhcdSFt0fNBKl7lXiQBEbfT4kIrwAHxVW1z7gHwlJNyc
         rdk/uMji/BYmCgrola87fBEQO84PNNBtQiXA8/2fBVkh9V+4MUcMlzXY2uoUEAv/1M9h
         YZzgr1Aoztfh1TjIDD57jSipZfWn+QQbqMzub/dDXMg4v54lcIbs0D/Fj/es6m2eLBGs
         Rh1J7gME9QDX5vfAg7/VgSA6bIEGTxiWi4zn9qyDmKoY24/usIS7BrpkIJ9NAhn9hOpE
         Pslw==
X-Gm-Message-State: AC+VfDzomJM16O48WRYg1nJ/7WipioRS5vDJaZ9y9MfREU3kBPoJykaM
        QHPxMATyjlr96y7oNL/cCE65NzuMM+5FcPMRYzI=
X-Google-Smtp-Source: ACHHUZ69uBBZgn6f6vUX8sQygzgcHzJYsGHym+7MIAzeaKrUWk1qJvA5wNnrk3YM1RC+LLKe8LJ88BQl+X8zF0LsGsQ=
X-Received: by 2002:ac2:5939:0:b0:4f3:8823:ebe9 with SMTP id
 v25-20020ac25939000000b004f38823ebe9mr245681lfi.22.1684457627157; Thu, 18 May
 2023 17:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230518215444.1418789-2-andrii@kernel.org> <202305190724.nnh1ZV2F-lkp@intel.com>
 <CAEf4BzYW_OXeF=5L1XU5025-VbWN3M-wOSszXqMD6c5E9bEO9w@mail.gmail.com>
In-Reply-To: <CAEf4BzYW_OXeF=5L1XU5025-VbWN3M-wOSszXqMD6c5E9bEO9w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 May 2023 17:53:35 -0700
Message-ID: <CAADnVQJL3ZAxXrR6nkk=pYbuVS8NhGX19UJpsvSrH4VbPAayhg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        oe-kbuild-all@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 5:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 18, 2023 at 4:59=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Andrii,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on bpf-next/master]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/=
bpf-support-O_PATH-FDs-in-BPF_OBJ_PIN-and-BPF_OBJ_GET-commands/20230519-060=
110
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.gi=
t master
> > patch link:    https://lore.kernel.org/r/20230518215444.1418789-2-andri=
i%40kernel.org
> > patch subject: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_O=
BJ_PIN and BPF_OBJ_GET commands
> > config: m68k-allyesconfig
> > compiler: m68k-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/74f08e59c3fccac=
04b3c080831615209e11be4fb
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review Andrii-Nakryiko/bpf-support-O_=
PATH-FDs-in-BPF_OBJ_PIN-and-BPF_OBJ_GET-commands/20230519-060110
> >         git checkout 74f08e59c3fccac04b3c080831615209e11be4fb
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dm68k olddefconfig
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.c=
ross W=3D1 O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash kernel/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202305190724.nnh1ZV2F-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    kernel/bpf/syscall.c: In function 'bpf_obj_get':
> > >> kernel/bpf/syscall.c:2720:13: warning: variable 'path_fd' set but no=
t used [-Wunused-but-set-variable]
> >     2720 |         int path_fd;
> >          |             ^~~~~~~
> >
> >
> > vim +/path_fd +2720 kernel/bpf/syscall.c
> >
> >   2717
> >   2718  static int bpf_obj_get(const union bpf_attr *attr)
> >   2719  {
> > > 2720          int path_fd;
> >   2721
> >   2722          if (CHECK_ATTR(BPF_OBJ) || attr->bpf_fd !=3D 0 ||
> >   2723              attr->file_flags & ~(BPF_OBJ_FLAG_MASK | BPF_F_PATH=
_FD))
> >   2724                  return -EINVAL;
> >   2725
> >   2726          /* path_fd has to be accompanied by BPF_F_PATH_FD flag =
*/
> >   2727          if (!(attr->file_flags & BPF_F_PATH_FD) && attr->path_f=
d)
> >   2728                  return -EINVAL;
> >   2729
> >   2730          path_fd =3D attr->file_flags & BPF_F_PATH_FD ? attr->pa=
th_fd : AT_FDCWD;
> >   2731          return bpf_obj_get_user(attr->path_fd, u64_to_user_ptr(=
attr->pathname),
>
> argh.... s/attr->path_fd/path_fd/ here, but it's curious how tests
> didn't catch this because we always provide absolute path in
> attr->pathname, and from openat() man page:
>
>   If pathname is absolute, then dirfd is ignored.
>
> So whatever garbage FD is passed in (in this case 0), the kernel won't
> complain. Interesting. I'll send v3 with a fix.

because other tests have an absolute path to bpf objs?
