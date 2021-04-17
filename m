Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F83362DB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 06:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhDQEbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhDQEbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:31:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59CDC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 21:31:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so1676241otp.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 21:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=W6o2ooVTP+MnLQxjkPC27j4YkCmKuP7UZ0yTK+5vziU=;
        b=MYCnjeWCAOCBV2A5whTNGk1N7PjQZqQz5hw/cEWj0es8Lvi9HCoB/jo9UZl/iNHCZE
         mGlFBQZ3fCaE0zl2Dg2RFIG24iLMfOZyUXPjwwJwJfoMNjjKWhGErq//y7K35Y3ZjRZw
         0vq2XlJ0hQTSXW5SJVCkm95TrCP3SteqD8zvUGeveXpUxK2ozBn9IPcSTeuWu4PQNAPc
         lIoWUCQlgAUdRZnbhR9SI9fkKdhb0VCZU9cGAG0cjlJpEIyIHYtEd9asKEpyy0HE4siX
         SuZcgHO0c5DjIRbDGOcI5QPD3Wn57i9ClJSuAQMREGjGWXU73hd4OECPj7PffJQM63fA
         3wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=W6o2ooVTP+MnLQxjkPC27j4YkCmKuP7UZ0yTK+5vziU=;
        b=ImGatjoPRqUGbaCPLqIMLzZveURlt1s2Ds2t61TFGzBZo6Sn6v667ch7Q3eJ1jKmAn
         9qCpP/44ngnuSW9UGK+x4ddpuZ6/+7yMGGxSawA1q8gQPsz9WjLcFVnaPGzUvJQOmwLj
         +NsgWxlmsurnj4IbnJl3OoQwCwWIIH7crsiCxpKXyG6EgeozXqY0nlILVwrEqVyCTmCo
         tnn3vxy1zADMcdBDSUcUemSy6ujei9IiTuDmgJAMBAoFKN0SC8O5wsOeYqZ4HqjUOv8x
         odDKjXRiwZFGEhW24hnt3o//w6pNdG2g0G7ma/bIiFX12qdsrimq1oMjRuqo4QS+zugo
         rgOw==
X-Gm-Message-State: AOAM530uy/zwXpksRsY+mxDZ62eqTnUJxA0ohAHnBpP3MnohWDLMPQOX
        Hiptj7w3RI9aRVm0abM/4tzGng==
X-Google-Smtp-Source: ABdhPJyvYn8ZCtwckfRxXZNQrcGUemWroaDuXExJiCBU2JDLDPKzl1qtAgjmrur/IxHHTlF9XIhBhg==
X-Received: by 2002:a9d:5a1a:: with SMTP id v26mr5902631oth.50.1618633882669;
        Fri, 16 Apr 2021 21:31:22 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t25sm574797otp.4.2021.04.16.21.31.21
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 16 Apr 2021 21:31:22 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:31:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Collin Fijalkovich <cfijalkovich@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, songliubraving@fb.com,
        surenb@google.com, hridya@google.com, kaleshsingh@google.com,
        hughd@google.com, timmurray@google.com,
        william.kucharski@oracle.com, willy@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm, thp: Relax the VM_DENYWRITE constraint on
 file-backed THPs
In-Reply-To: <20210406000930.3455850-1-cfijalkovich@google.com>
Message-ID: <alpine.LSU.2.11.2104162117300.26825@eggly.anvils>
References: <20210406000930.3455850-1-cfijalkovich@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 5 Apr 2021, Collin Fijalkovich wrote:

> Transparent huge pages are supported for read-only non-shmem files,
> but are only used for vmas with VM_DENYWRITE. This condition ensures that
> file THPs are protected from writes while an application is running
> (ETXTBSY).  Any existing file THPs are then dropped from the page cache
> when a file is opened for write in do_dentry_open(). Since sys_mmap
> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> produced by execve().
> 
> Systems that make heavy use of shared libraries (e.g. Android) are unable
> to apply VM_DENYWRITE through the dynamic linker, preventing them from
> benefiting from the resultant reduced contention on the TLB.
> 
> This patch reduces the constraint on file THPs allowing use with any
> executable mapping from a file not opened for write (see
> inode_is_open_for_write()). It also introduces additional conditions to
> ensure that files opened for write will never be backed by file THPs.
> 
> Restricting the use of THPs to executable mappings eliminates the risk that
> a read-only file later opened for write would encounter significant
> latencies due to page cache truncation.
> 
> The ld linker flag '-z max-page-size=(hugepage size)' can be used to
> produce executables with the necessary layout. The dynamic linker must
> map these file's segments at a hugepage size aligned vma for the mapping to
> be backed with THPs.
> 
> Comparison of the performance characteristics of 4KB and 2MB-backed
> libraries follows; the Android dex2oat tool was used to AOT compile an
> example application on a single ARM core.
> 
> 4KB Pages:
> ==========
> 
> count              event_name            # count / runtime
> 598,995,035,942    cpu-cycles            # 1.800861 GHz
>  81,195,620,851    raw-stall-frontend    # 244.112 M/sec
> 347,754,466,597    iTLB-loads            # 1.046 G/sec
>   2,970,248,900    iTLB-load-misses      # 0.854122% miss rate
> 
> Total test time: 332.854998 seconds.
> 
> 2MB Pages:
> ==========
> 
> count              event_name            # count / runtime
> 592,872,663,047    cpu-cycles            # 1.800358 GHz
>  76,485,624,143    raw-stall-frontend    # 232.261 M/sec
> 350,478,413,710    iTLB-loads            # 1.064 G/sec
>     803,233,322    iTLB-load-misses      # 0.229182% miss rate
> 
> Total test time: 329.826087 seconds
> 
> A check of /proc/$(pidof dex2oat64)/smaps shows THPs in use:
> 
> /apex/com.android.art/lib64/libart.so
> FilePmdMapped:      4096 kB
> 
> /apex/com.android.art/lib64/libart-compiler.so
> FilePmdMapped:      2048 kB
> 
> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

and you also won

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

in the v1 thread.

I had hoped to see a more dramatic difference in the numbers above,
but I'm a performance naif, and presume other loads and other
libraries may show further benefit.

> ---
> Changes v1 -> v2:
> * commit message 'non-shmem filesystems' -> 'non-shmem files'
> * Add performance testing data to commit message
> 
>  fs/open.c       | 13 +++++++++++--
>  mm/khugepaged.c | 16 +++++++++++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..f76e960d10ea 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
>  	 * XXX: Huge page cache doesn't support writing yet. Drop all page
>  	 * cache for this file before processing writes.
>  	 */
> -	if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
> -		truncate_pagecache(inode, 0);
> +	if (f->f_mode & FMODE_WRITE) {
> +		/*
> +		 * Paired with smp_mb() in collapse_file() to ensure nr_thps
> +		 * is up to date and the update to i_writecount by
> +		 * get_write_access() is visible. Ensures subsequent insertion
> +		 * of THPs into the page cache will fail.
> +		 */
> +		smp_mb();
> +		if (filemap_nr_thps(inode->i_mapping))
> +			truncate_pagecache(inode, 0);
> +	}
>  
>  	return 0;
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a7d6cb912b05..4c7cc877d5e3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  
>  	/* Read-only file mappings need to be aligned for THP to work. */
>  	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> -	    (vm_flags & VM_DENYWRITE)) {
> +	    !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +	    (vm_flags & VM_EXEC)) {
>  		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>  				HPAGE_PMD_NR);
>  	}
> @@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
>  	else {
>  		__mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
>  		filemap_nr_thps_inc(mapping);
> +		/*
> +		 * Paired with smp_mb() in do_dentry_open() to ensure
> +		 * i_writecount is up to date and the update to nr_thps is
> +		 * visible. Ensures the page cache will be truncated if the
> +		 * file is opened writable.
> +		 */
> +		smp_mb();
> +		if (inode_is_open_for_write(mapping->host)) {
> +			result = SCAN_FAIL;
> +			__mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
> +			filemap_nr_thps_dec(mapping);
> +			goto xa_locked;
> +		}
>  	}
>  
>  	if (nr_none) {
> -- 
> 2.31.0.208.g409f899ff0-goog
