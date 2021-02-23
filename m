Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A400322DB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhBWPkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhBWPkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614094725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEc8q6U0PvZdpT9f0rmyiAzpeP08z6HF0GSvezKfJ4M=;
        b=hcdmZgLEHMPJkjQRcrURifATbui//rDlz8N+Md5GJAEedST8G+lH9mNxWZbou/FQc8GVxF
        SCsWhPXIu717CG7zyth2Lhl6KsLlrqJarrgz8lE7z1wt28frGC9wy/fPCRPwnfVXhmA3Fo
        zcN6iN2FZOO8ylh9JsQdcVr+wWZWDbY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-UsH2gtDlN-GI9G3PZ7wb_w-1; Tue, 23 Feb 2021 10:38:43 -0500
X-MC-Unique: UsH2gtDlN-GI9G3PZ7wb_w-1
Received: by mail-qt1-f197.google.com with SMTP id i19so10268044qtx.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEc8q6U0PvZdpT9f0rmyiAzpeP08z6HF0GSvezKfJ4M=;
        b=n7pUmgnEhijn5JhpjuSLCSbw+2wtTiloDWhhAuCxjhIPmkSprpa57DbFzujevaZSqv
         i/Fv9PxNaHQmqDydg2EGWUsuKxMj86EiaqA7yX5/USdp71QoiLFMmUQfHhj3cMBN4Dx+
         k3W+rcQtFTUllVN+/QHB5BtMyyIdOasapJj15oi2iPQnI5mSg31GdOn8gjnn2B6Pggmv
         H9oN6V/7XxJJbz45PwIM/ejikwF+Wl6yD7VDNNVJURq+Npwj9J0LsGTbvam1Lmt6J8n+
         m2mDbaJ0973If6Pzl/QDf5i4BjVJHJjjNd6vKTIHWfye1NguSpSI4dNfTP6vuXtdGfVY
         BthA==
X-Gm-Message-State: AOAM531ayQbfJiI3sftvQZNGM/piVdwyoYq8S+HaymQ1RC+551VyUdT8
        88kvG1TZO4fFkMM0agNPdl/LXgjuk+7lCImPNXDEpZ9VuZ0wwFYbF6Bq1sD+jWcss+4EGimyPRT
        B14URlhTg69OfivDjkJUTOm7b3A==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr25023827qti.57.1614094723037;
        Tue, 23 Feb 2021 07:38:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2ox3wfwlm8jigspxM3yikHGpDC4/LFO1zOj6cnc9AkQazrG31gnHBzf4415QMybfSERLkIg==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr25023799qti.57.1614094722794;
        Tue, 23 Feb 2021 07:38:42 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id y15sm308813qth.52.2021.02.23.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:38:42 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:38:40 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v7 4/6] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210223153840.GB154711@xz-x1>
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219004824.2899045-5-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:48:22PM -0800, Axel Rasmussen wrote:
> @@ -4645,8 +4646,18 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	spinlock_t *ptl;
>  	int ret;
>  	struct page *page;
> +	int writable;
>  
> -	if (!*pagep) {
> +	mapping = dst_vma->vm_file->f_mapping;
> +	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> +
> +	if (is_continue) {
> +		ret = -EFAULT;
> +		page = find_lock_page(mapping, idx);
> +		*pagep = NULL;

Why set *pagep to NULL?  Shouldn't it be NULL always?.. If that's the case,
maybe WARN_ON_ONCE(*pagep) suite more.

Otherwise the patch looks good to me.

Thanks,

-- 
Peter Xu

