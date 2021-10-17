Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282664306A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Oct 2021 06:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbhJQEiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Oct 2021 00:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhJQEit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Oct 2021 00:38:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C59CC061765;
        Sat, 16 Oct 2021 21:36:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e65so10217808pgc.5;
        Sat, 16 Oct 2021 21:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SImy2fbcQmbj25MrY7ik0EFCmAboOoUt1YB+3+8VGO8=;
        b=lFCJuu9LrILjtoPrk1zBQpWcp9vJRNvOa+SyJTdWQ8C5KJlBaAd2sQU2StKnWNw/OM
         bpi8yFIrF8VWI3nRawpu+BGTr055AM9IQxQnro4ogPPI34ge1JIV86eFQufDn/E0r6Do
         Q9k690msW5z4pfT23CYYt7qjeFsUDcZqPhvi+4RWPVk4R4N8BinB+rKvPyee5QIAAp1O
         AAA+eLcvobbseZaK4Dfl/8wrgEfemy1Zz4Zm0MF8sxxkId/G0qdCDDt6tFw+pa9HpqD3
         MuxeeMnzQ0e3+o/Sh5fymLZgYZOoyzLvcaiMp9yDz6EeWsJnuDvrgrO+HsVQax7oUqfE
         msDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SImy2fbcQmbj25MrY7ik0EFCmAboOoUt1YB+3+8VGO8=;
        b=iPy8yxO2WWmw8zJ8+mnP3COitlgAYrCtoSAC8EEzehPIhQCpy3++cMAcohzKQCVzUn
         uKCUc1d0RT68/V5EP1Whx/FftLbRGokoAS2yAOiRFKYQPc7P2MrPtnsYfxErThWRZ3Ic
         k/sGgeDzIC9Yfqx5jx73NBLb+i4hf4fLQ07q1emXtQzND213rOdVEUfx+6/PJCFsFwE2
         joPwSj1fZDSxiGBYKMkhGQXY1q7qXgN22U/LZUcE+ZobSZUdwxhPWEZzE1WNSrH3+9Nz
         NlVNjPXjdEY0w0hOhapbcko4YqdrXhLEilRVPO/yXPXIuYM2KpdiequQicZz1qNfuahz
         aPFQ==
X-Gm-Message-State: AOAM531SbheWe0civtikrvWZv9EthDMvBKlDfAivnTQv94nVDfbi/ZLR
        SREEeXafVJ5hfaa6oTO4/CahGof/XZU=
X-Google-Smtp-Source: ABdhPJyLHqLBFnf6Z6mcJfPemM50Ww8flUSGee23fVZyaHVq8qP45fcNC0+vXR8DV8KvwYzfUms7Xg==
X-Received: by 2002:a62:84d5:0:b0:44d:7cf:e6dc with SMTP id k204-20020a6284d5000000b0044d07cfe6dcmr20795903pfd.12.1634445399458;
        Sat, 16 Oct 2021 21:36:39 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id e9sm9222768pjl.41.2021.10.16.21.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 21:36:39 -0700 (PDT)
Date:   Sun, 17 Oct 2021 04:36:35 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Unit mismatch (Slab/SReclaimable/SUnreclaim) in meminfo
Message-ID: <20211017043635.GB3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211016115429.17226-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016115429.17226-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 16, 2021 at 11:54:29AM +0000, Hyeonggon Yoo wrote:
> Hello, it seems there's mismatch in unit (byte and kB) in meminfo.
> Would something like this will be acceptable?
> 
> commit d42f3245c7e2 ("mm: memcg: convert vmstat slab counters
> to bytes") changed it to bytes but proc seems to print everything in
> kilobytes.
> 

Ignore this.

this was my misunderstanding of code :(
It internally converts to kilobytes when updating its data.

> ---
>  fs/proc/meminfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..182376582076 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -52,8 +52,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
>  
>  	available = si_mem_available();
> -	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> -	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> +	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) / 1024;
> +	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) / 1024;
>  
>  	show_val_kb(m, "MemTotal:       ", i.totalram);
>  	show_val_kb(m, "MemFree:        ", i.freeram);
> -- 
> 2.27.0
> 
