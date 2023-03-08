Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D26AFC3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 02:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCHB0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 20:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCHB0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:26:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AD2898DB;
        Tue,  7 Mar 2023 17:26:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j11so40291961edq.4;
        Tue, 07 Mar 2023 17:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678238805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li/ZgFXVP1Se56QdUsy/uv0TfvyuXofWTKsHZLAR0u8=;
        b=iZJUH/J3LDHn1vSlVYlB7F4OHGs5nuClm3+6k8o+tyMEXcAAf+O8L5y5J+2Pv9Gs4K
         Bs1GUbaLIH0J6VMGlPCk3vrLv/mDc65kQxDprstIs/Lf/97jeXemaXO9qNYzkWriaknm
         7FCQcI0IvaKd4lHCmBfIkTpmicWyPD0zViylk0JeHezdLu+GguQt/JP4vSwuUs6zoj1w
         4UwpxTYwgDFIOG9/dpCSqJzEdGkMp1izGNuL7NksYzGThWC50sFa1voZkIyMUyy4H2qM
         RDOPp+nNKY7/sNZHTFVb6AewEA9FaumABuAEtxckMPOFGgh2G1x5LpuQiEC1evnesim8
         JNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li/ZgFXVP1Se56QdUsy/uv0TfvyuXofWTKsHZLAR0u8=;
        b=N21ukIxRm77qaMWuo7X3bVyb46j15K7eTWVNO8oG9ntsfZE2pymVTHWKhAQgrTEHVQ
         XY9oLOBEA+E79ZihdKsaad4ZnIAd8a9Th0+TqiREdlF09L/gDwxuuiF0UdH3OGo+h792
         UGDsj0whC4aZuPypYjxDJiIR721amvHF+ujl88JEdgS/J+LYQG1dI+Sc97pm3ELY3LwY
         unQSXR82WkfzeVkYtqHPEst0TDaynQCqAQ+5S96gW592sB97CjMTmkPkbHofbVgpkIt5
         6yAMScXh2CfUX5zd2gWhrtWO9Q3+metnCxqfYLo2X2u2ul0e6ECmfLSwildE1UvJpy5t
         rbjg==
X-Gm-Message-State: AO0yUKUyT9K8JPt892P3UL1hKjUVPqBYo5Tgh+bu6r/+4Wm15esy42Xr
        vM/MXesIcqnDbtPdVxcVGMDeSF8sl4OKunPJWOLYOuZbDnc=
X-Google-Smtp-Source: AK7set/Yboq1ECwCfm6ab/yrsQXlJu0ggY8MGTJNHj7mLxZr/bf0BTOQb2Z15ZV6UhYJ9ldsL72UsBPkNBwjVCNYx2c=
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr8943838edb.5.1678238804760; Tue, 07 Mar
 2023 17:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20230228093206.821563-1-jolsa@kernel.org> <20230228093206.821563-8-jolsa@kernel.org>
In-Reply-To: <20230228093206.821563-8-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 17:26:32 -0800
Message-ID: <CAEf4Bzb-ZuR6RwgGEw1Dyy+HtvyzdnCYXWXU86v=694rWcZpAA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 bpf-next 7/9] selftests/bpf: Replace
 extract_build_id with read_build_id
To:     Jiri Olsa <jolsa@kernel.org>
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:33=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Replacing extract_build_id with read_build_id that parses out
> build id directly from elf without using readelf tool.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

small nit below, but looks good. Thanks for clean up!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../bpf/prog_tests/stacktrace_build_id.c      | 19 ++++++--------
>  .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 17 +++++--------
>  tools/testing/selftests/bpf/test_progs.c      | 25 -------------------
>  tools/testing/selftests/bpf/test_progs.h      |  1 -
>  4 files changed, 13 insertions(+), 49 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c=
 b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
> index 9ad09a6c538a..9e4b76ee356f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
> @@ -7,13 +7,12 @@ void test_stacktrace_build_id(void)
>
>         int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
>         struct test_stacktrace_build_id *skel;
> -       int err, stack_trace_len;
> +       int err, stack_trace_len, build_id_size;
>         __u32 key, prev_key, val, duration =3D 0;
> -       char buf[256];
> -       int i, j;
> +       char buf[BPF_BUILD_ID_SIZE];
>         struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
>         int build_id_matches =3D 0;
> -       int retry =3D 1;
> +       int i, retry =3D 1;
>
>  retry:
>         skel =3D test_stacktrace_build_id__open_and_load();
> @@ -52,9 +51,10 @@ void test_stacktrace_build_id(void)
>                   "err %d errno %d\n", err, errno))
>                 goto cleanup;
>
> -       err =3D extract_build_id(buf, 256);
> +       build_id_size =3D read_build_id("./urandom_read", buf);

nit: "urandom_read" vs "./urandom_read" matters only when executing
binary, not when opening a file. So all these "./" just creates
unnecessary confusion, IMO

> +       err =3D build_id_size < 0 ? build_id_size : 0;
>
> -       if (CHECK(err, "get build_id with readelf",
> +       if (CHECK(err, "read_build_id",
>                   "err %d errno %d\n", err, errno))
>                 goto cleanup;
>
> @@ -64,8 +64,6 @@ void test_stacktrace_build_id(void)
>                 goto cleanup;
>
>         do {
> -               char build_id[64];
> -
>                 err =3D bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
>                 if (CHECK(err, "lookup_elem from stackmap",
>                           "err %d, errno %d\n", err, errno))
> @@ -73,10 +71,7 @@ void test_stacktrace_build_id(void)
>                 for (i =3D 0; i < PERF_MAX_STACK_DEPTH; ++i)
>                         if (id_offs[i].status =3D=3D BPF_STACK_BUILD_ID_V=
ALID &&
>                             id_offs[i].offset !=3D 0) {
> -                               for (j =3D 0; j < 20; ++j)
> -                                       sprintf(build_id + 2 * j, "%02x",
> -                                               id_offs[i].build_id[j] & =
0xff);
> -                               if (strstr(buf, build_id) !=3D NULL)
> +                               if (memcmp(buf, id_offs[i].build_id, buil=
d_id_size) =3D=3D 0)
>                                         build_id_matches =3D 1;
>                         }
>                 prev_key =3D key;
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_n=
mi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> index f4ea1a215ce4..8d84149ebcc7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> @@ -28,11 +28,10 @@ void test_stacktrace_build_id_nmi(void)
>                 .config =3D PERF_COUNT_HW_CPU_CYCLES,
>         };
>         __u32 key, prev_key, val, duration =3D 0;
> -       char buf[256];
> -       int i, j;
> +       char buf[BPF_BUILD_ID_SIZE];
>         struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
> -       int build_id_matches =3D 0;
> -       int retry =3D 1;
> +       int build_id_matches =3D 0, build_id_size;
> +       int i, retry =3D 1;
>
>         attr.sample_freq =3D read_perf_max_sample_freq();
>
> @@ -94,7 +93,8 @@ void test_stacktrace_build_id_nmi(void)
>                   "err %d errno %d\n", err, errno))
>                 goto cleanup;
>
> -       err =3D extract_build_id(buf, 256);
> +       build_id_size =3D read_build_id("./urandom_read", buf);
> +       err =3D build_id_size < 0 ? build_id_size : 0;
>
>         if (CHECK(err, "get build_id with readelf",
>                   "err %d errno %d\n", err, errno))
> @@ -106,8 +106,6 @@ void test_stacktrace_build_id_nmi(void)
>                 goto cleanup;
>
>         do {
> -               char build_id[64];
> -
>                 err =3D bpf_map__lookup_elem(skel->maps.stackmap, &key, s=
izeof(key),
>                                            id_offs, sizeof(id_offs), 0);
>                 if (CHECK(err, "lookup_elem from stackmap",
> @@ -116,10 +114,7 @@ void test_stacktrace_build_id_nmi(void)
>                 for (i =3D 0; i < PERF_MAX_STACK_DEPTH; ++i)
>                         if (id_offs[i].status =3D=3D BPF_STACK_BUILD_ID_V=
ALID &&
>                             id_offs[i].offset !=3D 0) {
> -                               for (j =3D 0; j < 20; ++j)
> -                                       sprintf(build_id + 2 * j, "%02x",
> -                                               id_offs[i].build_id[j] & =
0xff);
> -                               if (strstr(buf, build_id) !=3D NULL)
> +                               if (memcmp(buf, id_offs[i].build_id, buil=
d_id_size) =3D=3D 0)
>                                         build_id_matches =3D 1;
>                         }
>                 prev_key =3D key;
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 6d5e3022c75f..9813d53c4878 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -591,31 +591,6 @@ int compare_stack_ips(int smap_fd, int amap_fd, int =
stack_trace_len)
>         return err;
>  }
>
> -int extract_build_id(char *build_id, size_t size)
> -{
> -       FILE *fp;
> -       char *line =3D NULL;
> -       size_t len =3D 0;
> -
> -       fp =3D popen("readelf -n ./urandom_read | grep 'Build ID'", "r");
> -       if (fp =3D=3D NULL)
> -               return -1;
> -
> -       if (getline(&line, &len, fp) =3D=3D -1)
> -               goto err;
> -       pclose(fp);
> -
> -       if (len > size)
> -               len =3D size;
> -       memcpy(build_id, line, len);
> -       build_id[len] =3D '\0';
> -       free(line);
> -       return 0;
> -err:
> -       pclose(fp);
> -       return -1;
> -}
> -
>  static int finit_module(int fd, const char *param_values, int flags)
>  {
>         return syscall(__NR_finit_module, fd, param_values, flags);
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 9fbdc57c5b57..3825c2797a4b 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -404,7 +404,6 @@ static inline void *u64_to_ptr(__u64 ptr)
>  int bpf_find_map(const char *test, struct bpf_object *obj, const char *n=
ame);
>  int compare_map_keys(int map1_fd, int map2_fd);
>  int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
> -int extract_build_id(char *build_id, size_t size);
>  int kern_sync_rcu(void);
>  int trigger_module_test_read(int read_sz);
>  int trigger_module_test_write(int write_sz);
> --
> 2.39.2
>
