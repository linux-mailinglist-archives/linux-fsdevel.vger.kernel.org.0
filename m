Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E814690B82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 15:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBIOSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 09:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjBIOSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:18:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A82E823;
        Thu,  9 Feb 2023 06:18:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1646194wms.1;
        Thu, 09 Feb 2023 06:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6rfU3Snjl72LWDE6qX15Ocps4cU89fmRgYsFNMufWk=;
        b=ptrgdRIUbWXZm/c9lvzocxPMYQ+eryxsewr3pbMPofs6WTJXzB1Ds06zzWNlpBFdfE
         y52VbKkz22dnSCkSuVB6Kqy3Bn0EYvx/voJ6fcGkXc58mN+umM38sBmb1NfC6eTgR5/g
         Qf4APaaY5Q4j3X5wFir1KJ4coiw/6UX1yJdqYkpE8FxOrw5mgdwYIa0ulh3uF+ZoVJ+5
         ZQwXYAh9ubL1aXAeRfScDXJx+1YpSXNUVuWCwt2sfQeC6U5GThIdQyWV3OUK6IRbji9x
         ErxpRJynYb6LskLmbQBbz9a93hHFi7tmhPeCzwsN8HHYsmcdIEvrpMGPKtABOHieEgSX
         jkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6rfU3Snjl72LWDE6qX15Ocps4cU89fmRgYsFNMufWk=;
        b=yf4AAuEn8AoNkJoA6DsVt3yXwDWzQK3iCZDwMlc7gHDCX9GcuULMjmd3AxIBKXW8BK
         h1svAFYUUJYhBMAnxNQmxRcmHSfTjcOOHPyoLNiYY1QhYL2MnEu7XKlKY003l7jEvM4p
         MXfixi7HJ0DC34xn4pQD7dhwCc9avFi2Mz4lnFRE9MsrcxOtWpjtTBjBE9L2wT43dXpw
         4QW+w5E3y80VQYRSmjMUZ5Owhh30HJB7h3dOnAOLC2CdshfM3e4FUwe6mrMzvyEjE+4o
         H6JpwtIIMgL0+9JXF4y0Tj5e1BwDbAtXnZdocjYIezWnY+1kixuAXvxvAOrxjEZn+cES
         uVFA==
X-Gm-Message-State: AO0yUKUnc93qe0TOUt+PEoNyjQnSqeod7S98TQky8gsmOvIokxbLbfB/
        LrjLNSPjZglkwmz6T5ouUBY=
X-Google-Smtp-Source: AK7set/oU2MQE6PRrUGZeem/G28nDvWH2jZGBGq/aX3yec9+KFq5SeSvdk3RbW/QsABFEFJLifd0VA==
X-Received: by 2002:a05:600c:4d21:b0:3de:e447:8025 with SMTP id u33-20020a05600c4d2100b003dee4478025mr9943371wmp.21.1675952309295;
        Thu, 09 Feb 2023 06:18:29 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b003dc4aae4739sm5886452wms.27.2023.02.09.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:18:28 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 15:18:26 +0100
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
Message-ID: <Y+UAsr8A+xT0bUY/@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:57:32PM +0100, Jiri Olsa wrote:
> hi,
> we have a use cases for bpf programs to use binary file's build id.
> 
> After some attempts to add helpers/kfuncs [1] [2] Andrii had an idea [3]
> to store build id directly in the file object. That would solve our use
> case and might be beneficial for other profiling/tracing use cases with
> bpf programs.
> 
> This RFC patchset adds new config CONFIG_FILE_BUILD_ID option, which adds
> build id object pointer to the file object when enabled. The build id is
> read/populated when the file is mmap-ed.
> 
> I also added bpf and perf changes that would benefit from this.
> 
> I'm not sure what's the policy on adding stuff to file object, so apologies
> if that's out of line. I'm open to any feedback or suggestions if there's
> better place or way to do this.

hi,
Matthew suggested on irc to consider inode for storing build id

I tried that and it seems to have better stats wrt allocated build
id objects, because inode is being shared among file objects

I took /proc/slabinfo output after running bpf tests

- build id stored in file:

  # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
  build_id             668    775    160   25    1 : tunables    0    0    0 : slabdata     31     31      0

- build id stored in inode:

  # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
  build_id             222    225    160   25    1 : tunables    0    0    0 : slabdata      9      9      0


I'm stranger to inode/fs/mm code so I'll spend some time checking on
what I possibly broke in there before I send it, but I'd appreciate
any early feedback ;-)

the code is in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  inode_build_id

I'll send another version with inode if there's no objection

thanks,
jirka


> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/20221108222027.3409437-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/20221128132915.141211-1-jolsa@kernel.org/
> [3] https://lore.kernel.org/bpf/CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com/
> ---
> Jiri Olsa (5):
>       mm: Store build id in file object
>       bpf: Use file object build id in stackmap
>       perf: Use file object build id in perf_event_mmap_event
>       selftests/bpf: Add file_build_id test
>       selftests/bpf: Add iter_task_vma_buildid test
> 
>  fs/file_table.c                                               |  3 +++
>  include/linux/buildid.h                                       | 17 +++++++++++++++++
>  include/linux/fs.h                                            |  3 +++
>  kernel/bpf/stackmap.c                                         |  8 ++++++++
>  kernel/events/core.c                                          | 43 +++++++++++++++++++++++++++++++++++++++----
>  lib/buildid.c                                                 | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  mm/Kconfig                                                    |  7 +++++++
>  mm/mmap.c                                                     | 15 +++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c             | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/file_build_id.c        | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/file_build_id.c             | 34 ++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.c                   | 35 +++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h                   |  1 +
>  14 files changed, 413 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
>  create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c
