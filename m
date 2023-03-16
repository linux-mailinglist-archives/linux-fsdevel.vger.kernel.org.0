Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475746BD9B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 21:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCPUAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCPUAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:00:34 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA5CC309;
        Thu, 16 Mar 2023 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1+em3CxVhuR3t6hBfQ8ylZ5mFdk8mfxa3UhWs5bbebE=; b=jnfTLbEYvHHYc0U0zB3DuCNep9
        VQUjClUzHpq6rCcIiW8MhZBjnyv1nSpWEGrOzwVtrLyDwxtMWEqU/2rj48STQjv+k14/9EaXBcmgi
        sV61H+eMBJHKSn4mo5GbdWuV5UlK/ozBf/KO/CKgeEKGEzM8CCMuOiwOJMI6ObdjTTB3JsCMYkHgi
        yZ1rIrtCpgy2ZEABBuS7URmVOsapvfSIYwhczA2gEESMwKyd9tggTRZHlDpFjEgf/NRXVax5yz8Z5
        y5TWju9TY+Qj5SHP9hADSMEIyNjWprGlOKKfMMzptm+Bd5vjbM/vWKz5sqTKQ4j4GDPNUfl/oxobQ
        jYRmVdFw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pctkx-000GR8-FZ; Thu, 16 Mar 2023 20:59:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pctkw-0003g0-Nf; Thu, 16 Mar 2023 20:59:22 +0100
Subject: Re: [PATCHv3 bpf-next 9/9] selftests/bpf: Add file_build_id test
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
References: <20230316170149.4106586-1-jolsa@kernel.org>
 <20230316170149.4106586-10-jolsa@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <478a8e03-dea3-ebca-8376-6b7e3b616b5e@iogearbox.net>
Date:   Thu, 16 Mar 2023 20:59:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230316170149.4106586-10-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26845/Thu Mar 16 19:16:15 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/16/23 6:01 PM, Jiri Olsa wrote:
> The test attaches bpf program to sched_process_exec tracepoint
> and gets build of executed file from bprm->file object.
> 
> We use urandom_read as the test program and in addition we also
> attach uprobe to liburandom_read.so:urandlib_read_without_sema
> and retrieve and check build id of that shared library.
> 
> Also executing the no_build_id binary to verify the bpf program
> gets the error properly.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/file_build_id.c b/tools/testing/selftests/bpf/progs/file_build_id.c
> new file mode 100644
> index 000000000000..6dc10c8e17ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/file_build_id.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include "err.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <linux/string.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int pid;
> +
> +u32 build_id_bin_size;
> +u32 build_id_lib_size;
> +
> +char build_id_bin[BUILD_ID_SIZE_MAX];
> +char build_id_lib[BUILD_ID_SIZE_MAX];
> +
> +long build_id_bin_err;
> +long build_id_lib_err;
> +
> +static int store_build_id(struct file *file, char *build_id, u32 *sz, long *err)
> +{
> +	struct build_id *bid;
> +
> +	bid = file->f_build_id;
> +	if (IS_ERR_OR_NULL(bid)) {

I think you might need to enable this also in the CI config:

   [...]
     CLNG-BPF [test_maps] btf_dump_test_case_multidim.bpf.o
     CLNG-BPF [test_maps] ima.bpf.o
     CLNG-BPF [test_maps] bpf_cubic.bpf.o
   progs/bpf_iter_task_vma_buildid.c:46:27: error: no member named 'f_build_id' in 'struct file'
           if (IS_ERR_OR_NULL(file->f_build_id)) {
                              ~~~~  ^
   progs/bpf_iter_task_vma_buildid.c:51:37: error: no member named 'f_build_id' in 'struct file'
                   __builtin_memcpy(&build_id, file->f_build_id, sizeof(*file->f_build_id));
                                               ~~~~  ^
   progs/bpf_iter_task_vma_buildid.c:51:63: error: no member named 'f_build_id' in 'struct file'
                   __builtin_memcpy(&build_id, file->f_build_id, sizeof(*file->f_build_id));
                                                                         ~~~~  ^
   3 errors generated.
   make: *** [Makefile:578: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/bpf_iter_task_vma_buildid.bpf.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

Thanks,
Daniel
