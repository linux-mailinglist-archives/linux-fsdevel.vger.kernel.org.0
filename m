Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2977C8DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjHOHuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjHOHtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:49:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED211A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:49:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f13c41c957so1561117e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1692085789; x=1692690589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXOEvzRF8ADpNQSaByqRT4RWjoHlgIorYKOCNB0xrSo=;
        b=ctI2X5htkoAwJxA2kfQY81apo4f+wOZMRTR4YSRI2MhUTPTrl1aaQxfvGnkOK021Xh
         N2b6oekgxREzZSBd26EtP2sXHYTmO4B9wM/i9SlqSuK8I2WTsnM40oatmwc5vZcC6UsX
         dxeGlWj27TUrD/saPJfipYs6jTOAXOCVPpCS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085789; x=1692690589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXOEvzRF8ADpNQSaByqRT4RWjoHlgIorYKOCNB0xrSo=;
        b=iRXxfIXcyxfLi1OJeqwzjKezsL6I1h4grX9ok7kWmiof17H2vACinQI2OTVz+srhkk
         Le1h1QnD0U42eeJauWBEtohYsfd/KQyoazcMbiBwws2U6MXKV7ShoG7QblUnKmvaMHuL
         e3nO7YAccvleftD09H7ldFOIbk2VGzzUHWnA5Yylr3usmNCEQPk0L7VmIrCKu2bLfKCa
         q3okuobAKj3qCKeiekSQrptPQ5NSJEupVZOqKfLCXsJx1rdaa/BL/3Jpf7UTfGhMbS9Q
         xoDiHdpU2ssJQb9jNg5zKBhvGmo03mEEnxegUCA4vgWhzEjpBDhoev5q/B/Uur8WK5cm
         ZeDA==
X-Gm-Message-State: AOJu0YyjIFi525RjcMSpruGLKntF+5Q3qXhxmzuw7fBlyAiBf8L/l4Xe
        szxSotEzl71sIG8AmGcCfcTD21AI7EXj6loTKVGd4A==
X-Google-Smtp-Source: AGHT+IGn1Ixr5bTVNGHlW/hSLsuoMvWjfq1mrKGq4Ekrskbsvt5z7tXbeqR2zu4QGtGdbLbRF6sbB0NZkd2uhSdrjUM=
X-Received: by 2002:a05:6512:49a:b0:4fd:d0f7:5b90 with SMTP id
 v26-20020a056512049a00b004fdd0f75b90mr5999537lfq.4.1692085788398; Tue, 15 Aug
 2023 00:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-devcg_guard-v1-4-654971ab88b1@aisec.fraunhofer.de> <202308151506.6be3b169-oliver.sang@intel.com>
In-Reply-To: <202308151506.6be3b169-oliver.sang@intel.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Tue, 15 Aug 2023 09:49:37 +0200
Message-ID: <CAJqdLrrZAXn8hwReSFtP7x+G_ge-eOrx8A5gUvOZojQdwk4frw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] fs: allow mknod in non-initial userns using
 cgroup device guard
To:     kernel test robot <oliver.sang@intel.com>
Cc:     =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, gyroidos@aisec.fraunhofer.de,
        stgraber@ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 9:18=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
>
> commit: bffc333633f1e681c01ada11bd695aa220518bd8 ("[PATCH RFC 4/4] fs: al=
low mknod in non-initial userns using cgroup device guard")
> url: https://github.com/intel-lab-lkp/linux/commits/Michael-Wei/bpf-add-c=
group-device-guard-to-flag-a-cgroup-device-prog/20230814-224110
> patch link: https://lore.kernel.org/all/20230814-devcg_guard-v1-4-654971a=
b88b1@aisec.fraunhofer.de/
> patch subject: [PATCH RFC 4/4] fs: allow mknod in non-initial userns usin=
g cgroup device guard
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308151506.6be3b169-oliver.san=
g@intel.com
>
>
>
> [   14.468719][  T139]
> [   14.468999][  T139] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   14.469545][  T139] WARNING: suspicious RCU usage
> [   14.469968][  T139] 6.5.0-rc6-00004-gbffc333633f1 #1 Not tainted
> [   14.470520][  T139] -----------------------------
> [   14.470940][  T139] include/linux/cgroup.h:423 suspicious rcu_derefere=
nce_check() usage!

Most likely it's because in "cgroup_bpf_device_guard_enabled" function:

struct cgroup *cgrp =3D task_dfl_cgroup(task);

should be under rcu_read_lock (or cgroup_mutex). If we get rid of
cgroup_mutex and make cgroup_bpf_device_guard_enabled
function specific to "current" task we will solve this issue too.

> [   14.471703][  T139]
> [   14.471703][  T139] other info that might help us debug this:
> [   14.471703][  T139]
> [   14.472692][  T139]
> [   14.472692][  T139] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   14.473469][  T139] no locks held by (journald)/139.
> [   14.473935][  T139]
> [   14.473935][  T139] stack backtrace:
> [   14.474454][  T139] CPU: 1 PID: 139 Comm: (journald) Not tainted 6.5.0=
-rc6-00004-gbffc333633f1 #1
> [   14.475296][  T139] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   14.476298][  T139] Call Trace:
> [   14.476608][  T139]  dump_stack_lvl+0x78/0x8c
> [   14.477055][  T139]  dump_stack+0x12/0x18
> [   14.477420][  T139]  lockdep_rcu_suspicious+0x153/0x1a4
> [   14.477928][  T139]  cgroup_bpf_device_guard_enabled+0x14f/0x168
> [   14.478476][  T139]  devcgroup_task_is_guarded+0x10/0x20
> [   14.478973][  T139]  may_open_dev+0x11/0x44
> [   14.479367][  T139]  may_open+0x115/0x13c
> [   14.479727][  T139]  do_open+0xa1/0x378
> [   14.480113][  T139]  path_openat+0xdc/0x1bc
> [   14.480512][  T139]  do_filp_open+0x91/0x124
> [   14.480911][  T139]  ? lock_release+0x62/0x118
> [   14.481329][  T139]  ? _raw_spin_unlock+0x18/0x34
> [   14.481797][  T139]  ? alloc_fd+0x112/0x1c4
> [   14.482183][  T139]  do_sys_openat2+0x7a/0xa0
> [   14.482592][  T139]  __ia32_sys_openat+0x66/0x9c
> [   14.483065][  T139]  do_int80_syscall_32+0x27/0x48
> [   14.483502][  T139]  entry_INT80_32+0x10d/0x10d
> [   14.483962][  T139] EIP: 0xa7f39092
> [   14.484267][  T139] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68=
 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00=
 cd 80 <c3> 8d b4
>  26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
> [   14.485995][  T139] EAX: ffffffda EBX: ffffff9c ECX: 005df542 EDX: 000=
08100
> [   14.486622][  T139] ESI: 00000000 EDI: 00000000 EBP: affeb888 ESP: aff=
eb6ec
> [   14.487225][  T139] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAG=
S: 00200246
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230815/202308151506.6be3b169-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
