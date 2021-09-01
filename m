Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B23FD4EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbhIAIKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 04:10:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbhIAIKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:10:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 611A720297;
        Wed,  1 Sep 2021 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630483765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DdzSE7BCCcPraxiLuEKrcJ+XK47RRhp4XBmGdfag4no=;
        b=OfTL8XUorxFNEHyBlAvuoICTsf3IdOGyj9zaWeFE8z4xH/SeYsvC5Z6ZgNebhVDgLaWtCq
        eHrPUyaNE16I+TcePG+D/bXPhPgWsrq/gvIwRz/TgBmwtNmTUPZEewEhs7P8cT7akxZmzY
        FpDSq7uWpc5mBkOp9XmJchBYvpUf0XI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A7FBA3BA5;
        Wed,  1 Sep 2021 08:09:24 +0000 (UTC)
Date:   Wed, 1 Sep 2021 10:09:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YS81MDMgrL1tpcN7@dhcp22.suse.cz>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-08-21 12:18:57, Suren Baghdasaryan wrote:
[...]
> Userspace can set the name for a region of memory by calling
> prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, start, len, (unsigned long)name);
> Setting the name to NULL clears it.

Maybe I am missing this part but I do not see this being handled
anywhere.

[...]
> @@ -3283,5 +3283,16 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ADVISE_SYSCALLS
> +int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> +			  unsigned long len_in, const char *name);
> +#else
> +static inline int
> +madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> +		      unsigned long len_in, const char *name) {
> +	return 0;
> +}
> +#endif

You want to make this depend on CONFIG_PROC_FS.

[...]
> +#ifdef CONFIG_MMU
> +
> +#define ANON_VMA_NAME_MAX_LEN	64
> +
> +static int prctl_set_vma(unsigned long opt, unsigned long addr,
> +			 unsigned long size, unsigned long arg)
> +{
> +	struct mm_struct *mm = current->mm;
> +	char *name, *pch;
> +	int error;
> +
> +	switch (opt) {
> +	case PR_SET_VMA_ANON_NAME:
> +		name = strndup_user((const char __user *)arg,
> +				    ANON_VMA_NAME_MAX_LEN);
> +
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);

unless I am missing something NULL name would lead to an error rather
than a name clearing as advertised above.

> +
> +		for (pch = name; *pch != '\0'; pch++) {
> +			if (!isprint(*pch)) {
> +				kfree(name);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		mmap_write_lock(mm);
> +		error = madvise_set_anon_name(mm, addr, size, name);
> +		mmap_write_unlock(mm);
> +		kfree(name);
> +		break;
> +	default:
> +		error = -EINVAL;
> +	}
> +
> +	return error;
-- 
Michal Hocko
SUSE Labs
