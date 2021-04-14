Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79BA35ED66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDNGoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbhDNGoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:44:19 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E63C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 23:43:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so20500839qkb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 23:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xAItGVctj4Ym5XgJXrEHjFWuIEiXbFDkgH2LTVJTlqw=;
        b=boogogHOP6aMxYaO4TKu7w6/UT0zb6tK49kFGEqd/tGljpv/chIVdkvDoZiKgvcWl3
         uD72xEs3pGMozk801LATYIGOzSooQdo333X4M4rD3PNeWeoZ9/oX6LUPDbjvhVvQyG6/
         nTt5wmIPnMoq8lxe0TYVtm4DE/rQlDzKDa0fCpcwtw5WUsLaifXWcqsMidIkzaY8/9og
         +s8FqQNRmO6BXRBVpR03kz2epvzqQrKFmi5Hh/Dr9nzx9eIzWvOC83DKTQkse5T5QfKN
         OwqGrAsqVhMbFN/3vaxP0hsIwcf4UGB3beOYirKF+LBu4y8XLIbOcMpkmguDaeVt3yZa
         ZVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xAItGVctj4Ym5XgJXrEHjFWuIEiXbFDkgH2LTVJTlqw=;
        b=Q5Oil9ac5L0ut79Dl2fBAn68+bazoFhT2xpLKRS/KVkBBwFI427D8vGexWEB4A8HbT
         1LQsN8t8tyTB38buUbQfXE0LzepSe9cjrDC+zKiIcWA4giBI2vYzPgaVwkHI8vzRSYbe
         yUD0BcfD9nM58pSwyfS17rVLI+fRSRCEV17vBmpWLZYO7VmLXg4pn3DWkNVzswplk7T8
         RQcjJ4UmlddvV9z0U7CT+dNgbzc4bNVGPxuNCiuCT8l+bl2GRwJT16FvkISJuNqRHXee
         drL6Afy+Qw0cTzpzAvwhUAziKPtMq/FKIpoq6P6yJ0DMJl7X055gkhyrjnuHo7u/jhEj
         kbkQ==
X-Gm-Message-State: AOAM533i/7YQU1/Uw97VXYaotBaTXVlb4j/duGAAau2N+2oMbl4peTEF
        UpOqL5doytOb9/cKyxAoRXIKgg==
X-Google-Smtp-Source: ABdhPJyCbITTz5lmswPHeW0wVM8gnjbv6Zo4xmnNDnf/pa88GLZJNPjvZPoeIsTQcCXPoW3nk85tvw==
X-Received: by 2002:ae9:e113:: with SMTP id g19mr34615511qkm.480.1618382637457;
        Tue, 13 Apr 2021 23:43:57 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x22sm5174625qtq.93.2021.04.13.23.43.55
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 13 Apr 2021 23:43:57 -0700 (PDT)
Date:   Tue, 13 Apr 2021 23:43:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 1/9] userfaultfd/hugetlbfs: avoid including userfaultfd_k.h
 in hugetlb.h
In-Reply-To: <20210413051721.2896915-2-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104132336001.9086@eggly.anvils>
References: <20210413051721.2896915-1-axelrasmussen@google.com> <20210413051721.2896915-2-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Apr 2021, Axel Rasmussen wrote:

> Minimizing header file inclusion is desirable. In this case, we can do
> so just by forward declaring the enumeration our signature relies upon.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/hugetlb.h | 4 +++-
>  mm/hugetlb.c            | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 09f1fd12a6fa..3f47650ab79b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -11,7 +11,6 @@
>  #include <linux/kref.h>
>  #include <linux/pgtable.h>
>  #include <linux/gfp.h>
> -#include <linux/userfaultfd_k.h>
>  
>  struct ctl_table;
>  struct user_struct;
> @@ -135,6 +134,8 @@ void hugetlb_show_meminfo(void);
>  unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
> +
> +enum mcopy_atomic_mode;

Wrongly placed: the CONFIG_USERFAULTFD=y CONFIG_HUGETLB_PAGE=n build
fails. Better place it up above with struct ctl_table etc.

>  #ifdef CONFIG_USERFAULTFD
>  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
>  				struct vm_area_struct *dst_vma,
> @@ -143,6 +144,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
>  				enum mcopy_atomic_mode mode,
>  				struct page **pagep);
>  #endif /* CONFIG_USERFAULTFD */
> +
>  bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						struct vm_area_struct *vma,
>  						vm_flags_t vm_flags);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 54d81d5947ed..b1652e747318 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -40,6 +40,7 @@
>  #include <linux/hugetlb_cgroup.h>
>  #include <linux/node.h>
>  #include <linux/page_owner.h>
> +#include <linux/userfaultfd_k.h>
>  #include "internal.h"
>  
>  int hugetlb_max_hstate __read_mostly;
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
> 
