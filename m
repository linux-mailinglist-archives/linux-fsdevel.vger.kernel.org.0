Return-Path: <linux-fsdevel+bounces-36389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE29E3090
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 01:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4791283439
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 00:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73D4C6E;
	Wed,  4 Dec 2024 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RNfxo4BL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA07F9;
	Wed,  4 Dec 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273804; cv=none; b=hva9o6KPd2aw2B3EOBM8tMZUNi+PKk8DBzoExrRs3N17erzC//eUZHD5wTuz4fvm9ueE8V9fl1mE1fCZGZVu2Z4qjlAflybkg2+sgCkk5b0iAeRaWYTDczYe+2rwUClcGs1dDer/awDYSNq/iPinWBh85/pT5ytwQxEdEEQDJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273804; c=relaxed/simple;
	bh=HnvD9nA5AHCdsg9zPRJracg67gYt4epRVs62bCOVlMA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RtyijWDWfQTbn9gnEU0YXDyEznzg3rnd3ETJ3ne/pvHQtXwXo4qwXhApJAF2eLE2K/UohgztBXCyA06WJtyUc+0wcweBSslLfHQ8FBk6MNjnWWLsko+x0qhCkaHDrKouHTkc8hX/B0NCYk0NIBdX/mW9QOpsomLIOMv82GNj1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RNfxo4BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B322CC4CEDC;
	Wed,  4 Dec 2024 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733273804;
	bh=HnvD9nA5AHCdsg9zPRJracg67gYt4epRVs62bCOVlMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RNfxo4BLUORttXowEY/7Lb2NtXEKxZtj3iKtvpYt/poJyguBqduECGWz1N8tINRAc
	 WFjnTjrJKroELMzVPc8mYFNNl19IFv9ErROqnFh+NvfCVS3OKh8glphGPD9Q2t9Rwf
	 kuaYEet47sLB+XbLGaCrMymvQZSx5TIoN6cnPVsg=
Date: Tue, 3 Dec 2024 16:56:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: <xu.xin16@zte.com.cn>
Cc: <david@redhat.com>, <linux-kernel@vger.kernel.org>,
 <wang.yaxin@zte.com.cn>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH linux-next v4] ksm: add ksm involvement information for
 each process
Message-Id: <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
In-Reply-To: <20241203192633836RVHhkoK1Amnqjt84D4Ryd@zte.com.cn>
References: <20241203192633836RVHhkoK1Amnqjt84D4Ryd@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 19:26:33 +0800 (CST) <xu.xin16@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> KSM_mergeable and KSM_merge_any. It helps administrators to
> better know the system's KSM behavior at process level.

It's hard for me to judge the usefulness of this.  Please tell us more:
usage examples, what actions have been taken using this information, etc.

> KSM_mergeable: yes/no
> 	whether any VMAs of the process'mm are currently applicable to KSM.

Could we simply display VM_MERGEABLE in /proc/<pid>/maps?

> KSM_merge_any: yes/no
> 	whether the process'mm is added by prctl() into the candidate list
> 	of KSM or not, and fully enabled at process level.
> 
> ...
>
>  fs/proc/base.c      | 11 +++++++++++
>  include/linux/ksm.h |  1 +
>  mm/ksm.c            | 19 +++++++++++++++++++

Documentation/admin-guide/mm/ksm.rst will require an update please.

>
> ...
>
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3269,6 +3269,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  				struct pid *pid, struct task_struct *task)
>  {
>  	struct mm_struct *mm;
> +	int ret = 0;
> 
>  	mm = get_task_mm(task);
>  	if (mm) {
> @@ -3276,6 +3277,16 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
>  		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>  		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
> +		seq_printf(m, "ksm_merge_any: %s\n",
> +				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
> +		ret = mmap_read_lock_killable(mm);

Could do the locking in ksm_process_mergeable()?

> +		if (ret) {
> +			mmput(mm);
> +			return ret;
> +		}
> +		seq_printf(m, "ksm_mergeable: %s\n",
> +				ksm_process_mergeable(mm) ? "yes" : "no");

Calling seq_printf() after the mmap_read_unlock() would be a little
more scalable.

> +		mmap_read_unlock(mm);
>  		mmput(mm);
>  	}
>
> ...
>
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3263,6 +3263,25 @@ static void wait_while_offlining(void)
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> 
>  #ifdef CONFIG_PROC_FS
> +/*
> + * The process is mergeable only if any VMA (and which) is currently
> + * applicable to KSM.

That sentence needs revisiting, please.

> + * The mmap lock must be held in read mode.
> + */
> +bool ksm_process_mergeable(struct mm_struct *mm)
> +{
> +	struct vm_area_struct *vma;
> +
> +	mmap_assert_locked(mm);
> +	VMA_ITERATOR(vmi, mm, 0);
> +	for_each_vma(vmi, vma)
> +		if (vma->vm_flags & VM_MERGEABLE)
> +			return true;
> +
> +	return false;
> +}


