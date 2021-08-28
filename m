Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA83FA6C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhH1QUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhH1QUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 12:20:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A40C061756;
        Sat, 28 Aug 2021 09:20:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j4so21247836lfg.9;
        Sat, 28 Aug 2021 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJjlhL+wu+SZnMSpzSjNoshjgIUDvLy0pU8sVpAAjyY=;
        b=u+8fDKLkjfXLvVTs0dE+JFc9+I0FiO54/wmMk8th90CEiOgkFBAGh/5xcM745TSfJl
         inKBOUjhDchGvwYvSC8CiN9D2QMegqM2VctXyKdTWd+1ETeVNzWxLg6mTjYtOQLkFPY2
         8V/MIBPhQ+aeuqBJbDHbFqUlHSkTQUlUjDjk/PUjQSn8ILEFLSa/UDH4Xb65BRlRTei1
         Nyjiuj+e49LRy1YzLMmP3pZKM7ln1AHyWy8Fn3BJjL3aF3y4t5Zq/GW7LqWoyF18YtW7
         3gzXdINIcDHYPAQg1YnyGP6JKkV/9BMOrNZCjrl382MqJ5mEkVwX/U3xaYMJXVL9gCnK
         u0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJjlhL+wu+SZnMSpzSjNoshjgIUDvLy0pU8sVpAAjyY=;
        b=Dxsv9b6w6c+YXZ95jdBtx0VH6cO2kQ+BN9h1fiqCcx+6Nxh1KevJHv+Wzr9XFYY+1u
         TKUqpLJ+0sAtEONnUwjF0ilIP/DcCaJJfEDmc39R+NyPadUPA9+hTkXwj9qCZPYQ11L+
         vOc8eGVSlRAAk4ijHJ/w4B44XSJAmGi3+CosVgLRCsXslgGEQj2iH1s2jFxsrUDxySU3
         tFPF9MzdUfEHwQblq41igziIaHwVGL72/q63D3ujl3xEtPHAmQGhHjWUIWIQXt/srIOM
         k4/QZQ9GwacBQc/SAc7p0GTD+kl7sG2gZVsb3gS2Owd0t1xOjExUEpZVX6A1nFLvI5lU
         zPMQ==
X-Gm-Message-State: AOAM530WE3XhlY5/30Vyeey/8UTPI3aC5gIDIDkdDluJPTUs2ddWozNE
        5CRYSF/rhal1eAzQnooVgnP5SJSaLNBoY8L0
X-Google-Smtp-Source: ABdhPJzfh+dxaICrJfAx6dLlrn8Z1XpeCZJoqq0RHWXeE2d91rOegZX5mq6FdOUmaoPNHiKdU+T1dA==
X-Received: by 2002:a19:6a16:: with SMTP id u22mr10838618lfu.493.1630167599317;
        Sat, 28 Aug 2021 09:19:59 -0700 (PDT)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id m1sm244759lfc.144.2021.08.28.09.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 09:19:59 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id AC9EF5A001E; Sat, 28 Aug 2021 19:19:46 +0300 (MSK)
Date:   Sat, 28 Aug 2021 19:19:46 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
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
        kernel-team@android.com, Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Tang Chen <tangchen@cn.fujitsu.com>, Robin Holt <holt@sgi.com>,
        Shaohua Li <shli@fusionio.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v8 1/3] mm: rearrange madvise code to allow for reuse
Message-ID: <YSpiIrQKs5RUccYk@grain>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-2-surenb@google.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:18:56PM -0700, Suren Baghdasaryan wrote:
...
>  
> +/*
> + * Apply an madvise behavior to a region of a vma.  madvise_update_vma
> + * will handle splitting a vm area into separate areas, each area with its own
> + * behavior.
> + */
> +static int madvise_vma_behavior(struct vm_area_struct *vma,
> +				struct vm_area_struct **prev,
> +				unsigned long start, unsigned long end,
> +				unsigned long behavior)
> +{
> +	int error = 0;


Hi Suren! A nitpick -- this variable is never used with default value
so I think we could drop assignment here.
...
> +	case MADV_DONTFORK:
> +		new_flags |= VM_DONTCOPY;
> +		break;
> +	case MADV_DOFORK:
> +		if (vma->vm_flags & VM_IO) {
> +			error = -EINVAL;

We can exit early here, without jumping to the end of the function, right?

> +			goto out;
> +		}
> +		new_flags &= ~VM_DONTCOPY;
> +		break;
> +	case MADV_WIPEONFORK:
> +		/* MADV_WIPEONFORK is only supported on anonymous memory. */
> +		if (vma->vm_file || vma->vm_flags & VM_SHARED) {
> +			error = -EINVAL;

And here too.

> +			goto out;
> +		}
> +		new_flags |= VM_WIPEONFORK;
> +		break;
> +	case MADV_KEEPONFORK:
> +		new_flags &= ~VM_WIPEONFORK;
> +		break;
> +	case MADV_DONTDUMP:
> +		new_flags |= VM_DONTDUMP;
> +		break;
> +	case MADV_DODUMP:
> +		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
> +			error = -EINVAL;

Same.

> +			goto out;
> +		}
> +		new_flags &= ~VM_DONTDUMP;
> +		break;
> +	case MADV_MERGEABLE:
> +	case MADV_UNMERGEABLE:
> +		error = ksm_madvise(vma, start, end, behavior, &new_flags);
> +		if (error)
> +			goto out;
> +		break;
> +	case MADV_HUGEPAGE:
> +	case MADV_NOHUGEPAGE:
> +		error = hugepage_madvise(vma, &new_flags, behavior);
> +		if (error)
> +			goto out;
> +		break;
> +	}
> +
> +	error = madvise_update_vma(vma, prev, start, end, new_flags);
> +
> +out:

I suppose we better keep the former comment on why we maps ENOMEM to EAGAIN?

	Cyrill
