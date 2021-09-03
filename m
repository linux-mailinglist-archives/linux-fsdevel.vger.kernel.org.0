Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809BC4007DE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 00:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhICWWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 18:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhICWWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:22:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4B7C061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 15:21:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x19so593709pfu.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z6Ahe3HyFCsln3WxhiPzlBdzSMzmQy1MoB9r0kQJYjY=;
        b=j+i4OnKQlx67qf6KsGGrXn+kDIVbopkXPqg29WuanGw7D+NxxpUfn+yNtPO3lEjAlq
         IC+p3mgGgnWHwDwxvLzVWdG4G9j3wn6czhDnEmn2BCIcsFo5+Pljd/R4gG4PpcE5j/Lw
         n3fNJJKD0jBLyuMESbHVez1HBAiBgQ+3l0nAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6Ahe3HyFCsln3WxhiPzlBdzSMzmQy1MoB9r0kQJYjY=;
        b=nBlyCI0GVDi0hztTBnhHzHXVMw/UEtLhvwulrsKeGkcb/1utQQIINnWI9JguC1g0lD
         KC6UBa+bLkmysNf7t8rGmD9e/rOnvmR1f43/VxNQAIPazzPO9WmC45Fe31wKzAFc56lu
         gFUURl66q+MW05uziruT9O89x8ZxSTIcULdJ6l+khNTcxJW3MAUK2c2GlYB+S73PpjkM
         sP8r7uiaZRsllO4XucYKWvLMFsEHlyqW8hstJbDvlHb+oeXPvKSk5O2OTPIAx4OD4a+I
         zKcJo3b/XOGk15g2TjX29g8KLhPqSXJB9dRYvg84uIxQCTFfk8mQlAonrrmj+bpfzJ5f
         D+JQ==
X-Gm-Message-State: AOAM531l8cdtvmzsu+KgxXz4qsL9lLdON19ASJvalUzHwLrwBhYTQkaF
        11hoCYUdKB1UklGK/4VSDLs/Ew==
X-Google-Smtp-Source: ABdhPJyWCdRDESu1+RloArQDnrUNo5Gz+AwhyFui33D17W9ipNom5uKCB8s4H5hAYBrPJBoGl295nA==
X-Received: by 2002:a63:4610:: with SMTP id t16mr1059608pga.176.1630707660544;
        Fri, 03 Sep 2021 15:21:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm319586pfm.208.2021.09.03.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 15:20:59 -0700 (PDT)
Date:   Fri, 3 Sep 2021 15:20:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        willy@infradead.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v9 3/3] mm: add anonymous vma name refcounting
Message-ID: <202109031450.CDA7090A@keescook>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902231813.3597709-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 04:18:13PM -0700, Suren Baghdasaryan wrote:
> While forking a process with high number (64K) of named anonymous vmas the
> overhead caused by strdup() is noticeable. Experiments with ARM64 Android
> device show up to 40% performance regression when forking a process with
> 64k unpopulated anonymous vmas using the max name lengths vs the same
> process with the same number of anonymous vmas having no name.
> Introduce anon_vma_name refcounted structure to avoid the overhead of
> copying vma names during fork() and when splitting named anonymous vmas.
> When a vma is duplicated, instead of copying the name we increment the
> refcount of this structure. Multiple vmas can point to the same
> anon_vma_name as long as they increment the refcount. The name member of
> anon_vma_name structure is assigned at structure allocation time and is
> never changed. If vma name changes then the refcount of the original
> structure is dropped, a new anon_vma_name structure is allocated
> to hold the new name and the vma pointer is updated to point to the new
> structure.
> With this approach the fork() performance regressions is reduced 3-4x
> times and with usecases using more reasonable number of VMAs (a few
> thousand) the regressions is not measurable.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> previous version including cover letter with test results is at:
> https://lore.kernel.org/linux-mm/20210827191858.2037087-1-surenb@google.com/
> 
> changes in v9
> - Replaced kzalloc with kmalloc in anon_vma_name_alloc, per Rolf Eike Beer
> 
>  include/linux/mm_types.h |  9 ++++++++-
>  mm/madvise.c             | 43 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 968a1d0463d8..7feb43daee6c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -5,6 +5,7 @@
>  #include <linux/mm_types_task.h>
>  
>  #include <linux/auxvec.h>
> +#include <linux/kref.h>
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
>  #include <linux/rbtree.h>
> @@ -310,6 +311,12 @@ struct vm_userfaultfd_ctx {
>  struct vm_userfaultfd_ctx {};
>  #endif /* CONFIG_USERFAULTFD */
>  
> +struct anon_vma_name {
> +	struct kref kref;
> +	/* The name needs to be at the end because it is dynamically sized. */
> +	char name[];
> +};
> +
>  /*
>   * This struct describes a virtual memory area. There is one of these
>   * per VM-area/task. A VM area is any part of the process virtual memory
> @@ -361,7 +368,7 @@ struct vm_area_struct {
>  			unsigned long rb_subtree_last;
>  		} shared;
>  		/* Serialized by mmap_sem. */
> -		char *anon_name;
> +		struct anon_vma_name *anon_name;
>  	};
>  
>  	/*
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0c6d0f64d432..adc53edd3fe7 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -63,6 +63,28 @@ static int madvise_need_mmap_write(int behavior)
>  	}
>  }
>  
> +static struct anon_vma_name *anon_vma_name_alloc(const char *name)
> +{
> +	struct anon_vma_name *anon_name;
> +	size_t len = strlen(name);
> +
> +	/* Add 1 for NUL terminator at the end of the anon_name->name */
> +	anon_name = kmalloc(sizeof(*anon_name) + len + 1, GFP_KERNEL);
> +	if (anon_name) {
> +		kref_init(&anon_name->kref);
> +		strcpy(anon_name->name, name);

Please don't use strcpy(), even though we know it's safe here. We're
trying to remove it globally (or at least for non-constant buffers)[1].
We can also use the struct_size() helper, along with memcpy():

	/* Add 1 for NUL terminator at the end of the anon_name->name */
	size_t count = strlen(name) + 1;

	anon_name = kmalloc(struct_size(anon_name, name, count), GFP_KERNEL);
	if (anon_name) {
		kref_init(&anon_name->kref);
		memcpy(anon_name->name, name, count);
	}

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

> +	}
> +
> +	return anon_name;
> +}
> +
> +static void vma_anon_name_free(struct kref *kref)
> +{
> +	struct anon_vma_name *anon_name =
> +			container_of(kref, struct anon_vma_name, kref);
> +	kfree(anon_name);
> +}
> +
>  static inline bool has_vma_anon_name(struct vm_area_struct *vma)
>  {
>  	return !vma->vm_file && vma->anon_name;
> @@ -75,7 +97,7 @@ const char *vma_anon_name(struct vm_area_struct *vma)
>  
>  	mmap_assert_locked(vma->vm_mm);
>  
> -	return vma->anon_name;
> +	return vma->anon_name->name;
>  }
>  
>  void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> @@ -84,37 +106,44 @@ void dup_vma_anon_name(struct vm_area_struct *orig_vma,
>  	if (!has_vma_anon_name(orig_vma))
>  		return;
>  
> -	new_vma->anon_name = kstrdup(orig_vma->anon_name, GFP_KERNEL);
> +	kref_get(&orig_vma->anon_name->kref);
> +	new_vma->anon_name = orig_vma->anon_name;
>  }
>  
>  void free_vma_anon_name(struct vm_area_struct *vma)
>  {
> +	struct anon_vma_name *anon_name;
> +
>  	if (!has_vma_anon_name(vma))
>  		return;
>  
> -	kfree(vma->anon_name);
> +	anon_name = vma->anon_name;
>  	vma->anon_name = NULL;
> +	kref_put(&anon_name->kref, vma_anon_name_free);
>  }
>  
>  /* mmap_lock should be write-locked */
>  static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
>  {
> +	const char *anon_name;
> +
>  	if (!name) {
>  		free_vma_anon_name(vma);
>  		return 0;
>  	}
>  
> -	if (vma->anon_name) {
> +	anon_name = vma_anon_name(vma);
> +	if (anon_name) {
>  		/* Should never happen, to dup use dup_vma_anon_name() */
> -		WARN_ON(vma->anon_name == name);
> +		WARN_ON(anon_name == name);
>  
>  		/* Same name, nothing to do here */
> -		if (!strcmp(name, vma->anon_name))
> +		if (!strcmp(name, anon_name))
>  			return 0;
>  
>  		free_vma_anon_name(vma);
>  	}
> -	vma->anon_name = kstrdup(name, GFP_KERNEL);
> +	vma->anon_name = anon_vma_name_alloc(name);
>  	if (!vma->anon_name)
>  		return -ENOMEM;
>  
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 

With the above tweak, please consider this:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for working on this!

-- 
Kees Cook
