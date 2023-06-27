Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A1740013
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjF0Puv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjF0Puj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC982D4B
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687880993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWk97apVhyJHDonX03+ZEK7CdXKLu5yLLv7Ry7RwGo0=;
        b=QI+njb1EtRKxjAOKbJbDhAle9PDzUOjg7OF9vH98T+r/0+i4cv9ummNEcUupGq7uYX+BG+
        TWoR6FZxsI0dt9KhAS8NrjFM+on7sWttTaPZFXMUewS+mKOIuEVToG2owXV4DoCeBqb1ZQ
        kXj8k7sO8G9kEwm6LXzN9A9znm6lt1Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-UzjC4oLTOlGm4vslpiCfFw-1; Tue, 27 Jun 2023 11:49:52 -0400
X-MC-Unique: UzjC4oLTOlGm4vslpiCfFw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62dd79f63e0so8012296d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687880992; x=1690472992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWk97apVhyJHDonX03+ZEK7CdXKLu5yLLv7Ry7RwGo0=;
        b=b6oPUhL1keyZ+zLqm7Z1PnKf8VtUDw1FUWtFdr4lN9kQcsmm2dYvDhfPfWKR+LIvvO
         zXIl+L90pwRvQaGmVzvEYVX7p6fi3/xJHsXeQ9Nso3T84YMB/xK6MeDHc3Ok3cWBPgnN
         V6ZZC9iHRX2Jw4yuRrZr9Ex4d83MSiD1F94ypvT0Jal3NqOREg7k011ShY4JLFvmlqky
         SCbTmQ3eRzxXbzA2HvHfr7LsR5u+1vS2cZwyvXl7pLWFK8o30WipBxDBCpJLKHLdA30t
         3gW8DQ10u7N0HWefFbYB8eZivI4e7uawbfJtu9vvolUVutuKO6VFrNyKsziR/CNch+kA
         irZw==
X-Gm-Message-State: AC+VfDwIX9EbMVyXvo8C1Ab4oli4XNDDg63EZgbvvFfrtik++DKq33qF
        NuBT3Kl66/lOpvAMCiY+KsSCXhu0cMM4aJQnMLJq+WwGtpalBzBqEh9NybHZZLq+QHNefnfRyfo
        lrh0XQHYFlK1/dxdk6j/CtUgHGw==
X-Received: by 2002:a05:6214:5186:b0:62d:eceb:f7ce with SMTP id kl6-20020a056214518600b0062decebf7cemr22553575qvb.1.1687880991691;
        Tue, 27 Jun 2023 08:49:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6CRo+5Jo3T9LBKx4Xlv3zmaVI3QEZGMWrv6tzFG6sXb500w5+qcA4m6HHVWBCmVoQxsCYlOA==
X-Received: by 2002:a05:6214:5186:b0:62d:eceb:f7ce with SMTP id kl6-20020a056214518600b0062decebf7cemr22553552qvb.1.1687880991370;
        Tue, 27 Jun 2023 08:49:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g25-20020a37e219000000b0076224a4884asm4086568qki.35.2023.06.27.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:49:51 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:49:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 7/8] mm: drop VMA lock before waiting for migration
Message-ID: <ZJsFFzKG3W7UPCeo@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-8-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627042321.1763765-8-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:23:20PM -0700, Suren Baghdasaryan wrote:
> migration_entry_wait does not need VMA lock, therefore it can be
> dropped before waiting.

Hmm, I'm not sure..

Note that we're still dereferencing *vmf->pmd when waiting, while *pmd is
on the page table and IIUC only be guaranteed if the vma is still there.
If without both mmap / vma lock I don't see what makes sure the pgtable is
always there.  E.g. IIUC a race can happen where unmap() runs right after
vma_end_read() below but before pmdp_get_lockless() (inside
migration_entry_wait()), then pmdp_get_lockless() can read some random
things if the pgtable is freed.

> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/memory.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 5caaa4c66ea2..bdf46fdc58d6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3715,8 +3715,18 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	if (unlikely(non_swap_entry(entry))) {
>  		if (is_migration_entry(entry)) {
> -			migration_entry_wait(vma->vm_mm, vmf->pmd,
> -					     vmf->address);
> +			/* Save mm in case VMA lock is dropped */
> +			struct mm_struct *mm = vma->vm_mm;
> +
> +			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +				/*
> +				 * No need to hold VMA lock for migration.
> +				 * WARNING: vma can't be used after this!
> +				 */
> +				vma_end_read(vma);
> +				ret |= VM_FAULT_COMPLETED;
> +			}
> +			migration_entry_wait(mm, vmf->pmd, vmf->address);
>  		} else if (is_device_exclusive_entry(entry)) {
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			ret = remove_device_exclusive_entry(vmf);
> -- 
> 2.41.0.178.g377b9f9a00-goog
> 

-- 
Peter Xu

