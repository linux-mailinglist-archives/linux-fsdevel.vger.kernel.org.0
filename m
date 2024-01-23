Return-Path: <linux-fsdevel+bounces-8508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963A8386CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 06:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E981428BE58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 05:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB14414;
	Tue, 23 Jan 2024 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxuJVbct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239323BC;
	Tue, 23 Jan 2024 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988194; cv=none; b=QSCzVAUX++kgOgoyhAwApebySuz3Xrk5yFL6CY0+kbYmJ9Zt6s+ZrkhR3uJdf6dpgsFqx5vESlYgEzMG240fog3q6ZvVJ8C1GxlPQz0mb9X1rw9T6canaSQtRHA4/qTPh9gJzPT9nB0zkrylZg8vVSKOzuMTRDDZ4mrcAFObMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988194; c=relaxed/simple;
	bh=XcUyx0Kg5/x6d2IpLX/qANXj9xdB4k83aNsft2ltqyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPHMyGf/+qQAUzWQOO1pXFyPJiGV/YXzxDsEGh+fkhsEbo03Zonx7bCdAc9QH6SV2NDFO9JBmkBll9XD70nTukDSLntVGEeOxPszu+zevx1evl/TZmeedWudmIb6VU2s+N2Jg5dJDj8Z4raTzEaVzIhzwK1gFhDyWd9P9lFS72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxuJVbct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342CEC433C7;
	Tue, 23 Jan 2024 05:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705988193;
	bh=XcUyx0Kg5/x6d2IpLX/qANXj9xdB4k83aNsft2ltqyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxuJVbctGlVRuiog03AjfM1ofgpReV8yuZ06WUjRbYUOC/oCSz8MXnhmA/zpfb52u
	 7N0hYad1xKNfHz5mX8mctlhMVgNDdICvXb5HDFWfZXdq9osHoHb7DmFLncMZ5sn5Lx
	 szxArnmT1njinY0L1HohpN1axVehymgshEHtcj8tA1hgXmGSlb8MEXHabJFAczN9q4
	 mU4jPxrKw2775+vyPE+Fg2EtnyNa8HjDCVbxcPJdC9PAOJNSoQvb7B6fWOA/slwl23
	 yXS6B8pOECKegN8x1T8kzua8LH8sjlEjiXtoulTKIASXYExb5Ekddw+9O+RxTDWhcL
	 LKvYZPRaRvlrw==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dchinner@redhat.com,
	casey@schaufler-ca.com,
	ben.wolsieffer@hefring.com,
	paulmck@kernel.org,
	david@redhat.com,
	avagin@google.com,
	usama.anjum@collabora.com,
	peterx@redhat.com,
	hughd@google.com,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	Liam.Howlett@Oracle.com,
	yuzhao@google.com,
	axelrasmussen@google.com,
	lstoakes@gmail.com,
	talumbau@google.com,
	willy@infradead.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	jhubbard@nvidia.com,
	vishal.moola@gmail.com,
	mathieu.desnoyers@efficios.com,
	dhowells@redhat.com,
	jgg@ziepe.ca,
	sidhartha.kumar@oracle.com,
	andriy.shevchenko@linux.intel.com,
	yangxingui@huawei.com,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@android.com
Subject: Re: [PATCH 3/3] mm/maps: read proc/pid/maps under RCU
Date: Mon, 22 Jan 2024 21:36:29 -0800
Message-Id: <20240123053629.365673-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122071324.2099712-3-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren,

On Sun, 21 Jan 2024 23:13:24 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> With maple_tree supporting vma tree traversal under RCU and per-vma locks
> making vma access RCU-safe, /proc/pid/maps can be read under RCU and
> without the need to read-lock mmap_lock. However vma content can change
> from under us, therefore we make a copy of the vma and we pin pointer
> fields used when generating the output (currently only vm_file and
> anon_name). Afterwards we check for concurrent address space
> modifications, wait for them to end and retry. That last check is needed
> to avoid possibility of missing a vma during concurrent maple_tree
> node replacement, which might report a NULL when a vma is replaced
> with another one. While we take the mmap_lock for reading during such
> contention, we do that momentarily only to record new mm_wr_seq counter.
> This change is designed to reduce mmap_lock contention and prevent a
> process reading /proc/pid/maps files (often a low priority task, such as
> monitoring/data collection services) from blocking address space updates.
> 
> Note that this change has a userspace visible disadvantage: it allows for
> sub-page data tearing as opposed to the previous mechanism where data
> tearing could happen only between pages of generated output data.
> Since current userspace considers data tearing between pages to be
> acceptable, we assume is will be able to handle sub-page data tearing
> as well.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/internal.h |   2 +
>  fs/proc/task_mmu.c | 114 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 109 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index a71ac5379584..e0247225bb68 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -290,6 +290,8 @@ struct proc_maps_private {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	struct vma_iterator iter;
> +	unsigned long mm_wr_seq;
> +	struct vm_area_struct vma_copy;
>  #ifdef CONFIG_NUMA
>  	struct mempolicy *task_mempolicy;
>  #endif
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3f78ebbb795f..3886d04afc01 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -126,11 +126,96 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>  }
>  #endif
>  
> -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> -						loff_t *ppos)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static const struct seq_operations proc_pid_maps_op;
> +/*
> + * Take VMA snapshot and pin vm_file and anon_name as they are used by
> + * show_map_vma.
> + */
> +static int get_vma_snapshow(struct proc_maps_private *priv, struct vm_area_struct *vma)
>  {
> +	struct vm_area_struct *copy = &priv->vma_copy;
> +	int ret = -EAGAIN;
> +
> +	memcpy(copy, vma, sizeof(*vma));
> +	if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> +		goto out;
> +
> +	if (copy->anon_name && !anon_vma_name_get_rcu(copy))
> +		goto put_file;

From today updated mm-unstable which containing this patch, I'm getting below
build error when CONFIG_ANON_VMA_NAME is not set.  Seems this patch needs to
handle the case?

    .../linux/fs/proc/task_mmu.c: In function ‘get_vma_snapshow’:
    .../linux/fs/proc/task_mmu.c:145:19: error: ‘struct vm_area_struct’ has no member named ‘anon_name’; did you mean ‘anon_vma’?
      145 |         if (copy->anon_name && !anon_vma_name_get_rcu(copy))
          |                   ^~~~~~~~~
          |                   anon_vma
    .../linux/fs/proc/task_mmu.c:161:19: error: ‘struct vm_area_struct’ has no member named ‘anon_name’; did you mean ‘anon_vma’?
      161 |         if (copy->anon_name)
          |                   ^~~~~~~~~
          |                   anon_vma
    .../linux/fs/proc/task_mmu.c:162:41: error: ‘struct vm_area_struct’ has no member named ‘anon_name’; did you mean ‘anon_vma’?
      162 |                 anon_vma_name_put(copy->anon_name);
          |                                         ^~~~~~~~~
          |                                         anon_vma
    .../linux/fs/proc/task_mmu.c: In function ‘put_vma_snapshot’:
    .../linux/fs/proc/task_mmu.c:174:18: error: ‘struct vm_area_struct’ has no member named ‘anon_name’; did you mean ‘anon_vma’?
      174 |         if (vma->anon_name)
          |                  ^~~~~~~~~
          |                  anon_vma
    .../linux/fs/proc/task_mmu.c:175:40: error: ‘struct vm_area_struct’ has no member named ‘anon_name’; did you mean ‘anon_vma’?
      175 |                 anon_vma_name_put(vma->anon_name);
          |                                        ^~~~~~~~~
          |                                        anon_vma

[...]


Thanks,
SJ

