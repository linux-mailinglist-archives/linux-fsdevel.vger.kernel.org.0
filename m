Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846E68FBC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 01:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBIAB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 19:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBIAB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:01:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E77977B;
        Wed,  8 Feb 2023 16:01:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dr8so1633349ejc.12;
        Wed, 08 Feb 2023 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lnRMEps90VBoUvPiX08maYejjp0JR+MirybtrLIIsis=;
        b=T5vXmkSASESMqX2UeOtjZS2ssxJ4Lud3Ev/pHOB37KxdU7nqMTlccFCoXl5/kuvuJG
         iDkpBA5yWQbQCdpLjaxzzH1NeGAWyt40CVZ7om44kcl3jk0hFcsfGaGTi5uE3gSjTLaR
         1FlxNpFlQtTzb37W0EfKYl/NscEUSGyKaji1FuDB1O7PttswoWwqKC3hJyQaU1bFbXF7
         sgmBCTVfnS3DrW3FdjpXt84YaVliQ1HyppdlPiSFlYVCEA0uONRx1uh2hA4JpxshUMJu
         q36pYfg3TadiS38JRI3rjpDwWEBv0Q3wn8c62VgYx5nx8B0ygpD2K4eUlRcmv5hEKsPK
         b7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnRMEps90VBoUvPiX08maYejjp0JR+MirybtrLIIsis=;
        b=GAUmw7Fr9lF8z/SoJUUFhspIj4+Fkp0npkHBqPreWC0Y9jZipAr46wPkkKznzFuorz
         eGMdQilWPT8mcdLGjsRMqPW9yuGva7v1L2rgY76YJw9ogPfcFaTrYbHKPOzWS3V21RQW
         Jq44gu5NPEGftpeU52lbJz8Sto7TSRdYT88cHDOQnZbWb8tzBqkmbbsb0FGNLrlt4pcd
         l+ht/NY8u4NXr8E7ZZGvdMQv1YsYYGJVn1t+3VLx57AHoyBP1Y3wYD1It0srNgVDWhzo
         WrN5OQiE7Cd28l89G5U98kg2aGCIvN+8vAiPQM44KC0l6z1WBZexMLnEMY+la95ybva7
         f+jQ==
X-Gm-Message-State: AO0yUKX7Lr8JsBTF/g9ra7KGy9IQKXOO/wa2Lyp2nIbnPZmEhzSwiDXo
        +CmdCzPJOtLzzBeVbFZi2mkgr6PmyNbDZtn4vqQ=
X-Google-Smtp-Source: AK7set9eTP3Th07NxSDOa0p2NHCLdt7oO6rrdgVRBu4RBAY5MQEs4rGjBczC0SNe48hctP7Rz+XK23kCSuAIK9BlgnA=
X-Received: by 2002:a17:906:4c43:b0:8ab:3d5a:bb3b with SMTP id
 d3-20020a1709064c4300b008ab3d5abb3bmr101265ejw.2.1675900915310; Wed, 08 Feb
 2023 16:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <20230201135737.800527-6-jolsa@kernel.org>
In-Reply-To: <20230201135737.800527-6-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 16:01:42 -0800
Message-ID: <CAEf4BzYGQGdydeVbZf5YTnDTvGduA_wbeQ=t5nSc6Wi=S17+=A@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] selftests/bpf: Add iter_task_vma_buildid test
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
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

On Wed, Feb 1, 2023 at 5:58 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Testing iterator access to build id in vma->vm_file object
> by storing each binary with buildid into map and checking
> it against buildid retrieved in user space.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 88 +++++++++++++++++++
>  .../bpf/progs/bpf_iter_task_vma_buildid.c     | 49 +++++++++++
>  2 files changed, 137 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 3af6450763e9..fd3217b68c2e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -33,6 +33,7 @@
>  #include "bpf_iter_bpf_link.skel.h"
>  #include "bpf_iter_ksym.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
> +#include "bpf_iter_task_vma_buildid.skel.h"
>
>  static int duration;
>
> @@ -1536,6 +1537,91 @@ static void test_task_vma_dead_task(void)
>         bpf_iter_task_vma__destroy(skel);
>  }
>
> +#define D_PATH_BUF_SIZE                1024
> +#define BUILD_ID_SIZE_MAX      20
> +
> +struct build_id {
> +       u32 sz;
> +       char data[BUILD_ID_SIZE_MAX];
> +};
> +
> +#define BUILDID_STR_SIZE (BPF_BUILD_ID_SIZE*2 + 1)
> +
> +static void test_task_vma_buildid(void)
> +{
> +       int err, iter_fd = -1, proc_maps_fd = -1;
> +       struct bpf_iter_task_vma_buildid *skel;
> +       char key[D_PATH_BUF_SIZE], *prev_key;
> +       char bpf_build_id[BUILDID_STR_SIZE];
> +       int len, files_fd, i, cnt = 0;
> +       struct build_id val;
> +       char *build_id;
> +       char c;
> +
> +       skel = bpf_iter_task_vma_buildid__open();
> +       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma_buildid__open"))
> +               return;
> +
> +       err = bpf_iter_task_vma_buildid__load(skel);
> +       if (!ASSERT_OK(err, "bpf_iter_task_vma_buildid__load"))
> +               goto out;

minor: you can do __open_and_load() in one step

> +
> +       skel->links.proc_maps = bpf_program__attach_iter(
> +               skel->progs.proc_maps, NULL);
> +
> +       if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) {
> +               skel->links.proc_maps = NULL;
> +               goto out;
> +       }
> +
> +       iter_fd = bpf_iter_create(bpf_link__fd(skel->links.proc_maps));
> +       if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> +               goto out;
> +
> +       /* trigger the iterator, there's no output, just map */
> +       len = read(iter_fd, &c, 1);
> +       ASSERT_EQ(len, 0, "len_check");
> +
> +       files_fd = bpf_map__fd(skel->maps.files);
> +
> +       prev_key = NULL;
> +
> +       while (true) {
> +               err = bpf_map_get_next_key(files_fd, prev_key, &key);
> +               if (err) {
> +                       if (errno == ENOENT)
> +                               err = 0;
> +                       break;
> +               }
> +               if (bpf_map_lookup_elem(files_fd, key, &val))
> +                       break;
> +               if (!ASSERT_LE(val.sz, BUILD_ID_SIZE_MAX, "buildid_size"))
> +                       break;
> +
> +               memset(bpf_build_id, 0x0, sizeof(bpf_build_id));
> +               for (i = 0; i < val.sz; i++) {
> +                       sprintf(bpf_build_id + i*2, "%02x",
> +                               (unsigned char) val.data[i]);
> +               }
> +
> +               if (!ASSERT_OK(read_buildid(key, &build_id), "read_buildid"))
> +                       break;
> +
> +               printf("BUILDID %s %s %s\n", bpf_build_id, build_id, key);

debugging leftover or intentional?

> +               ASSERT_OK(strncmp(bpf_build_id, build_id, strlen(bpf_build_id)), "buildid_cmp");
> +
> +               free(build_id);
> +               prev_key = key;
> +               cnt++;
> +       }
> +
> +       printf("checked %d files\n", cnt);

ditto

> +out:
> +       close(proc_maps_fd);
> +       close(iter_fd);
> +       bpf_iter_task_vma_buildid__destroy(skel);
> +}
> +
>  void test_bpf_sockmap_map_iter_fd(void)
>  {
>         struct bpf_iter_sockmap *skel;
> @@ -1659,6 +1745,8 @@ void test_bpf_iter(void)
>                 test_task_vma();
>         if (test__start_subtest("task_vma_dead_task"))
>                 test_task_vma_dead_task();
> +       if (test__start_subtest("task_vma_buildid"))
> +               test_task_vma_buildid();
>         if (test__start_subtest("task_btf"))
>                 test_task_btf();
>         if (test__start_subtest("tcp4"))
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> new file mode 100644
> index 000000000000..25e2179ae5f4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +#include <string.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define VM_EXEC                0x00000004
> +#define D_PATH_BUF_SIZE        1024
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 10000);
> +       __type(key, char[D_PATH_BUF_SIZE]);
> +       __type(value, struct build_id);
> +} files SEC(".maps");
> +
> +static char tmp_key[D_PATH_BUF_SIZE];
> +static struct build_id tmp_data;
> +
> +SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)

nit: let's keep SEC() on separate line from function itself

> +{
> +       struct vm_area_struct *vma = ctx->vma;
> +       struct seq_file *seq = ctx->meta->seq;
> +       struct task_struct *task = ctx->task;
> +       unsigned long file_key;
> +       struct file *file;
> +
> +       if (task == (void *)0 || vma == (void *)0)
> +               return 0;
> +
> +       if (!(vma->vm_flags & VM_EXEC))
> +               return 0;
> +
> +       file = vma->vm_file;
> +       if (!file)
> +               return 0;
> +
> +       memset(tmp_key, 0x0, D_PATH_BUF_SIZE);

__builtin_memset() to not rely on compiler optimization?

> +       bpf_d_path(&file->f_path, (char *) &tmp_key, D_PATH_BUF_SIZE);
> +
> +       if (bpf_map_lookup_elem(&files, &tmp_key))
> +               return 0;
> +
> +       memcpy(&tmp_data, file->f_bid, sizeof(*file->f_bid));

same about __builtin_memcpy()

> +       bpf_map_update_elem(&files, &tmp_key, &tmp_data, 0);
> +       return 0;
> +}
> --
> 2.39.1
>
