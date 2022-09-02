Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50C5AB5A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbiIBPtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiIBPtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:49:02 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6F7DA3CA;
        Fri,  2 Sep 2022 08:39:32 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU8kv-000AgN-B3; Fri, 02 Sep 2022 17:38:53 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU8ku-00094m-Nl; Fri, 02 Sep 2022 17:38:52 +0200
Subject: Re: [PATCH] bpf: added the account of BPF running time
To:     Yunhui Cui <cuiyunhui@bytedance.com>, corbet@lwn.net,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        david@redhat.com, mail@christoph.anton.mitterer.name,
        ccross@google.com, vincent.whitchurch@axis.com,
        paul.gortmaker@windriver.com, peterz@infradead.org,
        edumazet@google.com, joshdon@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org
References: <20220902101217.1419-1-cuiyunhui@bytedance.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a16957b9-9247-55f6-eb5e-f9f1c2de7580@iogearbox.net>
Date:   Fri, 2 Sep 2022 17:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220902101217.1419-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26646/Fri Sep  2 09:55:25 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/22 12:12 PM, Yunhui Cui wrote:
[...]
> index a5f21dc3c432..9cb072f9e32b 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -565,6 +565,12 @@ struct sk_filter {
>   	struct bpf_prog	*prog;
>   };
>   
> +struct bpf_account {
> +	u64_stats_t nsecs;
> +	struct u64_stats_sync syncp;
> +};
> +DECLARE_PER_CPU(struct bpf_account, bpftime);
> +
>   DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>   
>   typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
> @@ -577,12 +583,14 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
>   					  bpf_dispatcher_fn dfunc)
>   {
>   	u32 ret;
> +	struct bpf_account *bact;
> +	unsigned long flags;
> +	u64 start = 0;
>   
>   	cant_migrate();
> +	start = sched_clock();
>   	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
>   		struct bpf_prog_stats *stats;
> -		u64 start = sched_clock();
> -		unsigned long flags;
>   
>   		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
>   		stats = this_cpu_ptr(prog->stats);
> @@ -593,6 +601,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
>   	} else {
>   		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
>   	}
> +	bact = this_cpu_ptr(&bpftime);
> +	flags = u64_stats_update_begin_irqsave(&bact->syncp);
> +	u64_stats_add(&bact->nsecs, sched_clock() - start);
> +	u64_stats_update_end_irqrestore(&bact->syncp, flags);
> +
>   	return ret;

The overhead this adds unconditionally is no-go. Have you tried using/improving:

commit 47c09d6a9f6794caface4ad50930460b82d7c670
Author: Song Liu <songliubraving@fb.com>
Date:   Mon Mar 9 10:32:15 2020 -0700

     bpftool: Introduce "prog profile" command

     With fentry/fexit programs, it is possible to profile BPF program with
     hardware counters. Introduce bpftool "prog profile", which measures key
     metrics of a BPF program.

     bpftool prog profile command creates per-cpu perf events. Then it attaches
     fentry/fexit programs to the target BPF program. The fentry program saves
     perf event value to a map. The fexit program reads the perf event again,
     and calculates the difference, which is the instructions/cycles used by
     the target program.

     Example input and output:

       ./bpftool prog profile id 337 duration 3 cycles instructions llc_misses

             4228 run_cnt
          3403698 cycles                                              (84.08%)
          3525294 instructions   #  1.04 insn per cycle               (84.05%)
               13 llc_misses     #  3.69 LLC misses per million isns  (83.50%)

     This command measures cycles and instructions for BPF program with id
     337 for 3 seconds. The program has triggered 4228 times. The rest of the
     output is similar to perf-stat. [...]

Thanks,
Daniel
