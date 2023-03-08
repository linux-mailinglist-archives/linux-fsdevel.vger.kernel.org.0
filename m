Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB396B0A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjCHOBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjCHOBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:01:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB34F31E0A;
        Wed,  8 Mar 2023 06:00:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az36so9878584wmb.1;
        Wed, 08 Mar 2023 06:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678284005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijCIwYAPHXH0JJ+XDQYDNj+O+tMouNaBIO9o2nVcDs8=;
        b=THbWYOEzoZY1Wq+Hj1c1Z23EGHOERcBr1xS1UYnd58sZJTcj65wRsmdBIpATJ5ZEvi
         2UAVbYzzXm/CbuXOWd3xUzPdspNUTbXiSmWUcIwdZf2tJHwERpph/iO374/hLyv3thOL
         SvK0uufuL6YupsR1/whQEb7+NQ4S1vJHyWn8V2qwBJ20rF0EKy9Y95Grl+3dP2JnFPaW
         7T1p14NXqyYLqGuXhvElEuCQL3j5gA9Lj0e29CuyX1XJSUA634hNOPRicebRONgNJPKX
         XyBpPzpprlp6ybWCSiTz/Mvf2CyQwxL4FwnnBzp/yTsbvD5CHU4WFnECZPlcfwOfiowB
         hJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijCIwYAPHXH0JJ+XDQYDNj+O+tMouNaBIO9o2nVcDs8=;
        b=4gfywHiKLs4eJcfVm5amaWwkuFfNhbUeVgNz5drpHUhlGOMU5oJ1ZyVNha2v8iJIe/
         QWMnX0wwWlpH/3Z+mg+bkau75+drtdlvooL0nSr9vHik9hxiHl09ugYTuyrNUfp2p2O1
         MdGmakCAUcn9RtVg70YoY33YwL7Ztq6rOJS/J9YaxApHG9swchicY2MJmSWczGp0349q
         /XuzrVlwGVuswkL7kIxcdXQYIWNjRrrrR+S2EwPe276cXvdqr8Wk9ToXVwqkiKvdumM/
         yZQ+iW5awRfQQ+2ro4dWxPC01rn8Dp3vpQ43U9uKNmHTs/2Cd5kVm0uKA8NZDlzM+dB+
         jS4g==
X-Gm-Message-State: AO0yUKUEOi34wugND4buA09P0kga8b/R1JWTsQJn6iMf59hr2WqDJVRL
        xdaFV4WAjf7iqotp8swSyv4=
X-Google-Smtp-Source: AK7set/vn8OmbYpYQOF2rZW6B03lZoH7qD0Ni12/ue2KmXWMbAqnSzbBF1zwnu0kRzByWKofxqOH9A==
X-Received: by 2002:a05:600c:4fc5:b0:3e2:1f63:4beb with SMTP id o5-20020a05600c4fc500b003e21f634bebmr16964014wmq.19.1678284005129;
        Wed, 08 Mar 2023 06:00:05 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b003e7f1086660sm21557344wmo.15.2023.03.08.06.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:00:04 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Mar 2023 15:00:02 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH RFC v2 bpf-next 9/9] selftests/bpf: Add
 iter_task_vma_buildid test
Message-ID: <ZAiU4nk5zKey4p5O@krava>
References: <20230228093206.821563-1-jolsa@kernel.org>
 <20230228093206.821563-10-jolsa@kernel.org>
 <CAEf4BzbLz5q8NgREMEiOPumSBEhKMh0rDC=1ii8Muvm4Whg59w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbLz5q8NgREMEiOPumSBEhKMh0rDC=1ii8Muvm4Whg59w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:32:17PM -0800, Andrii Nakryiko wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> > new file mode 100644
> > index 000000000000..dc528a4783ec
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "bpf_iter.h"
> > +#include "err.h"
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
> > +static char path[D_PATH_BUF_SIZE];
> > +static struct build_id build_id;
> > +
> > +SEC("iter/task_vma")
> > +int proc_maps(struct bpf_iter__task_vma *ctx)
> > +{
> > +       struct vm_area_struct *vma = ctx->vma;
> > +       struct seq_file *seq = ctx->meta->seq;
> > +       struct task_struct *task = ctx->task;
> > +       unsigned long file_key;
> > +       struct inode *inode;
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
> > +       __builtin_memset(path, 0x0, D_PATH_BUF_SIZE);
> > +       bpf_d_path(&file->f_path, (char *) &path, D_PATH_BUF_SIZE);
> > +
> > +       if (bpf_map_lookup_elem(&files, &path))
> > +               return 0;
> > +
> > +       inode = file->f_inode;
> > +       if (IS_ERR_OR_NULL(inode->i_build_id)) {
> > +               /* On error return empty build id. */
> > +               __builtin_memset(&build_id.data, 0x0, sizeof(build_id.data));
> > +               build_id.sz = 20;
> 
> let's replace `#define BUILD_ID_SIZE_MAX 20` in
> include/linux/buildid.h with `enum { BUILD_ID_SIZE_MAX = 20 };`. This
> will "expose" this constant into BTF and thus vmlinux.h, so we won't
> have to hard-code anything. BPF users would be grateful as well.
> 
> No downsides of doing this.

ok works nicely.. thanks

jirka
