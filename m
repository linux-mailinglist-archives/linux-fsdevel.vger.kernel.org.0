Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D4708CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjESAU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 20:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjESAUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 20:20:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502C1735;
        Thu, 18 May 2023 17:20:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965c3f9af2aso408061266b.0;
        Thu, 18 May 2023 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455562; x=1687047562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15NgEsRt4MK6mum5so5P7HzPdsd56yyVRui3pGxEiNA=;
        b=guzCpG8ZJdKuzbyBW2mEhtyPAR0dXyGyYpNwBTgEfTH1s1VuxM/iErunlVtPtuVJK5
         fnz1kZqRWKe88fogas5DLDiQikXeQWH0Ll8AKaiufBn7gFJK5IeMCJpHWhK/s6CtFnkG
         ez5cbxz7fPBj586U59JCIIg9hFMVvq4eKphRhKxXGoFDPaustgVVSkr4il9dXuAYUu4p
         VaZjXxra00T9kW3qPPmkyHYGf+ubxF0ym/tp7+jEF734RvWX1qauJwdMcb1ewSAqsgKa
         m2OWLb5ojJ8FSBehdfGcwbaC499kbpZILHpR9dGC2S2Obu8xblpZpJqMK7XntPb3jbi+
         Zftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455562; x=1687047562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15NgEsRt4MK6mum5so5P7HzPdsd56yyVRui3pGxEiNA=;
        b=S6A4NB0OJh6i+nONE0jLxVEpPVQkT9qr73C1vJKlRt4PRht95WT7LB7nM/bNdX/lw1
         bgwbAUp3R1JcU5lr2mESAZgZpbUyOb3wU+nFAMk2fU0pbEseNf153neHt6E55GX/iex4
         qKIulGUpkil0SkpMLFNBXPWX/0GCDdGw8g+UatMserO1f7ToUQ3DbU+3FNkd99WpFDa4
         PiKiYr+EaoMp3WzVVrIvg6/37eKfseNyGAsxsl+PKW+1i8TBQFQ1E++N1H2UFs04lao7
         I7fnylpdVr3vKWcU/bM3Z/yyxntBkPWAGQl9RjlYjKEHmf+VUXpEUi5Kb9CmJ5wwTyE5
         0d0g==
X-Gm-Message-State: AC+VfDyhPYXPww38qwQGExAsBqNBNThkYzCuTnPs14o4WwI0OUImjM55
        IWllANIgcYPQwW3cr3V6hAAsHd7oE03YgoYZqhs=
X-Google-Smtp-Source: ACHHUZ7kX8k9jsMFtMGSDd132vZ+EE6FwmlEfTvQsstIibPBpf+7x2PAhti/f2HnyWTB+FLK/AWecivo2xz/NRNiXRs=
X-Received: by 2002:a17:907:6095:b0:96a:17f4:c9bb with SMTP id
 ht21-20020a170907609500b0096a17f4c9bbmr792866ejc.58.1684455561831; Thu, 18
 May 2023 17:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230518215444.1418789-2-andrii@kernel.org> <202305190724.nnh1ZV2F-lkp@intel.com>
In-Reply-To: <202305190724.nnh1ZV2F-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 May 2023 17:19:10 -0700
Message-ID: <CAEf4BzYW_OXeF=5L1XU5025-VbWN3M-wOSszXqMD6c5E9bEO9w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        oe-kbuild-all@lists.linux.dev, cyphar@cyphar.com,
        brauner@kernel.org, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
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

On Thu, May 18, 2023 at 4:59=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-support-O_PATH-FDs-in-BPF_OBJ_PIN-and-BPF_OBJ_GET-commands/20230519-06011=
0
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20230518215444.1418789-2-andrii%=
40kernel.org
> patch subject: [PATCH v2 bpf-next 1/3] bpf: support O_PATH FDs in BPF_OBJ=
_PIN and BPF_OBJ_GET commands
> config: m68k-allyesconfig
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/74f08e59c3fccac04=
b3c080831615209e11be4fb
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Andrii-Nakryiko/bpf-support-O_PA=
TH-FDs-in-BPF_OBJ_PIN-and-BPF_OBJ_GET-commands/20230519-060110
>         git checkout 74f08e59c3fccac04b3c080831615209e11be4fb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dm68k olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dm68k SHELL=3D/bin/bash kernel/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305190724.nnh1ZV2F-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/syscall.c: In function 'bpf_obj_get':
> >> kernel/bpf/syscall.c:2720:13: warning: variable 'path_fd' set but not =
used [-Wunused-but-set-variable]
>     2720 |         int path_fd;
>          |             ^~~~~~~
>
>
> vim +/path_fd +2720 kernel/bpf/syscall.c
>
>   2717
>   2718  static int bpf_obj_get(const union bpf_attr *attr)
>   2719  {
> > 2720          int path_fd;
>   2721
>   2722          if (CHECK_ATTR(BPF_OBJ) || attr->bpf_fd !=3D 0 ||
>   2723              attr->file_flags & ~(BPF_OBJ_FLAG_MASK | BPF_F_PATH_F=
D))
>   2724                  return -EINVAL;
>   2725
>   2726          /* path_fd has to be accompanied by BPF_F_PATH_FD flag */
>   2727          if (!(attr->file_flags & BPF_F_PATH_FD) && attr->path_fd)
>   2728                  return -EINVAL;
>   2729
>   2730          path_fd =3D attr->file_flags & BPF_F_PATH_FD ? attr->path=
_fd : AT_FDCWD;
>   2731          return bpf_obj_get_user(attr->path_fd, u64_to_user_ptr(at=
tr->pathname),

argh.... s/attr->path_fd/path_fd/ here, but it's curious how tests
didn't catch this because we always provide absolute path in
attr->pathname, and from openat() man page:

  If pathname is absolute, then dirfd is ignored.

So whatever garbage FD is passed in (in this case 0), the kernel won't
complain. Interesting. I'll send v3 with a fix.

>   2732                                  attr->file_flags);
>   2733  }
>   2734
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
