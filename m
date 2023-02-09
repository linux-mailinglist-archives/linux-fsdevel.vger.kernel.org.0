Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F93691175
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 20:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBITi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 14:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBITi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:38:26 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52F457E6;
        Thu,  9 Feb 2023 11:38:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y2so1102202iot.4;
        Thu, 09 Feb 2023 11:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jdh4VULJ6F+h4MAiYTsb2LTjagqLadibqRKQMHpvOE=;
        b=eZBK7bsG54sHx0p7PAQy2iX/zWTjNGA/Qd2/ZdxdVyvp0yXbv8yOGGG3EWPo99DRtz
         D41JPGxHrKpnMA2ZENevlEV6JriYGPcTumXjSnsCJZwn5IrH5m3MDKobvNnUu2QaxaNv
         +WiUlme18JXjpbjqrOg7uTaDWpVBzldrKQFEOrgFo/ISWjXyFrg8oofCUNE5uxKa4fQa
         qqPF0R2NmRh4nBz+9U9FaEP7AHFZCLVSA96LHlfeeqzN265jRXHEQ9O8YMYBZcK9PUrQ
         esy+bkwI35pyARvJmzRbZzKGOtkGzjGwSFU7dXqiDzoO47SEOS2+of7u8fQwhZszP01/
         yFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Jdh4VULJ6F+h4MAiYTsb2LTjagqLadibqRKQMHpvOE=;
        b=Svdjr43RbYt5Jx0V4oC/1rRJVds3RQ2vK8eAaClS5JELVPoFPvrODxkEpi34s4Qhua
         UTAN+Hc3dxki0miSH6a3v0Ys7cp2tbTYAa/AQj50XGwQDqP/Bb+QQOb2wbiqEURbc2aD
         uHl+5NMRLUWdQIMhn74QIaS2gbX6ZRCaHYNmXoNahRXKogoHlj1XW7zn+/pJH//Pfwm/
         E6fgKopLJ33x3CroIspNXANkc5elwrhLNcCqs/uYF30C7tLgC5rtwrF03eX1hrOTouEo
         BGyAqOg3j5ezp3llTE+TY1N4KxfHub2EicRuD1aZDu0/MAiT2ktaCcEB0Bkmw/9kiqyA
         lGkA==
X-Gm-Message-State: AO0yUKV6g7DJlh1MVTl2SKW9rO9kbwtGPDzGCwA12GdA3WafOkQbgPZ2
        Iv3A8xPde789SDpUS8+59DyV/V7K2JCphaKp19E=
X-Google-Smtp-Source: AK7set/SRwK2j1K6/X1ct4MebC7m2uZKEvZh2iPzd2xeOuLUL++LqTwMGYRVKWqAXTayJdIPTpmag/h5t3V8QGEoDGA=
X-Received: by 2002:a02:b80a:0:b0:3b0:5216:258a with SMTP id
 o10-20020a02b80a000000b003b05216258amr7282175jam.23.1675971505154; Thu, 09
 Feb 2023 11:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <Y+UAsr8A+xT0bUY/@krava>
In-Reply-To: <Y+UAsr8A+xT0bUY/@krava>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 9 Feb 2023 11:38:13 -0800
Message-ID: <CAM9d7cgrwyzrnDkkU2sAExonKbjSrs=p7Qyr=cww2zg4DTDBFw@mail.gmail.com>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
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

Hi Jiri,

On Thu, Feb 9, 2023 at 6:25 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Feb 01, 2023 at 02:57:32PM +0100, Jiri Olsa wrote:
> > hi,
> > we have a use cases for bpf programs to use binary file's build id.
> >
> > After some attempts to add helpers/kfuncs [1] [2] Andrii had an idea [3]
> > to store build id directly in the file object. That would solve our use
> > case and might be beneficial for other profiling/tracing use cases with
> > bpf programs.
> >
> > This RFC patchset adds new config CONFIG_FILE_BUILD_ID option, which adds
> > build id object pointer to the file object when enabled. The build id is
> > read/populated when the file is mmap-ed.
> >
> > I also added bpf and perf changes that would benefit from this.

Thanks for working on this!

> >
> > I'm not sure what's the policy on adding stuff to file object, so apologies
> > if that's out of line. I'm open to any feedback or suggestions if there's
> > better place or way to do this.
>
> hi,
> Matthew suggested on irc to consider inode for storing build id

Yeah, that's my idea too.

>
> I tried that and it seems to have better stats wrt allocated build
> id objects, because inode is being shared among file objects
>
> I took /proc/slabinfo output after running bpf tests
>
> - build id stored in file:
>
>   # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
>   build_id             668    775    160   25    1 : tunables    0    0    0 : slabdata     31     31      0
>
> - build id stored in inode:
>
>   # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
>   build_id             222    225    160   25    1 : tunables    0    0    0 : slabdata      9      9      0

Cool!

>
>
> I'm stranger to inode/fs/mm code so I'll spend some time checking on
> what I possibly broke in there before I send it, but I'd appreciate
> any early feedback ;-)
>
> the code is in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   inode_build_id
>
> I'll send another version with inode if there's no objection

I'll take a look.

Thanks,
Namhyung


> >
> > [1] https://lore.kernel.org/bpf/20221108222027.3409437-1-jolsa@kernel.org/
> > [2] https://lore.kernel.org/bpf/20221128132915.141211-1-jolsa@kernel.org/
> > [3] https://lore.kernel.org/bpf/CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com/
> > ---
> > Jiri Olsa (5):
> >       mm: Store build id in file object
> >       bpf: Use file object build id in stackmap
> >       perf: Use file object build id in perf_event_mmap_event
> >       selftests/bpf: Add file_build_id test
> >       selftests/bpf: Add iter_task_vma_buildid test
> >
> >  fs/file_table.c                                               |  3 +++
> >  include/linux/buildid.h                                       | 17 +++++++++++++++++
> >  include/linux/fs.h                                            |  3 +++
> >  kernel/bpf/stackmap.c                                         |  8 ++++++++
> >  kernel/events/core.c                                          | 43 +++++++++++++++++++++++++++++++++++++++----
> >  lib/buildid.c                                                 | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  mm/Kconfig                                                    |  7 +++++++
> >  mm/mmap.c                                                     | 15 +++++++++++++++
> >  tools/testing/selftests/bpf/prog_tests/bpf_iter.c             | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/prog_tests/file_build_id.c        | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/file_build_id.c             | 34 ++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.c                   | 35 +++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h                   |  1 +
> >  14 files changed, 413 insertions(+), 4 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c
