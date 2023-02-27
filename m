Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCFA6A3FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 12:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjB0LEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 06:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB0LEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:04:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF010AAE;
        Mon, 27 Feb 2023 03:03:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D4F760C4F;
        Mon, 27 Feb 2023 11:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A6BC433EF;
        Mon, 27 Feb 2023 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677495812;
        bh=B8ENTCm2cMAtZMsYjBsYW23x07Oeq64jzGJ+GDqai64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZApN8X90W7vkmn00LCbXe+O0yMbc6f87FV8PqFOKOn+lLlUw0DFIw/OWvCr2XaLEm
         qUrbLtHPNn/3TfW/n5av1uV30lT1PvuPduZUUA7lK5e8PJyUVyB7+dl2YKUzdWDuRy
         Cuk83bqgNjk3ZgnD0nz/K+D3gLfjRSx7lxIiG/0PQrf23YI4JeBVh4cxwj/KXSnmbb
         348PZBkAvty0xrR97JqUxImRUSybNJ+XYplbSgs9cmZIC9iZRzBJ0nad+xIemq8CGE
         +UiPfENimuT0WrG5HcavD9zsH9PWvYcsc+BSuKPoifh0kkpCgfOzIaTns+86AfQSNe
         rkQNsWUy1oYIw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1723ab0375eso7019640fac.1;
        Mon, 27 Feb 2023 03:03:32 -0800 (PST)
X-Gm-Message-State: AO0yUKWDGuu1sottofXxvsRS/Lwrrbus+o5Zrs7Spi0rRB0lvMKk9wTM
        C/Eqp/6W+jBOtY+Y/QmcGSrLyA+P1QiTiZV0jfU=
X-Google-Smtp-Source: AK7set8As6hVly455AsDnjscUhYx/f4EEiz+HGSt74USSBb9Jhimh+BCnYs3Ffu0z0Wn+jvB0bHHl8iK36wGj8KhB54=
X-Received: by 2002:a05:6870:b7ad:b0:16e:9d0:2211 with SMTP id
 ed45-20020a056870b7ad00b0016e09d02211mr3313374oab.11.1677495811579; Mon, 27
 Feb 2023 03:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 27 Feb 2023 11:02:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H63rvF3bXNgQAhcjdjbP2q5Wxo8MjcxcT7BeA9vjxAxwQ@mail.gmail.com>
Message-ID: <CAL3q7H63rvF3bXNgQAhcjdjbP2q5Wxo8MjcxcT7BeA9vjxAxwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Introducing `wq_cpu_set` mount option for btrfs
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 26, 2023 at 4:31=E2=80=AFPM Ammar Faizi <ammarfaizi2@gnuweeb.or=
g> wrote:
>
> Hi,
>
> This is an RFC patchset that introduces the `wq_cpu_set` mount option.
> This option lets the user specify a CPU set that the Btrfs workqueues
> will use.
>
> Btrfs workqueues can slow sensitive user tasks down because they can use
> any online CPU to perform heavy workloads on an SMP system. Add a mount
> option to isolate the Btrfs workqueues to a set of CPUs. It is helpful
> to avoid sensitive user tasks being preempted by Btrfs heavy workqueues.
>
> This option is similar to the taskset bitmask except that the comma
> separator is replaced with a dot. The reason for this is that the mount
> option parser uses commas to separate mount options.
>
> Figure (the CPU usage when `wq_cpu_set` is used VS when it is not):
> https://gist.githubusercontent.com/ammarfaizi2/a10f8073e58d1712c1ed49af83=
ae4ad1/raw/a4f7cbc4eb163db792a669d570ff542495e8c704/wq_cpu_set.png

I haven't read the patchset.

It's great that it reduces CPU usage.
But does it also provide other performance benefits, like lower
latency or higher throughput for some workloads? Or using less CPU
also affects negatively in those other aspects?

Thanks.

>
> A simple stress testing:
>
> 1. Open htop.
> 2. Open a new terminal.
> 3. Mount and perform a heavy workload on the mounted Btrfs filesystem.
>
> ## Test without wq_cpu_set
> sudo mount -t btrfs -o rw,compress-force=3Dzstd:15,commit=3D1500 /dev/sda=
2 hdd/a;
> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
> sync; # See the CPU usage in htop.
> sudo umount hdd/a;
>
> ## Test wq_cpu_set
> sudo mount -t btrfs -o rw,compress-force=3Dzstd:15,commit=3D1500,wq_cpu_s=
et=3D0.4.1.5 /dev/sda2 hdd/a;
> cp -rf /path/folder_with_many_large_files/ hdd/a/test;
> sync; # See the CPU usage in htop.
> sudo umount hdd/a;
>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>
> Ammar Faizi (6):
>   workqueue: Add set_workqueue_cpumask() helper function
>   btrfs: Change `mount_opt` type in `struct btrfs_fs_info` to `u64`
>   btrfs: Create btrfs CPU set struct and helpers
>   btrfs: Add wq_cpu_set=3D%s mount option
>   btrfs: Adjust the default thread pool size when `wq_cpu_set` option is =
used
>   btrfs: Add `BTRFS_DEFAULT_MAX_THREAD_POOL_SIZE` macro
>
>  fs/btrfs/async-thread.c   | 51 ++++++++++++++++++++
>  fs/btrfs/async-thread.h   |  3 ++
>  fs/btrfs/disk-io.c        |  6 ++-
>  fs/btrfs/fs.c             | 97 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/fs.h             | 12 ++++-
>  fs/btrfs/super.c          | 83 +++++++++++++++++++++++++++++++++
>  include/linux/workqueue.h |  3 ++
>  kernel/workqueue.c        | 19 ++++++++
>  8 files changed, 271 insertions(+), 3 deletions(-)
>
>
> base-commit: 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> --
> Ammar Faizi
>
