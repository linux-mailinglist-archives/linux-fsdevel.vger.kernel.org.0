Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB33FA7A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 23:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhH1V32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 17:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhH1V31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:29:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CAC061756;
        Sat, 28 Aug 2021 14:28:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m4so18209113ljq.8;
        Sat, 28 Aug 2021 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXM23t7nGqJTGllQ0GBo3dDWWAdzVbWZALkyemvhWNo=;
        b=YO9S1CFPlYJXAsTzQEafWFpbtOf5hUDAUwwUDT6po2a6SrE4m/UaIhw+YovOop+y/8
         3zEPZWSEpENbiTKkvzsaIqWMkahjmgO5s+mB3dT/j+GtvX58cEEbFW2Mbk99VjPMyYZg
         mI+W4uJjaEwa83Tue6rQc6P5Rnk/AeUI+U9z1M3+8zxE8R893EoaFLhn/w3SCrQ/xmD8
         yd1umBxzRx8IaLfLbIcaMf9+mUpQ8v1vT+1WfHDshQgyzWRGCScShh3BJg5puQ/+dgcM
         FnK1xYckrS5f7Hy0ZzBHagJgEL4g8S31rneCVsFGG8ccwa5CfBAlwpGE/p4AsDetysOv
         Lojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXM23t7nGqJTGllQ0GBo3dDWWAdzVbWZALkyemvhWNo=;
        b=eIjCx40h5mnmPjfihJp5q3TcHXbY+rYw/TQu+SLkHuNeYk1vQF81J/6K0Mr8c6nlrM
         XpHLJOe2oSvZsBbyMWlSUbmouRS4a9HTWRu9IF+pKq92fBHxkVXYFiysY6jFN1W/3aH4
         NcnbvzXWOBuYwdYJ0r0rSC3+kTBhu41PkoyqWLjI9k8fbUtDS/9wQKh/D1PzrAY+0la+
         fcTlwyvjPoDJQBXAVYcmsMM4k092HQksAsS9U3fgkA+qdMWpnh7LUXEvrRNS0TzcfaGd
         R8rJnVrG8vmBeOkbjg2ReE1K0DhNEA8NP85zxgxObvUxpBZwdX5yHe2aZZSVU4KBpj93
         iFHw==
X-Gm-Message-State: AOAM5307PN8XreOPGTWXKZOUxG9Y25x82gWbbvWUvKzFZeiGquhCA67X
        2ghv10j9yX+5psdM7UTFtoQ=
X-Google-Smtp-Source: ABdhPJxEQbKglQZ/sIqsMfNEKtgB/wPaaCRyWOxraQzixjbdnPWF4zSNUzJOVcUYPxwIPDYxrr9jjg==
X-Received: by 2002:a2e:804a:: with SMTP id p10mr13718369ljg.216.1630186114923;
        Sat, 28 Aug 2021 14:28:34 -0700 (PDT)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id bp10sm1045767lfb.130.2021.08.28.14.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 14:28:33 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id D5EE95A001E; Sun, 29 Aug 2021 00:28:32 +0300 (MSK)
Date:   Sun, 29 Aug 2021 00:28:32 +0300
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
        kernel-team@android.com
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YSqqgJ7EC6PO9ggO@grain>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-3-surenb@google.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:18:57PM -0700, Suren Baghdasaryan wrote:
> 
> The name is stored in a pointer in the shared union in vm_area_struct
> that points to a null terminated string. Anonymous vmas with the same
> name (equivalent strings) and are otherwise mergeable will be merged.
> The name pointers are not shared between vmas even if they contain the
> same name. The name pointer is stored in a union with fields that are
> only used on file-backed mappings, so it does not increase memory usage.
> 
> The patch is based on the original patch developed by Colin Cross, more
> specifically on its latest version [1] posted upstream by Sumit Semwal.
> It used a userspace pointer to store vma names. In that design, name
> pointers could be shared between vmas. However during the last upstreaming
> attempt, Kees Cook raised concerns [2] about this approach and suggested
> to copy the name into kernel memory space, perform validity checks [3]
> and store as a string referenced from vm_area_struct.
> One big concern is about fork() performance which would need to strdup
> anonymous vma names. Dave Hansen suggested experimenting with worst-case
> scenario of forking a process with 64k vmas having longest possible names
> [4]. I ran this experiment on an ARM64 Android device and recorded a
> worst-case regression of almost 40% when forking such a process. This
> regression is addressed in the followup patch which replaces the pointer
> to a name with a refcounted structure that allows sharing the name pointer
> between vmas of the same name. Instead of duplicating the string during
> fork() or when splitting a vma it increments the refcount.
> 
> [1] https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.semwal@linaro.org/
> [2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
> [3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook/
> [4] https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a8e95@intel.com/
...
> +
> +/* mmap_lock should be read-locked */
> +static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
> +					 const char *name)
> +{
> +	const char *vma_name = vma_anon_name(vma);
> +
> +	if (likely(!vma_name))
> +		return name == NULL;
> +
> +	return name && !strcmp(name, vma_name);
> +}

Hi Suren! There is very important moment with this new feature: if
we assign a name to some VMA it won't longer be mergeable even if
near VMA matches by all other attributes such as flags, permissions
and etc. I mean our vma_merge() start considering the vma namings
and names mismatch potentially blocks merging which happens now
without this new feature. Is it known behaviour or I miss something
pretty obvious here?
