Return-Path: <linux-fsdevel+bounces-5985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BB811A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77481F213C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E953A8FF;
	Wed, 13 Dec 2023 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A1inhCL9"
X-Original-To: linux-fsdevel@vger.kernel.org
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 09:09:05 PST
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C49EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 09:09:05 -0800 (PST)
Message-ID: <6960ef41-fe22-4297-adc7-c85264288b6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702486777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4lJ6fuy6gVgOBLJgySJCzr4DpnAgH48SfeJ2oQaas8=;
	b=A1inhCL90hXyszEVY0knTkLQ/A4/3UIByKIh3eamKJfjCkdCG6PcVsh9j0f3y2gNyDIzPQ
	SwWY3FuNgxxpjGm06LZu4YviM+nKHDMxGRJfSDmQJDzw2qqwM9l3oYy4MNIt3X4z9mgpEj
	8QxbZSU2G6ruY81+VFFeNt4dzBwTc6w=
Date: Wed, 13 Dec 2023 08:59:26 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 1/3] bpf: cgroup: Introduce helper
 cgroup_bpf_current_enabled()
Content-Language: en-GB
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Quentin Monnet <quentin@isovalent.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-2-michael.weiss@aisec.fraunhofer.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231213143813.6818-2-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/13/23 6:38 AM, Michael Weiß wrote:
> This helper can be used to check if a cgroup-bpf specific program is
> active for the current task.
>
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>   include/linux/bpf-cgroup.h |  2 ++
>   kernel/bpf/cgroup.c        | 14 ++++++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index a789266feac3..7cb49bde09ff 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -191,6 +191,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   	return array != &bpf_empty_prog_array.hdr;
>   }
>   
> +bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type);
> +
>   /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>   #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
>   ({									      \
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 491d20038cbe..9007165abe8c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -24,6 +24,20 @@
>   DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
>   EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>   
> +bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type)
> +{
> +	struct cgroup *cgrp;
> +	struct bpf_prog_array *array;
> +
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(current);
> +	rcu_read_unlock();
> +
> +	array = rcu_access_pointer(cgrp->bpf.effective[type]);

This seems wrong here. The cgrp could become invalid once leaving
rcu critical section.

> +	return array != &bpf_empty_prog_array.hdr;

I guess you need include 'array' usage as well in the rcu cs.
So overall should look like:

	rcu_read_lock();
	cgrp = task_dfl_cgroup(current);
	array = rcu_access_pointer(cgrp->bpf.effective[type]);
	bpf_prog_exists = array != &bpf_empty_prog_array.hdr;
	rcu_read_unlock();

	return bpf_prog_exists;

> +}
> +EXPORT_SYMBOL(cgroup_bpf_current_enabled);
> +
>   /* __always_inline is necessary to prevent indirect call through run_prog
>    * function pointer.
>    */

