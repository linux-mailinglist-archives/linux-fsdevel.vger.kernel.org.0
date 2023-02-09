Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD2690EFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBIRRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 12:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBIRRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:17:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF4658F2;
        Thu,  9 Feb 2023 09:17:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id dr8so8381634ejc.12;
        Thu, 09 Feb 2023 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hOaWLeC8ipHRmcLbRfn6JATZO77iIGtuyhLGc5wCYsg=;
        b=eMz4/BTebHTthy7QIrMrF8piEjMCHk5gkyR04gPH0mQnoNxtk+juSI73WZpFmbv2gf
         FuQFYTsppEmm2CuV586y5L0Zop+4pJCnUHDtqT3b1tZbv9JE4w8f8tC43Bd7PWCBOhlA
         AsdznGOUVVgd38zrLID94UUU38wQwt+tzDz5OCKpX0LKf0HG/twtUODLrFm2TzC4gIbn
         eKt3ivD976xMgctdzkH8i6UWi2e8vGsJhFXzQSHSRHiNdET92IQNqFeDURxJh9zasCwY
         ba/IBqZzqb1CVIjc4JYx/HTf8p3zctAx4W8wNNb3BsvxutDM41yczWIevc6TIF0h5mL3
         NXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOaWLeC8ipHRmcLbRfn6JATZO77iIGtuyhLGc5wCYsg=;
        b=0pUZQ55hzkDuZUQDSU1Cu85hM34JD8q+yA0PiU5/e11hUApwWxY0543MFG+NFQ2drB
         9bB3YfeiYdLQ0lk398v9UAU7hvu1yyRRgfv7Cuz8LnFXmyRFBCjZqS5P4kWQq9eEEqFA
         Tn4pKK9o3I0Y+7sH985vA5KTiHkGNp6MkB7kkIyO35D4CANDMkwVev0AXwDDyoHS37cJ
         UcmITOcfRseiyweQFAjoIP6Izo2Wies+wRLtwkiSwy6b6IEOIhK+mxzkspnq7yIU6dWf
         YSV/QVqDN9iLg0WzQJbfYA+W1AneU9LZjAbTZBov0gP9kPDmCw7LQwXJ8N8Wdeqv4xKI
         BrWA==
X-Gm-Message-State: AO0yUKUIp7sAZgQaxd1aWMsWCpcsEIHEOqofqDtO98CvlkcbdWT4Pst1
        eMXiiwMbOv4gCXYMF00QqyROnF/7SgqD7K2wOjE=
X-Google-Smtp-Source: AK7set+twhKV+Ooh2gn/db6SF56f0jFgx/U8eC4Rup6g9uqGZ3eD9dYBHu34t+9OvtxJPnu0EFSQVSdwEy9TKbvAPXM=
X-Received: by 2002:a17:906:aec1:b0:889:8f1a:a153 with SMTP id
 me1-20020a170906aec100b008898f1aa153mr660783ejb.15.1675963018825; Thu, 09 Feb
 2023 09:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <20230201135737.800527-6-jolsa@kernel.org>
 <CAEf4BzYGQGdydeVbZf5YTnDTvGduA_wbeQ=t5nSc6Wi=S17+=A@mail.gmail.com> <Y+T9XNkDWla1+3NV@krava>
In-Reply-To: <Y+T9XNkDWla1+3NV@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Feb 2023 09:16:46 -0800
Message-ID: <CAEf4BzZ0yWJX0iNHEeSmWMmy_SiSCvhPjJdfcaET-3RHeb38Hg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] selftests/bpf: Add iter_task_vma_buildid test
To:     Jiri Olsa <olsajiri@gmail.com>
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

On Thu, Feb 9, 2023 at 6:04 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Feb 08, 2023 at 04:01:42PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > +static void test_task_vma_buildid(void)
> > > +{
> > > +       int err, iter_fd = -1, proc_maps_fd = -1;
> > > +       struct bpf_iter_task_vma_buildid *skel;
> > > +       char key[D_PATH_BUF_SIZE], *prev_key;
> > > +       char bpf_build_id[BUILDID_STR_SIZE];
> > > +       int len, files_fd, i, cnt = 0;
> > > +       struct build_id val;
> > > +       char *build_id;
> > > +       char c;
> > > +
> > > +       skel = bpf_iter_task_vma_buildid__open();
> > > +       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma_buildid__open"))
> > > +               return;
> > > +
> > > +       err = bpf_iter_task_vma_buildid__load(skel);
> > > +       if (!ASSERT_OK(err, "bpf_iter_task_vma_buildid__load"))
> > > +               goto out;
> >
> > minor: you can do __open_and_load() in one step
>
> right, I copied that from another test, but removed all the
> setup in between, so we can actually call just __open_and_load
>
> SNIP
>
> > > +               memset(bpf_build_id, 0x0, sizeof(bpf_build_id));
> > > +               for (i = 0; i < val.sz; i++) {
> > > +                       sprintf(bpf_build_id + i*2, "%02x",
> > > +                               (unsigned char) val.data[i]);
> > > +               }
> > > +
> > > +               if (!ASSERT_OK(read_buildid(key, &build_id), "read_buildid"))
> > > +                       break;
> > > +
> > > +               printf("BUILDID %s %s %s\n", bpf_build_id, build_id, key);
> >
> > debugging leftover or intentional?
> >
> > > +               ASSERT_OK(strncmp(bpf_build_id, build_id, strlen(bpf_build_id)), "buildid_cmp");
> > > +
> > > +               free(build_id);
> > > +               prev_key = key;
> > > +               cnt++;
> > > +       }
> > > +
> > > +       printf("checked %d files\n", cnt);
> >
> > ditto
>
> both intentional, first one can go out I guess, but the
> number of checked files seemed interesting to me ;-)
>
> SNIP
>
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> > > new file mode 100644
> > > index 000000000000..25e2179ae5f4
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> > > @@ -0,0 +1,49 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include "bpf_iter.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <string.h>
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > +
> > > +#define VM_EXEC                0x00000004
> > > +#define D_PATH_BUF_SIZE        1024
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_HASH);
> > > +       __uint(max_entries, 10000);
> > > +       __type(key, char[D_PATH_BUF_SIZE]);
> > > +       __type(value, struct build_id);
> > > +} files SEC(".maps");
> > > +
> > > +static char tmp_key[D_PATH_BUF_SIZE];
> > > +static struct build_id tmp_data;
> > > +
> > > +SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
> >
> > nit: let's keep SEC() on separate line from function itself
>
> ok
>
> >
> > > +{
> > > +       struct vm_area_struct *vma = ctx->vma;
> > > +       struct seq_file *seq = ctx->meta->seq;
> > > +       struct task_struct *task = ctx->task;
> > > +       unsigned long file_key;
> > > +       struct file *file;
> > > +
> > > +       if (task == (void *)0 || vma == (void *)0)
> > > +               return 0;
> > > +
> > > +       if (!(vma->vm_flags & VM_EXEC))
> > > +               return 0;
> > > +
> > > +       file = vma->vm_file;
> > > +       if (!file)
> > > +               return 0;
> > > +
> > > +       memset(tmp_key, 0x0, D_PATH_BUF_SIZE);
> >
> > __builtin_memset() to not rely on compiler optimization?
> >
> > > +       bpf_d_path(&file->f_path, (char *) &tmp_key, D_PATH_BUF_SIZE);
> > > +
> > > +       if (bpf_map_lookup_elem(&files, &tmp_key))
> > > +               return 0;
> > > +
> > > +       memcpy(&tmp_data, file->f_bid, sizeof(*file->f_bid));
> >
> > same about __builtin_memcpy()
>
> ah ok, did not know that, will check.. curious what could
> go wrong by using not '__builtin_...' version?

if compiler doesn't optimize it into __builtin_memcpy() (which results
in just explicit assembly code to copy/set data word-by-word), then
BPF program will do actual call to memset(), which with C rules would
be inferred as extern symbol, which would fail BPF object loading with
error along the lines of "couldn't resolve memset extern".

>
> thanks,
> jirka
