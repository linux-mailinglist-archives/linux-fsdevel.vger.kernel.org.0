Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87814690B43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjBIOET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 09:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBIOES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:04:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5A47402;
        Thu,  9 Feb 2023 06:04:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r18so1485462wmq.5;
        Thu, 09 Feb 2023 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PUxryEd4dhrO7bv0OIAXlQqcpfOYRHX35DELWBAPHE=;
        b=iZJRZxrJefggzAC+FvHDTR5gLHr2uHOtDx8X2MdTdeIgzrzDG6+ByN0Vf4uv9rbdJa
         0MDoPsaegm6+PTbsCeRrIagMBvqPuzr2uZgBUl5tcxm8ne9n8LsmVBYHokjdCxILpZxg
         lqpWDghfBS1ywAJqFT7yJs3O/js1VCARGvfb7N76nxzSNSLWejE0lU+9nvtZs9HwdpBO
         d1lnFgGgMUdH+V+IxsKZnRkgPWhYRON4NyfgJEElTfQP3AOo0Gruo8GPcnQtKou34Kb6
         cT46EXKlM1V7w/af/QS5WDqFwniA7H85MWFGufBNMoBZzK45yyPtv4FWFgwZQZXUTKK3
         sRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PUxryEd4dhrO7bv0OIAXlQqcpfOYRHX35DELWBAPHE=;
        b=KIOsmbXl+yWcrOYTSYAWC825vtPZM1GWyog64ddDYRmD2s6tVT2j+8oNS8jjdeNNUg
         6M165mzeYAp4b9/l4rOi45Y4cng5VKsDBxrzs2Oi72oKGCs3kaHG3svUlDtLsS0UZEql
         c7OUMErIIFGDksnQ8vxA5C1uDNxx0vkFfHCefioYPh8/CjsrcGEMrdK9H5TTmQ4n6T4r
         EYWabdfbO7toX9CbWA18TkyctderQbgM2GmJeKTYSeke5PdZyRmdy/mcFspre+OzUDWV
         A93Crylk62R4JSewmTMZIYaSmimILLoH7ZU66VDBwbLi/fyrm7rEP0HxIZBaTRFgnga8
         KNYg==
X-Gm-Message-State: AO0yUKULhVaANVjIAQptgGxq5RKCKLTZ+KEk3aozw2hiUO2bbIJBnyKC
        HMR2SsRPjkWxR3MI1Cz5hSA=
X-Google-Smtp-Source: AK7set+dQJhhuPXnb9xc8cpZgho9rV47XxrGh3m7mcorhUF5e31qI+vipv6EPg0wYlRKPwf3t1OkIg==
X-Received: by 2002:a05:600c:3d0e:b0:3df:efdd:9dc7 with SMTP id bh14-20020a05600c3d0e00b003dfefdd9dc7mr6197494wmb.10.1675951455884;
        Thu, 09 Feb 2023 06:04:15 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u6-20020adfed46000000b002bf95500254sm1378133wro.64.2023.02.09.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 06:04:15 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 15:04:12 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH RFC 5/5] selftests/bpf: Add iter_task_vma_buildid test
Message-ID: <Y+T9XNkDWla1+3NV@krava>
References: <20230201135737.800527-1-jolsa@kernel.org>
 <20230201135737.800527-6-jolsa@kernel.org>
 <CAEf4BzYGQGdydeVbZf5YTnDTvGduA_wbeQ=t5nSc6Wi=S17+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYGQGdydeVbZf5YTnDTvGduA_wbeQ=t5nSc6Wi=S17+=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:01:42PM -0800, Andrii Nakryiko wrote:

SNIP

> > +static void test_task_vma_buildid(void)
> > +{
> > +       int err, iter_fd = -1, proc_maps_fd = -1;
> > +       struct bpf_iter_task_vma_buildid *skel;
> > +       char key[D_PATH_BUF_SIZE], *prev_key;
> > +       char bpf_build_id[BUILDID_STR_SIZE];
> > +       int len, files_fd, i, cnt = 0;
> > +       struct build_id val;
> > +       char *build_id;
> > +       char c;
> > +
> > +       skel = bpf_iter_task_vma_buildid__open();
> > +       if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma_buildid__open"))
> > +               return;
> > +
> > +       err = bpf_iter_task_vma_buildid__load(skel);
> > +       if (!ASSERT_OK(err, "bpf_iter_task_vma_buildid__load"))
> > +               goto out;
> 
> minor: you can do __open_and_load() in one step

right, I copied that from another test, but removed all the
setup in between, so we can actually call just __open_and_load

SNIP

> > +               memset(bpf_build_id, 0x0, sizeof(bpf_build_id));
> > +               for (i = 0; i < val.sz; i++) {
> > +                       sprintf(bpf_build_id + i*2, "%02x",
> > +                               (unsigned char) val.data[i]);
> > +               }
> > +
> > +               if (!ASSERT_OK(read_buildid(key, &build_id), "read_buildid"))
> > +                       break;
> > +
> > +               printf("BUILDID %s %s %s\n", bpf_build_id, build_id, key);
> 
> debugging leftover or intentional?
> 
> > +               ASSERT_OK(strncmp(bpf_build_id, build_id, strlen(bpf_build_id)), "buildid_cmp");
> > +
> > +               free(build_id);
> > +               prev_key = key;
> > +               cnt++;
> > +       }
> > +
> > +       printf("checked %d files\n", cnt);
> 
> ditto

both intentional, first one can go out I guess, but the
number of checked files seemed interesting to me ;-)

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> > new file mode 100644
> > index 000000000000..25e2179ae5f4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "bpf_iter.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <string.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +#define VM_EXEC                0x00000004
> > +#define D_PATH_BUF_SIZE        1024
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __uint(max_entries, 10000);
> > +       __type(key, char[D_PATH_BUF_SIZE]);
> > +       __type(value, struct build_id);
> > +} files SEC(".maps");
> > +
> > +static char tmp_key[D_PATH_BUF_SIZE];
> > +static struct build_id tmp_data;
> > +
> > +SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
> 
> nit: let's keep SEC() on separate line from function itself

ok

> 
> > +{
> > +       struct vm_area_struct *vma = ctx->vma;
> > +       struct seq_file *seq = ctx->meta->seq;
> > +       struct task_struct *task = ctx->task;
> > +       unsigned long file_key;
> > +       struct file *file;
> > +
> > +       if (task == (void *)0 || vma == (void *)0)
> > +               return 0;
> > +
> > +       if (!(vma->vm_flags & VM_EXEC))
> > +               return 0;
> > +
> > +       file = vma->vm_file;
> > +       if (!file)
> > +               return 0;
> > +
> > +       memset(tmp_key, 0x0, D_PATH_BUF_SIZE);
> 
> __builtin_memset() to not rely on compiler optimization?
> 
> > +       bpf_d_path(&file->f_path, (char *) &tmp_key, D_PATH_BUF_SIZE);
> > +
> > +       if (bpf_map_lookup_elem(&files, &tmp_key))
> > +               return 0;
> > +
> > +       memcpy(&tmp_data, file->f_bid, sizeof(*file->f_bid));
> 
> same about __builtin_memcpy()

ah ok, did not know that, will check.. curious what could
go wrong by using not '__builtin_...' version?

thanks,
jirka
