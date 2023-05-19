Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F23708DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 04:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjESCnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESCnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 22:43:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B6E4E;
        Thu, 18 May 2023 19:43:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f40c19477so206553766b.1;
        Thu, 18 May 2023 19:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684464193; x=1687056193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqoVCRBHAsCkh7/H8NehRsiMX5fMyD5zSUScfa5DQRE=;
        b=bLBbamHR8gyk2G3fXirgAdUSHO0UwDucN+gS+zXCxT1ifdERuPR2RVbR5FFgas+qgY
         Ucu3c5r6R8zr4BrKiAeiZ9QeSdLB7WGQ6abf2c8b9VV9mtOFkcL5DNzKyXBCt0w6pLWz
         g6il4YFFUdrXQOY0hTkRio7OVmNwQVCTxyQDgrYcBq/oPVDFGNu4FHQhSxbZ73H5JukX
         p2VbM207wN6GeO01wsO15x6TfVBLBWHFGelW4y4jdnNRCcR3sAqPAhhdf1FTGbqVuHfG
         RH1k8V0VwKQOfZsXTQFvWJBLYkaeA9oMCdn9QAhb0Eb+LA5psyuoEzni9k1b0hQp2F/S
         /FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684464193; x=1687056193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqoVCRBHAsCkh7/H8NehRsiMX5fMyD5zSUScfa5DQRE=;
        b=YsgtYXCP/YfvOGW7Wr8Byro/jpFwl2tU0PYsZ5qes8hIwWaksaXt9seVvpb9fBBCB3
         GbBjBoT07U0xWyjQ+JenRzqw5WNSGmGxIyKfkujLemCVrHU+6USB70b6vPbx0H0DwEcv
         SsPulVQ5B6bA97auFVHmKET/bkCf2IdAwz0MMbRM2RIdn6iVbt1I+jiMYcdOoz7/ar2a
         Ybrs147fEAhy+DCWWqjgv3tyyjQL2oRtYTi1REbaeS2xycMS1fF9SMz5FS0BLymQoCeo
         69za63WWpEQQzt8UZDCZtV/DJnB0kQ4Eu4iJO1wDI2iLHo3cRvjhDjRCS3zw9yn7hf9n
         h31Q==
X-Gm-Message-State: AC+VfDxnc2FSFuNmHXRpl5/DRnerK1oXqIJITXqnWsklYBkxUjslhzyx
        G9DCWM55KGhkYrOejtqJBYI/Cw8QRhOTAD+tYP80uScvBC8=
X-Google-Smtp-Source: ACHHUZ7z1o1C64DaoCO9ITXhrawbHTDPEMEebA5juOKf4HC5e+P7KmYihzYzfl+ercLyku7s6gGsyMQ7qCHBcwqGxWU=
X-Received: by 2002:a17:906:9c82:b0:96a:3e7:b592 with SMTP id
 fj2-20020a1709069c8200b0096a03e7b592mr194315ejc.25.1684464192922; Thu, 18 May
 2023 19:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230518215444.1418789-2-andrii@kernel.org> <202305190724.nnh1ZV2F-lkp@intel.com>
 <CAEf4BzYW_OXeF=5L1XU5025-VbWN3M-wOSszXqMD6c5E9bEO9w@mail.gmail.com> <CAADnVQJL3ZAxXrR6nkk=pYbuVS8NhGX19UJpsvSrH4VbPAayhg@mail.gmail.com>
In-Reply-To: <CAADnVQJL3ZAxXrR6nkk=pYbuVS8NhGX19UJpsvSrH4VbPAayhg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 May 2023 19:42:59 -0700
Message-ID: <CAEf4BzZ0bsG4JcecNupSc5Srzg9CO4mfX2W6q8XUfGwebdBk3g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, May 18, 2023 at 5:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 18, 2023 at 5:19=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 18, 2023 at 4:59=E2=80=AFPM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Andrii,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on bpf-next/master]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryik=
o/bpf-support-O_PATH-FDs-in-BPF_OBJ_PIN-and-BPF_OBJ_GET-commands/20230519-0=
60110
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.=
git master
> > > patch link:    https://lore.kernel.org/r/20230518215444.1418789-2-and=
rii%40kernel.org
> > > patch subject: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF=
_OBJ_PIN and BPF_OBJ_GET commands
> > > config: m68k-allyesconfig
> > > compiler: m68k-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=3D1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/intel-lab-lkp/linux/commit/74f08e59c3fcc=
ac04b3c080831615209e11be4fb
> > >         git remote add linux-review https://github.com/intel-lab-lkp/=
linux
> > >         git fetch --no-tags linux-review Andrii-Nakryiko/bpf-support-=
O_PATH-FDs-in-BPF_OBJ_PIN-and-BPF_OBJ_GET-commands/20230519-060110
> > >         git checkout 74f08e59c3fccac04b3c080831615209e11be4fb
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make=
.cross W=3D1 O=3Dbuild_dir ARCH=3Dm68k olddefconfig
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make=
.cross W=3D1 O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash kernel/
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202305190724.nnh1ZV2F=
-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    kernel/bpf/syscall.c: In function 'bpf_obj_get':
> > > >> kernel/bpf/syscall.c:2720:13: warning: variable 'path_fd' set but =
not used [-Wunused-but-set-variable]
> > >     2720 |         int path_fd;
> > >          |             ^~~~~~~
> > >
> > >
> > > vim +/path_fd +2720 kernel/bpf/syscall.c
> > >
> > >   2717
> > >   2718  static int bpf_obj_get(const union bpf_attr *attr)
> > >   2719  {
> > > > 2720          int path_fd;
> > >   2721
> > >   2722          if (CHECK_ATTR(BPF_OBJ) || attr->bpf_fd !=3D 0 ||
> > >   2723              attr->file_flags & ~(BPF_OBJ_FLAG_MASK | BPF_F_PA=
TH_FD))
> > >   2724                  return -EINVAL;
> > >   2725
> > >   2726          /* path_fd has to be accompanied by BPF_F_PATH_FD fla=
g */
> > >   2727          if (!(attr->file_flags & BPF_F_PATH_FD) && attr->path=
_fd)
> > >   2728                  return -EINVAL;
> > >   2729
> > >   2730          path_fd =3D attr->file_flags & BPF_F_PATH_FD ? attr->=
path_fd : AT_FDCWD;
> > >   2731          return bpf_obj_get_user(attr->path_fd, u64_to_user_pt=
r(attr->pathname),
> >
> > argh.... s/attr->path_fd/path_fd/ here, but it's curious how tests
> > didn't catch this because we always provide absolute path in
> > attr->pathname, and from openat() man page:
> >
> >   If pathname is absolute, then dirfd is ignored.
> >
> > So whatever garbage FD is passed in (in this case 0), the kernel won't
> > complain. Interesting. I'll send v3 with a fix.
>
> because other tests have an absolute path to bpf objs?

right, I think we always test with absolute path. I'll add more tests
around pinning to catch something like this in the future.
